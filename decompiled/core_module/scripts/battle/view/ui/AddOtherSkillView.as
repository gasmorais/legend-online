package battle.view.ui
{
   import battle.BattleManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.battle.HeroOrderMsg;
   import dialog.utils.NewbieSocketOutManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.RoleEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.TimerUtils;
   
   public class AddOtherSkillView extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private var _battleModel:BattleModel;
      
      private var _heroRoleInfo:HeroRoleInfo;
      
      private var _enable:Boolean = false;
      
      private var _useSkillFailed:Boolean;
      
      private var _itemList:Array = [];
      
      private var _hbox:HBox;
      
      public function AddOtherSkillView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:AddOtherSkillItem = null;
         var _loc5_:int = 0;
         var _loc4_:SkillTempInfo = null;
         var _loc3_:int = 0;
         _battleModel = BattleManager.getInstance().battleModel;
         _heroRoleInfo = _battleModel.selfHero;
         _bg = ComponentFactory.Instance.creatBitmap("asset.battle.comAddSkbg");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("battle.addSkHBox");
         addChild(_bg);
         addChild(_hbox);
         _hbox.beginChanges();
         var _loc2_:Array = _heroRoleInfo.thessBoxSkills;
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc1_ = new AddOtherSkillItem();
            _loc1_.parentEnable = true;
            _loc1_.width = 34;
            _loc1_.height = 34;
            _loc5_ = int(_loc2_[_loc3_]);
            if(_loc5_ > 0)
            {
               _loc4_ = TempleteManager.instance.getSkillById(_loc5_);
               if(_loc4_)
               {
                  _loc1_.data = _loc4_;
               }
               else
               {
                  _loc1_.data = null;
               }
            }
            else
            {
               _loc1_.data = null;
            }
            _itemList[_loc3_] = _loc1_;
            _hbox.addChild(_loc1_);
            _loc3_++;
         }
         _hbox.commitChanges();
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("AddOther.skillUse",__skillUse);
         NotificationManager.instance.addEventListener("restrictChanged",restrictChangedHandler);
         NotificationManager.instance.addEventListener("BUFFER_SKILL_ENABLE",__bufferEnabeleHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 75,__skillUseServerBack);
         if(_heroRoleInfo)
         {
            _heroRoleInfo.addEventListener("die",__heroChildInfoDieHandler);
         }
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("AddOther.skillUse",__skillUse);
         NotificationManager.instance.removeEventListener("restrictChanged",restrictChangedHandler);
         NotificationManager.instance.removeEventListener("BUFFER_SKILL_ENABLE",__bufferEnabeleHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 75,__skillUseServerBack);
         if(_heroRoleInfo)
         {
            _heroRoleInfo.removeEventListener("die",__heroChildInfoDieHandler);
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
            setEnable(false);
         }
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
                  if(_heroRoleInfo && _heroRoleInfo.isLiving)
                  {
                     setEnable(true);
                  }
               }
            };
            flag = false;
            _useSkillFailed = true;
            TimerUtils.setTimeout(delayOpenSkillEnable,1000);
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
            setEnable(param1.data);
            if(!param1.data)
            {
               _useSkillFailed = false;
            }
         }
         else
         {
            setEnable(true);
         }
      }
      
      private function __bufferEnabeleHandler(param1:NotificationEvent) : void
      {
         for each(var _loc2_:AddOtherSkillItem in _itemList)
         {
            bufferEnabeleItemHandler(_loc2_);
         }
      }
      
      private function bufferEnabeleItemHandler(param1:AddOtherSkillItem) : void
      {
         var _loc6_:SkillTempInfo = null;
         var _loc2_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc7_:Boolean = false;
         if(param1.isLock)
         {
            return;
         }
         var _loc4_:Object = param1.data;
         var _loc3_:HeroRoleInfo = _heroRoleInfo;
         if(_loc4_ is SkillTempInfo)
         {
            _loc6_ = _loc4_ as SkillTempInfo;
            param1.bufferUnEnable = _loc3_.existUnenableSkillBuffer(_loc6_.TemplateId);
            if(param1.bufferUnEnable)
            {
               param1.buttonSkiner.enable = false;
               param1.setState(1);
               param1.addChild(param1.banImg);
            }
            else
            {
               _loc2_ = _loc3_.warsoulSp >= _loc6_.Cost;
               _loc5_ = _battleModel.currentReadySkillId != -1;
               _loc7_ = _loc3_.bloodA <= 0;
               if(param1.banImg.parent)
               {
                  param1.removeChild(param1.banImg);
               }
               if(_loc7_ || _loc5_ || !_loc2_)
               {
                  return;
               }
               param1.buttonSkiner.enable = true;
               param1.setState(0);
            }
         }
      }
      
      private function __skillUse(param1:NotificationEvent) : void
      {
         var skillInfo:SkillTempInfo;
         var currentskillId:int;
         var battleId:String;
         var livingID:int;
         var timeId:int;
         var event:NotificationEvent = param1;
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
         setEnable(false);
         skillInfo = event.data as SkillTempInfo;
         if(!skillInfo)
         {
            return;
         }
         currentskillId = skillInfo.TemplateId;
         battleId = _battleModel.battleId;
         livingID = _heroRoleInfo.livingId;
         if(PlayerManager.instance.newbieProcess < 19000)
         {
            NewbieSocketOutManager.sendBattleContinue();
            timeId = int(setTimeout(function():void
            {
               clearTimeout(timeId);
               SocketSendManager.instance.gameCommand(battleId,livingID,currentskillId);
            },400));
         }
         else
         {
            SocketSendManager.instance.gameCommand(battleId,livingID,currentskillId);
         }
      }
      
      private function setEnable(param1:Boolean) : void
      {
         var _loc3_:SkillTempInfo = null;
         var _loc2_:Boolean = false;
         if(param1 == _enable)
         {
            return;
         }
         _enable = param1;
         for each(var _loc4_:AddOtherSkillItem in _itemList)
         {
            if(!_loc4_.isLock)
            {
               if(!_enable)
               {
                  _loc4_.setDownEffect();
               }
               _loc3_ = _loc4_.data as SkillTempInfo;
               if(_loc3_)
               {
                  _loc2_ = _heroRoleInfo.warsoulSp >= _loc3_.Cost;
                  if(_enable)
                  {
                     _enable = _loc2_;
                  }
                  _loc4_.parentEnable = _enable;
                  _loc4_.buttonSkiner.enable = _enable;
               }
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:AddOtherSkillItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _heroRoleInfo = null;
         _battleModel = null;
      }
   }
}

