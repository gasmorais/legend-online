package yishi.service.managers
{
   import yishi.service.services.ServicesAmf;
   
   public class ServicesManager
   {
      
      private static var _instance:ServicesManager;
      
      private var _amfService:ServicesAmf;
      
      public function ServicesManager()
      {
         super();
         _amfService = new ServicesAmf();
      }
      
      public static function get instance() : ServicesManager
      {
         if(!_instance)
         {
            _instance = new ServicesManager();
         }
         return _instance;
      }
      
      public function get amfService() : ServicesAmf
      {
         return _amfService;
      }
      
      public function setup(param1:String) : void
      {
         _amfService.endPoint = param1;
      }
   }
}

