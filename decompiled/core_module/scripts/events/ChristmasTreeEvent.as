package events
{
   import flash.events.Event;
   
   public class ChristmasTreeEvent extends Event
   {
      
      public static const CT_UPDATE_REWARDS_INFO:String = "CT_UPDATE_REWARDS_INFO";
      
      public static const CT_UPDATE_LUCK_SHOW_INFO:String = "CT_UPDATE_LUCK_SHOW_INFO";
      
      public static const CT__UPDATE_BOX_STATUS:String = "CT__UPDATE_BOX_STATUS";
      
      public static const CT__PLAYER_BOX_GOODS:String = "CT__PLAYER_BOX_GOODS";
      
      public static const CT__ADD_INTERGAL:String = "CT__ADD_INTERGAL";
      
      public static const CT__RARE_GOODS:String = "CT__RARE_GOODS";
      
      public var data:*;
      
      public function ChristmasTreeEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

