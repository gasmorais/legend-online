package vehicle.room.view
{
   import avatar.view.AppellView;
   import avatar.view.ShowAvatar;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import managers.RoomManager;
   import managers.RoomSocketOutManager;
   import map.campaign.data.CampaignArmy;
   import map.internals.data.PhysicsEvent;
   import mvc.module.room.RoomInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.ArmyManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.PlayerInfoManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.PlayerMenu;
   
   public class VehiclePlayerFigure extends Component implements IEnterFrame
   {
      
      private var _data:CampaignArmy;
      
      private var _currentHero:ThaneInfo;
      
      private var _figureSprite:Sprite;
      
      private var _heroContan:Sprite;
      
      private var _consortiaName:FilterFrameText;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _flag:Bitmap;
      
      private var _posState:MovieClip;
      
      private var _closeState:MovieClip;
      
      private var _openState:MovieClip;
      
      private var _readyState:MovieClip;
      
      private var _state:int;
      
      private var _honerTxt:GradientText;
      
      private var _honerView:AppellView;
      
      private var _vipIcon:ScaleFrameImage;
      
      private var _vipText:GradientText;
      
      private var _heroFigure:ShowAvatar;
      
      private var uiFilter:UIFilter = new UIFilter();
      
      private var _appellId:int = 0;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _regressIcon:Image;
      
      private var _iconPosX:int;
      
      private var _iconPosY:int;
      
      private var _index:int;
      
      private var _chatPopView:Component;
      
      public function VehiclePlayerFigure(param1:int)
      {
         super();
         _index = param1;
         initView();
         initEvents();
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      private function initView() : void
      {
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("room.anterRoom.nameTxt");
         _consortiaName = ComponentFactory.Instance.creatComponentByStylename("room.anterRoom.consortiaTxt");
         _flag = ComponentFactory.Instance.creatBitmap("asset.baseroom.RoomPlayerFlag");
         _closeState = ComponentFactory.Instance.creat("asset.vehicleroom.RoomPosClose");
         _closeState.x = 4;
         _openState = ComponentFactory.Instance.creat("asset.vehicleroom.RoomPosExist");
         _openState.x = 0;
         _readyState = ComponentFactory.Instance.creat("asset.vehicleroom.RoomPosReady");
         _readyState.x = 0;
         _heroContan = new Sprite();
         _heroContan.buttonMode = true;
         addChild(_heroContan);
         _heroFigure = new VehicleShowAvatar(false,layout);
         _heroFigure.y = 12;
         addChild(_heroFigure);
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("army.VocationIcon");
         _vocationIcon.visible = false;
         _regressIcon = ComponentFactory.Instance.creatComponentByStylename("core.RegressIcon");
         _regressIcon.visible = false;
         this.placeState = 0;
      }
      
      private function initEvents() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         DoubleClickManager.Instance.enableDoubleClick(_heroContan);
         _heroContan.addEventListener("interactive_click",__clickHandler);
         _heroContan.addEventListener("interactive_double_click",__doubleClickHandler);
         _heroContan.addEventListener("mouseOver",__overHandler);
         _heroContan.addEventListener("mouseOut",__outHandler);
      }
      
      private function removeEvents() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         DoubleClickManager.Instance.disableDoubleClick(_heroContan);
         _heroContan.removeEventListener("interactive_click",__clickHandler);
         _heroContan.removeEventListener("interactive_double_click",__doubleClickHandler);
         _heroContan.removeEventListener("mouseOver",__overHandler);
         _heroContan.removeEventListener("mouseOut",__outHandler);
         removeArmyEvent();
      }
      
      public function enterFrame() : void
      {
         if(_honerView)
         {
            _honerView.draw();
         }
      }
      
      private function __chatHandler(param1:PhysicsEvent) : void
      {
      }
      
      private function chatBack() : void
      {
         _chatPopView = null;
      }
      
      private function layout() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(!_heroFigure)
         {
            return;
         }
         var _loc1_:Point = (_heroFigure as VehicleShowAvatar).getPosDown();
         _nickNameTxt.x = -_nickNameTxt.width / 2;
         _nickNameTxt.y = _loc1_.y - _nickNameTxt.height;
         _consortiaName.x = _nickNameTxt.x;
         _consortiaName.y = _nickNameTxt.y - _nickNameTxt.height;
         _flag.x = _nickNameTxt.x + _nickNameTxt.width / 2 - (_flag.width + _nickNameTxt.textWidth / 2);
         _flag.y = _nickNameTxt.y;
         _heroContan.addChild(_heroFigure);
         if(_data && _data.baseHero.userId == roomInfo.houseOwnerId)
         {
            addChild(_flag);
         }
         addChild(_nickNameTxt);
         addChild(_consortiaName);
         var _loc2_:Number = _nickNameTxt.width - _nickNameTxt.textWidth >> 1;
         _iconPosX = _nickNameTxt.x + _loc2_ - 5;
         _iconPosY = _nickNameTxt.y;
         setHonerName();
         refreshVocation();
         refreshRegress();
         if(isVip)
         {
            setVipIcon();
            _data.baseHero.vipType == 1 ? _vipIcon.setFrame(1) : _vipIcon.setFrame(2);
            _loc3_ = _vipIcon.width + _nickNameTxt.textWidth + 20;
            _vipIcon.y = _nickNameTxt.y - (_vipIcon.height - _nickNameTxt.textHeight);
            _vipIcon.x = -_loc3_ >> 1;
            _nickNameTxt.x = _vipIcon.x + _vipIcon.width - _loc2_ + 6;
            _vipIcon.y = _nickNameTxt.y - 2;
            _vipText.x = _nickNameTxt.x;
            _vipText.y = _nickNameTxt.y;
            _flag.x = _vipIcon.x - _flag.width;
            _vipText.text = _nickNameTxt.text;
            if(_vipIcon.visible)
            {
               _iconPosX = _vipIcon.x;
               _iconPosY = _vipIcon.y;
            }
         }
         if(_flag.parent && _flag.visible)
         {
            _iconPosX = _flag.x;
         }
         if(_vocationIcon != null)
         {
            if(isVip)
            {
               _loc4_ = int(_vipIcon.x);
               _loc5_ = int(_vipIcon.y);
            }
            else
            {
               _loc4_ = int(_nickNameTxt.x);
               _loc5_ = int(_nickNameTxt.y);
            }
            if(!_vocationIcon.parent)
            {
               addChild(_vocationIcon);
            }
            if(_data && _data.baseHero.userId == roomInfo.houseOwnerId)
            {
               _vocationIcon.x = _flag.x - _vocationIcon.width;
            }
            else
            {
               _vocationIcon.x = _loc4_ - _vocationIcon.width;
            }
            _vocationIcon.y = _loc5_ - 4;
            if(_vocationIcon.visible)
            {
               _iconPosX = _vocationIcon.x;
            }
         }
         if(_regressIcon != null)
         {
            _regressIcon.x = _iconPosX - _regressIcon.width + 5;
            _regressIcon.y = _iconPosY - 9;
            if(_regressIcon.visible)
            {
               _iconPosX = _regressIcon.x;
            }
            if(!_regressIcon.parent)
            {
               addChild(_regressIcon);
            }
         }
         if(_data.userId == ArmyManager.instance.army.userId)
         {
            if(_vipText)
            {
               _vipText.visible = false;
            }
            _nickNameTxt.visible = true;
         }
         else if(_data.baseHero.consortiaID != 0 && _data.baseHero.consortiaID == playerInfo.consortiaID)
         {
            if(_vipText)
            {
               _vipText.visible = false;
            }
            _nickNameTxt.visible = true;
         }
         else if(isVip)
         {
            if(_vipText)
            {
               _vipText.visible = true;
            }
            _nickNameTxt.visible = false;
         }
         else
         {
            if(_vipText)
            {
               _vipText.visible = false;
            }
            _nickNameTxt.visible = true;
         }
         hitArea = _heroContan;
      }
      
      private function setHonerName() : void
      {
         if(!_data)
         {
            return;
         }
         if(_appellId == _data.baseHero.appellId && (_honerView && _honerView.parent || _honerTxt && _honerTxt.parent))
         {
         }
         _appellId = _data.baseHero.appellId;
         if(_honerTxt && _honerTxt.parent)
         {
            _honerTxt.parent.removeChild(_honerTxt);
         }
         ObjectUtils.disposeObject(_honerTxt);
         _honerTxt = null;
         if(_honerView && _honerView.parent)
         {
            _honerView.parent.removeChild(_honerView);
         }
         ObjectUtils.disposeObject(_honerView);
         _honerView = null;
         if(isHoner)
         {
            _honerTxt = ComponentFactory.Instance.creatComponentByStylename(honerStyle);
            _honerTxt.text = honerName;
            _honerTxt.x = -_honerTxt.width / 2;
            _honerTxt.y = _data.baseHero.consortiaName ? _nickNameTxt.y - 40 : _nickNameTxt.y - 20;
            _honerView = new AppellView(_data.baseHero.appellInfo);
            _honerView.x = -_honerView.width / 2;
            _honerView.y = _data.baseHero.consortiaName ? _nickNameTxt.y - _data.baseHero.appellInfo.ImgHeight - 27 : _nickNameTxt.y - _data.baseHero.appellInfo.ImgHeight;
            showHoner();
         }
      }
      
      private function showHoner() : void
      {
         if(VersionSwitch.APPELL)
         {
            if(_honerTxt && _honerTxt.parent)
            {
               _honerTxt.parent.removeChild(_honerTxt);
            }
            addChild(_honerView);
         }
         else
         {
            addChild(_honerTxt);
            if(_honerView && _honerView.parent)
            {
               _honerView.parent.removeChild(_honerView);
            }
         }
      }
      
      private function get honerStyle() : String
      {
         if(VersionSwitch.APPELL)
         {
            return "map.campaign.HonerText" + _data.baseHero.appellInfo.Quality;
         }
         return "map.campaign.HonerText";
      }
      
      private function get honerName() : String
      {
         if(VersionSwitch.APPELL)
         {
            return _data.baseHero.appellInfo.Title;
         }
         return _data.baseHero.honerTemp.TemplateName;
      }
      
      private function get isHoner() : Boolean
      {
         if(!_data)
         {
            return false;
         }
         if(VersionSwitch.APPELL)
         {
            return _data.baseHero.appellId != 0;
         }
         return _data.baseHero.honer >= _data.baseHero.firstHonerTemp.Data;
      }
      
      private function setVipIcon() : void
      {
         _vipIcon || (_vipIcon = ComponentFactory.Instance.creatComponentByStylename("core.vipIcon"));
         addChild(_vipIcon);
         _vipIcon.scaleX = _vipIcon.scaleY = 1.25;
         _vipText || (_vipText = ComponentFactory.Instance.creatComponentByStylename("room.anterRoom.nameGradientText"));
         addChild(_vipText);
      }
      
      private function clearVipName() : void
      {
         _vipIcon && _vipIcon.parent && _vipIcon.parent.removeChild(_vipIcon);
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         _vipText && _vipText.parent && _vipText.parent.removeChild(_vipText);
         ObjectUtils.disposeObject(_vipText);
         _vipText = null;
      }
      
      private function get isVip() : Boolean
      {
         return _data.baseHero.IsVipAndNoExpirt;
      }
      
      private function refreshVocation() : void
      {
         if(!_data || !_data.baseHero || !_vocationIcon)
         {
            return;
         }
         if(_data.baseHero.vocationGrades > 0)
         {
            _vocationIcon.setFrame(_data.baseHero.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            _vocationIcon.visible = false;
         }
      }
      
      private function refreshRegress() : void
      {
         if(!_data || !_data.baseHero || !_regressIcon)
         {
            return;
         }
         if(_data.baseHero.isBackPlayer)
         {
            _regressIcon.visible = true;
         }
         else
         {
            _regressIcon.visible = false;
         }
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(_heroFigure)
         {
            uiFilter.setLightingFilter(_heroFigure);
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(_heroFigure)
         {
            _heroFigure.filters = [];
         }
      }
      
      private function __clickHandler(param1:Event) : void
      {
         var _loc3_:Boolean = false;
         var _loc5_:PlayerMenu = null;
         var _loc6_:Point = null;
         var _loc4_:int = 0;
         var _loc2_:Boolean = false;
         SoundManager.instance.play("022");
         if(!roomInfo)
         {
            return;
         }
         if(!_heroContan)
         {
            return;
         }
         if(_data && playerInfo.userId != _data.userId)
         {
            _loc3_ = roomInfo.houseOwnerId == playerInfo.userId ? true : false;
            if(roomInfo.roomState == 2 || roomInfo.roomState == 3)
            {
               _loc3_ = false;
            }
            _loc5_ = new PlayerMenu(false,false,false,_loc3_);
            _loc5_.setData(_data.baseHero);
            _loc6_ = new Point(_heroContan.x,_heroContan.y);
            _loc6_ = localToGlobal(_loc6_);
            if(StageReferance.stage.mouseX > _loc6_.x + 52 || StageReferance.stage.mouseX < _loc6_.x - 97 || StageReferance.stage.mouseY > _loc6_.y + 20 || StageReferance.stage.mouseY < _loc6_.y - 185)
            {
               _loc5_.x = _loc6_.x;
               _loc5_.y = _loc6_.y - 185;
            }
            else
            {
               _loc5_.x = StageReferance.stage.mouseX;
               _loc5_.y = StageReferance.stage.mouseY;
            }
            LayerManager.Instance.addToLayer(_loc5_,7);
         }
         else
         {
            _loc4_ = int(roomInfo.houseOwnerId);
            if(playerInfo.userId == _loc4_ && !_data)
            {
               _loc2_ = _state == -1;
               RoomSocketOutManager.sendClose(index,_loc2_);
            }
         }
      }
      
      private function __doubleClickHandler(param1:Event) : void
      {
         if(_data && _data.baseHero && _data.userId != roomInfo.houseOwnerId && playerInfo.userId == roomInfo.houseOwnerId && roomInfo.roomState != 2 && roomInfo.roomState != 3)
         {
            RoomSocketOutManager.sendKickPlayerAlert(_data.baseHero.userId);
         }
      }
      
      public function checkInfo(param1:String) : void
      {
         PlayerInfoManager.instance.show(_data.baseHero);
      }
      
      private function __updatePlayerInfoHandler(param1:RoomEvent) : void
      {
         updatePlayerState();
      }
      
      private function __heroInfoChange(param1:PlayerEvent) : void
      {
         _heroFigure.data = _data.baseHero;
         setHonerName();
         refreshVocation();
         refreshRegress();
      }
      
      private function removeArmyEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("CHAT_DATA",__chatHandler);
            _data.baseHero.removeEventListener("PLAYER_AVATA_CHANGE",__heroInfoChange);
            _data.removeEventListener("UPDATE_ROOM_PLAYER_DATA",__updatePlayerInfoHandler);
            _data.baseHero.removeEventListener("APPELL_CHANGE",__heroInfoChange);
            _data.baseHero.removeEventListener("VOCATION_GRADES",__heroInfoChange);
         }
      }
      
      private function addArmyEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("CHAT_DATA",__chatHandler);
            _data.baseHero.addEventListener("PLAYER_AVATA_CHANGE",__heroInfoChange);
            _data.addEventListener("UPDATE_ROOM_PLAYER_DATA",__updatePlayerInfoHandler);
            _data.baseHero.addEventListener("APPELL_CHANGE",__heroInfoChange);
            _data.baseHero.addEventListener("VOCATION_GRADES",__heroInfoChange);
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function setNickName() : void
      {
         if(_data.userId == ArmyManager.instance.army.userId)
         {
            _nickNameTxt.setFrame(3);
            if(_vipText)
            {
               _vipText.visible = true;
            }
            _nickNameTxt.visible = false;
         }
         else if(_data.baseHero.consortiaID != 0 && _data.baseHero.consortiaID == playerInfo.consortiaID)
         {
            _nickNameTxt.setFrame(2);
            if(_vipText)
            {
               _vipText.visible = true;
            }
            _nickNameTxt.visible = false;
         }
         else if(isVip)
         {
            _nickNameTxt.setFrame(2);
            if(_vipText)
            {
               _vipText.visible = true;
            }
            _nickNameTxt.visible = false;
         }
         else
         {
            _nickNameTxt.setFrame(1);
         }
         _nickNameTxt.text = _data.baseHero.nickName;
      }
      
      private function setConsortiaName() : void
      {
         if(_data.userId == ArmyManager.instance.army.userId)
         {
            _consortiaName.setFrame(3);
         }
         else if(_data.baseHero.consortiaName && _data.baseHero.consortiaName == playerInfo.consortiaName)
         {
            _consortiaName.setFrame(2);
         }
         else
         {
            _consortiaName.setFrame(1);
         }
         _consortiaName.text = _data.baseHero.consortiaName ? "<" + _data.baseHero.consortiaName + ">" : "";
      }
      
      private function clean() : void
      {
         if(_nickNameTxt.parent)
         {
            _nickNameTxt.parent.removeChild(_nickNameTxt);
         }
         if(_consortiaName.parent)
         {
            _consortiaName.parent.removeChild(_consortiaName);
         }
         if(_chatPopView)
         {
            _chatPopView.dispose();
         }
         if(_honerTxt && _honerTxt.parent)
         {
            _honerTxt.parent.removeChild(_honerTxt);
         }
         if(_honerView && _honerView.parent)
         {
            _honerView.parent.removeChild(_honerView);
         }
         if(_vipIcon && _vipIcon.parent)
         {
            _vipIcon.parent.removeChild(_vipIcon);
         }
         if(_vipText && _vipText.parent)
         {
            _vipText.parent.removeChild(_vipText);
         }
         if(_vocationIcon && _vocationIcon.parent)
         {
            _vocationIcon.parent.removeChild(_vocationIcon);
         }
         if(_regressIcon && _regressIcon.parent)
         {
            _regressIcon.parent.removeChild(_regressIcon);
         }
         _chatPopView = null;
         _currentHero = null;
         _heroFigure.data = null;
         updateOwnerState();
      }
      
      public function get data() : CampaignArmy
      {
         return _data;
      }
      
      private function get roomInfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
      }
      
      public function updateOwnerState() : void
      {
         if(_data && _data.baseHero.userId == roomInfo.houseOwnerId)
         {
            layout();
         }
         else if(_flag.parent)
         {
            _flag.parent.removeChild(_flag);
         }
      }
      
      private function updatePlayerState() : void
      {
         var _loc1_:int = 0;
         if(_data)
         {
            _loc1_ = int(_data.roomState);
         }
         else
         {
            _loc1_ = int(roomInfo.placesState[index]);
         }
         state = _loc1_;
      }
      
      public function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         placeState = param1;
      }
      
      public function set data(param1:CampaignArmy) : void
      {
         removeArmyEvent();
         clean();
         _data = param1;
         addArmyEvent();
         if(_data)
         {
            setNickName();
            setConsortiaName();
            _currentHero = param1.baseHero;
            _currentHero.fightingCapacity = param1.combatPower;
            _heroFigure.data = _currentHero;
            __updatePlayerInfoHandler(null);
            updateOwnerState();
         }
      }
      
      public function set placeState(param1:int) : void
      {
         var _loc2_:MovieClip = null;
         _state = param1;
         switch(param1 - -1)
         {
            case 0:
               _loc2_ = _closeState;
               break;
            case 1:
               _loc2_ = _openState;
               break;
            default:
               if(_data && _data.roomState == 1)
               {
                  _loc2_ = _readyState;
                  _readyState.play();
                  break;
               }
               _loc2_ = _openState;
         }
         if(_posState && _posState.parent)
         {
            _posState.stop();
            _posState.parent.removeChild(_posState);
         }
         _posState = _loc2_;
         _heroContan.addChildAt(_posState,0);
         _posState.play();
      }
      
      override public function dispose() : void
      {
         removeArmyEvent();
         removeEvents();
         _currentHero = null;
         _data = null;
         ObjectUtils.disposeAllChildren(_heroContan);
         ObjectUtils.disposeObject(_heroFigure);
         _heroFigure = null;
         ObjectUtils.disposeObject(_nickNameTxt);
         _nickNameTxt = null;
         ObjectUtils.disposeObject(_vipText);
         _vipText = null;
         ObjectUtils.disposeObject(_consortiaName);
         _consortiaName = null;
         ObjectUtils.disposeObject(_honerTxt);
         _honerTxt = null;
         ObjectUtils.disposeObject(_honerView);
         _honerView = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_flag);
         _flag = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeObject(_regressIcon);
         _regressIcon = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

