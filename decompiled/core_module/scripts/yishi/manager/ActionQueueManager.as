package yishi.manager
{
   import avmplus.getQualifiedClassName;
   import flash.events.EventDispatcher;
   import yishi.events.ActionsEvent;
   import yishi.interfaces.IAction;
   
   public class ActionQueueManager extends EventDispatcher
   {
      
      protected var _current:IAction;
      
      protected var _actions:Array = [];
      
      public function ActionQueueManager()
      {
         super();
      }
      
      public function update() : void
      {
         if(!_current)
         {
            shiftAction();
         }
         if(!_current)
         {
            return;
         }
         if(_current.finished)
         {
            _current.dispose();
            _current = null;
            if(_actions.length <= 0)
            {
               dispatchEvent(new ActionsEvent("action_all_complete"));
            }
         }
         else
         {
            _current.update();
            if(_current && _current.finished)
            {
               _current.dispose();
               _current = null;
               if(_actions.length <= 0)
               {
                  dispatchEvent(new ActionsEvent("action_all_complete"));
               }
            }
         }
      }
      
      public function getMessage() : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         for each(var _loc1_:IAction in _actions)
         {
            _loc3_++;
            _loc2_ += _loc3_ + " : " + getQualifiedClassName(_loc1_) + "\n";
         }
         return _loc2_;
      }
      
      protected function shiftAction() : void
      {
         var _loc1_:IAction = null;
         if(_actions.length > 0)
         {
            _loc1_ = _actions[0];
            _current = _actions.shift();
            _current.prepare();
         }
      }
      
      public function get size() : int
      {
         return _actions.length;
      }
      
      public function get current() : IAction
      {
         return _current;
      }
      
      public function addAction(param1:IAction, param2:Boolean = false) : void
      {
         var _loc3_:IAction = null;
         var _loc4_:int = 0;
         if(_current)
         {
            if(_current.filter(param1))
            {
               param1.cancel();
               param1.dispose();
               param1 = null;
               return;
            }
            if(_current.replace(param1))
            {
               _current.cancel();
               _current.dispose();
               _current = null;
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _actions.length)
         {
            _loc3_ = _actions[_loc4_] as IAction;
            if(_loc3_.filter(param1))
            {
               param1.cancel();
               param1.dispose();
               param1 = null;
               return;
            }
            if(_loc3_.replace(param1))
            {
               _loc3_.cancel();
               _loc3_.dispose();
               _loc3_ = null;
               _actions[_loc4_] = param1;
            }
            _loc4_++;
         }
         if(param2)
         {
            _actions.unshift(param1);
         }
         else
         {
            _actions.push(param1);
         }
      }
      
      public function cancelActionByType(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:IAction = null;
         _loc3_ = 0;
         while(_loc3_ < _actions.length)
         {
            _loc2_ = _actions[_loc3_] as IAction;
            if(_loc2_.type == param1)
            {
               _loc2_.cancel();
            }
            _loc3_++;
         }
         if(_current && _current.type == param1)
         {
            _current.cancel();
         }
      }
      
      public function getActions() : Array
      {
         return _actions;
      }
      
      public function cleanActions() : void
      {
         _actions = [];
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IAction = null;
         _loc2_ = 0;
         while(_loc2_ < _actions.length)
         {
            _loc1_ = _actions[_loc2_] as IAction;
            _loc1_.dispose();
            _loc1_ = null;
            _loc2_++;
         }
         _actions = null;
         _current = null;
      }
   }
}

