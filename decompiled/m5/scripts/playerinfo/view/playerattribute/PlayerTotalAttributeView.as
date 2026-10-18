package playerinfo.view.playerattribute
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class PlayerTotalAttributeView extends Sprite implements Disposeable
   {
      
      private var _back2:Bitmap;
      
      private var _thaneView:PlayerThaneView;
      
      private var _summaryAttributeView:PlayerSummaryAttributeView;
      
      private var _detailedAttributeView:PlayerDetailedAttributeView;
      
      public function PlayerTotalAttributeView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back2 = ComponentFactory.Instance.creatBitmap("asset.core.AttributeBackAsset");
         _thaneView = ComponentFactory.Instance.creatCustomObject("playerinfo.PlayerThaneView");
         _summaryAttributeView = ComponentFactory.Instance.creatCustomObject("playerinfo.PlayerSummaryAttributeView");
         _detailedAttributeView = ComponentFactory.Instance.creatCustomObject("playerinfo.PlayerDetailedAttributeView");
         addChild(_back2);
         addChild(_thaneView);
         addChild(_summaryAttributeView);
         addChild(_detailedAttributeView);
      }
      
      public function refresh(param1:ThaneInfo) : void
      {
         if(param1)
         {
            _thaneView.refreshIcon(param1);
            _summaryAttributeView.refresh(param1);
            _detailedAttributeView.refresh(param1);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_thaneView);
         _thaneView = null;
         ObjectUtils.disposeObject(_summaryAttributeView);
         _summaryAttributeView = null;
         ObjectUtils.disposeObject(_detailedAttributeView);
         _detailedAttributeView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

