package yishi.view.base
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class DashedLine extends Sprite
   {
      
      private var lengthsArray:Array = [];
      
      private var lineColor:uint;
      
      private var lineWeight:Number;
      
      private var lineAlpha:Number = 1;
      
      private var curX:Number = 0;
      
      private var curY:Number = 0;
      
      private var remainingDist:Number = 0;
      
      private var curIndex:int = 0;
      
      private var arraySum:Number = 0;
      
      private var startIndex:int = 0;
      
      private var fill:Shape = new Shape();
      
      private var stroke:Shape = new Shape();
      
      public function DashedLine(param1:Number = 0, param2:Number = 0, param3:Number = 1, param4:Array = null)
      {
         super();
         if(param4 != null)
         {
            this.lengthsArray = param4;
         }
         else
         {
            this.lengthsArray = [5,5];
         }
         if(this.lengthsArray.length % 2 != 0)
         {
            param4.push(5);
         }
         for(var _loc5_:String in param4)
         {
            arraySum += param4[_loc5_];
         }
         lineWeight = param1;
         lineColor = param2;
         lineAlpha = param3;
         stroke.graphics.lineStyle(lineWeight,lineColor,lineAlpha,false,"none","none");
         addChild(fill);
         addChild(stroke);
      }
      
      public function moveTo(param1:Number, param2:Number) : void
      {
         stroke.graphics.moveTo(param1,param2);
         fill.graphics.moveTo(param1,param2);
         curX = param1;
         curY = param2;
         remainingDist = 0;
         startIndex = 0;
      }
      
      public function lineTo(param1:Number, param2:Number) : void
      {
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc9_:Number = (param2 - curY) / (param1 - curX);
         var _loc8_:Number = curX;
         var _loc7_:Number = curY;
         var _loc4_:int = param1 < _loc8_ ? -1 : 1;
         var _loc10_:int = param2 < _loc7_ ? -1 : 1;
         loop0:
         while(Math.abs(_loc8_ - curX) < Math.abs(_loc8_ - param1) || Math.abs(_loc7_ - curY) < Math.abs(_loc7_ - param2))
         {
            _loc5_ = startIndex;
            while(_loc5_ < lengthsArray.length)
            {
               _loc6_ = Number(remainingDist == 0 ? lengthsArray[_loc5_] : remainingDist);
               _loc3_ = getCoords(_loc6_,_loc9_).x * _loc4_;
               _loc11_ = getCoords(_loc6_,_loc9_).y * _loc10_;
               if(!(Math.abs(_loc8_ - curX) + Math.abs(_loc3_) < Math.abs(_loc8_ - param1) || Math.abs(_loc7_ - curY) + Math.abs(_loc11_) < Math.abs(_loc7_ - param2)))
               {
                  remainingDist = getDistance(curX,curY,param1,param2);
                  curIndex = _loc5_;
                  break loop0;
               }
               if(_loc5_ % 2 == 0)
               {
                  stroke.graphics.lineTo(curX + _loc3_,curY + _loc11_);
               }
               else
               {
                  stroke.graphics.moveTo(curX + _loc3_,curY + _loc11_);
               }
               curX += _loc3_;
               curY += _loc11_;
               curIndex = _loc5_;
               startIndex = 0;
               remainingDist = 0;
               _loc5_++;
            }
         }
         startIndex = curIndex;
         if(remainingDist != 0)
         {
            if(curIndex % 2 == 0)
            {
               stroke.graphics.lineTo(param1,param2);
            }
            else
            {
               stroke.graphics.moveTo(param1,param2);
            }
            remainingDist = lengthsArray[curIndex] - remainingDist;
         }
         else if(startIndex == lengthsArray.length - 1)
         {
            startIndex = 0;
         }
         else
         {
            startIndex = startIndex + 1;
         }
         curX = param1;
         curY = param2;
         fill.graphics.lineTo(param1,param2);
      }
      
      private function getCoords(param1:Number, param2:Number) : Point
      {
         var _loc4_:Number = Math.atan(param2);
         var _loc5_:Number = Math.abs(Math.sin(_loc4_) * param1);
         var _loc3_:Number = Math.abs(Math.cos(_loc4_) * param1);
         return new Point(_loc3_,_loc5_);
      }
      
      private function getDistance(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return Math.sqrt(Math.pow(param3 - param1,2) + Math.pow(param4 - param2,2));
      }
      
      public function clear() : void
      {
         stroke.graphics.clear();
         stroke.graphics.lineStyle(lineWeight,lineColor,lineAlpha,false,"none","none");
         fill.graphics.clear();
         moveTo(0,0);
      }
      
      public function lineStyle(param1:Number = 0, param2:Number = 0, param3:Number = 1) : void
      {
         lineWeight = param1;
         lineColor = param2;
         lineAlpha = param3;
         stroke.graphics.lineStyle(lineWeight,lineColor,lineAlpha,false,"none","none");
      }
      
      public function beginFill(param1:uint, param2:Number = 1) : void
      {
         fill.graphics.beginFill(param1,param2);
      }
      
      public function endFill() : void
      {
         fill.graphics.endFill();
      }
   }
}

