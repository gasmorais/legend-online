package mvc.module.sevenyear
{
   import com.road.yishi.proto.active.anniversary.SevenYearAchievementMsg;
   import com.road.yishi.proto.active.anniversary.SevenYearActiveMsg;
   import com.road.yishi.proto.active.anniversary.SevenYearOrderListMsg;
   import com.road.yishi.proto.active.anniversary.SevenYearQuestionMsg;
   import com.road.yishi.proto.active.anniversary.SevenYearUserMsg;
   import com.road.yishi.proto.module.TreasureBoxMsg;
   import com.road.yishi.proto.module.TreasureBoxUserMsg;
   import events.SevenYearEvent;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import yishi.datas.templates.SevenYearQuestionTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.MessageTipManager;
   
   public class SevenYearModel extends EventDispatcher
   {
      
      public var isOpen:Boolean;
      
      public var beginTime:Date;
      
      public var endTime:Date;
      
      public var snowTeamNum:int;
      
      public var achievementMaxCount:int;
      
      public var achievementMaxScore:int;
      
      public var flagGrade:int;
      
      public var flagScore:int;
      
      public var rewardGrade:int;
      
      public var gameCount:int;
      
      public var answerTotalScore:int;
      
      public var achievementTotalScore:int;
      
      public var snowScore:int;
      
      public var achievements:SimpleDictionary;
      
      public var orders:Array;
      
      public var orderDate:Date;
      
      public var isGamePassed:Boolean = false;
      
      public var questionId:int;
      
      public var optionsArr:Array = [];
      
      public var myAnswer:int;
      
      public var rightAnswer:int;
      
      public var cdTime:int;
      
      public var dropList:Array = [];
      
      public var boxList:SimpleDictionary = new SimpleDictionary();
      
      private var _delayTime:Number = 0;
      
      public var curOpenBoxFrame:Boolean = false;
      
      public var rewardFreeGrade:int;
      
      public var hasBuy:Boolean = false;
      
      public function SevenYearModel()
      {
         super();
         achievements = new SimpleDictionary();
         orders = [];
      }
      
      public function updateActiveInfo(param1:SevenYearActiveMsg) : void
      {
         isOpen = param1.isOpen;
         beginTime = DateFormatter.parse(param1.startDate,"YYYY-MM-DD hh:mm:ss");
         endTime = DateFormatter.parse(param1.stopDate,"YYYY-MM-DD hh:mm:ss");
         dispatchEvent(new SevenYearEvent("UPDATE_ACTIVE_INFO",null));
      }
      
      public function updateUserInfo(param1:SevenYearUserMsg) : void
      {
         flagGrade = param1.flagGrade;
         flagScore = param1.flagScore;
         rewardGrade = param1.rewardGrade;
         rewardFreeGrade = param1.rewardFreeGrade;
         hasBuy = param1.hasBuy;
         gameCount = param1.gameCount;
         if(gameCount == 0)
         {
            isGamePassed = false;
         }
         answerTotalScore = param1.answerTotalScore;
         achievementTotalScore = param1.achievementTotalScore;
         snowScore = param1.snowScore;
         for each(var _loc2_:SevenYearAchievementMsg in param1.achievements)
         {
            achievements.add(_loc2_.type,_loc2_);
         }
         dispatchEvent(new SevenYearEvent("UPDATE_USER_INFO",null));
      }
      
      public function updateOrderInfo(param1:SevenYearOrderListMsg) : void
      {
         orders = param1.orders;
         orders.sortOn("order",16);
         orderDate = DateFormatter.parse(param1.orderDate,"YYYY-MM-DD hh:mm:ss");
         dispatchEvent(new SevenYearEvent("UPDATE_ORDER_INFO",null));
      }
      
      public function updateQuestionInfo(param1:SevenYearQuestionMsg) : void
      {
         questionId = param1.questionId;
         optionsArr = param1.options;
         myAnswer = param1.myAnswer;
         rightAnswer = param1.rightAnswer;
         cdTime = param1.cdTime;
         dispatchEvent(new SevenYearEvent("UPDATE_QUESTION_INFO",null));
      }
      
      public function updateTreasureBoxInfo(param1:TreasureBoxUserMsg) : void
      {
         if(param1.dropList.length > 0)
         {
            dropList = param1.dropList;
         }
         else
         {
            dropList = [];
         }
         for each(var _loc2_:TreasureBoxMsg in param1.boxList)
         {
            boxList.add(_loc2_.templateId,_loc2_);
         }
         dispatchEvent(new SevenYearEvent("UPDATE_TREASUREBOX_INFO",null));
      }
      
      public function get questionTempInfo() : SevenYearQuestionTempInfo
      {
         return TempleteManager.instance.sevenYearQuestionTempCate.getTemplateByID(questionId);
      }
      
      public function get answerTempInfoArr() : Array
      {
         var _loc3_:SevenYearQuestionTempInfo = null;
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < optionsArr.length)
         {
            _loc3_ = TempleteManager.instance.sevenYearQuestionTempCate.getTemplateByID(optionsArr[_loc2_]);
            _loc1_.push(_loc3_);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get delayTime() : Number
      {
         return _delayTime;
      }
      
      public function set delayTime(param1:Number) : void
      {
         _delayTime = param1;
      }
      
      public function get hasFlag() : Boolean
      {
         return true;
      }
      
      public function checkFlag() : Boolean
      {
         if(!hasFlag)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("SevenYearGameView.hint"));
         }
         return hasFlag;
      }
   }
}

