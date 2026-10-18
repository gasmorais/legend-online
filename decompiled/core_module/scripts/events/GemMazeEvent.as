package events
{
   import flash.events.Event;
   
   public class GemMazeEvent extends Event
   {
      
      public static const GEMMAZE_GET_INIT_INFO:String = "GEMMAZE_GET_INIT_INFO";
      
      public static const GEMMAZE_UPDATE_INFO:String = "GEMMAZE_UPDATE_INFO";
      
      public static const GEMMAZE_UPDATE_TIMESLEFT:String = "GEMMAZE_UPDATE_TIMESLEFT";
      
      public static const GEMMAZE_REMOVE_COMPLETE:String = "GEMMAZE_REMOVE_COMPLETE";
      
      public static const GEMMAZE_GEM_ACTION_COMPLETE:String = "GEMMAZE_GEM_ACTION_COMPLETE";
      
      public static const GEMMAZE_GEM_UPDATE_FRAME:String = "GEMMAZE_GEM_UPDATE_FRAME";
      
      public static const ORDERDATA_LOAD_COMPLETE:String = "ORDERDATA_LOAD_COMPLETE";
      
      public static const GEMMAZE_GEM_PLAYER_GOODS_FLY:String = "GEMMAZE_GEM_PLAYER_GOODS_FLY";
      
      public static const GEMMAZE_UPDATE_BOX_STATUS:String = "GEMMAZE_UPDATE_BOX_STATUS";
      
      public static const GEMMAZE_UPDATE_BAG:String = "GEMMAZE_UPDATE_BAG";
      
      public static const GEMMAZE_PLAYER_GRAIN:String = "GEMMAZE_PLAYER_GRAIN";
      
      public static const GEMMAZE_PLAYER_BOX_GOODS:String = "GEMMAZE_PLAYER_BOX_GOODS";
      
      public static const GEMMAZE_ADD_INTERGAL:String = "GEMMAZE_ADD_INTERGAL";
      
      public var data:*;
      
      public function GemMazeEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

