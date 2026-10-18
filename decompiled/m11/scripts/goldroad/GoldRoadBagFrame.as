package goldroad
{
   import bag.events.BagEvent;
   import bag.helper.BagHelper;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GoldRoadManager;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.GoodsManager;
   
   public class GoldRoadBagFrame extends Frame
   {
      
      private var _bagFrameBg1:Scale9CornerImage;
      
      private var _bagFrameBg2:Scale9CornerImage;
      
      private var _BagView:GoldRoadBagView;
      
      private var _pickupButton:TextButton;
      
      private var _tidyButton:TextButton;
      
      private var _BagScrollPanel:ScrollPanel;
      
      private var _BagVBox:VBox;
      
      public function GoldRoadBagFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("gold.GoldRoadBagFrame.titleText");
         _bagFrameBg1 = ComponentFactory.Instance.creatComponentByStylename("goldroad.goldRoadBagFrameBack1");
         _bagFrameBg2 = ComponentFactory.Instance.creatComponentByStylename("goldroad.goldRoadBagFrameBack2");
         _pickupButton = ComponentFactory.Instance.creatComponentByStylename("goldroad.goldRoadPickupBtn");
         _tidyButton = ComponentFactory.Instance.creatComponentByStylename("goldroad.goldRoadTidyBtn");
         _BagScrollPanel = ComponentFactory.Instance.creatComponentByStylename("goldroad.goldRoadBagScrollPanel");
         _BagVBox = ComponentFactory.Instance.creatComponentByStylename("goldroad.goldRoadBagVBox");
         _BagView = new GoldRoadBagView();
         _BagView.reFreshAll();
         addToContent(_bagFrameBg1);
         addToContent(_bagFrameBg1);
         addToContent(_BagScrollPanel);
         _BagVBox.addChild(_BagView);
         _BagScrollPanel.setView(_BagVBox);
         _BagScrollPanel.invalidateViewport();
         addToContent(_pickupButton);
         _pickupButton.text = LanguageMgr.GetTranslation("bottle.view.BottleStorageFrame.pickupButton");
         addToContent(_tidyButton);
         _tidyButton.text = LanguageMgr.GetTranslation("gold.GoldRoadBagFrame.cleanupButton");
         __refreshStorageInfo(null);
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _pickupButton.addEventListener("click",__pickupHandler);
         _tidyButton.addEventListener("click",__cleanupHandler);
         GoodsManager.instance.addEventListener("UPDATE_GOLDROAD_BAG",__updateBagView);
         GoodsManager.instance.addEventListener("DELETE_GOLDROAD_BAG",__refreshStorageInfo);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _pickupButton.removeEventListener("click",__pickupHandler);
         _tidyButton.removeEventListener("click",__cleanupHandler);
         GoodsManager.instance.removeEventListener("UPDATE_GOLDROAD_BAG",__updateBagView);
         GoodsManager.instance.removeEventListener("DELETE_GOLDROAD_BAG",__refreshStorageInfo);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __pickupHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         GoldRoadManager.instance.sendBroadCast(false,1);
      }
      
      private function __cleanupHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         BagHelper.instance.onTidyHandler(_BagView,2);
      }
      
      private function __updateBagView(param1:BagEvent) : void
      {
         _BagView.refreshData();
         _BagScrollPanel.invalidateViewport();
      }
      
      private function __refreshStorageInfo(param1:BagEvent) : void
      {
         if(GoodsManager.instance.getGoldRoadBagList().getList().length > 0)
         {
            _tidyButton.enable = _pickupButton.enable = true;
         }
         else
         {
            _tidyButton.enable = _pickupButton.enable = false;
         }
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         if(_BagView)
         {
            ObjectUtils.disposeObject(_BagView);
         }
         _BagView = null;
         if(_bagFrameBg1)
         {
            ObjectUtils.disposeObject(_bagFrameBg1);
         }
         _bagFrameBg1 = null;
         if(_bagFrameBg2)
         {
            ObjectUtils.disposeObject(_bagFrameBg2);
         }
         _bagFrameBg2 = null;
         if(_pickupButton)
         {
            ObjectUtils.disposeObject(_pickupButton);
         }
         _pickupButton = null;
         if(_tidyButton)
         {
            ObjectUtils.disposeObject(_tidyButton);
         }
         _tidyButton = null;
         if(_BagVBox)
         {
            ObjectUtils.disposeObject(_BagVBox);
         }
         _BagVBox = null;
         if(_BagScrollPanel)
         {
            ObjectUtils.disposeObject(_BagScrollPanel);
         }
         _BagScrollPanel = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

