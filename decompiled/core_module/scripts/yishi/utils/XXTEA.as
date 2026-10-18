package yishi.utils
{
   public class XXTEA
   {
      
      public function XXTEA()
      {
         super();
         throw new Error("XXTEA class is static container only");
      }
      
      private static function long2str(param1:Array, param2:Boolean) : String
      {
         var _loc5_:* = 0;
         var _loc3_:uint = param1.length;
         var _loc4_:int = param1[_loc3_ - 1] & 0xFFFFFFFF;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            param1[_loc5_] = String.fromCharCode(param1[_loc5_] & 0xFF,param1[_loc5_] >>> 8 & 0xFF,param1[_loc5_] >>> 16 & 0xFF,param1[_loc5_] >>> 24 & 0xFF);
            _loc5_++;
         }
         if(param2)
         {
            return param1.join("").substring(0,_loc4_);
         }
         return param1.join("");
      }
      
      private static function str2long(param1:String, param2:Boolean) : Array
      {
         var _loc5_:* = 0;
         var _loc3_:uint = uint(param1.length);
         var _loc4_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_[_loc5_ >> 2] = param1.charCodeAt(_loc5_) | param1.charCodeAt(_loc5_ + 1) << 8 | param1.charCodeAt(_loc5_ + 2) << 16 | param1.charCodeAt(_loc5_ + 3) << 24;
            _loc5_ += 4;
         }
         if(param2)
         {
            _loc4_[_loc4_.length] = _loc3_;
         }
         return _loc4_;
      }
      
      public static function encrypt(param1:String, param2:String) : String
      {
         var _loc7_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc9_:* = 0;
         if(param1 == "")
         {
            return "";
         }
         var _loc11_:Array = str2long(StringUtil.utf16to8(param1),true);
         var _loc6_:Array = str2long(param2,false);
         var _loc8_:uint = _loc11_.length - 1;
         var _loc13_:Number = Number(_loc11_[_loc8_]);
         var _loc12_:Number = Number(_loc11_[0]);
         var _loc4_:Number = 2654435769;
         var _loc10_:Number = Math.floor(6 + 52 / (_loc8_ + 1));
         var _loc5_:Number = 0;
         while(_loc10_-- > 0)
         {
            _loc5_ = _loc5_ + _loc4_ & 0xFFFFFFFF;
            _loc3_ = _loc5_ >>> 2 & 3;
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc12_ = Number(_loc11_[_loc9_ + 1]);
               _loc7_ = (_loc13_ >>> 5 ^ _loc12_ << 2) + (_loc12_ >>> 3 ^ _loc13_ << 4) ^ (_loc5_ ^ _loc12_) + (_loc6_[_loc9_ & 3 ^ _loc3_] ^ _loc13_);
               _loc13_ = Number(_loc11_[_loc9_] = _loc11_[_loc9_] + _loc7_ & 0xFFFFFFFF);
               _loc9_++;
            }
            _loc12_ = Number(_loc11_[0]);
            _loc7_ = (_loc13_ >>> 5 ^ _loc12_ << 2) + (_loc12_ >>> 3 ^ _loc13_ << 4) ^ (_loc5_ ^ _loc12_) + (_loc6_[_loc9_ & 3 ^ _loc3_] ^ _loc13_);
            _loc13_ = Number(_loc11_[_loc8_] = _loc11_[_loc8_] + _loc7_ & 0xFFFFFFFF);
         }
         return long2str(_loc11_,false);
      }
      
      public static function decrypt(param1:String, param2:String) : String
      {
         var _loc7_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc9_:* = 0;
         if(param1 == "")
         {
            return "";
         }
         var _loc11_:Array = str2long(param1,false);
         var _loc6_:Array = str2long(param2,false);
         var _loc8_:uint = _loc11_.length - 1;
         var _loc13_:Number = Number(_loc11_[_loc8_ - 1]);
         var _loc12_:Number = Number(_loc11_[0]);
         var _loc4_:Number = 2654435769;
         var _loc10_:Number = Math.floor(6 + 52 / (_loc8_ + 1));
         var _loc5_:Number = _loc10_ * _loc4_ & 0xFFFFFFFF;
         while(_loc5_ != 0)
         {
            _loc3_ = _loc5_ >>> 2 & 3;
            _loc9_ = _loc8_;
            while(_loc9_ > 0)
            {
               _loc13_ = Number(_loc11_[_loc9_ - 1]);
               _loc7_ = (_loc13_ >>> 5 ^ _loc12_ << 2) + (_loc12_ >>> 3 ^ _loc13_ << 4) ^ (_loc5_ ^ _loc12_) + (_loc6_[_loc9_ & 3 ^ _loc3_] ^ _loc13_);
               _loc12_ = Number(_loc11_[_loc9_] = _loc11_[_loc9_] - _loc7_ & 0xFFFFFFFF);
               _loc9_--;
            }
            _loc13_ = Number(_loc11_[_loc8_]);
            _loc7_ = (_loc13_ >>> 5 ^ _loc12_ << 2) + (_loc12_ >>> 3 ^ _loc13_ << 4) ^ (_loc5_ ^ _loc12_) + (_loc6_[_loc9_ & 3 ^ _loc3_] ^ _loc13_);
            _loc12_ = Number(_loc11_[0] = _loc11_[0] - _loc7_ & 0xFFFFFFFF);
            _loc5_ = _loc5_ - _loc4_ & 0xFFFFFFFF;
         }
         return StringUtil.utf8to16(long2str(_loc11_,true));
      }
   }
}

