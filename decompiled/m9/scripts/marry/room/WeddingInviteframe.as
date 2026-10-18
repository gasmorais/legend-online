package marry.room
{
   import chat.ChatSocketOutManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarrySender;
   import mvc.module.pveroomlist.PVERoomListModel;
   import mvc.module.shop.ShopGoodsInfo;
   import room.view.invite.InviteItem;
   import room.view.invite.InviteSearchView;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.MsgMan;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.tips.MessageTipManager;
   
   public class WeddingInviteframe extends Frame implements IManualSize
   {
      
      private var _friendTab:SelectedCheckButton;
      
      private var _consortiaTab:SelectedCheckButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _bg:ScaleBitmapImage;
      
      private var _panel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _titleBg:ScaleLeftRightImage;
      
      private var _oneKeyBtn:TextButton;
      
      private var _inviteBtn:TextButton;
      
      private var _refleshCount:int = 0;
      
      private var _currentSelectedIndex:int;
      
      private var _searchView:InviteSearchView;
      
      private var _cList:Array;
      
      private var _quickInviteFlag:Boolean;
      
      private var _title2:FilterFrameText;
      
      private var _type:int;
      
      public function WeddingInviteframe()
      {
         super();
         initView();
         initEvents();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,315,415);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _group = new SelectedButtonGroup();
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("WeddingInviteframe.titleBg");
         _title2 = ComponentFactory.Instance.creatComponentByStylename("WeddingInviteframe.title2");
         _friendTab = ComponentFactory.Instance.creatComponentByStylename("WeddingInviteframe.FriendsButton");
         _consortiaTab = ComponentFactory.Instance.creatComponentByStylename("WeddingInviteframe.UnionButton");
         _bg = ComponentFactory.Instance.creatComponentByStylename("WeddingInviteframe.BG");
         _oneKeyBtn = ComponentFactory.Instance.creatComponentByStylename("WeddingInviteframe.OneKeyInviteBtn");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("WeddingInviteframe.QuickInviteBtn");
         _panel = ComponentFactory.Instance.creatComponentByStylename("WeddingInviteframe.panel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("WeddingInviteframe.vBox");
         addToContent(_bg);
         addToContent(_titleBg);
         addToContent(_consortiaTab);
         _consortiaTab.text = LanguageMgr.GetTranslation("public.consortia");
         addToContent(_friendTab);
         _friendTab.text = LanguageMgr.GetTranslation("public.friend");
         addToContent(_oneKeyBtn);
         _oneKeyBtn.text = LanguageMgr.GetTranslation("marry.room.WeddingInviteframe.onekeyInvite");
         addToContent(_inviteBtn);
         _inviteBtn.text = LanguageMgr.GetTranslation("room.view.invite.RoomInviteFrame.inviteBtn.text");
         addToContent(_panel);
         addToContent(_title2);
         _panel.setView(_vBox);
         _group.addSelectItem(_friendTab);
         _group.addSelectItem(_consortiaTab);
         titleText = LanguageMgr.GetTranslation("room.view.invite.RoomInviteFrame.title");
         _title2.text = LanguageMgr.GetTranslation("marry.room.WeddingInviteframe.Title2");
         _searchView = new InviteSearchView();
         _searchView.x = 10;
         _searchView.y = 30;
         addToContent(_searchView);
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__response);
         _group.addEventListener("change",__selectedTabChangeHandler);
         _oneKeyBtn.addEventListener("click",__onKeyHandler);
         _inviteBtn.addEventListener("click",__quickInviteHandler);
         NotificationManager.instance.addEventListener("INVITE_SUCCESS",__inviteSuccessHandler);
         thane.addEventListener("SMALL_BUGLE_FREE_COUNT",__smallBugleFreeCountHandler);
         _group.selectIndex = 0;
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__response);
         _consortiaTab.removeEventListener("click",__selectedTabChangeHandler);
         _group.removeEventListener("change",__selectedTabChangeHandler);
         _inviteBtn.removeEventListener("click",__quickInviteHandler);
         NotificationManager.instance.removeEventListener("INVITE_SUCCESS",__inviteSuccessHandler);
         thane.removeEventListener("SMALL_BUGLE_FREE_COUNT",__smallBugleFreeCountHandler);
      }
      
      private function __selectedTabChangeHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         var _loc3_:SelectedCheckButton = _group.getSelectedItem() as SelectedCheckButton;
         switch(_loc3_)
         {
            case _friendTab:
               refreshList(FriendManager.getInstance().friendList.getList());
               _currentSelectedIndex = _group.selectIndex;
               break;
            case _consortiaTab:
               if(playerInfo.consortiaID == 0)
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
      
      private function __onKeyHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_cList == null || _cList.length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("marry.room.WeddingInviteframe.nullList"));
         }
         var _loc2_:Array = [];
         for each(var _loc3_:ThaneInfo in _cList)
         {
            _loc2_.push(_loc3_.userId);
         }
         MarrySender.oneKeyInvite(_loc2_);
         MsgMan.notifyObserver("MarryEventType.ONE_KEY_INVITE");
      }
      
      private function __quickInviteHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         SoundManager.instance.play("022");
         var _loc2_:int = int(GoodsManager.instance.getGoodsNumByTempId(208003));
         if(_loc2_ == 0)
         {
            if(thane.smallBugleFreeCount <= 0)
            {
               _loc3_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command06");
               MessageTipManager.instance().show(_loc3_);
               CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
               return;
            }
            _quickInviteFlag = true;
            ChatSocketOutManager.sendSmallBugleFreeCount();
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("pveroomlist",PVERoomListModel.OPEN_QUICKINVITEFRAME,1);
      }
      
      private function __smallBugleFreeCountHandler(param1:PlayerEvent) : void
      {
         var _loc3_:String = null;
         if(!_quickInviteFlag)
         {
            return;
         }
         _quickInviteFlag = false;
         var _loc2_:int = int(GoodsManager.instance.getGoodsNumByTempId(208003));
         if(_loc2_ == 0)
         {
            if(thane.smallBugleFreeCount <= 0)
            {
               _loc3_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command06");
               MessageTipManager.instance().show(_loc3_);
               CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
               return;
            }
         }
         FrameControllerManager.instance.openControllerByInfo("pveroomlist",PVERoomListModel.OPEN_QUICKINVITEFRAME,1);
      }
      
      private function quickUIcallback() : void
      {
         var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(208003);
         _loc1_.data(_loc2_);
         _loc1_.show();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function sortOnLevel(param1:ThaneInfo, param2:ThaneInfo) : int
      {
         var _loc3_:int = int(param1.grades);
         var _loc4_:int = int(param2.grades);
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         return 0;
      }
      
      private function __inviteSuccessHandler(param1:NotificationEvent) : void
      {
         refreshListView(_cList,false);
      }
      
      private function refreshList(param1:Array) : void
      {
         refreshListView(param1);
         _searchView.setCurrentList(_cList);
      }
      
      private function refreshListView(param1:Array, param2:Boolean = true) : void
      {
         var _loc3_:InviteItem = null;
         _cList = [];
         _vBox.disposeAllChildren();
         param1.sort(sortOnLevel);
         for each(var _loc4_:ThaneInfo in param1)
         {
            if(param2)
            {
               _loc4_.invited = false;
            }
            if(_loc4_.relation != 2 && Boolean(_loc4_.isOnline) && _loc4_.userId != thane.userId && _loc4_.userId != marryModel.selfMarryInfo.userId)
            {
               _loc3_ = new InviteItem();
               _loc3_.setCellValue(_loc4_);
               _loc3_.setWeddingInvite();
               _vBox.addChild(_loc3_);
               _cList.push(_loc4_);
            }
         }
         _vBox.refreshChildPos();
         _panel.invalidateViewport();
      }
      
      private function get marryModel() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function show(param1:int = 0) : void
      {
         _type = param1;
         if(_type == 1)
         {
            _inviteBtn.visible = false;
            _oneKeyBtn.x = 77;
         }
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function __response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 0)
         {
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvents();
         _cList = null;
         if(_friendTab)
         {
            _friendTab.dispose();
         }
         _friendTab = null;
         if(_consortiaTab)
         {
            _consortiaTab.dispose();
         }
         _consortiaTab = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_panel)
         {
            _panel.dispose();
         }
         _panel = null;
         if(_oneKeyBtn)
         {
            _oneKeyBtn.dispose();
         }
         _oneKeyBtn = null;
         if(_inviteBtn)
         {
            _inviteBtn.dispose();
         }
         _inviteBtn = null;
         if(_vBox)
         {
            _vBox.dispose();
         }
         _vBox = null;
         if(_titleBg)
         {
            _titleBg.dispose();
         }
         _titleBg = null;
         if(_searchView)
         {
            _searchView.dispose();
         }
         _searchView = null;
         if(_group)
         {
            _group.dispose();
         }
         _group = null;
         if(_title2)
         {
            _title2.dispose();
         }
         _title2 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

