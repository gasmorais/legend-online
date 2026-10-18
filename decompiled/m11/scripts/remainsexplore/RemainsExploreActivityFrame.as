package remainsexplore
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.remainsexplore.RemainsExploreModel;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.RemainsExploreManager;
   import yishi.utils.MsgMan;
   
   public class RemainsExploreActivityFrame extends Frame implements IManualSize
   {
      
      private var _border:Scale9CornerImage;
      
      private var _dayBtn:SelectedIconButton;
      
      private var _weekBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _bg:ScaleFrameImage;
      
      private var _activeProgress:RemainsExploreProgressView;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      public function RemainsExploreActivityFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,580,495);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("remainsExploreActivityFrame.titleText");
         _border = ComponentFactory.Instance.creatComponentByStylename("remainsExploreActivityFrame.border");
         _dayBtn = ComponentFactory.Instance.creatComponentByStylename("remainsExploreActivityFrame.dayBtn");
         _weekBtn = ComponentFactory.Instance.creatComponentByStylename("remainsExploreActivityFrame.weekBtn");
         _bg = ComponentFactory.Instance.creatComponentByStylename("remainsExploreActivityFrame.bg");
         _activeProgress = ComponentFactory.Instance.creatCustomObject("remainsExploreActivityFrame.activeProgress");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("remainsExploreActivityFrame.scrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("remainsExploreActivityFrame.vBox");
         addToContent(_border);
         addToContent(_bg);
         addToContent(_dayBtn);
         addToContent(_weekBtn);
         addToContent(_activeProgress);
         addToContent(_scrollPanel);
         addToContent(_vBox);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_dayBtn);
         _btnGroup.addSelectItem(_weekBtn);
         _btnGroup.selectIndex = 0;
         _scrollPanel.setView(_vBox);
         refreshView();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btnGroup.addEventListener("change",__btnGroupChangeHandler);
         MsgMan.addObserver("REMAINS_LEED_UPDATE",this,__leedUpdateInfoHandler);
         MsgMan.addObserver("EXPLORE_INFO_UPDATE",this,__leedUpdateInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _btnGroup.removeEventListener("change",__btnGroupChangeHandler);
         MsgMan.removeObserver("REMAINS_LEED_UPDATE",this,__leedUpdateInfoHandler);
         MsgMan.removeObserver("EXPLORE_INFO_UPDATE",this,__leedUpdateInfoHandler);
      }
      
      private function __leedUpdateInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __btnGroupChangeHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         _bg.setFrame(index);
         _activeProgress.data = isDayActivity ? model.dayLiveness : int(model.weekLiveness);
         _activeProgress.type = index;
         _activeProgress.refreshView();
         refreshItem();
      }
      
      private function refreshItem() : void
      {
         var _loc3_:int = 0;
         var _loc2_:RemainsExploreActivityItem = null;
         _vBox.removeAllChild();
         var _loc1_:Array = isDayActivity ? model.dayLeedList : model.weekLeedList;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = new RemainsExploreActivityItem();
            _loc2_.index = index;
            _loc2_.data = _loc1_[_loc3_];
            _vBox.addChild(_loc2_);
            _loc3_++;
         }
         _scrollPanel.beginChanges();
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
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
      
      private function get index() : int
      {
         return _btnGroup.selectIndex + 1;
      }
      
      private function get isDayActivity() : Boolean
      {
         return _btnGroup.selectIndex == 0;
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
         ObjectUtils.disposeObject(_dayBtn);
         _dayBtn = null;
         ObjectUtils.disposeObject(_weekBtn);
         _weekBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_activeProgress);
         _activeProgress = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeAllChildren(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

