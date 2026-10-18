package yishi.manager
{
   import com.road.yishi.proto.minigame.GemInfoUpdateMsg;
   import com.road.yishi.proto.minigame.GemInviteOpMsg;
   import com.road.yishi.proto.minigame.GemMazeBuyTimesMsg;
   import com.road.yishi.proto.minigame.GemMazeHelpBoardStatus;
   import com.road.yishi.proto.minigame.GemMazeInfoMsg;
   import com.road.yishi.proto.minigame.GemMoveInviteMsg;
   import com.road.yishi.proto.minigame.GemMoveInviteReqMsg;
   import com.road.yishi.proto.minigame.GemMoveMsg;
   import com.road.yishi.proto.minigame.GetRewardBoxMsg;
   import com.road.yishi.proto.minigame.GetRewardBoxRspMsg;
   import events.GemMazeEvent;
   import flash.events.EventDispatcher;
   import mvc.module.gemmaze.GemMazeModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class GemMazeManager extends EventDispatcher
   {
      
      private static var _instance:GemMazeManager;
      
      private var _model:GemMazeModel;
      
      private var hasLinstener:Boolean = false;
      
      public function GemMazeManager()
      {
         super();
      }
      
      public static function get Instance() : GemMazeManager
      {
         if(!_instance)
         {
            _instance = new GemMazeManager();
         }
         return _instance;
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4922,__gemMazeInfoBuffHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4923,__gemInfoUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4924,__invideResultHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4927,__onBuyTimesHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4928,__onGetBoxGoodsHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4930,__onInvideBackHandler);
         hasLinstener = true;
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4922,__gemMazeInfoBuffHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4923,__gemInfoUpdateHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4924,__invideResultHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4927,__onBuyTimesHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4928,__onGetBoxGoodsHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4930,__onInvideBackHandler);
         hasLinstener = false;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4925,__invideNoticeHandler);
      }
      
      public function get model() : GemMazeModel
      {
         if(_model == null)
         {
            _model = new GemMazeModel();
         }
         return _model;
      }
      
      public function getInitInfo() : void
      {
         if(!hasLinstener)
         {
            initEvent();
         }
         var _loc1_:PackageOut = new PackageOut(9508);
         SocketSendManager.instance.send(_loc1_);
      }
      
      private function __gemMazeInfoBuffHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GemMazeInfoMsg = new GemMazeInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GemMazeInfoMsg;
         model.updateGemMazeInfo(_loc2_);
         sendDispatchEvent("GEMMAZE_GET_INIT_INFO");
      }
      
      public function moveGem(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9509);
         var _loc3_:GemMoveMsg = new GemMoveMsg();
         _loc3_.beginMark = param1;
         _loc3_.endMark = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
         model.gemMazeInfo.timesLeft -= 1;
         sendDispatchEvent("GEMMAZE_UPDATE_TIMESLEFT");
         sendDispatchEvent("GEMMAZE_GEM_UPDATE_FRAME");
      }
      
      private function __gemInfoUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GemInfoUpdateMsg = new GemInfoUpdateMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GemInfoUpdateMsg;
         model.updateGemUpdateInfo(_loc2_);
         sendDispatchEvent("GEMMAZE_UPDATE_INFO");
      }
      
      public function invideFriendHelp(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9510);
         var _loc2_:GemMoveInviteMsg = new GemMoveInviteMsg();
         _loc2_.playerIdInvited = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
         model.canMoveGemByUser = false;
      }
      
      private function __invideResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GemInviteOpMsg = new GemInviteOpMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GemInviteOpMsg;
         model.canMoveGemByUser = true;
         FrameControllerManager.instance.gemMazeController.closeInvideMaskFrame();
      }
      
      private function __invideNoticeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GemMoveInviteReqMsg = new GemMoveInviteReqMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GemMoveInviteReqMsg;
         model.invideByPlayerId = _loc2_.friendId;
         model.invideRemoveGemCount = _loc2_.helpNums;
         model.invideLeftTimes = _loc2_.inviteTimes;
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            helpFriend(4);
            return;
         }
         if(model.invideByFriendIsOpen)
         {
            helpFriend(5);
            return;
         }
         FrameControllerManager.instance.gemMazeController.startFrameByType(2);
      }
      
      public function helpFriend(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9515);
         var _loc2_:GemInviteOpMsg = new GemInviteOpMsg();
         _loc2_.playerId = model.invideByPlayerId;
         _loc2_.opCode = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function buyTimes(param1:int = 2) : void
      {
         var _loc3_:PackageOut = new PackageOut(9516);
         var _loc2_:GemMazeBuyTimesMsg = new GemMazeBuyTimesMsg();
         _loc2_.buyTypes = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      private function __onBuyTimesHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         model.gemMazeInfo.timesLeft += 10;
         model.gemMazeInfo.buyTimesLeft -= 10;
         sendDispatchEvent("GEMMAZE_GEM_UPDATE_FRAME");
      }
      
      public function getBoxGoods(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9513);
         var _loc2_:GetRewardBoxMsg = new GetRewardBoxMsg();
         _loc2_.boxId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      private function __onGetBoxGoodsHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:GetRewardBoxRspMsg = new GetRewardBoxRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as GetRewardBoxRspMsg;
         model.gemMazeInfo.boxMark = _loc2_.boxGetMark;
         var _loc4_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _loc2_.rewardInfo.length)
         {
            _loc4_.push(_loc2_.rewardInfo[_loc3_].rewardId);
            _loc3_++;
         }
         sendDispatchEvent("GEMMAZE_PLAYER_BOX_GOODS",_loc4_);
         sendDispatchEvent("GEMMAZE_UPDATE_BOX_STATUS");
      }
      
      private function __onInvideBackHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GemMazeHelpBoardStatus = new GemMazeHelpBoardStatus();
         _loc2_ = _loc3_.readBody(_loc2_) as GemMazeHelpBoardStatus;
         FrameControllerManager.instance.gemMazeController.openInvideMaskFrame();
      }
      
      public function claerData() : void
      {
         model.gemMazeInfo = null;
         removeEvent();
      }
      
      public function sendOpenInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(9517);
         SocketSendManager.instance.send(_loc1_);
      }
      
      public function sendDispatchEvent(param1:String, param2:* = null) : void
      {
         dispatchEvent(new GemMazeEvent(param1,param2));
      }
   }
}

