package skytreasure.reward
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import mvc.module.skytreasure.SkyTreasureModelNew;
   import yishi.manager.SkyTreasureManager;
   
   public class SkyTreasureCoinRankView extends Component
   {
      
      private var _showInfoPanel:ScrollPanel;
      
      private var _showVBox:VBox;
      
      private var _rankView:SkymyrankItem;
      
      public function SkyTreasureCoinRankView()
      {
         super();
         initView();
         SkyTreasureManager.Instance.sendSkyTreasureRankHistroyInfoReq();
      }
      
      private function initView() : void
      {
         _showVBox = ComponentFactory.Instance.creatComponentByStylename("SkyTreasureCoinRankView.panelvBox");
         _showInfoPanel = ComponentFactory.Instance.creatComponentByStylename("SkyTreasureCoinRankView.panel");
         addChild(_showInfoPanel);
         _showInfoPanel.setView(_showVBox);
         _rankView = new SkymyrankItem();
         _rankView.y = 375;
         _rankView.x = 5;
         addChild(_rankView);
         refreshShowInfo();
      }
      
      private function get model() : SkyTreasureModelNew
      {
         return SkyTreasureManager.Instance.modelNew;
      }
      
      public function refreshShowInfo() : void
      {
         var _loc1_:int = 0;
         var _loc3_:SkyTreasureCoinRewardItem = null;
         var _loc2_:Array = [];
         _loc2_ = model.findSkyTreasureActTempInfoByActType(120);
         _showVBox.removeAllChild();
         _showVBox.disposeAllChildren();
         _showVBox.beginChanges();
         if(_loc2_.length <= 0)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_[0].skyTreasureRankRewardArray.length)
         {
            _loc3_ = new SkyTreasureCoinRewardItem();
            _loc3_.data = _loc2_[0].skyTreasureRankRewardArray[_loc1_];
            _showVBox.addChild(_loc3_);
            _loc1_++;
         }
         if(model.totalRankInfo)
         {
            _rankView.update(model.totalRankInfo.myRank,model.totalRankInfo.myGrade);
         }
         _showVBox.commitChanges();
         _showInfoPanel.invalidateViewport(true);
      }
      
      override public function dispose() : void
      {
         if(_showVBox)
         {
            _showVBox.removeAllChild();
            _showVBox.disposeAllChildren();
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

