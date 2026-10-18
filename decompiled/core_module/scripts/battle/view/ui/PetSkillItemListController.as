package battle.view.ui
{
   import battle.BattleManager;
   import battle.view.roles.RoleViewBase;
   import com.road.yishi.proto.battle.HeroOrderMsg;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.utils.Dictionary;
   import managers.RemotePetManager;
   import org.aswing.KeyboardManager;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.TimerUtils;
   
   public class PetSkillItemListController
   {
      
      private static var emptySelectableOnOff:Boolean = true;
      
      private var view:PetSkillItemListView;
      
      private var skills:Array;
      
      private var _battleModel:BattleModel;
      
      private var skillSelectingTargets:Array;
      
      private var skillType:int;
      
      private var _selected:Boolean;
      
      private var _useSkillFailed:Boolean;
      
      private var awakenSkills:Array = [];
      
      public function PetSkillItemListController(param1:PetSkillItemListView)
      {
         super();
         _battleModel = BattleManager.getInstance().battleModel;
         this.view = param1;
         init();
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = null;
         skills = [];
         var _loc3_:SkillTempInfo = null;
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc3_ = null;
            _loc1_ = RemotePetManager.instance.model.remotePetSkill;
            if(_loc2_ < _loc1_.length)
            {
               _loc3_ = TempleteManager.instance.getSkillTemplateInfoById(_loc1_[_loc2_]);
            }
            skills.push(_loc3_);
            _loc2_++;
         }
         if(view)
         {
            view.initView(skills);
            view.initCD();
         }
         NotificationManager.instance.addEventListener("REMOTEPET_SKILL",__skillUse);
         NotificationManager.instance.addEventListener("skillCd",onSkillCdHandler);
         NotificationManager.instance.addEventListener("SKILL_ENABLE",__skillEnable);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 75,__skillUseServerBack);
         NotificationManager.instance.addEventListener("RESET_ACTION_TIME_BattleNotic",__cleanSkillSelect);
         KeyboardManager.getInstance().addEventListener("keyUp",onKeyUp);
      }
      
      private function onSkillCdHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data.skillId);
         var _loc3_:int = int(param1.data.waitTime);
         view.cdStart(_loc2_,_loc3_);
      }
      
      private function __clearCD(param1:int) : void
      {
         var _loc2_:int = param1;
         view.clearCDButNotId(_loc2_);
         view.cdStart(_loc2_,0);
         view.setEnable(true);
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.charCode == 32)
         {
            emptySelectableOnOff = !emptySelectableOnOff;
         }
      }
      
      private function get isWatchOnly() : Boolean
      {
         if(BattleManager.getInstance().battleModel.battleType == 35)
         {
            return true;
         }
         if(BattleManager.getInstance().battleModel.battleType == 307)
         {
            return true;
         }
         return false;
      }
      
      private function __skillEnable(param1:NotificationEvent) : void
      {
         if(param1)
         {
            view.setEnable(param1.data);
            if(!param1.data)
            {
               _useSkillFailed = false;
            }
         }
         else
         {
            view.setEnable(true);
         }
      }
      
      private function restrictChangedHandler(param1:NotificationEvent) : void
      {
         __skillEnable(null);
      }
      
      private function __skillUse(param1:NotificationEvent) : void
      {
         var _loc2_:int = 0;
         var _loc4_:SkillTempInfo = null;
         view.setEnable(false);
         var _loc3_:String = _battleModel.battleId;
         if(param1.data is SkillTempInfo)
         {
            _loc4_ = param1.data as SkillTempInfo;
            _loc2_ = _loc4_.TemplateId;
            SocketSendManager.instance.sendUsePetBattleSkill(_loc3_,_loc2_);
            _battleModel.currentReadySkillId = _loc2_;
         }
         _battleModel.defaultSkillCount = 0;
      }
      
      private function addSkillUsedFlag(param1:SkillTempInfo) : void
      {
         var _loc2_:RoleViewBase = BattleManager.getInstance().getSelfRoleView();
         if(_loc2_ && _loc2_.info && _loc2_.info.isLiving)
         {
            _loc2_.addSkillFlag(param1);
         }
      }
      
      private function __skillUseServerBack(param1:SLGSocketEvent) : void
      {
         var pkg:PackageIn;
         var msg:HeroOrderMsg;
         var mapRoleDic:Dictionary;
         var roleId:int;
         var skillId:int;
         var result:int;
         var castTime:int;
         var qteTime:int;
         var aims:Array;
         var aimLen:int;
         var i:int;
         var skillInfo:SkillTempInfo;
         var heroView:RoleViewBase;
         var flag:Boolean;
         var living:int;
         var delayOpenSkillEnable:*;
         var event:SLGSocketEvent = param1;
         if(BattleManager.getInstance().battleModel.battleType != 3844)
         {
            return;
         }
         pkg = PackageIn(event.data);
         msg = new HeroOrderMsg();
         msg = pkg.readBody(msg) as HeroOrderMsg;
         mapRoleDic = BattleManager.getInstance().battleMap.rolesDict;
         roleId = msg.heroIndexId;
         skillId = msg.skillId;
         result = msg.result;
         castTime = msg.castTime;
         qteTime = 0;
         aims = [];
         aimLen = int(msg.targetIndexs.length);
         i = 0;
         while(i < aimLen)
         {
            aims.push(msg.targetIndexs[i]);
            i = i + 1;
         }
         flag = true;
         if(result == 0)
         {
            flag = true;
            skillInfo = getSkillTempInfoById(skillId);
            heroView = RoleViewBase(mapRoleDic[roleId]);
            if(heroView)
            {
               if(heroView.info && heroView.info.isLiving)
               {
                  skillInfo = TempleteManager.instance.getSkillTemplateInfoById(skillId);
                  heroView.addSkillFlag(skillInfo);
                  if(skillInfo.SonType == 20010)
                  {
                     __clearCD(skillId);
                  }
               }
            }
         }
         else
         {
            delayOpenSkillEnable = function():void
            {
               if(_useSkillFailed)
               {
                  _useSkillFailed = false;
                  if(view)
                  {
                     view.setEnable(true);
                  }
               }
            };
            flag = false;
            _battleModel.currentReadySkillId = -1;
            _useSkillFailed = true;
            for each(living in aims)
            {
               heroView = mapRoleDic[living] as RoleViewBase;
               if(heroView)
               {
                  heroView.removeSkillAimFlag();
               }
            }
            TimerUtils.setTimeout(delayOpenSkillEnable,1000);
         }
      }
      
      private function getSkillTempInfoById(param1:int) : SkillTempInfo
      {
         var _loc3_:* = null;
         var _loc2_:Array = skills;
         for each(var _loc4_:Object in _loc2_)
         {
            if(_loc4_)
            {
               if(_loc4_ is SkillTempInfo)
               {
                  if(_loc4_.TemplateId == param1 || _battleModel.isAutoFight && _loc4_.Parameter3 == param1)
                  {
                     return _loc4_ as SkillTempInfo;
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function __cleanSkillSelect(param1:Event) : void
      {
         var _loc2_:RoleViewBase = _battleModel.selfHero.view;
         if(_loc2_)
         {
            _loc2_.removeCollectionEffect();
            _loc2_.removeSkillFlag();
         }
         for each(var _loc3_:RoleViewBase in BattleManager.getInstance().battleMap.rolesDict)
         {
            _loc3_.removeSkillAimFlag();
         }
      }
      
      public function dispose() : void
      {
         NotificationManager.instance.removeEventListener("REMOTEPET_SKILL",__skillUse);
         NotificationManager.instance.removeEventListener("skillCd",onSkillCdHandler);
         NotificationManager.instance.removeEventListener("SKILL_ENABLE",__skillEnable);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 75,__skillUseServerBack);
         NotificationManager.instance.removeEventListener("RESET_ACTION_TIME_BattleNotic",__cleanSkillSelect);
         KeyboardManager.getInstance().removeEventListener("keyUp",onKeyUp);
         view = null;
         skills = null;
      }
   }
}

