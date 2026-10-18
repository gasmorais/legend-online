package bag.events
{
   import flash.events.Event;
   
   public class BagSortEvent extends Event
   {
      
      public static const BAG_SORT_SELECT:String = "BAG_SORT_SELECT";
      
      public static const BAG_SORT_CHANGE:String = "BAG_SORT_CHANGE";
      
      private var _sortByType:int;
      
      public function BagSortEvent(param1:String, param2:int)
      {
         super(param1,false,false);
         _sortByType = param2;
      }
      
      public function get sortByType() : int
      {
         return _sortByType;
      }
   }
}

