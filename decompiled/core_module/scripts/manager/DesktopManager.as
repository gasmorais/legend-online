package manager
{
   import flash.external.ExternalInterface;
   
   public class DesktopManager
   {
      
      private static var _instance:DesktopManager;
      
      private var _desktopType:int;
      
      public function DesktopManager()
      {
         super();
      }
      
      public static function get Instance() : DesktopManager
      {
         if(_instance == null)
         {
            _instance = new DesktopManager();
         }
         return _instance;
      }
      
      public function checkIsDesktop() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("SetIsDesktop",SetIsDesktop);
            ExternalInterface.call("IsDesktop");
         }
      }
      
      public function set desktopType(param1:int) : void
      {
         _desktopType = param1;
      }
      
      private function SetIsDesktop() : void
      {
         _desktopType = 1;
      }
      
      public function get isDesktop() : Boolean
      {
         return _desktopType > 0;
      }
      
      public function get desktopType() : int
      {
         return _desktopType;
      }
      
      public function backToLogin() : void
      {
         ExternalInterface.call("WindowReturn");
      }
   }
}

