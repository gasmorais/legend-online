package battle.animation
{
   import flash.display.DisplayObject;
   
   public class AnimationBase implements IAnimation
   {
      
      protected var _isFinished:Boolean;
      
      public function AnimationBase()
      {
         super();
      }
      
      public function get level() : int
      {
         return 0;
      }
      
      public function prepare(param1:ISetAnimation) : void
      {
      }
      
      public function replace(param1:IAnimation) : Boolean
      {
         return false;
      }
      
      public function cannel() : void
      {
      }
      
      public function update(param1:DisplayObject) : void
      {
      }
      
      public function isFinished() : Boolean
      {
         return _isFinished;
      }
   }
}

