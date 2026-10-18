package yishi.filter
{
   import flash.display.DisplayObject;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import yishi.interfaces.IFilterFormat;
   
   public class UIFilter implements IFilterFormat
   {
      
      protected var lightingFilter:ColorMatrixFilter;
      
      protected var grayFilter:ColorMatrixFilter;
      
      protected var redFilter:ColorMatrixFilter;
      
      public function UIFilter()
      {
         super();
         setupGrayFilter();
         setupLightingFilter();
         setupRedFilter();
      }
      
      public static function getRedFilter() : ColorMatrixFilter
      {
         var _loc1_:Array = [];
         _loc1_ = _loc1_.concat([1,0,0,0,0]);
         _loc1_ = _loc1_.concat([0,0.1,0,0,0]);
         _loc1_ = _loc1_.concat([0,0,0.1,0,0]);
         _loc1_ = _loc1_.concat([0,0,0,1,0]);
         return new ColorMatrixFilter(_loc1_);
      }
      
      public static function getLightingFilter() : ColorMatrixFilter
      {
         var _loc1_:Array = [];
         _loc1_ = _loc1_.concat([1,0,0,0,35]);
         _loc1_ = _loc1_.concat([0,1,0,0,35]);
         _loc1_ = _loc1_.concat([0,0,1,0,35]);
         _loc1_ = _loc1_.concat([0,0,0,1,0]);
         return new ColorMatrixFilter(_loc1_);
      }
      
      public static function getDarkFilter() : ColorMatrixFilter
      {
         var _loc1_:Array = [];
         _loc1_ = _loc1_.concat([0.3,0,0,0,0]);
         _loc1_ = _loc1_.concat([0,0.3,0,0,0]);
         _loc1_ = _loc1_.concat([0,0,0.3,0,0]);
         _loc1_ = _loc1_.concat([0,0,0,1,0]);
         return new ColorMatrixFilter(_loc1_);
      }
      
      public static function getGrayFilter() : ColorMatrixFilter
      {
         return new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0]);
      }
      
      public static function getBlackFilter() : ColorMatrixFilter
      {
         return new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]);
      }
      
      public static function getRoomIconFilter() : ColorMatrixFilter
      {
         return new ColorMatrixFilter([0.55,0.4,0.05,0,-13,0.2,0.75,0.05,0,-13,0.2,0.4,0.4,0,-13,0,0,0,1,0,0,0,0,0,1]);
      }
      
      public static function getGlowFilter(param1:uint = 16776960, param2:Number = 4, param3:Number = 4) : GlowFilter
      {
         var _loc6_:Number = 0.8;
         var _loc5_:Number = 3;
         var _loc7_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc8_:Number = 3;
         return new GlowFilter(param1,_loc6_,param2,param3,_loc5_,_loc8_,_loc7_,_loc4_);
      }
      
      public static function getTextBorderingFilter() : GlowFilter
      {
         return new GlowFilter(0,1,3,3,10);
      }
      
      private function setupGrayFilter() : void
      {
         grayFilter = getGrayFilter();
      }
      
      private function setupLightingFilter() : void
      {
         lightingFilter = getLightingFilter();
      }
      
      private function setupRedFilter() : void
      {
         redFilter = getRedFilter();
      }
      
      public function setLightingFilter(param1:DisplayObject) : void
      {
         param1.filters = [lightingFilter];
      }
      
      public function setGrayFilter(param1:DisplayObject) : void
      {
         param1.filters = [grayFilter];
      }
      
      public function setNormalFilter(param1:DisplayObject) : void
      {
         param1.filters = [];
      }
      
      public function setRedFilter(param1:DisplayObject) : void
      {
         param1.filters = [redFilter];
      }
   }
}

