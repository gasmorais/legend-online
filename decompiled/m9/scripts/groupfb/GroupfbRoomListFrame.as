package groupfb
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.GroupfbManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.groupfb.GroupfbModel;
   import mvc.module.groupfb.GroupfbRoomInfo;
   import mvc.module.groupfb.GroupfbSender;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class GroupfbRoomListFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _quickBtn:BaseButton;
      
      private var _searchBtn:BaseButton;
      
      private var _createBtn:BaseButton;
      
      private var _btnBox:HBox;
      
      private var _leftTime:FilterFrameText;
      
      private var _panel:ScrollPanel;
      
      private var _list:SimpleTileList;
      
      private var _delay:int;
      
      public function GroupfbRoomListFrame()
      {
         super();
         initView();
         initEvent();
         GroupfbSender.requestList();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,535,565);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("groupfb.GroupfbRoomListFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("GroupfbRoomListFrame.bg");
         _quickBtn = ComponentFactory.Instance.creatComponentByStylename("GroupfbRoomListFrame.QuickBtn");
         _searchBtn = ComponentFactory.Instance.creatComponentByStylename("GroupfbRoomListFrame.SearchRoomBtn");
         _createBtn = ComponentFactory.Instance.creatComponentByStylename("GroupfbRoomListFrame.CreateRoomBtn");
         _panel = ComponentFactory.Instance.creatComponentByStylename("GroupfbRoomListFrame.panel");
         _leftTime = ComponentFactory.Instance.creatComponentByStylename("GroupfbRoomListFrame.TimeTxt");
         _btnBox = ComponentFactory.Instance.creatComponentByStylename("GroupfbRoomListFrame.btnBox");
         _list = ComponentFactory.Instance.creatCustomObject("GroupfbRoomListFrame.SimpleTileList",[2]);
         addToContent(_bg);
         addToContent(_panel);
         addToContent(_btnBox);
         addToContent(_leftTime);
         _btnBox.addChild(_quickBtn);
         _btnBox.addChild(_searchBtn);
         _btnBox.addChild(_createBtn);
         _panel.setView(_list);
         var _loc1_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.teamCount);
         var _loc2_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.teamMaxCount);
         _leftTime.text = _loc1_ + " / " + _loc2_;
      }
      
      private function unitView() : void
      {
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
         if(_leftTime)
         {
            _leftTime.dispose();
         }
         _leftTime = null;
         if(_quickBtn)
         {
            _quickBtn.dispose();
         }
         _quickBtn = null;
         if(_searchBtn)
         {
            _searchBtn.dispose();
         }
         _searchBtn = null;
         if(_createBtn)
         {
            _createBtn.dispose();
         }
         _createBtn = null;
         if(_btnBox)
         {
            _btnBox.dispose();
         }
         _btnBox = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_quickBtn)
         {
            _quickBtn.addEventListener("click",__quickClickHandler);
         }
         if(_createBtn)
         {
            _createBtn.addEventListener("click",__createRoomHandler);
         }
         if(_searchBtn)
         {
            _searchBtn.addEventListener("click",__searchRoomHandler);
         }
         MsgMan.addObserver("PVPRoomListEvent.GROUP_ROOMLIST_UPDATE",this,__roomListHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_quickBtn)
         {
            _quickBtn.removeEventListener("click",__quickClickHandler);
         }
         if(_createBtn)
         {
            _createBtn.removeEventListener("click",__createRoomHandler);
         }
         if(_searchBtn)
         {
            _searchBtn.removeEventListener("click",__searchRoomHandler);
         }
         MsgMan.removeObserver("PVPRoomListEvent.GROUP_ROOMLIST_UPDATE",this,__roomListHandler);
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
      
      private function __roomListHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:GroupfbRoomItem = null;
         var _loc3_:int = 0;
         if(isDie)
         {
            return;
         }
         _list.disposeAllChildren();
         model.roomList.sort(sortRoom);
         var _loc2_:int = int(model.roomList.length > 6 ? model.roomList.length : 6);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(model.roomList.length <= _loc3_)
            {
               _loc1_ = new GroupfbRoomItem();
               _loc1_.data = null;
               _list.addChild(_loc1_);
            }
            else if(model.roomList[_loc3_].state != 3)
            {
               _loc1_ = new GroupfbRoomItem();
               _loc1_.data = model.roomList[_loc3_];
               _list.addChild(_loc1_);
            }
            _loc3_++;
         }
         _panel.invalidateViewport();
      }
      
      private function sortRoom(param1:GroupfbRoomInfo, param2:GroupfbRoomInfo) : int
      {
         if(param1.id > param2.id)
         {
            return 1;
         }
         if(param1.id < param2.id)
         {
            return -1;
         }
         return 0;
      }
      
      private function __createRoomHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(getTimer() - _delay <= 2000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _delay = getTimer();
         var _loc2_:String = WorldBossHelper.getCampaignTips();
         if(_loc2_ != "")
         {
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(FreedomTeamManager.instance.hasTeam || Boolean(GroupfbManager.instance.model.hasGroupTeam))
         {
            _loc2_ = LanguageMgr.GetTranslation("groupfb.GroupfbRoomListFrame.hasTeamTips");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         GroupfbSender.creatGroup();
      }
      
      private function __searchRoomHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(getTimer() - _delay <= 2000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _delay = getTimer();
         var _loc2_:String = WorldBossHelper.getCampaignTips();
         if(_loc2_ != "")
         {
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(FreedomTeamManager.instance.hasTeam || Boolean(GroupfbManager.instance.model.hasGroupTeam))
         {
            _loc2_ = LanguageMgr.GetTranslation("groupfb.GroupfbRoomListFrame.hasTeamTips");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("groupfb",3);
      }
      
      private function __quickClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(getTimer() - _delay <= 2000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _delay = getTimer();
         var _loc2_:String = WorldBossHelper.getCampaignTips();
         if(_loc2_ != "")
         {
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(FreedomTeamManager.instance.hasTeam || Boolean(GroupfbManager.instance.model.hasGroupTeam))
         {
            _loc2_ = LanguageMgr.GetTranslation("groupfb.GroupfbRoomListFrame.hasTeamTips");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         GroupfbSender.enterGroup(0);
      }
      
      private function get model() : GroupfbModel
      {
         return GroupfbManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

