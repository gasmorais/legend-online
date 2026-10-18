package events
{
   import flash.events.Event;
   
   public class FriendMenuEvent extends Event
   {
      
      public static const MENU_SELECTED:String = "MENU_SELECTED";
      
      public function FriendMenuEvent(param1:String)
      {
         super(param1,false,false);
      }
   }
}

