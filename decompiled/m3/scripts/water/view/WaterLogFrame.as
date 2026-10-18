package water.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.manager.WaterManager;
   
   public class WaterLogFrame extends Frame
   {
      
      private var _titlebarBg:MutipleImage;
      
      private var _contentBg:ScaleBitmapImage;
      
      private var _bg:ScaleBitmapImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _listPanel:ListPanel;
      
      private var _eventList:Array;
      
      public function WaterLogFrame()
      {
         super();
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("buildings.water.view.WaterLogFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("water.LogFrameDescribeBackground");
         addToContent(_bg);
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("water.LogFrameBg");
         addToContent(_contentBg);
         _titlebarBg = ComponentFactory.Instance.creatComponentByStylename("water.TitleBarBack");
         addToContent(_titlebarBg);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("water.LogFrameNameTextStyle");
         _nameTxt.text = LanguageMgr.GetTranslation("buildings.water.view.WaterLogFrame.title");
         addToContent(_nameTxt);
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("water.LogFrameTimeTextStyle");
         _timeTxt.text = LanguageMgr.GetTranslation("buildings.water.view.WaterLogFrame.time");
         addToContent(_timeTxt);
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("water.LogListPanel");
         _listPanel.hScrollProxy = 2;
         addToContent(_listPanel);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function initData() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = WaterManager.instance.logList;
         _listPanel.beginChanges();
         var _loc1_:int = int(_loc3_.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _listPanel.vectorListModel.append(_loc3_[_loc2_]);
            _loc2_++;
         }
         _listPanel.commitChanges();
         _listPanel.invalidateViewport();
         _listPanel.list.updateListView();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true);
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
      
      override public function dispose() : void
      {
         removeEvent();
         _listPanel.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

