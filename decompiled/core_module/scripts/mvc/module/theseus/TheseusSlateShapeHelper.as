package mvc.module.theseus
{
   public class TheseusSlateShapeHelper
   {
      
      public function TheseusSlateShapeHelper()
      {
         super();
      }
      
      public static function getShapeInfo(param1:int) : TheseusSlateShapeInfo
      {
         return new TheseusSlateShapeInfo(param1);
      }
      
      public static function getRotatedGrid(param1:int, param2:int) : Array
      {
         var _loc3_:TheseusSlateShapeInfo = getShapeInfo(param1);
         if(!_loc3_)
         {
            return null;
         }
         return _loc3_.getRotatedGrid(param2);
      }
      
      public static function getRotatedSize(param1:int, param2:int) : Object
      {
         var _loc3_:TheseusSlateShapeInfo = getShapeInfo(param1);
         if(!_loc3_)
         {
            return {
               "width":0,
               "height":0
            };
         }
         return _loc3_.getRotatedSize(param2);
      }
      
      public static function canPlaceStone(param1:int, param2:int, param3:int, param4:int, param5:int) : Boolean
      {
         var _loc11_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Array = getRotatedGrid(param1,param2);
         if(!_loc9_)
         {
            return false;
         }
         var _loc7_:Object = getRotatedSize(param1,param2);
         var _loc10_:int = int(_loc7_.width);
         var _loc12_:int = int(_loc7_.height);
         if(param4 + _loc10_ > 5 || param3 + _loc12_ > 5)
         {
            return false;
         }
         _loc11_ = 0;
         loop0:
         while(_loc11_ < _loc12_)
         {
            _loc6_ = 0;
            while(true)
            {
               if(_loc6_ >= _loc10_)
               {
                  _loc11_++;
                  continue loop0;
               }
               if(_loc9_[_loc11_][_loc6_] == 1)
               {
                  _loc8_ = (param3 + _loc11_) * 5 + (param4 + _loc6_);
                  if((param5 >> _loc8_ & 1) == 0)
                  {
                     break;
                  }
               }
               _loc6_++;
            }
            return false;
         }
         return true;
      }
      
      public static function getOccupiedGrids(param1:int, param2:int, param3:int, param4:int) : Array
      {
         var _loc11_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Array = getRotatedGrid(param1,param2);
         if(!_loc8_)
         {
            return [];
         }
         var _loc9_:Array = [];
         var _loc6_:Object = getRotatedSize(param1,param2);
         var _loc12_:int = int(_loc6_.height);
         var _loc10_:int = int(_loc6_.width);
         _loc11_ = 0;
         while(_loc11_ < _loc12_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc10_)
            {
               if(_loc8_[_loc11_][_loc5_] == 1)
               {
                  _loc7_ = (param3 + _loc11_) * 5 + (param4 + _loc5_);
                  _loc9_.push(_loc7_);
               }
               _loc5_++;
            }
            _loc11_++;
         }
         return _loc9_;
      }
      
      public static function getStartIndex(param1:int, param2:int) : int
      {
         return param1 * 5 + param2;
      }
      
      public static function getTopLeftPosition(param1:int) : Object
      {
         return {
            "row":Math.floor(param1 / 5),
            "col":param1 % 5
         };
      }
   }
}

