package battle.view.ui
{
   import battle.BattleManager;
   import battle.view.roles.RoleViewBase;
   import com.road.yishi.proto.battle.HeroOrderMsg;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
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
   
   public class ChildCommonSkillItemListController
   {
      
      private static var emptySelectableOnOff:Boolean = true;
      
      private var view:ChildCommonSkillItemListView;
      
      private var skills:Array;
      
      private var _heroRoleInfo:HeroRoleInfo;
      
      private var _battleModel:BattleModel;
      
      private var _useSkillFailed:Boolean;
      
      private var changeSkills:Array = [];
      
      private var child:ChildData;
      
      private var PROFOUND_CD_TIME:int = 30000;
      
      public function ChildCommonSkillItemListController(param1:ChildCommonSkillItemListView)
      {
         super();
         _battleModel = BattleManager.getInstance().battleModel;
         _heroRoleInfo = _battleModel.selfChildHeroInfo;
         this.view = param1;
         init();
      }
      
      private function init() : void
      {
         addEvent();
         initChildCommonSkillList();
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("ACTION_SKILL_BattleNotic",__skillUse);
         NotificationManager.instance.addEventListener("skillCd",onSkillCdHandler);
         NotificationManager.instance.addEventListener("SKILL_ENABLE",__skillEnable);
         NotificationManager.instance.addEventListener("restrictChanged",restrictChangedHandler);
         NotificationManager.instance.addEventListener("CHILD_AWAKE_SKILL",refreshSkill);
         NotificationManager.instance.addEventListener("ABYSM_FIGHT_INFO_UPDATA",initChildCommonSkillList);
         NotificationManager.instance.addEventListener("RESET_ACTION_TIME_BattleNotic",__cleanSkillSelect);
         NotificationManager.instance.addEventListener("childnswar.battle.UseAdd",_useChildNswarAdd);
         KeyboardManager.getInstance().addEventListener("keyUp",onKeyUp);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 75,__skillUseServerBack);
         if(_heroRoleInfo)
         {
            _heroRoleInfo.addEventListener("die",__heroChildInfoDieHandler);
         }
      }
      
      private function initChildCommonSkillList(param1:NotificationEvent = null) : void
      {
         var _loc2_:Array = null;
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:SkillTempInfo = null;
         var _loc7_:int = 0;
         skills = [];
         child = ChildManager.instance.model.getChildById(_heroRoleInfo.heroInfo.headId);
         if(!child)
         {
            return;
         }
         var _loc6_:String = child.fightSkill;
         if(_loc6_)
         {
            _loc2_ = _loc6_.split(",");
         }
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            if(_loc2_ && _loc2_[_loc5_] && _loc2_[_loc5_] != "-1")
            {
               _loc3_ = child.skill.split(",");
               _loc7_ = 0;
               while(_loc7_ < _loc3_.length)
               {
                  if(_loc3_[_loc7_] && parseInt(_loc3_[_loc7_]) > 0)
                  {
                     if(TempleteManager.instance.getSkillById(_loc3_[_loc7_]).SonType == _loc2_[_loc5_])
                     {
                        _loc4_ = TempleteManager.instance.getSkillById(_loc3_[_loc7_]);
                     }
                  }
                  _loc7_++;
               }
               if(_loc4_.Priority == 3)
               {
                  _loc4_.CoolDown = PROFOUND_CD_TIME;
               }
               skills[_loc5_] = _loc4_;
            }
            else
            {
               skills[_loc5_] = null;
            }
            _loc5_++;
         }
         if(_heroRoleInfo)
         {
            changeSkills.push(TempleteManager.instance.getSkillTemplateInfoById(700003));
            changeSkills.push(TempleteManager.instance.getSkillTemplateInfoById(700004));
         }
         if(view)
         {
            view.setEnable(false);
            view.initView(skills);
            view.initCD();
         }
         view.setEnable(true);
      }
      
      private function __heroChildInfoDieHandler(param1:RoleEvent) : void
      {
         var _loc2_:HeroRoleInfo = _heroRoleInfo;
         if(!_loc2_)
         {
            return;
         }
         if(_heroRoleInfo != null && !_heroRoleInfo.isLiving)
         {
            view.setEnable(false);
         }
      }
      
      private function restrictChangedHandler(param1:NotificationEvent) : void
      {
         __skillEnable(null);
      }
      
      private function refreshSkill(param1:NotificationEvent) : void
      {
         if(!view)
         {
            return;
         }
         if(_heroRoleInfo != null && !_heroRoleInfo.isLiving)
         {
            return;
         }
         view.refreshItemState();
      }
      
      private function __cleanSkillSelect(param1:Event) : void
      {
         var _loc2_:RoleViewBase = _heroRoleInfo.view;
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
      
      private function __skillUse(param1:NotificationEvent) : void
      {
         var _loc4_:int = 0;
         var _loc6_:SkillTempInfo = null;
         var _loc7_:int = 0;
         if(_heroRoleInfo.isWaitingChangeBody)
         {
            return;
         }
         if(!_battleModel.isChildBattle)
         {
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("battle.view.ui.SkillItemListController.str");
         view.setEnable(false);
         var _loc5_:String = _battleModel.battleId;
         var _loc3_:int = _heroRoleInfo.livingId;
         if(param1.data is SkillTempInfo)
         {
            _loc6_ = param1.data as SkillTempInfo;
            _loc4_ = _loc6_.TemplateId;
            if(_heroRoleInfo)
            {
               _loc7_ = _heroRoleInfo.livingId;
               SocketSendManager.instance.gameChildCommand(_loc5_,_loc7_,_loc4_);
               _battleModel.defaultSkillCount = 0;
            }
         }
      }
      
      private function _useChildNswarAdd(param1:NotificationEvent) : void
      {
         if(!_heroRoleInfo)
         {
            return;
         }
         var _loc4_:int = param1.data;
         var _loc2_:String = _battleModel.battleId;
         var _loc3_:int = _heroRoleInfo.livingId;
         SocketSendManager.instance.childnswarSkill(_loc2_,_loc3_,_loc4_);
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
         var _loc8_:int = 0;
         var _loc15_:* = null;
         var _loc17_:String = null;
         var _loc4_:* = null;
         if(!BattleManager.getInstance().battleModel)
         {
            return;
         }
         if(!BattleManager.getInstance().battleMap)
         {
            return;
         }
         if(!_battleModel.isChildBattle)
         {
            return;
         }
         var _loc10_:PackageIn = PackageIn(param1.data);
         var _loc2_:HeroOrderMsg = new HeroOrderMsg();
         _loc2_ = _loc10_.readBody(_loc2_) as HeroOrderMsg;
         var _loc9_:Dictionary = BattleManager.getInstance().battleMap.rolesDict;
         var _loc16_:int = _heroRoleInfo.livingId;
         var _loc6_:int = _loc2_.heroIndexId;
         var _loc13_:int = _loc2_.skillId;
         var _loc11_:int = _loc2_.result;
         var _loc14_:int = _loc2_.castTime;
         var _loc7_:int = 0;
         var _loc3_:Array = [];
         var _loc12_:int = int(_loc2_.targetIndexs.length);
         _loc8_ = 0;
         while(_loc8_ < _loc12_)
         {
            _loc3_.push(_loc2_.targetIndexs[_loc8_]);
            _loc8_++;
         }
         if(_loc11_ == 1 && _loc6_ == _heroRoleInfo.livingId)
         {
            _loc17_ = LanguageMgr.GetTranslation("battle.view.ui.SkillItemListController.str2");
         }
         var _loc5_:Boolean = _loc11_ == 0;
         if(_loc11_ == 0)
         {
            skillSuccess(_loc15_,_loc13_,_loc7_,_loc6_,_loc16_,_loc4_,_loc9_,_loc14_,_loc3_);
         }
         else
         {
            skillFail(_loc6_,_loc16_,_loc4_,_loc9_,_loc3_);
         }
         if(_loc6_ == _loc16_)
         {
            NotificationManager.instance.sendNotification("USE_SKILL_RESULT",{
               "skillId":_loc13_,
               "result":_loc5_
            });
         }
      }
      
      private function skillSuccess(param1:SkillTempInfo, param2:int, param3:int, param4:int, param5:int, param6:RoleViewBase, param7:Dictionary, param8:int, param9:Array) : void
      {
         param1 = getSkillTempInfoById(param2);
         if(!param1)
         {
            return;
         }
         if(param1 && !_battleModel.isAutoFight)
         {
            param3 = param1.QTETime;
         }
         if(param4 == param5)
         {
            _battleModel.currentReadySkillId = param2;
            param6 = RoleViewBase(param7[param5]);
            if(param6.info && param6.info.isLiving)
            {
               param6.addSkillFlag(param1);
               NotificationManager.instance.sendNotification("SHOW_SKILL_USE_SUCCESS_BattleNotic",[param1,param3,param8,param9]);
            }
         }
         else
         {
            param6 = RoleViewBase(param7[param4]);
            if(param6)
            {
               if(param6.info && param6.info.isLiving)
               {
                  param1 = TempleteManager.instance.getSkillTemplateInfoById(param2);
                  param6.addSkillFlag(param1);
               }
            }
         }
      }
      
      private function skillFail(param1:int, param2:int, param3:RoleViewBase, param4:Dictionary, param5:Array) : void
      {
         var living:int;
         var roleId:int = param1;
         var selfLivingId:int = param2;
         var heroView:RoleViewBase = param3;
         var mapRoleDic:Dictionary = param4;
         var aims:Array = param5;
         var delayOpenSkillEnable:* = function():void
         {
            if(_useSkillFailed)
            {
               _useSkillFailed = false;
               if(view)
               {
                  if(_heroRoleInfo && _heroRoleInfo.isLiving)
                  {
                     view.setEnable(true);
                  }
               }
            }
         };
         _battleModel.currentReadySkillId = -1;
         if(roleId == selfLivingId)
         {
            _useSkillFailed = true;
            heroView = RoleViewBase(mapRoleDic[selfLivingId]);
            if(heroView)
            {
               heroView.removeSkillFlag();
            }
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
      
      private function onSkillCdHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data.skillId);
         var _loc3_:int = int(param1.data.waitTime);
         view.cdStart(_loc2_,_loc3_);
      }
      
      private function getSkillTempInfoById(param1:int) : SkillTempInfo
      {
         var _loc3_:* = null;
         var _loc2_:Array = skills;
         _loc2_.push.apply(null,changeSkills);
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
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.charCode == 32)
         {
            emptySelectableOnOff = !emptySelectableOnOff;
         }
      }
      
      public function dispose() : void
      {
         NotificationManager.instance.removeEventListener("ACTION_SKILL_BattleNotic",__skillUse);
         NotificationManager.instance.removeEventListener("skillCd",onSkillCdHandler);
         NotificationManager.instance.removeEventListener("SKILL_ENABLE",__skillEnable);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 75,__skillUseServerBack);
         NotificationManager.instance.removeEventListener("restrictChanged",restrictChangedHandler);
         NotificationManager.instance.removeEventListener("CHILD_AWAKE_SKILL",refreshSkill);
         NotificationManager.instance.removeEventListener("ABYSM_FIGHT_INFO_UPDATA",initChildCommonSkillList);
         NotificationManager.instance.removeEventListener("RESET_ACTION_TIME_BattleNotic",__cleanSkillSelect);
         NotificationManager.instance.removeEventListener("childnswar.battle.UseAdd",_useChildNswarAdd);
         KeyboardManager.getInstance().removeEventListener("keyUp",onKeyUp);
         if(_heroRoleInfo)
         {
            _heroRoleInfo.removeEventListener("die",__heroChildInfoDieHandler);
         }
         view = null;
         skills = null;
      }
   }
}

