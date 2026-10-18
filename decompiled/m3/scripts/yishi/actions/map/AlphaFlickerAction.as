package yishi.actions.map
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   
   public class AlphaFlickerAction extends MapBaseAction
   {
      
      private var _target:Object;
      
      private var _count:int;
      
      public function AlphaFlickerAction(param1:Object)
      {
         _target = param1;
         super();
      }
      
      override public function update() : void
      {
         if(!_target)
         {
            dispose();
            return;
         }
         if(_count == 1)
         {
            TweenMax.to(_target,0.25,{
               "alpha":0.3,
               "repeat":5,
               "yoyo":true,
               "onComplete":dispose
            });
         }
         _count = _count + 1;
      }
      
      override public function dispose() : void
      {
         if(_target && _target is Sprite)
         {
            TweenMax.killChildTweensOf(_target as Sprite);
            (_target as Sprite).filters = null;
         }
         super.dispose();
      }
   }
}

