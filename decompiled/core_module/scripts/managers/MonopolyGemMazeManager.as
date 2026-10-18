package managers
{
   import com.road.yishi.proto.minigame.GemInfoUpdateMsg;
   import com.road.yishi.proto.minigame.GemMazeBuyTimesMsg;
   import com.road.yishi.proto.minigame.GemMazeInfoMsg;
   import com.road.yishi.proto.minigame.GemMoveMsg;
   import events.GemMazeEvent;
   import flash.events.EventDispatcher;
   import mvc.module.gemmaze.GemMazeModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class MonopolyGemMazeManager extends EventDispatcher
   {
      
      private static var _instance:MonopolyGemMazeManager;
      
      private var _model:GemMazeModel;
      
      private var hasLinstener:Boolean = false;
      
      public function MonopolyGemMazeManager()
      {
         super();
         _model = new GemMazeModel();
      }
      
      public static function get Instance() : MonopolyGemMazeManager
      {
         if(!_instance)
         {
            _instance = new MonopolyGemMazeManager();
         }
         return _instance;
      }
      
      public function get model() : GemMazeModel
      {
         return _model;
      }
      
      public function setup() : void
      {
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4760,__gemMazeInfoBuffHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4922,__gemMazeInfoBuffHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4761,__gemInfoUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4864,__onBuyTimesHandler);
         hasLinstener = true;
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4760,__gemMazeInfoBuffHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4922,__gemMazeInfoBuffHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4761,__gemInfoUpdateHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4864,__onBuyTimesHandler);
         hasLinstener = false;
      }
      
      private function __gemMazeInfoBuffHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GemMazeInfoMsg = new GemMazeInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GemMazeInfoMsg;
         model.updateGemMazeInfo(_loc2_);
         sendDispatchEvent("GEMMAZE_GET_INIT_INFO");
      }
      
      private function __gemInfoUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GemInfoUpdateMsg = new GemInfoUpdateMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GemInfoUpdateMsg;
         model.updateGemUpdateInfo(_loc2_);
         sendDispatchEvent("GEMMAZE_UPDATE_INFO");
      }
      
      private function __onBuyTimesHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         model.gemMazeInfo.timesLeft += 10;
         sendDispatchEvent("GEMMAZE_GEM_UPDATE_FRAME");
      }
      
      public function getInitInfo() : void
      {
         if(!hasLinstener)
         {
            initEvent();
         }
         var _loc1_:PackageOut = new PackageOut(8961);
         SocketSendManager.instance.send(_loc1_);
      }
      
      public function moveGem(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8879);
         var _loc3_:GemMoveMsg = new GemMoveMsg();
         _loc3_.beginMark = param1;
         _loc3_.endMark = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
         model.gemMazeInfo.timesLeft -= 1;
         sendDispatchEvent("GEMMAZE_UPDATE_TIMESLEFT");
         sendDispatchEvent("GEMMAZE_GEM_UPDATE_FRAME");
      }
      
      public function buyTimes(param1:int = 2) : void
      {
         var _loc3_:PackageOut = new PackageOut(8878);
         var _loc2_:GemMazeBuyTimesMsg = new GemMazeBuyTimesMsg();
         _loc2_.buyTypes = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function claerData() : void
      {
         model.gemMazeInfo = null;
         model.gemUpdateArr = [];
      }
      
      public function sendDispatchEvent(param1:String, param2:* = null) : void
      {
         dispatchEvent(new GemMazeEvent(param1,param2));
      }
   }
}

