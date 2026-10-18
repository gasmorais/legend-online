package battle.actions
{
   import battle.BattleManager;
   import battle.particle.crush.CrushUtils;
   import com.greensock.TimelineLite;
   import flash.geom.Rectangle;
   import yishi.datas.objects.PawnRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.datas.objects.SelfChessRoleInfo;
   import yishi.manager.NotificationManager;
   
   public class DieAction extends GameBaseAction
   {
      
      private var _frame:int;
      
      private var _timer:int;
      
      private var _isPawn:Boolean = false;
      
      private var costTime:Number;
      
      private var timelineLite:TimelineLite;
      
      public function DieAction(param1:RoleInfo)
      {
         super();
         _currentRole = param1;
         if(_currentRole as PawnRoleInfo)
         {
            _isPawn = true;
         }
         else if(_currentRole as SelfChessRoleInfo)
         {
            _isPawn = true;
         }
         _currentRole.addAction(this,true);
      }
      
      override public function prepare() : void
      {
         if(!_currentRole || _currentRole.dying)
         {
            _finished = true;
            return;
         }
         _currentRole.dying = true;
         if(_currentRole == BattleManager.getInstance().battleModel.selfHero && BattleManager.getInstance().battleModel.battleType != 3844)
         {
            NotificationManager.instance.sendNotification("SKILL_ENABLE",false);
         }
         super.prepare();
         _frame = _currentRole.actionMovie.getTagFrame("Die");
      }
      
      override public function update() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:int = 0;
         if(_finished)
         {
            return;
         }
         if(_timer == 0)
         {
            if(_isPawn)
            {
               _currentRole.action("Stand",null,null,5,true);
               timelineLite = new TimelineLite({
                  "useFrames":false,
                  "onComplete":actionComplete
               });
               if(!_currentRole.actionMovie || !_currentRole.actionMovie.movie)
               {
                  actionComplete();
                  return;
               }
               _loc1_ = _currentRole.actionMovie.movie.getBounds(_currentRole.actionMovie.movie);
               if(_loc1_.width == 0 || _loc1_.height == 0)
               {
                  actionComplete();
                  return;
               }
               _loc2_ = -1;
               CrushUtils.crush(_currentRole.actionMovie.movie,_loc2_,1,timelineLite,0,null,null);
               _currentRole.actionMovie.movie.visible = false;
               _currentRole.view.setRoleInfoViewVisible(false);
            }
            else
            {
               _currentRole.action("Die");
            }
         }
         if(_frame == _timer && !_isPawn)
         {
            actionOver();
         }
         _timer = _timer + 1;
      }
      
      private function actionComplete() : void
      {
         if(timelineLite)
         {
            timelineLite.kill();
            timelineLite = null;
         }
         actionOver();
      }
      
      override public function synchronization() : void
      {
         _timer = 0;
         actionOver();
      }
      
      override protected function actionOver() : void
      {
         _currentRole.cleanActions();
         _currentRole.isLiving = false;
         _finished = true;
      }
   }
}

