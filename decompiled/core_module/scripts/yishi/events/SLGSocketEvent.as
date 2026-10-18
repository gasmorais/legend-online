package yishi.events
{
   import flash.events.Event;
   
   public class SLGSocketEvent extends Event
   {
      
      public static const EVENT:String = "SLGSocketEvent";
      
      public static const GAME_CMD:String = "GAME_CMD";
      
      public static const U_PLAY_MOVIE:String = "U_PLAY_MOVIE";
      
      public static const UPDATE_CASTLE:String = "UPDATE_CASTLE";
      
      public static const UPDATE_WILDLAND:String = "UPDATE_WILDLAND";
      
      public static const UPDTAE_ARMY:String = "UPDTAE_ARMY";
      
      private var _data:Object;
      
      public function SLGSocketEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         _data = param2;
         super(param1,param3,param4);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

