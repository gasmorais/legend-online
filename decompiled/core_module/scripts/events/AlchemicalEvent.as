package events
{
   import flash.events.Event;
   
   public class AlchemicalEvent extends Event
   {
      
      public static const SELECT_BTNTYPE_CHANGE:String = "SELECT_BTNTYPE_CHANGE";
      
      public static const SELECT_FORMULA_CHANGE:String = "SELECT_FORMULA_CHANGE";
      
      public static const ALCHEMICAL_MINE_UPDATE:String = "ALCHEMICAL_MINE_UPDATE";
      
      public static const ALCHEMICAL_ITEM_UPDATE:String = "ALCHEMICAL_ITEM_UPDATE";
      
      public static const ALCHEMICAL_FORMULA_UPDATE:String = "ALCHEMICAL_FORMULA_UPDATE";
      
      public static const ALCHEMICAL_SELFINFO_UPGATE:String = "ALCHEMICAL_SELFINFO_UPGATE";
      
      public static const SELECT_MODELTYPE_CHANGE:String = "SELECT_MODELTYPE_CHANGE";
      
      public static const FORMULA_LISTVIEW_UPDATE:String = "FORMULA_LISTVIEW_UPDATE";
      
      public function AlchemicalEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

