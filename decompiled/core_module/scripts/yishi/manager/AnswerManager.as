package yishi.manager
{
   import com.road.yishi.proto.answerquestion.AnswerquestionReqMsg;
   import com.road.yishi.proto.answerquestion.SysAnswerQuestionStateMsg;
   import com.road.yishi.proto.answerquestion.TenAnswerQuestionOrderMsg;
   import com.road.yishi.proto.answerquestion.answerquestionorderMsg;
   import com.road.yishi.proto.answerquestion.playeranswerquestionMsg;
   import com.road.yishi.proto.answerquestion.singleranswerquestionMsg;
   import events.AnswerEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import manager.LanguageMgr;
   import mvc.module.answer.AnswerData;
   import mvc.module.answer.AnswerItemData;
   import mvc.module.answer.AnswerModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.tips.MessageTipManager;
   
   public class AnswerManager extends EventDispatcher
   {
      
      private static const SCORE_MIN:int = 1;
      
      private static const OPEN_GRADE:int = 30;
      
      private static var _instance:AnswerManager;
      
      private var _operationType:int;
      
      private var _operationValue:int;
      
      private var _isInit:Boolean = false;
      
      private var _isUseEyes:Boolean = false;
      
      private var _isUseHeart:Boolean = false;
      
      private var _isUseDouble:Boolean = false;
      
      private var _isShowRes:Boolean = false;
      
      private var _addSocre:int = 1;
      
      private var _isHasUseHeart:Boolean = false;
      
      private var _isShowReward:Boolean = false;
      
      private var _frameIsOpen:Boolean;
      
      private var _model:AnswerModel;
      
      public function AnswerManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get Instance() : AnswerManager
      {
         if(!_instance)
         {
            _instance = new AnswerManager();
         }
         return _instance;
      }
      
      private function init() : void
      {
         _isInit = _isUseEyes = _isUseHeart = _isUseDouble = false;
         model.curExp = 0;
         model.totalSocre = 0;
      }
      
      public function setup() : void
      {
         model = new AnswerModel();
         initEvent();
      }
      
      public function isOpen() : Boolean
      {
         if(model.state > 0 && ArmyManager.instance.thane.grades >= 30 && ConfigManager.info.ANSWER_SYSTEM)
         {
            return true;
         }
         return false;
      }
      
      public function get frameIsOpen() : Boolean
      {
         return _frameIsOpen;
      }
      
      public function get model() : AnswerModel
      {
         return _model;
      }
      
      public function set model(param1:AnswerModel) : void
      {
         _model = param1;
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4907,__recievePlayerInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4910,__recieveRankListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4909,__recieveSinglerQuestionHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4908,__recieveSystemStateHandler);
         model.addEventListener("SELECT_ANSWER",__onSelectAnswerHandler);
         model.addEventListener("SELECT_ITEM",__onSelectItemHandler);
      }
      
      private function __onSelectAnswerHandler(param1:AnswerEvent) : void
      {
         _operationType = 3;
         _operationValue = model.getIndexByTmp(param1.data);
         model.selectAnswer(param1.data);
         _isUseEyes = true;
         _isUseHeart = true;
         updateItem();
         sendRequestMsg();
         model.dispatchEvent(new AnswerEvent("UPDATE_ANSWER",model.curData));
      }
      
      private function __onSelectItemHandler(param1:AnswerEvent) : void
      {
         var _loc2_:String = null;
         if(model.state <= 1 || model.state >= 5)
         {
            _loc2_ = "";
            _loc2_ = model.state >= 5 ? LanguageMgr.GetTranslation("answer.errinfo.end") : LanguageMgr.GetTranslation("answer.errinfo.unstart");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _operationType = 2;
         var _loc3_:int = -1;
         switch(param1.data)
         {
            case 21:
               if(model.state == 3 || model.state == 2)
               {
                  if(model.doubleCount > 0)
                  {
                     _loc3_ = param1.data;
                     _isUseDouble = true;
                  }
               }
               break;
            case 22:
               if(model.state == 3)
               {
                  if(model.heartCount > 0)
                  {
                     _loc3_ = param1.data;
                     _isUseHeart = true;
                  }
               }
               break;
            case 23:
               if(model.state == 3)
               {
                  if(model.eyeCount > 0)
                  {
                     _loc3_ = param1.data;
                     _isUseEyes = true;
                  }
               }
               break;
            default:
               _loc3_ = param1.data;
         }
         if(_loc3_ == -1)
         {
            return;
         }
         _operationValue = param1.data;
         sendRequestMsg();
      }
      
      private function __recievePlayerInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc3_:playeranswerquestionMsg = new playeranswerquestionMsg();
         _loc3_ = _loc4_.readBody(_loc3_) as playeranswerquestionMsg;
         var _loc6_:Boolean = false;
         model.ranKing = _loc3_.curOrder;
         model.curExp = _loc3_.getEXP;
         model.sucCount = _loc3_.playerAnswerSucCount;
         model.extraExp = _loc3_.extraEXP;
         var _loc2_:Boolean = false;
         if(_isInit)
         {
            if(model.eyeCount > _loc3_.choiceEyesCount)
            {
               _isUseEyes = true;
            }
            if(model.heartCount > _loc3_.wisdomHeartCount)
            {
               _isUseHeart = true;
               _isUseEyes = true;
               _isHasUseHeart = true;
               useHeart();
               model.dispatchEvent(new AnswerEvent("UPDATE_ANSWER",model.curData));
            }
            if(model.doubleCount > _loc3_.doubleBlessCount)
            {
               _isUseDouble = true;
            }
         }
         model.doubleCount = _loc3_.doubleBlessCount;
         model.eyeCount = _loc3_.choiceEyesCount;
         model.heartCount = _loc3_.wisdomHeartCount;
         updateItem();
         if(model.state == 4 && _addSocre == 1)
         {
            _loc5_ = _loc3_.currentScore - model.totalSocre;
            _addSocre = _loc5_ > 0 ? _loc5_ : _addSocre;
            model.totalSocre = _loc3_.currentScore;
         }
         if(!_isInit)
         {
            model.totalSocre = _loc3_.currentScore;
         }
         model.dispatchEvent(new AnswerEvent("UPDATE_SELF_RANK",null));
         if(model.state == 5 && _isShowReward)
         {
            endActive();
            _isShowReward = false;
         }
         _isInit = true;
      }
      
      private function __recieveRankListHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc6_:TenAnswerQuestionOrderMsg = new TenAnswerQuestionOrderMsg();
         _loc6_ = _loc7_.readBody(_loc6_) as TenAnswerQuestionOrderMsg;
         var _loc4_:int = int(_loc6_.tenAQ_Info.length);
         var _loc5_:Object = {};
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = {};
            _loc5_.rank = (_loc6_.tenAQ_Info[_loc3_] as answerquestionorderMsg).curOrder;
            _loc5_.nick = (_loc6_.tenAQ_Info[_loc3_] as answerquestionorderMsg).nickName;
            _loc5_.score = (_loc6_.tenAQ_Info[_loc3_] as answerquestionorderMsg).currentScore;
            _loc2_[_loc3_] = _loc5_;
            _loc3_++;
         }
         model.dispatchEvent(new AnswerEvent("UPDATE_RANK",_loc2_));
      }
      
      private function __recieveSinglerQuestionHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc4_:singleranswerquestionMsg = new singleranswerquestionMsg();
         _loc4_ = _loc7_.readBody(_loc4_) as singleranswerquestionMsg;
         var _loc3_:int = model.curData.index;
         if(_loc3_ == _loc4_.id)
         {
            model.curData.answer = _loc4_.answer;
            if(model.state == 2 || model.state == 3)
            {
               if(model.curData.answer > 10 && _isUseEyes)
               {
                  useEyes();
               }
               else if(model.curData.answer < 10 && _isUseHeart)
               {
                  useHeart();
               }
               model.dispatchEvent(new AnswerEvent("UPDATE_ANSWER",model.curData));
            }
            else if(model.state == 4)
            {
               model.curData.answer = _loc4_.answer;
               model.rightAnswer(model.curData.answer);
               if(model.verAnswerRes() || _isHasUseHeart)
               {
                  updateRes(1,_addSocre);
               }
               else
               {
                  updateRes(0,_addSocre);
               }
               model.dispatchEvent(new AnswerEvent("UPDATE_ANSWER",model.curData));
               _isShowRes = true;
            }
            return;
         }
         var _loc5_:int = 0;
         if(model.state == 2)
         {
            _loc5_ = 4;
            _isHasUseHeart = _isUseEyes = _isUseHeart = _isUseDouble = false;
         }
         var _loc2_:Array = [0,1,2,3];
         var _loc6_:int = 0;
         model.curData.index = _loc4_.id;
         model.curData.topic = _loc4_.question;
         model.curData.answerVec = new Vector.<AnswerData>(4);
         _loc6_ = _loc2_.length * Math.random();
         model.curData.answerVec[_loc2_[_loc6_]] = new AnswerData();
         model.curData.answerVec[_loc2_[_loc6_]].tmpIndex = _loc2_[_loc6_];
         model.curData.answerVec[_loc2_[_loc6_]].index = 1;
         model.curData.answerVec[_loc2_[_loc6_]].info = _loc4_.option1;
         model.curData.answerVec[_loc2_[_loc6_]].state = _loc5_;
         _loc2_.splice(_loc6_,1);
         _loc6_ = _loc2_.length * Math.random();
         model.curData.answerVec[_loc2_[_loc6_]] = new AnswerData();
         model.curData.answerVec[_loc2_[_loc6_]].tmpIndex = _loc2_[_loc6_];
         model.curData.answerVec[_loc2_[_loc6_]].index = 2;
         model.curData.answerVec[_loc2_[_loc6_]].info = _loc4_.option2;
         model.curData.answerVec[_loc2_[_loc6_]].state = _loc5_;
         _loc2_.splice(_loc6_,1);
         _loc6_ = _loc2_.length * Math.random();
         model.curData.answerVec[_loc2_[_loc6_]] = new AnswerData();
         model.curData.answerVec[_loc2_[_loc6_]].tmpIndex = _loc2_[_loc6_];
         model.curData.answerVec[_loc2_[_loc6_]].index = 3;
         model.curData.answerVec[_loc2_[_loc6_]].info = _loc4_.option3;
         model.curData.answerVec[_loc2_[_loc6_]].state = _loc5_;
         _loc2_.splice(_loc6_,1);
         _loc6_ = _loc2_.length * Math.random();
         model.curData.answerVec[_loc2_[_loc6_]] = new AnswerData();
         model.curData.answerVec[_loc2_[_loc6_]].tmpIndex = _loc2_[_loc6_];
         model.curData.answerVec[_loc2_[_loc6_]].index = 4;
         model.curData.answerVec[_loc2_[_loc6_]].info = _loc4_.option4;
         model.curData.answerVec[_loc2_[_loc6_]].state = _loc5_;
         _loc2_.splice(_loc6_,1);
         model.curData.answer = _loc4_.answer;
         model.dispatchEvent(new AnswerEvent("UPDATE_ANSWER",model.curData));
         updateItem();
      }
      
      private function __recieveSystemStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc3_:SysAnswerQuestionStateMsg = new SysAnswerQuestionStateMsg();
         _loc3_ = _loc4_.readBody(_loc3_) as SysAnswerQuestionStateMsg;
         var _loc2_:Boolean = false;
         model.systemTotalNum = _loc3_.sysAnswerCount;
         model.systemLastNum = _loc3_.leftCount;
         if(model.state == 2 && _loc3_.sysState == 3)
         {
            model.askAnswerState();
            model.state = _loc3_.sysState;
            model.dispatchEvent(new AnswerEvent("UPDATE_ANSWER",model.curData));
            model.selectedAnswer = -1;
            _addSocre = 1;
         }
         if(model.state == 3 && _loc3_.sysState == 4)
         {
            model.unSelectedAnswer();
            model.state = _loc3_.sysState;
            model.dispatchEvent(new AnswerEvent("UPDATE_ANSWER",model.curData));
         }
         if(model.state == 4 && _loc3_.sysState == 5)
         {
            _isShowReward = true;
         }
         if(_loc3_.sysState == 5)
         {
            init();
         }
         if(_loc3_.sysState == 0 || model.state == 0)
         {
            model.state = _loc3_.sysState;
            NotificationManager.instance.sendNotification("ANSWER_SWITCH");
         }
         model.state = _loc3_.sysState;
         if(model.state == 2)
         {
            _isShowRes = false;
         }
         model.time = int(_loc3_.lastDate) / 1000 >> 0;
         model.startTime = int(_loc3_.beginDate);
         model.dispatchEvent(new AnswerEvent("UPDATE_STATE",{
            "state":model.state,
            "time":model.time
         }));
      }
      
      private function endActive() : void
      {
         model.dispatchEvent(new AnswerEvent("SHOW_REWARDS",null));
      }
      
      public function updateRes(param1:int, param2:int) : void
      {
         if(model.state == 4)
         {
            model.dispatchEvent(new AnswerEvent("UPDATE_RESULT",{
               "result":param1,
               "score":param2
            }));
         }
      }
      
      private function updateItem() : void
      {
         var _loc1_:Array = [];
         _loc1_[0] = {
            "id":21,
            "count":model.doubleCount,
            "enble":!_isUseDouble && model.doubleCount > 0
         };
         _loc1_[1] = {
            "id":22,
            "count":model.heartCount,
            "enble":!_isUseHeart && model.heartCount > 0
         };
         _loc1_[2] = {
            "id":23,
            "count":model.eyeCount,
            "enble":!_isUseEyes && model.eyeCount > 0
         };
         model.dispatchEvent(new AnswerEvent("UPDATE_ITEM",_loc1_));
      }
      
      private function updateRank() : void
      {
         var _loc2_:int = 0;
         var _loc4_:Object = null;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc4_ = {
               "rank":_loc2_ + 1,
               "nick":"test" + (_loc2_ + 1),
               "score":1000 - _loc2_ * 10
            };
            _loc1_[_loc2_] = _loc4_;
            _loc2_++;
         }
         var _loc3_:AnswerEvent = new AnswerEvent("UPDATE_RANK",_loc1_);
         model.dispatchEvent(_loc3_);
      }
      
      private function updateAnswerItem() : void
      {
         var _loc4_:AnswerData = null;
         var _loc2_:int = 0;
         var _loc3_:AnswerItemData = new AnswerItemData();
         _loc3_.topic = "测试! 能看到几个答案!";
         var _loc1_:Array = ["A","B","C","D"];
         var _loc5_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc4_ = new AnswerData();
            _loc5_ = _loc1_.length * Math.random();
            _loc4_.index = _loc1_[_loc5_];
            _loc1_.splice(_loc5_,1);
            _loc4_.info = "第" + (_loc2_ + 1) + "个答案!!!!!!";
            _loc4_.tmpIndex = _loc2_;
            _loc4_.state = Math.random() * 5;
            _loc3_.answerVec[_loc2_] = _loc4_;
            _loc2_++;
         }
         model.curData = _loc3_;
         model.dispatchEvent(new AnswerEvent("UPDATE_ANSWER",_loc3_));
      }
      
      private function useHeart() : void
      {
         _isUseEyes = true;
         model.useHeart();
         updateItem();
      }
      
      private function useEyes() : void
      {
         model.delErrorAnswer();
         updateItem();
      }
      
      public function sendRequestOpenUI() : void
      {
         _operationType = 1;
         _operationValue = 11;
         _frameIsOpen = true;
         if(model.state == 4 && _isShowRes)
         {
            if(model.verAnswerRes() || _isUseHeart)
            {
               updateRes(1,_addSocre);
            }
            else
            {
               updateRes(0,_addSocre);
            }
            model.dispatchEvent(new AnswerEvent("UPDATE_ANSWER",model.curData));
         }
         model.dispatchEvent(new AnswerEvent("UPDATE_SELF_RANK",null));
         sendRequestMsg();
      }
      
      public function sendRequestCloseUI() : void
      {
         _isInit = false;
         _frameIsOpen = false;
         _operationType = 1;
         _operationValue = 12;
         sendRequestMsg();
      }
      
      public function sendRequestMsg() : void
      {
         var _loc2_:PackageOut = new PackageOut(9501);
         var _loc1_:AnswerquestionReqMsg = new AnswerquestionReqMsg();
         _loc1_.type = _operationType;
         _loc1_.count = _operationValue;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
   }
}

