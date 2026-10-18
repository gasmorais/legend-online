package yishi.utils
{
   import flash.external.ExternalInterface;
   
   public class BrowserVersionUtils
   {
      
      public function BrowserVersionUtils()
      {
         super();
      }
      
      public static function getBrowser() : String
      {
         if(!ExternalInterface.available)
         {
            return "";
         }
         return ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
      }
      
      public static function getBrowserVersion(param1:Boolean = false) : String
      {
         if(!ExternalInterface.available)
         {
            return "";
         }
         var _loc2_:String = getBrowser();
         if(_loc2_ != null && _loc2_.indexOf("Firefox") >= 0)
         {
            return "Firefox";
         }
         if(_loc2_ != null && _loc2_.indexOf("Chrome") >= 0)
         {
            return "Chrome";
         }
         if(_loc2_ != null && _loc2_.indexOf("Safari") >= 0)
         {
            return "Safari";
         }
         if(_loc2_ != null && _loc2_.indexOf("MSIE") >= 0)
         {
            if(!param1)
            {
               return "MSIE";
            }
            if(_loc2_.indexOf("MSIE 8.0") >= 0)
            {
               return "MSIE 8.0";
            }
            if(_loc2_.indexOf("MSIE 6") >= 0)
            {
               return "MSIE 6.0";
            }
            if(_loc2_.indexOf("MSIE 9") >= 0)
            {
               return "MSIE 9.0";
            }
            if(_loc2_.indexOf("MSIE 7") >= 0)
            {
               return "MSIE 7.0";
            }
            return "MSIE";
         }
         if(_loc2_ != null && _loc2_.indexOf("Opera") >= 0)
         {
            return "Opera";
         }
         return "Unknow Browser";
      }
   }
}

