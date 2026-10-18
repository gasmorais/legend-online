package battle.handler
{
   import battle.BattleManager;
   import battle.actions.BattleDialogAction;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.interfaces.IAction;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.utils.TimerUtils;
   
   public class BattlePlotHandler implements IEnterFrame
   {
      
      private var _actions:Vector.<IAction>;
      
      private var _current:IAction;
      
      private var _checking:Boolean;
      
      public function BattlePlotHandler()
      {
         super();
         _actions = new Vector.<IAction>();
      }
      
      public function handler(param1:PackageIn) : void
      {
         _actions.push(new BattleDialogAction(param1));
      }
      
      public function enterFrame() : void
      {
         if(!_current)
         {
            if(_actions.length > 0)
            {
               if(!_checking)
               {
                  TimerUtils.setTimeout(checkEnd,100);
                  _checking = true;
               }
            }
         }
         if(_current)
         {
            if(_current.finished)
            {
               _current.dispose();
               _current = null;
            }
            else
            {
               _current.update();
            }
         }
      }
      
      private function checkEnd() : void
      {
         var _loc1_:BattleModel = BattleManager.getInstance().battleModel;
         if(!_loc1_)
         {
            _checking = false;
            inactive();
            return;
         }
         if(_loc1_.isRolesStatic())
         {
            _current = _actions.shift();
            if(_current)
            {
               _current.prepare();
            }
         }
         else if(_loc1_.battleType == 311 || _loc1_.battleType == 312 || _loc1_.battleType == 313)
         {
            _current = _actions.shift();
            if(_current)
            {
               _current.prepare();
            }
         }
         _checking = false;
      }
      
      public function activate() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      public function inactive() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         var _loc1_:BattleModel = BattleManager.getInstance().battleModel;
         if(_loc1_)
         {
            if(_loc1_.battleType == 311 || _loc1_.battleType == 312 || _loc1_.battleType == 313)
            {
               _actions.length = 0;
            }
         }
      }
   }
}

