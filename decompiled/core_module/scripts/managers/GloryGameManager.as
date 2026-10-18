package managers
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.road.yishi.proto.Glory.GloryBetMsg;
   import com.road.yishi.proto.Glory.GloryMainViewMsg;
   import com.road.yishi.proto.Glory.GloryPlayerViewMsg;
   import com.road.yishi.proto.Glory.GloryScheduleMsg;
   import com.road.yishi.proto.Glory.PlayerBetMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import mvc.module.gloryGame.GloryGameBetInfo;
   import mvc.module.gloryGame.GloryGameModel;
   import mvc.module.gloryGame.GloryGameScheduleInfo;
   import mvc.module.gloryGame.GloryGameTeamPlayer;
   import mvc.module.gloryGame.event.GloryGameEvent;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.HashMap;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.TimeDownView;
   
   public class GloryGameManager extends EventDispatcher
   {
      
      private static var _instance:GloryGameManager;
      
      private var _model:GloryGameModel;
      
      public var isStarareaGame:Boolean = false;
      
      private var _timeDownView:TimeDownView;
      
      private var _alert:BaseAlerFrame;
      
      public function GloryGameManager()
      {
         super();
         _model = new GloryGameModel();
      }
      
      public static function get instance() : GloryGameManager
      {
         if(!_instance)
         {
            _instance = new GloryGameManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4990,receiveSignConfirm);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4991,receiveOpenView);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4992,receiveBetInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4993,receiveRoomUpdate);
      }
      
      private function receiveSignConfirm(param1:SLGSocketEvent) : void
      {
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as PropertyMsg;
         if(_timeDownView)
         {
            clearTimeDown();
         }
         if(_alert)
         {
            _alert.dispose();
         }
         var _loc3_:String = LanguageMgr.GetTranslation("SevenYearGloryGame.sign.confirm.hint",_loc2_.param4);
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc5_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [requestSignConfirm];
         _alert = SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc3_,_loc4_,_loc5_,false,false,false,1) as BaseAlerFrame;
         _timeDownView = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteTime");
         _timeDownView.timeCount = 10;
         _timeDownView.addEventListener("timerDown_complete",_timeCompleteHandler);
         _timeDownView.x = 148;
         _timeDownView.y = 75;
         _alert.addChild(_timeDownView);
      }
      
      private function _timeCompleteHandler(param1:Event) : void
      {
         clearTimeDown();
         _alert.dispose();
         sendSignComfirm(false);
      }
      
      private function clearTimeDown() : void
      {
         _timeDownView.removeEventListener("timerDown_complete",_timeCompleteHandler);
         _timeDownView.dispose();
      }
      
      private function requestSignConfirm(param1:Boolean, param2:Boolean) : void
      {
         sendSignComfirm(param1);
         clearTimeDown();
      }
      
      private function receiveOpenView(param1:SLGSocketEvent) : void
      {
         var _loc3_:GloryGameTeamPlayer = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:GloryMainViewMsg = new GloryMainViewMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as GloryMainViewMsg;
         model.isSelfSigned = _loc2_.selfSignUp;
         model.currentRound = _loc2_.state.split(",")[0];
         model.currentState = _loc2_.state.split(",")[1];
         model.currentTurn = _loc2_.state.split(",")[2];
         model.isOpen = _loc2_.state != "0,0,0";
         trace("当前状态",model.currentRound,model.currentState,model.currentTurn);
         if(_loc2_.player && _loc2_.player.length)
         {
            model.teamPlayers = [];
            for each(var _loc4_:GloryPlayerViewMsg in _loc2_.player)
            {
               _loc3_ = new GloryGameTeamPlayer(_loc4_);
               model.teamPlayers.push(_loc3_);
            }
         }
         sendEvent("VIEW_OPENED");
      }
      
      private function receiveRoomUpdate(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         model.currentTurn = _loc2_.param1;
         model.currentRound = _loc2_.param2;
         model.myScore = _loc2_.param3;
         model.myGroup = int(_loc2_.param4);
         model.myWin = int(_loc2_.param5);
         if(_loc2_.param7)
         {
            model.extraTimeParam = _loc2_.param7;
         }
         sendEvent("ROOM_UPDATE");
      }
      
      private function receiveBetInfo(param1:SLGSocketEvent) : void
      {
         var _loc7_:GloryGameScheduleInfo = null;
         var _loc5_:GloryGameBetInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:GloryBetMsg = new GloryBetMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as GloryBetMsg;
         if(_loc2_.allSchedule && _loc2_.allSchedule.length)
         {
            model.teamNameMap = new HashMap();
            model.scheduleInfos = [];
            for each(var _loc4_:GloryScheduleMsg in _loc2_.allSchedule)
            {
               _loc7_ = new GloryGameScheduleInfo(_loc4_);
               model.scheduleInfos.push(_loc7_);
               model.teamNameMap.put(_loc7_.teamUid1,_loc7_.teamName1);
               model.teamNameMap.put(_loc7_.teamUid2,_loc7_.teamName2);
            }
            sendEvent("SCHEDULE_INFO_UPDATE");
         }
         if(_loc2_.playerBet && _loc2_.playerBet.length)
         {
            model.myBetInfos = new HashMap();
            for each(var _loc3_:PlayerBetMsg in _loc2_.playerBet)
            {
               _loc5_ = new GloryGameBetInfo(_loc3_);
               model.myBetInfos.put(_loc5_.id,_loc5_);
            }
            sendEvent("BET_INFO_UPDATE");
         }
      }
      
      public function getSchedulesByRoundAndGroup(param1:int, param2:int) : Vector.<GloryGameScheduleInfo>
      {
         var _loc4_:Vector.<GloryGameScheduleInfo> = new Vector.<GloryGameScheduleInfo>();
         if(model.scheduleInfos)
         {
            for each(var _loc3_:GloryGameScheduleInfo in model.scheduleInfos)
            {
               if(_loc3_.round == param1 && _loc3_.group == param2)
               {
                  _loc4_.push(_loc3_);
               }
            }
         }
         return _loc4_;
      }
      
      public function getSchedulesByRound(param1:int) : Vector.<GloryGameScheduleInfo>
      {
         var temp:GloryGameScheduleInfo;
         var round:int = param1;
         var vec:Vector.<GloryGameScheduleInfo> = new Vector.<GloryGameScheduleInfo>();
         if(model.scheduleInfos)
         {
            for each(temp in model.scheduleInfos)
            {
               if(temp.round == round)
               {
                  vec.push(temp);
               }
            }
         }
         vec.sort(function(param1:GloryGameScheduleInfo, param2:GloryGameScheduleInfo):int
         {
            if(param1.group > param2.group)
            {
               return 1;
            }
            if(param1.group < param2.group)
            {
               return -1;
            }
            return 0;
         });
         return vec;
      }
      
      public function getNextSaturday(param1:int, param2:Boolean = false) : Date
      {
         var _loc9_:Date = SevenYearManager.instance.model.beginTime;
         var _loc7_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         _loc7_.hours = 0;
         _loc7_.minutes = 0;
         _loc7_.seconds = 0;
         var _loc3_:Number = _loc7_.time - (model.currentRound - 1) * 7 * 24 * 60 * 60 * 1000;
         if(_loc3_ > _loc9_.time)
         {
            _loc9_.time = _loc3_;
         }
         var _loc8_:int = 6 - _loc9_.day;
         var _loc5_:Date = new Date(_loc9_.time);
         _loc5_.hours = 0;
         _loc5_.minutes = 0;
         _loc5_.seconds = 0;
         var _loc4_:Number = 72000000;
         var _loc6_:Number = 71700000;
         if(param2)
         {
            _loc5_.time += (_loc8_ + (param1 - 1) * 7) * 24 * 3600 * 1000 + _loc6_;
         }
         else
         {
            _loc5_.time += (_loc8_ + (param1 - 1) * 7) * 24 * 3600 * 1000 + _loc4_;
         }
         return _loc5_;
      }
      
      public function getBattleTimeByRoundAndGroup(param1:int, param2:int = 1, param3:int = -1) : Date
      {
         var _loc4_:Date = null;
         var _loc5_:Vector.<GloryGameScheduleInfo> = getSchedulesByRoundAndGroup(param1,param2);
         if(param1 == 3 || param1 == 4)
         {
            _loc4_ = getNextSaturday(param1);
            if(param3 == -1)
            {
               _loc4_.time += (param2 - 1) * 9 * 60 * 1000;
            }
            else
            {
               _loc4_.time += param3 * 3 * 60 * 1000;
            }
         }
         else if(param1 == 5)
         {
            _loc4_ = getNextSaturday(param1 - 1);
            _loc4_.time = _loc4_.time + 1800000;
            if(param3 != -1)
            {
               _loc4_.time += param3 * 3 * 60 * 1000;
            }
         }
         else if(param1 == 1)
         {
            _loc4_ = getNextSaturday(param1);
            _loc4_.time = _loc4_.time + param2 * 3 * 60 * 1000;
         }
         else
         {
            _loc4_ = getNextSaturday(param1);
            if(param3 != -1)
            {
               _loc4_.time += param3 * 3 * 60 * 1000;
            }
         }
         return _loc4_;
      }
      
      public function get myNextBattleTime() : Date
      {
         var _loc1_:Date = null;
         var _loc2_:int = 0;
         if(model.currentRound == 1)
         {
            if(model.currentState <= 4)
            {
               _loc1_ = GloryGameManager.instance.getBattleTimeByRoundAndGroup(model.currentRound,model.currentTurn);
            }
            else
            {
               _loc1_ = GloryGameManager.instance.getBattleTimeByRoundAndGroup(model.currentRound + 1,model.currentTurn);
            }
         }
         else if(model.currentRound == 2)
         {
            _loc1_ = GloryGameManager.instance.getBattleTimeByRoundAndGroup(model.currentRound,model.currentTurn,model.currentTurn);
         }
         else
         {
            _loc2_ = Math.max(model.currentTurn,(model.myGroup - 1) * 3);
            _loc1_ = GloryGameManager.instance.getBattleTimeByRoundAndGroup(model.currentRound,model.currentTurn,_loc2_);
         }
         return _loc1_;
      }
      
      public function get nextBattleTime() : Date
      {
         var _loc1_:Date = null;
         var _loc2_:int = 0;
         if(model.currentRound == 1)
         {
            _loc1_ = GloryGameManager.instance.getBattleTimeByRoundAndGroup(model.currentRound,model.currentTurn);
         }
         else
         {
            _loc2_ = model.currentRound;
            if(model.currentState >= 5)
            {
               _loc2_ += 1;
            }
            _loc1_ = GloryGameManager.instance.getBattleTimeByRoundAndGroup(_loc2_,model.currentTurn,model.currentTurn);
         }
         return _loc1_;
      }
      
      public function exit() : void
      {
         sendLeaveRoom();
      }
      
      public function sendEvent(param1:String, param2:* = null) : void
      {
         dispatchEvent(new GloryGameEvent(param1,param2));
      }
      
      public function sendOpenView() : void
      {
         var _loc2_:PackageOut = new PackageOut(9694);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = 1;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendSign() : void
      {
         var _loc2_:PackageOut = new PackageOut(9694);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = 2;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendEnterRoom() : void
      {
         var _loc2_:PackageOut = new PackageOut(9694);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = 3;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendOpenBet() : void
      {
         var _loc2_:PackageOut = new PackageOut(9694);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = 4;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendSignComfirm(param1:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(9694);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 5;
         _loc2_.param7 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendLeaveRoom() : void
      {
         var _loc2_:PackageOut = new PackageOut(9694);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = 6;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendBet(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(9699);
         var _loc2_:GloryBetMsg = new GloryBetMsg();
         _loc2_.playerBet = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function get model() : GloryGameModel
      {
         return _model;
      }
      
      public function set model(param1:GloryGameModel) : void
      {
         _model = param1;
      }
   }
}

