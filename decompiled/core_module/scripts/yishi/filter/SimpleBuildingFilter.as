package yishi.filter
{
   import flash.display.DisplayObject;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import yishi.interfaces.IBuildingFilter;
   
   public class SimpleBuildingFilter implements IBuildingFilter
   {
      
      protected var lightingFilter:ColorMatrixFilter;
      
      protected var glow:GlowFilter;
      
      protected var orangeGlow:GlowFilter;
      
      protected var grayFilter:ColorMatrixFilter;
      
      protected var lightFilter:ColorMatrixFilter;
      
      public function SimpleBuildingFilter()
      {
         super();
         setupGrayFilter();
         setupLightingFilter();
         setupLightFilter();
         setupGlowFilter();
      }
      
      private function setupGrayFilter() : void
      {
         var _loc1_:Array = [0.3,0.6,0.1,0,0,0.3,0.6,0.1,0,0,0.3,0.6,0.1,0,0,0,0,0,1,0];
         grayFilter = new ColorMatrixFilter(_loc1_);
      }
      
      private function setupLightingFilter() : void
      {
         var _loc1_:Array = [];
         _loc1_ = _loc1_.concat([1,0,0,0,60]);
         _loc1_ = _loc1_.concat([0,1,0,0,60]);
         _loc1_ = _loc1_.concat([0,0,1,0,60]);
         _loc1_ = _loc1_.concat([0,0,0,1,0]);
         lightingFilter = new ColorMatrixFilter(_loc1_);
         glow = new GlowFilter(16776960,1,5,5,3,2);
      }
      
      private function setupLightFilter() : void
      {
         var _loc1_:Array = [];
         _loc1_ = _loc1_.concat([1,0,0,0,50]);
         _loc1_ = _loc1_.concat([0,1,0,0,50]);
         _loc1_ = _loc1_.concat([0,0,1,0,50]);
         _loc1_ = _loc1_.concat([0,0,0,1,0]);
         lightFilter = new ColorMatrixFilter(_loc1_);
      }
      
      private function setupGlowFilter() : void
      {
         orangeGlow = new GlowFilter(15978275,1,10,10,2.5,1);
      }
      
      public function setLightFilter(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.filters = [lightFilter];
      }
      
      public function setLightingFilter(param1:DisplayObject) : void
      {
         param1.filters = [lightingFilter,glow];
      }
      
      public function setGlowFilter(param1:DisplayObject) : void
      {
         param1.filters = [orangeGlow];
      }
      
      public function setBuildingOverFilter(param1:DisplayObject) : void
      {
         setLightingFilter(param1);
      }
      
      public function setGrayFilter(param1:DisplayObject) : void
      {
         param1.filters = [grayFilter];
      }
      
      public function setBuildingOutFilter(param1:DisplayObject) : void
      {
         setNormalFilter(param1);
      }
      
      public function setNormalFilter(param1:DisplayObject) : void
      {
         param1.filters = [];
      }
      
      public function setBuildingBuildingFilter(param1:DisplayObject) : void
      {
         setGrayFilter(param1);
      }
      
      public function setBuildingFinishFilter(param1:DisplayObject) : void
      {
         setNormalFilter(param1);
      }
      
      public function setRedFilter(param1:DisplayObject) : void
      {
      }
      
      public function dispose() : void
      {
         lightingFilter = null;
         glow = null;
         orangeGlow = null;
         grayFilter = null;
         lightFilter = null;
      }
   }
}

