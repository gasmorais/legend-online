package battle.view.ui
{
   import battle.BattleManager;
   import com.road.yishi.proto.battle.HeroOrderMsg;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import org.aswing.KeyboardManager;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.datas.battle.BattleCooldownModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.RoleEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.TimerUtils;
   
   public class AvengerSkillItemListController
   {
      
      private static var emptySelectableOnOff:Boolean = true;
      
      private var view:AvengerBattleSkillView;
      
      private var _heroRoleInfo:HeroRoleInfo;
      
      private var _battleModel:BattleModel;
      
      private var _useSkillFailed:Boolean;
      
      public function AvengerSkillItemListController(param1:AvengerBattleSkillView)
      {
         super();
         _battleModel = BattleManager.getInstance().battleModel;
         _heroRoleInfo = _battleModel.selfHero;
         this.view = param1;
         initSkillCd();
         param1.setEnable(true);
         addEvent();
      }
      
      public function initSkillCd() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Array = battleModel.cooldownInfo;
         if(_loc1_)
         {
            for each(var _loc2_:BattleCooldownModel in _loc1_)
            {
               _loc3_ = Math.max(_loc2_.cooldown,_loc2_.appearCoolDown);
               if(_loc3_ > 0)
               {
                  _loc2_.stop();
                  cdStart(_loc2_.templateId,0,_loc3_ * 1000);
               }
            }
         }
      }
      
      public function cdStart(param1:int, param2:int = 0, param3:int = -1, param4:int = 0) : void
      {
         var _loc5_:BattleSkillItemII = getItemViewBySkillId(param1);
         if(_loc5_)
         {
            _loc5_.cdStart(param2,param3);
         }
      }
      
      private function getItemViewBySkillId(param1:int) : BattleSkillItemII
      {
         var _loc3_:int = 0;
         if(!view)
         {
            return null;
         }
         for each(var _loc2_:BattleSkillItemII in view.fightList)
         {
            if(_loc2_.data)
            {
               _loc3_ = (_loc2_.data as SkillTempInfo).TemplateId;
               if(_loc3_ == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("ACTION_SKILL_BattleNotic",__skillUse);
         NotificationManager.instance.addEventListener("SKILL_ENABLE",__skillEnable);
         NotificationManager.instance.addEventListener("restrictChanged",restrictChangedHandler);
         NotificationManager.instance.addEventListener("AVENGER_SKILL_REPLACE",__avengerskillReplace);
         KeyboardManager.getInstance().addEventListener("keyUp",onKeyUp);
         NotificationManager.instance.addEventListener("skillCd",onSkillCdHandler);
         NotificationManager.instance.addEventListener("BUFFER_SKILL_ENABLE",__bufferEnabeleHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 75,__skillUseServerBack);
         if(_heroRoleInfo)
         {
            _heroRoleInfo.addEventListener("die",__heroChildInfoDieHandler);
            _heroRoleInfo.addEventListener("AVENGER_SP",__avengerSpChangeHandler);
            _heroRoleInfo.addEventListener("AVENGER_SKILL_CHANGE",__avengerSkillChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("ACTION_SKILL_BattleNotic",__skillUse);
         NotificationManager.instance.removeEventListener("SKILL_ENABLE",__skillEnable);
         NotificationManager.instance.removeEventListener("restrictChanged",restrictChangedHandler);
         NotificationManager.instance.removeEventListener("AVENGER_SKILL_REPLACE",__avengerskillReplace);
         KeyboardManager.getInstance().removeEventListener("keyUp",onKeyUp);
         NotificationManager.instance.removeEventListener("skillCd",onSkillCdHandler);
         NotificationManager.instance.removeEventListener("BUFFER_SKILL_ENABLE",__bufferEnabeleHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 75,__skillUseServerBack);
         if(_heroRoleInfo)
         {
            _heroRoleInfo.removeEventListener("die",__heroChildInfoDieHandler);
            _heroRoleInfo.removeEventListener("AVENGER_SP",__avengerSpChangeHandler);
            _heroRoleInfo.removeEventListener("AVENGER_SKILL_CHANGE",__avengerSkillChangeHandler);
         }
      }
      
      private function __skillUse(param1:NotificationEvent) : void
      {
         if(_heroRoleInfo.isWaitingChangeBody)
         {
            return;
         }
         if(_battleModel.battleType == 3844)
         {
            return;
         }
         if(_battleModel.battleType == 3845)
         {
            return;
         }
         if(_battleModel.battleType == 3847)
         {
            return;
         }
         if(_battleModel.battleType == 16)
         {
            return;
         }
         if(_battleModel.battleType == 3868)
         {
            return;
         }
         if(_battleModel.isChildBattle)
         {
            return;
         }
         view.setEnable(false);
      }
      
      private function onSkillCdHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data.skillId);
         var _loc3_:int = int(param1.data.waitTime);
         cdStart(_loc2_,_loc3_);
      }
      
      private function __skillUseServerBack(param1:SLGSocketEvent) : void
      {
         var pkg:PackageIn;
         var msg:HeroOrderMsg;
         var flag:Boolean;
         var delayOpenSkillEnable:*;
         var event:SLGSocketEvent = param1;
         if(BattleManager.getInstance().battleModel.battleType == 3844)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.battleType == 3845)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.battleType == 3847)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.battleType == 3867)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.battleType == 3868)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.battleType == 3866)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.battleType == 3864)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.battleType == 3889)
         {
            return;
         }
         pkg = PackageIn(event.data);
         msg = new HeroOrderMsg();
         msg = pkg.readBody(msg) as HeroOrderMsg;
         flag = true;
         if(msg.result != 0)
         {
            delayOpenSkillEnable = function():void
            {
               if(_useSkillFailed)
               {
                  _useSkillFailed = false;
                  if(view && _heroRoleInfo && _heroRoleInfo.isLiving)
                  {
                     view.setEnable(true);
                  }
               }
            };
            flag = false;
            _useSkillFailed = true;
            TimerUtils.setTimeout(delayOpenSkillEnable,1000);
         }
      }
      
      private function __avengerskillReplace(param1:NotificationEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:SkillTempInfo = null;
         if(_heroRoleInfo.isWaitingChangeBody)
         {
            return;
         }
         if(_battleModel.battleType == 3844)
         {
            return;
         }
         if(_battleModel.battleType == 3845)
         {
            return;
         }
         if(_battleModel.battleType == 3847)
         {
            return;
         }
         if(_battleModel.battleType == 16)
         {
            return;
         }
         if(_battleModel.battleType == 3868)
         {
            return;
         }
         if(_battleModel.isChildBattle)
         {
            return;
         }
         var _loc4_:String = _battleModel.battleId;
         var _loc2_:int = _heroRoleInfo.livingId;
         if(param1.data is SkillTempInfo)
         {
            _loc5_ = param1.data as SkillTempInfo;
            _loc3_ = _loc5_.TemplateId;
         }
         SocketSendManager.instance.sendBattleAvengerChange(_loc4_,_loc3_,_loc2_);
      }
      
      private function __bufferEnabeleHandler(param1:NotificationEvent) : void
      {
         if(!view)
         {
            return;
         }
         for each(var _loc2_:BattleSkillItemII in view.fightList)
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
         if(param1.isLock)
         {
            return;
         }
         var _loc5_:Object = param1.data;
         var _loc4_:HeroRoleInfo = _heroRoleInfo;
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
               _loc3_ = _loc4_.avengerSp >= _loc7_.Cost;
               _loc6_ = _battleModel.currentReadySkillId != -1;
               _loc2_ = _battleModel.battleType == 25;
               _loc8_ = _loc4_.bloodA <= 0;
               if(param1.banImg.parent)
               {
                  param1.removeChild(param1.banImg);
               }
               if(_loc8_ || _loc6_ || !_loc3_ || _loc2_)
               {
                  return;
               }
               param1.buttonSkiner.enable = true;
               param1.setState(0);
            }
         }
      }
      
      private function __heroChildInfoDieHandler(param1:RoleEvent) : void
      {
         if(!_heroRoleInfo)
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
      
      private function __avengerSpChangeHandler(param1:Event) : void
      {
         view.updateAvengerSp(_heroRoleInfo.avengerSp);
      }
      
      private function __avengerSkillChangeHandler(param1:Event) : void
      {
         view.updateAvengerSkills();
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      public function dispose() : void
      {
         removeEvent();
         view = null;
      }
   }
}

