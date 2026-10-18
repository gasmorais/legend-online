package fish.view
{
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FishManager;
   import yishi.manager.GoodsManager;
   
   public class FishBagFrame extends Frame
   {
      
      private var _fishBagFrameBg1:Scale9CornerImage;
      
      private var _fishBagFrameBg2:Scale9CornerImage;
      
      private var _fishBagView:FishBagView;
      
      private var _pickupButton:TextButton;
      
      private var _fishBagVBox:VBox;
      
      public function FishBagFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("fish.FishBagFrame.title");
         _fishBagFrameBg1 = ComponentFactory.Instance.creatComponentByStylename("fish.FishBagFrameBack1");
         _fishBagFrameBg2 = ComponentFactory.Instance.creatComponentByStylename("fish.FishBagFrameBack2");
         _pickupButton = ComponentFactory.Instance.creatComponentByStylename("fish.FishBagPickupBtn");
         _fishBagVBox = ComponentFactory.Instance.creatComponentByStylename("fish.FishBagVBox");
         _fishBagView = new FishBagView();
         _fishBagView.reFreshAll();
         addToContent(_fishBagFrameBg1);
         addToContent(_fishBagFrameBg2);
         _fishBagVBox.addChild(_fishBagView);
         addToContent(_fishBagVBox);
         addToContent(_pickupButton);
         _pickupButton.text = LanguageMgr.GetTranslation("bottle.view.BottleStorageFrame.pickupButton");
         __refreshHandler(null);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _pickupButton.addEventListener("click",__pickupHandler);
         GoodsManager.instance.addEventListener("DELETE_FISH_BAG",__refreshHandler);
      }
      
      private function __pickupHandler(param1:MouseEvent) : void
      {
         FishManager.instance.fishAction(2);
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
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _pickupButton.removeEventListener("click",__pickupHandler);
         GoodsManager.instance.removeEventListener("DELETE_FISH_BAG",__refreshHandler);
      }
      
      private function __refreshHandler(param1:BagEvent) : void
      {
         if(GoodsManager.instance.getFishBagList().getList().length > 0)
         {
            _pickupButton.enable = true;
         }
         else
         {
            _pickupButton.enable = false;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _fishBagVBox.disposeAllChildren();
         ObjectUtils.disposeObject(_fishBagVBox);
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

