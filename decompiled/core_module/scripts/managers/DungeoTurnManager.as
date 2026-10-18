package managers
{
   import com.road.yishi.proto.dungeonturn.DungeonTurnOpMsg;
   import map.campaign.CampaignManager;
   import mvc.module.DungeoTurnModel;
   import yishi.actions.base.AlertTipAction;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.DelayActionsUtils;
   
   public class DungeoTurnManager
   {
      
      private static var _instance:DungeoTurnManager;
      
      private var _model:DungeoTurnModel;
      
      public function DungeoTurnManager()
      {
         super();
      }
      
      public static function get instance() : DungeoTurnManager
      {
         if(!_instance)
         {
            _instance = new DungeoTurnManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new DungeoTurnModel();
         }
         addEvent();
      }
      
      public function get model() : DungeoTurnModel
      {
         return _model;
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4874,_dungeoTurnopHandler);
      }
      
      private function _dungeoTurnopHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:DungeonTurnOpMsg = new DungeonTurnOpMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as DungeonTurnOpMsg;
         var _loc3_:int = _loc2_.op;
         switch(_loc3_ - 3)
         {
            case 0:
               _model.hasGeted = _loc2_.hasGetReward;
               _model.hasReward = _loc2_.hasReward;
               NotificationManager.instance.dispatchEvent(new NotificationEvent("DUNGEO_GET_REWARD"));
               break;
            case 1:
               _model.rewardInfo = _loc2_.reward;
               _model.hasGeted = _loc2_.hasGetReward;
               _model.hasReward = _loc2_.hasReward;
               model.calcReward();
               if(_loc2_.reward == "")
               {
                  PlayerManager.instance.currentPlayerModel.playerInfo.dungeoHasReward = false;
               }
               else
               {
                  PlayerManager.instance.currentPlayerModel.playerInfo.dungeoHasReward = true;
               }
         }
      }
      
      public function showRewardFrame(param1:Object = null) : void
      {
         CheckUIModuleUtil.instance.tryCall("dungeonturn",callRewardFrame);
      }
      
      private function callRewardFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("dungeonturn",3);
      }
      
      private function callFun() : void
      {
         FrameControllerManager.instance.openControllerByInfo("dungeonturn",1);
      }
      
      public function dungeoTurnop(param1:DungeonTurnOpMsg) : void
      {
         var _loc2_:int = param1.op;
         switch(_loc2_)
         {
            case 0:
               if(param1.dungeonTurnInfoMsg)
               {
                  _model.red = param1.dungeonTurnInfoMsg.red;
                  _model.green = param1.dungeonTurnInfoMsg.green;
                  _model.blue = param1.dungeonTurnInfoMsg.blue;
                  _model.posStatusMsg = param1.dungeonTurnInfoMsg.posStatusMsg;
                  _model.currentIndex = param1.dungeonTurnInfoMsg.curPos;
                  _model.normal = param1.dungeonTurnInfoMsg.normalBox;
                  _model.bossBox = param1.dungeonTurnInfoMsg.bossBox;
                  _model.playerInfo = param1.dungeonTurnInfoMsg.playerInfo;
                  _model.controlNum = param1.dungeonTurnInfoMsg.selectCount;
                  _model.currentControlNum = param1.dungeonTurnInfoMsg.selectCount;
                  _model.isByControl = false;
                  _model.calcBox();
                  _model.needPlayBossBoxLevelUp = _model.getneedPlayBossBoxLevelUp();
                  _model.needPlayNormalBoxLevelUp = _model.getneedPlayNormalBoxLevelUp();
                  if(!_model.isOpen)
                  {
                     CheckUIModuleUtil.instance.tryCall("dungeonturn",callFun);
                  }
               }
               break;
            case 1:
               if(param1.dungeonTurnInfoMsg)
               {
                  if(!model.isOpen && !model.isRoomOwner)
                  {
                     CheckUIModuleUtil.instance.tryCall("dungeonturn",callFun);
                  }
                  _model.red = param1.dungeonTurnInfoMsg.red;
                  _model.green = param1.dungeonTurnInfoMsg.green;
                  _model.blue = param1.dungeonTurnInfoMsg.blue;
                  _model.posStatusMsg = param1.dungeonTurnInfoMsg.posStatusMsg;
                  _model.currentIndex = param1.dungeonTurnInfoMsg.curPos;
                  _model.normal = param1.dungeonTurnInfoMsg.normalBox;
                  _model.bossBox = param1.dungeonTurnInfoMsg.bossBox;
                  _model.playerInfo = param1.dungeonTurnInfoMsg.playerInfo;
                  _model.controlNum = param1.dungeonTurnInfoMsg.selectCount;
                  _model.rollNum = param1.rollNum;
                  _model.calcBox();
                  _model.canDispose = false;
                  _model.fighting = false;
                  if(_model.currentControlNum != param1.dungeonTurnInfoMsg.selectCount)
                  {
                     _model.isByControl = true;
                     _model.currentControlNum = param1.dungeonTurnInfoMsg.selectCount;
                  }
                  NotificationManager.instance.dispatchEvent(new NotificationEvent("DUNGEO_TURN_ROLL"));
               }
               else
               {
                  _model.canDispose = true;
                  _model.fighting = false;
                  _model.rollNum = 0;
               }
               break;
            case 2:
               _model.rewardInfo = param1.reward;
               _model.hasGeted = param1.hasGetReward;
               _model.hasReward = param1.hasReward;
               model.calcReward();
               DelayActionsUtils.instance.addAction(new AlertTipAction(null,showRewardFrame,"PVE_ROOM_SCENE"));
               break;
            case 5:
               model.fighting = false;
               _model.red = param1.dungeonTurnInfoMsg.red;
               _model.green = param1.dungeonTurnInfoMsg.green;
               _model.blue = param1.dungeonTurnInfoMsg.blue;
               _model.posStatusMsg = param1.dungeonTurnInfoMsg.posStatusMsg;
               _model.currentIndex = param1.dungeonTurnInfoMsg.curPos;
               _model.normal = param1.dungeonTurnInfoMsg.normalBox;
               _model.bossBox = param1.dungeonTurnInfoMsg.bossBox;
               _model.playerInfo = param1.dungeonTurnInfoMsg.playerInfo;
               _model.controlNum = param1.dungeonTurnInfoMsg.selectCount;
               _model.currentControlNum = param1.dungeonTurnInfoMsg.selectCount;
               _model.isByControl = false;
               _model.calcBox();
               _model.needPlayBossBoxLevelUp = _model.getneedPlayBossBoxLevelUp();
               _model.needPlayNormalBoxLevelUp = _model.getneedPlayNormalBoxLevelUp();
               NotificationManager.instance.dispatchEvent(new NotificationEvent("DUNGEO_FINISH_FIGHT"));
               if(!_model.isOpen)
               {
                  CheckUIModuleUtil.instance.tryCall("dungeonturn",callFun);
               }
         }
      }
      
      public function fight() : void
      {
         model.fighting = true;
         if(CampaignManager.instance.controller)
         {
            CampaignManager.instance.controller.sendCampaignArrive(ArmyManager.instance.army.id,getNodeId());
         }
      }
      
      private function getNodeId() : int
      {
         var _loc1_:int = 0;
         var _loc2_:Array = [1,2,3,5,6,7,9,10,11];
         var _loc3_:int = 0;
         if(model.currentIndex == 13)
         {
            return model.endNodeId;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            if(_loc2_[_loc1_] == model.currentIndex)
            {
               _loc3_ = model.beginNodeId + _loc1_;
               break;
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      private function sendDungeoTurnOperate(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9006);
         var _loc3_:DungeonTurnOpMsg = new DungeonTurnOpMsg();
         _loc3_.op = param1;
         switch(param1 - 1)
         {
            case 0:
               _loc3_.rollNum = param2;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function openTurn() : void
      {
         sendDungeoTurnOperate(0,0);
      }
      
      public function rollDice(param1:int) : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("DUNGEO_START_ROLL"));
         model.canDispose = false;
         sendDungeoTurnOperate(1,param1);
      }
      
      public function getRewardInfo() : void
      {
         sendDungeoTurnOperate(2,0);
      }
      
      public function obtainReward() : void
      {
         sendDungeoTurnOperate(3,0);
      }
   }
}

