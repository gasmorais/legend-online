package events
{
   import flash.events.Event;
   
   public class GodsEveningEvent extends Event
   {
      
      public static const MAIN_FRAME_INFO:String = "MAIN_FRAME_INFO";
      
      public static const MAIN_FRAME_RANK_INFO:String = "MAIN_FRAME_RANK_INFO";
      
      public static const NPC_NODE_INFO:String = "NPC_NODE_INFO";
      
      public static const TASK_INFO:String = "TASK_INFO";
      
      public static const PERSON_RANK_INFO:String = "PERSON_RANK_INFO";
      
      public static const SERVER_RANK_INFO:String = "SERVER_RANK_INFO";
      
      public static const MY_INFO:String = "MY_INFO";
      
      public static const BUFF_LORD_KILLDE:String = "BUFF_LORD_KILLDE";
      
      public static const INSPIRE_INFO:String = "INSPIRE_INFO";
      
      public static const IS_SHOWICON:String = "IS_SHOWICON";
      
      public function GodsEveningEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

