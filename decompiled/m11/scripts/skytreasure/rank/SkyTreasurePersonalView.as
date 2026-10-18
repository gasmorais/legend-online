package skytreasure.rank
{
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectPool;
   import mvc.module.skytreasure.SkyTreasureModelNew;
   import yishi.manager.SkyTreasureManager;
   
   public class SkyTreasurePersonalView extends Component
   {
      
      private var _showInfoPanel:ScrollPanel;
      
      private var _showVBox:VBox;
      
      private var _bg:Scale9CornerImage;
      
      public function SkyTreasurePersonalView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.describeBackground_style25");
         _showVBox = ComponentFactory.Instance.creatComponentByStylename("SkyTreasureRankView.panelvBox");
         _showInfoPanel = ComponentFactory.Instance.creatComponentByStylename("SkyTreasureHisRankView.panel");
         addChild(_bg);
         _bg.width = 515;
         _bg.height = 365;
         _bg.x = -2;
         _bg.y = 27;
         addChild(_showInfoPanel);
         _showInfoPanel.setView(_showVBox);
      }
      
      private function get pumpModel() : SkyTreasureModelNew
      {
         return SkyTreasureManager.Instance.modelNew;
      }
      
      public function refreshShowInfo() : void
      {
         var _loc2_:int = 0;
         var _loc3_:SkyTreasurePersonalItem = null;
         var _loc1_:ChatData = null;
         _showVBox.removeAllChild();
         _showVBox.disposeAllChildren();
         _showVBox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < pumpModel.totalSkyTreasureRecordArray.length)
         {
            _loc3_ = new SkyTreasurePersonalItem();
            _loc1_ = ObjectPool.getObject(ChatData) as ChatData;
            _loc1_.channel = 21;
            _loc1_.msg = pumpModel.totalSkyTreasureRecordArray[_loc2_].recordDesc;
            _loc1_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc1_);
            _loc3_.data = _loc1_;
            _showVBox.addChild(_loc3_);
            _loc2_++;
         }
         _showVBox.commitChanges();
         _showInfoPanel.invalidateViewport(true);
         _showInfoPanel.scrollToTop();
      }
      
      public function refreshShowInfo1() : void
      {
         var _loc2_:int = 0;
         var _loc3_:SkyTreasurePersonalItem = null;
         var _loc1_:ChatData = null;
         _showVBox.removeAllChild();
         _showVBox.disposeAllChildren();
         _showVBox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < pumpModel.skyTreasureRecordArray.length)
         {
            _loc3_ = new SkyTreasurePersonalItem();
            _loc1_ = ObjectPool.getObject(ChatData) as ChatData;
            _loc1_.channel = 21;
            _loc1_.msg = pumpModel.skyTreasureRecordArray[_loc2_].recordDesc;
            _loc1_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc1_);
            _loc3_.data = _loc1_;
            _showVBox.addChild(_loc3_);
            _loc2_++;
         }
         _showVBox.commitChanges();
         _showInfoPanel.invalidateViewport(true);
         _showInfoPanel.scrollToTop();
      }
   }
}

