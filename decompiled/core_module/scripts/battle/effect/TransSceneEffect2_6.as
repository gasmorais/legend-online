package battle.effect
{
   import flash.display.DisplayObject;
   
   public class TransSceneEffect2_6 extends TransSceneEffect2
   {
      
      private var _centerIndex:int;
      
      public function TransSceneEffect2_6(param1:Array, param2:int, param3:int, param4:int)
      {
         super(param1,param2,param3,param4);
         _centerIndex = Math.floor(_row * 0.5);
      }
      
      override protected function getCellsByIndex(param1:int) : Array
      {
         var _loc5_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         _loc5_ = _centerIndex - param1;
         if(_loc5_ > -1)
         {
            _loc4_ = 0;
            while(_loc4_ < _col)
            {
               _loc3_ = _cells[_loc5_ * _col + _loc4_];
               _loc2_.push(_loc3_);
               _loc4_++;
            }
         }
         if(param1 > 0)
         {
            _loc5_ = _centerIndex + param1;
            if(_loc5_ < _row)
            {
               _loc4_ = 0;
               while(_loc4_ < _col)
               {
                  _loc3_ = _cells[_loc5_ * _col + _loc4_];
                  _loc2_.push(_loc3_);
                  _loc4_++;
               }
            }
         }
         return _loc2_;
      }
   }
}

