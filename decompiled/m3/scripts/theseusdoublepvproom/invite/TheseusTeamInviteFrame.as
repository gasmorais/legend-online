package theseusdoublepvproom.invite
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.room.RoomPlayerListMsg;
   import com.road.yishi.proto.room.RoomPlayerMsg;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.pveroomlist.ThsesusRoomListModel;
   import yishi.comm.PackageIn;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ApexManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusTeamInviteFrame extends Frame
   {
      
      private var _friendTab:SelectedCheckButton;
      
      private var _consortiaTab:SelectedCheckButton;
      
      private var _hallTab:SelectedCheckButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _listBG:ScaleBitmapImage;
      
      private var _listPanel:ListPanel;
      
      private var _refreshBtn:TextButton;
      
      private var _inviteBtn:TextButton;
      
      private var _refleshCount:int = 0;
      
      private var _currentSelectedIndex:int;
      
      private var _searchView:TheseusInviteSearchView;
      
      private var _cList:Array;
      
      private var _quickInviteFlag:Boolean;
      
      private var _type:int;
      
      public function TheseusTeamInviteFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _group = new SelectedButtonGroup();
         _friendTab = ComponentFactory.Instance.creatComponentByStylename("roomInvite.FriendsButton");
         _consortiaTab = ComponentFactory.Instance.creatComponentByStylename("roomInvite.UnionButton");
         _hallTab = ComponentFactory.Instance.creatComponentByStylename("roomInvite.hallButton");
         _listBG = ComponentFactory.Instance.creatComponentByStylename("roomInvite.ListBG");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("roomInvite.updateBtn");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("roomInvite.QuickInviteBtn");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("theseusdoublepvp.team.invite.ListPanel");
         addToContent(_listBG);
         addToContent(_consortiaTab);
         _consortiaTab.text = LanguageMgr.GetTranslation("public.consortia");
         addToContent(_friendTab);
         _friendTab.text = LanguageMgr.GetTranslation("public.friend");
         addToContent(_hallTab);
         _hallTab.text = LanguageMgr.GetTranslation("room.view.invite.RoomInviteFrame.hallTabText");
         addToContent(_refreshBtn);
         _refreshBtn.text = LanguageMgr.GetTranslation("room.view.invite.RoomInviteFrame.refreshBtn.text");
         addToContent(_inviteBtn);
         _inviteBtn.text = LanguageMgr.GetTranslation("room.view.invite.RoomInviteFrame.inviteBtn.text");
         addToContent(_listPanel);
         _listPanel.list.updateListView();
         _group.addSelectItem(_consortiaTab);
         _group.addSelectItem(_friendTab);
         _group.addSelectItem(_hallTab);
         titleText = LanguageMgr.GetTranslation("room.view.invite.RoomInviteFrame.title");
         _searchView = new TheseusInviteSearchView();
         _searchView.x = -10;
         addToContent(_searchView);
      }
      
      private function initData() : void
      {
         if(playerInfo.consortiaID > 0)
         {
            _consortiaTab.dispatchEvent(new MouseEvent("click"));
         }
         else
         {
            _friendTab.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__response);
         _consortiaTab.addEventListener("click",__selectedTabChangeHandler);
         _friendTab.addEventListener("click",__selectedTabChangeHandler);
         _hallTab.addEventListener("click",__selectedTabChangeHandler);
         _refreshBtn.addEventListener("click",__refreshClick);
         _inviteBtn.addEventListener("click",__quickInviteHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4161,__getHallListHandler);
         NotificationManager.instance.addEventListener("INVITE_SUCCESS",__inviteSuccessHandler);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__response);
         _consortiaTab.removeEventListener("click",__selectedTabChangeHandler);
         _friendTab.removeEventListener("click",__selectedTabChangeHandler);
         _hallTab.removeEventListener("click",__selectedTabChangeHandler);
         _refreshBtn.removeEventListener("click",__refreshClick);
         _inviteBtn.removeEventListener("click",__quickInviteHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4161,__getHallListHandler);
         NotificationManager.instance.removeEventListener("INVITE_SUCCESS",__inviteSuccessHandler);
      }
      
      private function __getHallListHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc8_:ThaneInfo = null;
         var _loc5_:RoomPlayerMsg = null;
         var _loc2_:Array = [];
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc3_:RoomPlayerListMsg = new RoomPlayerListMsg();
         _loc3_ = _loc7_.readBody(_loc3_) as RoomPlayerListMsg;
         var _loc6_:int = int(_loc3_.state);
         _loc4_ = 0;
         while(_loc4_ < _loc3_.roomPlayer.length)
         {
            _loc8_ = new ThaneInfo();
            _loc5_ = _loc3_.roomPlayer[_loc4_] as RoomPlayerMsg;
            if(_loc5_.hasPlayerId)
            {
               _loc8_.userId = _loc5_.playerId;
            }
            if(_loc5_.hasTemplateId)
            {
               _loc8_.templateId = _loc5_.templateId;
            }
            if(_loc5_.hasGrades)
            {
               _loc8_.grades = _loc5_.grades;
            }
            if(_loc5_.hasNickName)
            {
               _loc8_.nickName = _loc5_.nickName;
            }
            if(_loc5_.hasSex)
            {
               _loc8_.sexs = _loc5_.sex;
            }
            if(_loc5_.hasConsortiaId)
            {
               _loc8_.consortiaID = _loc5_.consortiaId;
            }
            if(_loc5_.hasConsortiaName)
            {
               _loc8_.consortiaName = _loc5_.consortiaName;
            }
            if(_loc5_.hasFightingCapacity)
            {
               _loc8_.fightingCapacity = _loc5_.fightingCapacity;
            }
            if(_loc5_.hasPlayerState)
            {
               _loc8_.state = _loc5_.playerState;
            }
            if(_loc5_.hasChangeShapeId)
            {
               _loc8_.changeShapeId = _loc5_.changeShapeId;
            }
            if(_loc5_.hasIsVip)
            {
               _loc8_.IsVipAndNoExpirt = _loc5_.isVip;
            }
            if(_loc5_.hasVipType)
            {
               _loc8_.vipType = _loc5_.vipType;
            }
            if(_loc5_.hasTransferGrade)
            {
               _loc8_.vocationGrades = _loc5_.transferGrade;
            }
            if(_loc5_.hasChangeBranch)
            {
               _loc8_.vocationIndex = _loc5_.changeBranch;
            }
            if(_loc5_.hasIsBackPlayer)
            {
               _loc8_.isBackPlayer = _loc5_.isBackPlayer;
            }
            _loc2_.push(_loc8_);
            _loc4_++;
         }
         refreshList(_loc2_);
      }
      
      private function __selectedTabChangeHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         var _loc3_:SelectedCheckButton = param1.currentTarget as SelectedCheckButton;
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
               break;
            case _hallTab:
               SocketSendManager.instance.sendRefreshInviteHall();
               _currentSelectedIndex = _group.selectIndex;
         }
      }
      
      private function __refreshClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         switch(_currentSelectedIndex)
         {
            case 0:
               refreshList(ConsortiaManager.instance.model.consortiaMemberList.getList());
               break;
            case 1:
               refreshList(FriendManager.getInstance().friendList.getList());
               break;
            case 2:
               SocketSendManager.instance.sendRefreshInviteHall();
         }
      }
      
      private function __quickInviteHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         ApexManager.instance.model.isQuickInvite = true;
         FrameControllerManager.instance.openControllerByInfo("theseusroomlist",ThsesusRoomListModel.OPEN_QUICKINVITEFRAME);
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
         _cList = [];
         _clearItems();
         _listPanel.beginChanges();
         param1.sort(sortOnLevel);
         for each(var _loc3_:ThaneInfo in param1)
         {
            if(param2)
            {
               _loc3_.invited = false;
            }
            if(_loc3_.relation != 2 && Boolean(_loc3_.isOnline) && _loc3_.userId != thane.userId)
            {
               _listPanel.vectorListModel.append(_loc3_);
               _cList.push(_loc3_);
            }
         }
         _listPanel.commitChanges();
         _listPanel.list.updateListView();
      }
      
      private function _clearItems() : void
      {
         _listPanel.vectorListModel.clear();
         _listPanel.list.updateListView();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function show(param1:int = 0) : void
      {
         _type = param1;
         initData();
         LayerManager.Instance.addToLayer(this,3,true,true,1);
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
         _group = null;
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
         if(_hallTab)
         {
            ObjectUtils.disposeObject(_hallTab);
         }
         _hallTab = null;
         if(_listBG)
         {
            ObjectUtils.disposeObject(_listBG);
         }
         _listBG = null;
         if(_listPanel)
         {
            ObjectUtils.disposeObject(_listPanel);
         }
         _listPanel = null;
         if(_refreshBtn)
         {
            ObjectUtils.disposeObject(_refreshBtn);
         }
         _refreshBtn = null;
         if(_inviteBtn)
         {
            ObjectUtils.disposeObject(_inviteBtn);
         }
         _inviteBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

