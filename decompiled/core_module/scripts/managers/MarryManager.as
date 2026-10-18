package managers
{
   import com.pickgliss.ui.controls.Frame;
   import com.road.yishi.proto.farm.MarriageTreeMsg;
   import com.road.yishi.proto.friend.FriendPlayer;
   import com.road.yishi.proto.friend.RecommendListMsg;
   import com.road.yishi.proto.marriage.EngageMsg;
   import com.road.yishi.proto.marriage.MarriageDataMsg;
   import com.road.yishi.proto.marriage.MarriageHeartMsg;
   import com.road.yishi.proto.marriage.MarriageMsg;
   import com.road.yishi.proto.marriage.MarriageProMsg;
   import com.road.yishi.proto.reward.RewardInfo;
   import com.road.yishi.proto.reward.RewardUpdatedRspMsg;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import marry.view.ProposeBoxView;
   import mvc.controler.MarryController;
   import mvc.module.friends.RecommendInfo;
   import mvc.module.marry.MarryCarInfo;
   import mvc.module.marry.MarryGuestInfo;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarryProposeInfo;
   import mvc.module.marry.MarryQuality;
   import mvc.module.marry.MarryRoomInfo;
   import mvc.module.marry.MarrySender;
   import mvc.module.marry.MarryTask;
   import mvc.module.marry.MarryTreeInfo;
   import mvc.module.marry.feels.MarryHeartInfo;
   import mvc.module.marry.feels.MarryQuestionInfo;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   
   public class MarryManager
   {
      
      private static var _instance:MarryManager;
      
      private var _timer:Timer;
      
      private var TIME_ID:String = "managers.MarryManager";
      
      private var _lastTime:int;
      
      private var _model:MarryModel;
      
      private var _isThinkOver:Boolean;
      
      public var recommendMatesList:Vector.<RecommendInfo> = new Vector.<RecommendInfo>();
      
      private var _proposeBox:ProposeBoxView;
      
      public var removeBoxTimeOut:uint;
      
      public function MarryManager()
      {
         super();
         if(_model == null)
         {
            _model = new MarryModel();
         }
      }
      
      public static function get instance() : MarryManager
      {
         if(!_instance)
         {
            _instance = new MarryManager();
         }
         return _instance;
      }
      
      public function get model() : MarryModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4657,__marryInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4656,__proposeListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4658,__weddingQualityHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4659,__loverInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4662,__roomListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4673,__guestInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4674,__weddingInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4672,__rideHorseHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4675,__marryTaskUpdate);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4678,__marryTreeUpdate);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4690,__marryHeartStartHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4691,__marryHeartQuestionHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 357,__marryPersonalDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 359,__recommendMates);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 358,__consultDivorce);
      }
      
      private function __consultDivorce(param1:SLGSocketEvent) : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("CONSULT_DIVORCE"));
      }
      
      private function __marryHeartStartHandler(param1:SLGSocketEvent) : void
      {
         if(_isThinkOver)
         {
            return;
         }
         SimpleAlertHelper.instance.data = [heartCallback];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("marry.income.MarryHeartFrame.titleText");
         var _loc5_:String = LanguageMgr.GetTranslation("map.space.view.frame.DialogOptionItem.heartTipContent");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,false,true,true);
         _isThinkOver = true;
      }
      
      private function heartCallback(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            MarrySender.opMarryHeartOp(3002);
         }
         _isThinkOver = false;
      }
      
      private function __recommendMates(param1:SLGSocketEvent) : void
      {
         var _loc3_:FriendPlayer = null;
         var _loc6_:RecommendInfo = null;
         var _loc4_:int = 0;
         recommendMatesList.length = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:RecommendListMsg = new RecommendListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as RecommendListMsg;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.girlList.length)
         {
            _loc3_ = _loc2_.girlList[_loc4_] as FriendPlayer;
            _loc6_ = new RecommendInfo();
            _loc6_.id = _loc3_.playerId;
            _loc6_.name = _loc3_.nickName;
            _loc6_.level = _loc3_.level;
            _loc6_.sex = _loc3_.sex;
            _loc6_.attack = _loc3_.attack;
            _loc6_.mapname = _loc3_.mapName;
            _loc6_.vocationGrades = _loc3_.transGrade;
            _loc6_.vocationIndex = _loc3_.changeBranch;
            _loc6_.job = _loc3_.job;
            recommendMatesList.push(_loc6_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.boyList.length)
         {
            _loc3_ = _loc2_.boyList[_loc4_] as FriendPlayer;
            _loc6_ = new RecommendInfo();
            _loc6_.id = _loc3_.playerId;
            _loc6_.name = _loc3_.nickName;
            _loc6_.level = _loc3_.level;
            _loc6_.sex = _loc3_.sex;
            _loc6_.attack = _loc3_.attack;
            _loc6_.mapname = _loc3_.mapName;
            _loc6_.vocationGrades = _loc3_.transGrade;
            _loc6_.vocationIndex = _loc3_.changeBranch;
            _loc6_.job = _loc3_.job;
            recommendMatesList.push(_loc6_);
            _loc4_++;
         }
         FrameControllerManager.instance.openControllerByInfo("marry","SEARCH_MATE");
      }
      
      private function __marryPersonalDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MarriageDataMsg = new MarriageDataMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MarriageDataMsg;
         model.marriageData.userId = _loc2_.userId;
         model.marriageData.type = _loc2_.type;
         model.marriangeState = _loc2_.marriageState;
         if(_loc2_.hasHappy)
         {
            if(_loc2_.happy.hasHappyGp)
            {
               model.marriageData.happyInfo.happyGp = _loc2_.happy.happyGp;
            }
            if(_loc2_.happy.hasHappyGrade)
            {
               model.marriageData.happyInfo.happyGrade = _loc2_.happy.happyGrade;
            }
            if(_loc2_.happy.hasHappyHelp)
            {
               model.marriageData.happyInfo.happyHelp = _loc2_.happy.happyHelp;
            }
         }
         if(_loc2_.hasMateHappy)
         {
            if(_loc2_.mateHappy.hasHappyGp)
            {
               model.marriageData.mateHappyInfo.happyGp = _loc2_.mateHappy.happyGp;
            }
            if(_loc2_.mateHappy.hasHappyGrade)
            {
               model.marriageData.mateHappyInfo.happyGrade = _loc2_.mateHappy.happyGrade;
            }
            if(_loc2_.mateHappy.hasHappyHelp)
            {
               model.marriageData.mateHappyInfo.happyHelp = _loc2_.mateHappy.happyHelp;
            }
         }
         if(_loc2_.hasRing)
         {
            if(_loc2_.ring.hasRingGp)
            {
               model.marriageData.ringInfo.ringGp = _loc2_.ring.ringGp;
            }
            if(_loc2_.ring.hasRingGrade)
            {
               model.marriageData.ringInfo.ringGrade = _loc2_.ring.ringGrade;
            }
            if(_loc2_.ring.hasRingSkill)
            {
               model.marriageData.ringInfo.ringSkill = _loc2_.ring.ringSkill;
            }
         }
         if(_loc2_.hasGodTree)
         {
            if(_loc2_.godTree.hasTreeGp)
            {
               model.marriageData.godTreeInfo.treeGp = _loc2_.godTree.treeGp;
            }
            if(_loc2_.godTree.hasTreeGrade)
            {
               model.marriageData.godTreeInfo.treeGrade = _loc2_.godTree.treeGrade;
            }
            if(_loc2_.godTree.hasTreeState)
            {
               model.marriageData.godTreeInfo.treeState = _loc2_.godTree.treeState;
            }
            if(_loc2_.godTree.hasTreeStateValue)
            {
               model.marriageData.godTreeInfo.treeStateValue = _loc2_.godTree.treeStateValue;
            }
            if(_loc2_.godTree.hasTreeDiamondWater)
            {
               model.marriageData.godTreeInfo.treeDiamondWater = _loc2_.godTree.treeDiamondWater;
            }
            if(_loc2_.godTree.hasTreeGoldWater)
            {
               model.marriageData.godTreeInfo.treeGoldWater = _loc2_.godTree.treeGoldWater;
            }
            if(_loc2_.godTree.hasTreeEarningDate)
            {
               model.marriageData.godTreeInfo.treeEarningDate = _loc2_.godTree.treeEarningDate;
            }
            if(_loc2_.godTree.hasTreeMateState)
            {
               model.marriageData.godTreeInfo.mateTreeState = _loc2_.godTree.treeMateState;
            }
         }
         if(_loc2_.marriageState == 4)
         {
            model.marriageData.mateHappyInfo = null;
         }
         MsgMan.notifyObserver("MarryEventType.MARRIAGE_DATA");
      }
      
      private function __marryHeartQuestionHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:MarriageHeartMsg = new MarriageHeartMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as MarriageHeartMsg;
         var _loc6_:MarryQuestionInfo = new MarryQuestionInfo();
         var _loc5_:MarryHeartInfo = new MarryHeartInfo();
         if(_loc2_.curQuestion)
         {
            _loc6_.order = _loc2_.curQuestion.order;
            _loc6_.options = _loc2_.curQuestion.options.slice();
            _loc6_.optionA = _loc2_.curQuestion.optionA;
            _loc6_.optionB = _loc2_.curQuestion.optionB;
            _loc6_.templateId = _loc2_.curQuestion.templateId;
            _loc6_.result = _loc2_.curQuestion.result;
            _loc6_.remainTime = _loc2_.curQuestion.remainTime;
            _loc6_.random = _loc2_.curQuestion.random;
            _loc5_.curQuestion = _loc6_;
         }
         else
         {
            _loc5_.curQuestion = null;
         }
         _loc5_.maxOrder = _loc2_.maxOrder;
         _loc5_.syncRate = _loc2_.syncRate;
         var _loc3_:int = int(_loc2_.lastQuestions.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = new MarryQuestionInfo();
            _loc6_.order = _loc2_.lastQuestions[_loc4_].order;
            _loc6_.options = _loc2_.lastQuestions[_loc4_].options.slice();
            _loc6_.optionA = _loc2_.lastQuestions[_loc4_].optionA;
            _loc6_.optionB = _loc2_.lastQuestions[_loc4_].optionB;
            _loc6_.templateId = _loc2_.lastQuestions[_loc4_].templateId;
            _loc6_.result = _loc2_.lastQuestions[_loc4_].result;
            _loc6_.random = _loc2_.lastQuestions[_loc4_].random;
            _loc5_.answeredList[_loc6_.order - 1] = _loc6_;
            _loc4_++;
         }
         model.selfMarryInfo.heartInfo = _loc5_;
         MsgMan.notifyObserver("MarryEventType.QUESTION_INFO");
         if(!controller.hasHeartFrame)
         {
            creatHeartFrame();
         }
      }
      
      private function __marryTreeUpdate(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MarriageTreeMsg = new MarriageTreeMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MarriageTreeMsg;
         var _loc4_:MarryTreeInfo = new MarryTreeInfo();
         _loc4_.userIdA = _loc2_.userIdA;
         _loc4_.nickNameA = _loc2_.nickNameA;
         _loc4_.jobA = _loc2_.jobA;
         _loc4_.userIdB = _loc2_.userIdB;
         _loc4_.nickNameB = _loc2_.nickNameB;
         _loc4_.jobB = _loc2_.jobB;
         _loc4_.stateValue = _loc2_.stateValue;
         _loc4_.feedCount = _loc2_.feedCount;
         _loc4_.startString = _loc2_.startTime;
         _loc4_.endString = _loc2_.endTime;
         _loc4_.trainACount = _loc2_.trainACount;
         _loc4_.trainBCount = _loc2_.trainBCount;
         _loc4_.trainAType = _loc2_.trainAType;
         _loc4_.trainBType = _loc2_.trainBType;
         _loc4_.isGetA = _loc2_.isGetA;
         _loc4_.isGetB = _loc2_.isGetB;
         _loc4_.treeState = _loc2_.treeState;
         _loc4_.feedId = _loc2_.feedUser;
         MsgMan.notifyObserver("MarryEventType.TREE_UPDATE",_loc4_);
      }
      
      private function __marryTaskUpdate(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:RewardInfo = null;
         var _loc7_:MarryTask = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:RewardUpdatedRspMsg = new RewardUpdatedRspMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as RewardUpdatedRspMsg;
         var _loc3_:int = int(_loc2_.reward.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_.reward[_loc5_];
            if(model.hasAccessList[_loc4_.templateId])
            {
               _loc7_ = model.hasAccessList[_loc4_.templateId];
               _loc7_.isNew = false;
               if(_loc4_.isComplete || !_loc4_.isAccept)
               {
                  model.hasAccessList.del(_loc4_.templateId);
               }
               else
               {
                  model.hasAccessList[_loc4_.templateId].currTask = _loc4_;
                  _loc7_.changeDate = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
               }
            }
            else
            {
               _loc7_ = new MarryTask();
               _loc7_.marryTaskTemp = RingTaskManager.instance.getRewardTempByTempId(_loc4_.templateId);
               _loc7_.currTask = _loc4_;
               _loc7_.isNew = true;
               _loc7_.index = model.selfMarryInfo.questCount;
               _loc7_.changeDate = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
               model.hasAccessList.add(_loc4_.templateId,_loc7_);
            }
            _loc5_++;
         }
         MsgMan.notifyObserver("MarryEventType.TASK_UPDATE");
      }
      
      private function __rideHorseHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MarriageProMsg = new MarriageProMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MarriageProMsg;
         var _loc4_:MarryCarInfo = new MarryCarInfo();
         _loc4_.userIdA = _loc2_.userIdA;
         _loc4_.nickNameA = _loc2_.nickNameA;
         _loc4_.jobA = _loc2_.property6;
         _loc4_.userIdB = _loc2_.userIdB;
         _loc4_.nickNameB = _loc2_.nickNameB;
         _loc4_.jobB = _loc2_.property7;
         _loc4_.property4 = _loc2_.property4;
         _loc4_.isExist = true;
         model.updateCarList(_loc4_);
         MsgMan.notifyObserver("MarryEventType.CAR_INFO");
      }
      
      private function __weddingInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MarriageProMsg = new MarriageProMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MarriageProMsg;
         model.weddingInfo.userIdA = _loc2_.userIdA;
         model.weddingInfo.nickNameA = _loc2_.nickNameA;
         model.weddingInfo.userIdB = _loc2_.userIdB;
         model.weddingInfo.nickNameB = _loc2_.nickNameB;
         model.weddingInfo.property1 = _loc2_.property1;
         model.weddingInfo.property2 = _loc2_.property2;
         model.weddingInfo.property3 = _loc2_.property3;
         model.weddingInfo.property4 = _loc2_.property4;
         model.weddingInfo.property6 = _loc2_.property6;
         model.weddingInfo.property7 = _loc2_.property7;
         model.weddingInfo.property8 = _loc2_.property8;
         model.weddingInfo.property9 = _loc2_.property9;
         model.weddingInfo.property10 = _loc2_.property10;
         MsgMan.notifyObserver("MarryEventType.WEDDING_STATE");
      }
      
      private function __guestInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:MarriageProMsg = null;
         var _loc4_:int = 0;
         var _loc7_:MarryGuestInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:EngageMsg = new EngageMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as EngageMsg;
         var _loc3_:int = int(_loc2_.engageInfos.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_.engageInfos[_loc4_] as MarriageProMsg;
            _loc7_ = new MarryGuestInfo();
            _loc7_.userIdA = _loc5_.userIdA;
            _loc7_.nickNameA = _loc5_.nickNameA;
            _loc7_.jobA = _loc5_.jobA;
            _loc7_.property1 = _loc5_.property1;
            _loc7_.property2 = _loc5_.property2;
            model.updateGuestDic(_loc7_);
            _loc4_++;
         }
         MsgMan.notifyObserver("MarryEventType.GUEST_INFO");
      }
      
      private function __roomListHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:MarriageProMsg = null;
         var _loc4_:int = 0;
         var _loc7_:MarryRoomInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:EngageMsg = new EngageMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as EngageMsg;
         var _loc3_:int = int(_loc2_.engageInfos.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_.engageInfos[_loc4_] as MarriageProMsg;
            _loc7_ = new MarryRoomInfo();
            _loc7_.userIdA = _loc5_.userIdA;
            _loc7_.nickNameA = _loc5_.nickNameA;
            _loc7_.userIdB = _loc5_.userIdB;
            _loc7_.nickNameB = _loc5_.nickNameB;
            _loc7_.property1 = _loc5_.property1;
            _loc7_.property2 = _loc5_.property2;
            _loc7_.property3 = _loc5_.property3;
            _loc7_.property4 = _loc5_.property4;
            _loc7_.property5 = _loc5_.property5;
            _loc7_.property6 = _loc5_.property6;
            _loc7_.property7 = _loc5_.property7;
            model.updateRoomDic(_loc7_);
            _loc4_++;
         }
         MsgMan.notifyObserver("MarryEventType.ROOM_LIST_INFO");
      }
      
      private function __loverInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MarriageProMsg = new MarriageProMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MarriageProMsg;
         var _loc4_:MarryProposeInfo = new MarryProposeInfo();
         _loc4_.userIdA = _loc2_.userIdA;
         _loc4_.nickNameA = _loc2_.nickNameA;
         _loc4_.property1 = _loc2_.property1;
         _loc4_.property3 = _loc2_.property3;
         _loc4_.property4 = _loc2_.property4;
         _loc4_.property6 = _loc2_.property6;
         MsgMan.notifyObserver("MarryEventType.LOVER_INFO",_loc4_);
      }
      
      private function __marryInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MarriageMsg = new MarriageMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MarriageMsg;
         model.selfMarryInfo.userId = _loc2_.userId;
         model.selfMarryInfo.nickName = _loc2_.nickName;
         model.selfMarryInfo.state = _loc2_.state;
         model.selfMarryInfo.templateId = _loc2_.templateId;
         model.selfMarryInfo.marriageTime = _loc2_.marriageTime;
         model.selfMarryInfo.speTemplateId = _loc2_.speTemplateId;
         model.selfMarryInfo.questCount = _loc2_.questCount;
         model.selfMarryInfo.answerNum = _loc2_.answerNum;
         model.selfMarryInfo.logoutDays = _loc2_.logoutDays;
         model.selfMarryInfo.isBackPlayerFirstMarried = _loc2_.isBackPlayerFirstMarried;
         if(model.getMarryTask())
         {
            model.getMarryTask().index = _loc2_.questCount;
         }
         MsgMan.notifyObserver("MarryEventType.SELF_MARRY_INFO",null);
         NotificationManager.instance.sendNotification("TASK_UPDATE");
         if(int(_loc2_.marriageTime) + 259200 - playerModel.sysCurTimeBySecond > 0)
         {
            NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function checkTime() : void
      {
         _timer = new Timer(60000);
         _timer.addEventListener("timer",onCd);
         _timer.start();
      }
      
      private function onCd(param1:TimerEvent) : void
      {
         _lastTime -= 1;
         if(_lastTime <= 0)
         {
            MarrySender.cancleEngaged(14,1);
            if(_timer)
            {
               _timer.removeEventListener("timer",onCd);
               _timer.stop();
               _timer = null;
            }
         }
      }
      
      private function __weddingQualityHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MarriageProMsg = new MarriageProMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MarriageProMsg;
         var _loc4_:MarryQuality = new MarryQuality();
         _loc4_.qualityId = _loc2_.property2;
         _loc4_.payType = _loc2_.property3;
         _loc4_.opType = 5;
         MarryManager.instance.creatQualityConfirmFrame(_loc4_);
         MsgMan.notifyObserver("MarryEventType.QUALITY_ANSWER",_loc4_);
      }
      
      private function __proposeListHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:MarriageProMsg = null;
         var _loc4_:int = 0;
         var _loc7_:MarryProposeInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:EngageMsg = new EngageMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as EngageMsg;
         var _loc3_:int = int(_loc2_.engageInfos.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_.engageInfos[_loc4_] as MarriageProMsg;
            _loc7_ = new MarryProposeInfo();
            _loc7_.jobA = _loc5_.jobA;
            _loc7_.nickNameA = _loc5_.nickNameA;
            _loc7_.userIdA = _loc5_.userIdA;
            _loc7_.property1 = _loc5_.property1;
            _loc7_.property2 = _loc5_.property2;
            _loc7_.property3 = _loc5_.property3;
            _loc7_.property4 = _loc5_.property4;
            _loc7_.property5 = _loc5_.property5;
            _loc7_.property6 = _loc5_.property6;
            _loc7_.property7 = _loc5_.property7;
            _loc7_.time = DateFormatter.parse(_loc5_.property4,"YYYY-MM-DD hh:mm:ss").time / 1000;
            model.updateProposeList(_loc7_);
            _loc4_++;
         }
         model.updateProposeLen();
         MsgMan.notifyObserver("MarryEventType.PROPOSELIST_UPDATE",null);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function creatProposeAnswerFrame(param1:MarryProposeInfo) : void
      {
         FrameControllerManager.instance.openControllerByInfo("marry","RECEIVE",param1);
      }
      
      public function creatProposeQuestFrame(param1:int) : void
      {
         if(model.isSingle && param1 != playerInfo.userId)
         {
            FrameControllerManager.instance.openControllerByInfo("marry","QUEST",param1);
         }
      }
      
      public function creatSucceedFrame() : void
      {
         if(SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE")
         {
            FrameControllerManager.instance.openControllerByInfo("marry","SUCCEED");
         }
      }
      
      public function creatQualityConfirmFrame(param1:MarryQuality) : void
      {
         var _loc2_:Frame = null;
         if(SceneManager.instance.currentType != "BATTLE_SCENE" && SceneManager.instance.currentType != "WARLORDS_ROOM")
         {
            _loc2_ = FrameControllerManager.instance.marryController.frame;
            if(_loc2_)
            {
               _loc2_.dispose();
            }
            FrameControllerManager.instance.openControllerByInfo("marry","QUALITY_CONFIRM",param1);
         }
      }
      
      public function creatQualitySelectFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("marry","QUALITY_SELECT");
      }
      
      public function creatRoomListFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("marry","ROOM_LIST");
      }
      
      public function creatWeddingRoomSetFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("marry","WEDDING_SET");
      }
      
      public function creatWeddingInvateFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("marry","WEDDING_INVATE");
      }
      
      public function creatRingUpFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("marry","MARRY_TRAIN");
      }
      
      public function creatTreeFosterFrame(param1:int) : void
      {
         FrameControllerManager.instance.openControllerByInfo("marry","TREE_FOSTER",param1);
      }
      
      public function creatTaskMapFrame(param1:GoodsInfo) : void
      {
         FrameControllerManager.instance.openControllerByInfo("marry","TASK_MAP",param1);
      }
      
      public function creatHeartFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("marry","HEART");
      }
      
      private function get controller() : MarryController
      {
         return FrameControllerManager.instance.marryController;
      }
      
      public function createIMMsgBox() : ProposeBoxView
      {
         removeProposeBox();
         if(model.proposeNum > 0)
         {
            _proposeBox = new ProposeBoxView();
            return _proposeBox;
         }
         return null;
      }
      
      public function removeProposeBox() : void
      {
         if(_proposeBox)
         {
            _proposeBox.dispose();
            _proposeBox = null;
         }
      }
   }
}

