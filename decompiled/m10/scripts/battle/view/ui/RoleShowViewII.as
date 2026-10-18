package battle.view.ui
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import battle.utils.Helpers;
   import battle.utils.Int64Utils;
   import battle.view.BattleView;
   import battle.view.buffer.BossBufferContainer;
   import battle.view.reinforce.ReinforceWavePane;
   import battle.view.ui.top.BossInfoView;
   import chat.view.ChatTopBugleView;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.battle.BossHpMsg;
   import com.road.yishi.proto.simple.RoomBossInfoMsg;
   import com.road.yishi.proto.simple.SyncRoomBossHPMsg;
   import com.road.yishi.proto.simple.WorldBossInfoMsg;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import mvc.module.gamehall.GameHallAutoView;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   
   public class RoleShowViewII extends Sprite implements Disposeable
   {
      
      private var _rightIsBoss:Boolean;
      
      private var _bossView:BossInfoView;
      
      private var _boss:HeroRoleInfo;
      
      public var bossBufferContainer:BossBufferContainer;
      
      private var _reinforceWavePane:ReinforceWavePane;
      
      private var _gameHallAutoPane:GameHallAutoView;
      
      private var preState:int = -1;
      
      private var _nextWaveCame:Boolean = true;
      
      public function RoleShowViewII()
      {
         super();
         init();
         addEvent();
         layout();
      }
      
      private function init() : void
      {
         _rightIsBoss = isBoss(battleModel.armyInfoRight.getHeros);
         createRightView();
         if(battleModel.reinforceWave > 0)
         {
            setReinforceWaveInfo(battleModel.reinforceWave,battleModel.currentReinforceWave + 1);
         }
      }
      
      private function createRightView() : void
      {
         if(_rightIsBoss)
         {
            _bossView = new BossInfoView();
            _bossView.setInfo(_boss);
            _bossView.setTotalHp(battleModel.armyInfoRight.getBossesTotalHp());
            _bossView.setCurrentHp(battleModel.armyInfoRight.getBossesLeftHp());
            addChild(_bossView);
            bossBufferContainer = new BossBufferContainer(battleModel.armyInfoRight.boss);
            bossBufferContainer.x = 1080;
            bossBufferContainer.y = 25;
            addChild(bossBufferContainer);
         }
      }
      
      private function showReinforceWavePane() : void
      {
         _reinforceWavePane = new ReinforceWavePane();
         _gameHallAutoPane = new GameHallAutoView();
         deployReinforceWavePane(isBoss(battleModel.armyInfoRight.getHeros));
         if(PlayerManager.instance.newbieProcess >= 19000)
         {
            addChild(_reinforceWavePane);
            addChild(_gameHallAutoPane);
         }
         var _loc1_:BattleView = BattleManager.getInstance().mainViewContainer.view;
         var _loc2_:Number = _loc1_.sceneWidth / 1500;
         reinforceLayout(_loc2_);
      }
      
      private function deployReinforceWavePane(param1:Boolean) : void
      {
         if(!_reinforceWavePane)
         {
            return;
         }
         if(battleModel.battleType == 3886)
         {
            _reinforceWavePane.top = 160;
            _reinforceWavePane.right = 30;
         }
         else if(param1)
         {
            _reinforceWavePane.top = 75;
            _reinforceWavePane.right = 120;
         }
         else
         {
            _reinforceWavePane.top = 30;
            _reinforceWavePane.right = 53;
         }
      }
      
      public function setReinforceWaveInfo(param1:int, param2:int) : void
      {
         if(!_reinforceWavePane)
         {
            showReinforceWavePane();
            _reinforceWavePane.setTotalWave(param1);
            _reinforceWavePane.setCurrentWave(param2);
         }
      }
      
      private function updateReinforceWave() : void
      {
         if(_reinforceWavePane)
         {
            _reinforceWavePane.showNextWave();
         }
      }
      
      public function bossReinforce(param1:Array) : void
      {
         var _loc3_:HeroRoleInfo = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:BattleView = null;
         var _loc6_:Number = NaN;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            if(!_loc3_)
            {
               _loc3_ = param1[_loc5_];
            }
            _loc2_ += param1[_loc5_].totalBloodA;
            if(_loc3_ && _loc3_.heroInfo.grades <= param1[_loc5_].heroInfo.grades)
            {
               _loc3_ = param1[_loc5_];
            }
            _loc5_++;
         }
         _boss = _loc3_;
         if(!_rightIsBoss)
         {
            _rightIsBoss = true;
            createRightView();
            deployReinforceWavePane(true);
            _loc4_ = BattleManager.getInstance().mainViewContainer.view;
            _loc6_ = _loc4_.sceneWidth / 1500;
            layout();
         }
         _bossView.setInfo(_boss);
         _bossView.setTotalHp(_loc2_);
         _bossView.setCurrentHp(battleModel.armyInfoRight.getBossesLeftHp());
         bossBufferContainer.removeEvent();
         bossBufferContainer.initEvent(_boss);
         bossBufferContainer.reFreshBuffer(null);
      }
      
      private function isBoss(param1:Dictionary) : Boolean
      {
         var _loc2_:* = null;
         for each(var _loc3_:HeroRoleInfo in param1)
         {
            if(_loc3_.type == 3)
            {
               if(!_boss)
               {
                  _boss = _loc3_;
               }
               if(_boss && _boss.heroInfo.grades < _loc3_.heroInfo.grades)
               {
                  _boss = _loc3_;
               }
            }
         }
         return _boss != null;
      }
      
      private function isNeedShowRightView() : Boolean
      {
         if(battleModel.battleType == 4 || battleModel.battleType == 7 || battleModel.battleType == 5 || battleModel.battleType == 10 || battleModel.battleType == 8)
         {
            return true;
         }
         return false;
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      private function addEvent() : void
      {
         addEventListener("enterFrame",__enterFrame);
         StageReferance.stage.addEventListener("resize",__stageResize);
         BattleManager.getInstance().battleModel.addEventListener("reduceWorldBossBlood",onReduceWorldBossBlood);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4174,__syncBossHpHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4462,__syncBossHpHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4435,__addBossHpHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4727,__syncBossHpHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4985,tailaHPSyncHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 360,__syncBossHpHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4889,__syncBossHpHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4285,__syncBossHpHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4297,__syncBossHpHandler);
      }
      
      protected function tailaHPSyncHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:RoomBossInfoMsg = null;
         var _loc6_:HeroRoleInfo = battleModel.armyInfoRight.boss;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:SyncRoomBossHPMsg = new SyncRoomBossHPMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as SyncRoomBossHPMsg;
         var _loc4_:Array = _loc2_.roomBossInfoList.roomBoss;
         if(_loc4_ && _loc4_.length > 0)
         {
            _loc3_ = _loc4_[0] as RoomBossInfoMsg;
         }
         if(_loc6_ != null)
         {
            if(battleModel.battleType == 3846)
            {
               _loc6_.bloodA = Int64Utils.int64ToNumber(_loc3_.curHp);
               _bossView.setCurrentHp(Math.abs(Int64Utils.int64ToNumber(_loc3_.curHp)));
            }
         }
      }
      
      protected function __addBossHpHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:BossHpMsg = new BossHpMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as BossHpMsg;
         var _loc3_:int = int(_loc2_.value);
         if(_loc2_.livingId && _boss.livingId == _loc2_.livingId)
         {
            _bossView.updateWorldBossHp(Math.abs(_loc3_));
         }
      }
      
      private function __syncBossHpHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:WorldBossInfoMsg = new WorldBossInfoMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as WorldBossInfoMsg;
         var _loc6_:Number = Number(Int64Utils.int64ToNumber(_loc2_.currentMillis));
         var _loc3_:Number = Number(Int64Utils.int64ToNumber(_loc2_.curHp));
         var _loc4_:Number = Number(Int64Utils.int64ToNumber(_loc2_.totalHp));
         var _loc5_:HeroRoleInfo = BattleManager.getInstance().battleModel.getWorldBoss();
         if(preState == 0 && _loc2_.bossState == 1)
         {
            if(_loc5_)
            {
               _loc5_.totalBlood = _loc4_;
               _loc5_.initBloodA = _loc4_;
               _loc5_.bloodA = _loc4_;
               _bossView.setTotalHp(_loc4_);
               _bossView.setCurrentHp(battleModel.armyInfoRight.getBossesLeftHp());
            }
         }
         preState = _loc2_.bossState;
         BattleManager.getInstance().battleModel.updateWorldBossBlood(_loc3_,_loc6_);
      }
      
      private function onReduceWorldBossBlood(param1:BattleEvent) : void
      {
         _bossView.updateWorldBossHp(Number(param1.data));
      }
      
      private function __stageResize(param1:Event) : void
      {
         layout();
      }
      
      private function layout() : void
      {
         resizeHeadView();
      }
      
      private function resizeHeadView() : void
      {
         var _loc2_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:BattleView = BattleManager.getInstance().mainViewContainer.view;
         var _loc6_:Number = _loc3_.sceneWidth / 1500;
         if(_rightIsBoss)
         {
            _bossView.scaleX = _bossView.scaleY = _loc6_;
            _bossView.x = _loc3_.sceneWidth - _bossView.width * _loc6_ + 25;
            bossBufferContainer.x = _loc3_.sceneWidth - 210 * _loc6_ - 40;
            if(_loc6_ < 1)
            {
               bossBufferContainer.y = 5;
            }
            else
            {
               bossBufferContainer.y = 25;
            }
            _loc2_ = 1 / _loc6_;
            if(_bossView.nameTxt)
            {
               _loc4_ = Number(_bossView.nameTxt.width);
               _loc5_ = Number(_bossView.nameTxt.textHeight);
               _bossView.nameTxt.scaleX = _bossView.nameTxt.scaleY = _loc2_;
               _bossView.nameTxt.x -= (_bossView.nameTxt.width - _loc4_) / 2;
               _bossView.nameTxt.y -= _bossView.nameTxt.textHeight - _loc5_;
            }
            if(_bossView.nameInfoTxt)
            {
               _loc4_ = Number(_bossView.nameInfoTxt.width);
               _loc5_ = Number(_bossView.nameInfoTxt.textHeight);
               _bossView.nameInfoTxt.scaleX = _bossView.nameInfoTxt.scaleY = _loc2_;
               _bossView.nameInfoTxt.x -= (_bossView.nameInfoTxt.width - _loc4_) / 2;
               _bossView.nameInfoTxt.y -= _bossView.nameInfoTxt.textHeight - _loc5_;
            }
         }
         if(_reinforceWavePane)
         {
            reinforceLayout(_loc6_);
         }
         var _loc1_:Point = localToGlobal(new Point(x,y));
         ChatTopBugleView.instance.setPos((_loc1_.x + 170) * _loc6_,(_loc1_.y + 90) * _loc6_,true);
      }
      
      private function reinforceLayout(param1:Number) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BattleView = BattleManager.getInstance().mainViewContainer.view;
         if(battleModel.battleType == 3886)
         {
            _loc3_ = battleModel.reinforceWave - battleModel.currentReinforceWave - 1;
            _reinforceWavePane.x = _bossView.x - _loc3_ * 98 * param1 + 430 * param1;
            _reinforceWavePane.y = 40;
            _gameHallAutoPane.x = _reinforceWavePane.x + (_reinforceWavePane.displayWidth - _gameHallAutoPane.displayWidth) / 2;
            _gameHallAutoPane.y = 135;
         }
         else if(_rightIsBoss)
         {
            _reinforceWavePane.x = _loc2_.sceneWidth - _reinforceWavePane.right * param1 - 200;
            _reinforceWavePane.y = _reinforceWavePane.top * param1 + 40;
         }
         else
         {
            _reinforceWavePane.x = _loc2_.sceneWidth - _reinforceWavePane.right * param1;
            _reinforceWavePane.y = _reinforceWavePane.top * param1 + 40;
         }
      }
      
      public function get livingId() : int
      {
         if(_boss)
         {
            return _boss.livingId;
         }
         return 0;
      }
      
      private function __enterFrame(param1:Event) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = Number(battleModel.armyInfoRight.getLeftHp());
         if(_rightIsBoss)
         {
            _loc3_ = Number(battleModel.armyInfoRight.getBossesLeftHp());
            _bossView.setCurrentHp(_loc3_);
         }
         if(_loc2_ <= 0)
         {
            BattleManager.getInstance().battleModel.isOver = true;
            NotificationManager.instance.sendNotification("FORCE_SKILL_ENABLE",false);
         }
         if(_loc2_ > 0)
         {
            _nextWaveCame = true;
         }
         if(_loc2_ <= 0 && _reinforceWavePane)
         {
            if(_nextWaveCame)
            {
               updateReinforceWave();
               _nextWaveCame = false;
            }
         }
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__stageResize);
         removeEventListener("enterFrame",__enterFrame);
         BattleManager.getInstance().battleModel.removeEventListener("reduceWorldBossBlood",onReduceWorldBossBlood);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4174,__syncBossHpHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4462,__syncBossHpHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4435,__addBossHpHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4727,__syncBossHpHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4985,tailaHPSyncHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 360,__syncBossHpHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4889,__syncBossHpHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4285,__syncBossHpHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4297,__syncBossHpHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_gameHallAutoPane);
         _gameHallAutoPane = null;
         if(_reinforceWavePane)
         {
            ObjectUtils.disposeObject(_reinforceWavePane);
         }
         _reinforceWavePane = null;
         if(_bossView)
         {
            ObjectUtils.disposeObject(_bossView);
         }
         _bossView = null;
         if(bossBufferContainer)
         {
            bossBufferContainer.dispose();
         }
         bossBufferContainer = null;
         Helpers.removeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _boss = null;
      }
   }
}

