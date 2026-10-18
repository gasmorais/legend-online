package yishi.datas.templates
{
   import yishi.manager.TempleteManager;
   
   public class SecretMapLevelTemplate
   {
      
      public var MapId:int;
      
      public var MapName:String;
      
      public var Description:String;
      
      public var Drop:String;
      
      public var Type:int;
      
      private var _minSonLd:int = -1;
      
      private var _list:Array;
      
      public function SecretMapLevelTemplate()
      {
         super();
      }
      
      public function getMinSonId() : int
      {
         var _loc1_:Array = null;
         if(_minSonLd == -1)
         {
            _loc1_ = getSonList();
            _minSonLd = _loc1_[0];
         }
         return _minSonLd;
      }
      
      public function getSonList() : Array
      {
         if(_list == null)
         {
            _list = TempleteManager.instance.secretsonLvCate.getSonLvsByMapId(MapId);
            _list.sortOn("LevelId",16);
         }
         return _list;
      }
   }
}

