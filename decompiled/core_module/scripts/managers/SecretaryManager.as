package managers
{
   import com.road.yishi.proto.consortia.ConsortiaMsg;
   import com.road.yishi.proto.player.NeedGoldMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import flash.events.EventDispatcher;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.secretary.SecretaryData;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ConsortiaManager;
   import yishi.service.managers.SocketManager;
   
   public class SecretaryManager extends EventDispatcher
   {
      
      private static var _instance:SecretaryManager;
      
      public var actManager:LitteActionManager;
      
      public var isFinish:Boolean = false;
      
      public var isactFinish:Boolean = false;
      
      private var _model:SecretaryData;
      
      private var _model2:ConsortiaModel;
      
      public function SecretaryManager()
      {
         super();
         actManager = new LitteActionManager();
         if(!_model)
         {
            _model = new SecretaryData();
         }
      }
      
      public static function get instance() : SecretaryManager
      {
         if(!_instance)
         {
            _instance = new SecretaryManager();
         }
         return _instance;
      }
      
      public function get model() : SecretaryData
      {
         return _model;
      }
      
      public function setup() : void
      {
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 593,gemGoldHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4141,__refreshAltarInfo);
      }
      
      private function __refreshAltarInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaMsg = new ConsortiaMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ConsortiaMsg;
         _model2 = ConsortiaManager.instance.model;
         _model2.alTarBlessLeftTime = _loc2_.blessLeftTime;
      }
      
      private function gemGoldHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:NeedGoldMsg = new NeedGoldMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as NeedGoldMsg;
         model.GemGold = _loc2_.gold;
      }
      
      public function gotoGetGemNum(param1:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(9741);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function goGettower() : void
      {
         var _loc1_:PackageOut = new PackageOut(9742);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
      
      public function gotoLab() : void
      {
         var _loc2_:PackageOut = new PackageOut(9566);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = 11;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
   }
}

