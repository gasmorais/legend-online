package auction.view.sell
{
   import bag.events.BagEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.view.community.BaseItemView;
   
   public class AuctionGoodMoveControl
   {
      
      private static var _targetCell:AuctionSellTargetCell;
      
      public static var bagPane:Disposeable;
      
      private static var _sellPane:AuctionSellSubmitPane;
      
      private static var _storeTargetData:GoodsInfo;
      
      public static var isFirstOpenSellPane:Boolean = true;
      
      public function AuctionGoodMoveControl()
      {
         super();
      }
      
      public static function init(param1:AuctionSellTargetCell, param2:Disposeable, param3:AuctionSellSubmitPane) : void
      {
         _targetCell = param1;
         bagPane = param2;
         _sellPane = param3;
      }
      
      public static function playBlink() : void
      {
         if(!_targetCell.data && isFirstOpenSellPane)
         {
            _sellPane.playBlink();
         }
         StageReferance.stage.focus = _sellPane;
      }
      
      public static function stopBlink() : void
      {
         _sellPane.stopBlink();
      }
      
      public static function delTargetData() : void
      {
         if(bagPane && bagPane is PetSellView)
         {
            (bagPane as PetSellView).refresh();
         }
         if(_storeTargetData && _storeTargetData.id == _targetCell.data.id)
         {
            if(_targetCell.data)
            {
               _targetCell.data = null;
            }
         }
         else
         {
            GoodsManager.instance.dispatchEvent(new BagEvent("RETURN_REFRESH",null));
         }
      }
      
      public static function storeTargetData() : void
      {
         if(_storeTargetData)
         {
            _storeTargetData = null;
         }
         _storeTargetData = _targetCell.data;
      }
      
      public static function moveToTargetCell(param1:BaseItemView) : void
      {
         if(_targetCell.data)
         {
            NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_targetCell]);
            _targetCell.data = null;
         }
         param1.setGrayFilter();
         _targetCell.data = param1.data;
         checkSellCount(param1);
         _targetCell.setNumText(0);
      }
      
      public static function checkSellCount(param1:BaseItemView) : void
      {
         var _loc2_:AuctionSellNumPane = null;
         if(param1.data && param1.data.count > 1)
         {
            _sellPane.setPriceNull();
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("auction.AuctionSellNumFrame");
            _loc2_.show(param1,_targetCell);
            _loc2_.callBack = _sellPane.checkData;
         }
         else
         {
            param1.data.willSellCount = 1;
            _targetCell.setNumText(1);
            _sellPane.checkData();
         }
      }
      
      public static function dispose() : void
      {
         _targetCell = null;
         bagPane = null;
      }
   }
}

