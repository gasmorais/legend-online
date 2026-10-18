package com.road.mapengine.bitmap.map
{
   import com.pickgliss.ui.ComponentSetting;
   import flash.display.BitmapData;
   import map.internals.library.MapElmsLibrary;
   
   public class BaseMapsData
   {
      
      private var _elmsData:MapElmsLibrary;
      
      private var _indexArray:Array;
      
      private var _backUrl:String;
      
      private var _mapData:Object;
      
      private var _mapWidth:int;
      
      private var _mapHeight:int;
      
      public function BaseMapsData()
      {
         super();
      }
      
      public function get backUrl() : String
      {
         return _backUrl;
      }
      
      public function get mapHeight() : int
      {
         return _mapHeight;
      }
      
      public function set mapHeight(param1:int) : void
      {
         _mapHeight = param1;
      }
      
      public function get mapWidth() : int
      {
         return _mapWidth;
      }
      
      public function set mapWidth(param1:int) : void
      {
         _mapWidth = param1;
      }
      
      public function set elmsData(param1:MapElmsLibrary) : void
      {
         _elmsData = param1;
      }
      
      public function set mapData(param1:Object) : void
      {
         _mapData = param1;
         findBackUrl();
         sortOnBaseNum();
      }
      
      private function sortOnBaseNum() : void
      {
         var _loc5_:int = 0;
         _indexArray = [];
         for each(var _loc3_:Object in _mapData)
         {
            for each(var _loc1_:Array in _loc3_)
            {
               _indexArray = _indexArray.concat(_loc1_);
            }
         }
         _indexArray = _indexArray.sortOn("baseNum",16);
         var _loc4_:int = int(_indexArray.length);
         var _loc2_:* = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(_indexArray[_loc5_].baseNum > 101)
            {
               _loc2_ = _loc5_;
               break;
            }
            _loc5_++;
         }
         _indexArray.splice(0,_loc2_);
      }
      
      private function findBackUrl() : String
      {
         var _loc3_:BitmapData = null;
         var _loc1_:Boolean = false;
         loop0:
         for each(var _loc4_:Object in _mapData)
         {
            for each(var _loc2_:Array in _loc4_)
            {
               for each(var _loc5_:Object in _loc2_)
               {
                  if(_loc5_["baseNum"] == 101)
                  {
                     _backUrl = _loc5_["url"];
                     _loc3_ = getBitmapDataById(_backUrl) as BitmapData;
                     if(_loc3_ && _loc3_.width == _loc3_.height && _loc3_.width == 100)
                     {
                        break loop0;
                     }
                  }
               }
            }
         }
         return _backUrl;
      }
      
      public function getBitmapDataById(param1:String) : BitmapData
      {
         return _elmsData.getElementByPath(ComponentSetting.RESOURCE_PATH + param1) as BitmapData;
      }
      
      public function get indexArray() : Array
      {
         return _indexArray;
      }
   }
}

