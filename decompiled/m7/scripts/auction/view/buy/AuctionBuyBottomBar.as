package auction.view.buy
{
   import auction.view.common.AuctionPageControlComponent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   
   public class AuctionBuyBottomBar extends Sprite implements Disposeable
   {
      
      private var _diamondBack:DisplayObject;
      
      private var _diamondTxt:FilterFrameText;
      
      private var _pageControl:AuctionPageControlComponent;
      
      private var _auctionBtn:BaseButton;
      
      private var _fixedPriceBtn:BaseButton;
      
      public function AuctionBuyBottomBar()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _diamondBack = ComponentFactory.Instance.creatComponentByStylename("auction.diamondBackImg1");
         _diamondTxt = ComponentFactory.Instance.creatComponentByStylename("auction.DiamondTxt1");
         _pageControl = new AuctionPageControlComponent();
         _pageControl.x = 211;
         _pageControl.y = 10;
         _pageControl.update(FrameControllerManager.instance.auctionController.model.forSaleList);
         _auctionBtn = ComponentFactory.Instance.creatComponentByStylename("auction.auctionBtn");
         _fixedPriceBtn = ComponentFactory.Instance.creatComponentByStylename("auction.fixedPriceBtn");
         addChild(_diamondBack);
         addChild(_diamondTxt);
         addChild(_pageControl);
         addChild(_auctionBtn);
         addChild(_fixedPriceBtn);
         var _loc1_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         _loc1_.addEventListener("POINT_CHANGE",onPointChanged,false,0,true);
         onPointChanged(null);
      }
      
      private function onPointChanged(param1:PlayerEvent) : void
      {
         _diamondTxt.text = PlayerManager.instance.currentPlayerModel.playerInfo.point + "";
      }
      
      public function getAuctionBtn() : BaseButton
      {
         return _auctionBtn;
      }
      
      public function getFixedPriceBtn() : BaseButton
      {
         return _fixedPriceBtn;
      }
      
      public function getPageControlComp() : AuctionPageControlComponent
      {
         return _pageControl;
      }
      
      public function dispose() : void
      {
         var _loc1_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         _loc1_.removeEventListener("POINT_CHANGE",onPointChanged);
         ObjectUtils.disposeAllChildren(this);
         _pageControl = null;
         _diamondBack = null;
         _diamondTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

