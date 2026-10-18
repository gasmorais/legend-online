package yishi.utils
{
   import flash.external.ExternalInterface;
   
   public class JsHelper
   {
      
      private static var _isSelfAdapting:Boolean = true;
      
      private static var _preAdapting:Boolean;
      
      public function JsHelper()
      {
         super();
      }
      
      public static function setSelfAdapting() : void
      {
         if(ExternalInterface.available)
         {
            isSelfAdapting = true;
            ExternalInterface.call("setSelfAdapting");
         }
      }
      
      public static function setMinSize(param1:int = 1000, param2:int = 600) : void
      {
         if(ExternalInterface.available)
         {
            isSelfAdapting = false;
            ExternalInterface.call("setMinSize",param1,param2);
         }
      }
      
      public static function set isSelfAdapting(param1:Boolean) : void
      {
         _preAdapting = _isSelfAdapting;
         _isSelfAdapting = param1;
         if(ExternalInterface.available)
         {
            ExternalInterface.call("isSelfAdapting",_isSelfAdapting);
         }
      }
      
      public static function get isSelfAdapting() : Boolean
      {
         return _isSelfAdapting;
      }
      
      public static function setEnterRoomScaleModel() : void
      {
         setMinSize();
      }
      
      public static function setLeaveRoomScaleModel() : void
      {
         isSelfAdapting = _preAdapting;
         if(ExternalInterface.available)
         {
            ExternalInterface.call("setSelfAdapting");
         }
      }
      
      public static function setCurrentScene(param1:int) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("setCurrentScene",param1);
         }
      }
   }
}

