package yishi.utils
{
   import manager.LanguageMgr;
   import yishi.manager.PlayerManager;
   
   public final class DateFormatter
   {
      
      public static const DEFAULT_DATE:String = "2000-01-01 00:00:00";
      
      public function DateFormatter()
      {
         super();
      }
      
      public static function parse(param1:String, param2:String) : Date
      {
         var dateStr:String = param1;
         var formatStr:String = param2;
         var str:* = dateStr;
         str = escape(str);
         formatStr = escape(formatStr);
         var date:Date = new Date(1296000000);
         formatStr.replace(/([YMDhms])\1*/g,function(param1:*, param2:*, param3:*, param4:*):String
         {
            var _loc6_:String = param1 as String;
            var _loc7_:* = param3;
            var _loc5_:Number = parseInt(str.substr(_loc7_,_loc6_.length));
            switch(_loc6_.charAt())
            {
               case "Y":
                  date.fullYear = _loc5_;
                  break;
               case "M":
                  date.month = _loc5_ - 1;
                  break;
               case "D":
                  date.date = _loc5_;
                  break;
               case "h":
                  date.hours = _loc5_;
                  break;
               case "m":
                  date.minutes = _loc5_;
                  break;
               case "s":
                  date.seconds = _loc5_;
            }
            return "";
         });
         return date;
      }
      
      public static function getTimezoneOffsetDate(param1:Number) : Date
      {
         var _loc2_:Number = PlayerManager.instance.currentPlayerModel.sysSecond * 1000;
         var _loc3_:Date = new Date(_loc2_);
         var _loc4_:Number = _loc3_.getTimezoneOffset();
         var _loc5_:Number = _loc4_ * 60 * 1000;
         _loc3_.setTime(_loc3_.getTime() + _loc5_ + param1);
         return _loc3_;
      }
      
      public static function format(param1:Date, param2:String) : String
      {
         var str:String;
         var date:Date = param1;
         var formatStr:String = param2;
         if(!date)
         {
            return "";
         }
         str = formatStr.replace(/([YMDhms])\1*/g,function(param1:*, param2:*, param3:*, param4:*):String
         {
            var _loc6_:* = undefined;
            var _loc5_:String;
            switch((_loc5_ = param1 as String).charAt())
            {
               case "Y":
                  _loc6_ = getIntStrAtLength(date.getFullYear(),_loc5_.length);
                  break;
               case "M":
                  _loc6_ = getIntStrAtLength(date.getMonth() + 1,_loc5_.length);
                  break;
               case "D":
                  _loc6_ = getIntStrAtLength(date.getDate(),_loc5_.length);
                  break;
               case "h":
                  _loc6_ = getIntStrAtLength(date.getHours(),_loc5_.length);
                  break;
               case "m":
                  _loc6_ = getIntStrAtLength(date.getMinutes(),_loc5_.length);
                  break;
               case "s":
                  _loc6_ = getIntStrAtLength(date.getSeconds(),_loc5_.length);
            }
            return _loc6_;
         });
         return str;
      }
      
      public static function unix2ASDateString(param1:int) : String
      {
         var _loc2_:Date = new Date(param1 * 1000);
         return _loc2_.toDateString();
      }
      
      public static function unix2ASLocaleDateString(param1:int) : String
      {
         var _loc2_:Date = new Date(param1 * 1000);
         return _loc2_.toLocaleDateString();
      }
      
      public static function unix2ASString(param1:int) : String
      {
         var _loc2_:Date = new Date(param1 * 1000);
         return _loc2_.getFullYear() + "." + getIntStrAtLength(_loc2_.getMonth() + 1,2) + "." + getIntStrAtLength(_loc2_.getDate(),2) + "  " + getIntStrAtLength(_loc2_.getHours(),2) + ":" + getIntStrAtLength(_loc2_.getMinutes(),2) + ":" + getIntStrAtLength(_loc2_.getSeconds(),2);
      }
      
      public static function timeFormat1(param1:Date) : String
      {
         var _loc2_:String = "";
         _loc2_ += param1.getFullYear();
         _loc2_ += "-" + (param1.getMonth() + 1);
         _loc2_ += "-" + param1.getDate();
         _loc2_ += "  " + getIntStrAtLength(param1.getHours(),2);
         return _loc2_ + (":" + getIntStrAtLength(param1.getMinutes(),2));
      }
      
      public static function timeFormat2(param1:Date) : String
      {
         var _loc2_:String = "";
         _loc2_ += param1.getMonth() + 1;
         _loc2_ += "-" + param1.getDate();
         _loc2_ += "  " + getIntStrAtLength(param1.getHours(),2);
         return _loc2_ + (":" + getIntStrAtLength(param1.getMinutes(),2));
      }
      
      public static function timeFormat3(param1:Date) : String
      {
         var _loc2_:String = "";
         _loc2_ += param1.getFullYear();
         if(param1.getMonth() + 1 >= 10)
         {
            _loc2_ += "-" + (param1.getMonth() + 1);
         }
         else
         {
            _loc2_ += "-0" + (param1.getMonth() + 1);
         }
         if(param1.getDate().toString().length > 1)
         {
            _loc2_ += "-" + param1.getDate();
         }
         else
         {
            _loc2_ += "-0" + param1.getDate();
         }
         return _loc2_;
      }
      
      public static function timeFormat5(param1:Date) : String
      {
         var _loc2_:String = "";
         _loc2_ += getIntStrAtLength(param1.getHours(),2);
         return _loc2_ + (":" + getIntStrAtLength(param1.getMinutes(),2));
      }
      
      public static function getIntStrAtLength(param1:uint, param2:uint) : String
      {
         var _loc3_:String = param1.toString();
         if(param2 > 1)
         {
            if(_loc3_.length > param2)
            {
               _loc3_ = _loc3_.substr(-param2);
            }
            else
            {
               while(_loc3_.length < param2)
               {
                  _loc3_ = "0" + _loc3_;
               }
            }
         }
         return _loc3_;
      }
      
      public static function getCountDate(param1:int, param2:int = 2, param3:int = 3) : String
      {
         var _loc5_:String = null;
         var _loc4_:int = Math.floor(param1 / 3600);
         var _loc6_:int = Math.floor(param1 % 3600 / 60);
         var _loc7_:int = Math.floor(param1 % 3600 % 60);
         if(param3 == 3)
         {
            _loc5_ = getIntStrAtLength(_loc4_,param2);
            _loc5_ = _loc5_ + (":" + getIntStrAtLength(_loc6_,2));
            _loc5_ = _loc5_ + (":" + getIntStrAtLength(_loc7_,2));
         }
         else if(param3 == 2)
         {
            _loc5_ = getIntStrAtLength(_loc6_,2);
            _loc5_ = _loc5_ + (":" + getIntStrAtLength(_loc7_,2));
         }
         else if(param3 == 1)
         {
            _loc5_ = getIntStrAtLength(_loc4_,param2);
            _loc5_ = _loc5_ + (":" + getIntStrAtLength(_loc6_,2));
         }
         return _loc5_;
      }
      
      public static function getConsortiaCountDate(param1:int) : String
      {
         var _loc2_:int = Math.floor(param1 / 3600);
         var _loc4_:int = Math.floor(param1 % 3600 / 60);
         var _loc5_:int = Math.floor(param1 % 3600 % 60);
         var _loc3_:String = _loc2_.toString();
         while(_loc3_.length < 2)
         {
            _loc3_ = "0" + _loc3_;
         }
         _loc3_ += ":" + getIntStrAtLength(_loc4_,2);
         return _loc3_ + (":" + getIntStrAtLength(_loc5_,2));
      }
      
      public static function getCountDateByMS(param1:int) : String
      {
         var _loc3_:int = Math.floor(param1 / 60);
         var _loc4_:int = Math.floor(param1 % 60);
         var _loc2_:String = getIntStrAtLength(_loc3_,2);
         _loc2_ += ":" + getIntStrAtLength(_loc4_,2);
         if(param1 <= 0)
         {
            _loc2_ = "00:00";
         }
         return _loc2_;
      }
      
      public static function getSecondCountByMS(param1:String) : int
      {
         var _loc2_:Array = param1.split(":");
         return int(int(_loc2_[0]) * 60 + int(_loc2_[1]));
      }
      
      public static function getStopDateString(param1:Number) : String
      {
         var _loc4_:String = "";
         var _loc5_:Number = Math.floor(param1 / 86400);
         var _loc3_:int = (param1 - _loc5_ * 24 * 3600) / 3600;
         var _loc2_:int = (param1 - _loc5_ * 24 * 3600 - _loc3_ * 3600) / 60;
         if(_loc5_ > 0)
         {
            _loc4_ += _loc5_ + LanguageMgr.GetTranslation("public.day");
         }
         if(_loc3_ > 0)
         {
            _loc4_ += _loc3_ + LanguageMgr.GetTranslation("public.time.sigHour");
         }
         if(_loc2_ > 0 && _loc5_ <= 0)
         {
            _loc4_ += _loc2_ + LanguageMgr.GetTranslation("public.minute");
         }
         return _loc4_;
      }
      
      public static function getMonthDayString(param1:Number) : String
      {
         var _loc3_:String = "";
         if(param1 < 0)
         {
            return _loc3_;
         }
         var _loc2_:Date = new Date();
         _loc2_.time = param1;
         return _loc2_.month + 1 + LanguageMgr.GetTranslation("public.month") + _loc2_.date + LanguageMgr.GetTranslation("public.daily");
      }
      
      public static function getFullTimeString(param1:Number) : String
      {
         var _loc4_:String = "";
         if(param1 < 0)
         {
            return _loc4_;
         }
         var _loc5_:Number = Math.floor(param1 / 86400);
         var _loc3_:int = (param1 - _loc5_ * 24 * 3600) / 3600;
         var _loc2_:int = (param1 - _loc5_ * 24 * 3600 - _loc3_ * 3600) / 60;
         if(_loc5_ > 0)
         {
            _loc4_ += _loc5_ + LanguageMgr.GetTranslation("public.day");
         }
         if(_loc3_ > 0)
         {
            _loc4_ += _loc3_ + LanguageMgr.GetTranslation("public.time.hour");
         }
         if(_loc2_ > 0)
         {
            _loc4_ += _loc2_ + LanguageMgr.GetTranslation("yishi.utils.DateFormatter.timeStr.min");
         }
         return _loc4_;
      }
      
      public static function getFullDateString(param1:Number) : String
      {
         var _loc4_:String = "";
         if(param1 < 0)
         {
            return _loc4_;
         }
         var _loc5_:Number = Math.floor(param1 / 86400);
         var _loc3_:int = (param1 - _loc5_ * 24 * 3600) / 3600;
         var _loc2_:int = (param1 - _loc5_ * 24 * 3600 - _loc3_ * 3600) / 60;
         var _loc6_:int = param1 - _loc5_ * 24 * 3600 - _loc3_ * 3600 - _loc2_ * 60;
         if(_loc5_ > 0)
         {
            _loc4_ += _loc5_ + LanguageMgr.GetTranslation("public.day");
         }
         else if(_loc3_ > 0)
         {
            _loc4_ += _loc3_ + LanguageMgr.GetTranslation("public.time.hour");
         }
         else if(_loc2_ > 0)
         {
            _loc4_ += _loc2_ + LanguageMgr.GetTranslation("yishi.utils.DateFormatter.timeStr.min");
         }
         else if(_loc6_ > 0)
         {
            _loc4_ += _loc6_ + LanguageMgr.GetTranslation("public.time.second");
         }
         return _loc4_;
      }
      
      public static function getFullDateHtmlString(param1:Number, param2:String) : String
      {
         var _loc5_:String = "";
         if(param1 < 0)
         {
            return _loc5_;
         }
         var _loc6_:Number = Math.floor(param1 / 86400);
         var _loc4_:int = (param1 - _loc6_ * 24 * 3600) / 3600;
         var _loc3_:int = (param1 - _loc6_ * 24 * 3600 - _loc4_ * 3600) / 60;
         var _loc7_:int = param1 - _loc6_ * 24 * 3600 - _loc4_ * 3600 - _loc3_ * 60;
         if(_loc6_ >= 0)
         {
            _loc5_ += LanguageMgr.GetTranslation("public.time.colorFormat",param2,_loc6_) + LanguageMgr.GetTranslation("public.day");
         }
         if(_loc4_ >= 0)
         {
            _loc5_ += LanguageMgr.GetTranslation("public.time.colorFormat",param2,_loc4_) + LanguageMgr.GetTranslation("public.time.hour");
         }
         if(_loc3_ >= 0)
         {
            _loc5_ += LanguageMgr.GetTranslation("public.time.colorFormat",param2,_loc3_) + LanguageMgr.GetTranslation("yishi.utils.DateFormatter.timeStr.min");
         }
         if(_loc7_ >= 0)
         {
            _loc5_ += LanguageMgr.GetTranslation("public.time.colorFormat",param2,_loc7_) + LanguageMgr.GetTranslation("public.time.second");
         }
         return _loc5_;
      }
      
      public static function getDefaultFullDateString(param1:Number) : String
      {
         var _loc4_:String = "";
         if(param1 < 0)
         {
            return _loc4_;
         }
         var _loc5_:Number = Math.floor(param1 / 86400);
         var _loc3_:int = (param1 - _loc5_ * 24 * 3600) / 3600;
         var _loc2_:int = (param1 - _loc5_ * 24 * 3600 - _loc3_ * 3600) / 60;
         var _loc6_:int = param1 - _loc5_ * 24 * 3600 - _loc3_ * 3600 - _loc2_ * 60;
         if(_loc5_ > 0)
         {
            _loc4_ += _loc5_ + LanguageMgr.GetTranslation("public.day");
         }
         if(_loc3_ > 0)
         {
            _loc4_ += _loc3_ + LanguageMgr.GetTranslation("public.time.hour");
         }
         if(_loc2_ > 0)
         {
            _loc4_ += _loc2_ + LanguageMgr.GetTranslation("yishi.utils.DateFormatter.timeStr.min");
         }
         if(_loc6_ > 0)
         {
            _loc4_ += _loc6_ + LanguageMgr.GetTranslation("public.time.second");
         }
         return _loc4_;
      }
      
      public static function getUTCTimeStamp(param1:String, param2:String) : Number
      {
         var timeStr:String = param1;
         var formatStr:String = param2;
         var year:int = 0;
         var month:int = 0;
         var date:int = 0;
         var hours:int = 0;
         var min:int = 0;
         var sed:int = 0;
         var str:* = timeStr;
         str = escape(str);
         formatStr = escape(formatStr);
         formatStr.replace(/([YMDhms])\1*/g,function(param1:*, param2:*, param3:*, param4:*):void
         {
            var _loc6_:String = param1 as String;
            var _loc7_:* = param3;
            var _loc5_:Number = parseInt(str.substr(_loc7_,_loc6_.length));
            switch(_loc6_.charAt())
            {
               case "Y":
                  year = _loc5_;
                  break;
               case "M":
                  month = _loc5_ - 1;
                  break;
               case "D":
                  date = _loc5_;
                  break;
               case "h":
                  hours = _loc5_;
                  break;
               case "m":
                  min = _loc5_;
                  break;
               case "s":
                  sed = _loc5_;
            }
         });
         return Date.UTC(year,month,date,hours,min,sed,0);
      }
      
      public static function getMonthMaxDay(param1:int, param2:int) : int
      {
         switch(param1)
         {
            case 0:
               return 31;
            case 1:
               if(param2 % 4 == 0)
               {
                  return 29;
               }
               return 28;
               break;
            case 2:
               return 31;
            case 3:
               return 30;
            case 4:
               return 31;
            case 5:
               return 30;
            case 6:
               return 31;
            case 7:
               return 31;
            case 8:
               return 30;
            case 9:
               return 31;
            case 10:
               return 30;
            case 11:
               return 31;
            default:
               return 0;
         }
      }
      
      public static function transDate(param1:Number) : String
      {
         var _loc2_:Date = new Date(param1 * 1000);
         var _loc5_:String = _loc2_.getMinutes() + "";
         if(_loc2_.getMinutes() < 10)
         {
            _loc5_ = "0" + _loc5_;
         }
         var _loc3_:String = _loc2_.date + "";
         if(_loc2_.date < 10)
         {
            _loc3_ = "0" + _loc3_;
         }
         var _loc4_:String = _loc2_.getHours() + "";
         if(_loc2_.getHours() < 10)
         {
            _loc4_ = "0" + _loc4_;
         }
         return LanguageMgr.GetTranslation("public.dateType",_loc2_.fullYear,_loc2_.month + 1,_loc3_) + " " + _loc4_ + ":" + _loc5_;
      }
      
      public static function getSunday(param1:Date) : Date
      {
         var _loc2_:* = null;
         var _loc3_:Number = NaN;
         if(param1.day == 0)
         {
            _loc3_ = param1.time;
         }
         else
         {
            _loc3_ = param1.time + (7 - param1.day) * 24 * 3600 * 1000;
         }
         return new Date(_loc3_);
      }
      
      public static function getSundayZero(param1:Date) : Date
      {
         var _loc2_:* = null;
         var _loc3_:Number = NaN;
         var _loc4_:Date = new Date(param1.fullYear,param1.month,param1.date,0,0,0,0);
         if(_loc4_.day == 0)
         {
            _loc3_ = _loc4_.time;
         }
         else
         {
            _loc3_ = _loc4_.time + (7 - _loc4_.day) * 24 * 3600 * 1000;
         }
         return new Date(_loc3_);
      }
      
      public static function compareDay(param1:Date) : int
      {
         var _loc5_:Date = new Date(param1.fullYear,param1.month,param1.date,0,0,0,0);
         var _loc2_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc3_:Number = _loc2_.time;
         var _loc4_:Number = _loc5_.time;
         return int((_loc3_ - _loc4_) / 1000 / 60 / 60 / 24) + 1;
      }
      
      public static function compareDay2(param1:Date) : int
      {
         var _loc2_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc3_:Number = _loc2_.time;
         var _loc4_:Number = param1.time;
         return Math.ceil((_loc4_ - _loc3_) / 1000 / 60 / 60 / 24);
      }
      
      public static function compareDate(param1:Date, param2:Date) : Object
      {
         var _loc6_:Number = param1.time;
         var _loc7_:Number = param2.time;
         var _loc3_:Boolean = false;
         if(_loc7_ > _loc6_)
         {
            _loc3_ = true;
         }
         var _loc8_:int = (_loc7_ - _loc6_) / 1000 / 60 / 60 / 24;
         var _loc5_:int = (_loc7_ - _loc6_) / 1000 / 60 / 60;
         var _loc4_:int = (_loc7_ - _loc6_) / 1000 / 60;
         return {
            "flag":_loc3_,
            "day":_loc8_,
            "hour":_loc5_,
            "min":_loc4_
         };
      }
      
      public static function compareDate2(param1:Number, param2:Number) : Object
      {
         var _loc3_:Boolean = false;
         if(param2 > param1)
         {
            _loc3_ = true;
         }
         var _loc5_:int = (param2 - param1) / 1000 / 60 / 60 / 24;
         var _loc4_:int = (param2 - param1) / 1000 / 60 / 60;
         return {
            "flag":_loc3_,
            "day":_loc5_,
            "hour":_loc4_
         };
      }
      
      public static function timeFormat4(param1:Date) : String
      {
         var _loc2_:String = "";
         _loc2_ += param1.getFullYear();
         if(param1.getMonth() + 1 >= 10)
         {
            _loc2_ += "-" + (param1.getMonth() + 1);
         }
         else
         {
            _loc2_ += "-0" + (param1.getMonth() + 1);
         }
         if(param1.getDate().toString().length > 1)
         {
            _loc2_ += "-" + param1.getDate();
         }
         else
         {
            _loc2_ += "-0" + param1.getDate();
         }
         _loc2_ += " " + getIntStrAtLength(param1.getHours(),2);
         _loc2_ += ":" + getIntStrAtLength(param1.getMinutes(),2);
         return _loc2_ + (":" + getIntStrAtLength(param1.getSeconds(),2));
      }
      
      public static function checkIsSameDay(param1:Date, param2:Date) : Boolean
      {
         if(param1.fullYear == param2.fullYear && param1.month == param2.month && param1.date == param2.date)
         {
            return true;
         }
         return false;
      }
      
      public static function compareDate4(param1:Date, param2:Date) : Object
      {
         var _loc7_:Number = param1.time;
         var _loc8_:Number = param2.time;
         var _loc4_:Boolean = false;
         if(_loc8_ > _loc7_)
         {
            _loc4_ = true;
         }
         var _loc10_:int = (_loc8_ - _loc7_) / 1000;
         var _loc9_:int = _loc10_ / 60;
         var _loc11_:int = _loc9_ / 60;
         var _loc3_:int = _loc10_ % 60;
         var _loc5_:int = _loc9_ % 60;
         var _loc6_:int = _loc11_;
         return {
            "flag":_loc4_,
            "hour":_loc6_,
            "min":_loc5_,
            "sec":_loc3_
         };
      }
   }
}

