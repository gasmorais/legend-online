package mainBar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import mvc.module.buildings.BuildInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ExplainBuildItem extends Sprite implements Disposeable
   {
      
      private var _buildingBoxImg:Bitmap;
      
      private var _iconView:BaseIconView;
      
      private var _nodeTxt:FilterFrameText;
      
      private var _buildInfo:BuildInfo;
      
      public function ExplainBuildItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _buildingBoxImg = ComponentFactory.Instance.creatBitmap("asset.castle.buildingBoxImg");
         _iconView = ComponentFactory.Instance.creatCustomObject("castle.BuildIcon");
         _nodeTxt = ComponentFactory.Instance.creatComponentByStylename("explainBar.ItemNodeTxt");
         addChild(_buildingBoxImg);
         _buildingBoxImg.x = 0;
         addChild(_iconView);
         _iconView.x = 7;
         addChild(_nodeTxt);
         _buildingBoxImg.visible = false;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.leading = 10;
         _nodeTxt.defaultTextFormat = _loc1_;
      }
      
      public function set buildInfo(param1:BuildInfo) : void
      {
         _buildInfo = param1;
         _iconView.icon = IconFactory.getBuidIconByIcon(_buildInfo.templeteInfo.Icon);
         ShowTipManager.Instance.removeTip(_iconView);
         _buildingBoxImg.visible = true;
      }
      
      public function set nodetext(param1:String) : void
      {
         _nodeTxt.text = param1;
      }
      
      public function dispose() : void
      {
         _buildInfo = null;
         if(_buildingBoxImg)
         {
            ObjectUtils.disposeObject(_buildingBoxImg);
         }
         _buildingBoxImg = null;
         if(_iconView)
         {
            ObjectUtils.disposeObject(_iconView);
         }
         _iconView = null;
         if(_nodeTxt)
         {
            ObjectUtils.disposeObject(_nodeTxt);
         }
         _nodeTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

