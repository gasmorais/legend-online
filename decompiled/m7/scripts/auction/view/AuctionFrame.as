package auction.view
{
   import auction.view.sell.AuctionGoodMoveControl;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mediator.AuctionMessageSender;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class AuctionFrame extends Frame
   {
      
      private var _border:DisplayObject;
      
      private var _paneBack:Scale9CornerImage;
      
      private var _bar:AuctionTopBar;
      
      private var _paneContainer:Sprite;
      
      private var _currentPane:Sprite;
      
      private var _help:BaseButton = ComponentFactory.Instance.creatComponentByStylename("auction.auctionhelpBtn");
      
      private var _isFirstOpen:Boolean = true;
      
      public function AuctionFrame()
      {
         super();
         initView();
         addEvent();
         _help.tipData = LanguageMgr.GetTranslation("Auction.AuctionFrameTitle.helpData");
         titleText = LanguageMgr.GetTranslation("Auction.AuctionFrameTitle");
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("auction.AuctionFrameBorder");
         addToContent(_border);
         _paneBack = ComponentFactory.Instance.creatComponentByStylename("auction.AuctionFramePaneBack.Scale9CornerImage");
         addToContent(_paneBack);
         _bar = new AuctionTopBar();
         _bar.x = 21;
         _bar.y = -9.5;
         addToContent(_bar);
         _paneContainer = new Sprite();
         addToContent(_paneContainer);
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_help);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
         onBuyClick(null);
         _bar.initIndex();
      }
      
      private function showPane(param1:Sprite) : void
      {
         var _loc2_:Sprite = _currentPane;
         _currentPane = param1;
         if(!_currentPane.parent)
         {
            _paneContainer.addChild(_currentPane);
            _currentPane.x = 25;
            _currentPane.y = 42;
         }
         ObjectUtils.disposeObject(_loc2_);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",frameResponse);
         _bar.getBuyBtn().addEventListener("click",onBuyClick,false,10);
         _bar.getSellGoodsBtn().addEventListener("click",onSellGoodsClick,false,10);
         _bar.getSellPetBtn().addEventListener("click",__onSellPetClick,false,10);
         _bar.getRecordBtn().addEventListener("click",onRecordClick,false,10);
         _help.addEventListener("click",__helpClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",frameResponse);
         _bar.getBuyBtn().removeEventListener("click",onBuyClick);
         _bar.getSellGoodsBtn().removeEventListener("click",onSellGoodsClick);
         _bar.getSellPetBtn().removeEventListener("click",__onSellPetClick);
         _bar.getRecordBtn().removeEventListener("click",onRecordClick);
         _help.removeEventListener("click",__helpClick);
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = null;
         SoundManager.instance.play("022");
         if(_bar.getSelectedBtn() == _bar.getSellPetBtn())
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("auction.auctionHelperFrame");
            _loc2_.helpHtmlText = "AuctionFrame.helpPet";
         }
         else
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("auction.auctionHelperFrame");
         }
         _loc2_.show(2);
         param1.stopPropagation();
         param1.stopImmediatePropagation();
      }
      
      private function onBuyClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_bar.getSelectedBtn() == _bar.getBuyBtn())
         {
            return;
         }
         FrameControllerManager.instance.auctionController.model.clear();
         FrameControllerManager.instance.auctionController.model.currentModulIndex = 0;
         var _loc2_:AuctionBuyPane = new AuctionBuyPane();
         showPane(_loc2_);
         _loc2_.getSearchControl().restoreListTitle();
      }
      
      private function onSellGoodsClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_bar.getSelectedBtn() == _bar.getSellGoodsBtn())
         {
            return;
         }
         FrameControllerManager.instance.auctionController.model.clear();
         FrameControllerManager.instance.auctionController.model.currentModulIndex = 1;
         showPane(new AuctionSellPane(1));
         AuctionMessageSender.sendMyAuctionListReq(1,9,1);
      }
      
      private function __onSellPetClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(thaneInfo.grades < 50)
         {
            _loc2_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",50);
            MessageTipManager.instance().show(_loc2_);
            param1.stopImmediatePropagation();
            return;
         }
         if(_bar.getSelectedBtn() == _bar.getSellPetBtn())
         {
            return;
         }
         FrameControllerManager.instance.auctionController.model.clear();
         FrameControllerManager.instance.auctionController.model.currentModulIndex = 1;
         showPane(new AuctionSellPane(2));
         AuctionMessageSender.sendMyAuctionListReq(1,9,1);
      }
      
      private function onRecordClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_bar.getSelectedBtn() == _bar.getRecordBtn())
         {
            return;
         }
         FrameControllerManager.instance.auctionController.model.clear();
         FrameControllerManager.instance.auctionController.model.currentModulIndex = 2;
         showPane(new AuctionRecordPane());
         AuctionMessageSender.sendMyAuctionListHistoryReq(1,9,1);
      }
      
      private function frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get thaneInfo() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_paneBack);
         ObjectUtils.disposeObject(_border);
         ObjectUtils.disposeObject(_bar);
         ObjectUtils.disposeObject(_currentPane);
         ObjectUtils.disposeObject(_help);
         _bar = null;
         _currentPane = null;
         AuctionGoodMoveControl.dispose();
         super.dispose();
      }
   }
}

