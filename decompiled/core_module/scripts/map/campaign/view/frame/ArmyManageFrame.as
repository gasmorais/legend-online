package map.campaign.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.RoomEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import managers.RoomSocketOutManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.pveroomlist.PVERoomListModel;
   import mvc.module.room.RoomInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.tips.MessageTipManager;
   
   public class ArmyManageFrame extends Frame
   {
      
      private var _hBox:HBox;
      
      private var _back:ScaleBitmapImage;
      
      private var _addBtn:TextButton;
      
      private var _changeBtn:TextButton;
      
      private var _lineUpBtn:TextButton;
      
      private var _kickBtn:TextButton;
      
      private var _hero1:ArmyManageHeroItem;
      
      private var _hero2:ArmyManageHeroItem;
      
      private var _hero3:ArmyManageHeroItem;
      
      private var _hero4:ArmyManageHeroItem;
      
      private var _hero0:ArmyManageHeroItem;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _playerList:Dictionary;
      
      private var _quickInviteFlag:Boolean;
      
      private var _type:int;
      
      private var _currentSelected:ArmyManageHeroItem;
      
      public function ArmyManageFrame()
      {
         super();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         titleText = LanguageMgr.GetTranslation("map.campaign.view.frame.ArmyManageFrame.title");
         _back = ComponentFactory.Instance.creatComponentByStylename("core.armymanage.Back");
         addToContent(_back);
         _back.x = 0;
         _back.width = 448;
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("core.armymanage.AddBtn");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("core.armymanage.ChangeBtn");
         _kickBtn = ComponentFactory.Instance.creatComponentByStylename("core.armymanage.KickBtn");
         _lineUpBtn = ComponentFactory.Instance.creatComponentByStylename("core.armymanage.AdjustmentLineUp");
         addToContent(_addBtn);
         _addBtn.text = LanguageMgr.GetTranslation("map.campaign.view.frame.ArmyManageFrame.add");
         addToContent(_changeBtn);
         _changeBtn.text = LanguageMgr.GetTranslation("map.campaign.view.frame.ArmyManageFrame.change");
         addToContent(_kickBtn);
         _kickBtn.text = LanguageMgr.GetTranslation("map.campaign.view.frame.ArmyManageFrame.kick");
         addToContent(_lineUpBtn);
         _lineUpBtn.text = LanguageMgr.GetTranslation("armyII.viewII.allocate.AllocateView.sort");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("core.armymanage.Box");
         addToContent(_hBox);
         _buttonGroup = new SelectedButtonGroup();
         _playerList = new Dictionary();
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            this["_hero" + _loc1_] = new ArmyManageHeroItem();
            _hBox.addChild(this["_hero" + _loc1_]);
            _buttonGroup.addSelectItem(this["_hero" + _loc1_] as ISelectable);
            _playerList[_loc1_] = this["_hero" + _loc1_];
            (this["_hero" + _loc1_] as ArmyManageHeroItem).index = _loc1_;
            _loc1_++;
         }
      }
      
      private function uninit() : void
      {
         _buttonGroup.removeAllItem();
         ObjectUtils.disposeAllChildren(_hBox);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function initEvent() : void
      {
         for each(var _loc1_:ArmyManageHeroItem in _playerList)
         {
            _loc1_.addEventListener("click",__itemClickHandler);
         }
         addEventListener("response",__frameResponse);
         _addBtn.addEventListener("click",__addClickHandler);
         _changeBtn.addEventListener("click",__changeClickHandler);
         _kickBtn.addEventListener("click",__kickClickHandler);
         _lineUpBtn.addEventListener("click",__lineUpClickHandler);
         roomInfo.addEventListener("REMOVE_PLAYER_ROOM",__kickOutHandler);
         roomInfo.addEventListener("ADD_PLAYER_ROOM",__addPlayerHandler);
         roomInfo.addEventListener("room_HouseOwner_change",__ownerChangeHandler);
         roomInfo.addEventListener("ROOM_PLACE_STATE_CHANGE",__placeStateChangeHandler);
      }
      
      private function removeEvent() : void
      {
         for each(var _loc1_:ArmyManageHeroItem in _playerList)
         {
            _loc1_.removeEventListener("click",__itemClickHandler);
         }
         removeEventListener("response",__frameResponse);
         _addBtn.removeEventListener("click",__addClickHandler);
         _changeBtn.removeEventListener("click",__changeClickHandler);
         _kickBtn.removeEventListener("click",__kickClickHandler);
         _lineUpBtn.removeEventListener("click",__lineUpClickHandler);
         if(RoomManager.instance.roomInfo)
         {
            roomInfo.removeEventListener("ADD_PLAYER_ROOM",__addPlayerHandler);
            roomInfo.removeEventListener("REMOVE_PLAYER_ROOM",__kickOutHandler);
            roomInfo.removeEventListener("room_HouseOwner_change",__ownerChangeHandler);
            roomInfo.removeEventListener("ROOM_PLACE_STATE_CHANGE",__placeStateChangeHandler);
         }
      }
      
      private function refreshData() : void
      {
         var _loc3_:CampaignArmy = null;
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc3_ = RoomManager.instance.roomInfo.getPlayerByPos(_loc2_);
            (_playerList[_loc2_] as ArmyManageHeroItem).data = _loc3_;
            (_playerList[_loc2_] as ArmyManageHeroItem).state = RoomManager.instance.roomInfo.placesState[_loc2_];
            _loc2_++;
         }
      }
      
      private function refreshContrl() : void
      {
         if(roomInfo && roomInfo.isCross)
         {
            _kickBtn.text = LanguageMgr.GetTranslation("map.campaign.view.frame.ArmyManageFrame.kick2");
            _kickBtn.enable = isCurrentSelectedSelf ? false : true;
            if(_kickBtn.enable)
            {
               _kickBtn.x = 10;
               _kickBtn.width = 120;
               _back.x = 0;
               _back.width = 445;
            }
            if(houseOwnerId == selfInfo.userId && roomInfo.serverName == selfInfo.serviceName)
            {
               _lineUpBtn.text = LanguageMgr.GetTranslation("armyII.viewII.allocate.AllocateView.sort");
               _changeBtn.enable = isCurrentSelectedSelf ? false : true;
            }
            else
            {
               _lineUpBtn.text = LanguageMgr.GetTranslation("map.internals.view.team.FreedomTeamManageFrame.sortCheck");
               _changeBtn.enable = false;
            }
         }
         else
         {
            _kickBtn.text = LanguageMgr.GetTranslation("map.campaign.view.frame.ArmyManageFrame.kick");
            if(houseOwnerId == selfInfo.userId)
            {
               _lineUpBtn.text = LanguageMgr.GetTranslation("armyII.viewII.allocate.AllocateView.sort");
               _changeBtn.enable = isCurrentSelectedSelf ? false : true;
               _kickBtn.enable = isCurrentSelectedSelf ? false : true;
            }
            else
            {
               _lineUpBtn.text = LanguageMgr.GetTranslation("map.internals.view.team.FreedomTeamManageFrame.sortCheck");
               _changeBtn.enable = false;
               _kickBtn.enable = false;
            }
         }
         if(RoomManager.instance.roomInfo.capacity > 1)
         {
            _addBtn.enable = true;
         }
         else
         {
            _addBtn.enable = false;
         }
         if(CampaignManager.instance.mapModel)
         {
            if(CampaignManager.instance.mapModel.mapId == 4202)
            {
               _addBtn.enable = false;
            }
         }
         var _loc1_:String = SceneManager.instance.currentType;
         if(_loc1_ == "APEX_ROOM" || _loc1_ == "GLORY_GAME_SCENE" || _loc1_ == "THESE_Double_PVP_SCENE")
         {
            _addBtn.enable = false;
         }
      }
      
      private function setHouseOwner() : void
      {
         for each(var _loc1_:ArmyManageHeroItem in _playerList)
         {
            if(_loc1_.data && _loc1_.data.userId == houseOwnerId)
            {
               if(roomInfo && roomInfo.isCross)
               {
                  _loc1_.isHouseOwner = _loc1_.data.baseHero.serviceName == roomInfo.serverName ? true : false;
               }
               else
               {
                  _loc1_.isHouseOwner = true;
               }
            }
            else
            {
               _loc1_.isHouseOwner = false;
            }
         }
      }
      
      private function get isCurrentSelectedSelf() : Boolean
      {
         if(_currentSelected && _currentSelected.data && _currentSelected.data.userId == selfInfo.userId)
         {
            return true;
         }
         return false;
      }
      
      private function __placeStateChangeHandler(param1:RoomEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ArmyManageHeroItem = null;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc2_ = _playerList[_loc3_] as ArmyManageHeroItem;
            _loc2_.state = RoomManager.instance.roomInfo.placesState[_loc3_];
            _loc3_++;
         }
      }
      
      private function __addClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(!RoomManager.instance.roomInfo.existEmptyPos())
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("pveroomlist",PVERoomListModel.OPEN_ROOMINVITEFRAME);
      }
      
      private function __changeClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_currentSelected && selfInfo.userId == houseOwnerId && _currentSelected.data && selfInfo.userId != _currentSelected.data.baseHero.userId)
         {
            if(roomInfo && roomInfo.isCross)
            {
               if(selfInfo.serviceName == roomInfo.serverName)
               {
                  RoomSocketOutManager.sendChangeRoomOwner(_currentSelected.data.baseHero.userId,_currentSelected.data.baseHero.serviceName);
               }
            }
            else
            {
               RoomSocketOutManager.sendChangeRoomOwner(_currentSelected.data.baseHero.userId);
            }
         }
      }
      
      private function __kickClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_currentSelected || !_currentSelected.data)
         {
            return;
         }
         var _loc2_:ThaneInfo = _currentSelected.data.baseHero;
         if(_loc2_ && selfInfo && selfInfo.userId != _loc2_.userId)
         {
            RoomSocketOutManager.sendKickPlayerAlert(_loc2_.userId,_loc2_.serviceName);
         }
      }
      
      private function __lineUpClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(roomInfo.campaignId == 6011 || roomInfo.campaignId == 6021 || roomInfo.campaignId == 6031)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("room.view.pve.sortTips"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("teammanager");
      }
      
      private function __inviteClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("pveroomlist",PVERoomListModel.OPEN_QUICKINVITEFRAME);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __ownerChangeHandler(param1:RoomEvent) : void
      {
         refreshContrl();
         setHouseOwner();
      }
      
      private function __addPlayerHandler(param1:RoomEvent) : void
      {
         var _loc3_:CampaignArmy = param1.data as CampaignArmy;
         if(_loc3_)
         {
            for each(var _loc2_:ArmyManageHeroItem in _playerList)
            {
               if(!_loc2_.data && _loc2_.state != -1 && _loc2_.index == _loc3_.pos)
               {
                  _loc2_.data = _loc3_;
               }
            }
         }
      }
      
      private function __kickOutHandler(param1:RoomEvent) : void
      {
         var _loc3_:CampaignArmy = param1.data as CampaignArmy;
         if(!_loc3_ || _loc3_ && _loc3_.userId == selfInfo.userId)
         {
            return;
         }
         for each(var _loc2_:ArmyManageHeroItem in _playerList)
         {
            if(_loc2_.data && _loc2_.data.baseHero.userId == _loc3_.baseHero.userId)
            {
               _loc2_.data = null;
            }
         }
         _currentSelected = null;
         _buttonGroup.selectIndex = -1;
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         _currentSelected = param1.currentTarget as ArmyManageHeroItem;
         if(!_currentSelected)
         {
            return;
         }
         var _loc2_:int = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         var _loc3_:int = RoomManager.instance.roomInfo.houseOwnerId;
         if(!_currentSelected.data)
         {
            if(roomInfo.isCross)
            {
               return;
            }
            if(_loc2_ == _loc3_ && !_currentSelected.data)
            {
               RoomSocketOutManager.sendClose(_currentSelected.index,_currentSelected.state == -1);
            }
         }
         else
         {
            refreshContrl();
            _currentSelected.selected = true;
         }
      }
      
      private function get roomInfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
      }
      
      public function get houseOwnerId() : int
      {
         return roomInfo.houseOwnerId;
      }
      
      public function get selfInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get currentArmyId() : int
      {
         var _loc1_:BaseArmy = ArmyManager.instance.army;
         return _loc1_.id;
      }
      
      public function show(param1:int = 0) : void
      {
         _type = param1;
         CheckUIModuleUtil.instance.tryCall("teammanager",initShow);
      }
      
      private function initShow() : void
      {
         initView();
         refreshData();
         refreshContrl();
         setHouseOwner();
         initEvent();
         if(_type == 1)
         {
            _kickBtn.x = 76;
            _addBtn.x = 186;
            _changeBtn.x = 296;
         }
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
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
         removeEvent();
         uninit();
         super.dispose();
      }
   }
}

