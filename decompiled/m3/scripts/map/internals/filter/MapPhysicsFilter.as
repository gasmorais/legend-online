package map.internals.filter
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import flash.display.DisplayObject;
   import yishi.interfaces.IFilterFormat;
   
   public class MapPhysicsFilter implements IFilterFormat
   {
      
      public function MapPhysicsFilter()
      {
         super();
      }
      
      public function setLightingFilter(param1:DisplayObject) : void
      {
      }
      
      public function setGrayFilter(param1:DisplayObject) : void
      {
      }
      
      public function setNormalFilter(param1:DisplayObject) : void
      {
         TweenLite.killTweensOf(param1,false);
         param1.filters = null;
      }
      
      public function setRedFilter(param1:DisplayObject) : void
      {
         TweenMax.to(param1,0.5,{
            "glowFilter":{
               "color":16711680,
               "alpha":1,
               "blurX":17,
               "blurY":17
            },
            "repeat":-1,
            "yoyo":true
         });
      }
   }
}

