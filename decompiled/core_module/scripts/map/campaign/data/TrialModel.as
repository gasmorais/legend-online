package map.campaign.data
{
   public class TrialModel
   {
      
      public var shopList:Vector.<TrailPropInfo>;
      
      public var currentLayer:int;
      
      public var rewardExp:Number;
      
      public var rewardBox:int;
      
      public function TrialModel()
      {
         super();
         shopList = new Vector.<TrailPropInfo>();
      }
      
      public function resetShopList() : void
      {
         if(shopList)
         {
            shopList.splice(0,shopList.length);
         }
      }
      
      public function addShopItem(param1:TrailPropInfo) : void
      {
         shopList.push(param1);
      }
      
      public function getShopItemByIndex(param1:int) : TrailPropInfo
      {
         for each(var _loc2_:TrailPropInfo in shopList)
         {
            if(_loc2_.index == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

