package monopoly.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.MonopolyEvent;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MonopolyManager;
   import managers.MonopolySocketOutManager;
   import mvc.module.monopoly.MonopolyModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FriendManager;
   import yishi.manager.IMEManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.utils.StringHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class MonopolyFriendAssistFrame extends Frame implements IManualSize
   {
      
      private var _rect:Rectangle;
      
      private var _scaleBg:ScaleBitmapImage;
      
      private var _contentBg:Scale9CornerImage;
      
      private var _contentView:MonopolyFriendAssistView;
      
      private var _consortiaTab:SelectedCheckButton;
      
      private var _friendTab:SelectedCheckButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _warFlagIcon:Image;
      
      private var _warFlagTxt:FilterFrameText;
      
      private var _warFlagCountTxt:FilterFrameText;
      
      private var _warFlagAddBtn:BaseButton;
      
      private var _searchBg:Image;
      
      private var _searchTxt:FilterFrameText;
      
      private var _searchTipTxt:FilterFrameText;
      
      private var _searchBtn:BaseButton;
      
      private var _currentSelectedIndex:int;
      
      private var _playerInfo:PlayerInfo;
      
      private var _model:MonopolyModel;
      
      private var _tempStr:String = "";
      
      public function MonopolyFriendAssistFrame()
      {
         super();
         _playerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         _model = MonopolyManager.instance.model;
         initView();
         addEvent();
         refresh();
      }
      
      public function get viewRectangle() : Rectangle
      {
         if(!_rect)
         {
            _rect = new Rectangle(0,0,459,425);
         }
         return _rect;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("monopoly.view.MonopolyFriendAssistFrame.TitleTxt");
         _scaleBg = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistFrame.ScaleBg");
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistFrame.ContentBg");
         _consortiaTab = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistFrame.UnionButton");
         _friendTab = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistFrame.FriendsButton");
         _warFlagIcon = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistFrame.WarFlagIcon");
         _warFlagTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistFrame.WarFlagTxt");
         _warFlagCountTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistFrame.WarFlagCountTxt");
         _warFlagAddBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistFrame.WarFlagAddBtn");
         _contentView = ComponentFactory.Instance.creatCustomObject("monopoly.MonopolyFriendAssistFrame.ContentView");
         _searchBg = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistFrame.SearchBg");
         _searchTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistFrame.SearchTxt");
         _searchTipTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistFrame.SearchTipTxt");
         _searchBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistFrame.SearchBtn");
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_consortiaTab);
         _group.addSelectItem(_friendTab);
         addToContent(_scaleBg);
         addToContent(_contentBg);
         addToContent(_consortiaTab);
         addToContent(_friendTab);
         addToContent(_warFlagIcon);
         addToContent(_warFlagTxt);
         addToContent(_warFlagCountTxt);
         addToContent(_warFlagAddBtn);
         addToContent(_contentView);
         addToContent(_searchBg);
         addToContent(_searchTxt);
         addToContent(_searchTipTxt);
         addToContent(_searchBtn);
         _consortiaTab.text = LanguageMgr.GetTranslation("public.consortia");
         _friendTab.text = LanguageMgr.GetTranslation("public.friend");
         _warFlagTxt.text = LanguageMgr.GetTranslation("monopoly.view.MonopolyFriendAssistFrame.WarFlagTxt");
         _searchTipTxt.text = LanguageMgr.GetTranslation("friends.view.RosePresentView.inputTip");
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_scaleBg);
         _scaleBg = null;
         ObjectUtils.disposeObject(_contentBg);
         _contentBg = null;
         ObjectUtils.disposeObject(_contentView);
         _contentView = null;
         ObjectUtils.disposeObject(_consortiaTab);
         _consortiaTab = null;
         ObjectUtils.disposeObject(_friendTab);
         _friendTab = null;
         ObjectUtils.disposeObject(_group);
         _group = null;
         ObjectUtils.disposeObject(_warFlagIcon);
         _warFlagIcon = null;
         ObjectUtils.disposeObject(_warFlagTxt);
         _warFlagTxt = null;
         ObjectUtils.disposeObject(_warFlagCountTxt);
         _warFlagCountTxt = null;
         ObjectUtils.disposeObject(_warFlagAddBtn);
         _warFlagAddBtn = null;
         ObjectUtils.disposeObject(_searchBg);
         _searchBg = null;
         ObjectUtils.disposeObject(_searchTxt);
         _searchTxt = null;
         ObjectUtils.disposeObject(_searchTipTxt);
         _searchTipTxt = null;
         ObjectUtils.disposeObject(_searchBtn);
         _searchBtn = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function initData() : void
      {
         if(_playerInfo.consortiaID > 0)
         {
            _consortiaTab.dispatchEvent(new MouseEvent("click"));
         }
         else
         {
            _friendTab.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _consortiaTab.addEventListener("click",__selectedTabChangeHandler);
         _friendTab.addEventListener("click",__selectedTabChangeHandler);
         _warFlagAddBtn.addEventListener("click",__warFlagAddBtnClickHandler);
         _searchBtn.addEventListener("click",__searchBtnClickHandler);
         _searchTxt.addEventListener("change",_textChange);
         _searchTxt.addEventListener("focusIn",__onFocusin);
         _searchTxt.addEventListener("focusOut",__onFocusout);
         _searchTxt.addEventListener("keyDown",__onKeydownHandler);
         _model.addEventListener("MONOPOLY_INFO_CHANGE",__infoChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _consortiaTab.removeEventListener("click",__selectedTabChangeHandler);
         _friendTab.removeEventListener("click",__selectedTabChangeHandler);
         _warFlagAddBtn.removeEventListener("click",__warFlagAddBtnClickHandler);
         _searchBtn.removeEventListener("click",__searchBtnClickHandler);
         _searchTxt.removeEventListener("change",_textChange);
         _searchTxt.removeEventListener("focusIn",__onFocusin);
         _searchTxt.removeEventListener("focusOut",__onFocusout);
         _searchTxt.removeEventListener("keyDown",__onKeydownHandler);
         _model.removeEventListener("MONOPOLY_INFO_CHANGE",__infoChangeHandler);
      }
      
      private function __infoChangeHandler(param1:MonopolyEvent) : void
      {
         refresh();
      }
      
      private function _textChange(param1:Event) : void
      {
         if(StringHelper.checkStringLength(_searchTxt.text) > 12)
         {
            _searchTxt.text = _tempStr;
         }
         _tempStr = _searchTxt.text;
      }
      
      private function __onFocusin(param1:FocusEvent) : void
      {
         IMEManager.enable();
         _searchTipTxt.visible = false;
      }
      
      private function __onFocusout(param1:FocusEvent) : void
      {
         if(StringHelper.isNullOrEmpty(_searchTxt.text))
         {
            _searchTipTxt.visible = true;
         }
      }
      
      private function __onKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __searchBtnClickHandler(null);
         }
         param1.stopPropagation();
      }
      
      private function __searchBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc5_:* = null;
         var _loc2_:String = _searchTxt.text;
         var _loc4_:Array = [];
         var _loc3_:Array = [];
         if(_consortiaTab == _group.getSelectedItem())
         {
            _loc4_ = ConsortiaManager.instance.model.consortiaMemberList.getList();
         }
         else if(_friendTab == _group.getSelectedItem())
         {
            _loc4_ = FriendManager.getInstance().friendListByArray;
         }
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.nickName.indexOf(_loc2_) != -1)
            {
               _loc3_.push(_loc5_);
            }
         }
         refreshList(_loc3_);
      }
      
      private function __warFlagAddBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:TodayNotAlertFrame = null;
         var _loc3_:String = null;
         var _loc2_:String = null;
         if(todayNeedAlertForMonopolyBuy)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("monopoly.TodayNotAlertFrame");
            _loc3_ = LanguageMgr.GetTranslation("monopoly.view.MonopolyFriendAssistFrame.BuyTips",_model.warFlagPrice,_model.lastBuyWarFlag);
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_.show(_loc3_,_loc2_,monopolyBuyAlertCallBack,null,"center",1,true,_model.warFlagPrice,true);
         }
         else
         {
            sendMonopolyBuy();
         }
      }
      
      private function monopolyBuyAlertCallBack(param1:Boolean, param2:Boolean = false) : void
      {
         if(param1)
         {
            SharedManager.instance.monopolyWarFlagBuyAlertDate = new Date();
            SharedManager.instance.saveMonopolyWarFlagBuyAlertDate();
         }
         SharedManager.instance.monopolyWarFlagBuyUseBind = param2;
         SharedManager.instance.saveMonopolyWarFlagBuyUseBind();
         sendMonopolyBuy();
      }
      
      private function sendMonopolyBuy() : void
      {
         var _loc2_:int = PlayerManager.instance.currentPlayerModel.playerInfo.point;
         var _loc1_:Boolean = SharedManager.instance.monopolyWarFlagBuyUseBind;
         if(_loc1_)
         {
            _loc2_ = PlayerManager.instance.currentPlayerModel.playerInfo.allPoint;
         }
         if(_model.warFlagPrice > _loc2_)
         {
            RechargeAlertMannager.show();
            return;
         }
         MonopolySocketOutManager.sendMonopolyBuy(2,_loc1_);
      }
      
      private function get todayNeedAlertForMonopolyBuy() : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         var _loc1_:Date = SharedManager.instance.monopolyWarFlagBuyAlertDate;
         if(_loc1_)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == _loc1_.fullYear && _loc2_.month == _loc1_.month && _loc2_.date == _loc1_.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      private function __selectedTabChangeHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         var _loc3_:SelectedCheckButton = param1.currentTarget as SelectedCheckButton;
         switch(_loc3_)
         {
            case _friendTab:
               refreshList(FriendManager.getInstance().friendListByArray);
               _currentSelectedIndex = _group.selectIndex;
               break;
            case _consortiaTab:
               if(_playerInfo.consortiaID == 0)
               {
                  _loc2_ = LanguageMgr.GetTranslation("room.view.invite.RoomInviteFrame.command01");
                  MessageTipManager.instance().show(_loc2_);
                  _group.selectIndex = _currentSelectedIndex;
                  return;
               }
               refreshList(ConsortiaManager.instance.model.consortiaMemberList.getList());
               _currentSelectedIndex = _group.selectIndex;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function refresh() : void
      {
         _warFlagCountTxt.text = _model.warFlag.toString();
         _warFlagAddBtn.x = _warFlagCountTxt.x + _warFlagCountTxt.textWidth + 5;
      }
      
      private function refreshList(param1:Array) : void
      {
         _contentView.refreshList(param1);
      }
      
      public function show() : void
      {
         initData();
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

