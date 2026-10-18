package battle.actions
{
   import battle.BattleManager;
   import battle.actions.common.BaseAction;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.RoleInfo;
   
   public class GameBaseAction extends BaseAction
   {
      
      protected var _liftTime:int;
      
      protected var _currentRole:RoleInfo;
      
      protected var _moveScene:Boolean = false;
      
      public function GameBaseAction(param1:Boolean = false)
      {
         super();
         _moveScene = false;
      }
      
      public function addAct() : void
      {
         if(_currentRole)
         {
            _currentRole.addAction(this);
         }
      }
      
      override public function ready(param1:int = 0) : Boolean
      {
         return _liftTime > param1 ? false : true;
      }
      
      protected function actionOver() : void
      {
      }
      
      protected function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      public function get liftTime() : int
      {
         return _liftTime;
      }
      
      public function set liftTime(param1:int) : void
      {
         _liftTime = param1;
      }
   }
}

