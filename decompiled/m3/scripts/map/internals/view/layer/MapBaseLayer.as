package map.internals.view.layer
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class MapBaseLayer extends Sprite
   {
      
      protected var _dict:Dictionary = new Dictionary();
      
      private var _tempKeys:Array = [];
      
      public function MapBaseLayer()
      {
         super();
      }
      
      public static function getFileName(param1:int, param2:int, param3:int = 1000, param4:int = 1000) : String
      {
         var _loc5_:int = Math.floor(param1 / param3);
         var _loc6_:int = Math.floor(param2 / param4);
         return _loc5_ + "," + _loc6_;
      }
      
      protected function get nineSliceScaling() : Array
      {
         throw new Error("override nineSliceScaling()");
      }
      
      protected function getOtherItmes() : Array
      {
         var _loc3_:String = null;
         var _loc2_:Array = [];
         var _loc1_:Array = nineSliceScaling;
         for(var _loc4_:String in _dict)
         {
            _tempKeys.push(_loc4_);
         }
         while(_tempKeys.length > 0)
         {
            _loc3_ = _tempKeys.pop();
            if(_loc1_.indexOf(_loc3_) == -1)
            {
               _loc2_ = _loc2_.concat(_dict[_loc3_] as Array);
               _dict[_loc3_] = null;
               delete _dict[_loc3_];
               deleteRectCall(_loc3_);
            }
         }
         return _loc2_;
      }
      
      protected function removeAllChild() : void
      {
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
      }
      
      protected function addDict(param1:DisplayObject) : void
      {
         var _loc3_:int = 0;
         var _loc4_:String = getFileName(param1.x,param1.y);
         var _loc2_:Array = _dict[_loc4_] as Array;
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(_loc2_[_loc3_] == param1)
               {
                  _loc2_.splice(_loc3_,1);
                  break;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc2_ = [];
         }
         _loc2_.push(param1);
         _dict[_loc4_] = _loc2_;
      }
      
      protected function removeDict(param1:DisplayObject) : void
      {
         var _loc3_:int = 0;
         var _loc4_:String = getFileName(param1.x,param1.y);
         var _loc2_:Array = _dict[_loc4_] as Array;
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(_loc2_[_loc3_] == param1)
               {
                  _loc2_.splice(_loc3_,1);
                  break;
               }
               _loc3_++;
            }
         }
         _dict[_loc4_] = _loc2_;
      }
      
      protected function removeItemByXY(param1:int, param2:int) : DisplayObject
      {
         var _loc4_:DisplayObject = null;
         var _loc5_:int = 0;
         var _loc6_:String = getFileName(param1,param2);
         var _loc3_:Array = _dict[_loc6_] as Array;
         if(_loc3_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               if(_loc3_[_loc5_].x == param1 && _loc3_[_loc5_].y == param2)
               {
                  _loc4_ = _loc3_[_loc5_];
                  _loc3_.splice(_loc5_,1);
                  break;
               }
               _loc5_++;
            }
         }
         return _loc4_;
      }
      
      public function getItemByXY(param1:int, param2:int) : DisplayObject
      {
         var _loc5_:String = getFileName(param1,param2);
         var _loc3_:Array = _dict[_loc5_] as Array;
         if(_loc3_)
         {
            for each(var _loc4_:DisplayObject in _loc3_)
            {
               if(_loc4_.x == param1 && _loc4_.y == param2)
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      protected function deleteRectCall(param1:String) : void
      {
      }
      
      protected function removeOtherItems() : void
      {
         throw new Error("override removeOtherItems()");
      }
      
      public function dispose() : void
      {
         _tempKeys = [];
      }
   }
}

