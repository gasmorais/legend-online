package bag
{
   import flash.events.EventDispatcher;
   import yishi.manager.SharedManager;
   
   public class BaseBagListModel extends EventDispatcher
   {
      
      private var _lastBagSortType:Number;
      
      public function BaseBagListModel()
      {
         super();
         _lastBagSortType = SharedManager.instance.lastBagSortType;
      }
      
      public function get lastBagSortType() : Number
      {
         return _lastBagSortType;
      }
      
      public function set lastBagSortType(param1:Number) : void
      {
         if(_lastBagSortType == param1)
         {
            return;
         }
         _lastBagSortType = param1;
         SharedManager.instance.lastBagSortType = _lastBagSortType;
         SharedManager.instance.saveLastBagSortType();
      }
   }
}

