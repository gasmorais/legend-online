package com.road.mapengine.bitmap.load
{
   import com.pickgliss.loader.DomainResourceLoad;
   import flash.display.BitmapData;
   
   public class ResourceXYInfo extends ResourceInfo
   {
      
      public function ResourceXYInfo()
      {
         super();
      }
      
      public function getBitmapXYByFrame(param1:int, param2:int) : void
      {
         var _loc4_:* = undefined;
         var _loc3_:String = packageName + "" + param1 + "_" + param2;
         if(DomainResourceLoad.loaderContext && DomainResourceLoad.loaderContext.applicationDomain.hasDefinition(_loc3_))
         {
            _loc4_ = DomainResourceLoad.loaderContext.applicationDomain.getDefinition(_loc3_);
            nextBitmapData = new _loc4_() as BitmapData;
         }
      }
   }
}

