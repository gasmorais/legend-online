package skytreasure.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.SkyTreasureEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.skytreasure.SkyTreasureModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.SkyTreasureManager;
   import yishi.view.community.BaseItemView;
   
   public class SkyTreasureBagView extends Sprite implements Disposeable
   {
      
      private var _pickupButton:BaseButton;
      
      private var _bagScrollPanel:ScrollPanel;
      
      private var _bagHBox:HBox;
      
      public function SkyTreasureBagView()
      {
         super();
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         _pickupButton = ComponentFactory.Instance.creatComponentByStylename("skytreasure.bagview.pickupButton");
         _bagScrollPanel = ComponentFactory.Instance.creatComponentByStylename("skytreasure.bagview.bagScrollPanel");
         _bagHBox = ComponentFactory.Instance.creatComponentByStylename("skytreasure.bagHBox");
         addChild(_pickupButton);
         addChild(_bagScrollPanel);
         _bagScrollPanel.setView(_bagHBox);
         _bagScrollPanel.invalidateViewport();
      }
      
      private function initEvent() : void
      {
         if(_pickupButton)
         {
            _pickupButton.addEventListener("click",__pickupBtnHandler);
         }
         SkyTreasureManager.Instance.addEventListener("SKYTREASURE_RANK_UPDATE",__updateHandler);
         SkyTreasureManager.Instance.addEventListener("SKYTREASURE_ACTIVES_INFO",__updateHandler);
      }
      
      private function removeEvent() : void
      {
         if(_pickupButton)
         {
            _pickupButton.removeEventListener("click",__pickupBtnHandler);
         }
         SkyTreasureManager.Instance.removeEventListener("SKYTREASURE_RANK_UPDATE",__updateHandler);
         SkyTreasureManager.Instance.removeEventListener("SKYTREASURE_ACTIVES_INFO",__updateHandler);
      }
      
      public function get model() : SkyTreasureModel
      {
         return SkyTreasureManager.Instance.model;
      }
      
      private function clearBagHBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:BaseItemView = null;
         _loc1_ = 0;
         while(_loc1_ < _bagHBox.numChildren)
         {
            _loc2_ = _bagHBox.getChildAt(_loc1_) as BaseItemView;
            if(_loc2_)
            {
               _loc2_.data = null;
            }
            _loc1_++;
         }
         _bagScrollPanel.invalidateViewport();
      }
      
      private function addBaseItemView(param1:GoodsInfo) : void
      {
         var _loc3_:BaseItemView = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _bagHBox.numChildren)
         {
            _loc3_ = _bagHBox.getChildAt(_loc2_) as BaseItemView;
            if(_loc3_ && !_loc3_.data)
            {
               _loc3_.data = param1;
               return;
            }
            _loc2_++;
         }
         _loc3_ = ComponentFactory.Instance.creatCustomObject("skytreasure.boxShowView.Item");
         _loc3_.data = param1;
         _bagHBox.addChild(_loc3_);
      }
      
      private function initData() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:GoodsInfo = null;
         clearBagHBox();
         _loc2_ = 0;
         while(_loc2_ < model.chargeRewardList.length)
         {
            if(model.chargeRewardList[_loc2_].statu == 1 && model.joinInfoVO.height >= model.chargeRewardList[_loc2_].param)
            {
               _loc3_ = 0;
               while(_loc3_ < model.chargeRewardList[_loc2_].itemsList.length)
               {
                  _loc1_ = new GoodsInfo();
                  _loc1_.templateId = model.chargeRewardList[_loc2_].itemsList[_loc3_].templateId;
                  _loc1_.count = model.chargeRewardList[_loc2_].itemsList[_loc3_].count;
                  addBaseItemView(_loc1_);
                  _loc3_++;
               }
            }
            _loc2_++;
         }
         _bagScrollPanel.invalidateViewport();
      }
      
      private function __updateHandler(param1:SkyTreasureEvent) : void
      {
         initData();
      }
      
      private function __pickupBtnHandler(param1:MouseEvent) : void
      {
         SkyTreasureManager.Instance.getBoxGoods();
         if(_bagHBox)
         {
            _bagHBox.disposeAllChildren();
            _bagHBox.removeAllChild();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_pickupButton);
         _pickupButton = null;
         ObjectUtils.disposeObject(_bagScrollPanel);
         _bagScrollPanel = null;
         if(_bagHBox)
         {
            _bagHBox.disposeAllChildren();
            _bagHBox.removeAllChild();
            ObjectUtils.disposeObject(_bagHBox);
            _bagHBox = null;
         }
      }
   }
}

