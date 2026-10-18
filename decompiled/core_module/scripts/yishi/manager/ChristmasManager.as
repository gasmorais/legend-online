package yishi.manager
{
   import com.road.yishi.proto.christmas.ChristmasAnswersMsg;
   import com.road.yishi.proto.christmas.ChristmasMsg;
   import com.road.yishi.proto.christmas.ChristmasTaskListMsg;
   import com.road.yishi.proto.christmas.ChristmasTaskMsg;
   import com.road.yishi.proto.christmas.SnowyMistRefreshMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.events.EventDispatcher;
   import mvc.module.christmas.ChristmasModel;
   import mvc.module.christmas.ChristmasTaskInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   
   public class ChristmasManager extends EventDispatcher
   {
      
      private static var _instance:ChristmasManager;
      
      public static const EVENT_UPDATE:String = "EVENT_UPDATE";
      
      public static const ANSWER_UPDATE:String = "ANSWER_UPDATE";
      
      public static const TASK_UPDATE:String = "christmas.TASK_UPDATE";
      
      public static const SNOWYMIST_UPDATE:String = "SNOWYMIST_UPDATE";
      
      public static const OP_OPEN:int = 1;
      
      public static const OP_LOTTERY_NUM:int = 2;
      
      public static const OP_BUY_GIFT:int = 3;
      
      public static const OP_LIGHT:int = 4;
      
      public static const OP_WISH:int = 5;
      
      public static const OP_JACKPOT:int = 6;
      
      public static const OP_CONSUMPTION:int = 7;
      
      public static const OP_START_ANSWER:int = 8;
      
      public static const OP_CHOICE_ANSWER:int = 10;
      
      public static const OP_ANSWER_GET_REWARD:int = 12;
      
      public static const OP_TASK_REWARD:int = 13;
      
      public static const OP_SCORE_REWARD:int = 14;
      
      public static const OP_END_ANSWER:int = 15;
      
      public static const OP_TEAM_LIST:int = 16;
      
      public static const OP_TEAM_CREATE:int = 17;
      
      public static const OP_TEAM_JOIN:int = 18;
      
      public static const OP_TEAM_LEAVE:int = 19;
      
      public static const OP_TEAM_KICK:int = 20;
      
      public static const OP_TEAM_START:int = 21;
      
      public static const OP_TEAM_CLICK:int = 22;
      
      public static const OP_TASK_REFRESH:int = 23;
      
      private var _model:ChristmasModel;
      
      public function ChristmasManager()
      {
         super();
      }
      
      public static function get instance() : ChristmasManager
      {
         if(!_instance)
         {
            _instance = new ChristmasManager();
         }
         return _instance;
      }
      
      public function get model() : ChristmasModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new ChristmasModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 558,__activeInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 559,__taskInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 560,__answerInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 567,__snowymistInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4590,__topBtnHandler);
      }
      
      private function __topBtnHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.param1 == 4030)
         {
            model.isOpen = _loc2_.param7;
            model.openTime = _loc2_.param4;
            model.stopTime = _loc2_.param5;
            NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
         }
      }
      
      private function __activeInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChristmasMsg = new ChristmasMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChristmasMsg;
         _model.type = _loc2_.opType;
         _model.score = _loc2_.score;
         _model.scoreRewardInfo = _loc2_.scoreRewardInfo;
         _model.totalCharge = _loc2_.totalCharge;
         _model.lotteryCount = _loc2_.lotteryCount;
         _model.dayCharge = _loc2_.dayCharge;
         _model.giftBuyInfo = _loc2_.giftBuyInfo;
         _model.dayOnline = _loc2_.dayOnline;
         _model.onlineDate = _loc2_.onlineDate;
         _model.luckCount = _loc2_.luckCount;
         _model.luckNum = _loc2_.luckNum;
         _model.result = _loc2_.result;
         _model.isLight = _loc2_.isLight;
         _model.jackpotRewardInfo = _loc2_.jackpotRewardInfo;
         _model.consumptionRewardList = _loc2_.consumptionRewardList;
         _model.totalConsume = _loc2_.totalConsume;
         this.dispatchEvent(new NotificationEvent("EVENT_UPDATE"));
      }
      
      private function __taskInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:ChristmasTaskInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChristmasTaskListMsg = new ChristmasTaskListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ChristmasTaskListMsg;
         for each(var _loc3_:ChristmasTaskMsg in _loc2_.tasks)
         {
            _loc5_ = _model.taskDic[_loc3_.taskId];
            if(_loc5_ == null)
            {
               _loc5_ = new ChristmasTaskInfo();
               _model.taskDic[_loc3_.taskId] = _loc5_;
            }
            _loc5_.taskId = _loc3_.taskId;
            _loc5_.data = _loc3_.data;
            _loc5_.isReward = _loc3_.isReward;
         }
         this.dispatchEvent(new NotificationEvent("christmas.TASK_UPDATE"));
      }
      
      private function __answerInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChristmasAnswersMsg = new ChristmasAnswersMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChristmasAnswersMsg;
         _model.topicId = _loc2_.topicId;
         _model.surplusSeconds = _loc2_.surplusSeconds;
         _model.choiceNum = _loc2_.choiceNum;
         _model.choiceRightNum = _loc2_.choiceRightNum;
         _model.optionANum = _loc2_.optionANum;
         _model.optionBNum = _loc2_.optionBNum;
         _model.myOption = _loc2_.myOption;
         _model.rewardInfo = _loc2_.rewardInfo;
         _model.answerCorrectNum = _loc2_.answerCorrectNum;
         this.dispatchEvent(new NotificationEvent("ANSWER_UPDATE"));
      }
      
      private function __snowymistInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:Array = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SnowyMistRefreshMsg = new SnowyMistRefreshMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as SnowyMistRefreshMsg;
         _model.opType = _loc2_.opType;
         _model.snowyMistList = _loc2_.snowyMistList;
         if(_model.selfSnowyMist)
         {
            _loc3_ = _model.selfSnowyMist.map;
            if(_loc3_)
            {
               _loc3_.sortOn("nodeId",16);
            }
         }
         this.dispatchEvent(new NotificationEvent("SNOWYMIST_UPDATE"));
      }
      
      public function opRequest(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(9217);
         var _loc4_:PlayerOpMsg = new PlayerOpMsg();
         _loc4_.op = param1;
         _loc4_.id = param2;
         _loc4_.type = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
   }
}

