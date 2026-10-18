package battle.animation
{
   import flash.display.DisplayObject;
   
   public class AnimationManager implements ISetAnimation
   {
      
      private var _current:IAnimation;
      
      private var _movie:DisplayObject;
      
      private var _stageWidth:int;
      
      private var _stageHeight:int;
      
      private var _animations:Vector.<IAnimation>;
      
      public function AnimationManager(param1:DisplayObject, param2:int, param3:int)
      {
         super();
         _stageWidth = param2;
         _stageHeight = param3;
         _movie = param1;
         _animations = new Vector.<IAnimation>();
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
         param1.prepare(this);
         for each(var _loc2_:IAnimation in _animations)
         {
            if(_loc2_.level <= param1.level)
            {
               _loc2_.cannel();
            }
         }
         _animations.push(param1);
      }
      
      public function update() : void
      {
         for each(var _loc1_:IAnimation in _animations)
         {
            if(!_loc1_.isFinished())
            {
               _loc1_.update(_movie);
            }
            else if(_animations.indexOf(_loc1_) >= 0)
            {
               _animations.splice(_animations.indexOf(_loc1_),1);
            }
         }
      }
   }
}

