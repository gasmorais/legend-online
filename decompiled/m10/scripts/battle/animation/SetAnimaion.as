package battle.animation
{
   import flash.display.DisplayObject;
   
   public class SetAnimaion implements ISetAnimation
   {
      
      private var _current:IAnimation;
      
      private var _movie:DisplayObject;
      
      private var _stageWidth:int;
      
      private var _stageHeight:int;
      
      public function SetAnimaion(param1:DisplayObject, param2:int, param3:int)
      {
         super();
         _stageWidth = param2;
         _stageHeight = param3;
         _movie = param1;
      }
      
      public function get stageHeight() : int
      {
         return _stageHeight;
      }
      
      public function get stageWidth() : int
      {
         return _stageWidth;
      }
      
      public function getAnimateTarget() : DisplayObject
      {
         return _movie;
      }
      
      public function addAnimation(param1:IAnimation) : void
      {
         if(_current)
         {
            if(param1.replace(_current))
            {
               return;
            }
            if(_current.level <= param1.level)
            {
               _current.cannel();
               _current = param1;
               _current.prepare(this);
            }
         }
         else
         {
            _current = param1;
            _current.prepare(this);
         }
      }
      
      public function update() : void
      {
         if(_current)
         {
            if(!_current.isFinished())
            {
               _current.update(_movie);
            }
            else
            {
               _current = null;
            }
         }
      }
   }
}

