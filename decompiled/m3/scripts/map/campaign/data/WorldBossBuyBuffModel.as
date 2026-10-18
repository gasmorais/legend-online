package map.campaign.data
{
   import flash.events.EventDispatcher;
   import yishi.manager.TempleteManager;
   
   public class WorldBossBuyBuffModel extends EventDispatcher
   {
      
      public static const BUY_TYPE_POINT:int = 1;
      
      public static const BUY_TYPE_GIFTTOKEN:int = 2;
      
      public static const BUFFER_TYPE:int = 4;
      
      private static var _usePointCount:int = 0;
      
      private static var _useGiftCount:int = 0;
      
      public var currentType:int;
      
      public var currentPointCost:int = 0;
      
      public var currentGiftCost:int = 0;
      
      public var currentPrecent:int = 0;
      
      public var bufferList:Array;
      
      public var isLimit:Boolean = false;
      
      public function WorldBossBuyBuffModel()
      {
         super();
         bufferList = [];
         bufferList[0] = {"Live":0};
         var _loc2_:Array = TempleteManager.instance.campaignBufferTemplate.getTemplateByType(4);
         bufferList = bufferList.concat(_loc2_);
         var _loc1_:TempleteManager = TempleteManager.instance;
         currentPointCost = parseInt(_loc1_.getConfigInfoByConfigName("WorldBoss_Buffer_Diamond_Price").ConfigValue);
         currentGiftCost = parseInt(_loc1_.getConfigInfoByConfigName("WorldBoss_Buffer_Gift_Price").ConfigValue);
         _loc1_ = null;
      }
      
      public function clear() : void
      {
         WorldBossBuyBuffModel._usePointCount = 0;
         WorldBossBuyBuffModel._useGiftCount = 0;
      }
      
      public function get usePointCount() : int
      {
         return _usePointCount;
      }
      
      public function set usePointCount(param1:int) : void
      {
         _usePointCount = param1;
      }
      
      public function get useGiftCount() : int
      {
         return _useGiftCount;
      }
      
      public function set useGiftCount(param1:int) : void
      {
         _useGiftCount = param1;
      }
   }
}

