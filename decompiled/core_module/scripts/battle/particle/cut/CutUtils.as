package battle.particle.cut
{
   import com.greensock.TimelineLite;
   import com.greensock.TweenLite;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class CutUtils
   {
      
      public static const shakeTime:Number = 0.6;
      
      public static const cutTime:Number = 1;
      
      public static const HORIZONTAL_CUT:int = 1;
      
      public static const VERTICAL_CUT:int = 2;
      
      public function CutUtils()
      {
         super();
      }
      
      public static function cut(param1:DisplayObject, param2:int, param3:Number, param4:TimelineLite, param5:Number, param6:Function, param7:Function, param8:int = 1) : void
      {
         var _loc9_:Rectangle = param1.getBounds(param1);
         if(_loc9_.width == 0 || _loc9_.height == 0)
         {
            if(param7 != null)
            {
               param4.insert(TweenLite.delayedCall(param5,param7,null,false));
            }
            return;
         }
         param4.insert(TweenLite.delayedCall(param5,doCut,[param1,param2,param3,param4,param5 + 0.6,param8],false));
         if(param6 != null)
         {
            param4.insert(TweenLite.delayedCall(param5,param6,null,false));
         }
         var _loc10_:CutParams = new CutParams();
         param4.insert(new TweenLite(_loc10_,0.6,{
            "delay":param5,
            "onUpdate":shakeYourBody,
            "onUpdateParams":[param1,_loc10_]
         }));
         if(param7 != null)
         {
            param4.insert(TweenLite.delayedCall(param5 + 0.6 + 1,param7,null,false));
         }
      }
      
      private static function shakeYourBody(param1:DisplayObject, param2:CutParams) : void
      {
         param1.parent.x += param2.shakeFlag * 1;
         param2.shakeFlag *= -1;
      }
      
      private static function doCut(param1:DisplayObject, param2:int, param3:Number, param4:TimelineLite, param5:Number, param6:int) : void
      {
         var _loc12_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc9_:int = 0;
         var _loc7_:Rectangle = param1.getBounds(param1);
         var _loc10_:Matrix = new Matrix();
         if(param2 * param1.scaleX == 1)
         {
            _loc10_.translate(-_loc7_.x,-_loc7_.y);
         }
         else
         {
            _loc10_.scale(-1,1);
            _loc10_.translate(_loc7_.width + _loc7_.x,-_loc7_.y);
         }
         var _loc8_:BitmapData = new BitmapData(_loc7_.width,_loc7_.height,true,0);
         _loc8_.draw(param1,_loc10_);
         if(param2 * param1.scaleX == 1)
         {
            _loc12_ = param1.x + param2 * param3 * _loc7_.x;
         }
         else
         {
            _loc12_ = param1.x - param2 * param3 * (_loc7_.width + _loc7_.x);
         }
         _loc11_ = (param1.y + _loc7_.y) * param3;
         _loc9_ = param2;
         switch(param6 - 1)
         {
            case 0:
               horizontalCut(param1,param2,param3,param4,param5,_loc8_,_loc7_,_loc12_,_loc11_,_loc9_);
               break;
            case 1:
               verticalCut(param1,param2,param3,param4,param5,_loc8_,_loc7_,_loc12_,_loc11_,_loc9_);
         }
      }
      
      private static function horizontalCut(param1:DisplayObject, param2:int, param3:Number, param4:TimelineLite, param5:Number, param6:BitmapData, param7:Rectangle, param8:Number, param9:Number, param10:int) : void
      {
         var toX:int;
         var toY:int;
         var target:DisplayObject = param1;
         var direction:int = param2;
         var scaleRate:Number = param3;
         var timelineLite:TimelineLite = param4;
         var delay:Number = param5;
         var bd:BitmapData = param6;
         var rect:Rectangle = param7;
         var pieceX:Number = param8;
         var pieceY:Number = param9;
         var pieceScaleX:int = param10;
         var r:Shape = createPiece(bd,rect,[{
            "x":0,
            "y":0
         },{
            "x":0,
            "y":rect.height * 0.6
         },{
            "x":rect.width,
            "y":rect.height * 0.4
         },{
            "x":rect.width,
            "y":0
         }]);
         r.x = pieceX;
         r.y = pieceY;
         toX = pieceX - direction * rect.width * scaleRate * 0.33;
         toY = pieceY + 0.33 * rect.height * scaleRate * 0.2;
         r.scaleX = pieceScaleX * scaleRate;
         r.scaleY = scaleRate;
         target.parent.addChildAt(r,target.parent.getChildIndex(target));
         timelineLite.insert(TweenLite.to(r,1,{
            "delay":delay,
            "x":toX,
            "y":toY
         }));
         timelineLite.insert(TweenLite.to(r,0.5,{
            "delay":delay + 0.5,
            "alpha":0,
            "onComplete":function(param1:Shape):void
            {
               if(param1.parent != null)
               {
                  param1.parent.removeChild(param1);
               }
            },
            "onCompleteParams":[r]
         }));
         r = createPiece(bd,rect,[{
            "x":0,
            "y":rect.height * 0.6
         },{
            "x":0,
            "y":rect.height
         },{
            "x":rect.width,
            "y":rect.height
         },{
            "x":rect.width,
            "y":rect.height * 0.4
         }]);
         r.x = pieceX;
         r.y = pieceY;
         toX = pieceX - direction * rect.width * scaleRate * 0.33;
         toY = pieceY + 0.33 * rect.height * scaleRate * 0.2;
         r.scaleX = pieceScaleX * scaleRate;
         r.scaleY = scaleRate;
         target.parent.addChildAt(r,target.parent.getChildIndex(target));
         timelineLite.insert(TweenLite.to(r,0.5,{
            "delay":delay + 0.5,
            "alpha":0,
            "onComplete":function(param1:Shape):void
            {
               bd.dispose();
               if(param1.parent != null)
               {
                  param1.parent.removeChild(param1);
               }
            },
            "onCompleteParams":[r]
         }));
      }
      
      private static function verticalCut(param1:DisplayObject, param2:int, param3:Number, param4:TimelineLite, param5:Number, param6:BitmapData, param7:Rectangle, param8:Number, param9:Number, param10:int) : void
      {
         var toX:int;
         var toY:int;
         var target:DisplayObject = param1;
         var direction:int = param2;
         var scaleRate:Number = param3;
         var timelineLite:TimelineLite = param4;
         var delay:Number = param5;
         var bd:BitmapData = param6;
         var rect:Rectangle = param7;
         var pieceX:Number = param8;
         var pieceY:Number = param9;
         var pieceScaleX:int = param10;
         var r:Shape = createPiece(bd,rect,[{
            "x":0,
            "y":0
         },{
            "x":0,
            "y":rect.height
         },{
            "x":rect.width * 0.4,
            "y":rect.height
         },{
            "x":rect.width * 0.6,
            "y":0
         }]);
         r.x = pieceX;
         r.y = pieceY;
         toX = pieceX - direction * 0.33 * rect.width * scaleRate * 0.2;
         toY = pieceY + rect.height * scaleRate * 0.11;
         r.scaleX = pieceScaleX * scaleRate;
         r.scaleY = scaleRate;
         target.parent.addChildAt(r,target.parent.getChildIndex(target));
         timelineLite.insert(TweenLite.to(r,1,{
            "delay":delay,
            "x":toX,
            "y":toY
         }));
         timelineLite.insert(TweenLite.to(r,0.5,{
            "delay":delay + 0.5,
            "alpha":0,
            "onComplete":function(param1:Shape):void
            {
               if(param1.parent != null)
               {
                  param1.parent.removeChild(param1);
               }
            },
            "onCompleteParams":[r]
         }));
         r = createPiece(bd,rect,[{
            "x":rect.width * 0.4,
            "y":rect.height
         },{
            "x":rect.width,
            "y":rect.height
         },{
            "x":rect.width,
            "y":0
         },{
            "x":rect.width * 0.6,
            "y":0
         }]);
         r.x = pieceX;
         r.y = pieceY;
         toX = pieceX + direction * 0.33 * rect.width * scaleRate * 0.2;
         toY = pieceY - rect.height * scaleRate * 0.11;
         r.scaleX = pieceScaleX * scaleRate;
         r.scaleY = scaleRate;
         target.parent.addChildAt(r,target.parent.getChildIndex(target));
         timelineLite.insert(TweenLite.to(r,1,{
            "delay":delay,
            "x":toX,
            "y":toY
         }));
         timelineLite.insert(TweenLite.to(r,0.5,{
            "delay":delay + 0.5,
            "alpha":0,
            "onComplete":function(param1:Shape):void
            {
               bd.dispose();
               if(param1.parent != null)
               {
                  param1.parent.removeChild(param1);
               }
            },
            "onCompleteParams":[r]
         }));
      }
      
      private static function createPiece(param1:BitmapData, param2:Rectangle, param3:Array) : Shape
      {
         var _loc5_:int = 0;
         var _loc6_:Matrix = new Matrix();
         var _loc4_:Shape = new Shape();
         _loc4_.graphics.beginBitmapFill(param1,_loc6_,false,true);
         _loc4_.graphics.moveTo(param3[0].x,param3[0].y);
         _loc5_ = 1;
         while(_loc5_ < param3.length)
         {
            _loc4_.graphics.lineTo(param3[_loc5_].x,param3[_loc5_].y);
            _loc5_++;
         }
         _loc4_.graphics.endFill();
         return _loc4_;
      }
   }
}

