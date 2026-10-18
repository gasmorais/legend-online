package yishi.manager
{
   import chat.datas.ChatData;
   import com.pickgliss.utils.ObjectPool;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.getQualifiedClassName;
   import logging.LoggerSys;
   import mainBar.ChatBar;
   import yishi.actions.SimplePriorityQueue;
   import yishi.interfaces.IAction;
   import yishi.interfaces.IEnterFrame;
   import yishi.scene.SceneEvent;
   import yishi.scene.SceneManager;
   
   public class GameBaseQueueManager extends EventDispatcher implements IEnterFrame
   {
      
      private static var _instance:GameBaseQueueManager;
      
      private var _actionHeaps:SimplePriorityQueue = new SimplePriorityQueue(100);
      
      private var _actionDelays:Array = [];
      
      private var _currentAction:IAction;
      
      private var _timeoutCount:int;
      
      private var _isSceneSwitch:Boolean;
      
      private var times:int = 1;
      
      public function GameBaseQueueManager()
      {
         super();
      }
      
      public static function get instance() : GameBaseQueueManager
      {
         return _instance || (_instance = new GameBaseQueueManager());
      }
      
      public function setup() : void
      {
         SceneManager.instance.addEventListener("SWITCH_SCENE_LOCK",__switchSceneLockHandler);
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function __switchSceneLockHandler(param1:SceneEvent) : void
      {
         _isSceneSwitch = param1.data;
      }
      
      public function enterFrame() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IAction = null;
         if(_actionDelays.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _actionDelays.length)
            {
               _loc1_ = _actionDelays[_loc2_];
               _loc1_.delayFrameCount -= 1;
               if(_loc1_.delayFrameCount <= 0)
               {
                  _actionDelays.splice(_loc2_,1);
                  _loc2_--;
                  addAction(_loc1_);
               }
               _loc2_++;
            }
         }
         if(_currentAction)
         {
            _currentAction.update();
         }
         if(_currentAction)
         {
            if(_timeoutCount == 3600)
            {
               LoggerSys.info("Action is timeOut>>>nickName:" + ArmyManager.instance.thane.nickName + "|actionName:" + getQualifiedClassName(_currentAction));
            }
            _timeoutCount = _timeoutCount + 1;
         }
      }
      
      public function get actionsLength() : int
      {
         return _actionHeaps.size;
      }
      
      public function getMessage() : String
      {
         return _actionHeaps.toString();
      }
      
      public function addAction(param1:IAction, param2:int = 0) : void
      {
         sendToChat(param1,"加入");
         if(null == param1)
         {
            return;
         }
         param1.priority = param2;
         if(param1.timePriority == 0)
         {
            param1.timePriority = times++;
         }
         if(param1.isAlone)
         {
            _actionHeaps.removeObjByClass((param1 as Object).constructor);
         }
         _actionHeaps.enqueue(param1);
         dequeueAction();
      }
      
      private function dequeueAction() : void
      {
         if(null != _currentAction || _actionHeaps.size <= 0)
         {
            return;
         }
         _currentAction = _actionHeaps.dequeue() as IAction;
         _timeoutCount = 0;
         if(_currentAction)
         {
            if(_currentAction.canDisplay)
            {
               sendToChat(_currentAction,"开始");
               _currentAction.addEventListener("complete",__onCurrentActionComplete);
               _currentAction.prepare();
            }
            else
            {
               _actionDelays.push(_currentAction);
               _currentAction.delayFrameCount = 13;
               _currentAction = null;
            }
         }
         if(_actionHeaps.size <= 0)
         {
            _actionHeaps.clear();
         }
      }
      
      public function removeAction(param1:IAction) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(param1 == _currentAction)
         {
            return true;
         }
         return _actionHeaps.remove(param1);
      }
      
      public function get current() : IAction
      {
         return _currentAction;
      }
      
      public function isPlaying() : Boolean
      {
         return _currentAction != null;
      }
      
      private function __onCurrentActionComplete(param1:Event) : void
      {
         sendToChat(_currentAction,"结束");
         _currentAction.removeEventListener("complete",__onCurrentActionComplete);
         _currentAction = null;
         dequeueAction();
      }
      
      private function sendToChat(param1:IAction, param2:String = "") : void
      {
         var _loc4_:String = null;
         var _loc3_:ChatData = null;
         if(ChatBar.debugSwitch)
         {
            _loc4_ = getQualifiedClassName(param1);
            _loc3_ = ObjectPool.getObject(ChatData) as ChatData;
            _loc3_.channel = 3;
            _loc3_.msg = param2 + ":" + _loc4_;
            _loc3_.commit();
            NotificationManager.instance.sendNotification("ADD_CHAT",_loc3_);
         }
      }
   }
}

