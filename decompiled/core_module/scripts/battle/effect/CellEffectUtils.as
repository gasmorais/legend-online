package battle.effect
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Back;
   import flash.display.DisplayObject;
   
   public class CellEffectUtils
   {
      
      public function CellEffectUtils()
      {
         super();
      }
      
      public static function zoomOut(param1:DisplayObject, param2:Function) : void
      {
         param1.width += 1;
         TweenLite.to(param1,0.7,{
            "x":param1.x + (param1.width >> 1),
            "y":param1.y + (param1.height >> 1),
            "width":1,
            "height":1,
            "ease":Back.easeIn,
            "onComplete":param2
         });
      }
      
      public static function fadeOut(param1:DisplayObject, param2:Function) : void
      {
         TweenLite.to(param1,0.7,{
            "alpha":0,
            "ease":Back.easeIn,
            "onComplete":param2
         });
      }
      
      public static function rotate(param1:DisplayObject, param2:Function) : void
      {
         fadeOut(param1,param2);
      }
      
      public static function shutterX1(param1:DisplayObject, param2:Function) : void
      {
         TweenLite.to(param1,0.7,{
            "width":0,
            "ease":Back.easeIn,
            "onComplete":param2
         });
      }
      
      public static function shutterX2(param1:DisplayObject, param2:Function) : void
      {
         TweenLite.to(param1,0.7,{
            "x":param1.x + param1.width,
            "width":0,
            "ease":Back.easeIn,
            "onComplete":param2
         });
      }
      
      public static function shutterY1(param1:DisplayObject, param2:Function) : void
      {
         TweenLite.to(param1,0.7,{
            "height":0,
            "ease":Back.easeIn,
            "onComplete":param2
         });
      }
      
      public static function shutterY2(param1:DisplayObject, param2:Function) : void
      {
         TweenLite.to(param1,0.7,{
            "y":param1.y + param1.height,
            "height":0,
            "ease":Back.easeIn,
            "onComplete":param2
         });
      }
   }
}

