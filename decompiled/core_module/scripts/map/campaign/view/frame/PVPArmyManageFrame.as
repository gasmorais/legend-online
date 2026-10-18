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
   import map.campaign.data.CampaignArmy;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.room.RoomInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class PVPArmyManageFrame extends Frame
   {
      
      private const PLAYER_COUNT:int = 4;
      
      private var _hBox:HBox;
      
      private var _back:ScaleBitmapImage;
      
      private var _addBtn:TextButton;
      
      private var _kickBtn:TextButton;
      
      private var _hero0:ArmyManageHeroItem;
      
      private var _hero1:ArmyManageHeroItem;
      
      private var _hero2:ArmyManageHeroItem;
      
      private var _hero3:ArmyManageHeroItem;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _playerList:Dictionary;
      
      private var _roomInfo:RoomInfo = RoomManager.instance.roomInfo;
      
      private var _currentSelected:ArmyManageHeroItem;
      
      public function PVPArmyManageFrame()
      {
         super();
         initView();
         refreshData();
         refreshContrl();
         setHouseOwner();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _titleText = LanguageMgr.GetTranslation("map.campaign.view.frame.ArmyManageFrame.title");
         _back = ComponentFactory.Instance.creatComponentByStylename("core.PvParmymanage.Back");
         addToContent(_back);
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("core.PVParmymanage.AddBtn");
         _kickBtn = ComponentFactory.Instance.creatComponentByStylename("core.PVParmymanage.KickBtn");
         addToContent(_addBtn);
         _addBtn.text = LanguageMgr.GetTranslation("map.campaign.view.frame.ArmyManageFrame.add");
         addToContent(_kickBtn);
         _kickBtn.text = LanguageMgr.GetTranslation("map.campaign.view.frame.ArmyManageFrame.kick");
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
         _buttonGroup.dispose();
         _buttonGroup = null;
         for each(var _loc1_:ArmyManageHeroItem in _playerList)
         {
            _loc1_.dispose();
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _roomInfo = null;
         _addBtn = null;
         _kickBtn = null;
         _kickBtn = null;
         _playerList = null;
      }
      
      private function refreshData() : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            (_playerList[_loc2_] as ArmyManageHeroItem).data = _loc2_ < _roomInfo.capacity ? _roomInfo.getPlayerByPos(_loc2_) : null;
            _loc2_++;
         }
         __updateRoomInfoHanlder(null);
      }
      
      private function get isCurrentSelectedSelf() : Boolean
      {
         if(_currentSelected && _currentSelected.data && _currentSelected.data.userId == selfInfo.userId)
         {
            return true;
         }
         return false;
      }
      
      private function initEvent() : void
      {
         for each(var _loc1_:ArmyManageHeroItem in _playerList)
         {
            _loc1_.addEventListener("click",__itemClickHandler);
         }
         addEventListener("response",__frameResponse);
         _addBtn.addEventListener("click",__addClickHandler);
         _kickBtn.addEventListener("click",__kickClickHandler);
         _roomInfo.addEventListener("REMOVE_PLAYER_ROOM",__kickOutHandler);
         _roomInfo.addEventListener("ADD_PLAYER_ROOM",__addPlayerHandler);
         _roomInfo.addEventListener("room_HouseOwner_change",__ownerChangeHandler);
         _roomInfo.addEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomInfoHanlder);
      }
      
      private function removeEvent() : void
      {
         for each(var _loc1_:ArmyManageHeroItem in _playerList)
         {
            _loc1_.removeEventListener("click",__itemClickHandler);
         }
         removeEventListener("response",__frameResponse);
         _addBtn.removeEventListener("click",__addClickHandler);
         _kickBtn.removeEventListener("click",__kickClickHandler);
         if(_roomInfo)
         {
            _roomInfo.removeEventListener("ADD_PLAYER_ROOM",__addPlayerHandler);
            _roomInfo.removeEventListener("REMOVE_PLAYER_ROOM",__kickOutHandler);
            _roomInfo.removeEventListener("room_HouseOwner_change",__ownerChangeHandler);
            _roomInfo.removeEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomInfoHanlder);
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
         var _loc3_:Frame = ComponentFactory.Instance.creatComponentByStylename("room.RoomInviteFrame");
         _loc3_["show"](1);
      }
      
      private function __kickClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_currentSelected || !_currentSelected.data)
         {
            return;
         }
         var _loc2_:ThaneInfo = _currentSelected.data.baseHero;
         if(_loc2_ && selfInfo.userId == houseOwnerId && selfInfo.userId != _loc2_.userId)
         {
            RoomSocketOutManager.sendKickPlayerAlert(_loc2_.userId);
         }
      }
      
      private function __ownerChangeHandler(param1:RoomEvent) : void
      {
         refreshContrl();
         setHouseOwner();
      }
      
      private function refreshContrl() : void
      {
         if(houseOwnerId == selfInfo.userId)
         {
            _addBtn.enable = true;
            _kickBtn.enable = isCurrentSelectedSelf ? false : true;
         }
         else
         {
            _addBtn.enable = false;
            _kickBtn.enable = false;
         }
      }
      
      private function setHouseOwner() : void
      {
         for each(var _loc1_:ArmyManageHeroItem in _playerList)
         {
            if(_loc1_.data && _loc1_.data.userId == houseOwnerId)
            {
               _loc1_.isHouseOwner = true;
            }
            else
            {
               _loc1_.isHouseOwner = false;
            }
         }
      }
      
      private function __updateRoomInfoHanlder(param1:RoomEvent) : void
      {
         if(houseOwnerId == selfInfo.userId)
         {
            return;
         }
         var _loc2_:CampaignArmy = _roomInfo.getPlayerByUserId(selfInfo.userId,"");
         if(_loc2_ && _loc2_.roomState == 0)
         {
         }
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
         if(!_loc3_ || _loc3_.userId == selfInfo.userId)
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
            if(_loc2_ == _loc3_ && !_currentSelected.data)
            {
               RoomSocketOutManager.sendClose(_currentSelected.index,_currentSelected.state == -1);
            }
         }
         else
         {
            refreshContrl();
         }
      }
      
      public function get houseOwnerId() : int
      {
         return RoomManager.instance.roomInfo.houseOwnerId;
      }
      
      public function get selfInfo() : BaseArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get currentArmyId() : int
      {
         var _loc1_:BaseArmy = ArmyManager.instance.army;
         return _loc1_.id;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
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

