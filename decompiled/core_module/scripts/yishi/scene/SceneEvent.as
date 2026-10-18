package yishi.scene
{
   import flash.events.Event;
   
   public class SceneEvent extends Event
   {
      
      public static const SWITCH_SCENE_LOCK:String = "SWITCH_SCENE_LOCK";
      
      public static const SCENE_SWITCH_CALL:String = "SCENE_SWITCH_CALL";
      
      public var data:*;
      
      public function SceneEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         data = param2;
      }
   }
}

