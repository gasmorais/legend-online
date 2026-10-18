package yishi.manager
{
   import com.road.yishi.proto.recover.RecoverReqMsg;
   import com.road.yishi.proto.recover.RecoverRspMsg;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class ExpBackManager
   {
      
      private static var _instance:ExpBackManager;
      
      public var backExpCost:int;
      
      public var backExp:int;
      
      public function ExpBackManager()
      {
         super();
      }
      
      public static function get Instance() : ExpBackManager
      {
         if(!_instance)
         {
            _instance = new ExpBackManager();
         }
         return _instance;
      }
      
      public function setUp() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4912,__onRecoverHandler);
      }
      
      private function __onRecoverHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:RecoverRspMsg = new RecoverRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as RecoverRspMsg;
         backExp = _loc2_.recoverGP;
         backExpCost = _loc2_.payPoint;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("RECOVER_EXP"));
      }
      
      public function sendExpBackRequest(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9503);
         var _loc3_:RecoverReqMsg = new RecoverReqMsg();
         _loc3_.type = param1;
         _loc3_.way = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

