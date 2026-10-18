package yishi.manager
{
   import battle.utils.Int64Utils;
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.secretexplore.SecretExploreEventRspMsg;
   import com.road.yishi.proto.secretexplore.SecretExploreInfoRspMsg;
   import com.road.yishi.proto.secretexplore.SecretExploreMapRspMsg;
   import com.road.yishi.proto.secretexplore.SecretExploreSecenRspMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.module.secret.SecretAdventureModel;
   import mvc.module.secret.SecretEventInfo;
   import mvc.module.secret.SecretFrameInfo;
   import mvc.module.secret.SecretMapInfo;
   import mvc.module.secret.SecretSecenInfo;
   import yishi.SwitchPageHelp;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   
   public class SecretAdventerManager
   {
      
      private static var _instance:SecretAdventerManager;
      
      public static const OP_REVIER:int = 4;
      
      public static const OP_FRAME:int = 5;
      
      public static const OP_START:int = 6;
      
      public static const OP_EXIT:int = 7;
      
      public static const OP_RESET:int = 8;
      
      public var gotoSpace:Boolean;
      
      private var _model:SecretAdventureModel;
      
      private const OP_WALK:int = 1;
      
      private const OP_BUY:int = 2;
      
      private const OP_EVENT:int = 3;
      
      public function SecretAdventerManager()
      {
         super();
         _model = new SecretAdventureModel();
      }
      
      public static function get Instance() : SecretAdventerManager
      {
         if(_instance == null)
         {
            _instance = new SecretAdventerManager();
         }
         return _instance;
      }
      
      public function get model() : SecretAdventureModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 524,__frameInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 526,__eventInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 525,__secenInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 527,__resetHandler);
      }
      
      private function __resetHandler(param1:SLGSocketEvent) : void
      {
         gotoSpace = true;
         model.reset();
         var _loc2_:PackageIn = param1.data as PackageIn;
         if(SceneManager.instance.currentType == "SECRET_ADVENTURE_SCENE")
         {
            SwitchPageHelp.returnToSpace();
         }
         NotificationManager.instance.sendNotification("SecretAdEvent.timeClose");
      }
      
      private function __frameInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SecretExploreInfoRspMsg = new SecretExploreInfoRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as SecretExploreInfoRspMsg;
         var _loc3_:SecretFrameInfo = model.frameInfo;
         _loc3_.mapId = _loc2_.mapId;
         _loc3_.levelId = _loc2_.levelId;
         _loc3_.remainingTimes = _loc2_.remainingTimes;
         _loc3_.fight = _loc2_.fight;
         _loc3_.remainTime = _loc2_.remainTime;
         _loc3_.isFirst = _loc2_.isFirst;
         _loc3_.passMapId = _loc2_.passMapId;
         _loc3_.currHp = Int64Utils.int64ToNumber(_loc2_.hp);
         _loc3_.initHp = Int64Utils.int64ToNumber(_loc2_.initHp);
         model.resetForceRefresh = true;
         model.dispatchEvent(new NotificationEvent("SecretAdEvent.frameUpdate"));
      }
      
      private function __eventInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SecretExploreMapRspMsg = new SecretExploreMapRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SecretExploreMapRspMsg;
         readMapEvents(_loc2_);
      }
      
      private function __secenInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SecretExploreSecenRspMsg = new SecretExploreSecenRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SecretExploreSecenRspMsg;
         var _loc5_:SecretSecenInfo = model.secenInfo;
         _loc5_.levelId = _loc2_.levelId;
         _loc5_.mapDataIds = _loc2_.mapDataIds;
         _loc5_.standId = _loc2_.nodeId;
         model.pinfo.lastStandNodeId = _loc2_.nodeId;
         model.pinfo.standNodeId = _loc2_.nodeId;
         for each(var _loc4_:SecretExploreMapRspMsg in _loc2_.maps)
         {
            readMapEvents(_loc4_);
         }
         _loc5_.currMapDataId = _loc2_.currentMapDataId;
         if(SceneManager.instance.currentType != "SECRET_ADVENTURE_SCENE")
         {
            gotoSpace = false;
            SceneManager.instance.setScene("SECRET_ADVENTURE_SCENE");
         }
      }
      
      private function readMapEvents(param1:SecretExploreMapRspMsg) : void
      {
         var _loc2_:SecretMapInfo = null;
         var _loc4_:SecretEventInfo = null;
         var _loc6_:SecretSecenInfo = model.secenInfo;
         _loc2_ = _loc6_.getMapInfo(param1.mapDataId);
         if(!_loc2_)
         {
            _loc2_ = new SecretMapInfo();
            _loc6_.putMapInfo(param1.mapDataId,_loc2_);
         }
         _loc2_.mapDataId = param1.mapDataId;
         var _loc5_:Array = [];
         for each(var _loc3_:SecretExploreEventRspMsg in param1.events)
         {
            _loc4_ = _loc2_.getNdInfo(_loc3_.nodeId);
            if(!_loc4_)
            {
               _loc4_ = new SecretEventInfo();
               _loc4_.mapDataId = param1.mapDataId;
               _loc2_.addNdInfo(_loc3_.nodeId,_loc4_);
            }
            _loc4_.nodeId = _loc3_.nodeId;
            _loc4_.eventId = _loc3_.eventId;
            _loc4_.state = _loc3_.state;
            _loc4_.params = _loc3_.params;
            _loc5_.push(_loc4_);
         }
         model.dispatchEvent(new NotificationEvent("SecretAdEvent.mapEventUpadate",[_loc2_.mapDataId,_loc5_]));
      }
      
      public function opWalk(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9706);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = 1;
         _loc3_.param2 = param1;
         _loc3_.param3 = param2;
         sendProtoBuffer(_loc3_,_loc4_);
      }
      
      public function opBuy(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(9706);
         var _loc4_:PropertyMsg = new PropertyMsg();
         _loc4_.param1 = 2;
         _loc4_.param2 = param1;
         _loc4_.param3 = param2;
         _loc4_.param10 = param3;
         sendProtoBuffer(_loc4_,_loc5_);
      }
      
      public function opEvent(param1:int, param2:int, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(9706);
         var _loc4_:PropertyMsg = new PropertyMsg();
         _loc4_.param1 = 3;
         _loc4_.param2 = param1;
         _loc4_.param3 = param2;
         _loc4_.param10 = param3;
         sendProtoBuffer(_loc4_,_loc5_);
      }
      
      public function opCommon(param1:int, param2:int = 0) : void
      {
         if(param1 == 7 || param1 == 8 || param1 == 6)
         {
            _model.reset();
         }
         var _loc4_:PackageOut = new PackageOut(9706);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = param1;
         _loc3_.param2 = param2;
         sendProtoBuffer(_loc3_,_loc4_);
      }
      
      private function sendProtoBuffer(param1:Message, param2:PackageOut) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param2,param1);
      }
   }
}

