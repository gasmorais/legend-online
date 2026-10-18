package consortia.view.myConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.myConsortia.newui.ConsortiaBuildingView;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ConsortiaBuildPage extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _buildView:ConsortiaBuildingView;
      
      public function ConsortiaBuildPage()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortia.NewbuildImg");
         _buildView = new ConsortiaBuildingView();
         addChild(_bg);
         addChild(_buildView);
         _buildView.x = 21;
         _buildView.y = 73;
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_buildView);
         _buildView = null;
      }
      
      public function dispose() : void
      {
         uninit();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
      }
   }
}

