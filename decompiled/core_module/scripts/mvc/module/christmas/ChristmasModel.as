package mvc.module.christmas
{
   import com.road.yishi.proto.christmas.ConsumptionRewardInfoMsg;
   import com.road.yishi.proto.christmas.SnowyMistMsg;
   import com.road.yishi.proto.christmas.SnowyMistTeamPlayerMsg;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ChristmasAchievementsTempInfo;
   import yishi.datas.templates.ChristmasActivitiesTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class ChristmasModel
   {
      
      public var isOpen:Boolean;
      
      public var openTime:String;
      
      public var stopTime:String;
      
      public var type:int;
      
      public var score:int;
      
      public var totalCharge:int;
      
      public var lotteryCount:int;
      
      public var dayCharge:int;
      
      public var giftBuyInfo:String = "";
      
      public var dayOnline:int;
      
      public var onlineDate:String;
      
      public var luckCount:int;
      
      public var luckNum:int;
      
      public var result:String = "";
      
      public var isLight:int;
      
      public var jackpotRewardInfo:String = "";
      
      public var totalConsume:int;
      
      private var _scoreRewardInfo:String;
      
      private var _scoreRewardInfoList:Array = [];
      
      public var consumptionRewardDic:Dictionary = new Dictionary();
      
      public var isHirting:Boolean = false;
      
      public var hirtTempId:int = 0;
      
      public var taskDic:Dictionary = new Dictionary();
      
      public var topicId:int;
      
      public var surplusSeconds:int;
      
      public var choiceNum:int;
      
      public var choiceRightNum:int;
      
      public var optionANum:int;
      
      public var optionBNum:int;
      
      public var myOption:int;
      
      public var rewardInfo:String = "";
      
      public var answerCorrectNum:int;
      
      public var opType:int;
      
      public var snowyMistList:Array = [];
      
      public var selecedNodeId:int = -99;
      
      public function ChristmasModel()
      {
         super();
      }
      
      public function set scoreRewardInfo(param1:String) : void
      {
         if(_scoreRewardInfo == param1)
         {
            return;
         }
         _scoreRewardInfo = param1;
         if(_scoreRewardInfo != null && _scoreRewardInfo.length > 0)
         {
            _scoreRewardInfoList = _scoreRewardInfo.split(",");
         }
      }
      
      public function get scoreRewardInfoList() : Array
      {
         return _scoreRewardInfoList;
      }
      
      public function set consumptionRewardList(param1:Array) : void
      {
         for each(var _loc2_:ConsumptionRewardInfoMsg in param1)
         {
            consumptionRewardDic[_loc2_.itemId] = _loc2_;
         }
      }
      
      public function get selfSnowyMist() : SnowyMistMsg
      {
         return snowyMistList[0];
      }
      
      public function get selfPlayer() : SnowyMistTeamPlayerMsg
      {
         for each(var _loc1_:SnowyMistTeamPlayerMsg in selfSnowyMist.teamPlayers)
         {
            if(_loc1_.userId == playerInfo.userId)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function get openTimeStr() : String
      {
         var _loc1_:Date = DateFormatter.parse(openTime,"YYYY-MM-DD hh:mm:ss");
         return DateFormatter.format(_loc1_,LanguageMgr.GetTranslation("christmasModel.timeStr.txt"));
      }
      
      public function get stopTimeStr() : String
      {
         var _loc1_:Date = DateFormatter.parse(stopTime,"YYYY-MM-DD hh:mm:ss");
         return DateFormatter.format(_loc1_,LanguageMgr.GetTranslation("christmasModel.timeStr.txt"));
      }
      
      public function get isPrayRed() : Boolean
      {
         var _loc2_:int = 0;
         var _loc4_:int = ConfigInfoManager.instance.christmasLight;
         var _loc3_:int = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc4_);
         var _loc1_:Array = TempleteManager.instance.christmasActivitiesTempCate.getTemplatesByType(1);
         if(_loc1_.length > 0)
         {
            _loc2_ = (_loc1_[0] as ChristmasActivitiesTempInfo).Para1;
         }
         return _loc3_ >= _loc2_ && !isLight;
      }
      
      public function get isGiftRed() : Boolean
      {
         var _loc1_:Array = TempleteManager.instance.christmasActivitiesTempCate.getTemplatesByType(2);
         var _loc2_:int = (_loc1_[0] as ChristmasActivitiesTempInfo).Id;
         return giftBuyInfo.indexOf(_loc2_.toString()) == -1;
      }
      
      public function get isAnswerRed() : Boolean
      {
         var _loc4_:ChristmasActivitiesTempInfo = null;
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         var _loc1_:Array = TempleteManager.instance.christmasActivitiesTempCate.getTemplatesByType(3);
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_];
            if(rewardInfo.indexOf(_loc4_.Id.toString()) == -1 && answerCorrectNum >= _loc4_.Para1)
            {
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get isLuckyRed() : Boolean
      {
         return luckCount > 0;
      }
      
      public function get isHirtRed() : Boolean
      {
         var _loc5_:ChristmasActivitiesTempInfo = null;
         var _loc4_:int = 0;
         var _loc2_:ConsumptionRewardInfoMsg = null;
         var _loc3_:Boolean = false;
         var _loc1_:Array = TempleteManager.instance.christmasActivitiesTempCate.getTemplatesByType(5);
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = _loc1_[_loc4_];
            if(totalConsume >= _loc5_.Para1)
            {
               _loc2_ = consumptionRewardDic[_loc5_.Id];
               if(_loc2_.isGetReward == 0)
               {
                  _loc3_ = true;
                  break;
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function get isChengjiuRed() : Boolean
      {
         var _loc8_:ChristmasAchievementsTempInfo = null;
         var _loc6_:ChristmasTaskInfo = null;
         var _loc4_:int = 0;
         var _loc3_:ChristmasActivitiesTempInfo = null;
         var _loc5_:int = 0;
         var _loc2_:Boolean = false;
         var _loc7_:Array = TempleteManager.instance.christmasAchievementsTempCate.getTaskList();
         _loc4_ = 0;
         while(_loc4_ < _loc7_.length)
         {
            _loc8_ = _loc7_[_loc4_];
            _loc6_ = taskDic[_loc8_.Id];
            if(_loc6_ && !_loc6_.isReward && _loc6_.data >= _loc8_.Para)
            {
               _loc2_ = true;
               break;
            }
            _loc4_++;
         }
         var _loc1_:Array = TempleteManager.instance.christmasActivitiesTempCate.getTemplatesByType(6);
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc5_];
            if(scoreRewardInfoList.indexOf(_loc3_.Id.toString()) == -1 && score >= _loc3_.Para1)
            {
               _loc2_ = true;
               break;
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function get redCount() : int
      {
         var _loc1_:int = 0;
         if(isPrayRed)
         {
            _loc1_++;
         }
         if(isGiftRed)
         {
            _loc1_++;
         }
         if(isAnswerRed)
         {
            _loc1_++;
         }
         if(isLuckyRed)
         {
            _loc1_++;
         }
         if(isHirtRed)
         {
            _loc1_++;
         }
         if(isChengjiuRed)
         {
            _loc1_++;
         }
         return _loc1_;
      }
   }
}

