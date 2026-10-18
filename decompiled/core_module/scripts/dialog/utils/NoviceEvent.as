package dialog.utils
{
   import flash.events.Event;
   
   public class NoviceEvent extends Event
   {
      
      public static const TUTORIAL_COMPLETE:String = "tutorialComplete";
      
      public static const NODE_COMPLETE:String = "nodeComplete";
      
      private var _args:Array;
      
      public function NoviceEvent(param1:String, ... rest)
      {
         _args = rest;
         super(param1);
      }
      
      public function get args() : Array
      {
         return _args;
      }
   }
}

