package friends.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.SNSEvent;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import im.view.IMStateComBox;
   import manager.LanguageMgr;
   import managers.FriendSocketOutManager;
   import managers.IMManager;
   import managers.SNSManager;
   import mvc.controler.FriendControler;
   import mvc.module.friends.IMModel;
   import mvc.module.sns.BaseSnsInfo;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.StringHelper;
   import yishi.view.community.HeadIconCell;
   
   public class FriendsFrame extends Frame implements IManualSize
   {
      
      private var _scaleFrameBg:ScaleBitmapImage;
      
      private var _bg:ScaleBitmapImage;
      
      private var _friendTab:SelectedCheckButton;
      
      private var _consortiaTab:SelectedCheckButton;
      
      private var _communityTab:SelectedCheckButton;
      
      private var _nickname:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _mood:FilterFrameText;
      
      private var _moodBg:ScaleBitmapImage;
      
      private var _moodRollBg:ScaleLeftRightImage;
      
      private var _moodRollEnabled:Boolean;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _groupChatButton:BaseButton;
      
      private var _addButton:BaseButton;
      
      private var _treeButton:TextButton;
      
      private var _headCell:HeadIconCell;
      
      private var _stateComBox:IMStateComBox;
      
      private var _friendsList:FridendsListView;
      
      private var _consortiaView:ConsortiaMenuView;
      
      private var _consortiaPanel:ScrollPanel;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _snsInfo:BaseSnsInfo;
      
      private var _tempStr:String = "";
      
      private var _tipButton:BaseButton;
      
      public function FriendsFrame()
      {
         super();
         FriendSocketOutManager.requestCrossFriendMsg(4);
         initView();
         addEvent();
         control.currentPanel = 1;
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("friends.view.FriendsFrame.title");
         _scaleFrameBg = ComponentFactory.Instance.creatComponentByStylename("friends.IMFriendsFrameScaleBg");
         _bg = ComponentFactory.Instance.creatComponentByStylename("friends.DescribeScrollPanelBack");
         _stateComBox = ComponentFactory.Instance.creatComponentByStylename("friends.IMStateComBox");
         _stateComBox.setData();
         _nickname = ComponentFactory.Instance.creatComponentByStylename("friends.heroNicknameTextStyle");
         _level = ComponentFactory.Instance.creatComponentByStylename("friends.heroLevelTextStyle");
         _moodBg = ComponentFactory.Instance.creatComponentByStylename("friends.HeroMoodBg");
         _moodRollBg = ComponentFactory.Instance.creatComponentByStylename("friends.HeroMoodRollBg");
         _mood = ComponentFactory.Instance.creatComponentByStylename("friends.heroMoodTextStyle");
         _friendTab = ComponentFactory.Instance.creatComponentByStylename("friends.FriendsButton");
         _consortiaTab = ComponentFactory.Instance.creatComponentByStylename("friends.UnionButton");
         _communityTab = ComponentFactory.Instance.creatComponentByStylename("friends.CommunityButton");
         _groupChatButton = ComponentFactory.Instance.creatComponentByStylename("friends.groupChatBtn");
         _addButton = ComponentFactory.Instance.creatComponentByStylename("friends.addfriendBtn");
         _treeButton = ComponentFactory.Instance.creatComponentByStylename("friends.treeBtn");
         _friendsList = ComponentFactory.Instance.creatCustomObject("friends.FridendsListView");
         _consortiaView = ComponentFactory.Instance.creatCustomObject("friends.ConsortiaMenuView");
         _consortiaPanel = ComponentFactory.Instance.creatComponentByStylename("friends.ConsortiaDescribeScrollPanel");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("friends.VocationIcon");
         _vocationIcon.visible = false;
         _mood.mouseEnabled = true;
         _moodBg.visible = false;
         _moodRollBg.mouseEnabled = false;
         _moodRollBg.visible = false;
         _moodRollEnabled = true;
         addToContent(_scaleFrameBg);
         addToContent(_bg);
         addToContent(_friendTab);
         addToContent(_consortiaTab);
         addToContent(_nickname);
         addToContent(_level);
         addToContent(_moodBg);
         addToContent(_moodRollBg);
         addToContent(_mood);
         addToContent(_groupChatButton);
         groupChatBtnState();
         addToContent(_addButton);
         addToContent(_friendsList);
         addToContent(_consortiaPanel);
         addToContent(_stateComBox);
         _communityTab.text = LanguageMgr.GetTranslation("friends.view.FriendsFrame.title");
         _nickname.text = thane.nickName;
         if(_nickname.text.substring(_nickname.text.length - 3) == "..." && thane.nickName.substring(thane.nickName.length - 3) != "...")
         {
            _tipButton = ComponentFactory.Instance.creatComponentByStylename("core.CloseBtn");
            _tipButton.x = _nickname.x;
            _tipButton.y = _nickname.y;
            _tipButton.width = _nickname.width;
            _tipButton.height = _nickname.height;
            _tipButton.alpha = 0;
            _tipButton.tipData = thane.nickName;
            addToContent(_tipButton);
            _tipButton.tipGapH = 0;
            _tipButton.tipGapV = 0;
         }
         _mood.text = thane.snsInfo.sign != "" ? thane.snsInfo.sign : LanguageMgr.GetTranslation("friends.view.FriendsFrame.inputSignTip");
         simplifyThaneSign();
         _level.text = LanguageMgr.GetTranslation("public.level2",thane.grades);
         _consortiaTab.enable = PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID <= 0 ? false : true;
         _communityTab.enable = false;
         _buttonGroup = new SelectedButtonGroup();
         _buttonGroup.addSelectItem(_friendTab);
         _buttonGroup.addSelectItem(_consortiaTab);
         _buttonGroup.addSelectItem(_communityTab);
         _buttonGroup.selectIndex = 0;
         _consortiaPanel.setView(_consortiaView);
         _consortiaPanel.visible = false;
         var _loc1_:SearchFriendView = new SearchFriendView();
         addToContent(_loc1_);
         _headCell = ComponentFactory.Instance.creatCustomObject("friends.HeadIconCell");
         _headCell.headId = thane.snsInfo.headId;
         addToContent(_headCell);
         addToContent(_vocationIcon);
         refreshVocation();
      }
      
      private function refreshVocation() : void
      {
         if(thane && thane.vocationGrades > 0)
         {
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(thane.templateInfo.Job,thane.vocationStep,thane.vocationLevel);
            _vocationIcon.setFrame(thane.vocationLevel);
            _vocationIcon.visible = true;
            _level.x = _vocationIcon.x + _vocationIcon.width;
         }
         else
         {
            _vocationIcon.visible = false;
            _level.x = _vocationIcon.x;
         }
      }
      
      private function groupChatBtnState() : void
      {
         if(player.consortiaID > 0)
         {
            _groupChatButton.enable = true;
         }
         else
         {
            _groupChatButton.enable = false;
         }
      }
      
      private function get player() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get imModel() : IMModel
      {
         return IMManager.instance.model;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _groupChatButton.addEventListener("click",__groupChatHandler);
         _addButton.addEventListener("click",__addHandler);
         _friendTab.addEventListener("click",__friendTabHandler);
         _consortiaTab.addEventListener("click",__consortiaTabHandler);
         _consortiaView.addEventListener("SHOW_MEMBER_LIST",__updataConsortiaView);
         _headCell.addEventListener("click",__onPlayerIconClick);
         thane.addEventListener("NICKNAME_UPDATE",__nickNameHandler);
         SNSManager.instance.addEventListener("SNSINFO_UPDATE",__snsInfoUpdateHandler);
         player.addEventListener("CONSORTIA_CHANGE",__onConsortiaChangeHandler);
         DoubleClickManager.Instance.enableDoubleClick(_mood);
         _mood.addEventListener("interactive_click",__onMoodClickHandler);
         _mood.addEventListener("change",__moodInputHandler);
         _mood.addEventListener("rollOver",__onRollOverHandler);
         _mood.addEventListener("rollOut",__onRollOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_groupChatButton)
         {
            _groupChatButton.removeEventListener("click",__groupChatHandler);
         }
         if(_addButton)
         {
            _addButton.removeEventListener("click",__addHandler);
         }
         if(_friendTab)
         {
            _friendTab.removeEventListener("click",__friendTabHandler);
         }
         if(_consortiaTab)
         {
            _consortiaTab.removeEventListener("click",__consortiaTabHandler);
         }
         if(_consortiaView)
         {
            _consortiaView.removeEventListener("SHOW_MEMBER_LIST",__updataConsortiaView);
         }
         if(_headCell)
         {
            _headCell.removeEventListener("click",__onPlayerIconClick);
         }
         thane.removeEventListener("NICKNAME_UPDATE",__nickNameHandler);
         SNSManager.instance.removeEventListener("SNSINFO_UPDATE",__snsInfoUpdateHandler);
         player.removeEventListener("CONSORTIA_CHANGE",__onConsortiaChangeHandler);
         DoubleClickManager.Instance.disableDoubleClick(_mood);
         _mood.removeEventListener("interactive_click",__onMoodClickHandler);
         _mood.removeEventListener("focusOut",__moodFocusOutHandler);
         _mood.removeEventListener("keyDown",__onMoodKeyDown);
         _mood.removeEventListener("change",__moodInputHandler);
         _mood.removeEventListener("rollOver",__onRollOverHandler);
         _mood.removeEventListener("rollOut",__onRollOutHandler);
      }
      
      private function __onRollOverHandler(param1:MouseEvent) : void
      {
         if(_moodRollEnabled)
         {
            _moodRollBg.visible = true;
         }
      }
      
      private function __onRollOutHandler(param1:MouseEvent) : void
      {
         if(_moodRollEnabled)
         {
            _moodRollBg.visible = false;
         }
      }
      
      private function __moodInputHandler(param1:Event) : void
      {
         if(StringHelper.checkStringLength(_mood.text) > 100)
         {
            _mood.text = _tempStr;
         }
         _tempStr = _mood.text;
      }
      
      private function __onMoodClickHandler(param1:InteractiveEvent) : void
      {
         if(!_moodRollEnabled)
         {
            return;
         }
         _moodRollBg.visible = false;
         _moodRollEnabled = false;
         _mood.mouseEnabled = false;
         _mood.type = "input";
         _mood.text = thane.snsInfo.sign != "" ? thane.snsInfo.sign : LanguageMgr.GetTranslation("friends.view.FriendsFrame.inputSignTip");
         _mood.setSelection(0,_mood.length);
         _mood.setFocus();
         _moodBg.visible = true;
         _mood.addEventListener("focusOut",__moodFocusOutHandler);
         _mood.addEventListener("keyDown",__onMoodKeyDown);
      }
      
      private function __moodFocusOutHandler(param1:FocusEvent) : void
      {
         _moodRollEnabled = true;
         _mood.removeEventListener("focusOut",__moodFocusOutHandler);
         _mood.removeEventListener("keyDown",__onMoodKeyDown);
         _mood.mouseEnabled = true;
         _mood.type = "dynamic";
         _moodBg.visible = false;
         if(_mood.text != thane.snsInfo.sign && _mood.text != LanguageMgr.GetTranslation("friends.view.FriendsFrame.inputSignTip"))
         {
            if(!_snsInfo)
            {
               _snsInfo = new BaseSnsInfo();
            }
            _snsInfo.sign = _mood.text;
            SNSManager.instance.sendAutoSaveInfo(_snsInfo);
         }
         else
         {
            _mood.text = thane.snsInfo.sign != "" ? thane.snsInfo.sign : LanguageMgr.GetTranslation("friends.view.FriendsFrame.inputSignTip");
         }
         simplifyThaneSign();
      }
      
      private function __onMoodKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __moodFocusOutHandler(null);
            StageReferance.stage.focus = this;
         }
      }
      
      private function __onConsortiaChangeHandler(param1:PlayerEvent) : void
      {
         groupChatBtnState();
      }
      
      private function __nickNameHandler(param1:PlayerEvent) : void
      {
         _nickname.text = thane.nickName;
      }
      
      private function __snsInfoUpdateHandler(param1:SNSEvent) : void
      {
         _mood.text = thane.snsInfo.sign != "" ? thane.snsInfo.sign : LanguageMgr.GetTranslation("friends.view.FriendsFrame.inputSignTip");
         simplifyThaneSign();
         if(_headCell.headId != thane.snsInfo.headId)
         {
            _headCell.headId = thane.snsInfo.headId;
         }
      }
      
      private function simplifyThaneSign() : void
      {
         with(_mood)
         {
            if(textWidth > width)
            {
               text = text.substring(0,getCharIndexAtPoint(width - 22,5)) + "...";
            }
         }
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
      
      private function get control() : FriendControler
      {
         return FrameControllerManager.instance.friendControler;
      }
      
      private function __groupChatHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         MainToolBar.instance.poptipButtonShine = false;
         MainToolBar.instance.poptipButtonVisible = false;
         FrameControllerManager.instance.openControllerByInfo("consortiagroupchat");
      }
      
      private function __addHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         param1.stopPropagation();
         control.openFindFriendFrame();
      }
      
      private function __onPlayerIconClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.armyController.openChangeHeadFrame();
      }
      
      protected function __friendTabHandler(param1:MouseEvent) : void
      {
         control.currentPanel = 1;
         SoundManager.instance.play("022");
         _friendsList.visible = true;
         _consortiaPanel.visible = false;
      }
      
      private function __consortiaTabHandler(param1:MouseEvent) : void
      {
         control.currentPanel = 2;
         SoundManager.instance.play("022");
         _friendsList.visible = false;
         _consortiaPanel.visible = true;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToSpecial(this,3,true,true,1,-100,0,0,true);
      }
      
      override public function dispose() : void
      {
         control.closeFindFriendFrame();
         control.currentPanel = 0;
         removeEvent();
         uninit();
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         IMManager.instance.friendBtnShining = true;
      }
      
      private function uninit() : void
      {
         if(_scaleFrameBg)
         {
            ObjectUtils.disposeObject(_scaleFrameBg);
         }
         _scaleFrameBg = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_tipButton)
         {
            ObjectUtils.disposeObject(_tipButton);
         }
         _tipButton = null;
         if(_friendTab)
         {
            ObjectUtils.disposeObject(_friendTab);
         }
         _friendTab = null;
         if(_consortiaTab)
         {
            ObjectUtils.disposeObject(_consortiaTab);
         }
         _consortiaTab = null;
         if(_communityTab)
         {
            ObjectUtils.disposeObject(_communityTab);
         }
         _communityTab = null;
         if(_nickname)
         {
            ObjectUtils.disposeObject(_nickname);
         }
         _nickname = null;
         if(_mood)
         {
            _mood.dispose();
         }
         _mood = null;
         if(_moodBg)
         {
            _moodBg.dispose();
         }
         _moodBg = null;
         if(_moodRollBg)
         {
            _moodRollBg.dispose();
         }
         _moodRollBg = null;
         if(_level)
         {
            ObjectUtils.disposeObject(_level);
         }
         _level = null;
         if(_groupChatButton)
         {
            ObjectUtils.disposeObject(_groupChatButton);
         }
         _groupChatButton = null;
         if(_addButton)
         {
            ObjectUtils.disposeObject(_addButton);
         }
         _addButton = null;
         if(_friendsList)
         {
            ObjectUtils.disposeObject(_friendsList);
         }
         _friendsList = null;
         if(_headCell)
         {
            ObjectUtils.disposeObject(_headCell);
         }
         _headCell = null;
         if(_stateComBox)
         {
            _stateComBox.dispose();
         }
         _stateComBox = null;
         if(_treeButton)
         {
            _treeButton.dispose();
         }
         _treeButton = null;
         if(_buttonGroup)
         {
            _buttonGroup.dispose();
         }
         _buttonGroup = null;
         if(_consortiaPanel)
         {
            _consortiaPanel.dispose();
         }
         _consortiaPanel = null;
         if(_consortiaView)
         {
            _consortiaView.dispose();
         }
         _consortiaView = null;
         if(_vocationIcon)
         {
            _vocationIcon.dispose();
         }
         _vocationIcon = null;
         _snsInfo = null;
         _tempStr = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      protected function __updataConsortiaView(param1:Event) : void
      {
         _consortiaPanel.invalidateViewport();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,302,537);
      }
   }
}

