package map.internals3D.mapbackground.model
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.utils.Dictionary;
   import map.outercity.manager.OuterCityManager;
   
   public class MapBackgroundMaxModel3D extends MapBackgroundBaseModel3D
   {
      
      private static const CELL_COUNT_X:uint = 20;
      
      private static const CELL_COUNT_Y:uint = 10;
      
      private var _allTile:Dictionary;
      
      public function MapBackgroundMaxModel3D()
      {
         super();
         _allTile = new Dictionary();
      }
      
      override protected function updateScreenBackground(param1:int, param2:int) : void
      {
         param1 = -param1 + StageReferance.stageWidth;
         param2 = -param2 + StageReferance.stageHeight;
         findDeleteCell();
         findNextDisplayCell(param1,param2);
      }
      
      private function findNextDisplayCell(param1:int, param2:int) : void
      {
         var _loc10_:MapBackgroundCellInfo3D = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc7_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _newBackroundCellList.length = 0;
         var _loc3_:int = int(StageReferance.stageWidth);
         var _loc9_:int = int(StageReferance.stageHeight);
         param1 = int(param1 < _loc3_ / 2 ? _loc3_ / 2 : param1);
         param2 = int(param2 < _loc9_ / 2 ? _loc9_ / 2 : param2);
         var _loc12_:int = Math.floor((param1 - _loc3_ / 2 - 512) / 512);
         var _loc8_:int = Math.ceil((param1 + _loc3_ / 2 + 512) / 512);
         var _loc11_:int = Math.floor((param2 - _loc9_ / 2 - 512) / 512);
         var _loc6_:int = Math.ceil((param2 + _loc9_ / 2 + 512) / 512);
         if(_loc12_ < 0)
         {
            _loc12_ = 0;
         }
         if(_loc11_ < 0)
         {
            _loc11_ = 0;
         }
         _loc4_ = _loc12_;
         while(_loc4_ < _loc8_)
         {
            _loc5_ = _loc11_;
            while(_loc5_ < _loc6_)
            {
               _loc13_ = _loc4_;
               _loc14_ = _loc5_;
               _loc7_ = _loc13_ + "_" + _loc14_;
               if(!_allTile[_loc7_])
               {
                  _loc10_ = new MapBackgroundCellInfo3D();
                  _loc10_.row = _loc13_;
                  _loc10_.col = _loc14_;
                  _loc10_.mapId = mapId;
               }
               else
               {
                  _loc10_ = _allTile[_loc7_];
               }
               _loc10_.x = _loc4_;
               _loc10_.y = _loc5_;
               _loc10_.setCenterPoint(0,0);
               _newBackroundCellList.push(_loc10_);
               _allTile[_loc7_] = _loc10_;
               _loc5_++;
            }
            _loc4_++;
         }
      }
      
      private function getTileX(param1:int, param2:int) : int
      {
         var _loc3_:int = -1;
         if(Math.floor(param2 / 10) % 2 == 0)
         {
            _loc3_ = param1 % 20;
         }
         else if(Math.floor(param1 / (20 / 2)) % 2 == 0)
         {
            _loc3_ = param1 % 20 + 20 / 2;
         }
         else
         {
            _loc3_ = param1 % 20 - 20 / 2;
         }
         return _loc3_;
      }
      
      private function findDeleteCell() : void
      {
         _deleteBackroundCellList.length = 0;
         for each(var _loc1_:MapBackgroundCellInfo3D in _newBackroundCellList)
         {
            _deleteBackroundCellList.push(_loc1_);
         }
      }
      
      private function get mapId() : int
      {
         return OuterCityManager.instance.model.mapId;
      }
      
      override public function dispose() : void
      {
         var _loc1_:MapBackgroundCellInfo3D = null;
         for(var _loc2_:String in _allTile)
         {
            _loc1_ = _allTile[_loc2_];
            _loc1_.dispose();
            delete _allTile[_loc2_];
         }
         _allTile = null;
         super.dispose();
      }
   }
}

