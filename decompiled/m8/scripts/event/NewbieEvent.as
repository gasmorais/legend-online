package event
{
   import flash.events.Event;
   
   public class NewbieEvent extends Event
   {
      
      public static const NODE_COMPLETE:String = "nodeComplete";
      
      public static const TUTORIAL_COMPLETE:String = "tutorialComplete";
      
      public static const DIALOG_START:String = "dialogStart";
      
      public static const DIALOG_COMPLETE:String = "dialogComplete";
      
      public static const MAINTOOLBTN_COMPLETE:String = "maintoolbtnComplete";
      
      public static const NODE_LEVEUPDATE:String = "node_leveupdate";
      
      public static const SKIPNOVICE_COMPLETE:String = "skip_NoviceComplete";
      
      public static const SHOW_PHYSICS_MENU:String = "showPhysicsMenu";
      
      public static const BATTLE_EFFECT_COMPLETE:String = "battle_efffct_complete";
      
      public static const BATTLE_START:String = "battle_start";
      
      public static const NEW_NPC_OPEN_EVENT:String = "new_npc_open_event";
      
      private var _args:Array;
      
      public function NewbieEvent(param1:String, ... rest)
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

