package room.view.pvp
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import map.campaign.data.CampaignArmy;
   import mediator.RoomTimeMediator;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.room.RoomInfo;
   import room.loader.BackgroundLoader;
   import room.net.RoomSocketOuterManager;
   import room.view.invite.RoomInviteFrame;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.view.RoomPasswordFrame;
   import yishi.view.component.MovieButton;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class PVPRoomRightView extends Sprite implements Disposeable
   {
      
      public static const NAME:String = "room.view.pvp.PVPRoomRightView";
      
      private const PLAYER_COUNT:int = 4;
      
      private var _model:RoomInfo;
      
      private var _bg:Sprite;
      
      private var _lockBtn:SelectedIconButton;
      
      private var _startBtn:MovieButton;
      
      private var _inviteBtn:BaseButton;
      
      private var _sortBtn:BaseButton;
      
      private var _readyBtn:MovieButton;
      
      private var _cancelBtn:MovieButton;
      
      private var _titleTxt:FilterFrameText;
      
      private var _roomNumberTxt:FilterFrameText;
      
      private var _peopleNumberTxt:FilterFrameText;
      
      private var _timeBG:Bitmap;
      
      private var _timeFont:Bitmap;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timeNumber:int;
      
      private var _timer:Timer;
      
      private var _nodeSprite:Sprite;
      
      private var _mediatorKey:String;
      
      private var _enterTimeBg:Bitmap;
      
      private var _enterTimedes:Bitmap;
      
      private var _enterTimeTxt:FilterFrameText;
      
      private var _preClickTime:Number;
      
      private var _canCancel:Boolean;
      
      public function PVPRoomRightView()
      {
         super();
         initView();
         initEvents();
         var _loc1_:Array = [RoomTimeMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"room.view.pvp.PVPRoomRightView");
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatCustomObject("asset.roomPVP.RoomRightBG");
         _lockBtn = ComponentFactory.Instance.creatComponentByStylename("roomPVP.roomRight.PvpLockBtn");
         _startBtn = ComponentFactory.Instance.creatCustomObject("roomPVP.roomRight.StartBtn");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("roomPVP.roomRight.InviteBtn");
         _sortBtn = ComponentFactory.Instance.creatComponentByStylename("roomPVP.roomRight.TeamSortBtn");
         _readyBtn = ComponentFactory.Instance.creatCustomObject("roomPVP.roomRight.ReadyBtn");
         _cancelBtn = ComponentFactory.Instance.creatCustomObject("roomPVP.roomRight.CancelBtn");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("roomPVP.roomRight.titleTxt");
         _titleTxt.text = LanguageMgr.GetTranslation("room.view.pvp.PVPRoomRightView.title");
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.roomPVP.RoomNumberFont");
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.roomPVP.playerNumberFont");
         _roomNumberTxt = ComponentFactory.Instance.creatComponentByStylename("roomPVP.roomRight.roomNumber");
         _peopleNumberTxt = ComponentFactory.Instance.creatComponentByStylename("roomPVP.roomRight.roomPeopleNumber");
         _nodeSprite = ComponentFactory.Instance.creatCustomObject("roomPVP.NodeSp");
         _timeBG = ComponentFactory.Instance.creatBitmap("asset.roomPVP.timeBG");
         _timeFont = ComponentFactory.Instance.creatBitmap("asset.roomPVP.timeFontBG");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("roomPVP.roomRight.timeTxt");
         _enterTimeBg = ComponentFactory.Instance.creatBitmap("asset.water.Expback");
         _enterTimedes = ComponentFactory.Instance.creatBitmap("asset.pvproomlist.TimeLeftBMD");
         _enterTimeTxt = ComponentFactory.Instance.creatComponentByStylename("room.roomRight.EnterTimeRecord");
         _enterTimeTxt.y = 477;
         addChild(_bg);
         addChild(_lockBtn);
         addChild(_loc1_);
         addChild(_loc2_);
         addChild(_nodeSprite);
         addChild(_timeBG);
         _timeBG.visible = false;
         addChild(_timeFont);
         _timeFont.visible = false;
         addChild(_timeTxt);
         _timeTxt.visible = false;
         addChild(_startBtn);
         addChild(_inviteBtn);
         addChild(_sortBtn);
         addChild(_readyBtn);
         _readyBtn.visible = false;
         addChild(_cancelBtn);
         _cancelBtn.visible = false;
         addChild(_roomNumberTxt);
         _roomNumberTxt.text = "565";
         addChild(_peopleNumberTxt);
         _peopleNumberTxt.text = "3 / 5";
         addChild(_enterTimeBg);
         _enterTimeBg.x = -3;
         _enterTimeBg.y = 451;
         addChild(_enterTimedes);
         _enterTimedes.y = 478;
         addChild(_enterTimeTxt);
         _enterTimeTxt.text = PlayerManager.instance.currentPlayerModel.playerInfo.JJCcount + " / " + PlayerManager.instance.currentPlayerModel.playerInfo.JJCMaxCount;
         _inviteBtn.enable = false;
         _timer = new Timer(1000);
         _timer.stop();
         _lockBtn.tipData = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.lockBtn.tipData");
         __loadNodeBitmap();
      }
      
      private function initEvents() : void
      {
         _lockBtn.addEventListener("click",__lockHandler);
         _startBtn.addEventListener("click",_startClick);
         _inviteBtn.addEventListener("click",_inviteClick);
         _sortBtn.addEventListener("click",__teamSortClick);
         _readyBtn.addEventListener("click",_readyClick);
         _cancelBtn.addEventListener("click",_cancelClick);
         _timer.addEventListener("timer",__timerHandler);
      }
      
      private function removeEvents() : void
      {
         _lockBtn.removeEventListener("click",__lockHandler);
         _startBtn.removeEventListener("click",_startClick);
         _inviteBtn.removeEventListener("click",_inviteClick);
         _sortBtn.removeEventListener("click",__teamSortClick);
         _readyBtn.removeEventListener("click",_readyClick);
         _cancelBtn.removeEventListener("click",_cancelClick);
         _timer.removeEventListener("timer",__timerHandler);
         _model.removeEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomInfoHanlder);
         _model.removeEventListener("UPDATE_ROOM_PLAYER_DATA",__updateRoomInfoHanlder);
         _model.removeEventListener("ADD_PLAYER_ROOM",__updateRoomInfoHanlder);
         _model.removeEventListener("REMOVE_PLAYER_ROOM",__updateRoomInfoHanlder);
         _model.removeEventListener("room_HouseOwner_change",__roomOwnerChangeHandler);
      }
      
      private function __roomOwnerChangeHandler(param1:RoomEvent) : void
      {
         MainToolBar.instance.switchToolsBarState(2);
      }
      
      private function __loadNodeBitmap() : void
      {
         new BackgroundLoader().loadByUrl(PathManager.mapPVProomIconPath(),__drawNote);
      }
      
      private function __drawNote(param1:BitmapData) : void
      {
         var _loc2_:Bitmap = new Bitmap(param1);
         _nodeSprite.addChild(_loc2_);
      }
      
      private function get userId() : int
      {
         return slefArmy.userId;
      }
      
      private function __updateRoomInfoHanlder(param1:RoomEvent) : void
      {
         if(_model.roomState == 2)
         {
            __startTime();
            _inviteBtn.enable = false;
            _sortBtn.enable = false;
         }
         else
         {
            __stopTime();
            _inviteBtn.enable = true;
            _sortBtn.enable = true;
         }
         _roomNumberTxt.text = String(_model.id);
         _peopleNumberTxt.text = _model.curCount + " / " + 4;
         if(model.houseOwnerId == userId)
         {
            setHouseOwnerView();
         }
         else
         {
            setNormalView();
         }
         if(_startBtn.visible || Boolean(_readyBtn.visible))
         {
            ResourcesBar.instance.armyBtnEnable(true);
         }
      }
      
      private function get inviteEnable() : Boolean
      {
         if(_model.capacity <= 1 || _model.houseOwnerId != userId || !_startBtn.visible)
         {
            return false;
         }
         return true;
      }
      
      private function setNormalView() : void
      {
         var _loc1_:CampaignArmy = _model.getPlayerByUserId(userId,"");
         _startBtn.visible = false;
         _lockBtn.enable = false;
         _lockBtn.selected = !!_model.password;
         if(_loc1_ && _loc1_.roomState == 0)
         {
            _readyBtn.enable = _readyBtn.visible = true;
            _cancelBtn.visible = false;
            MainToolBar.instance.switchToolsBarState(2);
         }
         else
         {
            _readyBtn.visible = false;
            _cancelBtn.enable = _canCancel;
            _cancelBtn.visible = true;
            MainToolBar.instance.switchToolsBarState(1);
         }
      }
      
      private function setHouseOwnerView() : void
      {
         _lockBtn.enable = true;
         _readyBtn.visible = false;
         _cancelBtn.visible = false;
         _startBtn.visible = true;
         _lockBtn.selected = !!_model.password;
         _startBtn.enable = _model.allPlayerReader;
         if(_model.roomState == 2)
         {
            _startBtn.visible = false;
            _lockBtn.enable = false;
            _cancelBtn.enable = _cancelBtn.visible = true;
            ResourcesBar.instance.armyBtnEnable(false);
            LayerManager.Instance.clearnGameDynamic();
            MainToolBar.instance.switchToolsBarState(1);
         }
         else
         {
            ResourcesBar.instance.armyBtnEnable(true);
            MainToolBar.instance.switchToolsBarState(2);
         }
      }
      
      private function __lockHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _lockBtn.selected = !!_model.password;
         var _loc2_:RoomPasswordFrame = ComponentFactory.Instance.creatComponentByStylename("core.RoomPasswordFrame");
         _loc2_.backCall = passwordInputBack;
         _loc2_.show(_model.id);
      }
      
      private function passwordInputBack(param1:int, param2:String) : void
      {
         RoomSocketOuterManager.sendLockCampaignRoom(param1,param2);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function _startClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc9_:String = null;
         var _loc4_:String = null;
         var _loc10_:TodayNotAlertFrame = null;
         SoundManager.instance.play("016",true);
         if(!playerInfo.isPVPStart)
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.pvp.RoomRightView.IsOver");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc6_:Number = getTimer();
         if(_loc6_ - _preClickTime < 2000)
         {
            _loc2_ = LanguageMgr.GetTranslation("activity.view.ActivityItem.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _preClickTime = _loc6_;
         if(showThewAlert(startAlertback))
         {
            return;
         }
         var _loc8_:Boolean = Boolean(SharedManager.instance.getProperty("PVP_ALERT_SIGN"));
         var _loc7_:Date = SharedManager.instance.getProperty("PVP_CHECK_DATE") as Date;
         var _loc5_:Date = new Date();
         var _loc3_:Boolean = false;
         if(!_loc8_ || _loc7_ && _loc7_.month <= _loc5_.month && _loc7_.date < _loc5_.date)
         {
            _loc3_ = true;
         }
         if(_model.playerCount < 4 && _loc3_)
         {
            _loc9_ = LanguageMgr.GetTranslation("room.view.pvp.RoomRightView.noEnoughPeople");
            _loc4_ = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
            _loc10_ = ComponentFactory.Instance.creatComponentByStylename("pvp.noEnoughPeople.AlertFrame");
            _loc10_.show(_loc9_,_loc4_,noEnoughPeopleBack,null,"center");
            return;
         }
         start();
      }
      
      private function noEnoughPeopleBack(param1:Boolean) : void
      {
         var _loc2_:Date = new Date();
         SharedManager.instance.setProperty("PVP_ALERT_SIGN",param1,"PVP_CHECK_DATE",_loc2_);
         start();
      }
      
      private function readState(param1:Boolean) : void
      {
         SharedManager.instance.thewCheck = param1;
         SharedManager.instance.thewCheckDate = new Date();
         SharedManager.instance.saveThewCheck();
         _startBtn.enable = false;
         MainToolBar.instance.switchToolsBarState(1);
      }
      
      private function start() : void
      {
         RoomSocketOuterManager.sendStartCampaignScene(0,0,sendCmdCallback);
      }
      
      private function sendCmdCallback() : void
      {
      }
      
      private function startAlertback(param1:Boolean) : void
      {
         readState(param1);
         start();
      }
      
      private function get selfArmyId() : int
      {
         return ArmyManager.instance.army.id;
      }
      
      private function get armyPawns() : Boolean
      {
         if(slefArmy)
         {
            if(slefArmy.countAllArmyPawnNmber() > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      private function get slefArmy() : BaseArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function _inviteClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(!RoomManager.instance.roomInfo.existEmptyPos())
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc3_:RoomInviteFrame = ComponentFactory.Instance.creatComponentByStylename("room.RoomInviteFrame");
         _loc3_.show(1);
      }
      
      private function __teamSortClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("teammanager");
      }
      
      private function _readyClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("016",true);
         if(!playerInfo.isPVPStart)
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.pvp.RoomRightView.IsOver");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(showThewAlert(readyAlertBack))
         {
            return;
         }
         sendReady();
      }
      
      private function readyAlertBack(param1:Boolean) : void
      {
         readState(param1);
         sendReady();
      }
      
      private function sendReady() : void
      {
         RoomSocketOuterManager.sendPlayerState(1);
         _readyBtn.enable = false;
         ResourcesBar.instance.armyBtnEnable(false);
         MainToolBar.instance.switchToolsBarState(1);
         LayerManager.Instance.clearnGameDynamic();
         if(_model.houseOwnerId == userId)
         {
            ResourcesBar.instance.armyBtnEnable(false);
         }
      }
      
      private function showThewAlert(param1:Function = null) : Boolean
      {
         var _loc9_:TodayNotAlertFrame = null;
         var _loc8_:String = null;
         var _loc3_:String = null;
         var _loc4_:Boolean = PlayerManager.instance.currentPlayerModel.playerInfo.JJCcount < 1;
         var _loc5_:Date = SharedManager.instance.thewCheckDate;
         var _loc6_:Date = new Date();
         var _loc2_:Boolean = false;
         var _loc7_:Boolean = Boolean(SharedManager.instance.thewCheck);
         if(!_loc7_ || _loc5_.month <= _loc5_.month && _loc5_.date < _loc6_.date)
         {
            _loc2_ = true;
         }
         if(_loc4_ && _loc2_)
         {
            _loc9_ = ComponentFactory.Instance.creatComponentByStylename("core.TodayNotAlertFrame");
            _loc8_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist03");
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc9_.containerY = 20;
            _loc9_.show(_loc8_,_loc3_,param1);
         }
         return _loc4_ && _loc2_;
      }
      
      private function _cancelClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("016",true);
         if(_model.houseOwnerId == userId)
         {
            RoomSocketOuterManager.sendRoomState(1);
            ResourcesBar.instance.armyBtnEnable(true);
         }
         else
         {
            RoomSocketOuterManager.sendPlayerState(0);
         }
         _cancelBtn.enable = false;
         _startBtn.visible = true;
         _startBtn.enable = true;
         _cancelBtn.visible = false;
         MainToolBar.instance.switchToolsBarState(2);
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         _timeNumber = _timeNumber + 1;
         _loc2_ = String(int(_timeNumber / 60) > 9 ? int(_timeNumber / 60) : "0" + int(_timeNumber / 60));
         _loc2_ += ":" + (String(int(_timeNumber % 60) > 9 ? int(_timeNumber % 60) : "0" + int(_timeNumber % 60)));
         _timeTxt.text = _loc2_;
         if(_timeNumber == 20)
         {
            _canCancel = true;
            _cancelBtn.enable = true;
         }
      }
      
      private function __startTime() : void
      {
         _timeBG.visible = true;
         _timeFont.visible = true;
         _timeTxt.visible = true;
         _timeTxt.text = "00:00";
         _timeNumber = 0;
         _timer.reset();
         _timer.start();
         _canCancel = false;
      }
      
      private function __stopTime() : void
      {
         _timeBG.visible = false;
         _timeFont.visible = false;
         _timeTxt.visible = false;
         _timer.stop();
         _canCancel = true;
      }
      
      public function set model(param1:RoomInfo) : void
      {
         _model = param1;
         _model.addEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomInfoHanlder);
         _model.addEventListener("UPDATE_ROOM_PLAYER_DATA",__updateRoomInfoHanlder);
         _model.addEventListener("ADD_PLAYER_ROOM",__updateRoomInfoHanlder);
         _model.addEventListener("REMOVE_PLAYER_ROOM",__updateRoomInfoHanlder);
         _model.addEventListener("room_HouseOwner_change",__roomOwnerChangeHandler);
         __updateRoomInfoHanlder(null);
      }
      
      public function get model() : RoomInfo
      {
         return _model;
      }
      
      public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         removeEvents();
         if(_timer)
         {
            _timer.stop();
         }
         _timer = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_startBtn)
         {
            ObjectUtils.disposeObject(_startBtn);
         }
         _startBtn = null;
         if(_inviteBtn)
         {
            ObjectUtils.disposeObject(_inviteBtn);
         }
         _inviteBtn = null;
         if(_sortBtn)
         {
            ObjectUtils.disposeObject(_sortBtn);
         }
         _sortBtn = null;
         if(_readyBtn)
         {
            ObjectUtils.disposeObject(_readyBtn);
         }
         _readyBtn = null;
         if(_cancelBtn)
         {
            ObjectUtils.disposeObject(_cancelBtn);
         }
         _cancelBtn = null;
         if(_titleTxt)
         {
            ObjectUtils.disposeObject(_titleTxt);
         }
         _titleTxt = null;
         if(_roomNumberTxt)
         {
            ObjectUtils.disposeObject(_roomNumberTxt);
         }
         _roomNumberTxt = null;
         if(_peopleNumberTxt)
         {
            ObjectUtils.disposeObject(_peopleNumberTxt);
         }
         _peopleNumberTxt = null;
         if(_timeBG)
         {
            ObjectUtils.disposeObject(_timeBG);
         }
         _timeBG = null;
         if(_timeFont)
         {
            ObjectUtils.disposeObject(_timeFont);
         }
         _timeFont = null;
         if(_timeTxt)
         {
            ObjectUtils.disposeObject(_timeTxt);
         }
         _timeTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         MainToolBar.instance.switchToolsBarState(2);
      }
   }
}

