package mailcheck
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.getTimer;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.DesktopManager;
   import manager.LanguageMgr;
   import managers.MailCheckManager;
   import mvc.module.customerService.CustomerServiceModel;
   import mvc.module.mailcheck.MailCheckEvent;
   import mvc.module.mailcheck.MailCheckModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IFilterFormat;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.CustomerServiceManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.view.tips.MessageTipManager;
   
   public class MailCheckFrame extends Frame implements IManualSize, IEnterFrame
   {
      
      private var _filter:IFilterFormat;
      
      private var _bg1:ScaleBitmapImage;
      
      private var _bg2:ScaleBitmapImage;
      
      private var _successPrize:FilterFrameText;
      
      private var _emailAddressInputTxt:FilterFrameText;
      
      private var _checkCodeInputTxt:FilterFrameText;
      
      private var _sendCheckCodeBtn:TextButton;
      
      private var _submitBtn:TextButton;
      
      private var _checkCodeInputHint:Image;
      
      private var _mailAddressInputHint:Image;
      
      private var _checkCodeInputBg:Image;
      
      private var _mailAddressInputBg:Image;
      
      private var _hBox:HBox;
      
      private var _gotoGMTxt:FilterFrameText;
      
      private var _refreshTimeCountTxt:FilterFrameText;
      
      private var _lastTime:Number;
      
      private var _countDiff:int = 1;
      
      private var _autoTimeCount:int = 0;
      
      private var _handTimeCount:int = 0;
      
      private var _effect:MainToolBtnGlowEffect;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _privacyTxt:FilterFrameText;
      
      public function MailCheckFrame()
      {
         super();
         initView();
         addEvent();
         initRefreshData();
      }
      
      private function initView() : void
      {
         _filter = new UIFilter();
         titleText = LanguageMgr.GetTranslation("mailCheck.MailCheckFrame.title");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("mailcheck.Bg1");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("mailcheck.Bg2");
         _successPrize = ComponentFactory.Instance.creatComponentByStylename("mailcheck.successPrize");
         _emailAddressInputTxt = ComponentFactory.Instance.creatComponentByStylename("mailcheck.emailAddressInputTxt");
         _checkCodeInputTxt = ComponentFactory.Instance.creatComponentByStylename("mailcheck.checkCodeInputTxt");
         _sendCheckCodeBtn = ComponentFactory.Instance.creatComponentByStylename("mailcheck.sendCheckCodeBtn");
         _submitBtn = ComponentFactory.Instance.creatComponentByStylename("mailcheck.submitBtn");
         _checkCodeInputHint = ComponentFactory.Instance.creatComponentByStylename("mailcheck.checkCodeInputHint");
         _mailAddressInputHint = ComponentFactory.Instance.creatComponentByStylename("mailcheck.mailAddressInputHint");
         _checkCodeInputBg = ComponentFactory.Instance.creatComponentByStylename("mailcheck.checkCodeInputBg");
         _mailAddressInputBg = ComponentFactory.Instance.creatComponentByStylename("mailcheck.mailAddressInputBg");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("mailcheck.prizeHBox");
         _gotoGMTxt = ComponentFactory.Instance.creatComponentByStylename("mailcheck.gotoGMTxt");
         _emailAddressInputTxt.text = model.mailAddress ? model.mailAddress : "";
         _checkCodeInputTxt.text = "";
         _checkCodeInputTxt.maxChars = 6;
         _successPrize.text = LanguageMgr.GetTranslation("mailCheck.MailCheckFrame.successPrize");
         _sendCheckCodeBtn.text = LanguageMgr.GetTranslation("mailCheck.MailCheckFrame.sendCheckCodeBtn");
         _submitBtn.text = LanguageMgr.GetTranslation("mailCheck.MailCheckFrame.submitBtn");
         _refreshTimeCountTxt = ComponentFactory.Instance.creatComponentByStylename("mailcheck.refreshTimeCountTxt");
         _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("mailCheckFrame.selectedCheckBtn");
         _privacyTxt = ComponentFactory.Instance.creatComponentByStylename("mailCheckFrame.privacyTxt");
         addToContent(_bg1);
         addToContent(_checkCodeInputHint);
         addToContent(_mailAddressInputHint);
         addToContent(_checkCodeInputBg);
         addToContent(_mailAddressInputBg);
         addToContent(_emailAddressInputTxt);
         addToContent(_checkCodeInputTxt);
         addToContent(_sendCheckCodeBtn);
         addToContent(_submitBtn);
         addToContent(_gotoGMTxt);
         addToContent(_refreshTimeCountTxt);
         addToContent(_selectedBtn);
         addToContent(_privacyTxt);
         _gotoGMTxt.htmlText = LanguageMgr.GetTranslation("mainBar.vicePassword.serviceText.text");
         _effect = new MainToolBtnGlowEffect(_gotoGMTxt);
         _effect.stop();
         newServiceReply();
         _checkCodeInputHint.tipData = LanguageMgr.GetTranslation("mailCheckFrame.checkCodeInput.tip");
         _selectedBtn.text = LanguageMgr.GetTranslation("mailCheckFrame.selectedCheckBtn.text");
         _privacyTxt.htmlText = LanguageMgr.GetTranslation("mailCheckFrame.privacyTxt.text");
      }
      
      private function newServiceReply() : void
      {
         if(gmModel.receiveMessageList.length)
         {
            _effect.play();
         }
         else
         {
            _effect.stop();
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         addEventListener("response",frameResponse);
         NotificationManager.instance.addEventListener("MailCheckEvent.STATE_UPDATE",__mailCheckInfoHandler);
         _sendCheckCodeBtn.addEventListener("click",__sendCheckCodeBtnClickHandle);
         _submitBtn.addEventListener("click",__submitBtnClickHandle);
         _gotoGMTxt.addEventListener("click",_serviceClickHandler);
         CustomerServiceManager.instance.addEventListener("new_reply",__newServiceReplyHandler);
         _privacyTxt.addEventListener("link",__onLinkHandler);
      }
      
      private function __onLinkHandler(param1:TextEvent) : void
      {
         var _loc2_:URLRequest = null;
         var _loc3_:String = "http://www.wan.com/en/policy.html";
         if(DesktopManager.Instance.isDesktop)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("navigateToURL",_loc3_);
            }
         }
         else if(ExternalInterface.available)
         {
            _loc2_ = new URLRequest(_loc3_);
            navigateToURL(_loc2_,"_blank");
         }
      }
      
      private function __newServiceReplyHandler(param1:Event) : void
      {
         newServiceReply();
      }
      
      protected function __mailCheckInfoHandler(param1:MailCheckEvent) : void
      {
         _emailAddressInputTxt.text = model.mailAddress;
         switch(int(model.state))
         {
            case 0:
               _submitBtn.enable = false;
               break;
            case 1:
               _submitBtn.enable = true;
               break;
            case 2:
               dispose();
               break;
            case 3:
               _submitBtn.enable = false;
         }
      }
      
      protected function _serviceClickHandler(param1:MouseEvent) : void
      {
         if(CustomerServiceManager.instance.model.canOpen)
         {
            if(gmModel.receiveMessageList.length)
            {
               FrameControllerManager.instance.openControllerByInfo("customerservice");
            }
            else
            {
               FrameControllerManager.instance.openControllerByInfo("customerservice",null,6);
            }
            newServiceReply();
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mainBar.SmallMapBar.customerservice"));
         }
      }
      
      public function get gmModel() : CustomerServiceModel
      {
         return CustomerServiceManager.instance.model;
      }
      
      private function get model() : MailCheckModel
      {
         return MailCheckManager.instance.model;
      }
      
      private function ckSth(param1:String) : Boolean
      {
         var _loc3_:RegExp = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+(w+([.-]\w+))*/;
         return _loc3_.test(param1);
      }
      
      protected function __sendCheckCodeBtnClickHandle(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = ckSth(_emailAddressInputTxt.text);
         if(!_loc2_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MailCheckFrame.wrongEmailAddress"));
            return;
         }
         MailCheckManager.instance.sendCheckMail(_emailAddressInputTxt.text);
         model.refreshTime = getTimer();
         _sendCheckCodeBtn.enable = false;
         _refreshTimeCountTxt.text = LanguageMgr.GetTranslation("mailcheck.MailCheckFrame.refreshTxt",300);
      }
      
      private function initRefreshData() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = getTimer();
         var _loc3_:int = 0;
         if(model.refreshTime != -1)
         {
            _lastTime = model.refreshTime;
            _loc2_ = _loc1_ - _lastTime;
            _countDiff = _loc2_ / 1000;
            _loc3_ = 300 - _countDiff;
            if(_loc3_ > 0)
            {
               _refreshTimeCountTxt.text = LanguageMgr.GetTranslation("mailcheck.MailCheckFrame.refreshTxt",_loc3_);
               _sendCheckCodeBtn.enable = false;
            }
         }
         else
         {
            _lastTime = _loc1_;
         }
      }
      
      public function enterFrame() : void
      {
         var _loc1_:Number = getTimer();
         var _loc2_:Number = _loc1_ - _lastTime;
         var _loc3_:int = 0;
         if(_loc2_ >= 1000)
         {
            _countDiff = _loc2_ / 1000;
            _autoTimeCount += _countDiff;
            if(!_sendCheckCodeBtn.enable)
            {
               _handTimeCount += _countDiff;
               _loc3_ = 300 - _handTimeCount;
               _refreshTimeCountTxt.text = LanguageMgr.GetTranslation("mailcheck.MailCheckFrame.refreshTxt",_loc3_);
            }
            _lastTime = _loc1_;
         }
         if(!_sendCheckCodeBtn.enable && _handTimeCount >= 300)
         {
            _handTimeCount = 0;
            model.refreshTime = -1;
            _sendCheckCodeBtn.enable = true;
            _refreshTimeCountTxt.text = "";
         }
      }
      
      protected function __submitBtnClickHandle(param1:MouseEvent) : void
      {
         if(!_selectedBtn.selected)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mailCheckFrame.notSelected.text"));
            return;
         }
         var _loc2_:int = parseInt(_checkCodeInputTxt.text);
         MailCheckManager.instance.submitCheckCode(_emailAddressInputTxt.text,_loc2_);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         removeEventListener("response",frameResponse);
         NotificationManager.instance.removeEventListener("MailCheckEvent.STATE_UPDATE",__mailCheckInfoHandler);
         _sendCheckCodeBtn.removeEventListener("click",__sendCheckCodeBtnClickHandle);
         _submitBtn.removeEventListener("click",__submitBtnClickHandle);
         _gotoGMTxt.removeEventListener("click",_serviceClickHandler);
         CustomerServiceManager.instance.removeEventListener("new_reply",__newServiceReplyHandler);
         _privacyTxt.removeEventListener("link",__onLinkHandler);
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
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,491,245);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _filter = null;
         super.dispose();
      }
   }
}

