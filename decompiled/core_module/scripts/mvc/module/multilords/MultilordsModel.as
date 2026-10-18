package mvc.module.multilords
{
   import com.road.yishi.proto.timer.TimerInfoMsg;
   import events.MultilordsEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   
   public class MultilordsModel extends EventDispatcher
   {
      
      public static const OPEN:Boolean = true;
      
      public static const OPEN_GRADE:int = 50;
      
      public static const BET_OPEN_GRADE:int = 35;
      
      public static const PROCESS_READY:int = 0;
      
      public static const PROCESS_PRELIM:int = 1;
      
      public static const PROCESS_FINAL:int = 2;
      
      public static const PROCESS_BET:int = 3;
      
      public static const PROCESS_OVER:int = 4;
      
      public static const PROCESS_APPLY:int = 5;
      
      public static const BETTING:int = 1;
      
      public static const LAST_RANK:int = 2;
      
      public static const LAST_AWARD:int = 3;
      
      public static const ACCESS_FINAL:int = 4;
      
      public static const TOP:int = 4;
      
      public static const CUR_BETTING:int = 5;
      
      public static const JOB_TOP3:int = 6;
      
      public static const BATTLE_VIEW:int = 7;
      
      public static const MIN_BET_NUM:int = 600;
      
      public static const MAX_BET_NUM:int = 5000;
      
      public static const MAX_BET_NUM2:int = 25000;
      
      public static const MAX_WIN_RATE:Number = 20;
      
      public static const MIN_WIN_RATE:Number = 1.5;
      
      public static const FAIL_RATE:Number = 1;
      
      public static const DIVIDING_RANK:int = 16;
      
      public static const INSPIRE_MAX:int = 10;
      
      public static const JOIN_CHANGE_EVENT:String = "JOIN_CHANGE_EVENT";
      
      public var period:int;
      
      public var process:int;
      
      public var curRound:int;
      
      public var totalRound:int;
      
      public var isEnterFinal:Boolean;
      
      public var curAwardTotal:int;
      
      public var lastAwardNum:int;
      
      public var selfAwardNum:int;
      
      public var canBetList:Vector.<MultilordsPlayerInfo>;
      
      public var betNum:int;
      
      public var finalRankList:Vector.<MultilordsPlayerInfo>;
      
      public var waitTime:int;
      
      public var rankListCreateDate:Date;
      
      public var lastSelfRank:int;
      
      public var lastPeriod:int;
      
      public var reqAgainTimer:uint;
      
      public var reqAgainCount:int;
      
      public var teamId:String;
      
      public var betOrder:int;
      
      public var inspire:int;
      
      public var hasSignup:Boolean;
      
      public var topServerName:String;
      
      private var _isViewType:Boolean;
      
      private var _selfInfo:MultilordsPlayerInfo;
      
      private var _rewardState:int;
      
      private var _lastAwardList:Vector.<MultilordsPlayerInfo>;
      
      private var _accessFinalList:Vector.<MultilordsPlayerInfo>;
      
      private var _topDic:SimpleDictionary;
      
      private var _jobTop3Dic:SimpleDictionary;
      
      private var _matchDateDic:SimpleDictionary;
      
      private var _bettingDic:SimpleDictionary;
      
      private var _lastRankDic:SimpleDictionary;
      
      private var _battleViewDic:SimpleDictionary;
      
      private var _curBettingDic:SimpleDictionary;
      
      public function MultilordsModel(param1:IEventDispatcher = null)
      {
         super(param1);
         _selfInfo = new MultilordsPlayerInfo();
         _topDic = new SimpleDictionary();
         _jobTop3Dic = new SimpleDictionary();
         _matchDateDic = new SimpleDictionary();
         _bettingDic = new SimpleDictionary();
         _lastRankDic = new SimpleDictionary();
         _battleViewDic = new SimpleDictionary();
         _curBettingDic = new SimpleDictionary();
         var _loc2_:Date = new Date();
         _matchDateDic.add(1,_loc2_);
         _matchDateDic.add(2,_loc2_);
         _matchDateDic.add(3,_loc2_);
         _matchDateDic.add(4,_loc2_);
         _matchDateDic.add(5,_loc2_);
         _matchDateDic.add(6,_loc2_);
      }
      
      public static function getPerPageNum(param1:int) : int
      {
         switch(param1 - 1)
         {
            case 0:
               return 9;
            case 1:
            case 6:
               return 8;
            case 2:
               return 9;
            default:
               return 10;
         }
      }
      
      public static function checkIsTempleGroup(param1:int) : Boolean
      {
         return param1 > 0 && param1 <= 16;
      }
      
      public static function getDisplayRank(param1:int) : int
      {
         if(param1 <= 0)
         {
            return param1;
         }
         if(param1 <= 16)
         {
            return param1;
         }
         return param1 - 16;
      }
      
      public function initTimerInfo(param1:TimerInfoMsg) : void
      {
         var _loc2_:Date = null;
         _loc2_ = DateFormatter.parse(param1.readyOpen,"YYYY-MM-DD hh:mm:ss");
         _matchDateDic.add(1,_loc2_);
         _loc2_ = DateFormatter.parse(param1.readyStop,"YYYY-MM-DD hh:mm:ss");
         _matchDateDic.add(2,_loc2_);
         _loc2_ = DateFormatter.parse(param1.finalOpen,"YYYY-MM-DD hh:mm:ss");
         _matchDateDic.add(3,_loc2_);
         _loc2_ = DateFormatter.parse(param1.finalStop,"YYYY-MM-DD hh:mm:ss");
         _matchDateDic.add(4,_loc2_);
         _loc2_ = new Date(DateFormatter.parse(param1.finalStop,"YYYY-MM-DD hh:mm:ss").time + 345600000);
         _matchDateDic.add(5,_loc2_);
         _loc2_ = DateFormatter.parse(param1.signupTime,"YYYY-MM-DD hh:mm:ss");
         _matchDateDic.add(6,_loc2_);
      }
      
      public function get inspireCost() : int
      {
         var _loc1_:int = 0;
         switch(inspire)
         {
            case 0:
               _loc1_ = 200;
               break;
            case 1:
               _loc1_ = 400;
               break;
            case 2:
               _loc1_ = 600;
               break;
            case 3:
               _loc1_ = 800;
               break;
            case 4:
               _loc1_ = 1200;
               break;
            case 5:
               _loc1_ = 1800;
               break;
            case 6:
               _loc1_ = 2600;
               break;
            case 7:
               _loc1_ = 3600;
               break;
            case 8:
               _loc1_ = 4800;
               break;
            case 9:
               _loc1_ = 6200;
         }
         return _loc1_;
      }
      
      public function get selfInfo() : MultilordsPlayerInfo
      {
         return _selfInfo;
      }
      
      public function get hasBet() : Boolean
      {
         return _bettingDic[betOrder] && betNum > 0;
      }
      
      public function get rewardState() : int
      {
         return _rewardState;
      }
      
      public function set rewardState(param1:int) : void
      {
         if(_rewardState == param1)
         {
            return;
         }
         _rewardState = param1;
         dispatchEvent(new MultilordsEvent("REWARD_STATE_CHANGE"));
      }
      
      public function get lastAwardList() : Vector.<MultilordsPlayerInfo>
      {
         return _lastAwardList;
      }
      
      public function set lastAwardList(param1:Vector.<MultilordsPlayerInfo>) : void
      {
         if(_lastAwardList == param1)
         {
            return;
         }
         _lastAwardList = param1;
         dispatchEvent(new MultilordsEvent("LAST_AWARDLIST_UPDATE"));
      }
      
      public function get accessFinalList() : Vector.<MultilordsPlayerInfo>
      {
         return _accessFinalList;
      }
      
      public function set accessFinalList(param1:Vector.<MultilordsPlayerInfo>) : void
      {
         if(_accessFinalList == param1)
         {
            return;
         }
         _accessFinalList = param1;
         dispatchEvent(new MultilordsEvent("ACCESS_FINALLIST_UPDATE"));
      }
      
      public function getMatchDate(param1:int) : Date
      {
         return _matchDateDic[param1];
      }
      
      public function getMatchDateString(param1:int, param2:String = "DD/MM/YYYY hh:mm") : String
      {
         return DateFormatter.format(_matchDateDic[param1],param2);
      }
      
      public function getMatchDateString1(param1:int, param2:String = "DD/MM/YYYY hh:mm") : String
      {
         return DateFormatter.format(_matchDateDic[param1],"DD/MM/YYYY") + " às " + DateFormatter.format(_matchDateDic[param1],"hh:mm");
      }
      
      public function isExistData(param1:int, param2:int = 0) : Boolean
      {
         switch(param1 - 1)
         {
            case 0:
               return canBetList && canBetList.length > 0;
            case 1:
               return _lastRankDic[param2];
            case 2:
               return _lastAwardList && _lastAwardList.length > 0;
            case 3:
               return _topDic[param2];
            case 4:
               return _curBettingDic[param2];
            case 6:
               return _battleViewDic[param2];
            default:
               return false;
         }
      }
      
      public function getListData(param1:int, param2:int) : Object
      {
         switch(param1 - 1)
         {
            case 0:
               return _bettingDic[param2];
            case 1:
               return _lastRankDic[param2];
            case 3:
               return _topDic[param2];
            case 4:
               return _curBettingDic[param2];
            case 5:
               return _jobTop3Dic[param2];
            case 6:
               return _battleViewDic[param2];
            default:
               return null;
         }
      }
      
      public function addListData(param1:int, param2:int, param3:Object) : void
      {
         switch(param1 - 1)
         {
            case 0:
               if(param2 > 0)
               {
                  if(_bettingDic[param2])
                  {
                     (_bettingDic[param2] as MultilordsPlayerInfo).betRank = 0;
                  }
                  if(param3)
                  {
                     _bettingDic.del((param3 as MultilordsPlayerInfo).betRank);
                     (param3 as MultilordsPlayerInfo).betRank = param2;
                  }
                  _bettingDic.add(param2,param3);
               }
               break;
            case 1:
               _lastRankDic.add(param2,param3);
               break;
            case 3:
               _topDic.add(param2,param3);
               break;
            case 4:
               if(param2 > 0)
               {
                  if(_curBettingDic[param2])
                  {
                     (_curBettingDic[param2] as MultilordsPlayerInfo).betRank = 0;
                  }
                  if(param3)
                  {
                     _curBettingDic.del((param3 as MultilordsPlayerInfo).betRank);
                     (param3 as MultilordsPlayerInfo).betRank = param2;
                  }
                  _curBettingDic.add(param2,param3);
                  dispatchEvent(new MultilordsEvent("CUR_BETTING_CHANGE"));
               }
               break;
            case 5:
               _jobTop3Dic.add(param2,param3);
               break;
            case 6:
               _battleViewDic.add(param2,param3);
         }
      }
      
      public function delListData(param1:int, param2:int) : void
      {
         switch(param1 - 1)
         {
            case 0:
               if(_bettingDic[param2])
               {
                  (_bettingDic[param2] as MultilordsPlayerInfo).betRank = 0;
               }
               _bettingDic.del(param2);
               break;
            case 1:
               _lastRankDic.del(param2);
               break;
            case 3:
               _topDic.del(param2);
               break;
            case 4:
               if(_curBettingDic[param2])
               {
                  (_curBettingDic[param2] as MultilordsPlayerInfo).betRank = 0;
               }
               _curBettingDic.del(param2);
               dispatchEvent(new MultilordsEvent("CUR_BETTING_CHANGE"));
               break;
            case 5:
               _jobTop3Dic.del(param2);
               break;
            case 6:
               _battleViewDic.del(param2);
         }
      }
      
      public function updateBettingByType(param1:int) : void
      {
         var _loc4_:MultilordsPlayerInfo = null;
         switch(param1)
         {
            case 0:
               for each(_loc4_ in _curBettingDic)
               {
                  _loc4_.betRank = 0;
               }
               _curBettingDic.clear();
               for(var _loc3_:String in _bettingDic)
               {
                  _loc4_ = _bettingDic[int(_loc3_)] as MultilordsPlayerInfo;
                  if(_loc4_)
                  {
                     _loc4_.betRank = int(_loc3_);
                  }
               }
               break;
            case 1:
               for each(_loc4_ in _bettingDic)
               {
                  _loc4_.betRank = 0;
               }
               _bettingDic.clear();
               var _loc12_:int = 0;
               var _loc11_:SimpleDictionary = _curBettingDic;
               while(§§hasnext(_loc11_,_loc12_))
               {
                  var _loc2_:String = §§nextname(_loc12_,_loc11_);
                  _bettingDic.add(_loc2_,_curBettingDic[_loc2_]);
               }
         }
      }
      
      public function getBetResult() : Boolean
      {
         var _loc1_:Boolean = false;
         if(_bettingDic[betOrder] && _jobTop3Dic[betOrder] && _bettingDic[betOrder].userKey == _jobTop3Dic[betOrder].userKey && !StringHelper.isNullOrEmpty(_bettingDic[betOrder].userKey))
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function topAvatarChange() : void
      {
         dispatchEvent(new MultilordsEvent("TOP_AVATAR_CHANGE"));
      }
      
      public function beginChanges() : void
      {
      }
      
      public function commitChanges() : void
      {
         dispatchEvent(new MultilordsEvent("INFO_UPDATE"));
      }
      
      public function get isViewType() : Boolean
      {
         return _isViewType;
      }
      
      public function set isViewType(param1:Boolean) : void
      {
         _isViewType = param1;
         dispatchEvent(new Event("JOIN_CHANGE_EVENT"));
      }
   }
}

