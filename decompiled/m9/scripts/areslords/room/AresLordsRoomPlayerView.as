package areslords.room
{
   import avatar.view.AppellView;
   import avatar.view.ShowAvatar;
   import chat.datas.ChatFactory;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
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
   import map.campaign.data.CampaignArmy;
   import map.internals.data.PhysicsEvent;
   import mvc.module.room.RoomInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.ArmyManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.PlayerInfoManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.PlayerMenu;
   
   public class AresLordsRoomPlayerView extends Component implements IEnterFrame
   {
      
      private var _data:CampaignArmy;
      
      private var _currentHero:ThaneInfo;
      
      private var _heroFigure:ShowAvatar;
      
      private var _heroContan:Sprite;
      
      private var _consortiaName:FilterFrameText;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _petNameTxt:FilterFrameText;
      
      private var _flag:Bitmap;
      
      private var _petQuaity:MovieClip;
      
      private var _petQuaityWidth:int = 66;
      
      private var _posState:MovieClip;
      
      private var _closeState:MovieClip;
      
      private var _openState:MovieClip;
      
      private var _readyState:MovieClip;
      
      private var _state:int;
      
      private var _honerTxt:GradientText;
      
      private var _honerView:AppellView;
      
      private var _vipIcon:Bitmap;
      
      private var _vipText:GradientText;
      
      private var _appellId:int = 0;
      
      private var _vocationIcon:ScaleFrameImage;
      
      public var index:int;
      
      private var _chatPopView:Component;
      
      public function AresLordsRoomPlayerView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("room.anterRoom.nameTxt");
         _consortiaName = ComponentFactory.Instance.creatComponentByStylename("room.anterRoom.consortiaTxt");
         _flag = ComponentFactory.Instance.creatBitmap("asset.baseroom.RoomPlayerFlag");
         _closeState = ComponentFactory.Instance.creat("asset.baseroom.RoomPosClose");
         _openState = ComponentFactory.Instance.creat("asset.baseroom.RoomPosExist");
         _readyState = ComponentFactory.Instance.creat("asset.baseroom.RoomPosReady");
         _petNameTxt = ComponentFactory.Instance.creatComponentByStylename("map.campaign.PetNameText");
         if(ArmyManager.instance.thane.grades >= 50)
         {
            _petQuaity = ComponentFactory.Instance.creat("asset.map.PetQuaityAsset");
         }
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("army.VocationIcon");
         _vocationIcon.visible = false;
         _heroContan = new Sprite();
         _heroContan.buttonMode = true;
         addChild(_heroContan);
         _heroFigure = new ShowAvatar(false,__onCompleteHandler,true);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_heroFigure);
         _heroFigure = null;
         ObjectUtils.disposeObject(_nickNameTxt);
         _nickNameTxt = null;
         ObjectUtils.disposeObject(_petNameTxt);
         _petNameTxt = null;
         ObjectUtils.disposeViolentMc(_petQuaity);
         _petQuaity = null;
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
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeObject(_flag);
         _flag = null;
         ObjectUtils.disposeAllChildren(_heroContan);
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
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
         if(_chatPopView)
         {
            _chatPopView.dispose();
            _chatPopView = null;
         }
         if(!_chatPopView && _heroFigure && _heroFigure.body && _heroFigure.body.content && _heroFigure.body.content["pos_up"])
         {
            _chatPopView = ChatFactory.createChatPopByType(_data.chatData,chatBack);
            _chatPopView.x = -90;
            _chatPopView.y = _heroFigure.y + _heroFigure.body.content["pos_up"]["y"] - _chatPopView.displayHeight;
            addChild(_chatPopView);
            if(_data && _data.baseHero.userId == roomInfo.houseOwnerId)
            {
               addChild(_flag);
            }
            addChild(_nickNameTxt);
         }
      }
      
      private function chatBack() : void
      {
         _chatPopView = null;
      }
      
      private function __onCompleteHandler() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(!_heroFigure)
         {
            return;
         }
         if(_heroFigure.data && _heroFigure.width == 0 || _heroFigure.height == 0)
         {
            return;
         }
         var _loc4_:Object = _heroFigure.body.content;
         if(!_loc4_ || !_loc4_["pos_down"] || !_loc4_["pos_up"])
         {
            return;
         }
         _heroFigure.x = -_loc4_["pos_down"]["x"];
         _heroFigure.y = isDragonTalker ? -_loc4_["pos_down"]["y"] - 18 : -_loc4_["pos_down"]["y"];
         var _loc3_:Number = Number(isDragonTalker ? _loc4_["pos_up"]["y"] + 20 : _loc4_["pos_up"]["y"]);
         _nickNameTxt.x = _heroFigure.x + _loc4_["pos_up"]["x"] - _nickNameTxt.width / 2;
         _nickNameTxt.y = _heroFigure.y + _loc3_ - _nickNameTxt.height;
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
         setHonerName();
         if(isVip)
         {
            setVipIcon();
            _loc2_ = _vipIcon.width + _nickNameTxt.textWidth + 10;
            _loc1_ = _nickNameTxt.width - _nickNameTxt.textWidth >> 1;
            _vipIcon.y = _nickNameTxt.y - (_vipIcon.height - _nickNameTxt.textHeight);
            _vipIcon.x = -_loc2_ >> 1;
            _nickNameTxt.x = _vipIcon.x + _vipIcon.width - _loc1_ - 1;
            _vipIcon.y = _nickNameTxt.y;
            _vipText.x = _nickNameTxt.x;
            _vipText.y = _nickNameTxt.y;
            _flag.x = _vipIcon.x - _flag.width;
            _vipText.text = _nickNameTxt.text;
         }
         if(_vocationIcon != null)
         {
            if(isVip)
            {
               _loc5_ = _vipIcon.x;
               _loc6_ = _vipIcon.y;
            }
            else
            {
               _loc5_ = _nickNameTxt.x + _nickNameTxt.width / 2 - (_flag.width + _nickNameTxt.textWidth / 2);
               _loc6_ = int(_nickNameTxt.y);
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
               _vocationIcon.x = _loc5_ - _vocationIcon.width;
            }
            _vocationIcon.y = _loc6_ - 4;
         }
         if(isSelf)
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
         setPetName();
      }
      
      private function setPetName(param1:String = "") : void
      {
         var _loc2_:String = _data.baseHero.petName ? _data.baseHero.petName : "";
         if(param1 != "")
         {
            _loc2_ = param1;
         }
         if(_petNameTxt)
         {
            _petNameTxt.text = "";
            if(!_petNameTxt.parent)
            {
               addChild(_petNameTxt);
            }
            _petNameTxt.text = _loc2_;
            if(_data.baseHero.petQuaity > 0)
            {
               _petNameTxt.setFrame(_data.baseHero.petQuaity);
            }
            if(_data.baseHero.petQuaity >= 5)
            {
               if(_petQuaity && !_petQuaity.parent)
               {
                  addChild(_petQuaity);
               }
            }
            else if(_petQuaity && _petQuaity.parent)
            {
               _petQuaity.parent.removeChild(_petQuaity);
            }
            if(_heroFigure.petAvatar)
            {
               _petNameTxt.x = _heroFigure.x + _heroFigure.petAvatar.x - _petNameTxt.width / 2;
               _petNameTxt.y = _heroFigure.y + _heroFigure.petAvatar.y + _heroFigure.petAvatar.headPosY;
               if(_petQuaity)
               {
                  _petQuaity.x = _petNameTxt.x + _petNameTxt.width / 2 - _petQuaityWidth / 2;
                  _petQuaity.y = _petNameTxt.y;
               }
            }
         }
      }
      
      private function setHonerName() : void
      {
         if(_appellId == _data.baseHero.appellId && (_honerView && _honerView.parent || _honerTxt && _honerTxt.parent))
         {
            resetHonerPos();
            return;
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
            _honerView = new AppellView(_data.baseHero.appellInfo);
            resetHonerPos();
            showHoner();
         }
         refreshVocation();
      }
      
      private function resetHonerPos() : void
      {
         if(_honerTxt)
         {
            _honerTxt.x = -_honerTxt.width / 2;
            _honerTxt.y = _data.baseHero.consortiaName ? _nickNameTxt.y - 40 : _nickNameTxt.y - 20;
         }
         if(_honerView)
         {
            _honerView.x = -_honerView.width / 2;
            _honerView.y = _data.baseHero.consortiaName ? _nickNameTxt.y - _data.baseHero.appellInfo.ImgHeight - 20 : _nickNameTxt.y - _data.baseHero.appellInfo.ImgHeight;
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
         if(VersionSwitch.APPELL)
         {
            return _data.baseHero.appellId != 0;
         }
         return _data.baseHero.honer >= _data.baseHero.firstHonerTemp.Data;
      }
      
      private function setVipIcon() : void
      {
         _vipIcon || (_vipIcon = ComponentFactory.Instance.creatBitmap("asset.core.simpleVIPIcon"));
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
         if(_data && _data.baseHero && _data.baseHero.vocationGrades > 0)
         {
            _vocationIcon.setFrame(_data.baseHero.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            _vocationIcon.visible = false;
         }
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(_heroFigure)
         {
            TweenMax.to(_heroFigure,0.5,{
               "glowFilter":{
                  "color":16777215,
                  "alpha":1,
                  "blurX":4,
                  "blurY":4,
                  "strength":10,
                  "quality":1
               },
               "repeat":-1,
               "yoyo":true
            });
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(_heroFigure)
         {
            TweenMax.killTweensOf(_heroFigure);
            _heroFigure.filters = [];
         }
      }
      
      private function __clickHandler(param1:Event) : void
      {
         var _loc2_:PlayerMenu = null;
         var _loc3_:Point = null;
         SoundManager.instance.play("022");
         if(_data && playerInfo.userId != _data.userId)
         {
            _loc2_ = new PlayerMenu();
            _loc2_.setData(_data.baseHero);
            _loc3_ = new Point(_heroContan.x,_heroContan.y);
            _loc3_ = localToGlobal(_loc3_);
            if(StageReferance.stage.mouseX > _loc3_.x + 52 || StageReferance.stage.mouseX < _loc3_.x - 97 || StageReferance.stage.mouseY > _loc3_.y + 20 || StageReferance.stage.mouseY < _loc3_.y - 185)
            {
               _loc2_.x = _loc3_.x;
               _loc2_.y = _loc3_.y - 185;
            }
            else
            {
               _loc2_.x = StageReferance.stage.mouseX;
               _loc2_.y = StageReferance.stage.mouseY;
            }
            LayerManager.Instance.addToLayer(_loc2_,7);
         }
      }
      
      private function __doubleClickHandler(param1:Event) : void
      {
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
         if(isSelf)
         {
            _heroFigure.data = thane;
         }
         else
         {
            _heroFigure.data = _data.baseHero;
         }
         setHonerName();
         setPetName();
      }
      
      private function removeArmyEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("CHAT_DATA",__chatHandler);
            _data.removeEventListener("UPDATE_ROOM_PLAYER_DATA",__updatePlayerInfoHandler);
            if(isSelf)
            {
               thane.removeEventListener("PLAYER_AVATA_CHANGE",__heroInfoChange);
               thane.removeEventListener("APPELL_CHANGE",__heroInfoChange);
               thane.removeEventListener("VOCATION_GRADES",__heroInfoChange);
            }
            else
            {
               _data.baseHero.removeEventListener("PLAYER_AVATA_CHANGE",__heroInfoChange);
               _data.baseHero.removeEventListener("APPELL_CHANGE",__heroInfoChange);
               _data.baseHero.removeEventListener("VOCATION_GRADES",__heroInfoChange);
            }
         }
      }
      
      private function addArmyEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("CHAT_DATA",__chatHandler);
            _data.addEventListener("UPDATE_ROOM_PLAYER_DATA",__updatePlayerInfoHandler);
            if(isSelf)
            {
               thane.addEventListener("PLAYER_AVATA_CHANGE",__heroInfoChange);
               thane.addEventListener("APPELL_CHANGE",__heroInfoChange);
               thane.addEventListener("VOCATION_GRADES",__heroInfoChange);
            }
            else
            {
               _data.baseHero.addEventListener("PLAYER_AVATA_CHANGE",__heroInfoChange);
               _data.baseHero.addEventListener("APPELL_CHANGE",__heroInfoChange);
               _data.baseHero.addEventListener("VOCATION_GRADES",__heroInfoChange);
            }
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get isSelf() : Boolean
      {
         if(_data.userId == thane.userId)
         {
            return true;
         }
         return false;
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
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function setNickName() : void
      {
         if(isSelf)
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
         if(isSelf)
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
         if(_petNameTxt.parent)
         {
            _petNameTxt.parent.removeChild(_petNameTxt);
         }
         if(_consortiaName.parent)
         {
            _consortiaName.parent.removeChild(_consortiaName);
         }
         if(_chatPopView)
         {
            _chatPopView.dispose();
         }
         if(_petQuaity && _petQuaity.parent)
         {
            _petQuaity.parent.removeChild(_petQuaity);
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
         _chatPopView = null;
         _currentHero = null;
         _heroFigure.data = null;
         updateOwnerState();
         state = roomInfo.placesState[index] == -1 ? -1 : 0;
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
            __onCompleteHandler();
         }
         else
         {
            if(_flag.parent)
            {
               _flag.parent.removeChild(_flag);
            }
            __onCompleteHandler();
         }
      }
      
      private function updatePlayerState() : void
      {
         var _loc1_:int = 0;
         if(_data)
         {
            _loc1_ = 1;
         }
         else
         {
            _loc1_ = 0;
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
               if(_data)
               {
                  _loc2_ = _readyState;
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
      
      public function get isDragonTalker() : Boolean
      {
         if(!_data)
         {
            return false;
         }
         return PlayerManager.instance.getIsDragonTalkerState(_data.baseHero);
      }
      
      override public function dispose() : void
      {
         removeArmyEvent();
         removeEvents();
         uninitView();
         _currentHero = null;
         _data = null;
         super.dispose();
      }
   }
}

