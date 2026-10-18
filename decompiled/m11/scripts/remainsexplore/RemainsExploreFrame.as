package remainsexplore
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.remainsexplore.RemainsExploreModel;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.RemainsExploreManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class RemainsExploreFrame extends Frame
   {
      
      private var _border:Scale9CornerImage;
      
      private var _bg:Bitmap;
      
      private var _activityBtn:IconButton;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _helpBtn:BaseButton;
      
      private var _num:int = 4;
      
      public function RemainsExploreFrame()
      {
         super();
         initView();
         addEvent();
         RemainsExploreManager.instance.sendDataRequest();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("remainsExploreFrame.titleText");
         _border = ComponentFactory.Instance.creatComponentByStylename("remainsExploreFrame.border");
         _bg = ComponentFactory.Instance.creatBitmap("asset.RemainsExploreFrame.bg");
         _activityBtn = ComponentFactory.Instance.creatComponentByStylename("remainsExploreFrame.activityBtn");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("remainsExploreFrame.scrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("remainsExploreFrame.vBox");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("remainsExploreFrame.helpBtn");
         addToContent(_border);
         addToContent(_bg);
         addToContent(_helpBtn);
         addToContent(_activityBtn);
         addToContent(_vBox);
         addToContent(_scrollPanel);
         _scrollPanel.setView(_vBox);
         initItem();
      }
      
      private function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RemainsExploreAreaItem = null;
         _vBox.removeAllChild();
         _loc2_ = 0;
         while(_loc2_ < _num)
         {
            _loc1_ = new RemainsExploreAreaItem(_loc2_ + 1);
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
         _scrollPanel.beginChanges();
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _activityBtn.addEventListener("click",__activityBtnClickHandler);
         _helpBtn.addEventListener("click",__helpClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _activityBtn.removeEventListener("click",__activityBtnClickHandler);
         _helpBtn.removeEventListener("click",__helpClickHandler);
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("remainsExploreFrame.helperFrame");
         _loc2_.show();
      }
      
      private function __activityBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("remainsexplore",4);
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : RemainsExploreModel
      {
         return RemainsExploreManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_activityBtn);
         _activityBtn = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeAllChildren(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

