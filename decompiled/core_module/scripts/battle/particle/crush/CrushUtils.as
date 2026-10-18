package battle.particle.crush
{
   import battle.particle.Particle2D;
   import com.greensock.TimelineLite;
   import com.greensock.TweenLite;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class CrushUtils
   {
      
      public static const burnTime:Number = 0.6;
      
      public static const crushTime:Number = 0.6;
      
      private static var constTme:Number = 0;
      
      public function CrushUtils()
      {
         super();
      }
      
      public static function crush(param1:DisplayObject, param2:int, param3:Number, param4:TimelineLite, param5:Number, param6:Function, param7:Function) : void
      {
         var crushParams:CrushParams;
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
         crushParams = new CrushParams(target,direction,scaleRate);
         constTme = getTimer();
         createParticleBM(crushParams);
         if(crushParams.particleBMwidth == 0 || crushParams.particleBMheight == 0)
         {
            return;
         }
         if(onStartCallback != null)
         {
            timelineLite.insert(TweenLite.delayedCall(delay,onStartCallback,null,false));
         }
         timelineLite.insert(new TweenLite(crushParams,0.6,{
            "delay":delay,
            "onUpdate":onParticleUpdateTurnBlack,
            "onUpdateParams":[crushParams]
         }));
         timelineLite.insert(new TweenLite(crushParams.particleBM,0.6,{
            "alpha":0,
            "delay":delay + 0.6,
            "onUpdate":onParticleUpdateCrush,
            "onUpdateParams":[crushParams],
            "onComplete":function():void
            {
               crushParams.dispose();
               crushParams = null;
            }
         }));
         if(onEndCallback != null)
         {
            timelineLite.insert(TweenLite.delayedCall(delay + 0.6 + 0.6,onEndCallback,null,false));
         }
      }
      
      private static function createParticleBM(param1:CrushParams) : void
      {
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:DisplayObject = param1.target;
         var _loc10_:int = param1.direction;
         var _loc3_:Rectangle = _loc9_.getBounds(_loc9_);
         if(_loc3_.width == 0 || _loc3_.height == 0)
         {
            return;
         }
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
                  _loc2_.push(new Particle2D(_loc7_,_loc6_ + _loc3_.height,_loc5_,Math.random() * 40,(0.5 - Math.random()) * 25));
               }
               _loc7_++;
            }
            _loc6_++;
         }
         _loc4_.dispose();
         param1.particleArray = _loc2_;
         param1.blackStep = _loc2_.length / 20;
         param1.particleBMwidth = _loc3_.width * 3;
         param1.particleBMheight = _loc3_.height * 3;
         if(_loc10_ * _loc9_.scaleX == 1)
         {
            param1.particleBM.x = _loc9_.x + _loc10_ * _loc3_.x * param1.scaleRate;
         }
         else
         {
            param1.particleBM.x = _loc9_.x - _loc10_ * (_loc3_.width + _loc3_.x) * param1.scaleRate;
         }
         param1.particleBM.y = (_loc9_.y + _loc3_.y - _loc3_.height) * param1.scaleRate;
         param1.particleBM.scaleX = _loc10_ * param1.scaleRate;
         param1.particleBM.scaleY = param1.scaleRate;
         _loc9_.parent.addChildAt(param1.particleBM,_loc9_.parent.getChildIndex(_loc9_));
      }
      
      private static function onParticleUpdateTurnBlack(param1:CrushParams) : void
      {
         var _loc3_:* = 0;
         var _loc5_:* = 0;
         var _loc9_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc10_:int = 0;
         constTme = getTimer();
         var _loc4_:BitmapData = new BitmapData(param1.particleBMwidth,param1.particleBMheight,true,0);
         var _loc8_:int = param1.currentIndex + param1.blackStep;
         if(_loc8_ < param1.particleArray.length)
         {
            _loc10_ = param1.currentIndex;
            while(_loc10_ < _loc8_)
            {
               _loc7_ = uint(param1.particleArray[_loc10_].color);
               _loc3_ = uint(_loc7_ >> 24);
               _loc5_ = uint((_loc7_ >> 16 & 0xFF) * 0.4);
               _loc9_ = uint((_loc7_ >> 8 & 0xFF) * 0.4);
               _loc6_ = uint((_loc7_ & 0xFF) * 0.4);
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
               _loc5_ = uint((_loc7_ >> 16 & 0xFF) * 0.4);
               _loc9_ = uint((_loc7_ >> 8 & 0xFF) * 0.4);
               _loc6_ = uint((_loc7_ & 0xFF) * 0.4);
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
      
      private static function onParticleUpdateCrush(param1:CrushParams) : void
      {
         constTme = getTimer();
         var _loc3_:BitmapData = new BitmapData(param1.particleBMwidth,param1.particleBMheight,true,0);
         for each(var _loc2_:Particle2D in param1.particleArray)
         {
            _loc2_.x += _loc2_.offsetX;
            _loc2_.y += _loc2_.offsetY;
            _loc3_.setPixel32(_loc2_.x,_loc2_.y,_loc2_.color);
            _loc3_.setPixel32(_loc2_.x + 1,_loc2_.y,_loc2_.color);
            _loc3_.setPixel32(_loc2_.x,_loc2_.y + 1,_loc2_.color);
            _loc3_.setPixel32(_loc2_.x + 1,_loc2_.y + 1,_loc2_.color);
         }
         if(param1.particleBM.bitmapData)
         {
            param1.particleBM.bitmapData.dispose();
         }
         param1.particleBM.bitmapData = _loc3_;
      }
   }
}

