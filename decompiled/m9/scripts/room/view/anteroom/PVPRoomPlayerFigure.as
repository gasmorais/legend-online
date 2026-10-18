package room.view.anteroom
{
   import avatar.view.AppellView;
   import avatar.view.ShowAvatar;
   import chat.datas.ChatFactory;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
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
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.ArmyManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.PlayerMenu;
   
   public class PVPRoomPlayerFigure extends Component implements IEnterFrame
   {
      
      private var _data:CampaignArmy;
      
      private var _figureSprite:Sprite;
      
      private var _heroFigure:ShowAvatar;
      
      private var _heroContan:Sprite;
      
      private var _consortiaName:FilterFrameText;
      
      private var _flag:Bitmap;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _petNameTxt:FilterFrameText;
      
      private var _state:int;
      
      private var _petQuaity:MovieClip;
      
      private var _petQuaityWidth:int = 66;
      
      private var _posState:MovieClip;
      
      private var _openState:MovieClip;
      
      private var _readyState:MovieClip;
      
      private var _honerTxt:GradientText;
      
      private var _honerView:AppellView;
      
      private var _vipIcon:ScaleFrameImage;
      
      private var _vipText:GradientText;
      
      private var _appellId:int = 0;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _regressIcon:Image;
      
      private var _iconPosX:int;
      
      private var _iconPosY:int;
      
      private var _leagueRankContainer:Sprite;
      
      private var _leagueRankGroup:ScaleFrameImage;
      
      private var _leagueRankTips1:Bitmap;
      
      private var _leagueRankTips2:Bitmap;
      
      private var _leagueRankTxt:FilterFrameText;
      
      private var stateImage:ScaleFrameImage;
      
      public var index:int;
      
      private var _hBox:HBox;
      
      private var _chatPopView:Component;
      
      public function PVPRoomPlayerFigure()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("roomPVP.anterRoom.nameTxt");
         _consortiaName = ComponentFactory.Instance.creatComponentByStylename("roomPVP.anterRoom.consortiaTxt");
         _flag = ComponentFactory.Instance.creatBitmap("asset.baseroom.RoomPlayerFlag");
         _openState = ComponentFactory.Instance.creat("asset.baseroom.RoomPosExist");
         _readyState = ComponentFactory.Instance.creat("asset.baseroom.RoomPosReady");
         _petNameTxt = ComponentFactory.Instance.creatComponentByStylename("map.campaign.PetNameText");
         stateImage = ComponentFactory.Instance.creatComponentByStylename("baseroom.RoomPlayer.stateImage");
         if(ArmyManager.instance.thane.grades >= 50)
         {
            _petQuaity = ComponentFactory.Instance.creat("asset.map.PetQuaityAsset");
         }
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("army.VocationIcon");
         _vocationIcon.visible = false;
         _hBox = new HBox();
         _hBox.spacing = 2;
         _regressIcon = ComponentFactory.Instance.creatComponentByStylename("core.RegressIcon");
         _regressIcon.visible = false;
         _heroContan = new Sprite();
         _heroContan.buttonMode = true;
         addChild(_heroContan);
         _heroFigure = new ShowAvatar(false,__onCompleteHandler,true);
         placeState = 0;
         _leagueRankContainer = new Sprite();
         _leagueRankGroup = ComponentFactory.Instance.creatComponentByStylename("roomPVP.anterRoom.RankGroupTips");
         _leagueRankTips1 = ComponentFactory.Instance.creatBitmap("asset.roomPVP.RankTips1");
         _leagueRankTips2 = ComponentFactory.Instance.creatBitmap("asset.roomPVP.RankTips2");
         _leagueRankTxt = ComponentFactory.Instance.creatComponentByStylename("roomPVP.anterRoom.RankTxt");
         _leagueRankContainer.addChild(_leagueRankGroup);
         _leagueRankContainer.addChild(_leagueRankTips2);
         _leagueRankContainer.addChild(_leagueRankTxt);
         _leagueRankGroup.setFrame(1);
         addChild(_leagueRankContainer);
         _leagueRankContainer.visible = false;
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
      
      private function __onCompleteHandler() : void
      {
         var _loc2_:Number = NaN;
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
         addChild(stateImage);
         var _loc1_:Number = _nickNameTxt.width - _nickNameTxt.textWidth >> 1;
         _iconPosX = _nickNameTxt.x + _loc1_ - 5;
         _iconPosY = _nickNameTxt.y;
         setLeagueRank();
         refreshVocation();
         refreshRegress();
         if(isVip)
         {
            setVipIcon();
            _data.baseHero.vipType == 1 ? _vipIcon.setFrame(1) : _vipIcon.setFrame(2);
            _loc2_ = _vipIcon.width + _nickNameTxt.textWidth + 20;
            _vipIcon.y = _nickNameTxt.y - (_vipIcon.height - _nickNameTxt.textHeight);
            _vipIcon.x = -_loc2_ >> 1;
            _nickNameTxt.x = _vipIcon.x + _vipIcon.width - _loc1_ + 6;
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
               _loc5_ = int(_vipIcon.x);
               _loc6_ = int(_vipIcon.y);
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
         if(stateImage)
         {
            stateImage.x = stateImage.width > 0 ? -stateImage.width / 2 : -stateImage.displayWidth / 2;
            if(_leagueRankContainer.parent && _leagueRankContainer.visible)
            {
               stateImage.y = _leagueRankContainer.y - 30;
            }
            else if(_honerView && _honerView)
            {
               stateImage.y = _honerView.y - 30;
            }
            else if(_data.baseHero.consortiaName)
            {
               stateImage.y = _consortiaName.y - 30;
            }
            else
            {
               stateImage.y = _nickNameTxt.y - 30;
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
         hitArea = _heroFigure;
         setPetName();
      }
      
      private function __chatHandler(param1:PhysicsEvent) : void
      {
         if(_data.chatData == null)
         {
            if(_chatPopView)
            {
               _chatPopView.dispose();
            }
            _chatPopView = null;
            return;
         }
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
            if(_data && _data.baseHero && _data.baseHero.userId == roomInfo.houseOwnerId)
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
         if(_data && _data.userId != playerInfo.userId)
         {
            _loc2_ = new PlayerMenu();
            _data.baseHero.fightingCapacity = _data.combatPower;
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
         if(_data && _data.baseHero && _data.userId != roomInfo.houseOwnerId && playerInfo.userId == roomInfo.houseOwnerId && roomInfo.roomState != 2)
         {
            RoomSocketOutManager.sendKickPlayerAlert(_data.baseHero.userId);
         }
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
         setStateImage();
         _state = param1;
         switch(param1 - -1)
         {
            case 0:
               break;
            case 1:
               _loc2_ = _openState;
               break;
            default:
               if(_data && _data.roomState == 1 && _data.baseHero.userId != roomInfo.houseOwnerId)
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
         if(!_posState)
         {
            return;
         }
         _heroContan.addChildAt(_posState,0);
         _posState.play();
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
         setStateImage();
      }
      
      private function __updatePlayerInfoHandler(param1:RoomEvent) : void
      {
         var _loc2_:int = 0;
         if(_data.baseHero.userId == roomInfo.houseOwnerId)
         {
            _loc2_ = 2;
         }
         else if(_data.roomState == 0)
         {
            _loc2_ = 0;
         }
         else if(_data.roomState == 1)
         {
            _loc2_ = 1;
         }
         state = _loc2_;
      }
      
      private function removeArmyEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("UPDATE_ROOM_PLAYER_DATA",__updatePlayerInfoHandler);
            _data.removeEventListener("CHAT_DATA",__chatHandler);
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
            _data.addEventListener("UPDATE_ROOM_PLAYER_DATA",__updatePlayerInfoHandler);
            _data.addEventListener("CHAT_DATA",__chatHandler);
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
         if(_data && _data.userId == thane.userId)
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
            setConsortiaName();
            setNickName();
            _heroFigure.data = param1.baseHero;
            __updatePlayerInfoHandler(null);
            updateOwnerState();
         }
      }
      
      private function clean() : void
      {
         if(_chatPopView)
         {
            _chatPopView.dispose();
         }
         _chatPopView = null;
         _nickNameTxt.text = "";
         _petNameTxt.text = "";
         _consortiaName.text = "";
         if(_petQuaity && _petQuaity.parent)
         {
            _petQuaity.parent.removeChild(_petQuaity);
         }
         if(_hBox && _hBox.parent)
         {
            _hBox.parent.removeChild(_hBox);
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
         if(_leagueRankContainer && _leagueRankContainer.parent)
         {
            _leagueRankContainer.parent.removeChild(_leagueRankContainer);
         }
         if(stateImage && stateImage.parent)
         {
            stateImage.parent.removeChild(stateImage);
         }
         _heroFigure.data = null;
         placeState = 0;
         updateOwnerState();
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
      
      private function setPetName() : void
      {
         var _loc1_:String = _data.baseHero.petName ? _data.baseHero.petName : "";
         if(_petNameTxt)
         {
            _petNameTxt.text = "";
            if(_hBox)
            {
               _hBox.removeAllChild();
            }
            if(!_petNameTxt.parent)
            {
               addChild(_petNameTxt);
            }
            _petNameTxt.text = _loc1_;
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
            if(_petNameTxt.text != "")
            {
               addChild(_hBox);
               showStar(_data.baseHero);
            }
            if(_heroFigure.petAvatar)
            {
               _petNameTxt.x = _heroFigure.x + _heroFigure.petAvatar.x - _petNameTxt.width / 2;
               _petNameTxt.y = _heroFigure.y + _heroFigure.petAvatar.y + _heroFigure.petAvatar.headPosY;
               _hBox.x = _heroFigure.x + _heroFigure.petAvatar.x - _hBox.width / 2;
               _hBox.y = _petNameTxt.y - 10;
               if(_petQuaity)
               {
                  _petQuaity.x = _petNameTxt.x + _petNameTxt.width / 2 - _petQuaityWidth / 2;
                  _petQuaity.y = _petNameTxt.y;
               }
            }
         }
      }
      
      private function showStar(param1:ThaneInfo) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Bitmap = null;
         if(_hBox)
         {
            _hBox.removeAllChild();
         }
         if(param1.petTemplate && param1.petTemplate.NeedGrade == 3)
         {
            if(param1.petQuaity == 6 && param1.temQuality == 31)
            {
               return;
            }
         }
         else if(param1.petQuaity == 5 && param1.temQuality == 21)
         {
            return;
         }
         _loc2_ = param1.temQuality % 5 == 0 ? 5 : param1.temQuality % 5;
         if(param1.temQuality > 25)
         {
            _loc3_ = "asset.pet.smallMoonLightLevelImg";
         }
         else
         {
            _loc3_ = "asset.pet.smallStarLevelImg";
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = ComponentFactory.Instance.creatBitmap(_loc3_);
            _hBox.addChild(_loc5_);
            _loc4_++;
         }
      }
      
      private function setLeagueRank() : void
      {
         if(_data && _data.baseHero && _data.baseHero.leagueRankIndex > 0)
         {
            _leagueRankGroup.setFrame(_data.baseHero.leagueRankGroup);
            _leagueRankTxt.text = _data.baseHero.leagueRankIndex.toString();
            _leagueRankTxt.width = _leagueRankTxt.textWidth + 5;
            _leagueRankTips2.x = _leagueRankTxt.x + _leagueRankTxt.width;
            _leagueRankContainer.x = -_leagueRankContainer.width / 2;
            _leagueRankContainer.y = _data.baseHero.consortiaName ? _nickNameTxt.y - _leagueRankContainer.height - 20 : _nickNameTxt.y - _leagueRankContainer.height;
            if(!_leagueRankContainer.parent)
            {
               addChild(_leagueRankContainer);
            }
            _leagueRankContainer.visible = true;
         }
         else
         {
            _leagueRankContainer.visible = false;
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
            showHoner();
         }
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
      
      private function __heroInfoChange(param1:PlayerEvent) : void
      {
         _heroFigure.data = _data.baseHero;
         setLeagueRank();
         refreshVocation();
         refreshRegress();
         setPetName();
      }
      
      private function setStateImage() : void
      {
         if(_data && _data.baseHero.userId == roomInfo.houseOwnerId)
         {
            stateImage.setFrame(1);
         }
         else if(_data && _data.roomState == 1 && _data.baseHero.userId != roomInfo.houseOwnerId)
         {
            stateImage.setFrame(2);
         }
         else
         {
            stateImage.setFrame(3);
         }
      }
      
      public function get data() : CampaignArmy
      {
         return _data;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get roomInfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
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
         _data = null;
         if(_heroContan)
         {
            _heroContan.filters = null;
         }
         ObjectUtils.disposeAllChildren(_heroContan);
         ObjectUtils.disposeObject(_figureSprite);
         _figureSprite = null;
         ObjectUtils.disposeObject(_heroFigure);
         _heroFigure = null;
         ObjectUtils.disposeObject(_nickNameTxt);
         _nickNameTxt = null;
         ObjectUtils.disposeObject(_petNameTxt);
         _petNameTxt = null;
         if(_hBox)
         {
            ObjectUtils.disposeObject(_hBox);
         }
         _hBox = null;
         ObjectUtils.disposeObject(_petQuaity);
         _petQuaity = null;
         ObjectUtils.disposeObject(_consortiaName);
         _consortiaName = null;
         ObjectUtils.disposeObject(_honerTxt);
         _honerTxt = null;
         ObjectUtils.disposeObject(_honerView);
         _honerView = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_vipText);
         _vipText = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeObject(_regressIcon);
         _regressIcon = null;
         ObjectUtils.disposeObject(_leagueRankGroup);
         _leagueRankGroup = null;
         ObjectUtils.disposeObject(_leagueRankTips1);
         _leagueRankTips1 = null;
         ObjectUtils.disposeObject(_leagueRankTips2);
         _leagueRankTips2 = null;
         ObjectUtils.disposeObject(_leagueRankTxt);
         _leagueRankTxt = null;
         ObjectUtils.disposeObject(_leagueRankContainer);
         _leagueRankContainer = null;
         if(stateImage)
         {
            ObjectUtils.disposeObject(stateImage);
         }
         stateImage = null;
         ObjectUtils.disposeAllChildren(_heroContan);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

