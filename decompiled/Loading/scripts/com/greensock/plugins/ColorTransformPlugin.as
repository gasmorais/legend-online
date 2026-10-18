package com.greensock.plugins
{
   import com.greensock.*;
   import flash.display.*;
   import flash.geom.ColorTransform;
   
   public class ColorTransformPlugin extends TintPlugin
   {
      
      public static const API:Number = 1;
      
      public function ColorTransformPlugin()
      {
         super();
         this.propName = "colorTransform";
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         var _loc6_:Number = NaN;
         if(!(param1 is DisplayObject))
         {
            return false;
         }
         var _loc5_:ColorTransform = param1.transform.colorTransform;
         for(var _loc4_:String in param2)
         {
            if(_loc4_ == "tint" || _loc4_ == "color")
            {
               if(param2[_loc4_] != null)
               {
                  _loc5_.color = int(param2[_loc4_]);
               }
            }
            else if(!(_loc4_ == "tintAmount" || _loc4_ == "exposure" || _loc4_ == "brightness"))
            {
               _loc5_[_loc4_] = param2[_loc4_];
            }
         }
         if(!isNaN(param2.tintAmount))
         {
            _loc6_ = param2.tintAmount / (1 - (_loc5_.redMultiplier + _loc5_.greenMultiplier + _loc5_.blueMultiplier) / 3);
            _loc5_.redOffset *= _loc6_;
            _loc5_.greenOffset *= _loc6_;
            _loc5_.blueOffset *= _loc6_;
            _loc5_.redMultiplier = _loc5_.greenMultiplier = _loc5_.blueMultiplier = 1 - param2.tintAmount;
         }
         else if(!isNaN(param2.exposure))
         {
            _loc5_.redOffset = _loc5_.greenOffset = _loc5_.blueOffset = 255 * (param2.exposure - 1);
            _loc5_.redMultiplier = _loc5_.greenMultiplier = _loc5_.blueMultiplier = 1;
         }
         else if(!isNaN(param2.brightness))
         {
            _loc5_.redOffset = _loc5_.greenOffset = _loc5_.blueOffset = Math.max(0,(param2.brightness - 1) * 255);
            _loc5_.redMultiplier = _loc5_.greenMultiplier = _loc5_.blueMultiplier = 1 - Math.abs(param2.brightness - 1);
         }
         _ignoreAlpha = param3.vars.alpha != undefined && param2.alphaMultiplier == undefined;
         init(param1 as DisplayObject,_loc5_);
         return true;
      }
   }
}

