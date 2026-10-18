package battle.effect
{
   import flash.display.DisplayObject;
   
   public class TransSceneEffect2_4 extends TransSceneEffect2
   {
      
      private var _centerIndex:int;
      
      public function TransSceneEffect2_4(param1:Array, param2:int, param3:int, param4:int)
      {
         super(param1,param2,param3,param4);
         _centerIndex = Math.floor(_row * 0.5);
      }
      
      override protected function getCellsByIndex(param1:int) : Array
      {
         var _loc2_:Array = getCellsByIndex2(param1 * 2);
         return _loc2_.concat(getCellsByIndex2(param1 * 2 + 1));
      }
      
      private function getCellsByIndex2(param1:int) : Array
      {
         var _loc5_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc2_:Array = [];
         var _loc6_:int = _centerIndex;
         var _loc4_:int = param1;
         while(true)
         {
            _loc6_ = _centerIndex - _loc5_;
            _loc4_ = param1 - _loc5_;
            if(isExit(_loc6_,_loc4_))
            {
               _loc3_ = _cells[_loc6_ * _col + _loc4_];
               _loc2_.push(_loc3_);
            }
            if(_loc5_ > 0)
            {
               _loc6_ = _centerIndex + _loc5_;
               if(isExit(_loc6_,_loc4_))
               {
                  _loc3_ = _cells[_loc6_ * _col + _loc4_];
                  _loc2_.push(_loc3_);
               }
               else if(_loc6_ >= _row)
               {
                  break;
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function isExit(param1:int, param2:int) : Boolean
      {
         if(param1 > -1 && param2 > -1 && param1 < _row && param2 < _col)
         {
            return true;
         }
         return false;
      }
   }
}

