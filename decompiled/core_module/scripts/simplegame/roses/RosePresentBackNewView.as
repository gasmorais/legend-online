package simplegame.roses
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import managers.IMManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FriendManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.tips.MessageTipManager;
   
   public class RosePresentBackNewView extends Frame
   {
      
      public static const ROSEID_9999:int = 2170005;
      
      public static const MAX_CONTENT:int = 76;
      
      private var _bg:MutipleImage;
      
      private var _bg2:MutipleImage;
      
      private var _inputTipTxt:FilterFrameText;
      
      private var _inputNumTxt:FilterFrameText;
      
      private var _inputBg:ScaleBitmapImage;
      
      private var _presentNameTxt:GradientText;
      
      private var _presentShowTxt:GradientText;
      
      private var _changeContentTxt:FilterFrameText;
      
      private var _contentContainer:Sprite;
      
      private var _contentBg:MutipleImage;
      
      private var _contentTxt:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _tempContent:String = "";
      
      private var _targetName:String;
      
      private var _roseTempId:int;
      
      private var _senderId:int;
      
      private var _frameHeight:int;
      
      private var _textBg:Bitmap;
      
      public function RosePresentBackNewView(param1:int, param2:String, param3:int)
      {
         super();
         _roseTempId = param1;
         _senderId = param3;
         _targetName = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("simplegame.roses.RosePresentBackView.presentBack");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewConfirmBtn1");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewCancleBtn1");
         _confirmBtn.icon["setFrame"](2);
         _cancelBtn.icon["setFrame"](2);
         _frameHeight = 234;
         _contentContainer = ComponentFactory.Instance.creatCustomObject("friends.RosePresentBackViewContentContainer1");
         _bg = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentViewBg1");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentViewNewBg2");
         _textBg = ComponentFactory.Instance.creatBitmap("asset.friends.textBg");
         _presentNameTxt = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewPresentNameTxt1");
         _presentShowTxt = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewPresentShowTxt1");
         _changeContentTxt = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewChangeContentTxt");
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewContentBg1");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewContentTxt1");
         _contentTxt.text = LanguageMgr.GetTranslation("yishi.view.RosePresentView.defaultContent0");
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(2170005);
         var _loc2_:String = "";
         if(_loc1_)
         {
            _loc2_ = _loc1_.TemplateName;
         }
         _presentNameTxt.text = _targetName;
         _presentShowTxt.text = LanguageMgr.GetTranslation("simplegame.roses.RosePresentBackView.presentShowContent",_loc2_);
         _changeContentTxt.htmlText = "<a href=\'event:#\'>" + LanguageMgr.GetTranslation("simplegame.roses.RosePresentBackView.changeContent") + "</a>";
         _contentContainer.visible = false;
         _contentContainer.addChild(_contentBg);
         _contentContainer.addChild(_contentTxt);
         addToContent(_bg);
         addToContent(_textBg);
         addToContent(_presentNameTxt);
         addToContent(_presentShowTxt);
         addToContent(_changeContentTxt);
         addToContent(_contentContainer);
         addToContent(_confirmBtn);
         addToContent(_cancelBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         if(_confirmBtn)
         {
            _confirmBtn.addEventListener("click",__onConfirmClick);
         }
         if(_cancelBtn)
         {
            _cancelBtn.addEventListener("click",__onCancleClick);
         }
         if(_changeContentTxt)
         {
            _changeContentTxt.addEventListener("link",__onChangeContentClick);
         }
         if(_contentTxt)
         {
            _contentTxt.addEventListener("change",__contentInputHandler);
         }
         if(_inputNumTxt)
         {
            _inputNumTxt.addEventListener("change",__numInputHandler);
         }
         if(_inputNumTxt)
         {
            _inputNumTxt.addEventListener("focusIn",__inHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__onConfirmClick);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__onCancleClick);
         }
         if(_changeContentTxt)
         {
            _changeContentTxt.removeEventListener("link",__onChangeContentClick);
         }
         if(_contentTxt)
         {
            _contentTxt.removeEventListener("change",__contentInputHandler);
         }
         if(_inputNumTxt)
         {
            _inputNumTxt.removeEventListener("change",__numInputHandler);
         }
         if(_inputNumTxt)
         {
            _inputNumTxt.removeEventListener("focusIn",__inHandler);
         }
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
            case 4:
               dispose();
         }
      }
      
      private function __onChangeContentClick(param1:TextEvent) : void
      {
         if(_contentContainer)
         {
            if(_contentContainer.visible)
            {
               _contentContainer.visible = false;
               StageReferance.stage.focus = this;
            }
            else
            {
               _contentContainer.visible = true;
               _contentTxt.setSelection(0,_contentTxt.length);
               _contentTxt.setFocus();
            }
         }
      }
      
      private function __contentInputHandler(param1:Event) : void
      {
         var _loc2_:int = StringHelper.checkStringLength(_contentTxt.text);
         if(_loc2_ > 76)
         {
            _contentTxt.text = _tempContent;
         }
         _tempContent = _contentTxt.text;
      }
      
      private function __numInputHandler(param1:Event) : void
      {
         var _loc2_:int = int(_inputNumTxt.text);
         var _loc3_:int = GoodsManager.instance.getGoodsNumByTempId(_roseTempId);
         if(_loc2_ > _loc3_)
         {
            _loc2_ = _loc3_;
            _inputNumTxt.text = _loc2_.toString();
         }
         else if(_loc2_ <= 0 || _loc3_ <= 0)
         {
            _inputNumTxt.text = "";
         }
         else
         {
            _inputNumTxt.text = _loc2_.toString();
         }
      }
      
      private function __inHandler(param1:FocusEvent) : void
      {
         _inputNumTxt.setSelection(0,_inputNumTxt.text.length);
      }
      
      private function __onConfirmClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = StringHelper.trim(_contentTxt.text);
         if(StringHelper.isNullOrEmpty(_loc3_))
         {
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.RosePresentView.noContent");
            SimpleAlertHelper.instance.data = [sendRosePresent,_roseTempId,1,_loc3_];
            SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc2_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true);
            return;
         }
         if(FilterWordManager.isGotForbiddenWords(_loc3_) || FilterWordManager.containSpecificChar(_loc3_,"<>"))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.im.view.IMStateReplyInputView.dirtyWordTip"));
            return;
         }
         sendRosePresent(true,false,_roseTempId,1,_loc3_);
      }
      
      private function sendRosePresent(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:String) : void
      {
         if(!param1 || param4 <= 0)
         {
            return;
         }
         var _loc6_:ThaneInfo = getFriendInfoByUid(_senderId);
         if(!_loc6_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("simplegame.roses.RosePresentBackView.notFriend"));
            return;
         }
         var _loc7_:Array = GoodsManager.instance.getBagGoodsByTemplateId(param3);
         if(_loc7_.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.im.IMFrame.present.TipTxt"));
            return;
         }
         SocketSendManager.instance.sendUseItem(_loc7_[0].pos,param4,1,param5,_loc6_.userId);
         dispose();
      }
      
      private function showBuyFrameCall(param1:Array) : void
      {
         var _loc2_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         _loc2_.data(TempleteManager.instance.getShopTempInfoByItemId(param1[0]));
         _loc2_.show();
      }
      
      private function __onCancleClick(param1:MouseEvent) : void
      {
         switch(_roseTempId - 2170005)
         {
            case 0:
               IMManager.instance.createIMFrame(getFriendInfoByUid(_senderId,true));
               break;
            default:
               dispose();
         }
      }
      
      private function getFriendInfoByUid(param1:int, param2:Boolean = false) : ThaneInfo
      {
         for each(var _loc3_:ThaneInfo in FriendManager.getInstance().friendList)
         {
            if(_loc3_.userId == param1)
            {
               if(param2)
               {
                  return _loc3_;
               }
               if(_loc3_.relation == 1)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public function show() : void
      {
         this.height = _frameHeight;
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_inputBg)
         {
            _inputBg.dispose();
         }
         _inputBg = null;
         if(_contentBg)
         {
            _contentBg.dispose();
         }
         _contentBg = null;
         if(_contentTxt)
         {
            _contentTxt.dispose();
         }
         _contentTxt = null;
         if(_confirmBtn)
         {
            _confirmBtn.dispose();
         }
         _confirmBtn = null;
         if(_cancelBtn)
         {
            _cancelBtn.dispose();
         }
         _cancelBtn = null;
         ObjectUtils.disposeObject(_presentNameTxt);
         _presentNameTxt = null;
         ObjectUtils.disposeObject(_presentShowTxt);
         _presentShowTxt = null;
         ObjectUtils.disposeObject(_changeContentTxt);
         _changeContentTxt = null;
         ObjectUtils.disposeObject(_inputTipTxt);
         _inputTipTxt = null;
         ObjectUtils.disposeObject(_inputNumTxt);
         _inputNumTxt = null;
         ObjectUtils.disposeAllChildren(_contentContainer);
         _contentContainer = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

