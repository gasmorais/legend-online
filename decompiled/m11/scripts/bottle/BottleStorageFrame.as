package bottle
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
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.BottleManager;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.GoodsManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class BottleStorageFrame extends Frame
   {
      
      private var _bottleStorageFrameBg1:Scale9CornerImage;
      
      private var _bottleStorageFrameBg2:Scale9CornerImage;
      
      private var _bottleBagView:BottleBagView;
      
      private var _pickupButton:TextButton;
      
      private var _giveupButton:TextButton;
      
      private var _cleanupButton:TextButton;
      
      private var _storageTipText:FilterFrameText;
      
      private var _bottleBagScrollPanel:ScrollPanel;
      
      private var _bottleBagVBox:VBox;
      
      public function BottleStorageFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("bottle.view.BottleStorageFrame.titleText");
         _bottleStorageFrameBg1 = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleStorageFrameBack1");
         _bottleStorageFrameBg2 = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleStorageFrameBack2");
         _pickupButton = ComponentFactory.Instance.creatComponentByStylename("bottle.StoragePickupBtn");
         _giveupButton = ComponentFactory.Instance.creatComponentByStylename("bottle.StorageGiveupBtn");
         _cleanupButton = ComponentFactory.Instance.creatComponentByStylename("bottle.StorageCleanupBtn");
         _storageTipText = ComponentFactory.Instance.creatComponentByStylename("bottle.StorageTipText");
         _bottleBagScrollPanel = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleBagScrollPanel");
         _bottleBagVBox = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleBagVBox");
         _bottleBagView = new BottleBagView();
         _bottleBagView.reFreshAll();
         addToContent(_bottleStorageFrameBg1);
         addToContent(_bottleStorageFrameBg2);
         addToContent(_bottleBagScrollPanel);
         _bottleBagVBox.addChild(_bottleBagView);
         _bottleBagScrollPanel.setView(_bottleBagVBox);
         _bottleBagScrollPanel.invalidateViewport();
         addToContent(_storageTipText);
         _storageTipText.text = LanguageMgr.GetTranslation("bottle.view.BottleStorageFrame.storageTipText");
         addToContent(_pickupButton);
         _pickupButton.text = LanguageMgr.GetTranslation("bottle.view.BottleStorageFrame.pickupButton");
         _giveupButton.text = LanguageMgr.GetTranslation("bottle.view.BottleStorageFrame.giveupButton");
         addToContent(_cleanupButton);
         _cleanupButton.text = LanguageMgr.GetTranslation("bottle.view.BottleStorageFrame.cleanupButton");
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
         _giveupButton.addEventListener("click",__giveupHandler);
         _pickupButton.addEventListener("click",__pickupHandler);
         _cleanupButton.addEventListener("click",__cleanupHandler);
         GoodsManager.instance.addEventListener("DELETE_BOTTLE_BAG",__refreshStorageInfo);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _giveupButton.removeEventListener("click",__giveupHandler);
         _pickupButton.removeEventListener("click",__pickupHandler);
         _cleanupButton.removeEventListener("click",__cleanupHandler);
         GoodsManager.instance.removeEventListener("DELETE_BOTTLE_BAG",__refreshStorageInfo);
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
      
      private function __giveupHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         SimpleAlertHelper.instance.data = [giveupResponse];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("bottle.view.BottleStorageFrame.giveupHandlerContent");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2);
      }
      
      private function giveupResponse(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            BottleManager.instance.sendOpenInfo(1,0);
         }
      }
      
      private function __pickupHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         BottleManager.instance.sendOpenInfo(2,0);
      }
      
      private function __cleanupHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         BagHelper.instance.onTidyHandler(_bottleBagView,2);
      }
      
      private function __refreshStorageInfo(param1:BagEvent) : void
      {
         if(GoodsManager.instance.getBottleBagList().getList().length > 0)
         {
            _cleanupButton.enable = _giveupButton.enable = _pickupButton.enable = true;
         }
         else
         {
            _cleanupButton.enable = _giveupButton.enable = _pickupButton.enable = false;
         }
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         _bottleBagVBox.disposeAllChildren();
         ObjectUtils.disposeObject(_bottleBagVBox);
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

