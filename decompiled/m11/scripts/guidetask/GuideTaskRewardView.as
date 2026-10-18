package guidetask
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.GuideTaskManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.view.community.BaseItemView;
   
   public class GuideTaskRewardView extends Sprite implements Disposeable
   {
      
      private var _rewardTitleImg:Bitmap;
      
      private var _rewardButton:IconButton;
      
      private var _hasGetRewardImg:Bitmap;
      
      private var _itemBox:HBox;
      
      private var _data:*;
      
      public function GuideTaskRewardView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BaseItemView = null;
         _rewardTitleImg = ComponentFactory.Instance.creatBitmap("asset.guidetask.completeTaskImg");
         _rewardButton = ComponentFactory.Instance.creatComponentByStylename("guidetask.rewardButton");
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("guidetask.rewardHBox");
         _hasGetRewardImg = ComponentFactory.Instance.creatBitmap("asset.core.ReceivedImg");
         addChild(_rewardTitleImg);
         addChild(_rewardButton);
         addChild(_itemBox);
         addChild(_hasGetRewardImg);
         _hasGetRewardImg.visible = false;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("guidetask.DropItem");
            _itemBox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      public function set data(param1:*) : void
      {
         var _loc3_:int = 0;
         var _loc4_:GoodsInfo = null;
         var _loc2_:BaseItemView = null;
         if(!param1)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = param1[_loc3_].TemplateId;
            _loc4_.count = param1[_loc3_].Count;
            _loc2_ = _itemBox.getChildAt(_loc3_) as BaseItemView;
            _loc2_.data = _loc4_;
            _loc3_++;
         }
      }
      
      private function initEvent() : void
      {
         _rewardButton.addEventListener("click",_rewardButtonHandler);
      }
      
      private function removeEvent() : void
      {
         _rewardButton.removeEventListener("click",_rewardButtonHandler);
      }
      
      private function _rewardButtonHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = FrameControllerManager.instance.guideTaskController.frame;
         if(_loc2_)
         {
            GuideTaskManager.instance.getReward(_loc2_._defaultDay);
         }
      }
      
      public function setGetRewardBtnStatu(param1:Boolean) : void
      {
         _rewardButton.enable = param1;
      }
      
      public function setGetRewardBtnHiden(param1:Boolean) : void
      {
         _rewardButton.visible = !param1;
         _hasGetRewardImg.visible = param1;
         if(GuideTaskManager.instance.model.statu == 0)
         {
            _rewardButton.visible = false;
            _hasGetRewardImg.visible = true;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_hasGetRewardImg);
         _hasGetRewardImg = null;
         ObjectUtils.disposeObject(_rewardTitleImg);
         _rewardTitleImg = null;
         ObjectUtils.disposeObject(_rewardButton);
         _rewardButton = null;
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
      }
   }
}

