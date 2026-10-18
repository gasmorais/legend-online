package yishi.utils
{
   import com.greensock.TweenMax;
   import flash.display.DisplayObject;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   
   public class FlickerHelper
   {
      
      private static var _blinkIIColor:ColorTransform;
      
      public function FlickerHelper()
      {
         super();
      }
      
      public static function setFlash(param1:DisplayObject, param2:Number, param3:Number) : void
      {
         if(!param1)
         {
            return;
         }
         clearFilcker(param1);
         TweenMax.to(param1,param2,{
            "alpha":param3,
            "repeat":-1,
            "yoyo":true
         });
      }
      
      public static function setFilcker(param1:DisplayObject) : void
      {
         if(!param1)
         {
            return;
         }
         clearFilcker(param1);
         param1.filters = [new GlowFilter(16763955,1,20,20,1,1)];
         TweenMax.to(param1,0.5,{
            "glowFilter":{
               "color":16763955,
               "alpha":1,
               "blurX":31,
               "blurY":31,
               "strength":2,
               "quality":1
            },
            "repeat":-1,
            "yoyo":true
         });
      }
      
      public static function setFilcker2(param1:DisplayObject) : void
      {
         if(!param1)
         {
            return;
         }
         clearFilcker(param1);
         TweenMax.to(param1,0.5,{
            "glowFilter":{
               "color":16763955,
               "alpha":1,
               "blurX":15,
               "blurY":15,
               "strength":2,
               "quality":1
            },
            "repeat":-1,
            "yoyo":true
         });
      }
      
      public static function setFilckerInside(param1:DisplayObject) : void
      {
         if(!param1)
         {
            return;
         }
         clearFilcker(param1);
         TweenMax.to(param1,0.5,{
            "glowFilter":{
               "color":16763955,
               "alpha":1,
               "blurX":15,
               "blurY":15,
               "strength":2,
               "quality":1,
               "inner":true
            },
            "repeat":-1,
            "yoyo":true
         });
      }
      
      public static function setFilcker3(param1:DisplayObject, param2:Object = null) : void
      {
         var repeatCount:int;
         var completeCall:Function;
         var completeCallParams:Array;
         var dis:DisplayObject = param1;
         var extra:Object = param2;
         if(!dis)
         {
            return;
         }
         clearFilcker(dis);
         repeatCount = int(extra && extra.hasOwnProperty("repeat") ? int(extra.repeat) : 5);
         completeCall = extra && extra.hasOwnProperty("onComplete") ? extra.onComplete as Function : null;
         completeCallParams = extra && extra.hasOwnProperty("onCompleteParams") ? extra.onCompleteParams as Array : null;
         TweenMax.to(dis,0.4,{
            "glowFilter":{
               "color":16763955,
               "alpha":1,
               "blurX":10,
               "blurY":10,
               "strength":2.5,
               "quality":1
            },
            "repeat":repeatCount,
            "yoyo":true,
            "onComplete":function():void
            {
               clearFilcker(dis);
               if(null != completeCall)
               {
                  completeCall.apply(null,completeCallParams);
               }
            }
         });
      }
      
      public static function setFilckerSelf(param1:DisplayObject) : void
      {
         if(!param1)
         {
            return;
         }
         clearFilcker(param1);
         param1.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,1);
         TweenMax.to(param1,0.4,{
            "colorTransform":{
               "redMultiplier":1,
               "greenMultiplier":1,
               "blueMultiplier":1,
               "redOffset":102,
               "greenOffset":70,
               "blueOffset":50
            },
            "repeat":-1,
            "yoyo":true
         });
      }
      
      public static function clearFilcker(param1:DisplayObject) : void
      {
         if(!param1)
         {
            return;
         }
         if(!TweenMax.isTweening(param1))
         {
            return;
         }
         TweenMax.killTweensOf(param1,true);
         param1.filters = null;
      }
      
      public static function blinkObj(param1:DisplayObject, param2:Object = null) : void
      {
         var tweenObj:Object;
         var obj:DisplayObject = param1;
         var extra:Object = param2;
         var repeatCount:int = int(extra && extra.repeat ? extra.repeat as int : 1);
         var durationCount:Number = extra && extra.duration ? extra.duration as Number : 0.6;
         var onComplete:Function = extra && extra.onComplete ? extra.onComplete as Function : null;
         var onCompleteParams:Array = extra && extra.onCompleteParams ? extra.onCompleteParams as Array : null;
         var delay:Number = Number(extra && extra.delay ? extra.delay as Number : null);
         var tweenColorMatrixFilter:Boolean = extra && extra.hasOwnProperty("tweenColorMatrixFilter") ? extra.tweenColorMatrixFilter as Boolean : true;
         var tweenComplete:Function = function():void
         {
            clearFilcker(obj);
            if(null != onComplete)
            {
               onComplete.apply(null,onCompleteParams);
            }
         };
         clearFilcker(obj);
         tweenObj = {
            "delay":delay,
            "onComplete":tweenComplete,
            "glowFilter":{
               "color":16777113,
               "alpha":1,
               "blurX":12,
               "blurY":12,
               "strength":1,
               "quality":2
            },
            "repeat":repeatCount,
            "yoyo":true
         };
         if(tweenColorMatrixFilter)
         {
            tweenObj.colorMatrixFilter = {
               "brightness":2,
               "contrast":4
            };
         }
         TweenMax.to(obj,durationCount,tweenObj);
      }
      
      public static function blinkII(param1:DisplayObject, param2:Boolean) : void
      {
         var __onUpdate:Function;
         var mc:DisplayObject = param1;
         var isClean:Boolean = param2;
         if(isClean)
         {
            if(_blinkIIColor)
            {
               TweenMax.killTweensOf(_blinkIIColor);
               _blinkIIColor = null;
            }
            if(mc)
            {
               mc.transform.colorTransform = new ColorTransform();
            }
         }
         else
         {
            blinkII(mc,true);
            __onUpdate = function():void
            {
               mc.transform.colorTransform = _blinkIIColor;
            };
            _blinkIIColor = new ColorTransform(0.3,0.3,0.3,1,179,143,0,1);
            mc.transform.colorTransform = _blinkIIColor;
            TweenMax.to(_blinkIIColor,0.5,{
               "repeat":-1,
               "yoyo":true,
               "delay":0.3,
               "redMultiplier":1,
               "greenMultiplier":1,
               "blueMultiplier":1,
               "redOffset":0,
               "greenOffset":0,
               "onUpdate":__onUpdate
            });
         }
      }
      
      public static function jumpFilcker(param1:DisplayObject, param2:int) : void
      {
         if(!param1)
         {
            return;
         }
         clearFilcker(param1);
         TweenMax.to(param1,0.5,{
            "y":param2,
            "repeat":-1,
            "yoyo":true
         });
      }
   }
}

