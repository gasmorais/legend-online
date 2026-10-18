package yishi.utils
{
   public class CertiCodeHelper
   {
      
      public function CertiCodeHelper()
      {
         super();
      }
      
      public static function getChecksum17(param1:String) : String
      {
         var _loc3_:Array = null;
         var _loc5_:* = 0;
         var _loc4_:int = 0;
         var _loc2_:* = 0;
         if(param1.length == 17)
         {
            _loc3_ = param1.split("").reverse();
            _loc5_ = 0;
            _loc4_ = 0;
            while(_loc4_ < 17)
            {
               _loc5_ += _loc3_[_loc4_] * getW(_loc4_ + 2);
               _loc4_++;
            }
            _loc2_ = uint((12 - _loc5_ % 11) % 11);
            return String(_loc2_ == 10 ? "x" : _loc2_);
         }
         return "";
      }
      
      public static function getW(param1:int) : uint
      {
         return Math.pow(2,param1 - 1) % 11;
      }
      
      public static function checkCertiCode(param1:String) : Boolean
      {
         if(param1.length < 15 || param1.length != 18 && param1.length > 15)
         {
            return false;
         }
         if(param1.length == 15)
         {
            param1 = id15UpgradeToID17(param1,"19");
            param1 += getChecksum17(param1.substring(0,17));
         }
         if(getChecksum17(param1.substring(0,17)) == param1.substring(17,18).toLocaleLowerCase())
         {
            return true;
         }
         return false;
      }
      
      public static function id15UpgradeToID17(param1:String, param2:String) : String
      {
         if(param1.length == 15)
         {
            return param1.substring(0,6) + param2 + param1.substr(6,15);
         }
         return null;
      }
      
      public static function checkCertiCode1(param1:String) : int
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:String = null;
         if(param1 == null || param1.length != 15 && param1.length != 18)
         {
            return 1;
         }
         if(param1.length == 15)
         {
            if(!checkFigure(param1))
            {
               return 5;
            }
            _loc3_ = "19" + param1.substring(6,10);
            _loc4_ = param1.substring(8,10);
            _loc2_ = param1.substring(10,12);
            if(!checkDate(_loc3_,_loc4_,_loc2_))
            {
               return 2;
            }
         }
         if(param1.length == 18)
         {
            if(!checkFigure(param1.substring(0,17)))
            {
               return 5;
            }
            _loc3_ = param1.substring(6,10);
            _loc4_ = param1.substring(10,12);
            _loc2_ = param1.substring(12,14);
            if(!checkDate(_loc3_,_loc4_,_loc2_))
            {
               return 2;
            }
            if(!checkIDParityBit(param1))
            {
               return 3;
            }
         }
         return 0;
      }
      
      private static function checkFigure(param1:String) : Boolean
      {
         return true;
      }
      
      private static function checkDate(param1:String, param2:String, param3:String) : Boolean
      {
         return true;
      }
      
      private static function checkIDParityBit(param1:String) : Boolean
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:String = null;
         var _loc6_:int = 0;
         var _loc2_:Boolean = false;
         if(StringHelper.isNullOrEmpty(param1))
         {
            return false;
         }
         var _loc4_:Array = [7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2,1];
         if(param1.length == 18)
         {
            _loc5_ = 0;
            _loc7_ = 0;
            while(_loc7_ < 18)
            {
               _loc3_ = param1.charAt(_loc7_);
               _loc6_ = 0;
               if(_loc3_ == "X")
               {
                  _loc6_ = 10;
               }
               else
               {
                  if(!(_loc3_ <= "9" || _loc3_ >= "0"))
                  {
                     return _loc2_;
                  }
                  _loc6_ = int(_loc3_) - 48;
               }
               _loc5_ += _loc6_ * _loc4_[_loc7_];
               _loc7_++;
            }
            if(_loc5_ % 11 == 1)
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
   }
}

