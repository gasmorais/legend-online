package mvc.controler
{
   import battle.utils.Int64Utils;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.controls.Frame;
   import com.road.yishi.proto.consortiapve.ConsortiaPveAreaBoxMsg;
   import com.road.yishi.proto.consortiapve.ConsortiaPveCurNodeMsg;
   import com.road.yishi.proto.consortiapve.ConsortiaPveDataMsg;
   import com.road.yishi.proto.consortiapve.ConsortiaPveNodeMsg;
   import com.road.yishi.proto.consortiapve.ConsortiaPvePlayerMsg;
   import com.road.yishi.proto.consortiapve.ConsortiaPveSeasonMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import mvc.FrameController;
   import mvc.module.guildfb.GuildFBAreaNode;
   import mvc.module.guildfb.GuildFBModel;
   import mvc.module.guildfb.GuildFBNode;
   import mvc.module.guildfb.GuildFBPlayerInfo;
   import mvc.module.guildfb.GuildFBRaceNode;
   import mvc.module.guildfb.GuildFBRankItemInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   
   public class GuildFbController extends FrameController
   {
      
      public static const FIGHT_NODE_FRAME:int = 1;
      
      public static const AREA_NODE_FRAME:int = 2;
      
      public static const AREA_SORT_FRAME:int = 3;
      
      public static const AREA_REWARD_FRAME:int = 4;
      
      public static const STATUS_CLOSE:int = 0;
      
      public static const STATUS_OPEN:int = 1;
      
      public static const STATUS_END:int = 2;
      
      private var _list:XMLList;
      
      private var _model:GuildFBModel;
      
      public function GuildFbController()
      {
         super();
         setup();
      }
      
      private function setup() : void
      {
         _model = new GuildFBModel();
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4884,__allNodeInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4885,__updateNodeInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4886,__currNodeInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4887,__raceInfoHandler);
         if(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID > 0)
         {
            requestOp(0);
         }
      }
      
      private function __allNodeInfosHandler(param1:SLGSocketEvent) : void
      {
         _model.resetNodes();
         dealWithNodes(param1);
         MsgMan.notifyObserver("GuildFBModel.raceReset");
      }
      
      private function __updateNodeInfosHandler(param1:SLGSocketEvent) : void
      {
         dealWithNodes(param1);
      }
      
      private function dealWithNodes(param1:SLGSocketEvent) : void
      {
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaPveDataMsg = new ConsortiaPveDataMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ConsortiaPveDataMsg;
         _model.currFightingNodeId = _loc2_.curNodeId;
         _model.serverName = _loc2_.serverName;
         var _loc4_:Boolean = false;
         var _loc3_:Boolean = false;
         for each(var _loc7_:ConsortiaPveAreaBoxMsg in _loc2_.boxs)
         {
            readAreaNode(_loc7_);
            _loc4_ = true;
         }
         for each(var _loc5_:ConsortiaPveNodeMsg in _loc2_.nodes)
         {
            readFightNode(_loc5_);
            _loc3_ = true;
         }
         if(_loc4_)
         {
            MsgMan.notifyObserver("GuildFBModel.areaNode");
         }
         if(_loc3_)
         {
            MsgMan.notifyObserver("GuildFBModel.fightNode");
         }
         ConsortiaManager.instance.giftCount();
      }
      
      private function readAreaNode(param1:ConsortiaPveAreaBoxMsg) : void
      {
         var _loc2_:GuildFBAreaNode = _model.getAreaNodeByAreaIdAndDiff(param1.areaId,param1.difficulty);
         if(_loc2_ == null)
         {
            _loc2_ = new GuildFBAreaNode();
            _model.pushAreaNode(param1.areaId,param1.difficulty,_loc2_);
         }
         _loc2_.areaId = param1.areaId;
         _loc2_.diff = param1.difficulty;
         _loc2_.rewardState = param1.awardState;
         if(param1.leader != null)
         {
            _loc2_.leader.userId = param1.leader.userId;
            _loc2_.leader.headId = param1.leader.headId;
            _loc2_.leader.nickName = param1.leader.nickName;
            _loc2_.leader.fightPower = param1.leader.fightPower;
            _loc2_.leader.attackCount = param1.leader.attackCount;
            _loc2_.leader.totalDamage = Int64Utils.int64ToNumber(param1.leader.totalDamage);
         }
      }
      
      private function readFightNode(param1:ConsortiaPveNodeMsg) : void
      {
         var _loc2_:GuildFBNode = _model.getFightNodeByNodeId(param1.nodeId);
         if(_loc2_ == null)
         {
            _loc2_ = new GuildFBNode();
            _model.pushFightNode(param1.nodeId,_loc2_);
         }
         _loc2_.nodeID = param1.nodeId;
         _loc2_.attackCount = param1.attackCount;
         _loc2_.rewardState = param1.awardState;
      }
      
      private function __currNodeInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:GuildFBPlayerInfo = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaPveCurNodeMsg = new ConsortiaPveCurNodeMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as ConsortiaPveCurNodeMsg;
         var _loc4_:GuildFBNode = _model.getFightNodeByNodeId(_loc2_.curNodeId);
         if(_loc4_ == null)
         {
            trace("ERROR:--->服务器前面需要推送当前攻打节点过来");
            return;
         }
         _loc4_.bossHp = Int64Utils.int64ToNumber(_loc2_.bossHp);
         _loc4_.bossMaxHp = Int64Utils.int64ToNumber(_loc2_.bossMaxHp);
         _loc4_.attackCount = _loc2_.attackCount;
         _loc4_.playerList.length = 0;
         for each(var _loc3_:ConsortiaPvePlayerMsg in _loc2_.players)
         {
            _loc5_ = new GuildFBPlayerInfo();
            _loc5_.userId = _loc3_.userId;
            _loc5_.headId = _loc3_.headId;
            _loc5_.nickName = _loc3_.nickName;
            _loc5_.fightPower = _loc3_.fightPower;
            _loc4_.playerList.push(_loc5_);
         }
         _loc4_.buffID.length = 0;
         for each(var _loc6_:int in _loc2_.buffers)
         {
            _loc4_.buffID.push(_loc6_);
         }
         MsgMan.notifyObserver("GuildFBModel.fightInfo",_loc4_);
      }
      
      private function __raceInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaPveSeasonMsg = new ConsortiaPveSeasonMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ConsortiaPveSeasonMsg;
         var _loc3_:GuildFBRaceNode = new GuildFBRaceNode();
         _loc3_.seasonId = _loc2_.seasonId;
         _loc3_.state = _loc2_.state;
         _loc3_.beginTime = _loc2_.beginTime;
         _loc3_.endTime = _loc2_.endTime;
         _model.raceNode = _loc3_;
         MsgMan.notifyObserver("GuildFBModel.raceNode");
      }
      
      public function requestOp(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(8554);
         var _loc4_:PlayerOpMsg = new PlayerOpMsg();
         _loc4_.op = param1;
         _loc4_.value1 = param2;
         _loc4_.value2 = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public function get model() : GuildFBModel
      {
         return _model;
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.openType == 1 || _data.openType == 2)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "consortia.view.fb.GuildFBFightFrame";
         }
         if(_data.openType == 2)
         {
            return "consortia.view.fb.GuildFBAreaRewardFrame";
         }
         if(_data.openType == 3)
         {
            return "consortia.view.fb.GuildFBRankFrame";
         }
         if(_data.openType == 4)
         {
            return "consortia.view.fb.GuildFBRewardFrame";
         }
         return "consortia.view.fb.GuildFbFrame";
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      public function loadXML() : void
      {
         var _loc2_:String = "consortiapve_unzip.xml";
         var _loc1_:String = PathManager.orderPath + _loc2_;
         LoaderManagerII.instance.load(_loc1_,8,8,__onXMLDataLoaded);
      }
      
      private function __onXMLDataLoaded(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:String = param1.url;
         _loc4_ = _loc4_.replace(PathManager.orderPath,"");
         var _loc3_:int = _loc4_.indexOf("?");
         if(_loc3_ != -1)
         {
            _loc4_ = _loc4_.substring(0,_loc3_);
         }
         resolveXML(new XML(param2));
      }
      
      private function resolveXML(param1:XML) : void
      {
         var _loc2_:String = null;
         if(param1 != null)
         {
            _list = param1.ConsortiaPveOrder;
            if(param1.info[0])
            {
               _loc2_ = param1.info[0].@createDate;
               _loc2_ = _loc2_.substring(0,_loc2_.indexOf("."));
               _model.lastRefreshTime = _loc2_;
            }
            read();
         }
      }
      
      public function read() : void
      {
         var _loc2_:GuildFBRankItemInfo = null;
         if(_list)
         {
            _model.rankArray = [];
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = new GuildFBRankItemInfo();
               _loc2_.order = int(_loc1_.@Rank);
               _loc2_.consortiaId = int(_loc1_.@ConsortiaId);
               _loc2_.consortiaName = String(_loc1_.@ConsortiaName);
               _loc2_.serverName = String(_loc1_.@ServerName);
               _loc2_.currentLevel = int(_loc1_.@PassNodeId);
               _loc2_.progress = int(_loc1_.@Progress);
               _model.rankArray.push(_loc2_);
            }
            _model.rankArray.sortOn("order",16);
         }
         MsgMan.notifyObserver("RANK_UPDATE");
      }
   }
}

