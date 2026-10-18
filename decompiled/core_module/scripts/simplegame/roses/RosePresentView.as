package simplegame.roses
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.FriendUpdateEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FriendManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.component.WriteMailComboxBox;
   import yishi.view.tips.MessageTipManager;
   
   public class RosePresentView extends Frame
   {
      
      public static const MAX_CONTENT:int = 76;
      
      private var _bg:MutipleImage;
      
      private var _inputTipImg:Bitmap;
      
      private var _inputBg:ScaleBitmapImage;
      
      private var _contentBg:ScaleBitmapImage;
      
      private var _contentTxt:FilterFrameText;
      
      private var _wordCountTxt:FilterFrameText;
      
      private var _inputComBox:WriteMailComboxBox;
      
      private var _confirmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _tempStr:String = "";
      
      private var _tempContent:String = "";
      
      private var _selectIndex:int;
      
      private var _currentSelected:ThaneInfo;
      
      private var _friendList:Array;
      
      private var _useCount:int;
      
      private var _data:GoodsInfo;
      
      private var _type:int;
      
      public function RosePresentView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("friends.view.RosePresentView.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentViewBg");
         _inputTipImg = ComponentFactory.Instance.creatBitmap("asset.friends.RosePresentViewInputTipImg");
         _inputBg = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentViewInputBg");
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentViewContentBg");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentViewContentTxt");
         _wordCountTxt = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentViewWordCountTxt");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentViewConfirmBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentViewCancleBtn");
         _friendList = [];
         _wordCountTxt.text = LanguageMgr.GetTranslation("yishi.view.RosePresentView.wordCount",0,76);
         addToContent(_bg);
         addToContent(_inputTipImg);
         addToContent(_inputBg);
         addToContent(_contentBg);
         addToContent(_contentTxt);
         addToContent(_wordCountTxt);
         addToContent(_confirmBtn);
         addToContent(_cancelBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _confirmBtn.addEventListener("click",__onConfirmClick);
         _cancelBtn.addEventListener("click",__onCancleClick);
         _contentTxt.addEventListener("change",__contentInputHandler);
         FriendManager.getInstance().addEventListener("FRIEND_UPDATE",__friendUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _confirmBtn.removeEventListener("click",__onConfirmClick);
         _cancelBtn.removeEventListener("click",__onCancleClick);
         _contentTxt.removeEventListener("change",__contentInputHandler);
         _inputComBox.removeEventListener("select_textField",_selectField);
         _inputComBox.textField.removeEventListener("keyDown",__focusInHandler);
         _inputComBox.textField.removeEventListener("change",__inputNickNameHandler);
         FriendManager.getInstance().removeEventListener("FRIEND_UPDATE",__friendUpdateHandler);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
            case 4:
               dispose();
               break;
            case 2:
            case 3:
               __onConfirmClick(null);
         }
      }
      
      private function __friendUpdateHandler(param1:FriendUpdateEvent) : void
      {
         refreshComboBox(getFriendNameList());
         _selectField(null);
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
      
      private function __onConfirmClick(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = StringHelper.trimAll(_inputComBox.textValue).toLowerCase();
         if(StringHelper.isNullOrEmpty(_loc2_))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.view.RosePresentView.inputTip"));
            return;
         }
         if(_loc2_ == thane.nickName.toLowerCase())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.ShopControler.command01"));
            dispose();
            return;
         }
         var _loc4_:String = StringHelper.trim(_contentTxt.text);
         if(_type > 0 && StringHelper.isNullOrEmpty(_loc4_))
         {
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.RosePresentView.noContent");
            SimpleAlertHelper.instance.data = [sendRosePresent,_loc2_,_loc4_];
            SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc3_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true);
            return;
         }
         if(FilterWordManager.isGotForbiddenWords(_loc4_) || FilterWordManager.containSpecificChar(_loc4_,"<>"))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.im.view.IMStateReplyInputView.dirtyWordTip"));
            return;
         }
         sendRosePresent(true,false,_loc2_,_loc4_);
      }
      
      private function sendRosePresent(param1:Boolean, param2:Boolean, param3:String, param4:String) : void
      {
         var _loc5_:ThaneInfo = null;
         if(param1 && _data && _useCount > 0)
         {
            if(_currentSelected && _currentSelected.nickName.toLowerCase() == param3)
            {
               SocketSendManager.instance.sendUseItem(_data.pos,_useCount,1,param4,_currentSelected.userId);
            }
            else
            {
               _loc5_ = getFriendInfoByName(param3);
               if(_loc5_)
               {
                  SocketSendManager.instance.sendUseItem(_data.pos,_useCount,1,param4,_loc5_.userId);
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.view.RosePresentView.notFriends"));
               }
            }
            dispose();
         }
      }
      
      private function __onCancleClick(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function _selectField(param1:Event) : void
      {
         _selectIndex = 0;
         _currentSelected = null;
      }
      
      private function __focusInHandler(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function __inputNickNameHandler(param1:Event) : void
      {
         if(StringHelper.checkStringLength(_inputComBox.textValue) > 12)
         {
            _inputComBox.textValue = _tempStr;
         }
         _tempStr = _inputComBox.textValue;
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         _selectIndex = param1.index;
         _currentSelected = param1.cellValue;
      }
      
      private function initComboBox(param1:int) : void
      {
         var _loc2_:int = param1 > 0 ? 1 : 0;
         _inputComBox = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentViewInputComBox" + _loc2_);
         _inputComBox.textValue = "";
         _inputComBox.searchRange = 1;
         (_inputComBox.button as TextButton).text = LanguageMgr.GetTranslation("emailII.view.WriteEmailFrame.Friendlist");
         refreshComboBox(getFriendNameList());
         StageReferance.stage.focus = _inputComBox.textField;
         addToContent(_inputComBox);
         _inputComBox.addEventListener("select_textField",_selectField);
         _inputComBox.textField.addEventListener("keyDown",__focusInHandler);
         _inputComBox.textField.addEventListener("change",__inputNickNameHandler);
      }
      
      private function refreshComboBox(param1:Array) : void
      {
         var _loc4_:int = 0;
         _inputComBox.beginChanges();
         _inputComBox.selctedPropName = "text";
         var _loc3_:VectorListModel = _inputComBox.listPanel.vectorListModel;
         var _loc2_:int = int(param1.length);
         _loc3_.clear();
         while(_loc4_ < _loc2_)
         {
            _loc3_.append(param1[_loc4_]);
            _loc4_++;
         }
         _inputComBox.listPanel.list.updateListView();
         _inputComBox.listPanel.list.addEventListener("listItemClick",__itemClick);
         _inputComBox.commitChanges();
      }
      
      private function getFriendNameList() : Array
      {
         _friendList.splice(0,_friendList.length);
         var _loc1_:Dictionary = FriendManager.getInstance().friendList;
         for each(var _loc2_:ThaneInfo in _loc1_)
         {
            if(_loc2_.relation == 1)
            {
               _friendList.push(_loc2_);
            }
         }
         _friendList.sortOn(["isShine","state","friendGrade","friendGp","grades","nickName"],[2,0x10 | 2,0x10 | 2,0x10 | 2,0x10 | 2,1]);
         return _friendList;
      }
      
      private function getFriendInfoByName(param1:String) : ThaneInfo
      {
         for each(var _loc2_:ThaneInfo in _friendList)
         {
            if(_loc2_.nickName.toLowerCase() == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function setData(param1:GoodsInfo, param2:int = 1) : void
      {
         _data = param1;
         _useCount = param2;
         var _loc3_:GoodsTemplateInfo = _data ? _data.templateInfo : null;
         if(_loc3_)
         {
            _type = _loc3_.Property3;
            initComboBox(_type);
            switch(_type)
            {
               case 0:
               case 1:
               case 2:
                  _contentTxt.text = LanguageMgr.GetTranslation("yishi.view.RosePresentView.defaultContent" + _type);
                  _contentTxt.setSelection(0,_contentTxt.length);
                  _contentTxt.setFocus();
                  _wordCountTxt.text = LanguageMgr.GetTranslation("yishi.view.RosePresentView.wordCount",StringHelper.checkStringLength(_contentTxt.text),76);
                  break;
               default:
                  if(_contentBg.parent)
                  {
                     _contentBg.parent.removeChild(_contentBg);
                  }
                  if(_contentTxt.parent)
                  {
                     _contentTxt.parent.removeChild(_contentTxt);
                  }
                  if(_wordCountTxt.parent)
                  {
                     _wordCountTxt.parent.removeChild(_wordCountTxt);
                  }
                  _inputTipImg.x = 27;
                  _inputTipImg.y = 37;
                  _inputBg.width = 160;
                  _inputBg.x = 27;
                  _inputBg.y = 77;
                  _confirmBtn.x = 26;
                  _cancelBtn.x = 192;
                  _confirmBtn.y = _cancelBtn.y = 131;
            }
         }
      }
      
      public function show() : void
      {
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
         if(_inputComBox)
         {
            _inputComBox.dispose();
         }
         _inputComBox = null;
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
         ObjectUtils.disposeObject(_inputTipImg);
         _inputTipImg = null;
         _currentSelected = null;
         _friendList = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

