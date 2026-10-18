package consortia.view.myConsortia.chairmanPath
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.simple.SimplePlayerSearchRspMsg;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import manager.LanguageMgr;
   import yishi.comm.PackageIn;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.IMEManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaTransferFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _nicknameImg:Bitmap;
      
      private var _inputBg:Bitmap;
      
      private var _confirm:SelectedCheckButton;
      
      private var _cancelBtn:SelectedCheckButton;
      
      private var _tipTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _inputTipTxt:FilterFrameText;
      
      private var _tempStr:String = "";
      
      public function ConsortiaTransferFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaChairmanPath.command02");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.TransferFrameDescribeBackground");
         _nicknameImg = ComponentFactory.Instance.creatBitmap("asset.consortia.transferFrameNickNameTip");
         _inputBg = ComponentFactory.Instance.creatBitmap("asset.consortia.transferFrameInputBg2");
         _confirm = ComponentFactory.Instance.creatComponentByStylename("consortia.TransferFrameConfirmBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TransferFrameCancelBtn");
         _inputTipTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.TransferFrameInputTipTextStyle");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.TransferFrameTipTextStyle");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.TransferFrameInputNameTextStyle");
         _confirm.enable = false;
         _inputTipTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaTransferFrame.command01");
         _tipTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaTransferFrame.command02");
         _nameTxt.text = "";
         _nameTxt.maxChars = 14;
         addToContent(_bg);
         addToContent(_nicknameImg);
         addToContent(_inputBg);
         addToContent(_confirm);
         _confirm.text = LanguageMgr.GetTranslation("public.confirm");
         addToContent(_cancelBtn);
         _cancelBtn.text = LanguageMgr.GetTranslation("public.close");
         addToContent(_inputTipTxt);
         addToContent(_tipTxt);
         addToContent(_nameTxt);
      }
      
      private function uninit() : void
      {
         _cancelBtn = null;
         _confirm = null;
         _nameTxt = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _cancelBtn.addEventListener("click",__onCancelHandler);
         _confirm.addEventListener("click",__onConfirmBtnHandler);
         _nameTxt.addEventListener("focusIn",__onFocusInHandler);
         _nameTxt.addEventListener("focusOut",__onFocusOutHandler);
         _nameTxt.addEventListener("keyDown",__onKeydownHandler);
         _nameTxt.addEventListener("change",__onChangeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4170,__getUserInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _cancelBtn.removeEventListener("click",__onCancelHandler);
         _confirm.removeEventListener("click",__onConfirmBtnHandler);
         _nameTxt.removeEventListener("focusIn",__onFocusInHandler);
         _nameTxt.removeEventListener("focusOut",__onFocusOutHandler);
         _nameTxt.removeEventListener("keyDown",__onKeydownHandler);
         _nameTxt.removeEventListener("change",__onChangeHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4170,__getUserInfoHandler);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function __onCancelHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      private function __onChangeHandler(param1:Event) : void
      {
         if(StringHelper.isNullOrEmpty(_nameTxt.text))
         {
            _confirm.enable = false;
         }
         else
         {
            _confirm.enable = true;
            if(StringHelper.checkStringLength(_nameTxt.text) > 12)
            {
               _nameTxt.text = _tempStr;
            }
            _tempStr = _nameTxt.text;
         }
      }
      
      private function __onKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            if(_confirm.enable)
            {
               __onConfirmBtnHandler(null);
            }
         }
         param1.stopPropagation();
      }
      
      private function __onConfirmBtnHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         _nameTxt.text = StringHelper.trim(_nameTxt.text);
         if(StringHelper.isNullOrEmpty(_nameTxt.text))
         {
            _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaTransferFrame.command03");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         FrameControllerManager.instance.consortiaController.SearchPlayer(_nameTxt.text);
      }
      
      private function __getUserInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SimplePlayerSearchRspMsg = new SimplePlayerSearchRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as SimplePlayerSearchRspMsg;
         var _loc3_:String = "";
         if(_loc2_.hasInfo && _loc2_.info.nickName.toLowerCase() == _nameTxt.text.toLowerCase())
         {
            if(_loc2_.info.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
            {
               _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaTransferFrame.command04");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            if(_loc2_.info.grades < 12)
            {
               _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaTransferFrame.command05");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            FrameControllerManager.instance.consortiaController.consortiaTransfer(_loc2_.info.userId);
            dispose();
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaTransferFrame.command06");
            MessageTipManager.instance().show(_loc3_);
         }
      }
      
      private function __onFocusInHandler(param1:FocusEvent) : void
      {
         IMEManager.enable();
         _inputTipTxt.visible = false;
      }
      
      private function __onFocusOutHandler(param1:FocusEvent) : void
      {
         if(StringHelper.isNullOrEmpty(_nameTxt.text))
         {
            _inputTipTxt.visible = true;
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
         uninit();
         super.dispose();
      }
   }
}

