package yishi.manager
{
   import com.road.yishi.proto.castle.CastleYieldMsg;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.resource.ResourceData;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class ResourceManager
   {
      
      private static var _instance:ResourceManager;
      
      public var gold:ResourceData;
      
      public var crystal:ResourceData;
      
      public var population:ResourceData;
      
      public var waterCrystal:ResourceData;
      
      private var _socket:SocketSendManager;
      
      private var _syncTimer:Timer;
      
      public function ResourceManager()
      {
         super();
         gold = new ResourceData();
         crystal = new ResourceData();
         population = new ResourceData();
         waterCrystal = new ResourceData();
         _socket = SocketSendManager.instance;
         _syncTimer = new Timer(30000);
         _syncTimer.addEventListener("timer",__syncTimerHandler);
         _syncTimer.start();
         addEvent();
      }
      
      public static function get instance() : ResourceManager
      {
         if(!_instance)
         {
            _instance = new ResourceManager();
         }
         return _instance;
      }
      
      private function __syncTimerHandler(param1:TimerEvent) : void
      {
         sendSyncResources();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 109,__resourceUpgrade);
      }
      
      private function __resourceUpgrade(param1:SLGSocketEvent) : void
      {
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:CastleYieldMsg = new CastleYieldMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as CastleYieldMsg;
         var _loc8_:int = _loc2_.goldYield;
         var _loc5_:int = _loc2_.goldTotalCount;
         var _loc4_:int = _loc2_.goldMax;
         gold.synchronizationResource(_loc8_,_loc5_,_loc4_);
         var _loc3_:int = _loc2_.curPopulation;
         var _loc6_:int = _loc2_.maxPopulation;
         waterCrystal.synchronizationResource(0,_loc2_.crystalsCount,100000000);
         population.synchronizationResource(0,_loc3_,_loc6_);
      }
      
      public function canSubtractResources(param1:uint, param2:uint, param3:uint = 0) : String
      {
         var _loc5_:Array = [];
         var _loc4_:String = "";
         if(param1 > gold.count)
         {
            _loc4_ = LanguageMgr.GetTranslation("mainBar.view.ResourceView.gold");
            _loc5_.push(_loc4_ + (param1 - gold.count));
         }
         if(param2 > waterCrystal.count)
         {
            _loc4_ = LanguageMgr.GetTranslation("mainBar.view.ResourceView.crystal");
            _loc5_.push(_loc4_ + (param2 - waterCrystal.count));
         }
         if(param3 > population.limit)
         {
            _loc4_ = LanguageMgr.GetTranslation("mainBar.view.ResourceView.man");
            _loc5_.push(_loc4_ + (param3 - population.count));
         }
         if(_loc5_.length > 0)
         {
            _loc4_ = LanguageMgr.GetTranslation("mainBar.view.ResourceView.resource");
            return _loc4_ + _loc5_.join(",");
         }
         return null;
      }
      
      public function sendSyncResources() : void
      {
         var _loc1_:PackageOut = new PackageOut(5015);
         _socket.send(_loc1_);
      }
   }
}

