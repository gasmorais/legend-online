package battle.actions.common
{
   import flash.events.EventDispatcher;
   import yishi.interfaces.IAction;
   import yishi.utils.CallBacker;
   
   public class BaseAction extends EventDispatcher implements IAction
   {
      
      protected var _finished:Boolean;
      
      private var _callBackFinish:CallBacker = new CallBacker(this);
      
      protected var _paused:Boolean;
      
      public function BaseAction()
      {
         super();
      }
      
      public function synchronization() : void
      {
      }
      
      public function get finished() : Boolean
      {
         return _finished;
      }
      
      public function set finished(param1:Boolean) : void
      {
         _finished = param1;
      }
      
      public function replace(param1:IAction) : Boolean
      {
         return false;
      }
      
      public function prepare() : void
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
      
      public function update() : void
      {
      }
      
      public function cancel() : void
      {
         _finished = true;
      }
      
      public function get priority() : int
      {
         return 0;
      }
      
      public function dispose() : void
      {
         _callBackFinish.dispatch();
      }
      
      public function getCode() : uint
      {
         return 0;
      }
      
      public function get callBackFinish() : CallBacker
      {
         return _callBackFinish;
      }
      
      public function get type() : String
      {
         return "";
      }
      
      public function pause() : void
      {
         _paused = true;
      }
      
      public function resume() : void
      {
         _paused = false;
      }
      
      public function get canCancel() : Boolean
      {
         return false;
      }
      
      public function set priority(param1:int) : void
      {
         throw new Error("not implemented!!!");
      }
      
      public function get canDisplay() : Boolean
      {
         throw new Error("not implemented!!!");
      }
      
      public function get isAlone() : Boolean
      {
         throw new Error("not implemented!!!");
      }
      
      public function get delayFrameCount() : int
      {
         throw new Error("not implemented!!!");
      }
      
      public function set delayFrameCount(param1:int) : void
      {
         throw new Error("not implemented!!!");
      }
      
      public function get timePriority() : int
      {
         throw new Error("not implemented!!!");
      }
      
      public function set timePriority(param1:int) : void
      {
         throw new Error("not implemented!!!");
      }
   }
}

