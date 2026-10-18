package battle.utils
{
   import com.netease.protobuf.Int64;
   
   public class Int64Utils
   {
      
      public function Int64Utils()
      {
         super();
      }
      
      public static function int64ToNumber(param1:Int64) : Number
      {
         var _loc2_:Number = param1.high;
         _loc2_ *= 256;
         _loc2_ *= 256;
         _loc2_ *= 256;
         _loc2_ *= 256;
         return _loc2_ + param1.low;
      }
      
      public static function numberToInt64(param1:Number) : Int64
      {
         var _loc2_:Number = 1;
         _loc2_ *= 256;
         _loc2_ *= 256;
         _loc2_ *= 256;
         _loc2_ *= 256;
         return new Int64(param1,Math.floor(param1 / _loc2_));
      }
   }
}

