package yishi.utils
{
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class StringHelper
   {
      
      private static const OFFSET:Number = 2000;
      
      private static var blankSpaceType:Array = [9,32,61656,59349,59350,59351,59352,59353,59354,59355,59355,59356,59357,59358,59359,59360,59361,59362,59363,59364,59365];
      
      private static const reg:RegExp = /[^\x00-\xff]{1,}/g;
      
      public static const _leftReg:RegExp = /</g;
      
      public static const _rightReg:RegExp = />/g;
      
      private static var idR1:RegExp = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
      
      private static var idR2:RegExp = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/;
      
      public function StringHelper()
      {
         super();
      }
      
      public static function checkStringLength(param1:String) : int
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeMultiByte(param1,"");
         return _loc2_.length;
      }
      
      public static function substr(param1:String, param2:int) : String
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc3_ = 0;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            if(param1.charCodeAt(_loc5_) >= 19968 && param1.charCodeAt(_loc5_) <= 40869)
            {
               _loc3_ += 2;
            }
            else if(param1.charCodeAt(_loc5_) >= 65281 && param1.charCodeAt(_loc5_) <= 65374)
            {
               _loc3_ += 2;
            }
            else if(param1.charCodeAt(_loc5_) == 3000)
            {
               _loc3_ += 2;
            }
            else
            {
               _loc3_ += 1;
            }
            if(_loc3_ >= param2)
            {
               _loc4_ = _loc5_ + 1;
               break;
            }
            _loc4_ = ++_loc5_;
         }
         return param1.substr(0,_loc4_);
      }
      
      public static function getSubStrBetweenTwoChar(param1:String, param2:String, param3:String) : String
      {
         if(param3 == null || param3 == "")
         {
            return "";
         }
         var _loc4_:int = param3.indexOf(param1);
         var _loc5_:int = param3.indexOf(param2);
         if(_loc4_ == -1 || _loc5_ == -1)
         {
            return "";
         }
         return param3.substring(_loc4_ + param1.length,_loc5_);
      }
      
      public static function getStringsBetweenTwoChar(param1:String, param2:String, param3:String) : Array
      {
         var _loc6_:String = null;
         var _loc8_:int = 0;
         var _loc5_:Array = null;
         var _loc9_:String = null;
         var _loc4_:Array = [];
         if(param1 == null || param1 == "")
         {
            return _loc4_;
         }
         var _loc7_:* = 0;
         while(_loc7_ != param1.length)
         {
            _loc6_ = param1.charAt(_loc7_);
            if(_loc6_ == param2)
            {
               _loc8_ = _loc7_ + 1;
               _loc5_ = [];
               while(param1.charAt(_loc8_) != param3 && _loc8_ < param1.length)
               {
                  if(param1.charAt(_loc8_) == param2)
                  {
                     break;
                  }
                  _loc8_++;
               }
               if(param1.charAt(_loc8_) == param3)
               {
                  _loc9_ = param1.substring(_loc7_ + 1,_loc8_);
                  _loc4_.push(_loc9_);
               }
               _loc7_ = _loc8_;
            }
            else
            {
               _loc7_++;
            }
         }
         return _loc4_;
      }
      
      public static function truncate(param1:String, param2:uint, param3:String = "...") : String
      {
         if(param1 == null)
         {
            return "";
         }
         if(param2 == 0)
         {
            param2 = uint(param1.length);
         }
         param2 -= param3.length;
         var _loc4_:String = param1;
         if(_loc4_.length > param2)
         {
            _loc4_ = _loc4_.substr(0,param2);
            _loc4_ = trimRight(_loc4_);
            _loc4_ = _loc4_ + param3;
         }
         return _loc4_;
      }
      
      public static function trimLeft(param1:String) : String
      {
         if(!param1)
         {
            return param1;
         }
         return param1.replace(/^\s*/g,"");
      }
      
      public static function trim(param1:String) : String
      {
         if(!param1)
         {
            return param1;
         }
         return param1.replace(/(^\s*)|(\s*$)/g,"");
      }
      
      public static function trimAll(param1:String) : String
      {
         var _loc3_:* = 0;
         var _loc2_:String = trim(param1);
         var _loc4_:String = "";
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(blankSpaceType.indexOf(_loc2_.charCodeAt(_loc3_)) <= -1)
            {
               _loc4_ += _loc2_.charAt(_loc3_);
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      public static function trimRight(param1:String) : String
      {
         return param1.replace(/\s*$/g,"");
      }
      
      public static function replaceStr(param1:String, param2:String, param3:String) : String
      {
         if(!param1)
         {
            return "";
         }
         return param1.split(param2).join(param3);
      }
      
      public static function isNullOrEmpty(param1:String) : Boolean
      {
         return param1 == null || param1 == "" || param1 + "" == "undefined";
      }
      
      public static function stringToPath(param1:String) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1.charCodeAt(_loc4_);
            _loc5_ = param1.charCodeAt(_loc4_ + 1);
            _loc2_.push(new Point(_loc3_ - 2000,_loc5_ - 2000));
            _loc4_ += 2;
         }
         return _loc2_;
      }
      
      public static function stringToPoint(param1:String) : Point
      {
         return new Point(param1.charCodeAt(0) - 2000,param1.charCodeAt(1) - 2000);
      }
      
      public static function pathToString(param1:Array) : String
      {
         var _loc2_:int = 0;
         if(param1 == null || param1.length <= 0)
         {
            return "";
         }
         var _loc3_:String = "";
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ += String.fromCharCode(Math.round(param1[_loc2_].x + 2000));
            _loc3_ += String.fromCharCode(Math.round(param1[_loc2_].y + 2000));
            _loc2_++;
         }
         return _loc3_;
      }
      
      public static function pointToString(param1:Point) : String
      {
         var _loc2_:String = "";
         _loc2_ += String.fromCharCode(Math.round(param1.x + 2000));
         return _loc2_ + String.fromCharCode(Math.round(param1.y + 2000));
      }
      
      public static function numberToString(param1:Number) : String
      {
         return String.fromCharCode(Math.round(param1 + 2000));
      }
      
      public static function stringToNumber(param1:String) : Number
      {
         return param1.charCodeAt(0) - 2000;
      }
      
      public static function getIsBiggerMaxCHchar(param1:String, param2:uint) : Boolean
      {
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTF(trim(param1));
         if(_loc3_.length > param2 * 3 + 2)
         {
            return true;
         }
         return false;
      }
      
      public static function getRandomNumber() : String
      {
         var _loc1_:uint = Math.round(Math.random() * 1000000);
         return _loc1_.toString();
      }
      
      public static function checkTextFieldLength(param1:TextField, param2:uint, param3:String = null) : void
      {
         var _loc5_:uint = uint(param1.text ? param1.text.match(reg).join("").length : 0);
         var _loc4_:uint = uint(param3 ? param3.match(reg).join("").length : 0);
         param1.maxChars = param2 > _loc5_ + _loc4_ ? param2 - _loc5_ - _loc4_ : (param2 > _loc4_ ? param2 - _loc4_ : param2 / 2);
      }
      
      public static function rePlaceHtmlTextField(param1:String) : String
      {
         param1 = param1.replace(_leftReg,"&lt;");
         return param1.replace(_rightReg,"&gt;");
      }
      
      public static function parseTime(param1:String, param2:uint) : String
      {
         var _loc3_:String = param1;
         var _loc5_:Date = new Date(Number(_loc3_.substr(0,4)),Number(_loc3_.substr(5,2)) - 1,Number(_loc3_.substr(8,2)));
         var _loc4_:Date = new Date();
         _loc4_.setTime(_loc5_.getTime() + (param2 + 1) * 24 * 60 * 60 * 1000);
         return String(_loc4_.getUTCFullYear()) + "-" + (_loc4_.getUTCMonth() + 1) + "-" + _loc4_.getUTCDate();
      }
      
      public static function cidCheck(param1:String) : Boolean
      {
         if(idR1.test(param1) || idR2.test(param1))
         {
            return true;
         }
         return false;
      }
      
      public static function removeHtmlTagByTextField(param1:String) : String
      {
         if(isNullOrEmpty(param1))
         {
            return "";
         }
         var _loc2_:TextField = new TextField();
         _loc2_.htmlText = param1;
         return _loc2_.text;
      }
      
      public static function toHtmlString(param1:String) : String
      {
         if(isNullOrEmpty(param1))
         {
            return "";
         }
         var _loc2_:TextField = new TextField();
         _loc2_.text = param1;
         return removeHtmlTag(_loc2_.htmlText);
      }
      
      public static function removeHtmlTag(param1:String) : String
      {
         if(isNullOrEmpty(param1))
         {
            return "";
         }
         return param1.replace(/<(\S*?)[^>]*>|<.*? \/>/g,"");
      }
      
      public static function getConvertedHtmlArray(param1:String) : Array
      {
         if(isNullOrEmpty(param1))
         {
            return null;
         }
         return param1.match(/&[a-z]*?;/g);
      }
      
      public static function replaceHtmlTag(param1:String) : String
      {
         return param1.replace(/<(\S*?)[^>]*>|<.*? \/>/g,"");
      }
      
      public static function replaceToHtmlText(param1:String) : String
      {
         var _loc2_:TextField = new TextField();
         _loc2_.text = param1;
         return replaceHtmlTag(_loc2_.htmlText);
      }
      
      public static function format(param1:String, ... rest) : String
      {
         var _loc3_:* = 0;
         if(rest == null || rest.length <= 0)
         {
            return param1;
         }
         _loc3_ = 0;
         while(_loc3_ < rest.length)
         {
            param1 = replaceStr(param1,"{" + _loc3_.toString() + "}",rest[_loc3_]);
            _loc3_++;
         }
         return param1;
      }
      
      public static function getConvertedLst(param1:String) : Array
      {
         return param1.match(/&[a-z]*?;/g);
      }
   }
}

