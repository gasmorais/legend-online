package avatar.data
{
   import com.pickgliss.loader.DomainResourceLoad;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import flash.display.BitmapData;
   import flash.system.ApplicationDomain;
   
   public class CampaignAvatarBaseLayer
   {
      
      public var resourceInfo:ResourceLoaderInfo;
      
      public var curBaseNum:Number = 0;
      
      public var visible:Boolean = true;
      
      public var offsetX:int = 0;
      
      public var offsetY:int = 0;
      
      public var flight:int = 0;
      
      public var layouPara:AvatarLayouData;
      
      public var loadOver:Boolean;
      
      public var sizeType:int;
      
      private var _tempBitmapData:BitmapData;
      
      private var _domain:ApplicationDomain;
      
      public function CampaignAvatarBaseLayer()
      {
         super();
         _domain = DomainResourceLoad.loaderContext.applicationDomain;
      }
      
      public function get tempBitmapData() : BitmapData
      {
         return _tempBitmapData;
      }
      
      public function set tempBitmapData(param1:BitmapData) : void
      {
         if(_tempBitmapData)
         {
            _tempBitmapData.dispose();
         }
         _tempBitmapData = null;
         _tempBitmapData = param1;
      }
      
      public function getStandCellByFrame(param1:int, param2:int) : void
      {
         var _loc4_:* = undefined;
         if(!resourceInfo)
         {
            return;
         }
         var _loc3_:String = resourceInfo.packageName + "S_" + param1 + "_" + param2;
         if(_domain && _domain.hasDefinition(_loc3_))
         {
            _loc4_ = _domain.getDefinition(_loc3_);
            tempBitmapData = new _loc4_() as BitmapData;
         }
      }
      
      public function getWalksCellByFrame(param1:int, param2:int) : void
      {
         var _loc4_:* = undefined;
         if(!resourceInfo)
         {
            return;
         }
         var _loc3_:String = resourceInfo.packageName + "W_" + param1 + "_" + param2;
         if(_domain && _domain.hasDefinition(_loc3_))
         {
            _loc4_ = _domain.getDefinition(_loc3_);
            tempBitmapData = new _loc4_() as BitmapData;
         }
      }
      
      public function dispose() : void
      {
         tempBitmapData = null;
         _domain = null;
      }
   }
}

