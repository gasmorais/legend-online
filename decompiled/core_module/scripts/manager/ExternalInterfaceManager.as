package manager
{
   import com.pickgliss.utils.StringUtils;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Capabilities;
   import flash.system.Security;
   import flash.system.fscommand;
   
   public class ExternalInterfaceManager extends EventDispatcher
   {
      
      public static const SOUND_ON:String = "SOUND_ON";
      
      public static const SOUND_OFF:String = "SOUND_OFF";
      
      private static var _instance:ExternalInterfaceManager;
      
      public function ExternalInterfaceManager()
      {
         super();
      }
      
      public static function get instance() : ExternalInterfaceManager
      {
         if(!_instance)
         {
            _instance = new ExternalInterfaceManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("SetSoundOff",SetSoundOff);
            ExternalInterface.addCallback("SetSoundOn",SetSoundOn);
            ExternalInterface.addCallback("PopSetPanel",PopSetPanel);
         }
      }
      
      private function loadResource() : void
      {
      }
      
      public function initNews(param1:String) : void
      {
         var _loc3_:String = LanguageMgr.GetTranslation("manager.ExternalInterfaceManager.newsTitle");
         var _loc4_:String = LanguageMgr.GetTranslation("manager.ExternalInterfaceManager.newsContent" + param1);
         var _loc2_:String = _loc3_ + "|" + _loc4_;
         fscommand("initNews",_loc2_);
      }
      
      private function PopSetPanel() : void
      {
         Security.showSettings();
      }
      
      private function SetSoundOff() : void
      {
         dispatchEvent(new Event("SOUND_OFF"));
      }
      
      private function SetSoundOn() : void
      {
         dispatchEvent(new Event("SOUND_ON"));
      }
      
      public function syncDesktopTime(param1:Number) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("SyncDesktopTimer",String(param1));
         }
      }
      
      public function getBrowerType() : String
      {
         return ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
      }
      
      public function setSelfAdapting() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("setSelfAdapting");
         }
      }
      
      public function refreshWebSite() : void
      {
         var _loc1_:String = null;
         if(ExternalInterface.available)
         {
            _loc1_ = "function redict () {top.location.href=#}";
            ExternalInterface.call(_loc1_);
         }
      }
      
      public function isSafeFlash() : void
      {
         var _loc1_:Array = null;
         if(ExternalInterface.available)
         {
            _loc1_ = Capabilities.version.split(" ");
            ExternalInterface.call("isSafeFlash",_loc1_[1]);
         }
      }
      
      public function setExternalInfo(param1:String, param2:String) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("SetTitleText",param1);
            ExternalInterface.call("SetVerText",param2);
         }
      }
      
      public function returnHome() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("setAllowLeave");
         }
      }
      
      public function setFirstLeave(param1:String, param2:String) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("qihoo360.sendevent","playercreated",param1,param2);
            ExternalInterface.call("setFirstLeave");
         }
      }
      
      public function AASRegisterPath(param1:String) : void
      {
         var _loc2_:URLRequest = null;
         if(ExternalInterface.available)
         {
            _loc2_ = new URLRequest(param1);
            navigateToURL(_loc2_,"_blank");
         }
      }
      
      public function set360Event(param1:String, param2:String) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("qihoo360.sendevent","entergame",param1,param2);
         }
      }
      
      public function existGame(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:String = null;
         if(ExternalInterface.available)
         {
            if(DesktopManager.Instance.isDesktop)
            {
               ExternalInterface.call("ExitGameToLogin");
            }
            if(param3.indexOf("brazil") != -1 || param3.indexOf("broas") != -1 || param3.indexOf("337pt") != -1 || param3.indexOf("pt") != -1)
            {
               ExternalInterface.call("callInterruption",param2,param3);
               return;
            }
            _loc4_ = "function redict () {top.location.href=\"" + param1 + "\"}";
            ExternalInterface.call(_loc4_);
         }
      }
      
      public function navigateToStore(param1:String, param2:String) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("addfavorite",StringUtils.trim(param2),param1);
            ExternalInterface.call("addToFavorite","");
         }
      }
      
      public function leaveToLoginPath(param1:String) : void
      {
         var _loc2_:String = null;
         if(DesktopManager.Instance.isDesktop)
         {
            DesktopManager.Instance.backToLogin();
         }
         else if(ExternalInterface.available)
         {
            _loc2_ = "function redict () {top.location.href=\"" + param1 + "\"}";
            ExternalInterface.call(_loc2_);
         }
         else
         {
            navigateToURL(new URLRequest(param1),"_self");
         }
      }
      
      public function setFavorite(param1:String, param2:String) : void
      {
         if(ExternalInterface.available)
         {
            if(DesktopManager.Instance.isDesktop)
            {
               return;
            }
            ExternalInterface.call("addfavorite",param1,param2);
         }
      }
      
      public function printLogToJs(param1:String) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("traceLog",param1);
         }
      }
   }
}

