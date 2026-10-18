package yishi.manager
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.road.yishi.proto.simple.PropertyMsg;
   import managers.TheseussoulManager;
   import mvc.module.royaltyboss.RoyaltyBossModel;
   import mvc.module.royaltyboss.RoyaltyRankInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class RoyaltyBossManager
   {
      
      private static var _instance:RoyaltyBossManager;
      
      public static const ROYALTYBOSS_LV_EVENT:String = "ROYALTYBOSS_LV_EVENT";
      
      private var _model:RoyaltyBossModel;
      
      public function RoyaltyBossManager()
      {
         super();
      }
      
      public static function get instance() : RoyaltyBossManager
      {
         if(!_instance)
         {
            _instance = new RoyaltyBossManager();
         }
         return _instance;
      }
      
      public function get model() : RoyaltyBossModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new RoyaltyBossModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4292,__royaltyDataHandler);
      }
      
      private function __royaltyDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         model.royaltyLevel = _loc2_.param1;
         model.passBossLevel = _loc2_.param2;
         TheseussoulManager.Instance.model.checkEquipRed();
         NotificationManager.instance.sendNotification("ROYALTYBOSS_LV_EVENT");
      }
      
      public function sendFight() : void
      {
         var _loc1_:PackageOut = new PackageOut(8674);
         SocketSendManager.instance.send(_loc1_);
      }
      
      public function loadRoyaltyRankData() : void
      {
         var _loc1_:String = PathManager.royaltyRankPath;
         LoaderManagerII.instance.load(_loc1_,5,8,__royaltyRankLoadCompleteHandler);
      }
      
      private function __royaltyRankLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:RoyaltyRankInfo = null;
         model.rankList.length = 0;
         var _loc5_:XMLList = XML(param2)..item;
         for each(var _loc3_:XML in _loc5_)
         {
            _loc4_ = new RoyaltyRankInfo();
            _loc4_.Order = int(_loc3_.@Order);
            _loc4_.nickName = _loc3_.@NickName;
            _loc4_.royaltyLevel = int(_loc3_.@RoyaltyLevel);
            _loc4_.bossLevel = int(_loc3_.@BossLevel);
            model.rankList.push(_loc4_);
         }
         MsgMan.notifyObserver("ROYALTY_RANKDATA_LOAD_COMPLETE");
      }
   }
}

