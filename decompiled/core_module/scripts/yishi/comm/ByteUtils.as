package yishi.comm
{
   import flash.utils.ByteArray;
   
   public class ByteUtils
   {
      
      public function ByteUtils()
      {
         super();
      }
      
      public static function ToHexDump(param1:String, param2:ByteArray, param3:int, param4:int) : String
      {
         var _loc7_:int = 0;
         var _loc11_:String = null;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:String = "";
         if(param1 != null)
         {
            _loc6_ += param1;
            _loc6_ = _loc6_ + "\n";
         }
         var _loc8_:int = param3 + param4;
         _loc7_ = param3;
         while(_loc7_ < _loc8_)
         {
            _loc11_ = "";
            _loc9_ = "";
            _loc10_ = 0;
            while(_loc10_ < 16)
            {
               if(_loc10_ + _loc7_ < _loc8_)
               {
                  _loc5_ = Number(param2[_loc10_ + _loc7_]);
                  if(_loc5_ < 16)
                  {
                     _loc9_ += "0" + _loc5_.toString(16) + " ";
                  }
                  else
                  {
                     _loc9_ += _loc5_.toString(16) + " ";
                  }
                  if(_loc5_ >= 32 && _loc5_ <= 127)
                  {
                     _loc11_ += String.fromCharCode(_loc5_);
                  }
                  else
                  {
                     _loc11_ += ".";
                  }
               }
               else
               {
                  _loc9_ += "   ";
                  _loc11_ += " ";
               }
               _loc10_++;
            }
            _loc9_ += "  ";
            _loc9_ = _loc9_ + _loc11_;
            _loc9_ = _loc9_ + "\n";
            _loc6_ += _loc9_;
            _loc7_ += 16;
         }
         return _loc6_;
      }
   }
}

