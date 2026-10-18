package com.greensock.plugins
{
   import com.greensock.*;
   import flash.display.*;
   import flash.geom.*;
   
   public class TransformAroundCenterPlugin extends TransformAroundPointPlugin
   {
      
      public static const API:Number = 1;
      
      public function TransformAroundCenterPlugin()
      {
         super();
         this.propName = "transformAroundCenter";
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         var _loc5_:Sprite = null;
         var _loc8_:Boolean = false;
         var _loc6_:DisplayObject = param1 as DisplayObject;
         if(_loc6_.parent == null)
         {
            _loc8_ = true;
            _loc5_ = new Sprite();
            _loc5_.addChild(_loc6_);
         }
         var _loc4_:Rectangle = _loc6_.getBounds(_loc6_.parent);
         param2.point = new Point(_loc4_.x + _loc4_.width * 0.5,_loc4_.y + _loc4_.height * 0.5);
         if(_loc8_)
         {
            _loc6_.parent.removeChild(_loc6_);
         }
         var _loc7_:Boolean = super.onInitTween(_loc6_,param2,param3);
         if(_loc4_.width < 1 || _loc4_.height < 1)
         {
            _loc4_ = _loc6_.getBounds(_loc6_);
            _local = new Point(_loc4_.x + _loc4_.width * 0.5,_loc4_.y + _loc4_.height * 0.5);
         }
         return _loc7_;
      }
   }
}

