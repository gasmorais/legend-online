package battle.particle.freeze
{
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.geom.Point;
   
   public class ScrapShape extends Shape
   {
      
      private var vx:Number;
      
      private var ax:Number;
      
      private var vy:Number;
      
      private var ay:Number;
      
      private var alphaRate:Number;
      
      private var botton:int;
      
      public function ScrapShape(param1:BitmapData, param2:Polygon, param3:Point, param4:int)
      {
         var _loc7_:int = 0;
         super();
         graphics.beginBitmapFill(param1);
         graphics.moveTo(param2.lines[0].startPoint.x,param2.lines[0].startPoint.y);
         _loc7_ = 1;
         while(_loc7_ < param2.lines.length)
         {
            graphics.lineTo(param2.lines[_loc7_].startPoint.x,param2.lines[_loc7_].startPoint.y);
            _loc7_++;
         }
         graphics.endFill();
         var _loc5_:Point = param2.centerPoint;
         var _loc6_:Number = Point.distance(_loc5_,param3);
         vx = 0.5 * (_loc5_.x - param3.x) / _loc6_;
         ax = 0.1 * (_loc5_.x - param3.x) / _loc6_;
         vy = 0.1 * (_loc5_.y - param4);
         ay = 2;
         alphaRate = 1;
         botton = param4 - _loc5_.y;
         param2.dispose();
         param2 = null;
      }
      
      public function update() : void
      {
         vx += ax;
         x += vx;
         if(y > botton)
         {
            vy *= -0.3;
            vx *= 0.5;
            alphaRate = 0.8;
            y = botton;
         }
         else
         {
            vy += ay;
            y += vy;
         }
         alpha *= alphaRate;
      }
      
      public function dispose() : void
      {
         if(this.parent != null)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

