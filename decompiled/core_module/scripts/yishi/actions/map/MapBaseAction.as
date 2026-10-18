package yishi.actions.map
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import yishi.interfaces.IAction;
   import yishi.interfaces.IEnterFrame;
   import yishi.scene.SceneManager;
   
   public class MapBaseAction extends EventDispatcher implements IAction, IEnterFrame
   {
      
      protected var _finished:Boolean;
      
      protected var _paused:Boolean;
      
      protected var _mapId:int;
      
      private var _priority:int;
      
      private var _timePriority:int;
      
      private var _delayFrameCount:int;
      
      public var level:int;
      
      public function MapBaseAction()
      {
         super();
      }
      
      public function get delayFrameCount() : int
      {
         return _delayFrameCount;
      }
      
      public function set delayFrameCount(param1:int) : void
      {
         _delayFrameCount = param1;
      }
      
      public function set mapId(param1:int) : void
      {
         _mapId = param1;
      }
      
      public function prepare() : void
      {
         SceneManager.instance.lockScene = true;
      }
      
      public function get priority() : int
      {
         return _priority;
      }
      
      public function set priority(param1:int) : void
      {
         _priority = param1;
      }
      
      public function get canDisplay() : Boolean
      {
         return true;
      }
      
      public function get timePriority() : int
      {
         return _timePriority;
      }
      
      public function set timePriority(param1:int) : void
      {
         _timePriority = param1;
      }
      
      public function get isAlone() : Boolean
      {
         return false;
      }
      
      protected function actionOver() : void
      {
         SceneManager.instance.lockScene = false;
         dispatchEvent(new Event("complete"));
      }
      
      public function dispose() : void
      {
         actionOver();
      }
      
      public function enterFrame() : void
      {
      }
      
      public function get type() : String
      {
         return "";
      }
      
      public function update() : void
      {
      }
      
      public function getCode() : uint
      {
         return 0;
      }
      
      public function pause() : void
      {
      }
      
      public function resume() : void
      {
      }
      
      public function get canCancel() : Boolean
      {
         return false;
      }
      
      public function cancel() : void
      {
      }
      
      public function ready(param1:int = 0) : Boolean
      {
         return true;
      }
      
      public function filter(param1:IAction) : Boolean
      {
         return false;
      }
      
      public function synchronization() : void
      {
      }
      
      public function set finished(param1:Boolean) : void
      {
         _finished = param1;
      }
      
      public function get finished() : Boolean
      {
         return _finished;
      }
      
      public function replace(param1:IAction) : Boolean
      {
         return false;
      }
   }
}

