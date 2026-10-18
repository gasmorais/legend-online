package battle.view.ui
{
   import battle.BattleManager;
   import battle.view.roles.RoleViewBase;
   import com.road.yishi.proto.battle.HeroOrderMsg;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.utils.Dictionary;
   import managers.PetSacristyManager;
   import org.aswing.KeyboardManager;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.RoleEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.TimerUtils;
   
   public class PetSacristyItemListController
   {
      
      private static var emptySelectableOnOff:Boolean = true;
      
      private var view:PetSacristyItemListView;
      
      private var skills:Array;
      
      private var _battleModel:BattleModel;
      
      private var _useSkillFailed:Boolean;
      
      private var _petHeroInfo:HeroRoleInfo;
      
      public var awaken:int;
      
      public var childSkillDark:Boolean = false;
      
      public function PetSacristyItemListController(param1:PetSacristyItemListView)
      {
         super();
         _battleModel = BattleManager.getInstance().battleModel;
         _petHeroInfo = _battleModel.selfHero;
         this.view = param1;
         init();
      }
      
      private function init() : void
      {
         var _loc3_:int = 0;
         skills = [];
         var _loc2_:Array = PetSacristyManager.instance.petSkillMsg.skillId;
         var _loc4_:SkillTempInfo = null;
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc4_ = null;
            if(_loc3_ < _loc2_.length)
            {
               _loc4_ = TempleteManager.instance.getSkillTemplateInfoById(_loc2_[_loc3_]);
            }
            skills.push(_loc4_);
            _loc3_++;
         }
         var _loc1_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(PetSacristyManager.instance.petSkillMsg.relicSkillId);
         if(view)
         {
            view.initView(skills,_loc1_);
            view.initCD();
         }
         NotificationManager.instance.addEventListener("restrictChanged",restrictChangedHandler);
         NotificationManager.instance.addEventListener("SACRISTY_SKILL",__skillUse);
         NotificationManager.instance.addEventListener("skillCd",onSkillCdHandler);
         NotificationManager.instance.addEventListener("SKILL_ENABLE",__skillEnable);
         NotificationManager.instance.addEventListener("UPDATE_PET_POWER",__updatePetPower);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 75,__skillUseServerBack);
         NotificationManager.instance.addEventListener("BUFFER_SKILL_ENABLE",__bufferEnabeleHandler);
         NotificationManager.instance.addEventListener("RESET_ACTION_TIME_BattleNotic",__cleanSkillSelect);
         KeyboardManager.getInstance().addEventListener("keyUp",onKeyUp);
         if(_petHeroInfo)
         {
            _petHeroInfo.addEventListener("die",__heroChildInfoDieHandler);
         }
         __updatePetPower(null);
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
      
      private function __skillEnable(param1:NotificationEvent) : void
      {
         var _loc3_:Boolean = _battleModel.isOver;
         var _loc2_:Boolean = _petHeroInfo.restricted;
         var _loc4_:* = BattleManager.getInstance().getSelfRoleView();
         if(_loc3_ || _loc2_)
         {
            if(_loc4_)
            {
               _loc4_.cancelReadyState();
            }
            view.setEnable(false);
            _useSkillFailed = false;
         }
         else if(param1)
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
         var _loc3_:int = 0;
         var _loc5_:SkillTempInfo = null;
         var _loc2_:int = 0;
         if(!view)
         {
            return;
         }
         view.setEnable(false);
         var _loc4_:String = _battleModel.battleId;
         if(param1.data is SkillTempInfo)
         {
            _loc5_ = param1.data as SkillTempInfo;
            _loc3_ = _loc5_.TemplateId;
            _loc2_ = _battleModel.selfHero.livingId;
            SocketSendManager.instance.sendUsePetSacristySkill(_loc4_,_loc2_,_loc3_);
            _battleModel.currentReadySkillId = _loc3_;
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
         var skillInfo:SkillTempInfo;
         var heroView:RoleViewBase;
         var flag:Boolean;
         var living:int;
         var delayOpenSkillEnable:*;
         var event:SLGSocketEvent = param1;
         var pkg:PackageIn = PackageIn(event.data);
         var msg:HeroOrderMsg = new HeroOrderMsg();
         msg = pkg.readBody(msg) as HeroOrderMsg;
         var mapRoleDic:Dictionary = BattleManager.getInstance().battleMap.rolesDict;
         var roleId:int = msg.heroIndexId;
         var skillId:int = msg.skillId;
         var result:int = msg.result;
         var castTime:int = msg.castTime;
         var qteTime:int = 0;
         var aims:Array = [];
         var aimLen:int = int(msg.targetIndexs.length);
         var i:int = 0;
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
         var _loc2_:RoleViewBase = _petHeroInfo.view;
         if(_loc2_)
         {
            _loc2_.removeSkillFlag();
         }
         for each(var _loc3_:RoleViewBase in BattleManager.getInstance().battleMap.rolesDict)
         {
            _loc3_.removeSkillAimFlag();
         }
      }
      
      private function __heroChildInfoDieHandler(param1:RoleEvent) : void
      {
         var _loc2_:HeroRoleInfo = _petHeroInfo;
         if(!_loc2_)
         {
            return;
         }
         if(_petHeroInfo != null && !_petHeroInfo.isLiving)
         {
            view.setEnable(false);
            view.childSkillItem2.buttonSkiner.enable = false;
            view.childSkillItem2.setState(1);
         }
      }
      
      private function __updatePetPower(param1:NotificationEvent) : void
      {
         var _loc2_:int = PetSacristyManager.instance.awake;
         updateChildSkillItem(_loc2_);
      }
      
      public function updateChildSkillItem(param1:int) : void
      {
         awaken = param1;
         if(childSkillDark && awaken >= 100)
         {
            view.childSkillItem2.buttonSkiner.enable = true;
            view.childSkillItem2.setState(0);
         }
         else
         {
            view.childSkillItem2.buttonSkiner.enable = false;
            view.childSkillItem2.setState(1);
         }
      }
      
      private function __bufferEnabeleHandler(param1:NotificationEvent) : void
      {
         if(!view)
         {
            return;
         }
         for each(var _loc2_:BattleSkillItemII in view.skillItemViews)
         {
            bufferEnabeleItemHandler(_loc2_);
         }
      }
      
      private function bufferEnabeleItemHandler(param1:BattleSkillItemII) : void
      {
         var _loc7_:SkillTempInfo = null;
         var _loc3_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         if(param1.isLock)
         {
            return;
         }
         var _loc5_:Object = param1.data;
         var _loc4_:HeroRoleInfo = _petHeroInfo;
         if(_loc5_ is SkillTempInfo)
         {
            _loc7_ = _loc5_ as SkillTempInfo;
            param1.bufferUnEnable = _loc4_.existUnenableSkillBuffer(_loc7_.TemplateId);
            if(param1.bufferUnEnable)
            {
               param1.buttonSkiner.enable = false;
               param1.setState(1);
               param1.addChild(param1.banImg);
            }
            else
            {
               _loc3_ = _loc4_.sp + _loc7_.Cost >= 0 && _loc4_.hitPoint + _loc7_.HitPointCost >= 0;
               _loc6_ = _battleModel.currentReadySkillId != -1;
               _loc2_ = _battleModel.battleType == 25;
               _loc8_ = _loc4_.bloodA <= 0;
               _loc9_ = param1 == view.childSkillItem2;
               if(param1.banImg.parent)
               {
                  param1.removeChild(param1.banImg);
               }
               if(_loc8_ || _loc6_ || !_loc3_ || _loc2_ || _loc9_)
               {
                  return;
               }
               param1.buttonSkiner.enable = true;
               param1.setState(0);
            }
         }
      }
      
      public function dispose() : void
      {
         NotificationManager.instance.removeEventListener("restrictChanged",restrictChangedHandler);
         NotificationManager.instance.removeEventListener("REMOTEPET_SKILL",__skillUse);
         NotificationManager.instance.removeEventListener("skillCd",onSkillCdHandler);
         NotificationManager.instance.removeEventListener("SKILL_ENABLE",__skillEnable);
         NotificationManager.instance.removeEventListener("UPDATE_PET_POWER",__updatePetPower);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 75,__skillUseServerBack);
         NotificationManager.instance.removeEventListener("RESET_ACTION_TIME_BattleNotic",__cleanSkillSelect);
         KeyboardManager.getInstance().removeEventListener("keyUp",onKeyUp);
         if(_petHeroInfo)
         {
            _petHeroInfo.removeEventListener("die",__heroChildInfoDieHandler);
         }
         view = null;
         skills = null;
         _battleModel = null;
      }
   }
}

