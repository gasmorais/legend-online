package mvc.module.gamehall
{
   import com.road.yishi.proto.campaign.SpacePlayerMoveMsg;
   import events.GameHallEvent;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.event.OuterCityEvent;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.GameHallTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class GameHallModel extends EventDispatcher
   {
      
      public static const RAPID_THROUGH:int = 1;
      
      public static const LAND_MINE:int = 2;
      
      public static const PLANE_CRISIS:int = 3;
      
      public static const EAST:int = 4;
      
      public static const FIXED_GROUP_ID:int = 1;
      
      public static const EAST_GROUP_ID:int = 2;
      
      public static const AUTO_REFRESH_LIMIT:int = 30;
      
      public static const HAND_REFRESH_LIMIT:int = 20;
      
      public static const EVENT_FLITER_BUY:String = "EVENT_FLITER_BUY";
      
      public static const PAGE_NUM:int = 5;
      
      public static const OPEN_GROUP:Array = [1];
      
      public var inited:Boolean = false;
      
      public var refreshTime:int = -1;
      
      public var fixedGroupRewardCount:int = 0;
      
      public var hasEarnings:Boolean = false;
      
      public var isLock:Boolean = false;
      
      public var gameId:int;
      
      public var difficulty:int;
      
      public var selectedGameId:int;
      
      public var selectedDifficulty:int;
      
      public var password:String;
      
      public var captainId:int;
      
      public var searchTeam:GameHallTeamInfo;
      
      public var selfTeam:GameHallTeamInfo;
      
      public var teamList:Vector.<GameHallTeamInfo>;
      
      private var _memberFightPos:Array;
      
      public var tickes:int = 30;
      
      public var todayHasGetNum:int;
      
      private var _todayTotalCanBuy:int;
      
      private var _oneBuyCost:int;
      
      public var _oneBuyCanGetTicksNum:int;
      
      private var _allArmysDict:Dictionary;
      
      private var _gameHallDict:Dictionary;
      
      private var _groupCount:int = 0;
      
      public var openEastView:Boolean;
      
      public var eastIsOpen:Boolean;
      
      private var _eastOpenTemplateIdArr:Array = [];
      
      private var _wishArray:Array;
      
      private var _eastLotteryIdArr:Array;
      
      private var _eastInfoArr:Array;
      
      public var eastEndDate:Date;
      
      public var eastOpenDate:Date;
      
      public var num:int;
      
      private var _currentSelected:int = 0;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = 1;
      
      private var _changListDic:Dictionary;
      
      private var _count:int;
      
      private var _buyPrice:int;
      
      private var _effectiveNum:int;
      
      private var _dayLimitBuyNum:int;
      
      public var todayHasBuyBufferNum:int;
      
      public var remainEffectiveNum:int;
      
      public var wishLevelAllZero:Boolean = true;
      
      public function GameHallModel()
      {
         super();
         teamList = new Vector.<GameHallTeamInfo>();
         _memberFightPos = [];
         _allArmysDict = new Dictionary(true);
         _gameHallDict = new Dictionary(true);
         _changListDic = new Dictionary();
         initGameHallTemplate();
         initEastdata();
         initBufferData();
      }
      
      public function get effectiveNum() : int
      {
         return _effectiveNum;
      }
      
      private function initEastdata() : void
      {
         var _loc1_:String = ConfigInfoManager.instance.getEasterTicketConfig();
         var _loc2_:Array = _loc1_.split(",");
         if(_loc2_)
         {
            _oneBuyCost = _loc2_[0];
            _oneBuyCanGetTicksNum = _loc2_[1];
            _todayTotalCanBuy = _loc2_[2];
         }
         var _loc3_:GameHallTemplateInfo = TempleteManager.instance.gameHallTemplateCate.getTemplateByID(4);
         if(_loc3_)
         {
            eastEndDate = DateFormatter.parse(_loc3_.StopDate,"YYYY-MM-DD hh:mm:ss");
            eastOpenDate = DateFormatter.parse(_loc3_.StartDate,"YYYY-MM-DD hh:mm:ss");
         }
      }
      
      private function initBufferData() : void
      {
         var _loc1_:String = ConfigInfoManager.instance.getEasterBufferConfig();
         var _loc2_:Array = _loc1_.split(",");
         if(_loc2_)
         {
            _count = _loc2_[0];
            _buyPrice = _loc2_[1];
            _effectiveNum = _loc2_[2];
            _dayLimitBuyNum = _loc2_[3];
         }
      }
      
      public function get buyPrice() : int
      {
         return _buyPrice;
      }
      
      public function get eastInfoArr() : Array
      {
         return _eastInfoArr;
      }
      
      public function set eastInfoArr(param1:Array) : void
      {
         _eastInfoArr = param1;
      }
      
      public function get eastLotteryIdArr() : Array
      {
         return _eastLotteryIdArr;
      }
      
      public function set eastLotteryIdArr(param1:Array) : void
      {
         _eastLotteryIdArr = param1;
      }
      
      public function get wishArray() : Array
      {
         return _wishArray;
      }
      
      public function set wishArray(param1:Array) : void
      {
         _wishArray = param1;
      }
      
      public function get eastOpenTemplateIdArr() : Array
      {
         return _eastOpenTemplateIdArr;
      }
      
      public function set eastOpenTemplateIdArr(param1:Array) : void
      {
         _eastOpenTemplateIdArr = param1;
         _eastOpenTemplateIdArr.sort(16);
         totalPage = Math.ceil(_eastOpenTemplateIdArr.length / 5);
      }
      
      private function initGameHallTemplate() : void
      {
         var _loc1_:Dictionary = TempleteManager.instance.gameHallTemplateCate.getTemplates();
         for each(var _loc2_:GameHallTemplateInfo in _loc1_)
         {
            if(!_gameHallDict[_loc2_.Group])
            {
               _gameHallDict[_loc2_.Group] = [];
               _groupCount = _groupCount + 1;
            }
            _gameHallDict[_loc2_.Group].push(_loc2_);
         }
      }
      
      public function groupHasNewGame(param1:int) : Boolean
      {
         var _loc6_:GameHallTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc2_:Boolean = false;
         var _loc4_:Array = _gameHallDict[param1];
         var _loc3_:int = int(_loc4_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = _loc4_[_loc5_] as GameHallTemplateInfo;
            if(_loc6_.isNewGame)
            {
               _loc2_ = true;
               break;
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function groupHasValidGame(param1:int) : Boolean
      {
         var _loc6_:GameHallTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc2_:Boolean = false;
         var _loc4_:Array = _gameHallDict[param1];
         if(!_loc4_)
         {
            return false;
         }
         var _loc3_:int = int(_loc4_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = _loc4_[_loc5_] as GameHallTemplateInfo;
            if(isValid(_loc6_.GameId))
            {
               _loc2_ = true;
               break;
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function isOpenToday(param1:int) : Boolean
      {
         var _loc5_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:GameHallTemplateInfo = TempleteManager.instance.gameHallTemplateCate.getTemplateByID(param1);
         var _loc2_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         if(param1 == 4)
         {
            _loc3_ = isValid(4);
         }
         else
         {
            _loc5_ = _loc2_.day;
            if(_loc5_ == 0)
            {
               _loc5_ = 7;
            }
            if(_loc4_)
            {
               if(_loc4_.OpenDays.indexOf(_loc5_.toString()) != -1)
               {
                  _loc3_ = true;
               }
            }
         }
         return _loc3_;
      }
      
      public function isValid(param1:int) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:GameHallTemplateInfo = TempleteManager.instance.gameHallTemplateCate.getTemplateByID(param1);
         var _loc2_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc5_:Date = DateFormatter.parse(_loc4_.StartDate,"YYYY-MM-DD hh:mm:ss");
         var _loc6_:Date = DateFormatter.parse(_loc4_.StopDate,"YYYY-MM-DD hh:mm:ss");
         if(_loc5_.time < _loc2_.time && _loc2_.time < _loc6_.time)
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      public function get groupCount() : int
      {
         return _groupCount;
      }
      
      public function get gameHallDict() : Dictionary
      {
         return _gameHallDict;
      }
      
      public function get isCaptain() : Boolean
      {
         return selfTeam && selfTeam.captainId == PlayerManager.instance.currentPlayerModel.playerInfo.userId;
      }
      
      public function set memberFightPos(param1:Array) : void
      {
         if(_memberFightPos != param1)
         {
            _memberFightPos = param1;
         }
      }
      
      public function get armyFightPos() : Array
      {
         return _memberFightPos;
      }
      
      public function updateSelectedGameInfo() : void
      {
         dispatchEvent(new GameHallEvent("SELECTED_GAME_INFO_UPDATE",this));
      }
      
      public function updateGameInfo() : void
      {
         dispatchEvent(new GameHallEvent("GAME_INFO_UPDATE",this));
      }
      
      public function updateUserInfo() : void
      {
         dispatchEvent(new GameHallEvent("USER_INFO_UPDATE",this));
      }
      
      public function updateShopInfo() : void
      {
         dispatchEvent(new GameHallEvent("UPDATE_SHOPINFO",this));
      }
      
      public function updateCaptainInfo() : void
      {
         dispatchEvent(new GameHallEvent("CAPTAIN_UPDATE",this));
      }
      
      public function updatePasswordInfo() : void
      {
         dispatchEvent(new GameHallEvent("PASSWORD_UPDATE",this));
      }
      
      public function commit() : void
      {
         dispatchEvent(new GameHallEvent("INFO_UPDATE",this));
      }
      
      public function updateWalkTarget(param1:Point) : void
      {
         dispatchEvent(new CampaignMapEvent("UPDATE_WALK_TARGET",param1));
      }
      
      public function updateEastTeamLeftView() : void
      {
         dispatchEvent(new GameHallEvent("UPDATE_EAST_TEAMLEFTVIEW",this));
      }
      
      public function updateWiskInfo() : void
      {
         dispatchEvent(new GameHallEvent("UPDATE_EAST_TEAMLEFTVIEW",this));
      }
      
      public function updateBufferInfo() : void
      {
         dispatchEvent(new GameHallEvent("UPDATE_BUFFERINFO",this));
      }
      
      public function updateAutoBattle() : void
      {
         dispatchEvent(new GameHallEvent("UPDATE_AUTO_BATTLE",this));
      }
      
      public function updateWishInfo() : void
      {
         dispatchEvent(new GameHallEvent("UPDATE_WISHINFO",this));
      }
      
      public function get selfArmy() : GameHallArmy
      {
         return getUserArmyByUserId(ArmyManager.instance.army.userId);
      }
      
      public function get allArmyDict() : Dictionary
      {
         return _allArmysDict;
      }
      
      public function moveArmyTo(param1:SpacePlayerMoveMsg) : void
      {
         dispatchEvent(new CampaignMapEvent("MOVE_PATHS_ARMY",param1));
      }
      
      public function addUserArmy(param1:GameHallArmy) : void
      {
         if(!_allArmysDict[param1.userId])
         {
            _allArmysDict[param1.userId] = param1;
            dispatchEvent(new OuterCityEvent("addGarrison",param1));
         }
         else
         {
            _allArmysDict[param1.userId] = param1;
         }
      }
      
      public function removeUserArmyByArmyId(param1:int) : GameHallArmy
      {
         var _loc2_:GameHallArmy = _allArmysDict[param1];
         if(_loc2_)
         {
            delete _allArmysDict[param1];
            dispatchEvent(new OuterCityEvent("REMOVE_ARMY",_loc2_));
         }
         return _loc2_;
      }
      
      public function getUserArmyByUserId(param1:int) : GameHallArmy
      {
         return _allArmysDict[param1];
      }
      
      public function buyTicks() : void
      {
         if(eastEndDate && PlayerManager.instance.currentPlayerModel.nowDate > eastEndDate.time)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.ActivityManager.command02"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("gamehall.view.buyTick.goodsName");
         if(_todayTotalCanBuy - todayHasGetNum <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("gamehall.view.GameHallEastView.buyTicksTips.enlogh"));
            return;
         }
         SimpleAlertHelper.instance.data = [_buyTicksConfirm];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc1_:String = LanguageMgr.GetTranslation("gamehall.view.GameHallEastView.buyTicksTips",_oneBuyCost,_loc2_,_oneBuyCanGetTicksNum,todayHasGetNum,_todayTotalCanBuy);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc1_,_loc3_,_loc4_);
      }
      
      private function _buyTicksConfirm(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _oneBuyCost)
            {
               RechargeAlertMannager.show();
               return;
            }
            GameHallManager.instance.opEastFrame(1);
         }
      }
      
      public function buyBuffer(param1:Boolean = true) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         if(eastEndDate && PlayerManager.instance.currentPlayerModel.nowDate > eastEndDate.time)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.ActivityManager.command02"));
            return;
         }
         var _loc3_:String = LanguageMgr.GetTranslation("gamehall.view.buyTick.goodsName");
         if(_dayLimitBuyNum - todayHasBuyBufferNum <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("gamehall.view.GameHallEastView.buyTicksTips.enlogh"));
            return;
         }
         if(param1)
         {
            SimpleAlertHelper.instance.data = [_buyBufferConfirm];
            _loc4_ = LanguageMgr.GetTranslation("public.confirm");
            _loc5_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            _loc2_ = LanguageMgr.GetTranslation("gamehall.view.GameHallEastView.buyBufferTips",_buyPrice,_count,_effectiveNum,todayHasBuyBufferNum,_dayLimitBuyNum);
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc2_,_loc4_,_loc5_);
         }
         else
         {
            _buyBufferConfirm(true,true);
         }
      }
      
      private function _buyBufferConfirm(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _buyPrice)
            {
               RechargeAlertMannager.show();
               return;
            }
            GameHallManager.instance.opEastFrame(5);
         }
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
         _changListDic["PAGE_UPDATE"] = true;
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
         currentPage = _totalPage;
         _changListDic["PAGE_UPDATE"] = true;
      }
      
      public function pageBtnHandler(param1:Boolean) : void
      {
         if(param1 && currentPage > 1)
         {
            currentPage = currentPage - 1;
         }
         else
         {
            if(!(!param1 && currentPage < totalPage))
            {
               return;
            }
            currentPage = currentPage + 1;
         }
         commitChange();
      }
      
      private function resetChangListDic() : void
      {
         for(var _loc1_:String in _changListDic)
         {
            _changListDic[_loc1_] = false;
         }
      }
      
      public function commitChange() : void
      {
         if(_changListDic["PAGE_UPDATE"])
         {
            dispatchEvent(new GameHallEvent("PAGE_UPDATE"));
         }
         resetChangListDic();
      }
      
      public function setCurrentPage() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = int(_eastOpenTemplateIdArr.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(difficulty == _eastOpenTemplateIdArr[_loc2_])
            {
               currentPage = Math.ceil((_loc2_ + 1) / 5);
            }
            _loc2_++;
         }
      }
   }
}

