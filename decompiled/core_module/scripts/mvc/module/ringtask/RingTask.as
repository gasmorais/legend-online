package mvc.module.ringtask
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   import com.road.yishi.proto.reward.RewardInfo;
   import events.PawnEvent;
   import events.RingTaskEvent;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import managers.RingTaskManager;
   import mvc.module.armyII.ArmyPawn;
   import org.events.DictionaryEvent;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.datas.templates.OfferRewardTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   
   public class RingTask extends EventDispatcher implements INotSameHeightListCellData
   {
      
      public var sortFlag:Boolean;
      
      private var _ringTaskTemp:OfferRewardTemplate;
      
      private var _currTaskId:int;
      
      private var _currTask:RewardInfo;
      
      public var TemplateType:int = -2;
      
      private var _progress:Array;
      
      private var _conditionList:Array;
      
      private var _rewardList:Array;
      
      public var hasCompleted:Boolean = false;
      
      private var _changeDate:Number;
      
      public var Sort:Number = 0;
      
      public var isNew:Boolean;
      
      private var _rewardGoodsList:Array;
      
      private var _talkTaskState:Boolean = false;
      
      private var _qteResult:Boolean = false;
      
      private var _pawnsNum:int = -1;
      
      private var _hamsterGameResult:Boolean = false;
      
      public function RingTask()
      {
         super();
      }
      
      public function get rewardGoodsList() : Array
      {
         return _rewardGoodsList;
      }
      
      public function set rewardGoodsList(param1:Array) : void
      {
         _rewardGoodsList = param1;
      }
      
      public function get Title() : String
      {
         return _ringTaskTemp.Title;
      }
      
      public function get conditionList() : Array
      {
         return _ringTaskTemp.conditionList;
      }
      
      public function get rewardList() : Array
      {
         return _ringTaskTemp.rewardItemList;
      }
      
      public function get ringTaskTemp() : OfferRewardTemplate
      {
         return _ringTaskTemp;
      }
      
      public function set ringTaskTemp(param1:OfferRewardTemplate) : void
      {
         _ringTaskTemp = param1;
      }
      
      public function get currTaskId() : int
      {
         return _currTaskId;
      }
      
      public function set currTaskId(param1:int) : void
      {
         _currTaskId = param1;
      }
      
      public function get currTask() : RewardInfo
      {
         return _currTask;
      }
      
      public function set currTask(param1:RewardInfo) : void
      {
         _currTask = param1;
      }
      
      public function getProgress() : Array
      {
         var _loc4_:int = 0;
         var _loc1_:String = null;
         var _loc2_:OfferRewardConditionTemplate = null;
         var _loc5_:Array = [];
         var _loc3_:int = int(ringTaskTemp.conditionList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = ringTaskTemp.conditionList[_loc4_];
            switch(_loc2_.CondictionType)
            {
               case 1:
                  _loc1_ = checkPawnsCount(_loc2_);
                  break;
               case 2:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 3:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 4:
                  _loc1_ = checkGoodsCount(_loc2_);
                  break;
               case 5:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 6:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 7:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 8:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 9:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 10:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 11:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 12:
                  _loc1_ = checkQteResult();
                  break;
               case 13:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 14:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 15:
                  _loc1_ = checkHamsterGameResult(_loc2_);
                  break;
               case 16:
                  _loc1_ = checkTalkSetp();
                  break;
               case 17:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 18:
                  _loc1_ = checkDuplicatemonster(currTask.condition_1,currTask.condition_4);
                  break;
               case 19:
                  _loc1_ = checkGoodsCount2(currTask.condition_3);
                  break;
               case 20:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               default:
                  _loc1_ = LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
            }
            _loc5_[_loc4_] = _loc1_;
            _loc4_++;
         }
         return _loc5_;
      }
      
      private function checkDuplicatemonster(param1:int, param2:int) : String
      {
         var _loc3_:String = "";
         if(param1 >= param2)
         {
            _loc3_ = LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         else
         {
            _loc3_ = "(" + param1 + " / " + param2 + ")";
         }
         return _loc3_;
      }
      
      public function get NeedFightId() : int
      {
         return _ringTaskTemp.NeedFightId;
      }
      
      private function checkGoodsCount2(param1:int) : String
      {
         var _loc2_:String = "";
         if(getflag(param1))
         {
            _loc2_ = LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         else
         {
            hasCompleted = false;
            _loc2_ = "(0 / 1)";
         }
         return _loc2_;
      }
      
      public function set changeDate(param1:Number) : void
      {
         _changeDate = param1;
      }
      
      public function get changeDate() : Number
      {
         return _changeDate;
      }
      
      public function get talkTaskState() : Boolean
      {
         return _talkTaskState;
      }
      
      public function set talkTaskState(param1:Boolean) : void
      {
         if(_talkTaskState == param1)
         {
            return;
         }
         _talkTaskState = param1;
         if(_talkTaskState)
         {
            commit();
            RingTaskManager.instance.updataState();
         }
      }
      
      public function checkTalkSetp() : String
      {
         var _loc1_:String = "";
         if(currTask)
         {
            if(_talkTaskState)
            {
               _loc1_ = LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
            else
            {
               hasCompleted = false;
               _loc1_ = LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
            }
            if(currTask.condition_1 >= 1)
            {
               hasCompleted = true;
               _loc1_ = LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
         }
         return _loc1_;
      }
      
      public function get isCompleted() : Boolean
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         if(ringTaskTemp.Type == 3)
         {
            return false;
         }
         _loc1_ = getProgress();
         _loc2_ = 0;
         while(ringTaskTemp.conditionList[_loc2_] != null)
         {
            if(_loc1_[_loc2_] != LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress"))
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function get qteResult() : Boolean
      {
         return _qteResult;
      }
      
      public function set qteResult(param1:Boolean) : void
      {
         if(_qteResult == param1)
         {
            return;
         }
         _qteResult = param1;
         if(_qteResult)
         {
            commit();
            RingTaskManager.instance.updataState();
         }
      }
      
      private function checkQteResult() : String
      {
         if(_qteResult)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function __pawnsChangeHandler(param1:PawnEvent) : void
      {
         var _loc3_:ArmyPawn = param1.data as ArmyPawn;
         var _loc2_:int = ArmyManager.instance.getTotalPawnsNumberBySonType(_loc3_.templateInfo.SonType);
         if(_pawnsNum != _loc2_ && (_pawnsNum < conditionList[0].Para2 || _loc2_ < conditionList[0].Para2))
         {
            if(_loc2_ < conditionList[0].Para2)
            {
               hasCompleted = false;
            }
            else
            {
               hasCompleted = true;
               RingTaskManager.instance.updataState();
            }
            _pawnsNum = _loc2_;
            commit();
         }
      }
      
      private function checkPawnsCount(param1:OfferRewardConditionTemplate) : String
      {
         var _loc2_:int = ArmyManager.instance.getTotalPawnsNumberBySonType(param1.Para1);
         if(_loc2_ >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + String(_loc2_) + "/" + String(param1.Para2) + ")";
      }
      
      public function get hamsterGameResult() : Boolean
      {
         return _hamsterGameResult;
      }
      
      public function set hamsterGameResult(param1:Boolean) : void
      {
         if(_hamsterGameResult == param1)
         {
            return;
         }
         _hamsterGameResult = param1;
         if(_hamsterGameResult)
         {
            commit();
            RingTaskManager.instance.updataState();
         }
      }
      
      private function checkHamsterGameResult(param1:OfferRewardConditionTemplate) : String
      {
         if(_hamsterGameResult)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(0 / " + param1.Para2 + ")";
      }
      
      private function checkGoodsCount(param1:OfferRewardConditionTemplate) : String
      {
         var _loc2_:int = int(GoodsManager.instance.goodsCountByTempId[param1.Para1]);
         _loc2_ += getCount(param1.Para1);
         if(_loc2_ >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + _loc2_ + " / " + param1.Para2 + ")";
      }
      
      public function commit() : void
      {
         ringTaskManager.dispatchEvent(new RingTaskEvent("REFRESHTING",this));
      }
      
      public function addConditionListener() : void
      {
         for each(var _loc1_:OfferRewardConditionTemplate in conditionList)
         {
            addListenerByCondition(_loc1_);
         }
      }
      
      private function checkCount(param1:OfferRewardConditionTemplate, param2:int) : String
      {
         if(currTask)
         {
            if(currTask["condition_" + (param2 + 1)] >= param1.Para2)
            {
               return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
            return "(" + currTask["condition_" + (param2 + 1)] + " / " + param1.Para2 + ")";
         }
         return "";
      }
      
      public function removeConditionListener() : void
      {
         goodsCountByTempId.removeEventListener("addDictionary",__goodsChangeHandler);
         goodsCountByTempId.removeEventListener("deleteDictionary",__goodsChangeHandler);
         goodsCountByTempId.removeEventListener("updateDictionary",__goodsChangeHandler);
         goodsCountByTempId.removeEventListener("addDictionary",__goodsChangeHandler2);
         goodsCountByTempId.removeEventListener("updateDictionary",__goodsChangeHandler2);
         NotificationManager.instance.removeEventListener("TALKRINGTASK_COMPLETE",__talkTaskComplete);
         for each(var _loc1_:ArmyPawn in ArmyManager.instance.castlePawnList)
         {
            _loc1_.removeEventListener("pawnProppertyChager",__pawnsChangeHandler);
         }
      }
      
      private function addListenerByCondition(param1:OfferRewardConditionTemplate) : void
      {
         switch(param1.CondictionType - 1)
         {
            case 0:
               getCastlePawnBySonType(param1.Para1).addEventListener("pawnProppertyChager",__pawnsChangeHandler);
               break;
            case 3:
               goodsCountByTempId.addEventListener("addDictionary",__goodsChangeHandler2);
               goodsCountByTempId.addEventListener("updateDictionary",__goodsChangeHandler2);
               break;
            case 15:
               NotificationManager.instance.addEventListener("TALKRINGTASK_COMPLETE",__talkTaskComplete);
               break;
            case 18:
               if(getflag(currTask.condition_3))
               {
                  commit();
                  return;
               }
               goodsCountByTempId.addEventListener("addDictionary",__goodsChangeHandler);
               goodsCountByTempId.addEventListener("deleteDictionary",__goodsChangeHandler);
               goodsCountByTempId.addEventListener("updateDictionary",__goodsChangeHandler);
         }
      }
      
      private function getflag(param1:int) : Boolean
      {
         var _loc2_:GoodsInfo = GoodsManager.instance.getBagGoodsByTemplateId(param1)[0];
         if(_loc2_)
         {
            if(_loc2_.count >= 1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function __talkTaskComplete(param1:NotificationEvent) : void
      {
         RingTaskManager.instance.updataState();
         talkTaskState = true;
      }
      
      private function __goodsChangeHandler(param1:DictionaryEvent) : void
      {
         if(int(param1.key) == currTask.condition_3)
         {
            if(goodsCountByTempId[currTask.condition_3] >= 1)
            {
            }
            commit();
         }
      }
      
      private function __goodsChangeHandler2(param1:DictionaryEvent) : void
      {
         for each(var _loc2_:OfferRewardConditionTemplate in conditionList)
         {
            if(_loc2_.Para1 == int(param1.key))
            {
               if(goodsCountByTempId[_loc2_.Para1] + getCount(_loc2_.Para1) < _loc2_.Para2)
               {
                  hasCompleted = false;
               }
               commit();
               return;
            }
         }
      }
      
      private function getCount(param1:int) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_:GoodsInfo in consortiaGoodsCount)
         {
            if(_loc3_.templateId == param1)
            {
               _loc2_ += _loc3_.count;
            }
         }
         return _loc2_;
      }
      
      private function get ringTaskManager() : RingTaskManager
      {
         return RingTaskManager.instance;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get goodsCountByTempId() : SimpleDictionary
      {
         return GoodsManager.instance.goodsCountByTempId;
      }
      
      private function get consortiaGoodsCount() : SimpleDictionary
      {
         return GoodsManager.instance.consoritaBagList;
      }
      
      private function getCastlePawnBySonType(param1:int) : ArmyPawn
      {
         return ArmyManager.instance.castlePawnList[param1];
      }
      
      public function getCellHeight() : Number
      {
         if(isCompleted)
         {
            return 43;
         }
         return 36;
      }
   }
}

