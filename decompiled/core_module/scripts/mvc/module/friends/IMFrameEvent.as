package mvc.module.friends
{
   import flash.events.Event;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class IMFrameEvent extends Event
   {
      
      public static const DISPOSE:String = "IMFRAME_DISPOSE";
      
      public static const REMOVE:String = "IMFRAME_REMOVE";
      
      private var _data:ThaneInfo;
      
      public function IMFrameEvent(param1:String, param2:ThaneInfo = null)
      {
         super(param1);
         _data = param2;
      }
      
      override public function clone() : Event
      {
         return new IMFrameEvent(type,data);
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
   }
}

