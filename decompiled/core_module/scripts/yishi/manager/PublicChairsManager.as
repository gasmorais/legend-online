package yishi.manager
{
   import com.road.yishi.proto.active.ChairsListMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class PublicChairsManager
   {
      
      public static const OP_CLIENT_REQUEST:uint = 1;
      
      public static const OP_CLIENT_TAKEREWARD:uint = 2;
      
      private static var _instance:PublicChairsManager;
      
      private var _chairsMsg:ChairsListMsg;
      
      public var openChairs:Boolean = false;
      
      public function PublicChairsManager()
      {
         super();
      }
      
      public static function get instance() : PublicChairsManager
      {
         if(!_instance)
         {
            _instance = new PublicChairsManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 415,__chairslistHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 414,__openstateHandler);
      }
      
      private function __chairslistHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChairsListMsg = new ChairsListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChairsListMsg;
         _chairsMsg = _loc2_;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("PUBLIC_CHAIRS_UPDATE"));
      }
      
      private function __openstateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         openChairs = _loc2_.param7;
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
      
      public function get chairsMsg() : ChairsListMsg
      {
         return _chairsMsg;
      }
      
      public function OperateChairsReq(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9638);
         var _loc2_:ChairsListMsg = new ChairsListMsg();
         _loc2_.op = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

