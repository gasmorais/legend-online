package skytreasure.reward
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.skytreasure.SkyTreasureModelNew;
   import yishi.manager.SkyTreasureManager;
   import yishi.utils.MsgMan;
   
   public class SkytreasurelunCoinRankView extends Component
   {
      
      private var _showInfoPanel:ScrollPanel;
      
      private var _showVBox:VBox;
      
      public function SkytreasurelunCoinRankView()
      {
         super();
         initView();
         refreshShowInfo();
         initEvent();
      }
      
      private function initView() : void
      {
         _showVBox = ComponentFactory.Instance.creatComponentByStylename("SkyTreasureCoinRankView.panelvBox");
         _showInfoPanel = ComponentFactory.Instance.creatComponentByStylename("SkyTreasureCoinRankView.panel");
         addChild(_showInfoPanel);
         _showInfoPanel.setView(_showVBox);
      }
      
      private function initEvent() : void
      {
         MsgMan.addObserver("SkyTreasureCoinCellBtn",this,__onSelectChangeHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("SkyTreasureCoinCellBtn",this,__onSelectChangeHandler);
      }
      
      private function __onSelectChangeHandler(param1:String, param2:Object) : void
      {
         _showVBox.commitChanges();
         _showInfoPanel.invalidateViewport(true);
      }
      
      private function get model() : SkyTreasureModelNew
      {
         return SkyTreasureManager.Instance.modelNew;
      }
      
      public function refreshShowInfo() : void
      {
         var _loc2_:Array = null;
         var _loc1_:int = 0;
         var _loc3_:SkyTreasureCoinCellBtn = null;
         _loc2_ = model.findSkyTreasureActTempInfoByActType(121);
         _showVBox.removeAllChild();
         _showVBox.disposeAllChildren();
         _showVBox.beginChanges();
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            _loc3_ = new SkyTreasureCoinCellBtn();
            _loc3_.data = _loc2_[_loc1_];
            _showVBox.addChild(_loc3_);
            _loc1_++;
         }
         _showVBox.commitChanges();
         _showInfoPanel.invalidateViewport(true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_showVBox);
         _showVBox = null;
         ObjectUtils.disposeObject(_showInfoPanel);
         _showInfoPanel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

