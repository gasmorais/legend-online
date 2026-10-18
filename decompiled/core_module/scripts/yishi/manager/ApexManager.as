package yishi.manager
{
   import com.pickgliss.ui.ComponentFactory;
   import com.road.yishi.proto.apex.ApexBetMsg;
   import com.road.yishi.proto.apex.ApexBetPlayerListMsg;
   import com.road.yishi.proto.apex.ApexBetPlayerMsg;
   import com.road.yishi.proto.apex.ApexLastWinnerMsg;
   import com.road.yishi.proto.apex.ApexMainViewMsg;
   import com.road.yishi.proto.apex.ApexPlayerViewMsg;
   import com.road.yishi.proto.apex.ApexRankListMsg;
   import com.road.yishi.proto.apex.ApexResultMsg;
   import com.road.yishi.proto.apex.ApexStateMsg;
   import com.road.yishi.proto.apex.ApexTeamClientOpRespMsg;
   import com.road.yishi.proto.apex.ApexTeamMsg;
   import com.road.yishi.proto.player.CommonMsg;
   import com.road.yishi.proto.player.CommonMsgList;
   import events.ApexEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import mvc.module.apex.ApexBattleState;
   import mvc.module.apex.ApexBetData;
   import mvc.module.apex.ApexBetPlayerData;
   import mvc.module.apex.ApexModel;
   import mvc.module.apex.ApexPlayerViewData;
   import mvc.module.apex.ApexRankModel;
   import mvc.module.apex.ApexResultData;
   import mvc.module.apex.ApexState;
   import mvc.module.apex.ApexTeamData;
   import mvc.module.shop.ShopGoodsInfo;
   import tasktracetip.data.TipMessageData;
   import ui.toptoolbar.TopToolsBar;
   import yishi.actions.map.ApexReportAction;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DelayActionsUtils;
   import yishi.utils.HashMap;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.TimeOutInviteFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class ApexManager extends EventDispatcher
   {
      
      private static var _instance:ApexManager;
      
      private var _model:ApexModel;
      
      private var rankStart:Boolean = false;
      
      private var roomRankStart:Boolean = false;
      
      private var winnerStamp:int = -1;
      
      public function ApexManager()
      {
         super();
         _model = new ApexModel();
      }
      
      public static function get instance() : ApexManager
      {
         if(!_instance)
         {
            _instance = new ApexManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4684,receiveApexState);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4807,receiveApexResult);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4214,receiveApexRank);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4685,receiveApexMainView);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4688,receiveApexInBattleRank);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4682,receiveApexBetWinner);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4681,receiveApexBetInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4689,receiveApexBattleState);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 184,receiveApexSignInConfirm);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4683,receiveApexLastWinner);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 185,updateSignState);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 191,receiveTeamOp);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 528,shopBuyHandler);
      }
      
      private function shopBuyHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:ShopGoodsInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:CommonMsgList = new CommonMsgList();
         _loc2_ = _loc5_.readBody(_loc2_) as CommonMsgList;
         for each(var _loc3_:CommonMsg in _loc2_.list)
         {
            _loc4_ = getShopInfo(_loc3_.param1);
            if(_loc4_)
            {
               _loc4_.OneCurrentCount = _loc3_.param2;
            }
         }
      }
      
      private function getShopInfo(param1:int) : ShopGoodsInfo
      {
         var _loc4_:Dictionary = TempleteManager.instance.getApexShopTempInfoList();
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in _loc4_)
         {
            if(_loc3_.Id == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function receiveTeamOp(param1:SLGSocketEvent) : void
      {
         var _loc4_:ApexTeamData = null;
         var _loc3_:String = null;
         var _loc7_:TimeOutInviteFrame = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ApexTeamClientOpRespMsg = new ApexTeamClientOpRespMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ApexTeamClientOpRespMsg;
         if(!model.teams)
         {
            model.teams = new HashMap();
         }
         trace(_loc2_.optype);
         if(_loc2_.optype == 11)
         {
            _loc4_ = new ApexTeamData(_loc2_.team);
            model.myTeam = _loc4_;
            model.teams.put(_loc4_.teamId,_loc4_);
            sendEvent("REFRESH_APEX_TERM_DATA");
         }
         else if(_loc2_.optype == 12)
         {
            _loc4_ = new ApexTeamData(_loc2_.team);
            model.myTeam = _loc4_;
            model.teams.put(_loc4_.teamId,_loc4_);
            sendEvent("REFRESH_APEX_TERM_DATA");
         }
         else if(_loc2_.optype == 13)
         {
            _loc3_ = _loc2_.member.guildName;
            if(model.myTeam)
            {
               _loc3_ += LanguageMgr.GetTranslation("apex.team.str14");
            }
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("core.TimeOutInviteFrame");
            _loc7_.content = _loc3_;
            _loc7_.txt.multiline = true;
            _loc7_.txt.wordWrap = true;
            _loc7_.txt.height = 60;
            _loc7_.txt.y -= 10;
            _loc7_.titleText = LanguageMgr.GetTranslation("public.prompt");
            _loc7_.confirmCallBack = getInviteHandler;
            _loc7_.params = [_loc2_.member.userId];
            _loc7_.time = 10;
            _loc7_.show();
         }
         else if(_loc2_.optype == 14)
         {
            if(_loc2_.team.members.length)
            {
               _loc4_ = new ApexTeamData(_loc2_.team);
               model.teams.put(_loc4_.teamId,_loc4_);
               model.myTeam = _loc4_;
               if(!_loc4_.hasMember(ArmyManager.instance.thane.userId))
               {
                  model.myTeam = null;
                  model.myTeamPlayer = null;
                  model.curTeamMemNum = 0;
               }
            }
            else
            {
               model.teams.remove(_loc2_.team.teamId);
               if(model.myTeam && _loc2_.team.teamId == model.myTeam.teamId)
               {
                  model.myTeam = null;
                  model.myTeamPlayer = null;
                  model.curTeamMemNum = 0;
               }
            }
            sendEvent("REFRESH_APEX_TERM_DATA");
         }
         else if(_loc2_.optype == 15)
         {
            _loc4_ = new ApexTeamData(_loc2_.team);
            model.myTeam = _loc4_;
            model.teams.put(_loc4_.teamId,_loc4_);
            sendEvent("REFRESH_APEX_TERM_DATA");
         }
         else if(_loc2_.optype == 16)
         {
            model.teams.clear();
            model.teams = new HashMap();
            for each(var _loc5_:ApexTeamMsg in _loc2_.teams)
            {
               _loc4_ = new ApexTeamData(_loc5_);
               model.teams.put(_loc4_.teamId,_loc4_);
               if(_loc4_.isSelfTeam)
               {
                  model.myTeam = _loc4_;
               }
            }
            sendEvent("REFRESH_APEX_TERM_DATA");
         }
         else if(_loc2_.optype == 17)
         {
            _loc4_ = new ApexTeamData(_loc2_.team);
            if(_loc2_.team.members.length)
            {
               _loc4_ = new ApexTeamData(_loc2_.team);
               model.teams.put(_loc4_.teamId,_loc4_);
            }
            else
            {
               model.teams.remove(_loc2_.team.teamId);
            }
            sendEvent("REFRESH_APEX_TERM_DATA");
         }
      }
      
      private function getInviteHandler(param1:Boolean, param2:Array) : void
      {
         sendAgreeJoinTeam(param1,param2[0]);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function receiveApexState(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ApexStateMsg = new ApexStateMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ApexStateMsg;
         model.apexState = new ApexState(_loc2_);
         sendEvent("REFRESH_APEX_STATE");
         if(!(model.apexState.state == 1 && model.isSign))
         {
            TopToolsBar.instance.apexState = model.apexState.state;
         }
         if(model.apexState.state == 4)
         {
            showTip();
         }
      }
      
      public function showTip() : void
      {
         var _loc1_:TipMessageData = new TipMessageData();
         _loc1_.type = 57;
         _loc1_.title = LanguageMgr.GetTranslation("yishi.manager.BaseManager.tip.title");
         _loc1_.content = LanguageMgr.GetTranslation("apex.state.start");
         TaskTraceTipManager.instance.cleanByType(57);
         TaskTraceTipManager.instance.showView(_loc1_);
      }
      
      private function receiveApexResult(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ApexResultMsg = new ApexResultMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ApexResultMsg;
         model.apexResultData = new ApexResultData(_loc2_);
         DelayActionsUtils.instance.addAction(new ApexReportAction());
      }
      
      private function receiveApexRank(param1:SLGSocketEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ApexRankListMsg = new ApexRankListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ApexRankListMsg;
         if(rankStart == false)
         {
            rankStart = true;
            model.apexRankModel = new ApexRankModel(_loc2_);
         }
         else
         {
            model.apexRankModel.update(_loc2_);
         }
         _loc3_ = model.apexRankModel.flag;
         if(_loc3_)
         {
            rankStart = false;
            if(!FrameControllerManager.checkFrame("apexController","ApexRankFrame"))
            {
               FrameControllerManager.instance.openControllerByInfo("apex",5);
            }
         }
      }
      
      private function receiveApexMainView(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ApexMainViewMsg = new ApexMainViewMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ApexMainViewMsg;
         model.isSign = _loc2_.selfSignUp;
         if(_loc2_.hasCurTeamMemNum)
         {
            model.curTeamMemNum = _loc2_.curTeamMemNum;
         }
         if(TopToolsBar.instance.apexState == 1 && model.isSign)
         {
         }
         TopToolsBar.instance.apexState = model.apexState.state;
         var _loc4_:String = SceneManager.instance.currentType;
         var _loc3_:String = null;
         if(_loc4_ == "BATTLE_SCENE")
         {
            _loc3_ = LanguageMgr.GetTranslation("ChatOutputViewII.tip01");
         }
         else if(_loc4_ == "CAMPAIGN_MAP_SCENE")
         {
            _loc3_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip06");
         }
         if(_loc3_ != null)
         {
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(!FrameControllerManager.checkFrame("apexController","ApexHallFrame"))
         {
            FrameControllerManager.instance.openControllerByInfo("apex",1);
         }
         sendEvent("REFRESH_MAIN_VIEW");
      }
      
      private function sendEvent(param1:String, param2:* = null) : void
      {
         dispatchEvent(new ApexEvent(param1,param2));
      }
      
      private function receiveApexInBattleRank(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ApexRankListMsg = new ApexRankListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ApexRankListMsg;
         if(roomRankStart == false)
         {
            roomRankStart = true;
            model.apexRoomRankModel = new ApexRankModel(_loc2_);
         }
         else if(_loc2_.stamp > model.apexRoomRankModel.stamp)
         {
            model.apexRoomRankModel = new ApexRankModel(_loc2_);
         }
         else
         {
            model.apexRoomRankModel.update(_loc2_);
         }
         if(model.apexRoomRankModel.flag)
         {
            roomRankStart = false;
            sendEvent("REFRESH_APEX_BATTLE_RANK");
         }
      }
      
      private function receiveApexBetWinner(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ApexBetPlayerListMsg = new ApexBetPlayerListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ApexBetPlayerListMsg;
         if(winnerStamp != _loc2_.stamp)
         {
            model.betWinPlayers = [];
         }
         for each(var _loc3_:ApexBetPlayerMsg in _loc2_.list)
         {
            model.betWinPlayers.push(new ApexBetPlayerData(_loc3_));
         }
         if(_loc2_.page >= _loc2_.totalpage)
         {
            winnerStamp = 0;
            model.betWinPlayers.sortOn("order",16);
            FrameControllerManager.instance.openControllerByInfo("apex",6);
         }
      }
      
      private function receiveApexBetInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ApexBetMsg = new ApexBetMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ApexBetMsg;
         if(_loc2_ == null || _loc2_.rankList == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("apex.hall.cannotGuess2"));
            return;
         }
         model.apexBetData = new ApexBetData(_loc2_);
         if(FrameControllerManager.checkFrame("apexController","ApexGuessFrame"))
         {
            sendEvent("REFRESH_GUESS_STATE");
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("apex",2);
         }
      }
      
      private function receiveApexBattleState(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:CommonMsg = new CommonMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as CommonMsg;
         model.apexBattleState = new ApexBattleState(_loc2_);
         sendEvent("REFRESH_BATTLE_STATE");
      }
      
      private function receiveApexLastWinner(param1:SLGSocketEvent) : void
      {
         var _loc3_:ApexPlayerViewData = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ApexLastWinnerMsg = new ApexLastWinnerMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ApexLastWinnerMsg;
         model.lastWinnerPlayerList = new Vector.<ApexPlayerViewData>();
         if(_loc2_.list && _loc2_.list.length)
         {
            for each(var _loc4_:ApexPlayerViewMsg in _loc2_.list)
            {
               _loc3_ = new ApexPlayerViewData(_loc4_);
               model.lastWinnerPlayerList.push(_loc3_);
            }
         }
         while(model.lastWinnerPlayerList.length < 4)
         {
            model.lastWinnerPlayerList.push(null);
         }
         sendEvent("REFRESH_SPACE_AVATAR");
      }
      
      private function receiveApexSignInConfirm(param1:SLGSocketEvent) : void
      {
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:CommonMsg = new CommonMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as CommonMsg;
         var _loc3_:String = LanguageMgr.GetTranslation("apex.hall.invite",_loc2_.param4);
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc5_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [__requestFrameCloseHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc3_,_loc4_,_loc5_,false,false,false,1);
      }
      
      private function __requestFrameCloseHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            sendSignConfirm(true);
         }
         else
         {
            sendSignConfirm(false);
         }
      }
      
      public function clearRoomInfo() : void
      {
         roomRankStart = false;
      }
      
      private function updateSignState(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ApexMainViewMsg = new ApexMainViewMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ApexMainViewMsg;
         if(_loc2_.hasSelfSignUp)
         {
            model.isSign = _loc2_.selfSignUp;
         }
      }
      
      public function sendOpenMainView() : void
      {
         var _loc2_:PackageOut = new PackageOut(5439);
         var _loc1_:CommonMsg = new CommonMsg();
         _loc1_.param1 = 1;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendSign() : void
      {
         var _loc2_:PackageOut = new PackageOut(5439);
         var _loc1_:CommonMsg = new CommonMsg();
         _loc1_.param1 = 2;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendInRoom() : void
      {
         if(!_model.isOpen)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("apex.Error.str01"));
            return;
         }
         var _loc2_:PackageOut = new PackageOut(5439);
         var _loc1_:CommonMsg = new CommonMsg();
         _loc1_.param1 = 3;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendGetRank() : void
      {
         var _loc2_:PackageOut = new PackageOut(5439);
         var _loc1_:CommonMsg = new CommonMsg();
         _loc1_.param1 = 4;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendOpenGuess() : void
      {
         var _loc2_:PackageOut = new PackageOut(5439);
         var _loc1_:CommonMsg = new CommonMsg();
         _loc1_.param1 = 5;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendToGuess(param1:String, param2:Number) : void
      {
         var _loc4_:PackageOut = new PackageOut(5439);
         var _loc3_:CommonMsg = new CommonMsg();
         _loc3_.param1 = 6;
         _loc3_.param2 = param2;
         _loc3_.param4 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendGetTurn() : void
      {
         var _loc2_:PackageOut = new PackageOut(5439);
         var _loc1_:CommonMsg = new CommonMsg();
         _loc1_.param1 = 7;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendGetAwardList() : void
      {
         var _loc2_:PackageOut = new PackageOut(5439);
         var _loc1_:CommonMsg = new CommonMsg();
         _loc1_.param1 = 8;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendSignConfirm(param1:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(5439);
         var _loc2_:CommonMsg = new CommonMsg();
         _loc2_.param1 = 9;
         _loc2_.param2 = param1 ? 1 : 0;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendCreateTeam() : void
      {
         var _loc2_:PackageOut = new PackageOut(5439);
         var _loc1_:CommonMsg = new CommonMsg();
         _loc1_.param1 = 11;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendKickTeammate(param1:Number) : void
      {
         var _loc3_:PackageOut = new PackageOut(5439);
         var _loc2_:CommonMsg = new CommonMsg();
         _loc2_.param1 = 12;
         _loc2_.param2 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendInviteTeam(param1:Number) : void
      {
         var _loc3_:PackageOut = new PackageOut(5439);
         var _loc2_:CommonMsg = new CommonMsg();
         _loc2_.param1 = 13;
         _loc2_.param2 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendQuitTeam() : void
      {
         var _loc2_:PackageOut = new PackageOut(5439);
         var _loc1_:CommonMsg = new CommonMsg();
         _loc1_.param1 = 14;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendJoinTeam(param1:Number) : void
      {
         var _loc3_:PackageOut = new PackageOut(5439);
         var _loc2_:CommonMsg = new CommonMsg();
         _loc2_.param1 = 15;
         _loc2_.param2 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendGetAllTeamData() : void
      {
         var _loc2_:PackageOut = new PackageOut(5439);
         var _loc1_:CommonMsg = new CommonMsg();
         _loc1_.param1 = 16;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendAgreeJoinTeam(param1:Boolean, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(5439);
         var _loc3_:CommonMsg = new CommonMsg();
         _loc3_.param1 = 18;
         _loc3_.param2 = param2;
         _loc3_.param3 = param1 ? 1 : 0;
         if(param1)
         {
            if(thane.grades >= 80)
            {
               SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("apex.invite.View.needGrade"));
            }
         }
         else
         {
            SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
         }
      }
      
      public function get model() : ApexModel
      {
         return _model;
      }
      
      public function set model(param1:ApexModel) : void
      {
         _model = param1;
      }
   }
}

