package auction.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   
   public class AuctionListItem2 extends AuctionListItemBase
   {
      
      public function AuctionListItem2()
      {
         super("auction.listItemSelectL","auction.listItemUnselectL","auction.listItemOverL");
      }
      
      override protected function refreshView() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("auction.listMemberNameTxtL");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("auction.listMemberGradeTxtL");
         _timeLeftTxt = ComponentFactory.Instance.creatComponentByStylename("auction.listMemberTimeLeftTxtL");
         _salerTxt = ComponentFactory.Instance.creatComponentByStylename("auction.listMemberSalerTxtL");
         _fixedPriceBack = ComponentFactory.Instance.creatComponentByStylename("auction.listPriceBackL1");
         _fixedPriceTxt = ComponentFactory.Instance.creatComponentByStylename("auction.listMemberFixedPriceTxtL");
         _currPriceBack = ComponentFactory.Instance.creatComponentByStylename("auction.listPriceBackL2");
         _currPriceTxt = ComponentFactory.Instance.creatComponentByStylename("auction.listMemberCurrPriceTxtL");
         _icon = ComponentFactory.Instance.creatCustomObject("auction.listGoodItemL");
         _itemTipView = ComponentFactory.Instance.creatCustomObject("auction.timeLeftTip");
         _itemTipView.graphics.beginFill(0,0);
         _itemTipView.graphics.drawRect(0,0,820,42);
         _itemTipView.graphics.endFill();
         _itemTipView.x = 0;
         _itemTipView.y = 0;
         _itemTipView.doubleClickEnabled = true;
      }
   }
}

