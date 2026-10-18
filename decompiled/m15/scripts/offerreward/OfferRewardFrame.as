package offerreward
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.QueueBarEvent;
   import events.RewardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import managers.OfferRewardManager;
   import mvc.module.buildings.OfferRewardModel;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import offerreward.view.OfferCountView;
   import offerreward.view.OfferTaskItem;
   import offerreward.view.OfferTaskView;
   import offerreward.view.OfferTimeView;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.QueueBarManager;
   import yishi.view.community.MagicSpringBufferAddView;
   
   public class OfferRewardFrame extends Frame
   {
      
      private var _frameBack:Scale9CornerImage;
      
      private var _offerTaskView:OfferTaskView;
      
      private var _offerTimeView:OfferTimeView;
      
      private var _offerCountView:OfferCountView;
      
      private var _bufferView:MagicSpringBufferAddView;
      
      private var _helpBtn:BaseButton;
      
      public function OfferRewardFrame()
      {
         super();
         initView();
         initBufferView();
         initData();
         addEvent();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      private function initView() : void
      {
         _frameBack = ComponentFactory.Instance.creatComponentByStylename("offerReward.OfferRewardFrameBack");
         _offerTaskView = ComponentFactory.Instance.creatCustomObject("offerReward.OfferTaskView");
         _offerTimeView = ComponentFactory.Instance.creatCustomObject("offerReward.OfferTimeView");
         _offerCountView = ComponentFactory.Instance.creatCustomObject("offerReward.OfferCountView");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("offerReward.HelpBtn");
         addToContent(_frameBack);
         addToContent(_offerTaskView);
         addToContent(_offerTimeView);
         addToContent(_offerCountView);
         _helpBtn.tipData = LanguageMgr.GetTranslation("offerreward.OfferRewardFrame.HelpBtn.Tipdata");
      }
      
      private function initBufferView() : void
      {
         var _loc1_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(6);
         if(_loc1_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc1_);
            _bufferView.setDescText(_loc1_.tempInfo.Desc);
            _bufferView.x = 10;
            _bufferView.y = 5;
            addToContent(_bufferView);
         }
      }
      
      private function initData() : void
      {
         if(rewardModel.refreshRemainTime == 0 || Boolean(rewardModel.isNeedReset))
         {
            rewardManager.sendRefreshRewardList(false,true);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         rewardManager.addEventListener("OFFER_REWARD_LIST_REFRESH",__offerRewardListRefreshHandler);
         rewardModel.addEventListener("NEED_RESET_DATA",__resetDataHandler);
         _helpBtn.addEventListener("click",__onHelpClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         rewardManager.removeEventListener("OFFER_REWARD_LIST_REFRESH",__offerRewardListRefreshHandler);
         rewardModel.removeEventListener("NEED_RESET_DATA",__resetDataHandler);
         _helpBtn.removeEventListener("click",__onHelpClick);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function getOfferTaskItemByIndex(param1:int) : OfferTaskItem
      {
         return _offerTaskView.getOfferTaskItemByIndex(param1);
      }
      
      private function __offerRewardListRefreshHandler(param1:RewardEvent) : void
      {
         _offerTaskView.refreshView();
         _offerTimeView.refreshView();
         _offerCountView.refreshView();
      }
      
      private function __resetDataHandler(param1:RewardEvent) : void
      {
         rewardManager.sendRefreshRewardList(false,true);
         rewardModel.isNeedReset = false;
      }
      
      private function __onHelpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.offerRewardController.openRewardHelpFrame();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("buildings.offerreward.OfferRewardFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function get rewardManager() : OfferRewardManager
      {
         return OfferRewardManager.instance;
      }
      
      private function get rewardModel() : OfferRewardModel
      {
         return OfferRewardManager.instance.model;
      }
      
      override public function dispose() : void
      {
         QueueBarManager.instance.dispatchEvent(new QueueBarEvent("OFFER_REWARD_FRAME_CLOSE",null));
         removeEvent();
         ObjectUtils.disposeObject(_frameBack);
         _frameBack = null;
         ObjectUtils.disposeObject(_offerTaskView);
         _offerTaskView = null;
         ObjectUtils.disposeObject(_offerTimeView);
         _offerTimeView = null;
         ObjectUtils.disposeObject(_offerCountView);
         _offerCountView = null;
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
      }
   }
}

