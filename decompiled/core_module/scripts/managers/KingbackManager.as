package managers
{
   import com.road.yishi.proto.olderreflux.OlderRefluxInfoMsg;
   import com.road.yishi.proto.olderreflux.OlderRefluxMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import mvc.module.kingback.KingbackInfo;
   import mvc.module.kingback.KingbackModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   
   public class KingbackManager
   {
      
      private static var _instance:KingbackManager;
      
      public static const EVENT_UPDATE_INFOS:String = "kingback.updateInfos";
      
      private var _model:KingbackModel;
      
      private var _isOpen:int = 0;
      
      public function KingbackManager()
      {
         super();
         _model = new KingbackModel();
      }
      
      public static function get instance() : KingbackManager
      {
         if(!_instance)
         {
            _instance = new KingbackManager();
         }
         return _instance;
      }
      
      public function get model() : KingbackModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 515,__kingbackInfosHandler);
      }
      
      private function __kingbackInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:KingbackInfo = null;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:OlderRefluxMsg = new OlderRefluxMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as OlderRefluxMsg;
         if(_loc2_.hasOpenState)
         {
            isOpen = _loc2_.openState;
         }
         if(_loc2_.hasOpenTime)
         {
            _model.openTime = DateFormatter.parse(_loc2_.openTime,"YYYY-MM-DD hh:mm:ss").time;
         }
         if(_loc2_.hasStopTime)
         {
            _model.endTime = DateFormatter.parse(_loc2_.stopTime,"YYYY-MM-DD hh:mm:ss").time;
         }
         if(_loc2_.hasChargeTotalCount)
         {
            _model.chargeTotalCount = _loc2_.chargeTotalCount;
         }
         var _loc4_:int = 0;
         for each(var _loc3_:OlderRefluxInfoMsg in _loc2_.info)
         {
            _loc5_ = _loc3_.templateId;
            _loc7_ = _model.activeItems[_loc5_];
            if(_loc7_ == null)
            {
               _loc7_ = new KingbackInfo();
               _model.activeItems[_loc5_] = _loc7_;
            }
            _loc7_.templateId = _loc5_;
            _loc7_.needCounts = _loc3_.needCounts;
            _loc7_.rewardState = _loc3_.rewardState;
            if(_loc7_.rewardState == 1 && _loc7_.tempInfo && _loc7_.tempInfo.Type != 3)
            {
               _loc4_++;
            }
         }
         InfoTipsManager.instance.updateValue(32,_loc4_);
         NotificationManager.instance.sendNotification("kingback.updateInfos");
      }
      
      public function sendOp(param1:int, param2:int = -1) : void
      {
         var _loc4_:PackageOut = new PackageOut(9690);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = param2;
         _loc3_.templateId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function get isOpen() : int
      {
         return _isOpen;
      }
      
      public function set isOpen(param1:int) : void
      {
         if(_isOpen == param1)
         {
            return;
         }
         _isOpen = param1;
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
   }
}

