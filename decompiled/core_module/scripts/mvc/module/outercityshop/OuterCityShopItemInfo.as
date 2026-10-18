package mvc.module.outercityshop
{
   import yishi.manager.TempleteManager;
   
   public class OuterCityShopItemInfo
   {
      
      private var _itemId:int;
      
      private var _costIds:Array = [];
      
      public var index:int;
      
      public var isBuy:Boolean;
      
      private var _itemTemInfo:OuterCityShopGoodsInfo;
      
      private var _costInfos:Array = [];
      
      public function OuterCityShopItemInfo()
      {
         super();
      }
      
      public function set costInfos(param1:Array) : void
      {
         _costInfos = param1;
      }
      
      public function get costInfos() : Array
      {
         return _costInfos;
      }
      
      public function get costIds() : Array
      {
         return _costIds;
      }
      
      public function set costIds(param1:Array) : void
      {
         _costIds = param1;
      }
      
      public function get itemId() : int
      {
         return _itemId;
      }
      
      public function set itemId(param1:int) : void
      {
         _itemId = param1;
         _itemTemInfo = TempleteManager.instance.getouterCityShopRandomByMapShopId(param1);
         if(_itemTemInfo.Point > 0)
         {
            _costInfos.push([-400,_itemTemInfo.Point]);
         }
         if(_itemTemInfo.Score > 0)
         {
            _costInfos.push(["Score",_itemTemInfo.Score]);
         }
         if(_itemTemInfo.SecretStone > 0)
         {
            _costInfos.push([2131057,_itemTemInfo.SecretStone]);
         }
         if(_itemTemInfo.Strategy > 0)
         {
            _costInfos.push([-300,_itemTemInfo.Strategy]);
         }
         if(_itemTemInfo.Crystal > 0)
         {
            _costInfos.push([-600,_itemTemInfo.Crystal]);
         }
      }
      
      public function get itemTemInfo() : OuterCityShopGoodsInfo
      {
         return _itemTemInfo;
      }
      
      public function set itemTemInfo(param1:OuterCityShopGoodsInfo) : void
      {
         _itemTemInfo = param1;
      }
   }
}

