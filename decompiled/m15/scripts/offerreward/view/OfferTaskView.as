package offerreward.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.KingContractEvents;
   import flash.display.Sprite;
   import managers.OfferRewardManager;
   import mvc.module.buildings.OfferRewardModel;
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleDictionary;
   
   public class OfferTaskView extends Sprite implements Disposeable
   {
      
      private var _offerTaskList:Vector.<OfferTaskItem>;
      
      public function OfferTaskView()
      {
         super();
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         _offerTaskList = new Vector.<OfferTaskItem>();
         createTaskList();
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("UPDATE_KINGCONTRACT",__kingcontractHandler);
      }
      
      public function getOfferTaskItemByIndex(param1:int) : OfferTaskItem
      {
         return _offerTaskList[param1];
      }
      
      private function initData() : void
      {
         refreshView();
      }
      
      private function __kingcontractHandler(param1:KingContractEvents) : void
      {
         refreshView();
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("UPDATE_KINGCONTRACT",__kingcontractHandler);
      }
      
      private function createTaskList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:OfferTaskItem = null;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new OfferTaskItem();
            _loc1_.rewardPos = _loc2_;
            _loc1_.y = (_loc1_.height + 1) * _loc2_;
            _offerTaskList.push(_loc1_);
            addChild(_loc1_);
            _loc2_++;
         }
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         if(rewardModel.offerRewardTaskDic && rewardModel.offerRewardTaskStateDic && rewardModel.offerRewardTaskProfileDic)
         {
            _loc1_ = 0;
            while(_loc1_ < _offerTaskList.length)
            {
               _offerTaskList[_loc1_].setData(rewardModel.offerRewardTaskDic[_loc1_],rewardModel.offerRewardTaskProfileDic[_loc1_],rewardModel.offerRewardTaskStateDic[_loc1_]);
               _loc1_++;
            }
         }
      }
      
      private function cleanTaskList() : void
      {
         var _loc1_:OfferTaskItem = null;
         while(_offerTaskList.length > 0)
         {
            _loc1_ = _offerTaskList.pop();
            if(_loc1_)
            {
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
      }
      
      private function get rewardModel() : OfferRewardModel
      {
         return OfferRewardManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         cleanTaskList();
         _offerTaskList = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

