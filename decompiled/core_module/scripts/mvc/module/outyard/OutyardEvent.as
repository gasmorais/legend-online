package mvc.module.outyard
{
   import flash.events.Event;
   
   public class OutyardEvent extends Event
   {
      
      public static const REFRESH_TEMP:String = "REFRESH_TEMP";
      
      public static const DRAG_SCENE_END:String = "DRAG_SCENE_END";
      
      public static const DRAG_SCENE_START:String = "DRAG_SCENE_START";
      
      public static const UPDATEMOPUP:String = "UPDATEMOPUP";
      
      private var _data:Object;
      
      private var _isSwitchMap:Boolean;
      
      public function OutyardEvent(param1:String, param2:Object, param3:Boolean = false)
      {
         _data = param2;
         _isSwitchMap = param3;
         super(param1,false,false);
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get isSwitchMap() : Boolean
      {
         return _isSwitchMap;
      }
   }
}

