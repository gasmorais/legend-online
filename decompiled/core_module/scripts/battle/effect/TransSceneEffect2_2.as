package battle.effect
{
   import flash.display.DisplayObject;
   
   public class TransSceneEffect2_2 extends TransSceneEffect2
   {
      
      public function TransSceneEffect2_2(param1:Array, param2:int, param3:int, param4:int)
      {
         super(param1,param2,param3,param4);
      }
      
      override protected function getCellsByIndex(param1:int) : Array
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         if(param1 >= _row)
         {
            return null;
         }
         _loc4_ = 0;
         while(_loc4_ < _col)
         {
            _loc3_ = _cells[param1 * _col + _loc4_];
            _loc2_.push(_loc3_);
            _loc4_++;
         }
         return _loc2_;
      }
   }
}

