package mvc.module.dayGuide
{
   import events.DayGuideEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.DayGuideManager;
   import managers.VIPManager;
   import mvc.module.vip.VIPModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleDictionary;
   
   public class DayGuideCatecory extends EventDispatcher
   {
      
      public static const ACTIVE_CHANGE:String = "ACTIVE_CHANGE";
      
      public static const PROGRESS_CHANGE:String = "PROGRESS_CHANGE";
      
      public static const REWARDPOS_CHANGE:String = "REWARDPOS_CHANGE";
      
      public static const ExtractTimes_CHANGE:String = "ExtractTimes_CHANGE";
      
      public static const BUFF_STOP_DATE:String = "BUFF_STOP_DATE";
      
      public static const WEEK_ACTIVE_CHANGE:String = "ACTIVE_CHANGE";
      
      public static const WEEK_PROGRESS_CHANGE:String = "PROGRESS_CHANGE";
      
      public static const DAILY_LOGIN:int = 1;
      
      public static const WATER_SELF_TREE:int = 2;
      
      public static const WATER_FRIENDS_TREE:int = 3;
      
      public static const PASS_SINGLE_CAMPAIGN:int = 4;
      
      public static const PASS_MUL_CAMPAIGN:int = 5;
      
      public static const INTENSIFY:int = 6;
      
      public static const GET_FRIUT:int = 7;
      
      public static const CONTRIBUTE:int = 8;
      
      public static const OCCUPY_FAILED:int = 9;
      
      public static const PLUNDER:int = 10;
      
      public static const BLESS:int = 12;
      
      public static const PVP:int = 13;
      
      public static const CRUSADE:int = 14;
      
      public static const CONSUME_GIFT_POINT:int = 15;
      
      public static const CONSUME_SMALL_BUGLE:int = 16;
      
      public static const STAR:int = 17;
      
      public static const WORLDBOSS:int = 18;
      
      public static const COLOSSEUM:int = 19;
      
      public static const COMMOMTASK:int = 20;
      
      public static const DESKTOPLOGIN:int = 21;
      
      public static const HOOKROOM:int = 22;
      
      public static const MAZEROOM:int = 23;
      
      public static const OFFERREWARD:int = 24;
      
      public static const FARM_HARVEST:int = 25;
      
      public static const FARM_VISIT:int = 26;
      
      public static const WAR_FIGHT:int = 27;
      
      public static const TRIAL:int = 28;
      
      public static const AMETHYST_FIELD:int = 29;
      
      public static const PET_CHALLENGE:int = 30;
      
      public static const MONOPOLY:int = 31;
      
      public static const FLAMETEMPLE:int = 32;
      
      public static const SEMINARYBLESS:int = 33;
      
      public static const MOLONG:int = 34;
      
      public static const INFERNOMAZE:int = 35;
      
      public static const REMOTE_PET:int = 39;
      
      public static const SINGLE_PASS:int = 40;
      
      public static const SACRIFICE_ROOM:int = 41;
      
      public static const PLANES_WAR:int = 42;
      
      public static const GUARDS_WANTED:int = 43;
      
      public static const MOUNT_CULTIVATE:int = 44;
      
      public static const PET_FEED:int = 45;
      
      public static const TREASURE_HUNT:int = 46;
      
      public static const CHILD_ARENA:int = 47;
      
      public static const JU_HUN:int = 49;
      
      public static const EXP_BACK:int = 50;
      
      public static const CHILD_PATROL:int = 51;
      
      public static const KING_TOWER:int = 52;
      
      public static const BLOODY:int = 53;
      
      public static const CROSS_MUTI:int = 54;
      
      public static const VEHICLE:int = 55;
      
      public static const RING_TASK:int = 56;
      
      public static const CONSORTIA_GVG:int = 57;
      
      public static const CONSORTIA_DEVIL:int = 58;
      
      public static const CONSORTIA_SECRET:int = 59;
      
      public static const CONSORTIA_BOSS:int = 60;
      
      public static const PET_LAND:int = 61;
      
      public static const WORLD_BOSS1:int = 62;
      
      public static const WORLD_BOSS2:int = 63;
      
      public static const ARCHAEOLOGY:int = 64;
      
      public static const CAT_HOUSE:int = 65;
      
      public static const NAVIGATION:int = 66;
      
      public static const OUTYARD:int = 67;
      
      public static const FANTASYMATRIX:int = 68;
      
      public static const PERKIN_LAB:int = 69;
      
      public static const RAPID_THROUGH:int = 70;
      
      public static const CONSORTIA_TREASURE:int = 71;
      
      public static const TITAN_TEMPLES:int = 72;
      
      public static const TIME_GATE:int = 73;
      
      public static const ABYSS_MAW:int = 74;
      
      public static const ALCHEMICAL:int = 75;
      
      public static const UNREALSHOOTING:int = 77;
      
      public static const PLANE_CRISIS:int = 78;
      
      public static const DEUNGEON_TURN:int = 79;
      
      public static const GAME_HALL:int = 80;
      
      public static const REVENGE_ROAD:int = 81;
      
      public static const CONSORTIA_TONGJI:int = 82;
      
      public static const MONSTER_EXPLORE:int = 83;
      
      public static const AUTO_STAR:int = 84;
      
      public static const DEMON_LAND:int = 85;
      
      public static const TIME_VORTEX:int = 86;
      
      public static const LORD_TRIAL:int = 87;
      
      public static const ECLIPTIC_PALACE:int = 88;
      
      public static const CONSORTIA_FUBEN:int = 89;
      
      public static const REDEMPTION_ROAD:int = 90;
      
      public static const INCREASINGLY_ROAD:int = 91;
      
      public static const CHILDNS_SPIRITE_EXPEDITION:int = 92;
      
      public static const CHILD_NS_CAMP:int = 93;
      
      public static const SHADOW_LAND:int = 94;
      
      public static const CHILDESAL:int = 95;
      
      public static const FORBIDDEN_BOSS:int = 96;
      
      public static const GUILD_BOSS:int = 97;
      
      public static const VIP_LOGIN:int = 98;
      
      public static const ACTIVITY_CAMPAIGN:int = 99;
      
      public static const WEEK_CAMPAIGN:int = 100;
      
      public static const OUTYARD_FIGHT:int = 101;
      
      public static const OUTYARD_FIGHT2:int = 102;
      
      public static const GAME_BOX:int = 103;
      
      public static const OUTYARD_EXPLORE:int = 104;
      
      public static const MS_of_Day:int = 86400000;
      
      private var _changeObj:SimpleDictionary;
      
      public var allList:Dictionary;
      
      private var _active:int;
      
      private var _leedProcess:int;
      
      private var _weekActive:int;
      
      private var _weekLeedProcess:int;
      
      private var _rewardTemplateId:int;
      
      private var _leadExtractTimes:int;
      
      private var _buffStopDate:String;
      
      public function DayGuideCatecory()
      {
         super();
         allList = new Dictionary();
         _changeObj = new SimpleDictionary();
      }
      
      public function get buffStopDate() : String
      {
         return _buffStopDate;
      }
      
      public function set buffStopDate(param1:String) : void
      {
         if(param1 != _buffStopDate)
         {
            _buffStopDate = param1;
            _changeObj["BUFF_STOP_DATE"] = true;
         }
      }
      
      public function get unfinishList() : Vector.<LeedInfo>
      {
         var _loc2_:Vector.<LeedInfo> = new Vector.<LeedInfo>();
         for each(var _loc1_:LeedInfo in allList)
         {
            if(!_loc1_.isComplete)
            {
               _loc2_.push(_loc1_);
            }
         }
         _loc2_.sort(sortCompare);
         return _loc2_;
      }
      
      private function sortCompare(param1:LeedInfo, param2:LeedInfo) : int
      {
         if(param1.sort > param2.sort)
         {
            return 1;
         }
         return -1;
      }
      
      public function get finishList() : Vector.<LeedInfo>
      {
         var _loc2_:LeedInfo = null;
         var _loc3_:Vector.<LeedInfo> = new Vector.<LeedInfo>();
         for each(var _loc1_:LeedInfo in allList)
         {
            if(_loc1_.isComplete)
            {
               _loc3_.push(_loc1_);
            }
         }
         if(VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt && VIPManager.Instance.model.vipInfo.VipGrade >= 3)
         {
            _loc2_ = new LeedInfo();
            _loc2_.isComplete = true;
            _loc2_.templateId = -1;
            _loc3_.push(_loc2_);
         }
         return _loc3_;
      }
      
      public function getShowAllList() : Dictionary
      {
         var _loc1_:LeedInfo = null;
         if(VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt && VIPManager.Instance.model.vipInfo.VipGrade >= 3)
         {
            _loc1_ = new LeedInfo();
            _loc1_.isComplete = true;
            _loc1_.templateId = -1;
            allList[-1] = _loc1_;
         }
         return allList;
      }
      
      public function get active() : int
      {
         return _active;
      }
      
      public function set active(param1:int) : void
      {
         if(param1 != _active)
         {
            _active = param1;
            _changeObj["ACTIVE_CHANGE"] = true;
         }
      }
      
      public function get leedProcess() : int
      {
         return _leedProcess;
      }
      
      public function set leedProcess(param1:int) : void
      {
         if(param1 != _leedProcess)
         {
            _leedProcess = param1;
            _changeObj["PROGRESS_CHANGE"] = true;
         }
      }
      
      public function get weekActive() : int
      {
         return _weekActive;
      }
      
      public function set weekActive(param1:int) : void
      {
         if(param1 != _weekActive)
         {
            _weekActive = param1;
            _changeObj["ACTIVE_CHANGE"] = true;
         }
      }
      
      public function get weekLeedProcess() : int
      {
         return _weekLeedProcess;
      }
      
      public function set weekLeedProcess(param1:int) : void
      {
         if(param1 != _weekLeedProcess)
         {
            _weekLeedProcess = param1;
            _changeObj["PROGRESS_CHANGE"] = true;
         }
      }
      
      public function get rewardTemplateId() : int
      {
         return _rewardTemplateId;
      }
      
      public function set rewardTemplateId(param1:int) : void
      {
         _rewardTemplateId = param1;
         _changeObj["REWARDPOS_CHANGE"] = true;
      }
      
      public function get leadExtractTimes() : int
      {
         return _leadExtractTimes;
      }
      
      public function set leadExtractTimes(param1:int) : void
      {
         if(param1 != _leadExtractTimes)
         {
            _leadExtractTimes = param1;
            _changeObj["ExtractTimes_CHANGE"] = true;
         }
      }
      
      public function get hasRewardTimes() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         var _loc1_:DayGuideCatecory = DayGuideManager.instance.cate;
         _loc3_ = 1;
         while(_loc3_ < 6)
         {
            if(_loc1_.canPick(_loc3_) && !_loc1_.hasPick(_loc3_))
            {
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         _loc3_ = 1;
         while(_loc3_ <= 3)
         {
            if(_loc1_.canWeekPick(_loc3_) && !_loc1_.hasWeekPick(_loc3_))
            {
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      public function canPick(param1:int) : Boolean
      {
         if(param1 == 1 && _active >= dayActiveConfigValue[0])
         {
            return true;
         }
         if(param1 == 2 && _active >= dayActiveConfigValue[1])
         {
            return true;
         }
         if(param1 == 3 && _active >= dayActiveConfigValue[2])
         {
            return true;
         }
         if(param1 == 4 && _active >= dayActiveConfigValue[3])
         {
            return true;
         }
         if(param1 == 5 && _active >= dayActiveConfigValue[4])
         {
            return true;
         }
         return false;
      }
      
      public function get anyToPick() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            if(canPick(_loc1_) && !hasPick(_loc1_))
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function hasPick(param1:int) : Boolean
      {
         if(leedProcess >> param1 & 1)
         {
            return true;
         }
         return false;
      }
      
      public function canWeekPick(param1:int) : Boolean
      {
         if(param1 == 1 && _weekActive >= weekActiveConfigValue[0])
         {
            return true;
         }
         if(param1 == 2 && _weekActive >= weekActiveConfigValue[1])
         {
            return true;
         }
         if(param1 == 3 && _weekActive >= weekActiveConfigValue[2])
         {
            return true;
         }
         return false;
      }
      
      public function get anyWeekToPick() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= 3)
         {
            if(canWeekPick(_loc1_) && !hasWeekPick(_loc1_))
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function hasWeekPick(param1:int) : Boolean
      {
         if(weekLeedProcess >> param1 & 1)
         {
            return true;
         }
         return false;
      }
      
      public function hasSigned(param1:Date) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Number = NaN;
         if(param1.fullYear == today.fullYear && param1.month == today.month)
         {
            _loc3_ = param1.date;
            _loc4_ = DateFormatter.getMonthMaxDay(param1.month,param1.fullYear);
            _loc2_ = 1 << _loc4_ - int(param1.date);
            return _loc2_ == (signSite & _loc2_);
         }
         return false;
      }
      
      private function get today() : Date
      {
         return PlayerManager.instance.currentPlayerModel.sysCurtime;
      }
      
      private function get signSite() : int
      {
         return playerInfo.signSite;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function beginChange() : void
      {
         _changeObj.clear();
      }
      
      public function conmmitChange() : void
      {
         if(_changeObj["ACTIVE_CHANGE"] || _changeObj["ACTIVE_CHANGE"])
         {
            dispatchEvent(new DayGuideEvent("ACTIVE_CHANGE"));
         }
         if(_changeObj["PROGRESS_CHANGE"] || _changeObj["PROGRESS_CHANGE"])
         {
            dispatchEvent(new DayGuideEvent("LEED_PROGRESS_CHANGE"));
         }
         if(_changeObj["REWARDPOS_CHANGE"])
         {
            dispatchEvent(new DayGuideEvent("REWARDPOS_CHANGE"));
         }
         if(_changeObj["ExtractTimes_CHANGE"])
         {
            dispatchEvent(new DayGuideEvent("ExtractTimes_CHANGE"));
         }
         if(_changeObj["BUFF_STOP_DATE"])
         {
            dispatchEvent(new DayGuideEvent("BUFF_STOP_DATE"));
         }
      }
      
      public function getLeedRewardTipsStr(param1:int, param2:Boolean) : String
      {
         var _loc5_:int = 0;
         var _loc3_:Array = TempleteManager.instance.leedDropTemplateCate.getTemplatesByIndexAndIsWeek(param1,param2);
         var _loc4_:String = LanguageMgr.GetTranslation("dayguide.LimitedSellView.ActiveBoxItemTips") + "\n";
         if(_loc3_ != null)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               if(_loc5_ == _loc3_.length - 1)
               {
                  if(_loc3_[_loc5_].itemId < 0)
                  {
                     _loc4_ += getGoodsName(_loc3_[_loc5_].itemId) + " x" + _loc3_[_loc5_].count + "";
                  }
                  else if(_loc3_[_loc5_].itemId > 0)
                  {
                     _loc4_ += getGoodsName(_loc3_[_loc5_].itemId) + " x" + _loc3_[_loc5_].count;
                  }
               }
               else if(_loc3_[_loc5_].itemId < 0)
               {
                  _loc4_ += getGoodsName(_loc3_[_loc5_].itemId) + " x" + _loc3_[_loc5_].count + ",\n";
               }
               else if(_loc3_[_loc5_].itemId > 0)
               {
                  _loc4_ += getGoodsName(_loc3_[_loc5_].itemId) + " x" + _loc3_[_loc5_].count + ",\n";
               }
               _loc5_++;
            }
         }
         return _loc4_;
      }
      
      private function getGoodsName(param1:int) : String
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1).TemplateName;
      }
      
      public function get dayActiveConfigValue() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc1_:Array = ConfigInfoManager.instance.getLeedDayConfig();
         var _loc4_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_].split(",");
            _loc4_.push(_loc3_[1]);
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function get weekActiveConfigValue() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc1_:Array = ConfigInfoManager.instance.getLeedWeekConfig();
         var _loc4_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_].split(",");
            _loc4_.push(_loc3_[1]);
            _loc2_++;
         }
         return _loc4_;
      }
   }
}

