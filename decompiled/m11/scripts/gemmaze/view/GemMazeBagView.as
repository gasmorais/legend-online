package gemmaze.view
{
   import bag.events.BagEvent;
   import bag.helper.BagHelper;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.GemMazeEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.manager.GemMazeManager;
   import yishi.manager.GoodsManager;
   
   public class GemMazeBagView extends Sprite implements Disposeable
   {
      
      private var _pickupButton:TextButton;
      
      private var _cleanupButton:TextButton;
      
      private var _bagScrollPanel:ScrollPanel;
      
      private var _bagVBox:VBox;
      
      private var gemMazeBagGridView:GemMazeBagGridView;
      
      public function GemMazeBagView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _pickupButton = ComponentFactory.Instance.creatComponentByStylename("gemMaze.ReceiveAllButton");
         _pickupButton.text = LanguageMgr.GetTranslation("gemMaze.GemMazeBagView.getAll");
         _cleanupButton = ComponentFactory.Instance.creatComponentByStylename("gemMaze.SortOutButton");
         _cleanupButton.text = LanguageMgr.GetTranslation("armyII.ArmyFrameII.tidy");
         _bagScrollPanel = ComponentFactory.Instance.creatComponentByStylename("gemMaze.bagScrollPanel");
         _bagVBox = ComponentFactory.Instance.creatComponentByStylename("gemMaze.bagVBox");
         gemMazeBagGridView = new GemMazeBagGridView();
         addChild(_pickupButton);
         addChild(_cleanupButton);
         addChild(_bagScrollPanel);
         _bagVBox.addChild(gemMazeBagGridView);
         _bagScrollPanel.setView(_bagVBox);
         _bagScrollPanel.invalidateViewport();
         __refreshStorageInfo(null);
      }
      
      private function addEvent() : void
      {
         _pickupButton.addEventListener("click",__pickupHandler);
         _cleanupButton.addEventListener("click",__cleanupHandler);
         GemMazeManager.Instance.addEventListener("GEMMAZE_UPDATE_BAG",onUpdateBag);
      }
      
      private function removeEvent() : void
      {
         _pickupButton.removeEventListener("click",__pickupHandler);
         _cleanupButton.removeEventListener("click",__cleanupHandler);
         GemMazeManager.Instance.removeEventListener("GEMMAZE_UPDATE_BAG",onUpdateBag);
      }
      
      private function onUpdateBag(param1:GemMazeEvent) : void
      {
         __refreshStorageInfo();
         gemMazeBagGridView.refreshData();
         _bagScrollPanel.invalidateViewport();
      }
      
      private function __pickupHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         GemMazeManager.Instance.sendOpenInfo();
      }
      
      private function __cleanupHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         BagHelper.instance.onTidyHandler(gemMazeBagGridView,2);
      }
      
      private function __refreshStorageInfo(param1:BagEvent = null) : void
      {
         if(GoodsManager.instance.getMazeBagList().getList().length > 0)
         {
            _cleanupButton.enable = _pickupButton.enable = true;
         }
         else
         {
            _cleanupButton.enable = _pickupButton.enable = false;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         _bagVBox.disposeAllChildren();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

