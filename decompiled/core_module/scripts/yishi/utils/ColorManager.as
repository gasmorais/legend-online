package yishi.utils
{
   import com.greensock.TweenLite;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.ColorTransform;
   
   public class ColorManager extends EventDispatcher
   {
      
      private var _mc:DisplayObject;
      
      private var _color:ColorTransform;
      
      private var _index:int;
      
      private var _round:int;
      
      private var _delay:Number;
      
      public function ColorManager(param1:DisplayObject, param2:int = 5, param3:Number = 0.3)
      {
         super();
         _mc = param1;
         _round = param2;
         _delay = param3;
         init();
      }
      
      private function init() : void
      {
         _color = new ColorTransform(0.3,0.3,0.3,1,179,143,0,1);
         _mc.transform.colorTransform = _color;
         TweenLite.to(_color,0.3,{
            "delay":_delay,
            "redMultiplier":1,
            "greenMultiplier":1,
            "blueMultiplier":1,
            "redOffset":0,
            "greenOffset":0,
            "onUpdate":__onUpdate,
            "onComplete":__onFinishTween
         });
      }
      
      private function __onUpdate() : void
      {
         _mc.transform.colorTransform = _color;
      }
      
      private function __onFinishTween() : void
      {
         _index = _index + 1;
         if(_index == _round)
         {
            dispatchEvent(new Event("complete"));
            return;
         }
         if(_index % 2 == 0)
         {
            TweenLite.to(_color,0.3,{
               "redMultiplier":1,
               "greenMultiplier":1,
               "blueMultiplier":1,
               "redOffset":0,
               "greenOffset":0,
               "onUpdate":__onUpdate,
               "onComplete":__onFinishTween
            });
         }
         else
         {
            TweenLite.to(_color,0.3,{
               "redMultiplier":0.3,
               "greenMultiplier":0.3,
               "blueMultiplier":0.3,
               "redOffset":179,
               "greenOffset":143,
               "onUpdate":__onUpdate,
               "onComplete":__onFinishTween
            });
         }
      }
   }
}

