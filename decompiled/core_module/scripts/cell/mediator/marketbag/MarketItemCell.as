package cell.mediator.marketbag
{
   import cell.view.playerbag.PlayerBagCell;
   import yishi.manager.MediatorMananger;
   
   public class MarketItemCell extends PlayerBagCell
   {
      
      public static const NAME:String = "map.campaign.view.marketMarketItemCell";
      
      public static const SELL_TYPE:String = "SELL_TYPE";
      
      public static const BAG_TYPE:String = "BAG_TYPE";
      
      public var celltType:String;
      
      public function MarketItemCell()
      {
         super();
      }
      
      override protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [MarketBagCellClickMediator,MarketBagCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.campaign.view.marketMarketItemCell");
      }
   }
}

