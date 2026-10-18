package battle.effect
{
   import flash.display.DisplayObject;
   
   public class TransSceneEffect2_1 extends TransSceneEffect2
   {
      
      public function TransSceneEffect2_1(param1:Array, param2:int, param3:int, param4:int)
      {
         super(param1,param2,param3,param4);
      }
      
      override protected function getCellsByIndex(param1:int) : Array
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         if(param1 >= _col)
         {
            return null;
         }
         _loc4_ = 0;
         while(_loc4_ < _row)
         {
            _loc3_ = _cells[_loc4_ * _col + _col - param1 - 1];
            _loc2_.push(_loc3_);
            _loc4_++;
         }
         return _loc2_;
      }
   }
}

