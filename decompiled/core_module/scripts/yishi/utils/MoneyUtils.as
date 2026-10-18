package yishi.utils
{
   public class MoneyUtils
   {
      
      private static var NUM_ARR:Array;
      
      private static var UNITS_ARR:Array;
      
      public static const NUM_CN:Array = ["0","1","2","3","4","5","6","7","8","9"];
      
      public static const NUM_SIMPLE_CN:Array = ["0","1","2","3","4","5","6","7","8","9"];
      
      public static const DECIMAL_UNITS:Array = ["",""];
      
      public static const LEVELS:Array = ["","","",""];
      
      public static const UNITS:Array = ["千","百","拾"];
      
      public static const UNITS_SIMPLE:Array = ["","",""];
      
      public function MoneyUtils()
      {
         super();
      }
      
      public static function toCNUpper(param1:Number, param2:Boolean = false) : String
      {
         NUM_ARR = param2 ? NUM_SIMPLE_CN : NUM_CN;
         UNITS_ARR = param2 ? UNITS_SIMPLE : UNITS;
         if(param1 == 0)
         {
            return NUM_ARR[0];
         }
         var _loc6_:int = getUnitCount(param1);
         var _loc3_:String = param1.toFixed(2);
         var _loc5_:int = _loc3_.indexOf(".");
         var _loc8_:String = _loc5_ == -1 ? _loc3_ : _loc3_.substring(0,_loc5_);
         var _loc4_:String = _loc5_ == -1 ? "" : _loc3_.substring(_loc5_ + 1,_loc3_.length);
         if(_loc8_.length > 16)
         {
            throw new Error("数字太大，无法处理！");
         }
         return convertIntegerStr(_loc8_) + convertDecimalStr(_loc4_);
      }
      
      private static function convertIntegerStr(param1:String) : String
      {
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:String = null;
         var _loc7_:int = Math.floor(param1.length / 4);
         var _loc2_:int = param1.length % 4;
         var _loc4_:Array = [];
         if(_loc2_ > 0)
         {
            _loc4_.push(convertThousand(param1.substr(0,_loc2_),_loc7_));
         }
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc3_ = _loc2_ + _loc6_ * 4;
            _loc5_ = param1.substring(_loc3_,_loc3_ + 4);
            _loc4_.push(convertThousand(_loc5_,_loc7_ - _loc6_ - 1));
            _loc6_++;
         }
         return convertNodes(_loc4_);
      }
      
      private static function convertNodes(param1:Array) : String
      {
         var _loc5_:Boolean = false;
         var _loc4_:int = 0;
         var _loc3_:ThousandNode = null;
         var _loc2_:String = "";
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_] as ThousandNode;
            if(_loc5_ && _loc3_.desc.length > 0 || _loc3_.beforeZero && _loc3_.desc.length > 0 && _loc2_.length > 0)
            {
               _loc2_ += NUM_ARR[0];
            }
            _loc2_ += _loc3_.desc;
            if(_loc3_.afterZero && _loc4_ < param1.length - 1)
            {
               _loc5_ = true;
            }
            else if(_loc3_.desc.length > 0)
            {
               _loc5_ = false;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private static function convertThousand(param1:String, param2:int) : ThousandNode
      {
         var _loc9_:int = 0;
         var _loc3_:ThousandNode = new ThousandNode();
         var _loc5_:int = param1.length;
         _loc9_ = 0;
         while(_loc9_ < 4 - _loc5_)
         {
            param1 = "0" + param1;
            _loc9_++;
         }
         var _loc4_:int = int(param1.charAt(0));
         var _loc6_:int = int(param1.charAt(1));
         var _loc7_:int = int(param1.charAt(2));
         var _loc8_:int = int(param1.charAt(3));
         if(_loc4_ + _loc6_ + _loc7_ + _loc8_ == 0)
         {
            return _loc3_;
         }
         if(_loc4_ == 0)
         {
            _loc3_.beforeZero = true;
         }
         else
         {
            _loc3_.desc += NUM_ARR[_loc4_] + UNITS_ARR[0];
         }
         if(_loc6_ == 0 && _loc3_.desc != "" && _loc7_ + _loc8_ > 0)
         {
            _loc3_.desc += NUM_ARR[0];
         }
         else if(_loc6_ > 0)
         {
            _loc3_.desc += NUM_ARR[_loc6_] + UNITS_ARR[1];
         }
         if(_loc7_ == 0 && _loc3_.desc != "" && _loc8_ > 0)
         {
            _loc3_.desc += NUM_ARR[0];
         }
         else if(_loc7_ > 0)
         {
            _loc3_.desc += NUM_ARR[_loc7_] + UNITS_ARR[2];
         }
         if(_loc8_ == 0)
         {
            _loc3_.afterZero = true;
         }
         else if(_loc8_ > 0)
         {
            _loc3_.desc += NUM_ARR[_loc8_];
         }
         if(_loc3_.desc.length > 0)
         {
            _loc3_.desc += LEVELS[param2];
         }
         return _loc3_;
      }
      
      private static function convertDecimalStr(param1:String) : String
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:String = "";
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc4_ = int(param1.charAt(_loc2_));
            if(_loc4_ > 0)
            {
               _loc3_ += NUM_ARR[_loc4_] + DECIMAL_UNITS[_loc2_];
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public static function getUnitCount(param1:Number) : int
      {
         return Math.ceil(Math.log(param1) / 2.302585092994046);
      }
   }
}

class ThousandNode
{
   
   public var beforeZero:Boolean;
   
   public var afterZero:Boolean;
   
   public var desc:String = "";
   
   public function ThousandNode()
   {
      super();
   }
}
