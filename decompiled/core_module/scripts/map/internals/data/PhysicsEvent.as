package map.internals.data
{
   import flash.events.Event;
   
   public class PhysicsEvent extends Event
   {
      
      public static const UP_STATE:String = "UP_STATE";
      
      public static const UP_SONTYPE:String = "UP_SONTYPE";
      
      public static const FOLLOW_TARGET:String = "followTarget";
      
      public static const VISIT_USER_ID:String = "_visitUserIds";
      
      public static const CHAT_DATA:String = "CHAT_DATA";
      
      public static const UPDATE_CUR_HP:String = "UPDATE_CUR_HP";
      
      public static const UPDATE_NODE_HP:String = "UPDATE_NODE_HP";
      
      public static const WALK_NEXT_POINT:String = "WALK_NEXT_POINT";
      
      public static const MOVE_POS:String = "MOVE_POS";
      
      public static const PARA_1:String = "PARA_1";
      
      public static const DANNAY:String = "DANNAY";
      
      public static const USE_SKILL:String = "USE_SKILL";
      
      public static const ADD_BUFF:String = "ADD_BUFF";
      
      public var data:Object;
      
      public function PhysicsEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

