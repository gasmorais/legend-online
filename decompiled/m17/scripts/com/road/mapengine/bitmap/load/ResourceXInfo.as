package com.road.mapengine.bitmap.load
{
   import com.pickgliss.loader.DomainResourceLoad;
   import flash.display.BitmapData;
   
   public class ResourceXInfo extends ResourceInfo
   {
      
      public function ResourceXInfo()
      {
         super();
      }
      
      public function getBitmapXByFrame(param1:int) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:String = packageName + "" + param1 + "_0";
         if(DomainResourceLoad.loaderContext && DomainResourceLoad.loaderContext.applicationDomain.hasDefinition(_loc2_))
         {
            _loc3_ = DomainResourceLoad.loaderContext.applicationDomain.getDefinition(_loc2_);
            nextBitmapData = new _loc3_() as BitmapData;
         }
      }
   }
}

