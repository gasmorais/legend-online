package yishi.utils
{
   import flash.utils.ByteArray;
   
   public class StringUtil
   {
      
      public function StringUtil()
      {
         super();
      }
      
      public static function urlencodeGB2312(param1:String) : String
      {
         var _loc4_:int = 0;
         var _loc2_:String = "";
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeMultiByte(param1,"gb2312");
         while(_loc4_ < _loc3_.length)
         {
            _loc2_ += escape(String.fromCharCode(_loc3_[_loc4_]));
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function equalsIgnoreCase(param1:String, param2:String) : Boolean
      {
         return param1.toLowerCase() == param2.toLowerCase();
      }
      
      public static function equals(param1:String, param2:String) : Boolean
      {
         return param1 == param2;
      }
      
      public static function isEmail(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = trim(param1);
         var _loc3_:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
         var _loc2_:Object = _loc3_.exec(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function isNumber(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return !isNaN(Number(param1));
      }
      
      public static function isDouble(param1:String) : Boolean
      {
         param1 = trim(param1);
         var _loc3_:RegExp = /^[-\+]?\d+(\.\d+)?$/;
         var _loc2_:Object = _loc3_.exec(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function isInteger(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = trim(param1);
         var _loc3_:RegExp = /^[-\+]?\d+$/;
         var _loc2_:Object = _loc3_.exec(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function isEnglish(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = trim(param1);
         var _loc3_:RegExp = /^[A-Za-z]+$/;
         var _loc2_:Object = _loc3_.exec(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function isChinese(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = trim(param1);
         var _loc3_:RegExp = /^[Α-￥]+$/;
         var _loc2_:Object = _loc3_.exec(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function isDoubleChar(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = trim(param1);
         var _loc3_:RegExp = /^[^\x00-\xff]+$/;
         var _loc2_:Object = _loc3_.exec(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function hasChineseChar(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = trim(param1);
         var _loc3_:RegExp = /[^\x00-\xff]/;
         var _loc2_:Object = _loc3_.exec(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function hasAccountChar(param1:String, param2:uint = 15) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(param2 < 10)
         {
            param2 = 15;
         }
         param1 = trim(param1);
         var _loc4_:RegExp = new RegExp("^[a-zA-Z0-9][a-zA-Z0-9_-]{0," + param2 + "}$","");
         var _loc3_:Object = _loc4_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function isURL(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = trim(param1).toLowerCase();
         var _loc3_:RegExp = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
         var _loc2_:Object = _loc3_.exec(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function isWhitespace(param1:String) : Boolean
      {
         switch(param1)
         {
            case " ":
            case "\t":
            case "\r":
            case "\n":
            case "\f":
               break;
            default:
               return false;
         }
         return true;
      }
      
      public static function trim(param1:String) : String
      {
         if(param1 == null)
         {
            return null;
         }
         return rtrim(ltrim(param1));
      }
      
      public static function ltrim(param1:String) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:RegExp = /^\s*/;
         return param1.replace(_loc2_,"");
      }
      
      public static function rtrim(param1:String) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:RegExp = /\s*$/;
         return param1.replace(_loc2_,"");
      }
      
      public static function beginsWith(param1:String, param2:String) : Boolean
      {
         return param2 == param1.substring(0,param2.length);
      }
      
      public static function endsWith(param1:String, param2:String) : Boolean
      {
         return param2 == param1.substring(param1.length - param2.length);
      }
      
      public static function remove(param1:String, param2:String) : String
      {
         return replace(param1,param2,"");
      }
      
      public static function replace(param1:String, param2:String, param3:String) : String
      {
         return param1.split(param2).join(param3);
      }
      
      public static function utf16to8(param1:String) : String
      {
         var _loc4_:* = 0;
         var _loc2_:int = 0;
         var _loc5_:Array = [];
         var _loc3_:uint = uint(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1.charCodeAt(_loc4_);
            if(_loc2_ >= 1 && _loc2_ <= 127)
            {
               _loc5_[_loc4_] = param1.charAt(_loc4_);
            }
            else if(_loc2_ > 2047)
            {
               _loc5_[_loc4_] = String.fromCharCode(0xE0 | _loc2_ >> 12 & 0x0F,0x80 | _loc2_ >> 6 & 0x3F,0x80 | _loc2_ >> 0 & 0x3F);
            }
            else
            {
               _loc5_[_loc4_] = String.fromCharCode(0xC0 | _loc2_ >> 6 & 0x1F,0x80 | _loc2_ >> 0 & 0x3F);
            }
            _loc4_++;
         }
         return _loc5_.join("");
      }
      
      public static function substitute(param1:String, ... rest) : String
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:uint = uint(rest.length);
         if(_loc4_ == 1 && rest[0] is Array)
         {
            _loc3_ = rest[0] as Array;
            _loc4_ = _loc3_.length;
         }
         else
         {
            _loc3_ = rest;
         }
         param1 = param1.replace(/\\t/g,"\t");
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            param1 = param1.replace(new RegExp("\\{" + _loc5_ + "\\}","g"),_loc3_[_loc5_]);
            _loc5_++;
         }
         return param1;
      }
      
      public static function utf8to16(param1:String) : String
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:Array = [];
         var _loc3_:uint = uint(param1.length);
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1.charCodeAt(_loc4_++);
            switch(_loc2_ >> 4)
            {
               case 0:
               case 1:
               case 2:
               case 3:
               case 4:
               case 5:
               case 6:
               case 7:
                  _loc6_[_loc6_.length] = param1.charAt(_loc4_ - 1);
                  break;
               case 12:
               case 13:
                  _loc7_ = param1.charCodeAt(_loc4_++);
                  _loc6_[_loc6_.length] = String.fromCharCode((_loc2_ & 0x1F) << 6 | _loc7_ & 0x3F);
                  break;
               case 14:
                  _loc7_ = param1.charCodeAt(_loc4_++);
                  _loc5_ = param1.charCodeAt(_loc4_++);
                  _loc6_[_loc6_.length] = String.fromCharCode((_loc2_ & 0x0F) << 12 | (_loc7_ & 0x3F) << 6 | (_loc5_ & 0x3F) << 0);
            }
         }
         return _loc6_.join("");
      }
   }
}

