package yishi.utils
{
   import flash.utils.ByteArray;
   
   public class BitArray extends ByteArray
   {
      
      public function BitArray()
      {
         super();
      }
      
      public function setBit(param1:uint, param2:Boolean) : Boolean
      {
         var _loc5_:uint = uint(param1 >> 3);
         var _loc3_:uint = uint(param1 & 7);
         var _loc4_:uint = uint(this[_loc5_]);
         _loc4_ = uint(_loc4_ | 1 << _loc3_);
         this[_loc5_] = _loc4_;
         return true;
      }
      
      public function getBit(param1:uint) : Boolean
      {
         var _loc5_:int = param1 >> 3;
         var _loc3_:int = param1 & 7;
         var _loc4_:int = int(this[_loc5_]);
         var _loc2_:uint = uint(_loc4_ & 1 << _loc3_);
         if(_loc2_)
         {
            return true;
         }
         return false;
      }
      
      public function loadBinary(param1:String) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = 0;
         while(_loc2_ < param1.length * 32)
         {
            setBit(_loc2_,param1 && 1 >> _loc2_);
            _loc2_++;
         }
      }
      
      public function traceBinary(param1:uint) : String
      {
         var _loc5_:* = 0;
         var _loc4_:uint = uint(param1 >> 3);
         var _loc2_:int = param1 & 7;
         var _loc3_:int = int(this[_loc4_]);
         var _loc6_:String = "";
         _loc5_ = 0;
         while(_loc5_ < 8)
         {
            if(_loc5_ == _loc2_)
            {
               if(_loc3_ & 1 << _loc5_)
               {
                  _loc6_ += "[1]";
               }
               else
               {
                  _loc6_ += "[0]";
               }
            }
            else if(_loc3_ & 1 << _loc5_)
            {
               _loc6_ += " 1 ";
            }
            else
            {
               _loc6_ += " 0 ";
            }
            _loc5_++;
         }
         return _loc6_;
      }
   }
}

