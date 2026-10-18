package skytreasure.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.skytreasure.SkyTreasureModelNew;
   import yishi.manager.SkyTreasureManager;
   
   public class SkyTreasureHistoryView extends Component
   {
      
      private var _showInfoPanel:ScrollPanel;
      
      private var _showVBox:VBox;
      
      protected var _libiao1:Bitmap;
      
      protected var _histankRank:FilterFrameText;
      
      protected var _hisRanKserver:FilterFrameText;
      
      protected var _histankbane:FilterFrameText;
      
      public function SkyTreasureHistoryView()
      {
         super();
         initView();
         SkyTreasureManager.Instance.sendSkyTreasureRankHistroyInfoReq();
      }
      
      private function initView() : void
      {
         _libiao1 = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.paihangbangbg1");
         _libiao1.x = -30;
         _libiao1.y = -35;
         _libiao1.width = 583;
         _libiao1.height = 416;
         _histankRank = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.histankRank");
         _hisRanKserver = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.hisRanKserver");
         _histankbane = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.histankbane");
         addChild(_libiao1);
         addChild(_histankRank);
         addChild(_hisRanKserver);
         addChild(_histankbane);
         _histankRank.text = LanguageMgr.GetTranslation("SkyTreasureCoinRankFrame.tabTxt1");
         _hisRanKserver.text = LanguageMgr.GetTranslation("SkyTreasureCoinRankFrame.tabTxt4");
         _histankbane.text = LanguageMgr.GetTranslation("SkyTreasureCoinRankFrame.tabTxt2");
         _showVBox = ComponentFactory.Instance.creatComponentByStylename("SkyTreasureHisRankView.panelvBox");
         _showInfoPanel = ComponentFactory.Instance.creatComponentByStylename("SkyTreasureHisRankView.panel");
         addChild(_showInfoPanel);
         _showInfoPanel.setView(_showVBox);
         refreshShowInfo();
      }
      
      private function get pumpModel() : SkyTreasureModelNew
      {
         return SkyTreasureManager.Instance.modelNew;
      }
      
      public function refreshShowInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:SkyTreasureHistoryrankDayItem = null;
         _showVBox.removeAllChild();
         _showVBox.disposeAllChildren();
         _showVBox.beginChanges();
         _loc1_ = 0;
         while(_loc1_ < pumpModel.skyTreasureRankRecordInfoArray.length)
         {
            _loc2_ = new SkyTreasureHistoryrankDayItem();
            _loc2_.data = pumpModel.skyTreasureRankRecordInfoArray[_loc1_];
            _showVBox.addChild(_loc2_);
            _loc1_++;
         }
         _showVBox.commitChanges();
         _showInfoPanel.invalidateViewport(true);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_libiao1);
         _libiao1 = null;
         ObjectUtils.disposeObject(_histankRank);
         _histankRank = null;
         ObjectUtils.disposeObject(_hisRanKserver);
         _hisRanKserver = null;
         ObjectUtils.disposeObject(_histankbane);
         _histankbane = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

