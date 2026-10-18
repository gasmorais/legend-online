package com.pickgliss.utils
{
   import com.pickgliss.ui.core.Component;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.filters.GradientGlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class EffectUtils
   {
      
      public function EffectUtils()
      {
         super();
      }
      
      public static function imageGlower(param1:DisplayObject, param2:Number, param3:Number, param4:Number, param5:String) : void
      {
         var _loc6_:Array = null;
         var _loc10_:Number = 0;
         var _loc7_:Number = 45;
         if(param5 == "gold")
         {
            _loc6_ = [6684672,16737792,16755200,16777164];
         }
         if(param5 == "blue")
         {
            _loc6_ = [13209,13209,39423,10079487];
         }
         if(param5 == "green")
         {
            _loc6_ = [26112,3381504,10092288,16777164];
         }
         if(param5 == "ocean")
         {
            _loc6_ = [13107,3368550,10079436,13434879];
         }
         if(param5 == "aqua")
         {
            _loc6_ = [13107,26214,52428,65535];
         }
         if(param5 == "ice")
         {
            _loc6_ = [13158,3368601,6724044,10079487];
         }
         if(param5 == "spark")
         {
            _loc6_ = [102,26265,3394815,13434879];
         }
         if(param5 == "silver")
         {
            _loc6_ = [3355443,6710886,12303291,16777215];
         }
         if(param5 == "neon")
         {
            _loc6_ = [3355596,6697932,10066431,13421823];
         }
         if(param5 == "yellow")
         {
            _loc6_ = [16776960,16776960,16776960,16776960];
         }
         var _loc14_:Array = [0,1,1,1];
         var _loc8_:Array = [0,63,126,255];
         var _loc16_:Number = param3;
         var _loc9_:Number = param3;
         var _loc15_:Number = param2;
         param4 = param4;
         var _loc13_:String = "outer";
         var _loc17_:Boolean = false;
         var _loc12_:GradientGlowFilter = new GradientGlowFilter(_loc10_,_loc7_,_loc6_,_loc14_,_loc8_,_loc16_,_loc9_,_loc15_,param4,_loc13_,_loc17_);
         var _loc11_:Array = [];
         _loc11_.push(_loc12_);
         param1.filters = _loc11_;
      }
      
      public static function imageShiner(param1:DisplayObject, param2:Number) : void
      {
         var _loc4_:ColorTransform = new ColorTransform();
         var _loc3_:Number = param2;
         _loc4_.redOffset = _loc3_;
         _loc4_.redMultiplier = _loc3_ / 100 + 1;
         _loc4_.greenOffset = _loc3_;
         _loc4_.greenMultiplier = _loc3_ / 100 + 1;
         _loc4_.blueOffset = _loc3_;
         _loc4_.blueMultiplier = _loc3_ / 100 + 1;
         param1.transform.colorTransform = _loc4_;
      }
      
      public static function creatMcToBitmap(param1:DisplayObject, param2:uint) : Bitmap
      {
         var _loc7_:Rectangle = param1.getRect(param1);
         var _loc3_:int = param1.width == 0 ? (param1 as Component).displayWidth : param1.width;
         var _loc4_:int = param1.height == 0 ? (param1 as Component).displayHeight : param1.height;
         var _loc6_:BitmapData = new BitmapData(_loc3_,_loc4_,true,param2);
         _loc6_.draw(param1,new Matrix(1,0,0,1,-_loc7_.left,-_loc7_.top));
         var _loc5_:Bitmap = new Bitmap(_loc6_,"auto",true);
         _loc5_.x = _loc7_.left;
         _loc5_.y = _loc7_.top;
         return _loc5_;
      }
      
      public static function toRadian(param1:Number) : Number
      {
         return 3.141592653589793 / 180 * param1;
      }
   }
}

