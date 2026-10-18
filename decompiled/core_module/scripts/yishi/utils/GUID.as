package yishi.utils
{
   import flash.system.Capabilities;
   
   public class GUID
   {
      
      private static var counter:Number = 0;
      
      public function GUID()
      {
         super();
      }
      
      public function create() : String
      {
         var _loc2_:Number = new Date().getTime();
         var _loc1_:Number = Math.random() * 1.7976931348623157e+308;
         var _loc3_:String = Capabilities.serverString;
         return calculate(_loc2_ + _loc3_ + _loc1_ + counter++);
      }
      
      public function calculate(param1:String) : String
      {
         return hex_sha1(param1);
      }
      
      private function hex_sha1(param1:String) : String
      {
         return binb2hex(core_sha1(str2binb(param1),param1.length * 8));
      }
      
      private function core_sha1(param1:Array, param2:Number) : Array
      {
         var _loc9_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc15_:Number = NaN;
         param1[param2 >> 5] |= 128 << 24 - param2 % 32;
         param1[(param2 + 64 >> 9 << 4) + 15] = param2;
         var _loc16_:Array = new Array(80);
         var _loc3_:Number = 1732584193;
         var _loc4_:Number = -271733879;
         var _loc5_:Number = -1732584194;
         var _loc6_:Number = 271733878;
         var _loc7_:Number = -1009589776;
         _loc9_ = 0;
         while(_loc9_ < param1.length)
         {
            _loc13_ = _loc3_;
            var _loc14_:Number = _loc4_;
            _loc8_ = _loc5_;
            var _loc10_:Number = _loc6_;
            var _loc11_:Number = _loc7_;
            _loc12_ = 0;
            while(_loc12_ < 80)
            {
               if(_loc12_ < 16)
               {
                  _loc16_[_loc12_] = param1[_loc9_ + _loc12_];
               }
               else
               {
                  _loc16_[_loc12_] = rol(_loc16_[_loc12_ - 3] ^ _loc16_[_loc12_ - 8] ^ _loc16_[_loc12_ - 14] ^ _loc16_[_loc12_ - 16],1);
               }
               _loc15_ = safe_add(safe_add(rol(_loc3_,5),sha1_ft(_loc12_,_loc4_,_loc5_,_loc6_)),safe_add(safe_add(_loc7_,_loc16_[_loc12_]),sha1_kt(_loc12_)));
               _loc7_ = _loc6_;
               _loc6_ = _loc5_;
               _loc5_ = rol(_loc4_,30);
               _loc4_ = _loc3_;
               _loc3_ = _loc15_;
               _loc12_++;
            }
            _loc3_ = safe_add(_loc3_,_loc13_);
            _loc4_ = safe_add(_loc4_,_loc14_);
            _loc5_ = safe_add(_loc5_,_loc8_);
            _loc6_ = safe_add(_loc6_,_loc10_);
            _loc7_ = safe_add(_loc7_,_loc11_);
            _loc9_ += 16;
         }
         return new Array(_loc3_,_loc4_,_loc5_,_loc6_,_loc7_);
      }
      
      private function sha1_ft(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 < 20)
         {
            return param2 & param3 | ~param2 & param4;
         }
         if(param1 < 40)
         {
            return param2 ^ param3 ^ param4;
         }
         if(param1 < 60)
         {
            return param2 & param3 | param2 & param4 | param3 & param4;
         }
         return param2 ^ param3 ^ param4;
      }
      
      private function sha1_kt(param1:Number) : Number
      {
         return param1 < 20 ? 1518500249 : (param1 < 40 ? 1859775393 : (param1 < 60 ? -1894007588 : -899497514));
      }
      
      private function safe_add(param1:Number, param2:Number) : Number
      {
         var _loc4_:Number = (param1 & 0xFFFF) + (param2 & 0xFFFF);
         var _loc3_:Number = (param1 >> 16) + (param2 >> 16) + (_loc4_ >> 16);
         return _loc3_ << 16 | _loc4_ & 0xFFFF;
      }
      
      private function rol(param1:Number, param2:Number) : Number
      {
         return param1 << param2 | param1 >>> 32 - param2;
      }
      
      private function str2binb(param1:String) : Array
      {
         var _loc3_:Number = NaN;
         var _loc2_:Array = [];
         var _loc4_:Number = 255;
         _loc3_ = 0;
         while(_loc3_ < param1.length * 8)
         {
            var _loc5_:int = _loc3_ >> 5;
            var _loc6_:int = _loc2_[_loc5_] | (param1.charCodeAt(_loc3_ / 8) & _loc4_) << 24 - _loc3_ % 32;
            _loc2_[_loc5_] = _loc6_;
            _loc3_ += 8;
         }
         return _loc2_;
      }
      
      private function binb2hex(param1:Array) : String
      {
         var _loc4_:Number = NaN;
         var _loc2_:String = new String("");
         var _loc3_:String = new String("0123456789abcdef");
         _loc4_ = 0;
         while(_loc4_ < param1.length * 4)
         {
            _loc2_ += _loc3_.charAt(param1[_loc4_ >> 2] >> (3 - _loc4_ % 4) * 8 + 4 & 0x0F) + _loc3_.charAt(param1[_loc4_ >> 2] >> (3 - _loc4_ % 4) * 8 & 0x0F);
            _loc4_++;
         }
         return _loc2_;
      }
   }
}

