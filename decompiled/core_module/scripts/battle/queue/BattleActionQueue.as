package battle.queue
{
   import battle.BattleManager;
   import battle.actions.GameBaseAction;
   import yishi.interfaces.IAction;
   import yishi.manager.ActionQueueManager;
   
   public class BattleActionQueue extends ActionQueueManager
   {
      
      public function BattleActionQueue()
      {
         super();
      }
      
      override protected function shiftAction() : void
      {
         var _loc1_:IAction = null;
         if(_actions.length > 0)
         {
            _loc1_ = _actions[0];
            if(!_loc1_.ready(BattleManager.getInstance().BattleFrameCount))
            {
               return;
            }
            _current = _actions.shift();
            _current.prepare();
         }
      }
      
      public function get lastLiftTime() : int
      {
         if(_actions.length <= 0 && _current == null)
         {
            return 0;
         }
         var _loc1_:GameBaseAction = GameBaseAction(_actions[_actions.length - 1] || _current);
         return _loc1_.liftTime;
      }
      
      public function get nextLiftTime() : int
      {
         var _loc1_:GameBaseAction = _actions[0];
         if(_loc1_)
         {
            return _loc1_.liftTime;
         }
         return -1;
      }
      
      public function get isOver() : Boolean
      {
         if(_actions.length <= 0 && _current == null)
         {
            return true;
         }
         return false;
      }
   }
}

