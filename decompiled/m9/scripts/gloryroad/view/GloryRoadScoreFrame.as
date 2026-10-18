package gloryroad.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import managers.GloryroadManager;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.view.base.PageList;
   
   public class GloryRoadScoreFrame extends GloryRoadView implements IManualSize
   {
      
      private var _bgBox:ScaleBitmapImage;
      
      private var _bg:ScaleBitmapImage;
      
      private var _titleBg:Bitmap;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _pageList:PageList;
      
      private var _vBox:VBox;
      
      public function GloryRoadScoreFrame()
      {
         super();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,476,456);
      }
      
      override protected function initView() : void
      {
         titleText = getLanuage("GloryRoadScoreFrame.initView.title");
         _bgBox = addCreatComponentByStylename("gloryroad.rewardBgBox");
         _bg = addCreatComponentByStylename("gloryroad.scoreFrameBg");
         _titleBg = addCreatBitmap("asset.gloryroad.rewardTitleBg");
         _vBox = new VBox();
         _scrollPanel = addCreatComponentByStylename("gloryroad.scoreScrollPanel");
         _pageList = creatComponentByStylename("gloryroad.scorePageList");
         _pageList.updateCompleteHandler = updateCompleteHandler;
         _vBox.addChild(_pageList);
         _scrollPanel.setView(_vBox);
      }
      
      private function updateCompleteHandler() : void
      {
         _vBox.refreshChildPos();
         _scrollPanel.commitChanges();
         _scrollPanel.invalidateViewport();
      }
      
      override protected function initEvent() : void
      {
         addEvent(GloryroadManager.instance,"GLORY_ROAD_DATA_UPDATE",__refreshView);
         addEvent(this,"response",__frameResponse);
      }
      
      override protected function removeEvent() : void
      {
         deleteEvent(GloryroadManager.instance,"GLORY_ROAD_DATA_UPDATE",__refreshView);
         deleteEvent(this,"response",__frameResponse);
      }
      
      private function __refreshView(param1:Event) : void
      {
         _pageList.data = GloryroadManager.instance.model.getScoreListData();
      }
      
      public function show() : void
      {
         __refreshView(null);
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bgBox);
         _bgBox = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_pageList);
         _pageList = null;
         super.dispose();
      }
   }
}

