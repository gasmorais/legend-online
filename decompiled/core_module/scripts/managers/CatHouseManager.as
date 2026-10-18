package managers
{
   import com.road.yishi.proto.cat.CattoysInfoListMsg;
   import com.road.yishi.proto.cat.CattoysInfoMsg;
   import flash.utils.Dictionary;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class CatHouseManager
   {
      
      private static var _instance:CatHouseManager;
      
      public static const OP_EXCHANGE:int = 1;
      
      public static const OP_PLACE:int = 2;
      
      public static const OP_REWARD:int = 3;
      
      public static const OP_DISMANTLE:int = 4;
      
      public static const OP_REQUEST:int = 5;
      
      public static const CAT_ITEM_STATE_NORMAL:int = 0;
      
      public static const CAT_ITEM_STATE_PRODUCT:int = 1;
      
      public static const CAT_ITEM_STATE:int = 2;
      
      public static const CAT_ITEM_STATE_FINISH:int = 3;
      
      private var _cattoysDic:Dictionary;
      
      private var _cattoysList:Dictionary;
      
      public function CatHouseManager()
      {
         super();
      }
      
      public static function get instance() : CatHouseManager
      {
         if(!_instance)
         {
            _instance = new CatHouseManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _cattoysList = new Dictionary();
         _cattoysDic = new Dictionary();
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 331,__cattoysHandler);
      }
      
      private function __cattoysHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:CattoysInfoMsg = null;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:CattoysInfoListMsg = new CattoysInfoListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as CattoysInfoListMsg;
         _cattoysList = new Dictionary();
         _cattoysDic = new Dictionary();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.cattoyInfos.length)
         {
            _loc6_ = _loc2_.cattoyInfos[_loc3_] as CattoysInfoMsg;
            if(!_cattoysList[_loc6_.templateId])
            {
               _cattoysList[_loc6_.templateId] = [];
            }
            if(_loc6_.isExist)
            {
               _cattoysList[_loc6_.templateId].push(_loc6_);
            }
            if(_loc6_.rotatePos >= 0)
            {
               _cattoysDic[_loc6_.rotatePos] = _loc6_;
            }
            _loc3_++;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("CATTOYS_UPDATE"));
      }
      
      public function getCountByTemplateId(param1:int) : int
      {
         var _loc2_:Array = _cattoysList[param1] as Array;
         if(_loc2_)
         {
            return _loc2_.length;
         }
         return 0;
      }
      
      public function get cattoysDic() : Dictionary
      {
         return _cattoysDic;
      }
      
      public function getCattoysHarvestCount() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_:CattoysInfoMsg in _cattoysDic)
         {
            if(_loc1_.state == 2)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function getCattoysRandomId(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:Array = _cattoysList[param1];
         if(_loc2_.length > 0)
         {
            _loc3_ = int(CattoysInfoMsg(_loc2_[0]).id);
         }
         return _loc3_;
      }
      
      public function OperateCatHouse(param1:int, param2:int = 0, param3:int = 0, param4:int = 0) : void
      {
         var _loc6_:PackageOut = new PackageOut(9585);
         var _loc5_:CattoysInfoMsg = new CattoysInfoMsg();
         _loc5_.op = param1;
         _loc5_.id = param3;
         _loc5_.templateId = param2;
         _loc5_.payType = param4;
         SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc5_);
      }
   }
}

