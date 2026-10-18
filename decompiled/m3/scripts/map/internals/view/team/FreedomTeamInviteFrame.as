package map.internals.view.team
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
   import events.FreedomTeamEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import map.internals.view.team.invite.FreedomTeamInviteSearchView;
   import mvc.module.team.FreedomTeamModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.tips.MessageTipManager;
   
   public class FreedomTeamInviteFrame extends Frame
   {
      
      private var _friendTab:SelectedCheckButton;
      
      private var _consortiaTab:SelectedCheckButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _listBG:ScaleBitmapImage;
      
      private var _listPanel:ListPanel;
      
      private var _refreshBtn:TextButton;
      
      private var _refleshCount:int = 0;
      
      private var _currentSelectedIndex:int;
      
      private var _searchView:FreedomTeamInviteSearchView;
      
      private var _cList:Array;
      
      private var _type:int;
      
      public function FreedomTeamInviteFrame()
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
         titleText = LanguageMgr.GetTranslation("room.view.invite.RoomInviteFrame.title");
         _friendTab = ComponentFactory.Instance.creatComponentByStylename("roomInvite.FriendsButton");
         _consortiaTab = ComponentFactory.Instance.creatComponentByStylename("roomInvite.UnionButton");
         _listBG = ComponentFactory.Instance.creatComponentByStylename("roomInvite.ListBG");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("team.FreedomTeamInviteFrame.updateBtn");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("team.FreedomTeamInviteFrame.ListPanel");
         _consortiaTab.text = LanguageMgr.GetTranslation("public.consortia");
         _friendTab.text = LanguageMgr.GetTranslation("public.friend");
         _refreshBtn.text = LanguageMgr.GetTranslation("room.view.invite.RoomInviteFrame.refreshBtn.text");
         addToContent(_listBG);
         addToContent(_consortiaTab);
         addToContent(_friendTab);
         addToContent(_refreshBtn);
         addToContent(_listPanel);
         _listPanel.list.updateListView();
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_consortiaTab);
         _group.addSelectItem(_friendTab);
         _searchView = new FreedomTeamInviteSearchView();
         _searchView.x = -10;
         addToContent(_searchView);
      }
      
      private function uninitView() : void
      {
         _group = null;
         ObjectUtils.disposeObject(_friendTab);
         _friendTab = null;
         ObjectUtils.disposeObject(_consortiaTab);
         _consortiaTab = null;
         ObjectUtils.disposeObject(_listBG);
         _listBG = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeAllChildren(this);
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
         _refreshBtn.addEventListener("click",__refreshClick);
         NotificationManager.instance.addEventListener("INVITE_SUCCESS",__inviteSuccessHandler);
         NotificationManager.instance.addEventListener("TEAM_INFO_UPDATE",__teamInfoUpdateHandler);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__response);
         _consortiaTab.removeEventListener("click",__selectedTabChangeHandler);
         _friendTab.removeEventListener("click",__selectedTabChangeHandler);
         _refreshBtn.removeEventListener("click",__refreshClick);
         NotificationManager.instance.removeEventListener("INVITE_SUCCESS",__inviteSuccessHandler);
         NotificationManager.instance.removeEventListener("TEAM_INFO_UPDATE",__teamInfoUpdateHandler);
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
      
      private function get model() : FreedomTeamModel
      {
         return FreedomTeamManager.instance.model;
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
      
      private function __teamInfoUpdateHandler(param1:FreedomTeamEvent) : void
      {
         if(FreedomTeamManager.instance.hasTeam)
         {
            refreshListView(_cList,false);
         }
         else
         {
            dispose();
         }
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
            if(model.memberId.indexOf(_loc3_.userId) == -1)
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
      
      public function show() : void
      {
         initData();
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function __response(param1:FrameEvent) : void
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
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvents();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

