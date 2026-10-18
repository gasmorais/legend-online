package mvc.module.godsevening
{
   import flash.utils.Dictionary;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.internals.data.CampaignNode;
   import map.internals.data.PhysicInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   
   public class GodsEveningModel
   {
      
      public static const INSPIRE_MAX:int = 10;
      
      public static const INSPIRE_SCALE:int = 10;
      
      public static const INSPIRE_ATTRIBUTE:int = 5;
      
      public var selfFowllowingArmy:CampaignArmy;
      
      private var _matchDateDic:SimpleDictionary;
      
      public var teamDataDic:Dictionary;
      
      public var mainFramePersonRankDic:Dictionary;
      
      public var mainFrameServerRankDic:Dictionary;
      
      public var npcNodeInfoDic:Dictionary;
      
      public var npcNodeViewDic:Dictionary;
      
      public var taskProgressDic:Dictionary;
      
      public var taskGotRewardDic:Dictionary;
      
      public var taskCompleteCountsDic:Dictionary;
      
      public var personRankDataDic:Dictionary;
      
      public var serverRankDataDic:Dictionary;
      
      public var teamId:int;
      
      public var readyScore:int;
      
      public var readyOrder:int;
      
      public var finalScore:int;
      
      public var finalOrder:int;
      
      public var totalRank:int;
      
      public var serverScore:int;
      
      public var serverOrder:int;
      
      public var gameState:int;
      
      public var isShowIcon:Boolean;
      
      public var openTime:Date;
      
      public var endTime:Date;
      
      public var bossDebuffId:int;
      
      public var bossDebuffShowFlag:int = 1;
      
      public var isForceQuit:Boolean;
      
      public var inspireLevel:int;
      
      public function GodsEveningModel()
      {
         super();
         npcNodeInfoDic = new Dictionary();
         teamDataDic = new Dictionary();
         mainFramePersonRankDic = new Dictionary();
         mainFrameServerRankDic = new Dictionary();
         taskProgressDic = new Dictionary();
         taskGotRewardDic = new Dictionary();
         taskCompleteCountsDic = new Dictionary();
         personRankDataDic = new Dictionary();
         serverRankDataDic = new Dictionary();
         npcNodeViewDic = new Dictionary();
      }
      
      public function getNpcNodeInfoByTeamAndType(param1:int, param2:int) : ThaneInfo
      {
         return npcNodeInfoDic[param1 + "_" + param2];
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function get leftTime() : int
      {
         var _loc1_:int = 0;
         if(gameState == 1)
         {
            if(CampaignManager.instance.mapModel && CampaignManager.instance.mapModel.endTime)
            {
               _loc1_ = CampaignManager.instance.mapModel.endTime.time - playerModel.sysCurtime.time;
            }
         }
         return _loc1_;
      }
      
      public function get score() : int
      {
         var _loc1_:int = 0;
         if(gameState == 1)
         {
            _loc1_ = readyScore;
         }
         else if(gameState == 2)
         {
            _loc1_ = finalScore;
         }
         else if(finalOrder != 0)
         {
            _loc1_ = finalScore;
         }
         else
         {
            _loc1_ = readyScore;
         }
         return _loc1_;
      }
      
      public function get rank() : int
      {
         var _loc1_:int = 0;
         if(gameState == 1)
         {
            _loc1_ = readyOrder;
         }
         else if(gameState == 2)
         {
            _loc1_ = finalOrder;
         }
         else if(finalOrder != 0)
         {
            _loc1_ = finalOrder;
         }
         else
         {
            _loc1_ = readyOrder;
         }
         return _loc1_;
      }
      
      public function copyNodeData() : void
      {
         var _loc1_:int = 0;
         var _loc4_:CampaignNode = null;
         var _loc3_:CampaignNode = null;
         var _loc5_:int = 0;
         var _loc2_:Array = getCampaignNodeByGodDessId();
         if(_loc2_)
         {
            _loc1_ = int(_loc2_.length);
         }
         _loc5_ = 0;
         while(_loc5_ < _loc1_)
         {
            _loc4_ = _loc2_[_loc5_] as CampaignNode;
            _loc3_ = new CampaignNode();
            _loc3_.toward = _loc4_.sizeType == 10 ? 0 : _loc4_.toward;
            _loc3_.info = new PhysicInfo();
            _loc3_.curPosX = _loc4_.curPosX;
            _loc3_.curPosY = _loc4_.curPosY;
            _loc3_.info.names = _loc4_.info.names;
            _loc3_.info.grade = _loc4_.info.grade;
            _loc3_.info.state = _loc4_.info.state;
            _loc3_.info.types = _loc4_.info.types;
            _loc3_.nameColor = _loc4_.nameColor;
            _loc3_.param1 = _loc4_.param1;
            _loc3_.param2 = _loc4_.param2;
            _loc3_.armyId = _loc4_.armyId;
            _loc3_.nodeId = _loc4_.nodeId;
            if(!npcNodeViewDic[_loc3_.nodeId])
            {
               npcNodeViewDic[_loc3_.nodeId] = _loc3_;
            }
            else
            {
               delete npcNodeViewDic[_loc3_.nodeId];
               npcNodeViewDic[_loc3_.nodeId] = _loc3_;
            }
            _loc5_++;
         }
      }
      
      private function getCampaignNodeByGodDessId() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_:CampaignNode in CampaignManager.instance.mapModel.mapNodesData)
         {
            if(_loc1_ && (_loc1_.nodeId == 850110 || _loc1_.nodeId == 850111 || _loc1_.nodeId == 850112))
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
   }
}

