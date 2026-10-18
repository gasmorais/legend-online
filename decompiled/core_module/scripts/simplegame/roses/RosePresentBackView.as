package simplegame.roses
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
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
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.tips.MessageTipManager;
   
   public class RosePresentBackView extends Frame
   {
      
      public static const ROSEID_9999:int = 2170005;
      
      public static const ROSEID_999:int = 2170004;
      
      public static const ROSEID_99:int = 2170003;
      
      public static const ROSEID_11:int = 2170002;
      
      public static const ROSEID_1:int = 2170001;
      
      public static const MAX_CONTENT:int = 76;
      
      public static const SNOWROSEID:int = 2131116;
      
      private var _bg:MutipleImage;
      
      private var _inputTipTxt:FilterFrameText;
      
      private var _inputNumTxt:FilterFrameText;
      
      private var _inputBg:ScaleBitmapImage;
      
      private var _presentNameTxt:GradientText;
      
      private var _presentShowTxt:GradientText;
      
      private var _tabGroup:SelectedButtonGroup;
      
      private var _99Tab:SelectedIconTextButton;
      
      private var _999Tab:SelectedIconTextButton;
      
      private var _changeContentTxt:FilterFrameText;
      
      private var _contentContainer:Sprite;
      
      private var _contentBg:MutipleImage;
      
      private var _contentTxt:FilterFrameText;
      
      private var _wordCountTxt:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _tempContent:String = "";
      
      private var _targetName:String;
      
      private var _roseTempId:int;
      
      private var _frameHeight:int;
      
      public function RosePresentBackView(param1:int, param2:String)
      {
         super();
         _roseTempId = param1;
         _targetName = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:GoodsTemplateInfo = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc2_:String = null;
         titleText = LanguageMgr.GetTranslation("simplegame.roses.RosePresentBackView.presentBack");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewConfirmBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewCancleBtn");
         _confirmBtn.icon["setFrame"](1);
         _cancelBtn.icon["setFrame"](1);
         _confirmBtn.iconInnerRectString = "8,78,10,21,13";
         _cancelBtn.iconInnerRectString = "10,74,10,22,13";
         switch(_roseTempId - 2170003)
         {
            case 0:
            case 1:
               _frameHeight = 234;
               _tabGroup = new SelectedButtonGroup();
               _contentContainer = ComponentFactory.Instance.creatCustomObject("friends.RosePresentBackViewContentContainer");
               _bg = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewBg");
               _presentNameTxt = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewPresentNameTxt");
               _presentShowTxt = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewPresentShowTxt");
               _99Tab = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackView99Tab");
               _999Tab = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackView999Tab");
               _changeContentTxt = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewChangeContentTxt");
               _contentBg = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewContentBg");
               _contentTxt = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewContentTxt");
               _wordCountTxt = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewWordCountTxt");
               _tabGroup.addSelectItem(_99Tab);
               _tabGroup.addSelectItem(_999Tab);
               _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(2170003);
               _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(2170004);
               _loc2_ = "";
               if(_loc1_)
               {
                  _99Tab.text = _loc1_.TemplateName;
               }
               if(_loc3_)
               {
                  _999Tab.text = _loc3_.TemplateName;
               }
               if(_roseTempId == 2170003)
               {
                  _tabGroup.selectIndex = 0;
                  _contentTxt.text = LanguageMgr.GetTranslation("yishi.view.RosePresentView.defaultContent1");
                  if(_loc1_)
                  {
                     _loc2_ = _loc1_.TemplateName;
                  }
               }
               else
               {
                  _tabGroup.selectIndex = 1;
                  _contentTxt.text = LanguageMgr.GetTranslation("yishi.view.RosePresentView.defaultContent2");
                  if(_loc3_)
                  {
                     _loc2_ = _loc3_.TemplateName;
                  }
               }
               _presentNameTxt.text = _targetName;
               _presentShowTxt.text = LanguageMgr.GetTranslation("simplegame.roses.RosePresentBackView.presentShowContent",_loc2_);
               _changeContentTxt.htmlText = "<a href=\'event:#\'>" + LanguageMgr.GetTranslation("simplegame.roses.RosePresentBackView.changeContent") + "</a>";
               _wordCountTxt.text = LanguageMgr.GetTranslation("yishi.view.RosePresentView.wordCount",StringHelper.checkStringLength(_contentTxt.text),76);
               _confirmBtn.icon["setFrame"](2);
               _cancelBtn.icon["setFrame"](2);
               _confirmBtn.iconInnerRectString = "15,66,14,16,13";
               _cancelBtn.iconInnerRectString = "10,75,14,16,13";
               _confirmBtn.x = 44;
               _confirmBtn.y = 143;
               _cancelBtn.x = 204;
               _cancelBtn.y = 143;
               _contentContainer.visible = false;
               _contentContainer.addChild(_contentBg);
               _contentContainer.addChild(_contentTxt);
               _contentContainer.addChild(_wordCountTxt);
               addToContent(_bg);
               addToContent(_presentNameTxt);
               addToContent(_presentShowTxt);
               addToContent(_99Tab);
               addToContent(_999Tab);
               addToContent(_changeContentTxt);
               addToContent(_contentContainer);
               break;
            default:
               _frameHeight = 160;
               _inputTipTxt = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewInputTipTxt");
               _inputNumTxt = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewInputNumTxt");
               _inputBg = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewInputNumBg");
               _inputTipTxt.text = LanguageMgr.GetTranslation("simplegame.roses.RosePresentBackView.inputNum");
               _inputNumTxt.text = "1";
               _inputNumTxt.setSelection(0,_inputNumTxt.length);
               _inputNumTxt.setFocus();
               addToContent(_inputBg);
               addToContent(_inputTipTxt);
               addToContent(_inputNumTxt);
         }
         addToContent(_confirmBtn);
         addToContent(_cancelBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _confirmBtn.addEventListener("click",__onConfirmClick);
         _cancelBtn.addEventListener("click",__onCancleClick);
         if(_tabGroup)
         {
            _tabGroup.addEventListener("change",__tabSelectedHandler);
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
         if(_tabGroup)
         {
            _tabGroup.removeEventListener("change",__tabSelectedHandler);
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
      
      private function __tabSelectedHandler(param1:Event) : void
      {
         var _loc2_:ISelectable = _tabGroup.getSelectedItem();
         switch(_loc2_)
         {
            case _99Tab:
               _roseTempId = 2170003;
               _contentTxt.text = LanguageMgr.GetTranslation("yishi.view.RosePresentView.defaultContent1");
               break;
            case _999Tab:
               _roseTempId = 2170004;
               _contentTxt.text = LanguageMgr.GetTranslation("yishi.view.RosePresentView.defaultContent2");
         }
         __contentInputHandler(null);
      }
      
      private function __contentInputHandler(param1:Event) : void
      {
         var _loc2_:int = StringHelper.checkStringLength(_contentTxt.text);
         if(_loc2_ > 76)
         {
            _contentTxt.text = _tempContent;
         }
         _tempContent = _contentTxt.text;
         _wordCountTxt.text = LanguageMgr.GetTranslation("yishi.view.RosePresentView.wordCount",StringHelper.checkStringLength(_tempContent),76);
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
         var _loc3_:String = null;
         var _loc2_:String = null;
         switch(_roseTempId - 2170001)
         {
            case 0:
               sendRosePresent(true,false,2170001,_targetName,int(_inputNumTxt.text),"");
               dispose();
               break;
            case 1:
               sendRosePresent(true,false,2170002,_targetName,int(_inputNumTxt.text),"");
               dispose();
               break;
            case 2:
            case 3:
               _loc3_ = StringHelper.trim(_contentTxt.text);
               if(StringHelper.isNullOrEmpty(_loc3_))
               {
                  _loc2_ = LanguageMgr.GetTranslation("yishi.view.RosePresentView.noContent");
                  SimpleAlertHelper.instance.data = [sendRosePresent,_roseTempId,_targetName,1,_loc3_];
                  SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc2_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true);
                  return;
               }
               if(FilterWordManager.isGotForbiddenWords(_loc3_) || FilterWordManager.containSpecificChar(_loc3_,"<>"))
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.im.view.IMStateReplyInputView.dirtyWordTip"));
                  return;
               }
               sendRosePresent(true,false,_roseTempId,_targetName,1,_loc3_);
         }
      }
      
      private function sendRosePresent(param1:Boolean, param2:Boolean, param3:int, param4:String, param5:int, param6:String) : void
      {
         if(!param1 || param5 <= 0)
         {
            return;
         }
         var _loc7_:ThaneInfo = getFriendInfoByName(param4);
         if(!_loc7_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("simplegame.roses.RosePresentBackView.notFriend"));
            return;
         }
         var _loc8_:Array = GoodsManager.instance.getBagGoodsByTemplateId(param3);
         if(_loc8_.length == 0)
         {
            switch(param3 - 2170003)
            {
               case 0:
               case 1:
                  CheckUIModuleUtil.instance.tryCall("quickbuy",showBuyFrameCall,[param3]);
                  break;
               default:
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("Auction.ResultAlert2"));
            }
            return;
         }
         _loc8_.sortOn("isBinds",2);
         SocketSendManager.instance.sendUseItem(_loc8_[0].pos,param5,1,param6,_loc7_.userId);
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
         switch(_roseTempId - 2170003)
         {
            case 0:
            case 1:
               IMManager.instance.createIMFrame(getFriendInfoByName(_targetName,true));
               break;
            default:
               dispose();
         }
      }
      
      private function getFriendInfoByName(param1:String, param2:Boolean = false) : ThaneInfo
      {
         for each(var _loc3_:ThaneInfo in FriendManager.getInstance().friendList)
         {
            if(_loc3_.nickName == param1)
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
         if(_wordCountTxt)
         {
            _wordCountTxt.dispose();
         }
         _wordCountTxt = null;
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
         ObjectUtils.disposeObject(_99Tab);
         _99Tab = null;
         ObjectUtils.disposeObject(_999Tab);
         _999Tab = null;
         ObjectUtils.disposeObject(_changeContentTxt);
         _changeContentTxt = null;
         ObjectUtils.disposeObject(_tabGroup);
         _tabGroup = null;
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

