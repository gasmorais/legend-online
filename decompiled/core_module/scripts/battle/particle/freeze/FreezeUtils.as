package battle.particle.freeze
{
   import battle.particle.Particle2D;
   import com.greensock.TimelineLite;
   import com.greensock.TweenLite;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class FreezeUtils
   {
      
      public static const burnTime:Number = 0.6;
      
      public static const crushTime:Number = 1;
      
      public function FreezeUtils()
      {
         super();
      }
      
      public static function freeze(param1:DisplayObject, param2:int, param3:Number, param4:TimelineLite, param5:Number, param6:Function, param7:Function) : void
      {
         var freezeParams:FreezeParams;
         var target:DisplayObject = param1;
         var direction:int = param2;
         var scaleRate:Number = param3;
         var timelineLite:TimelineLite = param4;
         var delay:Number = param5;
         var onStartCallback:Function = param6;
         var onEndCallback:Function = param7;
         var rect:Rectangle = target.getBounds(target);
         if(rect.width == 0 || rect.height == 0)
         {
            if(onEndCallback != null)
            {
               timelineLite.insert(TweenLite.delayedCall(delay,onEndCallback,null,false));
            }
            return;
         }
         freezeParams = new FreezeParams(target,direction,scaleRate);
         createParticleBM(freezeParams);
         if(onStartCallback != null)
         {
            timelineLite.insert(TweenLite.delayedCall(delay,onStartCallback,null,false));
         }
         timelineLite.insert(new TweenLite(freezeParams,0.6,{
            "delay":delay,
            "onUpdate":onParticleUpdateTurnBlack,
            "onUpdateParams":[freezeParams]
         }));
         timelineLite.insert(TweenLite.delayedCall(delay + 0.6,createScraps,[freezeParams]));
         timelineLite.insert(new TweenLite(freezeParams.particleBM,1,{
            "delay":delay + 0.6 + 0.2,
            "onUpdate":onParticleUpdateCrush,
            "onUpdateParams":[freezeParams],
            "onComplete":function():void
            {
               freezeParams.dispose();
               freezeParams = null;
            }
         }));
         if(onEndCallback != null)
         {
            timelineLite.insert(TweenLite.delayedCall(delay + 0.6 + 1 + 0.2,onEndCallback,null,false));
         }
      }
      
      private static function createParticleBM(param1:FreezeParams) : void
      {
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:DisplayObject = param1.target;
         var _loc10_:int = param1.direction;
         var _loc3_:Rectangle = _loc9_.getBounds(_loc9_);
         var _loc8_:Matrix = new Matrix();
         if(_loc10_ * _loc9_.scaleX == 1)
         {
            _loc8_.translate(-_loc3_.x,-_loc3_.y);
         }
         else
         {
            _loc8_.scale(-1,1);
            _loc8_.translate(_loc3_.width + _loc3_.x,-_loc3_.y);
         }
         var _loc4_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         _loc4_.draw(_loc9_,_loc8_);
         var _loc2_:Array = [];
         _loc6_ = 1;
         while(_loc6_ <= _loc4_.height)
         {
            _loc7_ = 1;
            while(_loc7_ <= _loc4_.width)
            {
               _loc5_ = _loc4_.getPixel32(_loc7_,_loc6_);
               if(_loc5_ != 0)
               {
                  _loc2_.push(new Particle2D(_loc7_,_loc6_,_loc5_,Math.random() * 40,(0.5 - Math.random()) * 25));
               }
               _loc7_++;
            }
            _loc6_++;
         }
         _loc4_.dispose();
         param1.particleArray = _loc2_.reverse();
         param1.blackStep = _loc2_.length / 15;
         param1.particleBMwidth = _loc3_.width;
         param1.particleBMheight = _loc3_.height;
         if(_loc10_ * _loc9_.scaleX == 1)
         {
            param1.particleBM.x = _loc9_.x + _loc10_ * _loc3_.x * param1.scaleRate;
         }
         else
         {
            param1.particleBM.x = _loc9_.x - _loc10_ * (_loc3_.width + _loc3_.x) * param1.scaleRate;
         }
         param1.particleBM.y = (_loc9_.y + _loc3_.y) * param1.scaleRate;
         param1.particleBM.scaleX = _loc10_ * param1.scaleRate;
         param1.particleBM.scaleY = param1.scaleRate;
         _loc9_.parent.addChildAt(param1.particleBM,_loc9_.parent.getChildIndex(_loc9_));
      }
      
      private static function createScraps(param1:FreezeParams) : void
      {
         var _loc4_:ScrapShape = null;
         var _loc2_:Sprite = new Sprite();
         _loc2_.mouseChildren = false;
         _loc2_.mouseEnabled = false;
         var _loc7_:DisplayObject = param1.target;
         var _loc5_:Bitmap = param1.particleBM;
         var _loc8_:Polygon = new Polygon([new Point(0,0),new Point(param1.particleBMwidth,0),new Point(param1.particleBMwidth,param1.particleBMheight),new Point(0,param1.particleBMheight)]);
         var _loc3_:Array = [];
         Polygon.breakPolygon(_loc8_,7,_loc3_);
         var _loc6_:Point = new Point(param1.particleBMwidth * 0.5,param1.particleBMheight * 0.5);
         param1.scrapArray = new Vector.<ScrapShape>();
         for each(_loc8_ in _loc3_)
         {
            _loc4_ = new ScrapShape(_loc5_.bitmapData,_loc8_,_loc6_,param1.particleBMheight);
            _loc2_.addChild(_loc4_);
            param1.scrapArray.push(_loc4_);
         }
         _loc2_.x = _loc5_.x;
         _loc2_.y = _loc5_.y;
         _loc2_.scaleX = _loc5_.scaleX;
         _loc2_.scaleY = param1.scaleRate;
         _loc7_.parent.addChildAt(_loc2_,_loc7_.parent.getChildIndex(_loc7_));
         param1.particleBM.parent.removeChild(param1.particleBM);
      }
      
      private static function onParticleUpdateTurnBlack(param1:FreezeParams) : void
      {
         var _loc3_:* = 0;
         var _loc5_:* = 0;
         var _loc9_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc10_:int = 0;
         var _loc4_:BitmapData = new BitmapData(param1.particleBMwidth,param1.particleBMheight,true,0);
         var _loc8_:int = param1.currentIndex + param1.blackStep;
         if(_loc8_ < param1.particleArray.length)
         {
            _loc10_ = param1.currentIndex;
            while(_loc10_ < _loc8_)
            {
               _loc7_ = uint(param1.particleArray[_loc10_].color);
               _loc3_ = uint(_loc7_ >> 24);
               _loc5_ = uint(_loc7_ >> 16 & 0xFF);
               _loc5_ = uint(_loc5_ + 80 < 255 ? _loc5_ + 80 : 255);
               _loc9_ = uint(_loc7_ >> 8 & 0xFF);
               _loc9_ = uint(_loc9_ + 80 < 255 ? _loc9_ + 80 : 255);
               _loc6_ = uint(_loc7_ & 0xFF);
               _loc6_ = uint(_loc6_ + 80 < 255 ? _loc6_ + 80 : 255);
               param1.particleArray[_loc10_].color = _loc3_ << 24 | _loc5_ << 16 | _loc9_ << 8 | _loc6_;
               _loc10_++;
            }
            param1.currentIndex = _loc8_;
         }
         else
         {
            _loc8_ = int(param1.particleArray.length);
            _loc10_ = param1.currentIndex;
            while(_loc10_ < _loc8_)
            {
               _loc7_ = uint(param1.particleArray[_loc10_].color);
               _loc3_ = uint(_loc7_ >> 24);
               _loc5_ = uint(_loc7_ >> 16 & 0xFF);
               _loc5_ = uint(_loc5_ + 80 < 255 ? _loc5_ + 80 : 255);
               _loc9_ = uint(_loc7_ >> 8 & 0xFF);
               _loc9_ = uint(_loc9_ + 80 < 255 ? _loc9_ + 80 : 255);
               _loc6_ = uint(_loc7_ & 0xFF);
               _loc6_ = uint(_loc6_ + 80 < 255 ? _loc6_ + 80 : 255);
               param1.particleArray[_loc10_].color = _loc3_ << 24 | _loc5_ << 16 | _loc9_ << 8 | _loc6_;
               _loc10_++;
            }
            param1.currentIndex = _loc8_;
         }
         for each(var _loc2_:Particle2D in param1.particleArray)
         {
            _loc4_.setPixel32(_loc2_.x,_loc2_.y,_loc2_.color);
         }
         if(param1.particleBM.bitmapData)
         {
            param1.particleBM.bitmapData.dispose();
         }
         param1.particleBM.bitmapData = _loc4_;
         param1.particleBM.x += param1.shakeFlag * 1;
         param1.shakeFlag *= -1;
      }
      
      private static function onParticleUpdateCrush(param1:FreezeParams) : void
      {
         for each(var _loc2_:ScrapShape in param1.scrapArray)
         {
            _loc2_.update();
         }
      }
   }
}

