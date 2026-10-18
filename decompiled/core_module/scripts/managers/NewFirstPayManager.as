package managers
{
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.events.Event;
   import mvc.module.newfirstpay.NewFirstPayModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   
   public class NewFirstPayManager
   {
      
      private static var _instance:NewFirstPayManager;
      
      private var _model:NewFirstPayModel;
      
      public function NewFirstPayManager()
      {
         super();
         setup();
      }
      
      public static function get instance() : NewFirstPayManager
      {
         if(!_instance)
         {
            _instance = new NewFirstPayManager();
         }
         return _instance;
      }
      
      public function get model() : NewFirstPayModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new NewFirstPayModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4290,__updateOpenState);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4590,__topBtnHandler);
      }
      
      private function __topBtnHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.param1 == 4022)
         {
            model.isOpen = _loc2_.param7;
            NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
         }
      }
      
      private function __updateOpenState(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.hasParam4)
         {
            _model.rewardState[0] = _loc2_.param4.split(",");
         }
         if(_loc2_.hasParam5)
         {
            _model.rewardState[1] = _loc2_.param5.split(",");
         }
         if(_loc2_.hasParam6)
         {
            _model.rewardState[2] = _loc2_.param6.split(",");
         }
         if(_loc2_.hasParam1)
         {
            _model.chargeNum = _loc2_.param1;
         }
         _model.dispatchEvent(new Event("change"));
         NotificationManager.instance.sendNotification("INFO_TIPS_DATA_UPDATE");
      }
      
      public function sendGetReward(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8672);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.payType = param1;
         _loc3_.index = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
   }
}

