package mvc.module.consortia
{
   import events.ConsortiaEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.ConsortiaBusinessTempInfo;
   import yishi.datas.templates.ConsortiaCommerceShopTempInfo;
   import yishi.datas.templates.ConsortiaQuestConditionTempInfo;
   import yishi.datas.templates.ConsortiaQuestTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.BitArray;
   import yishi.utils.SimpleDictionary;
   
   [Event(name="recruitnum_changed",type="events.ConsortiaEvent")]
   public class ConsortiaModel extends EventDispatcher
   {
      
      public static var UPSKILL_GOODS_TEMPID:int = 208040;
      
      public static const CONSORTIA_SEARCH_PAGE_NUM:int = 8;
      
      public static const CONSORTIA_MEMBER_NUM:int = 15;
      
      public static const CREAT_NEEDED_GOLD:int = 200000;
      
      public static const CREAT_NEEDED_GRADES:int = 12;
      
      public static const CONTRIBUTE_RECORD_PAGE_NUM:int = 8;
      
      public static const CONSORTIA_EVENT_LIST_NUM:int = 11;
      
      public static const APPLY_CONSORTIA_PAGE_NUM:int = 8;
      
      public static const CASE_CELL_OPEN_BY_LEVEL:int = 5;
      
      public static const CASE_CELL_MAX_NUM:int = 56;
      
      public static const STUDY_SKILL_MIN_NUM:int = 6;
      
      public static const RESEARCH_SKILL_MIN_NUM:int = 4;
      
      public static const APPLY_MAX:int = 10;
      
      public static const CONSORTIA_RENAME_NEEDED_POINT:int = 1000;
      
      public static const OPEN_CELL_NEEDED_POINT:int = 100;
      
      public static const BAG_PAGE_CELL_NUM:int = 56;
      
      public static const VOTING_DAY:int = 14;
      
      private static const APPLAY_INFO:String = "applayInfo";
      
      public static var secretBuffPrice:int;
      
      private var _inviteList:Array = [];
      
      private var _applyList:Array = [];
      
      private var _consortiaList:Array = [];
      
      private var _consortiaContributionList:Array = [];
      
      private var _applyConsortiaList:Array = [];
      
      private var _openEffectDic:Dictionary;
      
      private var _setTotalRows:int = 1;
      
      private var _contributeListCurrentPage:int = 1;
      
      private var _contributeListTotalPage:int = 1;
      
      private var _recruitCurrentPage:int = 1;
      
      private var _recruitListTotalPage:int = 1;
      
      private var _alTarBlessLeftTime:int;
      
      private var _consortiaMemberList:SimpleDictionary;
      
      private var _baseSkillList:SimpleDictionary;
      
      private var _consortiaInfo:ConsortiaInfo;
      
      private var _timeLeft:int;
      
      private var _consortiaDutyList:Dictionary;
      
      private var _usrRights:BitArray;
      
      private var _consortiaEventList:Array;
      
      private var _altarGoods:GoodsInfo;
      
      private var _lastaltarGoods:GoodsInfo;
      
      public var isCaseHasGoods:Boolean;
      
      public var bagView:*;
      
      public var todayOffer:int;
      
      public var totalOffer:int;
      
      public var todaySpirit:Number;
      
      public var totalSpirit:Number;
      
      public var selfOrder:int;
      
      public var nickName:String = "";
      
      public var isHistory:Boolean;
      
      public var delayTime:Number = 0;
      
      public var recruitOperateNum:int;
      
      public var recruitOperateList:Array = [];
      
      public var blessInfo:ConsortiaAltarBlessInfo;
      
      public var isBlessing:Boolean;
      
      public var caseBag:*;
      
      private var _votingUsers:Vector.<ConsortiaVotingUserInfo>;
      
      private var _hasVoted:Boolean = false;
      
      private var _recruitNum:int;
      
      private var _atcitityList:Array = [];
      
      protected var _changeObj:SimpleDictionary;
      
      public var currentBagType:int;
      
      public var currCorssRing:int = 3;
      
      private var _currCrossIndex:int;
      
      private var _crossEndTime:String;
      
      private var _crossPVPApplyState:int = 0;
      
      private var _currAgainst:Array;
      
      private var _isCrossGuildOpen:Boolean = false;
      
      private var _crossCamp:int;
      
      private var _firstConsortia:String = "";
      
      private var _isOver:Boolean = false;
      
      private var _currRing:int;
      
      private var _currRank:int;
      
      private var _groupId:int;
      
      public var caseBagCanUse:Boolean = false;
      
      public const currentPrizeListCountMax:int = 10;
      
      public var currentPrizeTemplateId:int;
      
      protected var _currentPrizeListCount:int;
      
      private var _isFlag:Boolean;
      
      protected var _prizeList:SimpleDictionary;
      
      private var _prizeMemberList:SimpleDictionary;
      
      public var currentPage:int = 1;
      
      private var _consortiaWarOpenDate:String;
      
      private var _consortiaWarOpenTime:String;
      
      public var masterSkillTypeAry:Array = [22,23,24,25];
      
      public var masterSkillTempAry:Array;
      
      public var reputation:int;
      
      public var activePoint:int;
      
      public var weeklyActivePoint:int;
      
      public var taskTempDic:Dictionary;
      
      public var consortiaQuestStateAry:BitArray;
      
      public var questStateByteAry:BitArray;
      
      public var questInfoList:Array;
      
      public var businessTempDic:Dictionary;
      
      public var businessList:Array;
      
      public var altarWorshipIndex:int = 1;
      
      public var tradeList:Array = [];
      
      public var tradeStateList:Array = [];
      
      public var supplyList:Array = [];
      
      public var refreshCounts:int;
      
      public var secretInfo:ConsortiaSecretInfo;
      
      public var emeDreamInfo:ConsortiaEmeDreamInfo;
      
      public var maxMave:int;
      
      public var treasureGroupInfo:TreasureGroupInfo;
      
      public var refresh_costArr:Array;
      
      public var open_costArr:Array;
      
      public var CountArr:Array;
      
      public var speed_up_costArr:Array;
      
      public function ConsortiaModel(param1:IEventDispatcher = null)
      {
         super(param1);
         init();
      }
      
      public function get currentPrizeListCount() : int
      {
         return _currentPrizeListCount;
      }
      
      public function set currentPrizeListCount(param1:int) : void
      {
         _currentPrizeListCount = param1;
         dispatchEvent(new ConsortiaEvent("PRIZE_LIST_COUNT_UPDATE"));
      }
      
      public function get prizeList() : SimpleDictionary
      {
         return _prizeList;
      }
      
      public function set prizeList(param1:SimpleDictionary) : void
      {
         _prizeList = param1;
         dispatchEvent(new ConsortiaEvent("PRIZE_LIST_UPDATE"));
      }
      
      public function get prizeMemberList() : SimpleDictionary
      {
         return _prizeMemberList;
      }
      
      public function set prizeMemberList(param1:SimpleDictionary) : void
      {
         _prizeMemberList = param1;
         dispatchEvent(new ConsortiaEvent("PRIZE_MEMBER_LIST_UPDATE"));
      }
      
      public function get recruitNum() : int
      {
         return _recruitNum;
      }
      
      public function set recruitNum(param1:int) : void
      {
         if(_recruitNum == param1)
         {
            return;
         }
         _recruitNum = param1;
         dispatchEvent(new ConsortiaEvent("recruitnum_changed"));
      }
      
      public function get treasureCount() : int
      {
         return treasureMyCount + treasureOtherCount;
      }
      
      public function get treasureMyCount() : int
      {
         var _loc1_:MyTreasureInfo = null;
         var _loc3_:int = 0;
         var _loc2_:int = int(treasureGroupInfo.myTreasures.length);
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = treasureGroupInfo.myTreasures[_loc4_];
            if(_loc1_.status == 2)
            {
               _loc3_ += 1;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function get treasureOtherCount() : int
      {
         var _loc4_:OthersTreasureInfo = null;
         var _loc2_:int = 0;
         var _loc1_:int = int(treasureGroupInfo.helpList.length);
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = treasureGroupInfo.helpList[_loc3_];
            if(_loc4_.status == 2)
            {
               _loc2_ += 1;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function beginChanges() : void
      {
         _changeObj.clear();
      }
      
      public function removeFromApplyConsortiaList(param1:ThaneInfo) : void
      {
         var _loc2_:int = applyConsortiaList.indexOf(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         applyConsortiaList.splice(applyConsortiaList.indexOf(param1),1);
         _changeObj["applayInfo"] = true;
      }
      
      public function commit() : void
      {
         if(_changeObj["applayInfo"])
         {
            dispatchEvent(new ConsortiaEvent("UPDA_APPLY_CONSORTIA_INFO"));
         }
      }
      
      private function init() : void
      {
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc1_:ConsortiaTemplete = null;
         _consortiaInfo = new ConsortiaInfo();
         _consortiaDutyList = new Dictionary();
         _consortiaMemberList = new SimpleDictionary();
         _baseSkillList = new SimpleDictionary();
         _usrRights = new BitArray();
         blessInfo = new ConsortiaAltarBlessInfo();
         _changeObj = new SimpleDictionary();
         _prizeList = new SimpleDictionary();
         _prizeMemberList = new SimpleDictionary();
         secretInfo = new ConsortiaSecretInfo();
         treasureGroupInfo = new TreasureGroupInfo();
         emeDreamInfo = new ConsortiaEmeDreamInfo();
         questInfoList = [];
         businessList = [];
         var _loc5_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("Fam_Buffer_Price");
         secretBuffPrice = _loc5_ ? int(_loc5_.ConfigValue) : 10;
         _consortiaWarOpenDate = TempleteManager.instance.getConfigInfoByConfigName("Guild_WarDay").ConfigValue;
         _consortiaWarOpenTime = TempleteManager.instance.getConfigInfoByConfigName("GuildWar_Time").ConfigValue;
         var _loc3_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("CrossGuild_Index");
         if(_loc3_)
         {
            _currCrossIndex = parseInt(_loc3_.ConfigValue);
         }
         else
         {
            _currCrossIndex = 1;
         }
         masterSkillTempAry = [];
         _loc6_ = 0;
         while(_loc6_ < masterSkillTypeAry.length)
         {
            _loc8_ = int(masterSkillTypeAry[_loc6_]);
            _loc1_ = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(_loc8_,1);
            masterSkillTempAry.push(_loc1_);
            _loc6_++;
         }
         taskTempDic = new Dictionary();
         var _loc2_:Dictionary = TempleteManager.instance.consortiaQuestTempCate.getTemplates();
         for each(var _loc4_:ConsortiaQuestTempInfo in _loc2_)
         {
            if(taskTempDic[_loc4_.QuestType] == null)
            {
               taskTempDic[_loc4_.QuestType] = [];
            }
            taskTempDic[_loc4_.QuestType].push(_loc4_);
         }
         businessTempDic = new Dictionary();
         var _loc9_:Dictionary = TempleteManager.instance.consortiaBusinessTempCate.getTemplates();
         for each(var _loc7_:ConsortiaBusinessTempInfo in _loc9_)
         {
            if(businessTempDic[_loc7_.ShopLevel] == null)
            {
               businessTempDic[_loc7_.ShopLevel] = [];
            }
            businessTempDic[_loc7_.ShopLevel].push(_loc7_);
         }
      }
      
      public function get applyList() : Array
      {
         return _applyList;
      }
      
      public function set applyList(param1:Array) : void
      {
         _applyList = param1;
         dispatchEvent(new ConsortiaEvent("UPDA_RECORD_LIST"));
      }
      
      public function get inviteList() : Array
      {
         return _inviteList;
      }
      
      public function set inviteList(param1:Array) : void
      {
         _inviteList = param1;
         dispatchEvent(new ConsortiaEvent("UPDA_RECORD_LIST"));
      }
      
      public function get consortiaList() : Array
      {
         return _consortiaList;
      }
      
      public function get robotConsortiaList() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         var _loc1_:int = int(consortiaList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            if(consortiaList[_loc3_].isRobot)
            {
               _loc2_.push(consortiaList[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get noRobotConsortiaList() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         var _loc1_:int = int(consortiaList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            if(consortiaList[_loc3_].isRobot == false)
            {
               _loc2_.push(consortiaList[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function set consortiaList(param1:Array) : void
      {
         _consortiaList = param1;
         dispatchEvent(new ConsortiaEvent("UPDA_CONSORTIA_LIST"));
      }
      
      public function get consortiaMemberList() : SimpleDictionary
      {
         return _consortiaMemberList;
      }
      
      public function getSortMemberList(param1:String = "fightingCapacity", param2:Boolean = true) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc4_:ThaneInfo in _consortiaMemberList)
         {
            _loc3_.push(_loc4_);
         }
         if(param1 == "nickName")
         {
            if(param2)
            {
               _loc3_.sortOn(["isOnline",param1],[2,2]);
            }
            else
            {
               _loc3_.sortOn(["isOnline",param1],[2,1]);
            }
         }
         else if(param1 == "crossGuildTeamId")
         {
            if(param2)
            {
               _loc3_.sortOn([param1],[0x10 | 2]);
            }
            else
            {
               _loc3_.sortOn([param1],[16]);
            }
         }
         else if(param1 == "grades")
         {
            if(param2)
            {
               _loc3_.sortOn(["isOnline","vocationGrades",param1],[2,0x10 | 2,0x10 | 2]);
            }
            else
            {
               _loc3_.sortOn(["isOnline","vocationGrades",param1],[2,16,16]);
            }
         }
         else if(param2)
         {
            _loc3_.sortOn(["isOnline",param1],[2,0x10 | 2]);
         }
         else
         {
            _loc3_.sortOn(["isOnline",param1],[2,16]);
         }
         return _loc3_;
      }
      
      public function set consortiaMemberList(param1:SimpleDictionary) : void
      {
         _consortiaMemberList = param1;
      }
      
      public function get consortiaInfo() : ConsortiaInfo
      {
         return _consortiaInfo;
      }
      
      public function set consortiaInfo(param1:ConsortiaInfo) : void
      {
         _consortiaInfo = param1;
         dispatchEvent(new ConsortiaEvent("UPDA_CONSORTIA_INFO"));
      }
      
      public function get timeLeft() : int
      {
         return _timeLeft;
      }
      
      public function set timeLeft(param1:int) : void
      {
         if(_timeLeft == param1)
         {
            return;
         }
         _timeLeft = param1;
         dispatchEvent(new ConsortiaEvent("UPDA_COOLDOWN_TIME"));
      }
      
      public function get consortiaDutyList() : Dictionary
      {
         return _consortiaDutyList;
      }
      
      public function set consortiaDutyList(param1:Dictionary) : void
      {
         _consortiaDutyList = param1;
      }
      
      public function get usrRights() : BitArray
      {
         return _usrRights;
      }
      
      public function set usrRights(param1:BitArray) : void
      {
         _usrRights = param1;
         dispatchEvent(new ConsortiaEvent("UPDA_CONSORTIA_RIGHTS"));
      }
      
      public function get consortiaContributionList() : Array
      {
         return _consortiaContributionList;
      }
      
      public function set consortiaContributionList(param1:Array) : void
      {
         _consortiaContributionList = param1;
         dispatchEvent(new ConsortiaEvent("UPDA_CONSORTIA_CONTRIBUTE_INFO"));
      }
      
      public function get contributeListCurrentPage() : int
      {
         return _contributeListCurrentPage;
      }
      
      public function set crossPVPApplyState(param1:int) : void
      {
         _crossPVPApplyState = param1;
      }
      
      public function get crossPVPApplyState() : int
      {
         return _crossPVPApplyState;
      }
      
      public function set isOver(param1:Boolean) : void
      {
         _isOver = param1;
      }
      
      public function get isOver() : Boolean
      {
         return _isOver;
      }
      
      public function set firstConsortia(param1:String) : void
      {
         _firstConsortia = param1;
      }
      
      public function get firstConsortia() : String
      {
         return _firstConsortia;
      }
      
      public function set crossCamp(param1:int) : void
      {
         _crossCamp = param1;
      }
      
      public function get crossCamp() : int
      {
         return _crossCamp;
      }
      
      public function set crossEndTime(param1:String) : void
      {
         _crossEndTime = param1;
      }
      
      public function get crossEndTime() : String
      {
         return _crossEndTime;
      }
      
      public function set currRing(param1:int) : void
      {
         _currRing = param1;
      }
      
      public function get currRing() : int
      {
         return _currRing;
      }
      
      public function set currRank(param1:int) : void
      {
         _currRank = param1;
      }
      
      public function get currRank() : int
      {
         return _currRank;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function set currAgainst(param1:Array) : void
      {
         _currAgainst = param1;
      }
      
      public function get currAgainst() : Array
      {
         return _currAgainst;
      }
      
      public function set contributeListCurrentPage(param1:int) : void
      {
         param1 = int(param1 == 0 ? 1 : param1);
         _contributeListCurrentPage = param1;
      }
      
      public function get contributeListTotalPage() : int
      {
         return _contributeListTotalPage;
      }
      
      public function set contributeListTotalPage(param1:int) : void
      {
         param1 = int(param1 == 0 ? 1 : param1);
         _contributeListTotalPage = param1;
         dispatchEvent(new ConsortiaEvent("UPDE_CONTRIBUTION_SEARCH_PAGE"));
      }
      
      public function get setTotalRows() : int
      {
         return _setTotalRows;
      }
      
      public function set setTotalRows(param1:int) : void
      {
         _setTotalRows = param1;
      }
      
      public function get consortiaEventList() : Array
      {
         return _consortiaEventList;
      }
      
      public function set consortiaEventList(param1:Array) : void
      {
         _consortiaEventList = param1;
         dispatchEvent(new ConsortiaEvent("UPDA_CONSORTIA_EVENT_LIST"));
      }
      
      public function get recruitCurrentPage() : int
      {
         return _recruitCurrentPage;
      }
      
      public function set recruitCurrentPage(param1:int) : void
      {
         param1 = int(param1 == 0 ? 1 : param1);
         _recruitCurrentPage = param1;
      }
      
      public function get recruitListTotalPage() : int
      {
         return _recruitListTotalPage;
      }
      
      public function set recruitListTotalPage(param1:int) : void
      {
         param1 = int(param1 == 0 ? 1 : param1);
         _recruitListTotalPage = param1;
         dispatchEvent(new ConsortiaEvent("UPDE_RECRUIT_SEARCH_PAGE"));
      }
      
      public function get applyConsortiaList() : Array
      {
         return _applyConsortiaList;
      }
      
      public function set applyConsortiaList(param1:Array) : void
      {
         _applyConsortiaList = param1;
         _applyConsortiaList.sort(sortListByGradeDown);
         dispatchEvent(new ConsortiaEvent("UPDA_APPLY_CONSORTIA_INFO"));
      }
      
      public function sortListByGradeUp(param1:ThaneInfo, param2:ThaneInfo) : int
      {
         if(param1.fightingCapacity > param2.fightingCapacity)
         {
            return 1;
         }
         if(param1.fightingCapacity < param2.fightingCapacity)
         {
            return -1;
         }
         return 0;
      }
      
      public function sortListByGradeDown(param1:ThaneInfo, param2:ThaneInfo) : int
      {
         if(param1.fightingCapacity > param2.fightingCapacity)
         {
            return -1;
         }
         if(param1.fightingCapacity < param2.fightingCapacity)
         {
            return 1;
         }
         return 0;
      }
      
      public function get alTarBlessLeftTime() : int
      {
         return _alTarBlessLeftTime;
      }
      
      public function set alTarBlessLeftTime(param1:int) : void
      {
         param1 = int(param1 < 0 ? 0 : param1);
         _alTarBlessLeftTime = param1;
         dispatchEvent(new ConsortiaEvent("UPDA_ALTAR_BLESS_LEFT_TIME"));
      }
      
      public function get altarGoods() : GoodsInfo
      {
         return _altarGoods;
      }
      
      public function set altarGoods(param1:GoodsInfo) : void
      {
         _altarGoods = param1;
      }
      
      public function get lastaltarGoods() : GoodsInfo
      {
         return _lastaltarGoods;
      }
      
      public function set lastaltarGoods(param1:GoodsInfo) : void
      {
         _lastaltarGoods = param1;
         dispatchEvent(new ConsortiaEvent("UPDE_ALTAR_GOODS"));
      }
      
      public function get currentCasecellNum() : int
      {
         var _loc1_:int = 0;
         if(consortiaInfo.storeLevel == 0)
         {
            _loc1_ = 0;
         }
         else if(consortiaInfo.storeLevel == 10)
         {
            _loc1_ = 56;
         }
         else
         {
            _loc1_ = consortiaInfo.storeLevel * 5;
         }
         return _loc1_;
      }
      
      public function get baseSkillList() : SimpleDictionary
      {
         return _baseSkillList;
      }
      
      public function set baseSkillList(param1:SimpleDictionary) : void
      {
         _baseSkillList = param1;
      }
      
      public function updataResearchSkill() : void
      {
         for each(var _loc1_:ConsortiaTempleteInfo in _baseSkillList.getList())
         {
            _loc1_.level = consortiaInfo.getLevelByUpgradeType(_loc1_.type);
         }
      }
      
      public function get votingUsers() : Vector.<ConsortiaVotingUserInfo>
      {
         return _votingUsers;
      }
      
      public function set votingUsers(param1:Vector.<ConsortiaVotingUserInfo>) : void
      {
         _votingUsers = param1.sort(compareFun);
         dispatchEvent(new ConsortiaEvent("CONSORTIA_VOTINGLIST_CHANGE"));
      }
      
      private function compareFun(param1:ConsortiaVotingUserInfo, param2:ConsortiaVotingUserInfo) : int
      {
         return param2.votingData - param1.votingData;
      }
      
      public function get hasVoted() : Boolean
      {
         return _hasVoted;
      }
      
      public function set hasVoted(param1:Boolean) : void
      {
         _hasVoted = param1;
      }
      
      public function get currCrossIndex() : int
      {
         return _currCrossIndex;
      }
      
      public function get hasVotePermission() : Boolean
      {
         var _loc3_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc1_:int = _loc3_.consortiaOffer;
         var _loc2_:int = _loc3_.consortiaTotalOffer;
         return _loc2_ >= 100 || _loc1_ >= 100;
      }
      
      public function get openEffectDic() : Dictionary
      {
         if(!_openEffectDic)
         {
            _openEffectDic = new Dictionary();
         }
         return _openEffectDic;
      }
      
      public function getNeedByEffectKey(param1:int) : Boolean
      {
         if(openEffectDic[param1] == null)
         {
            openEffectDic[param1] = true;
         }
         return openEffectDic[param1];
      }
      
      public function getQuestInfoById(param1:int) : ConsortiaQuestInfo
      {
         for each(var _loc2_:ConsortiaQuestInfo in questInfoList)
         {
            if(_loc2_.conditionId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getBusinessInfoBytempId(param1:int) : ConsortiaBusinessInfo
      {
         for each(var _loc2_:ConsortiaBusinessInfo in businessList)
         {
            if(_loc2_.tempId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get taskCanRewardCount() : int
      {
         var _loc1_:int = 0;
         var _loc4_:Array = taskTempDic[2] ? taskTempDic[2] : [];
         var _loc5_:Array = taskTempDic[3] ? taskTempDic[3] : [];
         var _loc3_:Array = _loc4_.concat(_loc5_);
         for each(var _loc2_:ConsortiaQuestTempInfo in _loc3_)
         {
            if(getRewardState(_loc2_,true) == 2)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function getRewardState(param1:ConsortiaQuestTempInfo, param2:Boolean) : int
      {
         var _loc4_:ConsortiaQuestConditionTempInfo = null;
         var _loc5_:ConsortiaQuestInfo = null;
         var _loc3_:BitArray = param2 ? consortiaQuestStateAry : questStateByteAry;
         var _loc6_:Boolean = _loc3_ ? _loc3_.getBit(param1.TemplateId) : false;
         if(_loc6_)
         {
            return 0;
         }
         _loc4_ = TempleteManager.instance.consortiaQuestConditionTempCate.getTemplateByID(param1.TemplateId);
         if(!_loc4_)
         {
            return 1;
         }
         _loc5_ = getQuestInfoById(_loc4_.ConditionId);
         if(_loc5_ && _loc5_.process >= _loc4_.Target)
         {
            return 2;
         }
         return 1;
      }
      
      public function getCommerceShopInfoBytempId(param1:int) : ConsortiaCommerceShopTempInfo
      {
         var _loc3_:Array = TempleteManager.instance.consortiaCommerceShopTempCate.getTempArray();
         for each(var _loc2_:ConsortiaCommerceShopTempInfo in _loc3_)
         {
            if(_loc2_.MapShopId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

