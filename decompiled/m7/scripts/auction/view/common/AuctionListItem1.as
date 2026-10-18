package auction.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   
   public class AuctionListItem1 extends AuctionListItemBase
   {
      
      public function AuctionListItem1()
      {
         super("auction.listItemSelectS","auction.listItemUnselectS","auction.listItemOverS");
      }
      
      override protected function refreshView() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("auction.listMemberNameTxtS");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("auction.listMemberGradeTxtS");
         _timeLeftTxt = ComponentFactory.Instance.creatComponentByStylename("auction.listMemberTimeLeftTxtS");
         _salerTxt = ComponentFactory.Instance.creatComponentByStylename("auction.listMemberSalerTxtS");
         _fixedPriceBack = ComponentFactory.Instance.creatComponentByStylename("auction.listPriceBackS1");
         _fixedPriceTxt = ComponentFactory.Instance.creatComponentByStylename("auction.listMemberFixedPriceTxtS");
         _currPriceBack = ComponentFactory.Instance.creatComponentByStylename("auction.listPriceBackS2");
         _currPriceTxt = ComponentFactory.Instance.creatComponentByStylename("auction.listMemberCurrPriceTxtS");
         _icon = ComponentFactory.Instance.creatCustomObject("auction.listGoodItemS");
         _auctionedIcon = ComponentFactory.Instance.creatComponentByStylename("auction.listItemAuctionedIconS");
      }
   }
}

