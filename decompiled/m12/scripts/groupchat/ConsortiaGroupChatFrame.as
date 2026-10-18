package groupchat
{
   import chat.ChatManager;
   import chat.utils.ChatHelper;
   import chat.view.ExpressionList;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import events.GroupChatEvent;
   import events.SNSEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import groupchat.view.ConsortiaGroupChatHistoryView;
   import groupchat.view.ConsortiaGroupChatNotic;
   import manager.LanguageMgr;
   import managers.SNSManager;
   import mvc.module.groupchat.ConsortiaGroupChatData;
   import mvc.module.groupchat.ConsortiaGroupChatModel;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.IMEManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.StringHelper;
   import yishi.view.community.PlayerMenu;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaGroupChatFrame extends Frame implements IManualSize
   {
      
      public var needDispose:Boolean = false;
      
      private var _outputBack:ScaleBitmapImage;
      
      private var _inputBack:ScaleBitmapImage;
      
      private var _broadcastBack:ScaleBitmapImage;
      
      private var _buttonBack:Image;
      
      private var _titleImg:Bitmap;
      
      private var _minimizeBtn:BaseButton;
      
      private var _miniCloseBtn:BaseButton;
      
      private var _consortiaBtn:TextButton;
      
      private var _historyBtn:TextButton;
      
      private var _closeBtn:TextButton;
      
      private var _sendBtn:TextButton;
      
      private var _updateBtn:TextButton;
      
      private var _shineSwitchBtn:SelectedButton;
      
      private var _expressionBtn:BaseButton;
      
      private var _expressionList:ExpressionList;
      
      private var _notice:FilterFrameText;
      
      private var _broadCastTitle:FilterFrameText;
      
      private var _broadCast:FilterFrameText;
      
      private var _broadCastTip:FilterFrameText;
      
      private var _memberListTitle:FilterFrameText;
      
      private var _input:FilterFrameText;
      
      private var _menberList:ListPanel;
      
      private var _output:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _warningIcon:Image;
      
      private var _warningText:FilterFrameText;
      
      private var _menberListArray:Array;
      
      private var _onLine:int;
      
      private var _currentInChannel:int;
      
      private var _lastData:ConsortiaGroupChatData;
      
      private var _selfCount:int = 1;
      
      private var _timeLimit:Boolean = false;
      
      private var _timerID:uint;
      
      private var _menu:PlayerMenu;
      
      private var _isBroChanged:Boolean;
      
      private var _scrollValue:int;
      
      private var _broadcastFocusOutChange:String = "";
      
      private var _historyView:ConsortiaGroupChatHistoryView;
      
      public function ConsortiaGroupChatFrame()
      {
         super();
         initView();
         initEvent();
         mouseEnabled = false;
         _output.mouseEnabled = false;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,602,462);
      }
      
      override public function get groups() : Array
      {
         return ["GROUPCHAT"];
      }
      
      private function initView() : void
      {
         _vBox = new VBox();
         _vBox.spacing = 0;
         _vBox.mouseEnabled = false;
         _output = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.ChatList");
         _output.setView(_vBox,true);
         _outputBack = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.ChatListBack");
         _inputBack = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.InputBack");
         _broadcastBack = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.BroadCastBack");
         _buttonBack = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.ButtonBack");
         _titleImg = ComponentFactory.Instance.creatBitmap("asset.consortiagroupchat.TitleText");
         _minimizeBtn = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.MinimizeBtn");
         _miniCloseBtn = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.MiniCloseBtn");
         _consortiaBtn = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.ConsortiaBtn");
         _historyBtn = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.HistoryBtn");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.CloseBtn");
         _sendBtn = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.SendBtn");
         _updateBtn = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.UpdateBtn");
         _shineSwitchBtn = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.ShineSwitchBtn");
         _expressionBtn = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.ChatExpressionBtn");
         _broadCastTitle = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.BroadCastTitleText");
         _broadCast = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.BroadCastText");
         _broadCastTip = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.BroadCastInputTipTextStyle");
         _memberListTitle = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.MenberListTitleText");
         _input = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.InputText");
         _menberList = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.MenberListPanel");
         _warningIcon = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.WarningIcon");
         _warningText = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.WarningText");
         _consortiaBtn.text = LanguageMgr.GetTranslation("consortiagroupchat.consortiaBtnTxt");
         _historyBtn.text = LanguageMgr.GetTranslation("consortiagroupchat.historyBtnTxt");
         _closeBtn.text = LanguageMgr.GetTranslation("consortiagroupchat.closeBtnTxt");
         _sendBtn.text = LanguageMgr.GetTranslation("consortiagroupchat.sendBtnTxt");
         _updateBtn.text = LanguageMgr.GetTranslation("consortiagroupchat.updateBtnTxt");
         _broadCastTitle.text = LanguageMgr.GetTranslation("consortiagroupchat.broadCastTitle");
         _broadCastTip.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaFrameRightContent.pronouncement");
         _broadCastTip.visible = false;
         _warningText.text = LanguageMgr.GetTranslation("friends.im.view.IMChatInfoView.Notice");
         _sendBtn.tipData = LanguageMgr.GetTranslation("friends.im.IMFrame.send");
         _broadCast.selectable = _broadCast.mouseEnabled = false;
         _updateBtn.enable = false;
         _updateBtn.visible = false;
         _input.maxChars = 84;
         if(model.shineSwitch)
         {
            _shineSwitchBtn.tipData = LanguageMgr.GetTranslation("groupchat.ConsortiaGroupChatFrame.shineClose");
            _shineSwitchBtn.selected = false;
         }
         else
         {
            _shineSwitchBtn.tipData = LanguageMgr.GetTranslation("groupchat.ConsortiaGroupChatFrame.shineOpen");
            _shineSwitchBtn.selected = true;
         }
         addToContent(_outputBack);
         addToContent(_inputBack);
         addToContent(_broadcastBack);
         addToContent(_buttonBack);
         addToContent(_titleImg);
         addToContent(_minimizeBtn);
         addToContent(_miniCloseBtn);
         addToContent(_shineSwitchBtn);
         addToContent(_expressionBtn);
         addToContent(_consortiaBtn);
         addToContent(_historyBtn);
         addToContent(_closeBtn);
         addToContent(_sendBtn);
         addToContent(_updateBtn);
         addToContent(_warningIcon);
         addToContent(_warningText);
         addToContent(_broadCastTitle);
         addToContent(_broadCast);
         addToContent(_broadCastTip);
         addToContent(_memberListTitle);
         addToContent(_input);
         addToContent(_menberList);
         addToContent(_output);
         _expressionBtn.tipData = LanguageMgr.GetTranslation("chat.view.ChatView.command06");
         _currentInChannel = 5;
         setBroadCast();
         setBroadCastState();
         _input.setFocus();
      }
      
      private function initData() : void
      {
         var _loc3_:int = 0;
         var _loc1_:ConsortiaGroupChatData = null;
         _vBox.removeAllChild();
         var _loc2_:int = int(model.curConsortiaChats.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = model.curConsortiaChats[_loc3_];
            appendChatData(_loc1_);
            _loc3_++;
         }
         refreshView();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__response);
         model.addEventListener("consortiagroupchatupdate",__updateHandler);
         model.addEventListener("consortiagroupchatitemselected",__itemClickHandler);
         model.addEventListener("consortiagroupchatitemupdate",__itemUpdateHandler);
         ConsortiaManager.instance.model.addEventListener("UPDATA_CONSORTIA_MEMBER",__onMemberListUpdata);
         ConsortiaManager.instance.model.addEventListener("UPDA_CONSORTIA_RIGHTS",__onMemberListUpdata);
         ConsortiaManager.instance.model.addEventListener("UPDA_CONSORTIA_INFO",__onConsortiaUpdata);
         SNSManager.instance.addEventListener("SNSINFO_UPDATE",__snsInfoUpdateHandler);
         _minimizeBtn.addEventListener("click",__minimizeBtnHandler);
         _miniCloseBtn.addEventListener("click",__onCloseClick);
         _consortiaBtn.addEventListener("click",__consortiaBtnHandler);
         _historyBtn.addEventListener("click",__historyBtnHandler);
         _closeBtn.addEventListener("click",__onCloseClick);
         _sendBtn.addEventListener("click",__sendBtnHandler);
         _updateBtn.addEventListener("click",__updateBtnHandler);
         _shineSwitchBtn.addEventListener("select",__shineSwitchHandler);
         _expressionBtn.addEventListener("mouseDown",___expressionBtnDownHandler);
         _expressionBtn.addEventListener("click",___expressionBtnClickHandler);
         _input.addEventListener("focusIn",__onInputFocusInHandler);
         _input.addEventListener("focusOut",__onInputFocusOutHandler);
         _input.addEventListener("keyDown",__inputKeyDownHandler);
         _broadCast.addEventListener("focusIn",__onBroFocusInHandler);
         _broadCast.addEventListener("focusOut",__onBroFocusOutHandler);
         _broadCast.addEventListener("change",__onBroFocusOutChangeHandler);
         _broadCast.addEventListener("keyDown",__keyDownHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__response);
         model.removeEventListener("consortiagroupchatupdate",__updateHandler);
         model.removeEventListener("consortiagroupchatitemselected",__itemClickHandler);
         model.removeEventListener("consortiagroupchatitemupdate",__itemUpdateHandler);
         ConsortiaManager.instance.model.removeEventListener("UPDATA_CONSORTIA_MEMBER",__onMemberListUpdata);
         ConsortiaManager.instance.model.removeEventListener("UPDA_CONSORTIA_RIGHTS",__onMemberListUpdata);
         ConsortiaManager.instance.model.removeEventListener("UPDA_CONSORTIA_INFO",__onConsortiaUpdata);
         SNSManager.instance.removeEventListener("SNSINFO_UPDATE",__snsInfoUpdateHandler);
         _minimizeBtn.removeEventListener("click",__minimizeBtnHandler);
         _miniCloseBtn.removeEventListener("click",__onCloseClick);
         _consortiaBtn.removeEventListener("click",__consortiaBtnHandler);
         _historyBtn.removeEventListener("click",__historyBtnHandler);
         _closeBtn.removeEventListener("click",__onCloseClick);
         _sendBtn.removeEventListener("click",__sendBtnHandler);
         _updateBtn.removeEventListener("click",__updateBtnHandler);
         _shineSwitchBtn.removeEventListener("select",__shineSwitchHandler);
         _expressionBtn.removeEventListener("mouseDown",___expressionBtnDownHandler);
         _expressionBtn.removeEventListener("click",___expressionBtnClickHandler);
         _input.removeEventListener("focusIn",__onInputFocusInHandler);
         _input.removeEventListener("focusOut",__onInputFocusOutHandler);
         _input.removeEventListener("keyDown",__inputKeyDownHandler);
         _broadCast.removeEventListener("focusIn",__onBroFocusInHandler);
         _broadCast.removeEventListener("focusOut",__onBroFocusOutHandler);
         _broadCast.removeEventListener("change",__onBroFocusOutChangeHandler);
         _broadCast.removeEventListener("keyDown",__keyDownHandler);
      }
      
      private function ___expressionBtnDownHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function ___expressionBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_expressionList)
         {
            _expressionList.dispose();
            return;
         }
         LayerManager.Instance.clearGameMenuLayer();
         if(!_expressionList)
         {
            _expressionList = new ExpressionList();
         }
         _expressionList.addEventListener("dispose",__onExpressionListDispose);
         var _loc2_:Point = new Point(_expressionBtn.x,_expressionBtn.y);
         _expressionList.x = localToGlobal(_loc2_).x - _expressionList.width / 2 + 18;
         _expressionList.y = localToGlobal(_loc2_).y - _expressionList.height + 8;
         _expressionList.input = _input;
         LayerManager.Instance.addToLayer(_expressionList,7);
      }
      
      private function __onExpressionListDispose(param1:Event) : void
      {
         _expressionList.removeEventListener("dispose",__onExpressionListDispose);
         _expressionList = null;
      }
      
      private function __onInputFocusInHandler(param1:Event) : void
      {
         IMEManager.enable();
      }
      
      private function __onInputFocusOutHandler(param1:Event) : void
      {
         IMEManager.disable();
      }
      
      private function __inputKeyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            sendChat();
         }
         param1.stopPropagation();
      }
      
      private function sendChat() : void
      {
         var _loc1_:String = "";
         if(StringHelper.isNullOrEmpty(_input.text))
         {
            _loc1_ = LanguageMgr.GetTranslation("consortiagroupchat.command01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(_timeLimit)
         {
            _loc1_ = LanguageMgr.GetTranslation("friends.im.IMFrame.command03");
            MessageTipManager.instance().show(_loc1_,true);
            return;
         }
         _timeLimit = true;
         _timerID = setTimeout(limitTimeOutHandler,1000);
         var _loc2_:String = _input.text;
         _loc1_ = ChatHelper.parasMsgs(_loc2_);
         if(!ChatHelper.checkCanSend(_loc1_,_currentInChannel))
         {
            _input.text = "";
            return;
         }
         SoundManager.instance.play("006");
         ChatManager.instance.chatNormal(_loc1_,_currentInChannel,"",[],[],[]);
         _input.text = "";
         _input.setFocus();
      }
      
      private function limitTimeOutHandler() : void
      {
         clearTimeout(_timerID);
         _timeLimit = false;
      }
      
      private function __onBroFocusInHandler(param1:Event) : void
      {
         if(!_isBroChanged)
         {
            _broadCastTip.visible = false;
         }
         IMEManager.enable();
         _updateBtn.enable = true;
      }
      
      private function __onBroFocusOutHandler(param1:Event) : void
      {
         if(!_isBroChanged && Boolean(StringHelper.isNullOrEmpty(_broadCast.text)))
         {
            _broadCastTip.visible = true;
         }
      }
      
      private function __onBroFocusOutChangeHandler(param1:Event) : void
      {
         if(_broadCast.textHeight > 90)
         {
            _broadCast.text = _broadcastFocusOutChange;
            StageReferance.stage.focus = _updateBtn;
         }
         _broadcastFocusOutChange = _broadCast.text;
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function __minimizeBtnHandler(param1:MouseEvent) : void
      {
         if(_historyView)
         {
            _historyView.dispose();
         }
         MainToolBar.instance.poptipButtonVisible = true;
         dispose();
      }
      
      private function __consortiaBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("consortia");
      }
      
      private function __historyBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_historyView)
         {
            _historyView = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.HistoryView");
            _historyView.addEventListener("dispose",__disposeHandler);
            _historyView.show(this);
         }
         else
         {
            _historyView.dispose();
         }
      }
      
      private function __disposeHandler(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("dispose",__disposeHandler);
         _historyView = null;
      }
      
      private function __sendBtnHandler(param1:MouseEvent) : void
      {
         sendChat();
      }
      
      private function __updateBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_updateBtn.enable)
         {
            return;
         }
         FrameControllerManager.instance.consortiaGroupChatControler.sendModifyGroupPlacard(_broadCast.text);
         _updateBtn.enable = false;
      }
      
      private function __shineSwitchHandler(param1:Event) : void
      {
         if(_shineSwitchBtn)
         {
            if(!_shineSwitchBtn.selected)
            {
               _shineSwitchBtn.tipData = LanguageMgr.GetTranslation("groupchat.ConsortiaGroupChatFrame.shineClose");
               model.shineSwitch = true;
            }
            else
            {
               _shineSwitchBtn.tipData = LanguageMgr.GetTranslation("groupchat.ConsortiaGroupChatFrame.shineOpen");
               model.shineSwitch = false;
            }
         }
      }
      
      private function __updateHandler(param1:GroupChatEvent) : void
      {
         var _loc2_:ConsortiaGroupChatData = param1.data as ConsortiaGroupChatData;
         appendChatData(_loc2_);
         refreshView();
      }
      
      private function __itemClickHandler(param1:GroupChatEvent) : void
      {
         if(!param1.item || !param1.data)
         {
            return;
         }
         var _loc3_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.userId);
         if((param1.data as ThaneInfo).userId == _loc3_)
         {
            return;
         }
         PlayerManager.instance.sendRequestSimpleAndSnsInfo((param1.data as ThaneInfo).userId,3);
         var _loc2_:Point = param1.item.parent.localToGlobal(new Point(param1.item.x,param1.item.y));
         _menu = new PlayerMenu();
         _menu.setData(param1.data);
         _menu.x = _loc2_.x - _menu.width;
         _menu.y = _loc2_.y - _menu.height > 0 ? _loc2_.y - _menu.height : 0;
         LayerManager.Instance.addToLayer(_menu,7);
      }
      
      private function __snsInfoUpdateHandler(param1:SNSEvent) : void
      {
         var _loc2_:ThaneInfo = model.getConsortiaMemberList()[thane.userId];
         _loc2_.headId = thane.snsInfo.headId;
         refreshView();
      }
      
      private function __itemUpdateHandler(param1:GroupChatEvent) : void
      {
         refreshView();
      }
      
      private function __updataDutyInfo(param1:SLGSocketEvent) : void
      {
         refreshView();
      }
      
      private function __onConsortiaUpdata(param1:ConsortiaEvent) : void
      {
         setBroadCast();
         refreshView();
      }
      
      private function __onMemberListUpdata(param1:ConsortiaEvent) : void
      {
         refreshView();
      }
      
      private function playToBottom(param1:ConsortiaGroupChatData = null) : void
      {
         var _loc2_:Boolean = _output.height + _output.vScrollbar.scrollValue >= _output.vScrollbar.maximum;
         if(!_loc2_ && Boolean(_output.vScrollbar.getThumbVisible()))
         {
            _output.invalidateViewport();
            return;
         }
         _output.invalidateViewport(true);
      }
      
      private function appendChatData(param1:ConsortiaGroupChatData) : void
      {
         var _loc2_:ConsortiaGroupChatNotic = null;
         if(model.isSelfFollow(param1,_lastData) && _selfCount < 5)
         {
            _output.beginChanges();
            _loc2_ = _vBox.getChildAt(_vBox.numChildren - 1) as ConsortiaGroupChatNotic;
            _loc2_.appendText(param1);
            _vBox.refreshChildPos();
            playToBottom(param1);
            _output.commitChanges();
            _selfCount = _selfCount + 1;
         }
         else
         {
            while(_vBox.numChildren >= 20)
            {
               _loc2_ = _vBox.removeChildAt(0) as ConsortiaGroupChatNotic;
               _loc2_.dispose();
            }
            _loc2_ = ObjectPool.getObject(ConsortiaGroupChatNotic) as ConsortiaGroupChatNotic;
            _loc2_.data = param1;
            _output.beginChanges();
            _vBox.addChild(_loc2_);
            _vBox.refreshChildPos();
            playToBottom(param1);
            _output.commitChanges();
            _selfCount = 1;
         }
         _lastData = param1;
      }
      
      public function exitFrame() : void
      {
         model.disposeAllConsortiaChats();
         dispose();
      }
      
      private function __response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 0)
         {
            dispose();
         }
      }
      
      private function setBroadCast() : void
      {
         var _loc1_:Boolean = Boolean(FrameControllerManager.instance.consortiaController.getRightsByIndex(3));
         if(_loc1_ && Boolean(StringHelper.isNullOrEmpty(FrameControllerManager.instance.consortiaController.model.consortiaInfo.groupPlacard)))
         {
            _isBroChanged = false;
            _broadCastTip.visible = true;
            _broadCast.text = "";
         }
         else
         {
            _broadCastTip.visible = false;
            _isBroChanged = true;
            _broadCast.text = FrameControllerManager.instance.consortiaController.model.consortiaInfo.groupPlacard;
         }
         _broadcastFocusOutChange = _broadCast.text;
      }
      
      private function sortByValue(param1:ThaneInfo, param2:ThaneInfo) : int
      {
         if(param1.userId == thane.userId)
         {
            return -1;
         }
         if(param2.userId == thane.userId)
         {
            return 1;
         }
         return 0;
      }
      
      private function refreshView() : void
      {
         var _loc3_:ThaneInfo = null;
         var _loc2_:int = 0;
         _scrollValue = _menberList.vScrollbar ? _menberList.vScrollbar.scrollValue : 0;
         _menberListArray = model.getConsortiaMemberList().getList();
         _menberListArray.sort(sortByValue);
         _menberListArray.shift();
         _menberListArray.sortOn(["state","dutyId","consortiaTotalOffer","userId"],[0x10 | 2,16,0x10 | 2,16]);
         _menberListArray.unshift(model.getConsortiaMemberList()[player.userId]);
         var _loc1_:int = int(_menberListArray.length);
         _onLine = 0;
         _menberList.beginChanges();
         _menberList.vectorListModel.clear();
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = _menberListArray[_loc2_] as ThaneInfo;
            if(_loc3_ && _loc3_.isOnline)
            {
               _onLine = _onLine + 1;
            }
            _menberList.vectorListModel.append(_loc3_);
            _loc2_++;
         }
         _menberList.commitChanges();
         _menberList.invalidateViewport(true);
         _menberList.list.updateListView();
         if(_scrollValue > 0 && _menberList.vScrollbar)
         {
            _menberList.vScrollbar.scrollValue = _scrollValue;
         }
         _memberListTitle.htmlText = LanguageMgr.GetTranslation("consortiagroupchat.memberListTitle") + "[" + toArialBold(_onLine + " / " + _loc1_) + "]";
         setBroadCastState();
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            _consortiaBtn.enable = false;
            model.isOpenGroupChatTip = true;
         }
         else
         {
            _consortiaBtn.enable = true;
            model.isOpenGroupChatTip = false;
         }
         model.unreadGroupChat = false;
         if(model.shineSwitch)
         {
            FrameControllerManager.instance.consortiaGroupChatControler.consortiaBtnShining = true;
         }
      }
      
      private function toArialBold(param1:String) : String
      {
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
      
      private function setBroadCastState() : void
      {
         var _loc1_:Boolean = Boolean(FrameControllerManager.instance.consortiaController.getRightsByIndex(3));
         if(_loc1_)
         {
            _updateBtn.visible = true;
            _broadCast.selectable = _broadCast.mouseEnabled = true;
         }
         else
         {
            _updateBtn.visible = false;
            _broadCast.selectable = _broadCast.mouseEnabled = false;
         }
      }
      
      private function get model() : ConsortiaGroupChatModel
      {
         return FrameControllerManager.instance.consortiaGroupChatControler.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get player() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function show() : void
      {
         scaleX = scaleY = 1;
         LayerManager.Instance.addToLayer(this,3,true,false);
         if(_input)
         {
            _input.setFocus();
         }
         if(_historyView && _historyView.parent)
         {
            _historyView.show(this);
         }
         if(_lastData)
         {
            _lastData = null;
         }
         _selfCount = 1;
         initData();
         MainToolBar.instance.poptipButtonShine = false;
      }
      
      override public function dispose() : void
      {
         if(needDispose)
         {
            removeEvent();
            if(_vBox)
            {
               _vBox.disposeAllChildren();
               _vBox.removeAllChild();
               _vBox = null;
            }
            ObjectUtils.disposeObject(_outputBack);
            _outputBack = null;
            ObjectUtils.disposeObject(_inputBack);
            _inputBack = null;
            ObjectUtils.disposeObject(_broadcastBack);
            _broadcastBack = null;
            ObjectUtils.disposeObject(_buttonBack);
            _buttonBack = null;
            ObjectUtils.disposeObject(_titleImg);
            _titleImg = null;
            ObjectUtils.disposeObject(_minimizeBtn);
            _minimizeBtn = null;
            ObjectUtils.disposeObject(_miniCloseBtn);
            _miniCloseBtn = null;
            ObjectUtils.disposeObject(_shineSwitchBtn);
            _shineSwitchBtn = null;
            ObjectUtils.disposeObject(_consortiaBtn);
            _consortiaBtn = null;
            ObjectUtils.disposeObject(_historyBtn);
            _historyBtn = null;
            ObjectUtils.disposeObject(_closeBtn);
            _closeBtn = null;
            ObjectUtils.disposeObject(_sendBtn);
            _sendBtn = null;
            ObjectUtils.disposeObject(_updateBtn);
            _updateBtn = null;
            ObjectUtils.disposeObject(_notice);
            _notice = null;
            ObjectUtils.disposeObject(_broadCastTitle);
            _broadCastTitle = null;
            ObjectUtils.disposeObject(_broadCast);
            _broadCast = null;
            ObjectUtils.disposeObject(_memberListTitle);
            _memberListTitle = null;
            ObjectUtils.disposeObject(_input);
            _input = null;
            ObjectUtils.disposeObject(_menberList);
            _menberList = null;
            ObjectUtils.disposeObject(_output);
            _output = null;
            ObjectUtils.disposeObject(_warningIcon);
            _warningIcon = null;
            ObjectUtils.disposeObject(_warningText);
            _warningText = null;
            _menberListArray = null;
            _lastData = null;
            ObjectUtils.disposeObject(_historyView);
            _historyView = null;
            ObjectUtils.disposeAllChildren(_menberList);
            ObjectUtils.disposeObject(_menberList);
            _menberList = null;
            ObjectUtils.disposeAllChildren(this);
            MainToolBar.instance.poptipButtonVisible = false;
            model.isOpenGroupChatTip = true;
            model.unreadGroupChat = false;
            if(model.shineSwitch)
            {
               FrameControllerManager.instance.consortiaGroupChatControler.consortiaBtnShining = true;
            }
            model.disposeCurConsortiaChats();
            super.dispose();
         }
         else
         {
            MainToolBar.instance.poptipButtonVisible = true;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         ComponentFactory.Instance.preStylename = "";
         StageReferance.stage.focus = null;
      }
   }
}

