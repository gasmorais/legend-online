package battle.actions
{
   import battle.BattleManager;
   import battle.skillsys.effect.BattleEffect;
   import battle.skillsys.effect.MovieClipEffect;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import yishi.interfaces.IAction;
   import yishi.manager.NotificationManager;
   
   public class MovePointAction extends GameBaseAction
   {
      
      protected var _tarPoint:Point;
      
      protected var _speed:int;
      
      private var _idMoveScene:Boolean;
      
      private var _setScale:Boolean;
      
      private var _autoStand:Boolean;
      
      private var _frame:int;
      
      private var _canReplace:Boolean;
      
      private var _endFun:Function;
      
      private var _startFun:Function;
      
      protected var _playWalkAct:Boolean;
      
      private var _dustRes:String;
      
      private var _dustGap:int;
      
      private var _dustPt:Point;
      
      private var _moveForward:Boolean;
      
      public function MovePointAction(param1:int, param2:Point, param3:int, param4:int = 0, param5:Boolean = false, param6:Boolean = false, param7:Boolean = true, param8:Boolean = false, param9:Function = null, param10:Function = null, param11:Boolean = true, param12:String = null, param13:int = 100, param14:Boolean = false)
      {
         super(param5);
         _tarPoint = param2;
         _speed = param3;
         _liftTime = param4;
         _setScale = param6;
         _autoStand = param7;
         _canReplace = param8;
         _currentRole = battleModel.getRoleById(param1);
         _endFun = param9;
         _startFun = param10;
         _playWalkAct = param11;
         _dustRes = param12;
         _dustGap = param13;
         _moveForward = param14;
         if(_dustRes && _dustGap < 0)
         {
            _dustGap = 100;
         }
         if(_startFun != null)
         {
            _startFun();
         }
         addAct();
      }
      
      override public function update() : void
      {
         if(!_currentRole.isLiving)
         {
            finish();
            return;
         }
         if(_currentRole.actionMovie.currentLabels == "Stand")
         {
            playWalkAction();
         }
         var _loc1_:int = Point.distance(_tarPoint,_currentRole.point);
         var _loc2_:int = Math.abs(_loc1_ / _speed);
         if(_loc2_ < 1)
         {
            finish();
            _currentRole.point = _tarPoint;
            if(_autoStand)
            {
               _currentRole.action("Stand");
            }
            return;
         }
         _currentRole.point = Point.interpolate(_tarPoint,_currentRole.point,1 / _loc2_);
         processBackDust();
      }
      
      protected function processBackDust() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 1;
         if(_dustRes && _dustRes != "")
         {
            if(Point.distance(_dustPt,_currentRole.point) > _dustGap)
            {
               if(_currentRole.point.x - _dustPt.x < 0)
               {
                  _loc2_ = -1;
               }
               _loc1_ = Math.atan2(_currentRole.point.y - _dustPt.y,_currentRole.point.x - _dustPt.x);
               _dustPt.x += _dustGap * Math.cos(_loc1_);
               _dustPt.y += _dustGap * Math.sin(_loc1_);
               addDust(_dustPt,_loc2_);
               processBackDust();
            }
         }
      }
      
      protected function addDust(param1:Point, param2:int) : void
      {
         var _loc4_:BattleEffect = null;
         if(battleModel.isHideOtherInBattle(_currentRole))
         {
            return;
         }
         var _loc3_:MovieClip = BattleManager.getInstance().resourceModel.getOrCreateInstanse(_dustRes) as MovieClip;
         _loc4_ = new MovieClipEffect(_loc3_);
         _currentRole.map.effectContainer.addEffect(_loc4_);
         _loc4_.getDisplayObject().x = param1.x;
         _loc4_.getDisplayObject().y = param1.y;
         _loc4_.getDisplayObject().scaleX = param2;
      }
      
      override public function replace(param1:IAction) : Boolean
      {
         return _canReplace;
      }
      
      override public function prepare() : void
      {
         super.prepare();
         if(!_currentRole.isLiving)
         {
            finish();
            return;
         }
         if(!_moveForward && _currentRole.actionMovie.currentLabels == "Ready")
         {
            finish();
            return;
         }
         playWalkAction();
         var _loc1_:int = Point.distance(_tarPoint,_currentRole.point);
         _dustPt = _currentRole.point.clone();
         _frame = Math.abs(_loc1_ / _speed);
         _currentRole.moving = true;
         if(_currentRole == battleModel.selfHero)
         {
            NotificationManager.instance.sendNotification("selfMoveStart");
         }
      }
      
      protected function playWalkAction() : void
      {
         if(_playWalkAct)
         {
            _currentRole.action("Walk","REPEAT");
         }
      }
      
      private function finish() : void
      {
         _currentRole.moving = false;
         if(_endFun != null)
         {
            _endFun();
         }
         _finished = true;
      }
   }
}

