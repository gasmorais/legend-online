package map.space.preload
{
   import map.internals.data.MapInfo;
   import map.internals.load.PreLoadMapData;
   
   public class ProLoadSpaceData extends PreLoadMapData
   {
      
      private var _stepTimeId1:int;
      
      private var _stepTimeId2:int;
      
      private var _stepTimeId3:int;
      
      private var _stepTimeId4:int;
      
      private var _loadCount:int;
      
      private var _upProView:Boolean;
      
      public function ProLoadSpaceData(param1:MapInfo, param2:Boolean = true)
      {
         super(param1);
         _upProView = param2;
      }
   }
}

