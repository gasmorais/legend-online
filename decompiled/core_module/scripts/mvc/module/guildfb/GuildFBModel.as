package mvc.module.guildfb
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GuildFBPveRankDropTempInfo;
   import yishi.datas.templates.GuildFBTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   
   public class GuildFBModel
   {
      
      public static const EVENT_FIGHT_NODE:String = "GuildFBModel.fightNode";
      
      public static const EVENT_AREA_NODE:String = "GuildFBModel.areaNode";
      
      public static const EVENT_CHANGE_DIFF:String = "GuildFBModel.changeDiff";
      
      public static const EVENT_FIGHT_INFO:String = "GuildFBModel.fightInfo";
      
      public static const RACE_NODE:String = "GuildFBModel.raceNode";
      
      public static const RACE_RESET:String = "GuildFBModel.raceReset";
      
      public static const RANK_UPDATE:String = "RANK_UPDATE";
      
      public static const DIFF_NORMAL:int = 0;
      
      public static const DIFF_ADVANCE:int = 1;
      
      public static const BUFF_IDS:Array = [43000001,43000002];
      
      public var currFightNum:int = 0;
      
      public var raceNode:GuildFBRaceNode = null;
      
      private const MAX_AREA_NODES:int = 12;
      
      private const MAX_AREA:int = 5;
      
      private var _configMaxFightNum:int = -1;
      
      private var _currFightingNodeId:int = -1;
      
      private var _currFightNode:GuildFBNode;
      
      private var _nodeDic:SimpleDictionary;
      
      private var _areaDic:SimpleDictionary;
      
      private var _currSelectDiff:int = 0;
      
      private var _maxNormalNode:GuildFBTempInfo;
      
      private var _rankArray:Array;
      
      public var lastRefreshTime:String;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = 1;
      
      private var _serverName:String;
      
      public function GuildFBModel()
      {
         super();
         _nodeDic = new SimpleDictionary();
         _areaDic = new SimpleDictionary();
         _rankArray = [];
      }
      
      public function get serverName() : String
      {
         return _serverName;
      }
      
      public function set serverName(param1:String) : void
      {
         _serverName = param1;
      }
      
      public function get configMaxFightNum() : int
      {
         if(_configMaxFightNum > 0)
         {
            return _configMaxFightNum;
         }
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("consortia_pve_count");
         if(_loc1_ != null)
         {
            _configMaxFightNum = int(_loc1_.ConfigValue);
         }
         else
         {
            _configMaxFightNum = 1;
         }
         return _configMaxFightNum;
      }
      
      public function set rankArray(param1:Array) : void
      {
         _rankArray = param1;
      }
      
      public function get rankArray() : Array
      {
         return _rankArray;
      }
      
      public function get currSelectDiff() : int
      {
         return _currSelectDiff;
      }
      
      public function getRewardArray() : Array
      {
         var _loc3_:* = null;
         var _loc1_:Array = [];
         var _loc4_:Dictionary = TempleteManager.instance.guildFbPveRankDropTempte.getTempInfoByRank();
         for each(var _loc2_:Array in _loc4_)
         {
            _loc1_.push(getArrayData(_loc2_));
         }
         _loc1_.sortOn("firstOrder",16);
         return _loc1_;
      }
      
      private function getArrayData(param1:Array) : GuildFBRewardItemInfo
      {
         var _loc2_:int = 0;
         var _loc5_:GuildFBPveRankDropTempInfo = null;
         var _loc6_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:GuildFBRewardItemInfo = new GuildFBRewardItemInfo();
         if(param1)
         {
            _loc2_ = int(param1.length);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc5_ = param1[_loc4_] as GuildFBPveRankDropTempInfo;
               _loc6_ = _loc5_.para2.split(",");
               if(_loc6_ && _loc6_.length > 1)
               {
                  _loc3_.firstOrder = _loc6_[0];
                  _loc3_.lastOrder = _loc6_[1];
                  _loc3_.itemIdStr += _loc5_.itemId + ",";
                  _loc3_.countStr += _loc5_.count + ",";
               }
               else
               {
                  _loc3_.firstOrder = _loc6_[0];
                  _loc3_.lastOrder = _loc6_[0];
                  _loc3_.itemIdStr += _loc5_.itemId + ",";
                  _loc3_.countStr += _loc5_.count + ",";
               }
               _loc4_++;
            }
         }
         return _loc3_;
      }
      
      public function set currSelectDiff(param1:int) : void
      {
         if(_currSelectDiff == param1)
         {
            return;
         }
         _currSelectDiff = param1;
         MsgMan.notifyObserver("GuildFBModel.changeDiff");
      }
      
      public function get currFightingNodeId() : int
      {
         return _currFightingNodeId;
      }
      
      public function get currFightNode() : GuildFBNode
      {
         return _currFightNode;
      }
      
      public function set currFightingNodeId(param1:int) : void
      {
         if(_currFightingNodeId == param1)
         {
            return;
         }
         _currFightingNodeId = param1;
         var _loc2_:GuildFBNode = _nodeDic[_currFightingNodeId + ""];
         if(_loc2_ == null)
         {
            _loc2_ = new GuildFBNode();
            _loc2_.nodeID = _currFightingNodeId;
            _loc2_.rewardState = 3;
            pushFightNode(_currFightingNodeId,_loc2_);
         }
         _currFightNode = _loc2_;
         currSelectDiff = _loc2_.currTempInfo.Difficulty;
      }
      
      public function resetNodes() : void
      {
         _currFightingNodeId = -1;
         _nodeDic.clear();
         _areaDic.clear();
      }
      
      public function pushFightNode(param1:int, param2:GuildFBNode) : void
      {
         _nodeDic.add(param1 + "",param2);
      }
      
      public function pushAreaNode(param1:int, param2:int, param3:GuildFBAreaNode) : void
      {
         var _loc4_:String = param1 + "_" + param2;
         _areaDic.add(_loc4_,param3);
      }
      
      public function getFightNodeListByDiff(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         var _loc5_:Array = fightAllNodeList;
         var _loc4_:int = 0;
         for each(var _loc6_:GuildFBNode in _loc5_)
         {
            if(_loc6_.currTempInfo && _loc6_.currTempInfo.AreaId == param1 && _loc6_.currTempInfo.Difficulty == param2)
            {
               _loc3_.push(_loc6_);
               if(++_loc4_ >= 12)
               {
                  break;
               }
            }
         }
         return _loc3_;
      }
      
      public function getCurrAreaNodesByDiff() : Array
      {
         var _loc2_:GuildFBAreaNode = null;
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         _loc3_ = 1;
         while(_loc3_ <= 5)
         {
            _loc2_ = getAreaNodeByAreaIdAndDiff(_loc3_,_currSelectDiff);
            if(_loc2_ != null)
            {
               _loc1_.push(_loc2_);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function getFightNodeByNodeId(param1:int) : GuildFBNode
      {
         return _nodeDic[param1 + ""];
      }
      
      public function getAreaNodeByAreaIdAndDiff(param1:int, param2:int) : GuildFBAreaNode
      {
         return _areaDic[param1 + "_" + param2];
      }
      
      public function get fightAllNodeList() : Array
      {
         return _nodeDic.getList();
      }
      
      public function get areaAllNodeList() : Array
      {
         return _areaDic.getList();
      }
      
      public function get isPassNormal() : Boolean
      {
         var _loc2_:Array = null;
         var _loc1_:Boolean = false;
         if(_maxNormalNode == null)
         {
            _loc2_ = TempleteManager.instance.guildFBTempCate.getNodes(5,0);
            _loc2_.sortOn("NodeId",16);
            _maxNormalNode = _loc2_[_loc2_.length - 1];
         }
         var _loc3_:GuildFBNode = getFightNodeByNodeId(_maxNormalNode.NodeId);
         if(_loc3_ && _loc3_.rewardState != 3)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function getFightRewards() : int
      {
         var _loc2_:int = 0;
         var _loc3_:Array = fightAllNodeList;
         for each(var _loc1_:GuildFBNode in _loc3_)
         {
            if(_loc1_.rewardState == 1)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function getReaNum() : int
      {
         var _loc3_:int = getFightRewards();
         var _loc2_:Array = areaAllNodeList;
         for each(var _loc1_:GuildFBAreaNode in _loc2_)
         {
            if(_loc1_.rewardState == 1)
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function set currentPage(param1:int) : void
      {
         param1 = int(param1 <= 0 ? 1 : param1);
         if(_currentPage == param1)
         {
            return;
         }
         _currentPage = param1;
         MsgMan.notifyObserver("RANK_UPDATE");
      }
      
      public function get totalPage() : int
      {
         return _totalPage;
      }
      
      public function set totalPage(param1:int) : void
      {
         param1 = param1 <= _currentPage ? _currentPage : param1;
         if(_totalPage == param1)
         {
            return;
         }
         _totalPage = param1;
         MsgMan.notifyObserver("RANK_UPDATE");
      }
   }
}

