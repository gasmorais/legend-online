package mvc.module.sale
{
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.utils.SimpleDictionary;
   
   public class SaleModel
   {
      
      public static const UPGRADE_TYPE:int = 116;
      
      public static const TITAN_STONE_ID:int = 208054;
      
      public static const TITAN_DATA_CHECK:String = "TITAN_DATA_CHECK";
      
      public var previewType:int;
      
      public var specialId:int;
      
      public var leftSecond:int;
      
      public var specialItem:SaleData;
      
      public var isOpen:Boolean = false;
      
      public var items:Vector.<SaleData>;
      
      public var luckShowInfo:Array;
      
      public var allItems:Vector.<SaleData>;
      
      public function SaleModel()
      {
         super();
         items = new Vector.<SaleData>(5);
      }
      
      public function getPreviewList() : SimpleDictionary
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:GoodsInfo = null;
         var _loc3_:SimpleDictionary = new SimpleDictionary(true);
         if(allItems && allItems.length > 0)
         {
            allItems = allItems.sort(sortFun);
            _loc1_ = 0;
            _loc2_ = 0;
            while(_loc2_ < allItems.length)
            {
               _loc4_ = getNewGoods(_loc1_,allItems[_loc2_]);
               if(previewType == 1)
               {
                  _loc3_.add(_loc4_.id,_loc4_);
                  _loc1_++;
               }
               else if(previewType == 2 && allItems[_loc2_].fixPoint == 0)
               {
                  _loc3_.add(_loc4_.id,_loc4_);
                  _loc1_++;
               }
               else if(previewType == 3 && allItems[_loc2_].startPoint == 0)
               {
                  _loc3_.add(_loc4_.id,_loc4_);
                  _loc1_++;
               }
               else if(previewType == 4 && allItems[_loc2_].buyUserId == thane.userId)
               {
                  _loc3_.add(_loc4_.id,_loc4_);
                  _loc1_++;
               }
               _loc2_++;
            }
         }
         return _loc3_;
      }
      
      private function getNewGoods(param1:int, param2:SaleData) : GoodsInfo
      {
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.pos = param1;
         _loc3_.id = param2.auctionId;
         _loc3_.templateId = param2.templateId;
         _loc3_.count = param2.counts;
         _loc3_.isBinds = true;
         return _loc3_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      protected function sortFun(param1:SaleData, param2:SaleData) : Number
      {
         if(param1.states == 2 && param2.states == 1)
         {
            return -1;
         }
         if(param1.states == 1 && param2.states == 2)
         {
            return 1;
         }
         if(param1.states < param2.states)
         {
            return -1;
         }
         if(param1.states > param2.states)
         {
            return 1;
         }
         if(param1.auctionId < param2.auctionId)
         {
            return -1;
         }
         if(param1.auctionId > param2.auctionId)
         {
            return 1;
         }
         return 0;
      }
      
      public function getItemByAuctionId(param1:int) : SaleData
      {
         var _loc2_:int = 0;
         if(allItems && allItems.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < allItems.length)
            {
               if(allItems[_loc2_].auctionId == param1)
               {
                  return allItems[_loc2_];
               }
               _loc2_++;
            }
         }
         return null;
      }
   }
}

