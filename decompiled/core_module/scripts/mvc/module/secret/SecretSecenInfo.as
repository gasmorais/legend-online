package mvc.module.secret
{
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleDictionary;
   
   public class SecretSecenInfo
   {
      
      public var levelId:int;
      
      public var mapDataIds:String;
      
      private var _standId:int;
      
      private var _currMapDataId:int;
      
      private var _mapInfos:SimpleDictionary;
      
      public function SecretSecenInfo()
      {
         super();
         _mapInfos = new SimpleDictionary();
      }
      
      public function getMapIds() : Array
      {
         if(mapDataIds && mapDataIds.length > 0)
         {
            return mapDataIds.split(",");
         }
         return [];
      }
      
      public function getMapInfo(param1:int) : SecretMapInfo
      {
         return _mapInfos[param1];
      }
      
      public function putMapInfo(param1:int, param2:SecretMapInfo) : void
      {
         _mapInfos.clear();
         _mapInfos.add(param1,param2);
      }
      
      public function clear() : void
      {
         var _loc2_:Array = _mapInfos.getList();
         for each(var _loc1_:SecretMapInfo in _loc2_)
         {
            _loc1_.clear();
         }
         _mapInfos.clear();
         mapDataIds = "";
         _currMapDataId = -1;
      }
      
      public function get currMapDataId() : int
      {
         return _currMapDataId;
      }
      
      public function set currMapDataId(param1:int) : void
      {
         if(_currMapDataId == param1)
         {
            return;
         }
         var _loc2_:int = _currMapDataId;
         _currMapDataId = param1;
         NotificationManager.instance.sendNotification("SecretAdEvent.transMap",_loc2_);
      }
      
      public function get standId() : int
      {
         return _standId;
      }
      
      public function set standId(param1:int) : void
      {
         _standId = param1;
      }
   }
}

