package map.internals.data
{
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import map.internals.event.OuterCityEvent;
   import map.internals.utils.MapDataUtils;
   import map.internals.utils.Utils;
   
   public class FloorMapInfo extends MapInfo
   {
      
      private var _nineSliceScaling:Array = [];
      
      private var _preNineSliceScaling:Array = [];
      
      public var _currentOuterCityConfig:Dictionary;
      
      private var _noteUserFiles:Dictionary = new Dictionary(true);
      
      public function FloorMapInfo(param1:IEventDispatcher = null)
      {
         super(param1);
         _currentOuterCityConfig = new Dictionary(true);
      }
      
      public function set nineSliceScaling(param1:Array) : void
      {
         _preNineSliceScaling = _nineSliceScaling;
         _nineSliceScaling = param1;
         this.dispatchEvent(new OuterCityEvent("nineSliceScaling",param1));
      }
      
      public function get nineSliceScaling() : Array
      {
         return _nineSliceScaling;
      }
      
      public function upPreNineSliceScaling(param1:String) : void
      {
         var _loc2_:int = _nineSliceScaling.indexOf(param1);
         if(_loc2_ != -1)
         {
            _nineSliceScaling.splice(_loc2_);
         }
      }
      
      public function checkUpdateConfig() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         var _loc4_:int = 0;
         var _loc1_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _nineSliceScaling.length)
         {
            _loc2_ = false;
            _loc4_ = 0;
            while(_loc4_ < _preNineSliceScaling.length)
            {
               if(_nineSliceScaling[_loc3_] == _preNineSliceScaling[_loc4_])
               {
                  _loc2_ = true;
               }
               _loc4_++;
            }
            if(!_loc2_)
            {
               _loc1_.push(_nineSliceScaling[_loc3_]);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function checkConfigNoExites() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = checkUpdateConfig();
         _loc2_ = _loc1_.length - 1;
         while(_loc2_ >= 0)
         {
            if(_currentOuterCityConfig[_loc1_[_loc2_] + "_f"] && _currentOuterCityConfig[_loc1_[_loc2_] + "_b"])
            {
               addOuterCityConfig(_loc1_[_loc2_],_currentOuterCityConfig[_loc1_[_loc2_] + "_f"],_currentOuterCityConfig[_loc1_[_loc2_] + "_b"]);
               _loc1_.splice(_loc2_,1);
            }
            _loc2_--;
         }
         return _loc1_;
      }
      
      public function addOuterCityConfig(param1:String, param2:Array, param3:Array) : void
      {
         _noteUserFiles[param1] = true;
         if(_currentOuterCityConfig[param1 + "_f"])
         {
            this.dispatchEvent(new OuterCityEvent("currentConfigChange",{
               "floor":param2,
               "build":param3,
               "id":param1
            }));
         }
         else
         {
            _currentOuterCityConfig[param1 + "_f"] = param2;
            _currentOuterCityConfig[param1 + "_b"] = param3;
            this.dispatchEvent(new OuterCityEvent("currentConfigChange",{
               "floor":param2,
               "build":param3,
               "id":param1
            }));
         }
      }
      
      public function reUserFile(param1:String) : void
      {
         _noteUserFiles[param1] = false;
      }
      
      public function set currentFloorData(param1:Array) : void
      {
         var _loc2_:Object = null;
         var _loc4_:Point = null;
         var _loc8_:Array = null;
         var _loc3_:Array = null;
         var _loc5_:Array = null;
         var _loc9_:Point = null;
         if(param1.length == 0)
         {
            return;
         }
         this.dispatchEvent(new OuterCityEvent("commitLoading",null));
         var _loc6_:Dictionary = new Dictionary(true);
         for each(var _loc7_:String in nineSliceScaling)
         {
            if(_currentSceneFloorData[_loc7_])
            {
               _loc6_[_loc7_] = _currentSceneFloorData[_loc7_];
            }
            else
            {
               _loc2_ = sloveRectData(_loc7_);
               if(_loc2_["floor"])
               {
                  _loc4_ = Utils.getStartPoint(_loc7_);
                  _loc2_["start"] = _loc4_;
                  _loc2_["id"] = _loc7_;
                  _loc6_[_loc7_] = _loc2_;
               }
            }
         }
         _currentSceneFloorData = _loc6_;
         for(var _loc10_:String in _currentSceneFloorData)
         {
            _loc8_ = _currentSceneFloorData[_loc10_] as Array;
            _loc3_ = moviesData ? moviesData[_loc10_] as Array : [];
            _loc5_ = topsData ? topsData[_loc10_] as Array : [];
            _loc9_ = MapDataUtils.getStartPoint(_loc10_);
            this.dispatchEvent(new OuterCityEvent("currentConfigChange",{
               "floor":_loc8_,
               "movies":_loc3_,
               "tops":_loc5_,
               "id":_loc10_,
               "start":_loc9_
            }));
         }
      }
      
      protected function sloveRectData(param1:String) : Object
      {
         var _loc4_:String = null;
         var _loc3_:Point = Utils.getStartPoint(param1);
         if(getARectOrBRect(_loc3_))
         {
            _loc4_ = _loc3_.x % 5000 / 1000 + "," + _loc3_.y % 5000 / 1000;
         }
         else
         {
            _loc4_ = _loc3_.x % 5000 / 1000 + "," + (int(_loc3_.y % 5000 / 1000 + 5));
         }
         var _loc2_:Object = {};
         _loc2_["floor"] = floorData[_loc4_];
         if(topsData)
         {
            _loc2_["tops"] = topsData[_loc4_];
         }
         if(moviesData)
         {
            _loc2_["movies"] = moviesData[_loc4_];
         }
         return _loc2_;
      }
      
      private function getARectOrBRect(param1:Point) : Boolean
      {
         var _loc2_:int = Math.floor(param1.x / 5000) % 2;
         var _loc3_:int = Math.floor(param1.y / 5000) % 2;
         if(_loc2_ == 0)
         {
            if(_loc3_ == 0)
            {
               return true;
            }
         }
         else if(_loc3_ != 0)
         {
            return true;
         }
         return false;
      }
      
      public function mapAddToStage() : void
      {
         this.dispatchEvent(new OuterCityEvent("MAP_MOVE",[]));
      }
      
      public function mapMove(param1:int, param2:int) : void
      {
         this.dispatchEvent(new OuterCityEvent("MAP_MOVE",[]));
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _nineSliceScaling = null;
         _preNineSliceScaling = null;
         _noteUserFiles = null;
         _currentOuterCityConfig = null;
      }
   }
}

