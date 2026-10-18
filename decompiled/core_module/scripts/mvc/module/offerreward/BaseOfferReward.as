package mvc.module.offerreward
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   import com.road.yishi.proto.reward.RewardInfo;
   import events.PawnEvent;
   import events.RewardEvent;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import managers.OfferRewardManager;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.kingcontract.KingContractInfo;
   import org.events.DictionaryEvent;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.datas.templates.OfferRewardTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   
   public class BaseOfferReward extends EventDispatcher implements INotSameHeightListCellData
   {
      
      public var changeDate:Number;
      
      public var Sort:Number = 0;
      
      public var isNew:Boolean;
      
      public var sortFlag:Boolean;
      
      public var ShowType:int;
      
      private var _TemplateType:int = -1;
      
      private var _rewardID:int;
      
      private var _rewardTemp:OfferRewardTemplate;
      
      private var _rewardInfo:RewardInfo;
      
      private var _qteResult:Boolean = false;
      
      private var _hamsterGameResult:Boolean = false;
      
      private var _pawnsNum:int = -1;
      
      public var hasCompleted:Boolean = false;
      
      public function BaseOfferReward()
      {
         super();
      }
      
      public function get TemplateType() : int
      {
         return _TemplateType;
      }
      
      public function get rewardID() : int
      {
         return _rewardID;
      }
      
      public function set rewardID(param1:int) : void
      {
         _rewardID = param1;
      }
      
      public function get rewardTemp() : OfferRewardTemplate
      {
         return _rewardTemp;
      }
      
      public function set rewardTemp(param1:OfferRewardTemplate) : void
      {
         if(_rewardTemp == param1)
         {
            return;
         }
         _rewardTemp = param1;
      }
      
      public function get rewardInfo() : RewardInfo
      {
         return _rewardInfo;
      }
      
      public function set rewardInfo(param1:RewardInfo) : void
      {
         if(_rewardInfo == param1)
         {
            return;
         }
         _rewardInfo = param1;
         dispatchEvent(new RewardEvent("REWARD_TASK_UPDATE",this));
      }
      
      public function get conditionList() : Array
      {
         return _rewardTemp.conditionList;
      }
      
      public function get rewardItemList() : Array
      {
         return _rewardTemp.rewardItemList;
      }
      
      public function get Title() : String
      {
         return _rewardTemp.Title;
      }
      
      public function get NeedFightId() : int
      {
         return _rewardTemp.NeedFightId;
      }
      
      public function get profile() : int
      {
         return _rewardInfo.quality;
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
         }
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
         }
      }
      
      public function get isCompleted() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Array = getProgress();
         _loc2_ = 0;
         while(rewardTemp.conditionList[_loc2_] != null)
         {
            if(_loc1_[_loc2_] != LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress"))
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      private function get kingInfo() : KingContractInfo
      {
         return KingContractManager.Instance.model.getInfoById(2);
      }
      
      public function getProgress() : Array
      {
         var _loc4_:int = 0;
         var _loc1_:String = null;
         var _loc2_:OfferRewardConditionTemplate = null;
         if(kingInfo.leftTime > 0 && VersionSwitch.KING_CONTRACT)
         {
            return [LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress")];
         }
         var _loc5_:Array = [];
         var _loc3_:int = int(rewardTemp.conditionList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = rewardTemp.conditionList[_loc4_];
            switch(_loc2_.CondictionType - 1)
            {
               case 0:
                  _loc1_ = checkPawnsCount(_loc2_);
                  break;
               case 1:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 2:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 3:
                  _loc1_ = checkGoodsCount(_loc2_);
                  break;
               case 4:
                  _loc1_ = checkCount(_loc2_,_loc4_);
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
                  _loc1_ = checkQteResult();
                  break;
               case 12:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 13:
                  _loc1_ = checkCount(_loc2_,_loc4_);
                  break;
               case 14:
                  _loc1_ = checkHamsterGameResult(_loc2_);
                  break;
               default:
                  _loc1_ = LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
            }
            _loc5_[_loc4_] = _loc1_;
            _loc4_++;
         }
         return _loc5_;
      }
      
      public function addConditionListener() : void
      {
         for each(var _loc1_:OfferRewardConditionTemplate in conditionList)
         {
            addListenerByCondition(_loc1_);
         }
      }
      
      public function removeConditionListener() : void
      {
         goodsCountByTempId.removeEventListener("addDictionary",__goodsChangeHandler);
         goodsCountByTempId.removeEventListener("deleteDictionary",__goodsChangeHandler);
         goodsCountByTempId.removeEventListener("updateDictionary",__goodsChangeHandler);
         for each(var _loc1_:ArmyPawn in ArmyManager.instance.castlePawnList)
         {
            _loc1_.removeEventListener("pawnProppertyChager",__pawnsChangeHandler);
         }
      }
      
      public function commit() : void
      {
         changeDate = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         dispatchEvent(new RewardEvent("REWARD_TASK_UPDATE",this));
         rewardManager.dispatchEvent(new RewardEvent("REWARD_TASK_UPDATE",this));
      }
      
      private function addListenerByCondition(param1:OfferRewardConditionTemplate) : void
      {
         switch(param1.CondictionType - 1)
         {
            case 0:
               getCastlePawnBySonType(param1.Para1).addEventListener("pawnProppertyChager",__pawnsChangeHandler);
               break;
            case 3:
               goodsCountByTempId.addEventListener("addDictionary",__goodsChangeHandler);
               goodsCountByTempId.addEventListener("deleteDictionary",__goodsChangeHandler);
               goodsCountByTempId.addEventListener("updateDictionary",__goodsChangeHandler);
         }
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
            _pawnsNum = _loc2_;
            commit();
         }
      }
      
      private function __goodsChangeHandler(param1:DictionaryEvent) : void
      {
         for each(var _loc2_:OfferRewardConditionTemplate in conditionList)
         {
            if(_loc2_.Para1 == int(param1.key))
            {
               if(goodsCountByTempId[_loc2_.Para1] < _loc2_.Para2)
               {
                  hasCompleted = false;
               }
               commit();
               return;
            }
         }
      }
      
      private function checkCount(param1:OfferRewardConditionTemplate, param2:int) : String
      {
         if(rewardInfo)
         {
            if(rewardInfo["condition_" + (param2 + 1)] >= param1.Para2)
            {
               return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
            return "(" + rewardInfo["condition_" + (param2 + 1)] + " / " + param1.Para2 + ")";
         }
         return "";
      }
      
      private function checkPawnsCount(param1:OfferRewardConditionTemplate) : String
      {
         var _loc2_:int = ArmyManager.instance.getTotalPawnsNumberBySonType(param1.Para1);
         if(_loc2_ >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + String(_loc2_) + " / " + String(param1.Para2) + ")";
      }
      
      private function checkGoodsCount(param1:OfferRewardConditionTemplate) : String
      {
         var _loc2_:int = int(GoodsManager.instance.goodsCountByTempId[param1.Para1]);
         if(_loc2_ >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + _loc2_ + " / " + param1.Para2 + ")";
      }
      
      private function checkQteResult() : String
      {
         if(_qteResult)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkHamsterGameResult(param1:OfferRewardConditionTemplate) : String
      {
         if(_hamsterGameResult)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(0 / " + param1.Para2 + ")";
      }
      
      private function get rewardManager() : OfferRewardManager
      {
         return OfferRewardManager.instance;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function getCastlePawnBySonType(param1:int) : ArmyPawn
      {
         return ArmyManager.instance.castlePawnList[param1];
      }
      
      private function get goodsCountByTempId() : SimpleDictionary
      {
         return GoodsManager.instance.goodsCountByTempId;
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

