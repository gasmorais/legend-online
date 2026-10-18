package emailII.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.simple.SimplePlayerSearchReqMsg;
   import com.road.yishi.proto.simple.SimplePlayerSearchRspMsg;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import mvc.controler.EmailControler;
   import mvc.module.emailII.EmailModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FriendManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.StringHelper;
   import yishi.utils.StringUtil;
   import yishi.utils.TextFieldHelp;
   import yishi.view.component.WriteMailComboxBox;
   import yishi.view.tips.MessageTipManager;
   
   public class WriteEmailFrame extends Frame
   {
      
      private var _line:BitmapData;
      
      private var _comBoxBack:Bitmap;
      
      private var _comboBox:WriteMailComboxBox;
      
      private var _background:MutipleImage;
      
      private var _costValue:FilterFrameText;
      
      private var _subjectValue:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _sendBtn:SelectedCheckButton;
      
      private var _closeBtn:SelectedCheckButton;
      
      private var _selectIndex:int;
      
      private var _control:EmailControler;
      
      private var _model:EmailModel;
      
      private var _tempStr:String = "";
      
      private var _target:String;
      
      private var _subject:String;
      
      private var _contentValue:String;
      
      private var _currentSelected:ThaneInfo;
      
      private var _friendList:Array = [];
      
      public function WriteEmailFrame()
      {
         super();
         titleText = LanguageMgr.GetTranslation("emailII.view.WriteEmailFrame.title");
         initView();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Bitmap = null;
         _background = ComponentFactory.Instance.creatComponentByStylename("writeemail.WriteEmailBack");
         _comBoxBack = ComponentFactory.Instance.creatBitmap("asset.writeemail.WriteMailSelectInputBg");
         _costValue = ComponentFactory.Instance.creatComponentByStylename("writeemail.WriteEmailCostValueText");
         _costValue.text = LanguageMgr.GetTranslation("emailII.view.WriteEmailFrame.cost",100);
         _subjectValue = ComponentFactory.Instance.creatComponentByStylename("writeemail.WriteTitleValueText");
         _content = ComponentFactory.Instance.creatComponentByStylename("writeemail.WriteContentText");
         _sendBtn = ComponentFactory.Instance.creatComponentByStylename("email.ReplyBtn");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("writeemail.CloseBtn");
         _comboBox = ComponentFactory.Instance.creatComponentByStylename("email.Combox1");
         _line = ComponentFactory.Instance.creatBitmapData("asset.core.WriteEmailLine");
         _subjectValue.maxChars = 15;
         _sendBtn.text = LanguageMgr.GetTranslation("public.send");
         _closeBtn.text = LanguageMgr.GetTranslation("public.cancel1");
         initComboBox(getFriendNameList());
         addToContent(_background);
         addToContent(_comBoxBack);
         _loc3_ = 0;
         while(_loc3_ < 12)
         {
            _loc2_ = new Bitmap(_line);
            _loc2_.x = 5;
            _loc2_.y = _loc3_ * 24 + 84;
            addToContent(_loc2_);
            _loc3_++;
         }
         addToContent(_costValue);
         addToContent(_subjectValue);
         addToContent(_content);
         addToContent(_sendBtn);
         addToContent(_closeBtn);
         addToContent(_comboBox);
         _comboBox.textValue = "";
         var _loc1_:String = LanguageMgr.GetTranslation("public.friend");
         _comboBox.friendBtn.text = _loc1_;
         var _loc4_:String = LanguageMgr.GetTranslation("emailII.view.WriteEmailFrame.friendListTip");
         (_comboBox.button as TextButton).text = _loc4_;
         _comboBox.consortiaBtn.enable = PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID != 0;
         (_comboBox.button as TextButton).text = LanguageMgr.GetTranslation("emailII.view.WriteEmailFrame.Friendlist");
         _comboBox.friendBtn.text = LanguageMgr.GetTranslation("public.friend");
         _comboBox.consortiaBtn.text = LanguageMgr.GetTranslation("public.consortia");
      }
      
      private function initComboBox(param1:Array) : void
      {
         _comboBox.beginChanges();
         _comboBox.selctedPropName = "text";
         var _loc2_:VectorListModel = _comboBox.listPanel.vectorListModel;
         _loc2_.clear();
         for each(var _loc3_:ThaneInfo in param1)
         {
            if(_loc3_.userId != thane.userId)
            {
               _loc2_.append(_loc3_);
            }
         }
         _comboBox.listPanel.list.updateListView();
         _comboBox.listPanel.list.addEventListener("listItemClick",__itemClick);
         _comboBox.commitChanges();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _sendBtn.addEventListener("click",__sendHandler);
         _closeBtn.addEventListener("click",__closeHandler);
         _comboBox.button.addEventListener("click",_comboClick);
         _comboBox.addEventListener("friend_selected",_comboFriend);
         _comboBox.addEventListener("consortia_selected",_comConsortia);
         _comboBox.addEventListener("select_textField",_selectField);
         _comboBox.textField.addEventListener("keyDown",__focusInHandler);
         _comboBox.textField.addEventListener("change",__inputNickNameHandler);
         _subjectValue.addEventListener("keyDown",__focusInHandler);
         _content.addEventListener("keyDown",__focusInHandler);
         _content.addEventListener("change",__onContentChangeHandler);
         _content.addEventListener("scroll",__onScrollHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4170,__getUserInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_sendBtn)
         {
            _sendBtn.removeEventListener("click",__sendHandler);
         }
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__closeHandler);
         }
         if(_subjectValue)
         {
            _subjectValue.removeEventListener("keyDown",__focusInHandler);
         }
         if(_comboBox)
         {
            _comboBox.removeEventListener("friend_selected",_comboFriend);
            _comboBox.removeEventListener("consortia_selected",_comConsortia);
            _comboBox.removeEventListener("select_textField",_selectField);
            if(_comboBox.button)
            {
               _comboBox.button.removeEventListener("click",_comboClick);
            }
            if(_comboBox.textField)
            {
               _comboBox.textField.removeEventListener("keyDown",__focusInHandler);
            }
            if(_comboBox.textField)
            {
               _comboBox.textField.removeEventListener("change",__inputNickNameHandler);
            }
            if(_comboBox.listPanel && _comboBox.listPanel.list)
            {
               _comboBox.listPanel.list.removeEventListener("listItemClick",__itemClick);
            }
         }
         if(_content)
         {
            _content.removeEventListener("keyDown",__focusInHandler);
            _content.removeEventListener("change",__onContentChangeHandler);
            _content.removeEventListener("scroll",__onScrollHandler);
         }
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4170,__getUserInfoHandler);
      }
      
      private function __inputNickNameHandler(param1:Event) : void
      {
         if(StringHelper.checkStringLength(_comboBox.textValue) > 12)
         {
            _comboBox.textValue = _tempStr;
         }
         _tempStr = _comboBox.textValue;
      }
      
      private function __focusInHandler(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function __onContentChangeHandler(param1:Event) : void
      {
         TextFieldHelp.limitLines(_content,7);
      }
      
      private function __onScrollHandler(param1:Event) : void
      {
         _content.scrollV = 1;
      }
      
      private function __getUserInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:Array = null;
         var _loc3_:String = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:SimplePlayerSearchRspMsg = new SimplePlayerSearchRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as SimplePlayerSearchRspMsg;
         if(_loc2_.hasInfo && _loc2_.info.nickName.toLowerCase() == _target.toLowerCase())
         {
            _loc4_ = [];
            _loc4_.push(_loc2_.info.userId);
            sendEmail(_loc4_);
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("emailII.view.WriteEmailFrame.content01",_comboBox.textValue);
            MessageTipManager.instance().show(_loc3_);
         }
      }
      
      private function __sendHandler(param1:MouseEvent) : void
      {
         var _loc4_:Array = null;
         var _loc5_:PackageOut = null;
         var _loc3_:SimplePlayerSearchReqMsg = null;
         SoundManager.instance.play("022");
         var _loc2_:String = "";
         if(VersionSwitch.FILTER_TRIM)
         {
            _target = StringUtil.remove(_comboBox.textValue," ");
            _subject = StringUtil.remove(FilterWordManager.filterWrod(_subjectValue.text)," ");
            _contentValue = StringUtil.remove(FilterWordManager.filterWrod(_content.text)," ");
         }
         else
         {
            _target = _comboBox.textValue;
            _subject = FilterWordManager.filterWrod(_subjectValue.text);
            _contentValue = FilterWordManager.filterWrod(_content.text);
         }
         if(!_target)
         {
            _loc2_ = LanguageMgr.GetTranslation("emailII.view.WriteEmailFrame.target");
         }
         else if(!_subject)
         {
            _loc2_ = LanguageMgr.GetTranslation("emailII.view.WriteEmailFrame.subject");
         }
         else if(!_contentValue)
         {
            _loc2_ = LanguageMgr.GetTranslation("emailII.view.WriteEmailFrame.content");
         }
         else if(_currentSelected && _currentSelected.nickName == _comboBox.textValue)
         {
            _loc4_ = [];
            _loc4_.push(_currentSelected.userId);
            sendEmail(_loc4_);
         }
         else if(_target)
         {
            _loc5_ = new PackageOut(8257);
            _loc3_ = new SimplePlayerSearchReqMsg();
            _loc3_.otherNickname = _target;
            SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc3_);
         }
         if(_loc2_)
         {
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function sendEmail(param1:Array) : void
      {
         _control.sendEmail(param1,_subject,_contentValue);
         dispose();
      }
      
      private function __closeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function _comboFriend(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(!_comboBox.friendBtn.selected)
         {
            _selectIndex = 0;
            initComboBox(getFriendNameList());
         }
      }
      
      private function _comboClick(param1:Event) : void
      {
         SoundManager.instance.play("022");
      }
      
      private function _comConsortia(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(!_comboBox.consortiaBtn.selected)
         {
            _selectIndex = 0;
            initComboBox(ConsortiaManager.instance.model.consortiaMemberList.getList());
         }
      }
      
      private function _selectField(param1:Event) : void
      {
         _selectIndex = 0;
         _currentSelected = null;
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         SoundManager.instance.play("022");
         _selectIndex = param1.index;
         _currentSelected = param1.cellValue;
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
         return _friendList;
      }
      
      public function sendEmailToPerson(param1:String) : void
      {
         if(param1)
         {
            _comboBox.textField.text = param1;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP"];
      }
      
      public function show(param1:EmailControler, param2:EmailModel) : void
      {
         _control = param1;
         _model = param2;
         if(!StringHelper.isNullOrEmpty(_model.reply))
         {
            _selectField(null);
            _comboBox.textField.text = _model.reply;
            _model.reply = "";
         }
         initEvent();
         LayerManager.Instance.addToLayer(this,3,true);
         StageReferance.stage.focus = _subjectValue;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

