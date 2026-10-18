package yishi.manager
{
   import com.netease.protobuf.Message;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.road.yishi.proto.crisis.CrisisEventCount;
   import com.road.yishi.proto.crisis.CrisisEventCountMsg;
   import com.road.yishi.proto.crisis.CrisisGameEndMsg;
   import com.road.yishi.proto.crisis.CrisisGameStartMsg;
   import com.road.yishi.proto.crisis.CrisisInfoMsg;
   import com.road.yishi.proto.crisis.CrisisItemMsg;
   import com.road.yishi.proto.crisis.CrisisNodeInfo;
   import com.road.yishi.proto.crisis.CrisisOpMsg;
   import com.road.yishi.proto.crisis.CrisisPlayerInfo;
   import com.road.yishi.proto.crisis.CrisisPlayerMsg;
   import com.road.yishi.proto.room.RoomPlayerMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import mvc.module.crisis.PlaneCrisisArmy;
   import mvc.module.crisis.PlaneCrisisCountInfo;
   import mvc.module.crisis.PlaneCrisisEventType;
   import mvc.module.crisis.PlaneCrisisGameOverPlayInfo;
   import mvc.module.crisis.PlaneCrisisModel;
   import mvc.module.crisis.PlaneCrisisNodeInfo;
   import mvc.module.crisis.PlaneCrisisPlayerInfo;
   import yishi.SwitchPageHelp;
   import yishi.actions.base.AlertTipAction;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DelayActionsUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class PlaneCrisisManager
   {
      
      private static var _instance:PlaneCrisisManager;
      
      private var _model:PlaneCrisisModel;
      
      public var exit:Boolean;
      
      public var endBossNodeId:int = -1;
      
      public function PlaneCrisisManager()
      {
         super();
      }
      
      public static function get Instance() : PlaneCrisisManager
      {
         if(_instance == null)
         {
            _instance = new PlaneCrisisManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4873,__enterGameHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4867,__gameStartHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4868,__updateGameInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4870,__exitGameHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4871,__attackBossHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4872,_moveHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4869,__gameEndHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4876,__moveMapHandler);
      }
      
      private function __moveMapHandler(param1:SLGSocketEvent) : void
      {
         if(_model == null)
         {
            return;
         }
         _model.transMoveMap();
      }
      
      private function __enterGameHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PropertyMsg;
         var _loc4_:int = _loc2_.param1;
         var _loc3_:String = "";
         if(_loc4_ == 1)
         {
            _loc3_ = LanguageMgr.GetTranslation("planeCrisis.DiffName1");
         }
         else if(_loc4_ == 2)
         {
            _loc3_ = LanguageMgr.GetTranslation("planeCrisis.DiffName2");
         }
         var _loc6_:Frame = ComponentFactory.Instance.creatComponentByStylename("ui.planeCrisis.PlaneCrisisEnterConformFrame");
         _loc6_["show"](_loc3_);
      }
      
      private function __gameStartHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PlaneCrisisCountInfo = null;
         initModel();
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:CrisisGameStartMsg = new CrisisGameStartMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as CrisisGameStartMsg;
         _model.currMapId = _loc2_.mapId;
         _model.attackEndBossNeedNum = _loc2_.needCrystal;
         _model.difficulty = _loc2_.difficulty;
         for each(var _loc5_:CrisisPlayerMsg in _loc2_.players)
         {
            readPlayerInfos(_loc5_);
         }
         for each(var _loc3_:CrisisEventCountMsg in _loc2_.eventCountInfos)
         {
            _loc4_ = _model.eventProgessDic[_loc3_.eventType];
            if(_loc4_ == null)
            {
               _loc4_ = new PlaneCrisisCountInfo();
               _model.eventProgessDic[_loc3_.eventType] = _loc4_;
            }
            _loc4_.eventType = _loc3_.eventType;
            _loc4_.maxCount = _loc3_.eventMaxCount;
         }
         SceneManager.instance.setScene("PLANE_CRISRIS");
      }
      
      private function __updateGameInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PlaneCrisisNodeInfo = null;
         var _loc7_:PlaneCrisisPlayerInfo = null;
         var _loc5_:PlaneCrisisCountInfo = null;
         if(_model == null)
         {
            return;
         }
         var _loc11_:PackageIn = param1.data as PackageIn;
         var _loc2_:CrisisInfoMsg = new CrisisInfoMsg();
         _loc2_ = _loc11_.readBody(_loc2_) as CrisisInfoMsg;
         _model.beginChanges();
         var _loc9_:Boolean = _loc2_.isRelogin;
         var _loc8_:Array = [];
         for each(var _loc10_:CrisisNodeInfo in _loc2_.nodes)
         {
            _loc3_ = _model.nodeInfoDic[_loc10_.nodeId];
            if(_loc3_ == null)
            {
               _loc3_ = new PlaneCrisisNodeInfo();
               _model.nodeInfoDic[_loc10_.nodeId] = _loc3_;
            }
            _loc3_.nodeId = _loc10_.nodeId;
            _loc3_.isOpen = _loc10_.isOpen;
            _loc3_.eventId = _loc10_.eventId;
            if(endBossNodeId == -1 && _loc3_.eventTempInfo && _loc3_.eventTempInfo.EventType == PlaneCrisisEventType.END_BOSS)
            {
               endBossNodeId = _loc3_.nodeId;
            }
            _loc3_.isPick = _loc10_.isPick;
            if(_loc9_)
            {
               _loc3_.isPlay = true;
            }
            _loc8_.push(_loc3_);
         }
         if(_loc8_.length > 0)
         {
            _model.flag("PlaneCrisisEventType.updateNodeInfo",_loc8_);
         }
         for each(var _loc6_:CrisisPlayerInfo in _loc2_.players)
         {
            _loc7_ = _model.planeCrisisInfoDic[_loc6_.id];
            if(_loc7_ != null)
            {
               _loc7_.buyTime = _loc6_.buyCount;
               _loc7_.actionNum = _loc6_.energy;
               _loc7_.fragment = _loc6_.crystal;
               _loc7_.standNodeId = _loc6_.currentNodeId;
               _loc7_.isOffline = _loc6_.isOffline;
               _loc7_.commitPostion();
               _model.flag("PlaneCrisisEventType.updatePlayerInfo",true);
            }
         }
         for each(var _loc4_:CrisisEventCount in _loc2_.eventCountInfos)
         {
            _loc5_ = _model.eventProgessDic[_loc4_.eventType];
            if(_loc5_ != null)
            {
               _loc5_.currCount = _loc4_.eventCount;
               _model.flag("PlaneCrisisEventType.updateEventCount",true);
            }
         }
         _model.commit();
      }
      
      private function _moveHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PlaneCrisisPlayerInfo = null;
         if(_model == null)
         {
            return;
         }
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PropertyMsg;
         _loc3_ = _model.planeCrisisInfoDic[_loc2_.param1];
         if(_loc3_ != null)
         {
            _loc3_.lastStandNodeId = _loc2_.param2;
            _loc3_.standNodeId = _loc2_.param3;
         }
      }
      
      private function __exitGameHandler(param1:SLGSocketEvent) : void
      {
         if(model == null)
         {
            return;
         }
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         var _loc4_:int = _loc2_.param1;
         if(_loc4_ == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            exit = true;
            if(GameHallManager.instance.model.selfTeam)
            {
               GameHallManager.instance.enterGameHallScene();
            }
            else
            {
               SwitchPageHelp.returnToSpace();
            }
         }
         else
         {
            model.deletePlayCrisisInfo(_loc4_);
         }
      }
      
      private function __attackBossHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:String = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PropertyMsg;
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         _loc7_ = LanguageMgr.GetTranslation("planeCrisis.helpAttackBoss");
         SimpleAlertHelper.instance.data = [jionAttackBoss];
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc3_,_loc4_,true);
      }
      
      private function jionAttackBoss(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:PlaneCrisisNodeInfo = null;
         if(_model == null)
         {
            return;
         }
         if(param1)
         {
            _loc3_ = _model.nodeInfoDic[model.selfInfo.standNodeId];
            if(_loc3_.eventTempInfo.bossAttackNum <= model.selfInfo.actionNum)
            {
               gameOp(3);
            }
            else
            {
               alertBuy();
            }
         }
      }
      
      public function confrimAttackBoss(param1:int) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("planeCrisis.doAttack");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("planeCrisis.attackNeedActionNum",param1);
         SimpleAlertHelper.instance.data = [doConfrimAttackBoss];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true);
      }
      
      private function doConfrimAttackBoss(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            gameOp(3);
         }
      }
      
      public function acceptInvate(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc8_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc7_:String = null;
         if(param1 == null || _model == null)
         {
            return;
         }
         var _loc5_:int = int(param1[0]);
         var _loc6_:int = int(param1[1]);
         if(_model.selfInfo.standNodeId == _loc6_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("planeCrisis.noTransTip"));
            return;
         }
         if(_model.nodeItemDic[_loc6_] && _model.nodeItemDic[_loc6_].eventInfo)
         {
            _loc4_ = int(_model.nodeItemDic[_loc6_].eventInfo.bossTransNum);
            if(_model.selfInfo.actionNum < _loc4_)
            {
               alertBuy();
               return;
            }
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc7_ = LanguageMgr.GetTranslation("public.prompt");
            _loc8_ = LanguageMgr.GetTranslation("planeCrisis.acceptTransToNode",_loc4_);
            SimpleAlertHelper.instance.data = [acceptAttackBoss,param1];
            SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc2_,_loc3_,true);
         }
      }
      
      private function acceptAttackBoss(param1:Boolean, param2:Boolean, param3:Array) : void
      {
         if(param1)
         {
            gameOp(5,param3[1],param3[0]);
         }
      }
      
      public function alertBuy() : void
      {
         if(_model == null)
         {
            return;
         }
         var _loc2_:int = _model.limitBuy - _model.selfInfo.buyTime;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         var _loc4_:TodayNotAlertFrame = ComponentFactory.Instance.creatComponentByStylename("ui.planeCrisis.buyFrame");
         _loc4_.setSelestX(23);
         var _loc3_:String = LanguageMgr.GetTranslation("planeCrisis.buyActionTip",_model.buffPrice,_model.buyActionNum,_loc2_,_model.limitBuy);
         var _loc1_:String = LanguageMgr.GetTranslation("planeCrisis.checkPointBuy",_model.pointBuyPrice);
         _loc4_.checkBtm.selected = true;
         _loc4_.show(_loc3_,_loc1_,buyBackFun,null,"left",1,false,0,false,3);
      }
      
      private function buyBackFun(param1:Boolean) : void
      {
         if(param1)
         {
            gameOp(6,0);
         }
         else
         {
            gameOp(6,1);
         }
      }
      
      private function __gameEndHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PlaneCrisisPlayerInfo = null;
         var _loc8_:PlaneCrisisGameOverPlayInfo = null;
         exit = true;
         var _loc12_:PackageIn = param1.data as PackageIn;
         var _loc2_:CrisisGameEndMsg = new CrisisGameEndMsg();
         _loc2_ = _loc12_.readBody(_loc2_) as CrisisGameEndMsg;
         var _loc9_:int = _loc2_.crystalCount;
         var _loc7_:Array = [];
         for each(var _loc11_:CrisisItemMsg in _loc2_.items)
         {
            if(_loc7_.indexOf(_loc11_.templateId) == -1)
            {
               _loc7_.push([_loc11_.templateId,_loc11_.count]);
            }
         }
         var _loc3_:Array = [];
         var _loc6_:Object = {};
         var _loc10_:int = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         for each(var _loc4_:CrisisPlayerInfo in _loc2_.players)
         {
            _loc5_ = _model.planeCrisisInfoDic[_loc4_.id];
            if(_loc5_ != null)
            {
               _loc8_ = new PlaneCrisisGameOverPlayInfo();
               _loc8_.actionNum = _loc4_.energy;
               _loc8_.fragment = _loc4_.crystal;
               _loc8_.nickName = _loc5_.armyData.nickName;
               _loc8_.headId = _loc5_.armyData.baseHero.headId;
               _loc3_.push(_loc8_);
               if(_loc4_.id == _loc10_)
               {
                  _loc6_.buyCount = _loc4_.buyCount;
                  _loc6_.diamondBuyCount = _loc4_.diamondBuyCount;
                  _loc6_.rewardDelRate = _loc4_.rewardDelRate;
               }
            }
         }
         if(SceneManager.instance.currentType != "PLANE_CRISRIS")
         {
            reset();
         }
         else if(GameHallManager.instance.model.selfTeam)
         {
            GameHallManager.instance.enterGameHallScene();
         }
         else
         {
            SwitchPageHelp.returnToSpace();
         }
         _loc6_.rewards = _loc7_;
         _loc6_.players = _loc3_;
         _loc6_.count = _loc9_;
         if(GameHallManager.instance.model.selfTeam)
         {
            DelayActionsUtils.instance.addAction(new AlertTipAction(_loc6_,showReportFun,"GAME_HALL_SCENE"));
         }
         else
         {
            DelayActionsUtils.instance.addAction(new AlertTipAction(_loc6_,showReportFun,"SPACE_SCENE"));
         }
      }
      
      private function showReportFun(param1:Object = null) : void
      {
         FrameControllerManager.instance.openControllerByInfo("planecrisis",null,param1);
      }
      
      public function gameOp(param1:int, param2:int = 0, param3:int = 0, param4:int = 0) : void
      {
         var _loc6_:PackageOut = new PackageOut(9675);
         var _loc5_:CrisisOpMsg = new CrisisOpMsg();
         _loc5_.op = param1;
         _loc5_.param1 = param2;
         _loc5_.param2 = param3;
         _loc5_.param3 = param4;
         sendProtoBuffer(_loc5_,_loc6_);
      }
      
      private function sendProtoBuffer(param1:Message, param2:PackageOut) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param2,param1);
      }
      
      private function readPlayerInfos(param1:CrisisPlayerMsg) : void
      {
         var _loc6_:ThaneInfo = null;
         var _loc3_:PlaneCrisisArmy = null;
         var _loc2_:PlaneCrisisPlayerInfo = null;
         var _loc4_:RoomPlayerMsg = param1.player;
         var _loc7_:int = _loc4_.playerId;
         var _loc5_:int = param1.id;
         _loc2_ = _model.planeCrisisInfoDic[_loc5_];
         if(_loc2_ == null)
         {
            _loc2_ = new PlaneCrisisPlayerInfo();
            _loc3_ = new PlaneCrisisArmy();
            _loc6_ = new ThaneInfo();
            _loc2_.armyData = _loc3_;
            _loc3_.baseHero = _loc6_;
            _loc2_.userId = _loc5_;
            _loc3_.id = _loc5_;
            _loc6_.id = _loc5_;
            _loc3_.userId = _loc7_;
            _loc6_.userId = _loc7_;
            _loc3_.color = param1.color;
            _model.addPlayCrisisInfo(_loc2_);
         }
         _loc2_.standNodeId = param1.currentNodeId;
         _loc2_.color = param1.color;
         _loc2_.actionNum = param1.energy;
         _loc3_ = _loc2_.armyData;
         _loc6_ = _loc3_.baseHero;
         _loc6_.grades = _loc4_.grades;
         _loc3_.nickName = _loc4_.nickName;
         _loc6_.nickName = _loc3_.nickName;
         _loc6_.templateId = _loc4_.templateId;
         _loc6_.armsEquipAvata = _loc4_.arm;
         _loc6_.bodyEquipAvata = _loc4_.cloth;
         _loc4_.hasWing && (_loc6_.wingAvata = _loc4_.wing);
         _loc6_.hairFashionAvata = _loc4_.hat;
         _loc6_.armsFashionAvata = _loc4_.fashionArm;
         _loc6_.bodyFashionAvata = _loc4_.fashionCloth;
         _loc6_.hideFashion = _loc4_.hide;
         _loc6_.changeShapeId = _loc4_.changeShapeId;
         _loc6_.honer = _loc4_.geste;
         _loc6_.headId = _loc4_.headId;
         if(_loc4_.hasHide)
         {
            _loc6_.hideFashion = _loc4_.hide;
         }
         if(_loc4_.hasFashionArm)
         {
            _loc6_.armsFashionAvata = _loc4_.fashionArm;
         }
         if(_loc4_.hasFashionCloth)
         {
            _loc6_.bodyFashionAvata = _loc4_.fashionCloth;
         }
         if(_loc4_.hasHat)
         {
            _loc6_.hairFashionAvata = _loc4_.hat;
         }
         _loc3_.online = _loc4_.onlineState;
         _loc6_.state = _loc4_.onlineState ? 7 : 0;
      }
      
      private function initModel() : void
      {
         endBossNodeId = -1;
         exit = false;
         if(_model == null)
         {
            _model = new PlaneCrisisModel();
         }
      }
      
      public function reset() : void
      {
         if(_model != null)
         {
            if(exit)
            {
               _model.dispose();
               _model = null;
            }
            else
            {
               _model.reset();
            }
         }
      }
      
      public function get model() : PlaneCrisisModel
      {
         return _model;
      }
   }
}

