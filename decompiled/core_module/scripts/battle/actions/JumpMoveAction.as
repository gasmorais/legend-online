package battle.actions
{
   import flash.geom.Point;
   
   public class JumpMoveAction extends MovePointAction
   {
      
      public function JumpMoveAction(param1:int, param2:Point, param3:int, param4:int = 0, param5:Boolean = false, param6:Boolean = false, param7:Boolean = true, param8:Boolean = false, param9:Function = null, param10:Function = null, param11:Boolean = true, param12:String = null, param13:int = 100)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
      }
      
      override protected function playWalkAction() : void
      {
         if(_playWalkAct)
         {
            _currentRole.action("Walk","STOP");
         }
      }
      
      override protected function processBackDust() : void
      {
      }
      
      override public function prepare() : void
      {
         var _loc1_:Number = Point.distance(_currentRole.point,_tarPoint);
         _speed = Math.ceil(_loc1_ / _currentRole.actionMovie.getLabelFrameNum("Walk"));
         super.prepare();
      }
   }
}

