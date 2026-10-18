package yishi.events
{
   import flash.events.Event;
   
   public class SceneViewEvent extends Event
   {
      
      public static const ADD_TO_STAGE:String = "addToStage";
      
      private var _sceneType:String;
      
      public function SceneViewEvent(param1:String, param2:String)
      {
         _sceneType = param2;
         super(param1);
      }
      
      public function get sceneType() : String
      {
         return _sceneType;
      }
   }
}

