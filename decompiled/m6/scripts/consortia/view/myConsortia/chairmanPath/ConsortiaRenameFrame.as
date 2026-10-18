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
   import com.road.yishi.proto.consortia.ConsortiaRenameRspMsg;
   import consortia.net.ConsortiaSocektSendManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import yishi.comm.PackageIn;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.IMEManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaRenameFrame extends Frame
   {
      
      private var _confirm:SelectedCheckButton;
      
      private var _bg:ScaleBitmapImage;
      
      private var _tipTxtImg:Bitmap;
      
      private var _inputBg:Bitmap;
      
      private var _limitTipTxt:FilterFrameText;
      
      private var _alertTipTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _inputTipTxt:FilterFrameText;
      
      private const MAX_LIMIT_WORDS:int = 10;
      
      private const MIN_LIMIT_WORDS:int = 4;
      
      private var _useBindPointBtn:SelectedCheckButton;
      
      private var _notJoinActTxt:FilterFrameText;
      
      private var _call:Function;
      
      private var _renameType:int;
      
      public function ConsortiaRenameFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaChairmanPath.command03");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.RenameFrameDescribeBackground");
         _tipTxtImg = ComponentFactory.Instance.creatBitmap("asset.consortia.newConsortiaNameTip");
         _inputBg = ComponentFactory.Instance.creatBitmap("asset.consortia.transferFrameInputBg");
         _inputTipTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.RenameFrameInputTipTextStyle");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.RenameFrameInputNameTextStyle");
         _limitTipTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.InputTipTextStyle");
         _alertTipTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.RenameFrameTipTextStyle");
         _confirm = ComponentFactory.Instance.creatComponentByStylename("consortia.RenameFrameConfirmBtn");
         _useBindPointBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.useBindPointBtn");
         _notJoinActTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.notJoinActTxt");
         _inputTipTxt.text = LanguageMgr.GetTranslation("consortia.view.club.CreatConsortiaFrame.command02");
         _limitTipTxt.text = LanguageMgr.GetTranslation("consortia.view.club.CreatConsortiaFrame.command04");
         _alertTipTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaRenameFrame.command01",1000);
         _nameTxt.text = "";
         _nameTxt.maxChars = 10;
         _confirm.enable = false;
         _useBindPointBtn.visible = true;
         addToContent(_bg);
         addToContent(_tipTxtImg);
         addToContent(_inputBg);
         addToContent(_inputTipTxt);
         addToContent(_nameTxt);
         addToContent(_limitTipTxt);
         addToContent(_alertTipTxt);
         addToContent(_confirm);
         _confirm.text = LanguageMgr.GetTranslation("public.confirm");
         addToContent(_useBindPointBtn);
         _useBindPointBtn.selected = true;
         _useBindPointBtn.text = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.useBind");
         addToContent(_notJoinActTxt);
         _notJoinActTxt.visible = true;
         _notJoinActTxt.text = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.promptTxt");
         updateFrameSize(true);
      }
      
      private function uninit() : void
      {
         _confirm = null;
         _nameTxt = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirm.addEventListener("click",__onConfirmBtnHandler);
         _nameTxt.addEventListener("focusIn",__onFocusInHandler);
         _nameTxt.addEventListener("focusOut",__onFocusOutHandler);
         _nameTxt.addEventListener("change",__onChangeHandler);
         _nameTxt.addEventListener("keyDown",__onKeydownHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 49,__renameHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirm.removeEventListener("click",__onConfirmBtnHandler);
         _nameTxt.removeEventListener("focusIn",__onFocusInHandler);
         _nameTxt.removeEventListener("focusOut",__onFocusOutHandler);
         _nameTxt.removeEventListener("change",__onChangeHandler);
         _nameTxt.removeEventListener("keyDown",__onKeydownHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 49,__renameHandler);
      }
      
      private function __renameHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaRenameRspMsg = new ConsortiaRenameRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ConsortiaRenameRspMsg;
         if(_loc2_.result)
         {
            dispose();
         }
         else if(_confirm)
         {
            _confirm.enable = true;
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
      
      private function __onKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13 && Boolean(_confirm.enable))
         {
            __onConfirmBtnHandler(null);
         }
         param1.stopPropagation();
      }
      
      private function __onChangeHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(StringHelper.isNullOrEmpty(_nameTxt.text))
         {
            _confirm.enable = false;
         }
         else
         {
            _loc2_ = int(_nameTxt.text.replace(/[^\x00-\xff]/g,"xx").length);
            if(_loc2_ > 10 || _loc2_ < 4)
            {
               _confirm.enable = false;
            }
            else
            {
               _confirm.enable = true;
            }
         }
      }
      
      private function __onConfirmBtnHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc4_:int = 0;
         SoundManager.instance.play("022");
         if(FilterWordManager.isGotForbiddenWords(_nameTxt.text,"name") || Boolean(FilterWordManager.isGotForbiddenWords(_nameTxt.text,"chat")))
         {
            _loc2_ = LanguageMgr.GetTranslation("consortia.view.club.CreatConsortiaFrame.command11");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_useBindPointBtn.selected)
         {
            _loc4_ = PlayerManager.instance.currentPlayerModel.playerInfo.point + PlayerManager.instance.currentPlayerModel.playerInfo.giftToken;
         }
         else
         {
            _loc4_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         }
         if(_renameType == 0 && _loc4_ < 1000)
         {
            RechargeAlertMannager.show();
            return;
         }
         _confirm.enable = false;
         var _loc3_:Boolean = _renameType == 0 ? false : true;
         ConsortiaSocektSendManager.consortiaRename(_nameTxt.text,_loc3_,_useBindPointBtn.selected);
         if(_call == null)
         {
            dispose();
         }
      }
      
      public function show(param1:Function = null) : void
      {
         _call = param1;
         if(_call != null)
         {
            _renameType = 1;
            _alertTipTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaRenameFrame.command02");
            _alertTipTxt.x = 11;
            _useBindPointBtn.visible = false;
         }
         updateFrameSize(_call == null);
         LayerManager.Instance.addToLayer(this,2,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function updateFrameSize(param1:Boolean) : void
      {
         if(param1)
         {
            _notJoinActTxt.visible = true;
            this.height = 305;
            _confirm.y = 180;
            _bg.height = 166;
         }
         else
         {
            _notJoinActTxt.visible = false;
            height = 285;
            _confirm.y = 160;
            _bg.height = 146;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(_call != null)
               {
                  _call();
               }
               _call = null;
               dispose();
         }
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

