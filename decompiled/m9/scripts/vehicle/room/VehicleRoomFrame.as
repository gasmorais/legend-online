package vehicle.room
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.SoundManager;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.view.frame.ArmyManageFrame;
   import mediator.RoomTimeMediator;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.room.RoomInfo;
   import room.net.RoomSocketOuterManager;
   import room.view.invite.RoomInviteFrame;
   import vehicle.room.view.VehiclePlayerFigure;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.BaseManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.RoomPasswordFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class VehicleRoomFrame extends Frame
   {
      
      private var _bg:Bitmap;
      
      private var _roomNameImg:Bitmap;
      
      private var _captainImg:Bitmap;
      
      private var _roomTxt:FilterFrameText;
      
      private var _captainTxt:FilterFrameText;
      
      private var _passwardBtn:SelectedIconButton;
      
      private var _inviteBtn:IconButton;
      
      private var _changeBtn:IconButton;
      
      private var _startBtn:IconButton;
      
      private var _readyBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _playerFigureArr:Array = [];
      
      private var _posArr:Array = [{
         "x":180,
         "y":255
      },{
         "x":318,
         "y":405
      },{
         "x":608,
         "y":405
      },{
         "x":737,
         "y":255
      }];
      
      private var _roomInfo:RoomInfo = RoomManager.instance.roomInfo;
      
      private var _playerInfo:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
      
      private var _hBox:HBox;
      
      private var _mediatorKey:String;
      
      public var mediatorname:String = "VehicleRoomFrame";
      
      private var _countBmp:Bitmap;
      
      private var _timer:Timer;
      
      private var _timeNumber:int;
      
      private var _timeTxt:GradientText;
      
      private var _frame:ArmyManageFrame;
      
      private var startDate:Date;
      
      private var endDate:Date;
      
      private var _daimonFrame:Frame;
      
      public function VehicleRoomFrame()
      {
         initStartEndDate();
         super();
         initView();
         addEvent();
         refresh();
         var _loc1_:Array = [RoomTimeMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,mediatorname);
         BaseManager.instance.existRoomInvate = true;
      }
      
      private function initStartEndDate() : void
      {
         var _loc1_:Array = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc2_:String = null;
         var _loc7_:Array = null;
         var _loc3_:Date = null;
         var _loc4_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("MatchOfVehicleTime");
         var _loc9_:Array = _loc4_.ConfigValue.split("|");
         startDate = new Date();
         endDate = new Date();
         for each(var _loc8_:String in _loc9_)
         {
            _loc1_ = _loc8_.split(",");
            _loc5_ = _loc1_[0];
            _loc6_ = _loc5_.split(":");
            startDate.time = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
            startDate.hours = parseInt(_loc6_[0]);
            startDate.minutes = parseInt(_loc6_[1]);
            startDate.seconds = 0;
            _loc2_ = _loc1_[1];
            _loc7_ = _loc2_.split(":");
            endDate.time = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
            endDate.hours = parseInt(_loc7_[0]);
            endDate.minutes = parseInt(_loc7_[1]);
            endDate.seconds = 0;
            _loc3_ = PlayerManager.instance.currentPlayerModel.sysCurtime;
            if(startDate.time <= _loc3_.time && _loc3_.time < endDate.time)
            {
               return;
            }
         }
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:VehiclePlayerFigure = null;
         var _loc2_:Object = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.vehicleroom.Bg");
         _roomNameImg = ComponentFactory.Instance.creatBitmap("asset.vehicleroom.TeamNum");
         _captainImg = ComponentFactory.Instance.creatBitmap("asset.vehicleroom.CaptainName");
         _roomTxt = ComponentFactory.Instance.creatComponentByStylename("VehicleRoom.TeamNumTxt");
         _captainTxt = ComponentFactory.Instance.creatComponentByStylename("VehicleRoom.CaptainNameTxt");
         _passwardBtn = ComponentFactory.Instance.creatComponentByStylename("room.roomRight.PveLockBtn");
         _passwardBtn.x = 28;
         _passwardBtn.y = 4;
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("VehicleRoom.InviteBtn");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("VehicleRoom.ChangeBtn");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("VehicleRoom.StartBtn");
         _readyBtn = ComponentFactory.Instance.creatComponentByStylename("VehicleRoom.ReadyBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("VehicleRoom.CancelBtn");
         _cancelBtn.visible = false;
         _passwardBtn.tipData = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.lockBtn.tipData");
         addToContent(_bg);
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = new VehiclePlayerFigure(_loc3_);
            _playerFigureArr.push(_loc1_);
            _loc2_ = _posArr[_loc3_];
            _loc1_.x = _loc2_.x;
            _loc1_.y = _loc2_.y;
            _loc3_++;
         }
         addToContent(_playerFigureArr[0]);
         addToContent(_playerFigureArr[3]);
         addToContent(_playerFigureArr[1]);
         addToContent(_playerFigureArr[2]);
         addToContent(_roomNameImg);
         addToContent(_captainImg);
         addToContent(_roomTxt);
         addToContent(_captainTxt);
         addToContent(_passwardBtn);
         addToContent(_inviteBtn);
         addToContent(_changeBtn);
         addToContent(_startBtn);
         addToContent(_readyBtn);
         addToContent(_cancelBtn);
         _startBtn.visible = isCaptain;
         _readyBtn.visible = !_startBtn.visible;
         setPasswordBtn();
         _timer = new Timer(1000);
         _timer.stop();
         _countBmp = ComponentFactory.Instance.creatBitmap("asset.daimontrial.CountTxt");
         _countBmp.x = 295;
         _countBmp.y = 90;
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("VehicleRoom.timeTxt");
         _timeTxt.x = 500;
         _timeTxt.y = 89;
         addToContent(_countBmp);
         addToContent(_timeTxt);
         _countBmp.visible = false;
         _timeTxt.visible = false;
         _timeTxt.text = "00:00";
         titleText = LanguageMgr.GetTranslation("vehicle.molishilian");
         if(_roomInfo)
         {
            _roomTxt.text = String(_roomInfo.id);
            update();
         }
      }
      
      private function unitView() : void
      {
         _roomNameImg = null;
         _captainImg = null;
         _roomTxt = null;
         _captainTxt = null;
         _passwardBtn = null;
         _inviteBtn = null;
         _changeBtn = null;
         _startBtn = null;
         _bg = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _passwardBtn.addEventListener("click",__passwardClickHandler);
         _inviteBtn.addEventListener("click",__inviteClickHandler);
         _changeBtn.addEventListener("click",__changeClickHandler);
         _startBtn.addEventListener("click",__startClickHandler);
         _readyBtn.addEventListener("click",__readyClickHandler);
         _cancelBtn.addEventListener("click",__cancelClickHandler);
         NotificationManager.instance.addEventListener("VEHICLE_ROOM_KILL_OUT",__kickOutHandler);
         if(_roomInfo)
         {
            _roomInfo.addEventListener("ADD_PLAYER_ROOM",__addPlayerHandler);
            _roomInfo.addEventListener("REMOVE_PLAYER_ROOM",__removePlayerHandler);
            _roomInfo.addEventListener("room_HouseOwner_change",__houseOwnerChangeHandler);
            _roomInfo.addEventListener("ROOM_PLACE_STATE_CHANGE",__placeStateChangeHandler);
            _roomInfo.addEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomInfoHanlder);
         }
         if(_timer)
         {
            _timer.addEventListener("timer",__onTimerHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _passwardBtn.removeEventListener("click",__passwardClickHandler);
         _inviteBtn.removeEventListener("click",__inviteClickHandler);
         _changeBtn.removeEventListener("click",__changeClickHandler);
         _startBtn.removeEventListener("click",__startClickHandler);
         _readyBtn.removeEventListener("click",__readyClickHandler);
         _cancelBtn.removeEventListener("click",__cancelClickHandler);
         NotificationManager.instance.removeEventListener("VEHICLE_ROOM_KILL_OUT",__kickOutHandler);
         if(_roomInfo)
         {
            _roomInfo.removeEventListener("ADD_PLAYER_ROOM",__addPlayerHandler);
            _roomInfo.removeEventListener("REMOVE_PLAYER_ROOM",__removePlayerHandler);
            _roomInfo.removeEventListener("room_HouseOwner_change",__houseOwnerChangeHandler);
            _roomInfo.removeEventListener("ROOM_PLACE_STATE_CHANGE",__placeStateChangeHandler);
            _roomInfo.removeEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomInfoHanlder);
         }
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimerHandler);
         }
      }
      
      private function __kickOutHandler(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(_roomInfo.roomState != 2)
               {
                  dispose();
               }
         }
      }
      
      private function __passwardClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         setPasswordBtn();
         var _loc2_:RoomPasswordFrame = ComponentFactory.Instance.creatComponentByStylename("core.RoomPasswordFrame");
         _loc2_.backCall = passwordInputBack;
         if(_roomInfo)
         {
            _loc2_.show(_roomInfo.id);
         }
         else
         {
            _loc2_.show(0);
         }
      }
      
      private function passwordInputBack(param1:int, param2:String) : void
      {
         if(isDie)
         {
            return;
         }
         if(_roomInfo)
         {
            RoomSocketOuterManager.sendLockCampaignRoom(_roomInfo.id,param2);
         }
      }
      
      private function __frameDispose(param1:Event) : void
      {
         _frame.removeEventListener("dispose",__frameDispose);
         _frame = null;
      }
      
      private function __inviteClickHandler(param1:MouseEvent) : void
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
      
      private function __changeClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_daimonFrame)
         {
            _daimonFrame.dispose();
         }
         _daimonFrame = FrameControllerManager.instance.vehicleDaimonController.openWithoutGroup();
      }
      
      private function __startClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_roomInfo.allPlayerReader)
         {
            return;
         }
         if(checkCanEnter())
         {
            _startBtn.visible = false;
            _readyBtn.visible = false;
            _cancelBtn.visible = true;
            RoomSocketOuterManager.sendStartCampaignScene(0,0,startFailBack);
         }
      }
      
      private function startFailBack() : void
      {
         _startBtn.visible = true;
         _readyBtn.visible = false;
         _cancelBtn.visible = false;
      }
      
      private function __readyClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(checkCanEnter())
         {
            RoomSocketOuterManager.sendPlayerState(1);
            _startBtn.visible = false;
            _readyBtn.visible = false;
            _cancelBtn.visible = true;
         }
      }
      
      private function checkCanEnter() : Boolean
      {
         var _loc2_:String = null;
         var _loc1_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         if(endDate.time - _loc1_.time < 300000)
         {
            _loc2_ = LanguageMgr.GetTranslation("CannotEnterVehicle");
            MessageTipManager.instance().show(_loc2_);
            return false;
         }
         return true;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __cancelClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_roomInfo.roomState == 2 && !isCaptain)
         {
            return;
         }
         if(_roomInfo.houseOwnerId == _playerInfo.userId)
         {
            RoomSocketOuterManager.sendRoomState(1);
         }
         else
         {
            RoomSocketOuterManager.sendPlayerState(0);
         }
         _startBtn.visible = isCaptain;
         _readyBtn.visible = !_startBtn.visible;
         _cancelBtn.visible = false;
      }
      
      private function __addPlayerHandler(param1:RoomEvent) : void
      {
         var _loc2_:VehiclePlayerFigure = null;
         update();
         var _loc3_:CampaignArmy = param1.data as CampaignArmy;
         if(_loc3_)
         {
            _loc2_ = _playerFigureArr[_loc3_.pos];
            if(_loc2_)
            {
               _loc2_.data = _loc3_;
            }
         }
      }
      
      private function __removePlayerHandler(param1:RoomEvent) : void
      {
         var _loc2_:VehiclePlayerFigure = null;
         update();
         var _loc3_:CampaignArmy = param1.data as CampaignArmy;
         if(_loc3_)
         {
            _loc2_ = _playerFigureArr[_loc3_.pos];
            if(_loc2_)
            {
               _loc2_.data = null;
            }
         }
      }
      
      private function __houseOwnerChangeHandler(param1:RoomEvent) : void
      {
         update();
         for each(var _loc2_:VehiclePlayerFigure in _playerFigureArr)
         {
            _loc2_.updateOwnerState();
         }
         if(isCaptain)
         {
            _startBtn.visible = true;
            _startBtn.enable = _roomInfo.allPlayerReader;
            _readyBtn.visible = false;
            _cancelBtn.visible = false;
         }
         else
         {
            _startBtn.visible = false;
            _readyBtn.visible = true;
            _cancelBtn.visible = false;
         }
      }
      
      private function __placeStateChangeHandler(param1:RoomEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:VehiclePlayerFigure = null;
         var _loc2_:Array = param1.data as Array;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _playerFigureArr[_loc4_];
            _loc3_.placeState = _loc2_[_loc4_];
            _loc4_++;
         }
      }
      
      private function __updateRoomInfoHanlder(param1:RoomEvent) : void
      {
         if(RoomManager.instance.exit)
         {
            dispose();
            return;
         }
         if(_roomInfo.roomState == 2)
         {
            startTime();
         }
         else
         {
            if(_roomInfo.roomState == 3)
            {
               if(_timer)
               {
                  _timer.reset();
                  _timer.stop();
               }
               return;
            }
            stopTime();
         }
         update();
         var _loc2_:CampaignArmy = _roomInfo.getPlayerByUserId(_playerInfo.userId);
         if(_loc2_ && _loc2_.roomState == 0)
         {
            _readyBtn.visible = true;
            _cancelBtn.visible = false;
         }
         else if(_loc2_ && _loc2_.roomState == 1)
         {
            _readyBtn.visible = false;
            _cancelBtn.visible = true;
         }
      }
      
      private function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc1_:VehiclePlayerFigure = null;
         var _loc2_:VehiclePlayerFigure = null;
         if(!_roomInfo)
         {
            return;
         }
         update();
         var _loc3_:int = int(_roomInfo.placesState.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = _playerFigureArr[_loc4_];
            _loc1_.placeState = _roomInfo.placesState[_loc4_];
            _loc4_++;
         }
         for each(var _loc5_:CampaignArmy in _roomInfo.playerList)
         {
            if(_loc5_)
            {
               _loc2_ = _playerFigureArr[_loc5_.pos];
               if(_loc2_)
               {
                  _loc2_.data = _loc5_;
               }
            }
         }
      }
      
      private function startTime() : void
      {
         if(_countBmp)
         {
            _countBmp.visible = true;
         }
         if(_timeTxt)
         {
            _timeTxt.visible = true;
            _timeTxt.text = "00:00";
         }
         if(_timer)
         {
            _timeNumber = 0;
            _timer.start();
         }
         if(_roomInfo.houseOwnerId != _playerInfo.userId)
         {
            _cancelBtn.enable = false;
         }
         if(closeButton)
         {
            closeButton.enable = false;
         }
         if(_inviteBtn)
         {
            _inviteBtn.enable = false;
         }
         if(_changeBtn)
         {
            _changeBtn.enable = false;
         }
         setPasswordBtn();
      }
      
      private function stopTime() : void
      {
         if(_timer)
         {
            _timeNumber = 0;
            _timer.stop();
         }
         if(_countBmp)
         {
            _countBmp.visible = false;
         }
         if(_timeTxt)
         {
            _timeTxt.visible = false;
            _timeTxt.text = "00:00";
         }
         _cancelBtn.enable = true;
         if(closeButton)
         {
            closeButton.enable = true;
         }
         if(_inviteBtn)
         {
            _inviteBtn.enable = true;
         }
         if(_changeBtn)
         {
            _changeBtn.enable = true;
         }
         setPasswordBtn();
      }
      
      private function __onTimerHandler(param1:TimerEvent = null) : void
      {
         var _loc2_:String = null;
         _timeNumber = _timeNumber + 1;
         _loc2_ = String(int(_timeNumber / 60) > 9 ? int(_timeNumber / 60) : "0" + int(_timeNumber / 60));
         _loc2_ += ":" + (String(int(_timeNumber % 60) > 9 ? int(_timeNumber % 60) : "0" + int(_timeNumber % 60)));
         _timeTxt.text = _loc2_;
      }
      
      private function update() : void
      {
         if(!_roomInfo)
         {
            return;
         }
         var _loc1_:CampaignArmy = _roomInfo.getPlayerByUserId(_roomInfo.houseOwnerId);
         if(_loc1_)
         {
            _captainTxt.text = _loc1_.baseHero.nickName;
         }
         setPasswordBtn();
         if(_roomInfo.houseOwnerId == _playerInfo.userId)
         {
            _startBtn.enable = _roomInfo.allPlayerReader;
            if(_roomInfo.roomState == 1)
            {
               startFailBack();
            }
         }
      }
      
      private function setPasswordBtn() : void
      {
         if(_passwardBtn && _roomInfo)
         {
            _passwardBtn.enable = isCaptain && _roomInfo.roomState != 2;
            _passwardBtn.selected = !!_roomInfo.password;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function exitRoom() : void
      {
         if(RoomManager.instance.exit)
         {
            return;
         }
         var _loc1_:int = 0;
         var _loc2_:BaseArmy = ArmyManager.instance.army;
         if(_loc2_)
         {
            _loc1_ = int(_loc2_.id);
         }
         CampaignSocketOutManager.instance.sendReturnCampaignRoom(_loc1_);
      }
      
      private function get isCaptain() : Boolean
      {
         if(_roomInfo)
         {
            return _playerInfo.userId == _roomInfo.houseOwnerId;
         }
         return false;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         BaseManager.instance.existRoomInvate = false;
         if(_daimonFrame)
         {
            _daimonFrame.dispose();
            _daimonFrame = null;
         }
         var _loc1_:RoomInfo = RoomManager.instance.roomInfo;
         if(_loc1_)
         {
            if(_loc1_.roomState == 3)
            {
               RoomManager.instance.dispose();
            }
            else
            {
               RoomManager.instance.dispose();
               exitRoom();
            }
         }
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         removeEvent();
         unitView();
         _playerInfo = null;
         _roomInfo = null;
         if(_frame)
         {
            _frame.dispose();
         }
         super.dispose();
         FrameControllerManager.instance.openControllerByInfo("vehicleroomlist");
      }
   }
}

