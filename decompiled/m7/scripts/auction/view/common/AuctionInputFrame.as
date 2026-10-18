package auction.view.common
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.auction.AuctionListItemData;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class AuctionInputFrame extends Frame
   {
      
      private var _alertTxt:Bitmap;
      
      private var _inputBack:ScaleBitmapImage;
      
      private var _inputTxt:FilterFrameText;
      
      private var _warmTxt:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _diamondBm:Bitmap;
      
      private var _backCall:Function;
      
      private var _data:AuctionListItemData;
      
      public function AuctionInputFrame()
      {
         super();
         initView();
         initEvent();
         titleText = LanguageMgr.GetTranslation("Auction.AuctionTitle");
      }
      
      public function set backCall(param1:Function) : void
      {
         _backCall = param1;
      }
      
      public function setData(param1:AuctionListItemData) : void
      {
         _data = param1;
      }
      
      private function initView() : void
      {
         _alertTxt = ComponentFactory.Instance.creatBitmap("asset.auction.AuctionPriceLabelBMD");
         _inputBack = ComponentFactory.Instance.creatComponentByStylename("auction.AuctionInputBack");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("auction.AuctionInputText");
         _warmTxt = ComponentFactory.Instance.creatComponentByStylename("auction.AuctionInputWarmText");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("auction.AuctionConfirmBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("auction.AuctionCancelBtn");
         _diamondBm = ComponentFactory.Instance.creatBitmap("asset.auction.DiamondBigIcon");
         _diamondBm.x = 251;
         _diamondBm.y = 11;
         addToContent(_alertTxt);
         addToContent(_inputBack);
         addToContent(_inputTxt);
         _inputTxt.restrict = "0-9";
         _inputTxt.maxChars = 9;
         addToContent(_warmTxt);
         _warmTxt.text = LanguageMgr.GetTranslation("Auction.EnterAuctionPrice");
         addToContent(_confirmBtn);
         addToContent(_cancelBtn);
         addToContent(_diamondBm);
      }
      
      protected function initEvent() : void
      {
         _inputTxt.addEventListener("change",__onChangeInput);
         addEventListener("response",__frameResponse);
         addEventListener("addedToStage",__onAddedToStage);
         _confirmBtn.addEventListener("click",__confirmHandler);
         _cancelBtn.addEventListener("click",__cancelHandler);
      }
      
      protected function __onChangeInput(param1:Event) : void
      {
         if(int(_inputTxt.text) > PlayerManager.instance.currentPlayerModel.playerInfo.point)
         {
            _inputTxt.text = "" + PlayerManager.instance.currentPlayerModel.playerInfo.point;
         }
      }
      
      protected function removeEvent() : void
      {
         if(_inputTxt)
         {
            _inputTxt.removeEventListener("change",__onChangeInput);
         }
         removeEventListener("response",__frameResponse);
         removeEventListener("addedToStage",__onAddedToStage);
         _confirmBtn.removeEventListener("click",__confirmHandler);
         _cancelBtn.removeEventListener("click",__cancelHandler);
      }
      
      protected function __onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",__onAddedToStage);
         stage.focus = _inputTxt;
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(_backCall != null)
         {
            if(_inputTxt.text == "")
            {
               SimpleAlertHelper.instance.data = [confirmAlert];
               _loc3_ = LanguageMgr.GetTranslation("public.confirm");
               _loc4_ = LanguageMgr.GetTranslation("public.cancel");
               _loc5_ = LanguageMgr.GetTranslation("public.prompt");
               _loc2_ = LanguageMgr.GetTranslation("Auction.EnterAuctionPrice");
               SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,"",true,false,false,2);
            }
            else
            {
               _backCall(_inputTxt.text);
            }
         }
         dispose();
      }
      
      private function confirmAlert(param1:Boolean, param2:Boolean) : void
      {
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      protected function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
               __confirmHandler(null);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         _backCall = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         super.dispose();
      }
   }
}

