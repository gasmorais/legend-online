package mvc.module.secret
{
   import yishi.utils.SimpleDictionary;
   
   public class SecretMapInfo
   {
      
      public var mapDataId:int;
      
      public var hasGetTask:Boolean;
      
      private var _mapEventInfos:SimpleDictionary;
      
      public function SecretMapInfo()
      {
         super();
         _mapEventInfos = new SimpleDictionary();
      }
      
      public function clear() : void
      {
         _mapEventInfos.clear();
      }
      
      public function addNdInfo(param1:int, param2:SecretEventInfo) : void
      {
         _mapEventInfos.add(param1,param2);
      }
      
      public function getNdInfo(param1:int) : SecretEventInfo
      {
         return _mapEventInfos[param1];
      }
      
      public function getAllNdInfos() : Array
      {
         return _mapEventInfos.getList();
      }
   }
}

