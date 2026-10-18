package bag
{
   public class BaseBagListManager
   {
      
      private static var _instance:BaseBagListManager;
      
      private var _model:BaseBagListModel;
      
      public function BaseBagListManager()
      {
         super();
         _model = new BaseBagListModel();
      }
      
      public static function get instance() : BaseBagListManager
      {
         if(!_instance)
         {
            _instance = new BaseBagListManager();
         }
         return _instance;
      }
      
      public function get model() : BaseBagListModel
      {
         return _model;
      }
   }
}

