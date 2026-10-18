package theseusDoublepvpscene.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import managers.TheseusPvpManager;
   import map.campaign.data.CampaignArmy;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.room.RoomInfo;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpModel;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpSeasonInfo;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpUserInfo;
   import theseusdoublepvp.TheseusDoubleVsView;
   import theseusdoublepvproom.invite.TheseusTeamInviteFrame;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusAnteroomView extends Component
   {
      
      private const PLAYER_COUNT:int = 4;
      
      private var _roomInfo:RoomInfo;
      
      private var _playerList:Vector.<TheseusPlayerFigure>;
      
      private var _pointArray:Vector.<Point>;
      
      private var _offY:int = 10;
      
      private var _currTimeDate:Date;
      
      private var _matchBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _inviteBtn:IconButton;
      
      private var _btnBg:Bitmap;
      
      private var _configBuyDic:Dictionary = new Dictionary();
      
      private var _maxBuyTime:int;
      
      private var _buyBtn:BaseButton;
      
      public var _bottomFreeTxt:FilterFrameText;
      
      private var _macthMc:MovieClip;
      
      private var _ready:IconButton;
      
      private var _cancelready:IconButton;
      
      private var _jImg:Image;
      
      private var initWidth:int;
      
      private var initHeight:int;
      
      private var _centerX:int;
      
      private var _centerY:int;
      
      private var _playerListPos:SimpleDictionary = new SimpleDictionary(true);
      
      public function TheseusAnteroomView(param1:RoomInfo)
      {
         super();
         model = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc3_:int = 0;
         initPlayerList();
         refreshPlayerData();
         var _loc6_:TheseusDoublePvpSeasonInfo = modeldouble.seasonTimeInfo;
         _currTimeDate = DateFormatter.parse(_loc6_.stopDate,"YYYY-MM-DD hh:mm:ss");
         _btnBg = ComponentFactory.Instance.creatBitmap("asset.theseuspve.double.BtnBg");
         addChild(_btnBg);
         _matchBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.matchBtn1");
         addChild(_matchBtn);
         _ready = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspve.double.ready");
         addChild(_ready);
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspve.double.Hallinvitation");
         addChild(_inviteBtn);
         _cancelready = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspve.double.cancelready");
         addChild(_cancelready);
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.cancelMatchBtn");
         addChild(_cancelBtn);
         _cancelBtn.x = 165;
         _cancelBtn.y = 65;
         _cancelBtn.visible = false;
         _ready.visible = false;
         _cancelready.visible = false;
         _bottomFreeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.bottomFreeTxt");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.buyJBtn");
         addChild(_bottomFreeTxt);
         addChild(_buyBtn);
         _macthMc = ComponentFactory.Instance.creatCustomObject("asset.theseuspvp.matchMC");
         addChild(_macthMc);
         _macthMc.visible = false;
         _macthMc.stop();
         _macthMc.mouseEnabled = false;
         getPoint();
         _btnBg.x = 0;
         _btnBg.y = 0;
         _jImg = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.buyIcon");
         addChild(_jImg);
         _jImg.buttonMode = true;
         _jImg.x = 134;
         _jImg.y = 15;
         _jImg.tipData = LanguageMgr.GetTranslation("theseuspvp.useTip");
         _bottomFreeTxt.x = _matchBtn.x - 150;
         _buyBtn.y = _bottomFreeTxt.y = _matchBtn.y - 30;
         _buyBtn.x = _bottomFreeTxt.x + _bottomFreeTxt.width - 30;
         _ready.x = _matchBtn.x;
         _ready.y = _matchBtn.y;
         _cancelready.x = _matchBtn.x;
         _cancelready.y = _matchBtn.y;
         _macthMc.x = 197;
         _macthMc.y = 30;
         updateInfos();
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("theseus_multi_pvp_buy_count_points");
         if(_loc1_)
         {
            _loc2_ = _loc1_.ConfigValue.split("|");
            _maxBuyTime = _loc2_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc5_ = _loc2_[_loc3_];
               if(_loc5_.length >= 2)
               {
                  _loc4_ = _loc5_.split(",");
                  _configBuyDic[int(_loc4_[0])] = int(_loc4_[1]);
               }
               _loc3_++;
            }
         }
         MainToolBar.instance.switchToolsBarState(2);
         updateMatchState();
      }
      
      private function addEvent() : void
      {
         if(RoomManager.instance.roomInfo)
         {
            RoomManager.instance.roomInfo.addEventListener("ADD_PLAYER_ROOM",__addPlayerHandler);
            RoomManager.instance.roomInfo.addEventListener("REMOVE_PLAYER_ROOM",__removePlayerHandler);
            RoomManager.instance.roomInfo.addEventListener("room_HouseOwner_change",__houseOwnerChangeHandler);
            RoomManager.instance.roomInfo.addEventListener("ROOM_PLACE_STATE_CHANGE",__placeStateChangeHandler);
            RoomManager.instance.roomInfo.addEventListener("UPDATE_ROOM_BASE_DATA",updateMatchState);
         }
         NotificationManager.instance.addEventListener("theseuspvpDoubleMatchEvent",updateshowMatchView);
         NotificationManager.instance.addEventListener("theseusDoublepvpUserInfoEvent",userChangeHandler);
         _cancelBtn.addEventListener("click",cancelmatchHandler);
         _ready.addEventListener("click",readyHandler);
         _buyBtn.addEventListener("click",buyClickHandler);
         _cancelready.addEventListener("click",cancelreadyHandler);
         _matchBtn.addEventListener("click",matchHandler);
         _inviteBtn.addEventListener("click",_inviteClick);
         _jImg.addEventListener("click",useAddTimeHandler);
      }
      
      private function confirmChoose(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            TheseusPvpManager.Instance.doSomething1(15);
         }
      }
      
      private function buyClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc8_:String = null;
         var _loc5_:TheseusDoublePvpUserInfo = model1.selfUserInfo;
         var _loc7_:int = _loc5_.buyCount + 1;
         if(_configBuyDic[_loc7_])
         {
            _loc6_ = int(_configBuyDic[_loc7_]);
            if(_loc6_ > 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("theseuspvp.buyAlert",_loc6_,_maxBuyTime);
               SimpleAlertHelper.instance.data = [confirmChoose];
               _loc3_ = LanguageMgr.GetTranslation("public.confirm");
               _loc4_ = LanguageMgr.GetTranslation("public.cancel");
               _loc8_ = LanguageMgr.GetTranslation("public.prompt");
               SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc2_,_loc3_,_loc4_,true,true);
            }
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseuspvp.buyMax"));
         }
      }
      
      private function useAddTimeHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("theseuspvp","BUY_TIMEDOUBLE");
      }
      
      private function removeEvent() : void
      {
         if(RoomManager.instance.roomInfo)
         {
            RoomManager.instance.roomInfo.removeEventListener("ADD_PLAYER_ROOM",__addPlayerHandler);
            RoomManager.instance.roomInfo.removeEventListener("REMOVE_PLAYER_ROOM",__removePlayerHandler);
            RoomManager.instance.roomInfo.removeEventListener("room_HouseOwner_change",__houseOwnerChangeHandler);
            RoomManager.instance.roomInfo.removeEventListener("ROOM_PLACE_STATE_CHANGE",__placeStateChangeHandler);
            RoomManager.instance.roomInfo.removeEventListener("UPDATE_ROOM_BASE_DATA",updateMatchState);
         }
         NotificationManager.instance.removeEventListener("theseuspvpDoubleMatchEvent",updateshowMatchView);
         _jImg.removeEventListener("click",useAddTimeHandler);
         NotificationManager.instance.removeEventListener("theseusDoublepvpUserInfoEvent",userChangeHandler);
         _cancelBtn.removeEventListener("click",cancelmatchHandler);
         _ready.removeEventListener("click",readyHandler);
         _buyBtn.removeEventListener("click",buyClickHandler);
         _cancelready.removeEventListener("click",cancelreadyHandler);
         _matchBtn.removeEventListener("click",matchHandler);
         _inviteBtn.removeEventListener("click",_inviteClick);
      }
      
      private function cancelmatchHandler(param1:MouseEvent) : void
      {
         if(_roomInfo.houseOwnerId == ArmyManager.instance.thane.userId)
         {
            TheseusPvpManager.sendRoomState(1);
         }
         else
         {
            TheseusPvpManager.sendPlayerState(0);
         }
      }
      
      private function readyHandler(param1:MouseEvent) : void
      {
         TheseusPvpManager.sendPlayerState(1);
      }
      
      private function cancelreadyHandler(param1:MouseEvent) : void
      {
         TheseusPvpManager.sendPlayerState(0);
      }
      
      private function getIsNoGet() : Boolean
      {
         var _loc2_:Number = _currTimeDate.time / 1000 - playerModel.sysCurTimeBySecond;
         if(_loc2_ <= 0)
         {
            return false;
         }
         var _loc1_:TheseusDoublePvpUserInfo = modeldouble.selfUserInfo;
         var _loc3_:int = _loc1_.freeCount + _loc1_.addCount;
         if(_loc3_ <= 0)
         {
            return false;
         }
         return true;
      }
      
      private function userChangeHandler(param1:NotificationEvent) : void
      {
         updateInfos();
      }
      
      private function updateshowMatchView(param1:NotificationEvent) : void
      {
         var _loc2_:TheseusDoubleVsView = null;
         _loc2_ = new TheseusDoubleVsView();
         _loc2_.show();
         visible = false;
      }
      
      private function updateMatchState(param1:RoomEvent = null) : void
      {
         visible = true;
         if(model.houseOwnerId == ArmyManager.instance.thane.userId)
         {
            _cancelready.visible = _ready.visible = false;
            if(_roomInfo.roomState <= 1)
            {
               _buyBtn.visible = _bottomFreeTxt.visible = true;
               _matchBtn.visible = true;
               _cancelBtn.visible = false;
               _inviteBtn.visible = true;
               _macthMc.visible = false;
               _jImg.visible = true;
               _macthMc.stop();
               MainToolBar.instance.switchToolsBarState(4);
            }
            else if(_roomInfo.roomState == 2)
            {
               _buyBtn.visible = _bottomFreeTxt.visible = false;
               _jImg.visible = false;
               _matchBtn.visible = false;
               _cancelBtn.visible = true;
               _inviteBtn.visible = false;
               _macthMc.visible = true;
               _macthMc.gotoAndPlay(1);
               MainToolBar.instance.switchToolsBarState(3);
            }
         }
         else
         {
            _matchBtn.visible = _cancelBtn.visible = false;
            if(_roomInfo.roomState <= 1)
            {
               setNormalView();
               _buyBtn.visible = _bottomFreeTxt.visible = true;
               _inviteBtn.visible = true;
               _macthMc.visible = false;
               _jImg.visible = true;
               _macthMc.stop();
               MainToolBar.instance.switchToolsBarState(4);
            }
            else if(_roomInfo.roomState == 2)
            {
               _buyBtn.visible = _bottomFreeTxt.visible = false;
               _ready.visible = false;
               _cancelready.visible = false;
               _jImg.visible = false;
               _macthMc.visible = true;
               _inviteBtn.visible = false;
               _macthMc.gotoAndPlay(1);
               MainToolBar.instance.switchToolsBarState(3);
            }
         }
      }
      
      private function get slefArmy() : BaseArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get userId() : int
      {
         return slefArmy.userId;
      }
      
      private function setNormalView() : void
      {
         var _loc1_:CampaignArmy = model.getPlayerByUserId(userId,"");
         if(_loc1_ && _loc1_.roomState == 0)
         {
            _ready.enable = _ready.visible = true;
            _cancelready.visible = false;
         }
         else
         {
            _ready.visible = false;
            _cancelready.enable = true;
            _cancelready.visible = true;
         }
      }
      
      private function updateInfos() : void
      {
         var _loc1_:TheseusDoublePvpUserInfo = model1.selfUserInfo;
         var _loc2_:int = int(TempleteManager.instance.getConfigValue("theseus_multi_pvp_day_free_count"));
         var _loc3_:int = _loc1_.freeCount + _loc1_.addCount;
         if(_roomInfo.roomState <= 1)
         {
            _buyBtn.visible = true;
         }
         _bottomFreeTxt.text = LanguageMgr.GetTranslation("theseuspvp.leftTime",_loc3_);
      }
      
      private function _inviteClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:TheseusTeamInviteFrame = ComponentFactory.Instance.creatComponentByStylename("theseusdoublepvproom.invite.TheseusTeamInviteFrame");
         _loc2_.show();
      }
      
      private function matchHandler(param1:MouseEvent) : void
      {
         var _loc3_:Number = _currTimeDate.time / 1000 - playerModel.sysCurTimeBySecond;
         if(_loc3_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseuspvp.inCounting"));
            return;
         }
         var _loc2_:TheseusDoublePvpUserInfo = modeldouble.selfUserInfo;
         var _loc4_:int = _loc2_.freeCount + _loc2_.addCount;
         if(_loc4_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseuspvp.fightNeedGood"));
            return;
         }
         TheseusPvpManager.sendStartCampaignScene();
      }
      
      private function get modeldouble() : TheseusDoublePvpModel
      {
         return TheseusPvpManager.Instance.model1;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function refreshPlayerData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TheseusPlayerFigure = null;
         var _loc3_:CampaignArmy = null;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = _playerList[_loc1_] as TheseusPlayerFigure;
            _loc3_ = RoomManager.instance.roomInfo.getPlayerByPos(_loc1_);
            if(_loc3_)
            {
               showFigure(_loc3_);
            }
            _loc1_++;
         }
      }
      
      public function resize(param1:int, param2:int) : void
      {
         var _loc4_:Object = null;
         var _loc6_:int = 0;
         this.x = (param1 - this.width) * 0.5 - 210;
         var _loc3_:int = 1495;
         var _loc5_:int = 895;
         if(param2 < _loc5_ || param1 < _loc3_)
         {
            this.y = param2 - this.height - 258 + 40;
            _loc6_ = 0;
            while(_loc6_ < 4)
            {
               _loc4_ = _playerListPos[_playerList[_loc6_]];
               _loc4_.target.scaleX = 0.9;
               _loc4_.target.scaleY = 0.9;
               _loc4_.target.x = _loc6_ * 240 - 110;
               _loc6_++;
            }
         }
         else
         {
            this.y = param2 - this.height - 318 + 40;
            _loc6_ = 0;
            while(_loc6_ < 4)
            {
               _loc4_ = _playerListPos[_playerList[_loc6_]];
               _loc4_.target.scaleX = 1;
               _loc4_.target.scaleY = 1;
               _loc4_.target.x = _loc6_ * 300 - 230;
               _loc6_++;
            }
         }
      }
      
      private function getPoint() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Point = null;
         _pointArray = new Vector.<Point>();
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("room.PlayerFigure_" + _loc1_);
            _pointArray.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function __addPlayerHandler(param1:RoomEvent) : void
      {
         var _loc2_:CampaignArmy = param1.data as CampaignArmy;
         if(_loc2_)
         {
            showFigure(_loc2_);
         }
      }
      
      private function __removePlayerHandler(param1:RoomEvent) : void
      {
         var _loc2_:CampaignArmy = param1.data as CampaignArmy;
         if(_loc2_)
         {
            hideFigure(_loc2_);
         }
      }
      
      private function __houseOwnerChangeHandler(param1:RoomEvent) : void
      {
         for each(var _loc2_:TheseusPlayerFigure in _playerList)
         {
            _loc2_.updateOwnerState();
         }
      }
      
      private function __placeStateChangeHandler(param1:RoomEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TheseusPlayerFigure = null;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc3_ = _playerList[_loc2_] as TheseusPlayerFigure;
            _loc3_.placeState = model.placesState[_loc2_];
            _loc2_++;
         }
         setNormalView();
      }
      
      private function initPlayerList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TheseusPlayerFigure = null;
         _playerList = new Vector.<TheseusPlayerFigure>();
         if(!_roomInfo)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = new TheseusPlayerFigure();
            _loc2_.placeState = _roomInfo.placesState[_loc1_];
            _loc2_.index = _loc1_;
            if(_loc1_ == 1 || _loc1_ == 2)
            {
               _loc2_.y = -20;
            }
            else
            {
               _loc2_.y = 60;
            }
            _playerList.push(_loc2_);
            _playerListPos.add(_loc2_,{
               "x":_loc2_.x,
               "y":_loc2_.y,
               "width":_loc2_.width,
               "height":_loc2_.height,
               "target":_loc2_
            });
            _loc1_++;
         }
         addChild(_playerList[1]);
         addChild(_playerList[2]);
         addChild(_playerList[0]);
         addChild(_playerList[3]);
      }
      
      public function showFigure(param1:CampaignArmy) : void
      {
         for each(var _loc2_:TheseusPlayerFigure in _playerList)
         {
            if(_loc2_.index == param1.pos)
            {
               _loc2_.data = param1;
               break;
            }
         }
      }
      
      public function hideFigure(param1:CampaignArmy) : void
      {
         var _loc2_:TheseusPlayerFigure = _playerList[param1.pos] as TheseusPlayerFigure;
         _loc2_.data = null;
      }
      
      public function set model(param1:RoomInfo) : void
      {
         _roomInfo = param1;
      }
      
      private function get model1() : TheseusDoublePvpModel
      {
         return TheseusPvpManager.Instance.model1;
      }
      
      public function get model() : RoomInfo
      {
         return _roomInfo;
      }
      
      override public function dispose() : void
      {
         _playerListPos.clear();
         removeEvent();
         _pointArray = null;
         for each(var _loc1_:TheseusPlayerFigure in _playerList)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
            _loc1_ = null;
         }
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_inviteBtn);
         _inviteBtn = null;
         ObjectUtils.disposeObject(_matchBtn);
         _matchBtn = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_bottomFreeTxt);
         _bottomFreeTxt = null;
         ObjectUtils.disposeObject(_ready);
         _ready = null;
         ObjectUtils.disposeObject(_cancelready);
         _cancelready = null;
         _playerList = null;
         ObjectUtils.disposeViolentMc(_macthMc);
         _macthMc = null;
         ObjectUtils.disposeObject(_jImg);
         _jImg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

