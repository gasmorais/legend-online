package mvc.module.buildings
{
   import events.RewardEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import mvc.module.offerreward.BaseOfferReward;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class OfferRewardModel extends EventDispatcher
   {
      
      public static const OPEN_REWARD_GRADE:int = 14;
      
      public static const BASE_REWARD_COUNT:int = 20;
      
      public static const MAX_OFFER_TASK_NUM:int = 4;
      
      public static const AUTO_REFRESH_INTERVAL:uint = 1800;
      
      public static const REWARD_STATE_CANACCEPT:int = 1;
      
      public static const REWARD_STATE_ACCEPTED:int = 2;
      
      public static const REWARD_STATE_COMPLETED:int = 3;
      
      public static var isLogin:Boolean = true;
      
      public static var isFirstPay:Boolean = true;
      
      public var maxRewardCount:int = 20;
      
      public var freeRefreshCount:int;
      
      private var _rewardTempDic:Dictionary;
      
      private var _baseRewardDic:SimpleDictionary;
      
      private var _offerRewardTaskDic:SimpleDictionary;
      
      private var _offerRewardTaskStateDic:SimpleDictionary;
      
      private var _offerRewardTaskProfileDic:SimpleDictionary;
      
      private var _lastRefreshRewardListDate:Date;
      
      private var _isNeedReset:Boolean = false;
      
      public function OfferRewardModel()
      {
         super();
         initData();
      }
      
      private function initData() : void
      {
         _rewardTempDic = TempleteManager.instance.offerRewardTemplateDic;
         _baseRewardDic = new SimpleDictionary();
      }
      
      public function get hasData() : Boolean
      {
         return _lastRefreshRewardListDate ? true : false;
      }
      
      public function get remainRewardCount() : int
      {
         return maxRewardCount - thane.rewardCount > 0 ? maxRewardCount - thane.rewardCount : 0;
      }
      
      public function get rewardTempDic() : Dictionary
      {
         return _rewardTempDic;
      }
      
      public function get baseRewardDic() : SimpleDictionary
      {
         return _baseRewardDic;
      }
      
      public function get offerRewardTaskDic() : SimpleDictionary
      {
         return _offerRewardTaskDic;
      }
      
      public function set offerRewardTaskDic(param1:SimpleDictionary) : void
      {
         if(_offerRewardTaskDic == param1)
         {
            return;
         }
         if(_offerRewardTaskDic)
         {
            _offerRewardTaskDic.clear();
         }
         _offerRewardTaskDic = param1;
      }
      
      public function get offerRewardTaskStateDic() : SimpleDictionary
      {
         return _offerRewardTaskStateDic;
      }
      
      public function set offerRewardTaskStateDic(param1:SimpleDictionary) : void
      {
         if(_offerRewardTaskStateDic == param1)
         {
            return;
         }
         if(_offerRewardTaskStateDic)
         {
            _offerRewardTaskStateDic.clear();
         }
         _offerRewardTaskStateDic = param1;
      }
      
      public function get offerRewardTaskProfileDic() : SimpleDictionary
      {
         return _offerRewardTaskProfileDic;
      }
      
      public function set offerRewardTaskProfileDic(param1:SimpleDictionary) : void
      {
         if(_offerRewardTaskProfileDic == param1)
         {
            return;
         }
         if(_offerRewardTaskProfileDic)
         {
            _offerRewardTaskProfileDic.clear();
         }
         _offerRewardTaskProfileDic = param1;
      }
      
      public function set lastRefreshRewardListDate(param1:Date) : void
      {
         if(_lastRefreshRewardListDate == param1)
         {
            return;
         }
         _lastRefreshRewardListDate = param1;
      }
      
      public function get lastRefreshRewardListTime() : Number
      {
         if(_lastRefreshRewardListDate)
         {
            return _lastRefreshRewardListDate.time;
         }
         return 0;
      }
      
      public function get refreshRemainTime() : Number
      {
         var _loc1_:Number = NaN;
         if(_lastRefreshRewardListDate)
         {
            _loc1_ = 1800 - (playerModel.sysCurTimeBySecond - _lastRefreshRewardListDate.time / 1000);
            if(_loc1_ > 0)
            {
               return _loc1_ > 1800 ? 1800 : _loc1_;
            }
            return 0;
         }
         return 0;
      }
      
      public function get isNeedReset() : Boolean
      {
         return _isNeedReset;
      }
      
      public function set isNeedReset(param1:Boolean) : void
      {
         if(_isNeedReset == param1)
         {
            return;
         }
         _isNeedReset = param1;
         if(_isNeedReset)
         {
            dispatchEvent(new RewardEvent("NEED_RESET_DATA",null));
         }
      }
      
      public function get hasCompletedTask() : Boolean
      {
         for each(var _loc1_:BaseOfferReward in _baseRewardDic)
         {
            if(_loc1_.isCompleted)
            {
               return true;
            }
         }
         return false;
      }
      
      public function hasTaskAndNotCompleted(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         for each(var _loc3_:BaseOfferReward in _baseRewardDic)
         {
            if(_loc3_.rewardTemp && _loc3_.rewardTemp.TemplateId == param1 && !_loc3_.isCompleted)
            {
               _loc2_ = true;
               break;
            }
         }
         return _loc2_;
      }
      
      public function get hasOrangeTaskNotComplete() : Boolean
      {
         for(var _loc1_:String in offerRewardTaskProfileDic)
         {
            if(offerRewardTaskProfileDic[_loc1_] > 4 && offerRewardTaskStateDic[_loc1_] == 1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

