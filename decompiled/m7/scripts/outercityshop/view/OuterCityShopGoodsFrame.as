package outercityshop.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   
   public class OuterCityShopGoodsFrame extends Frame
   {
      
      private var _goodsBackBg:Scale9CornerImage;
      
      private var _goodsBack:ScaleBitmapImage;
      
      private var _goodsView:OuterCityShopGoodsView;
      
      public function OuterCityShopGoodsFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("outercityshop.OuterCityShopFrame.linkText");
         _goodsBackBg = ComponentFactory.Instance.creatComponentByStylename("outercityshop.goodsBackBg");
         _goodsBack = ComponentFactory.Instance.creatComponentByStylename("outercityshop.goodsBack");
         _goodsView = ComponentFactory.Instance.creatCustomObject("outercityshop.goodsView");
         addToContent(_goodsBackBg);
         addToContent(_goodsBack);
         addToContent(_goodsView);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_goodsBackBg)
         {
            ObjectUtils.disposeObject(_goodsBackBg);
         }
         _goodsBackBg = null;
         if(_goodsBack)
         {
            ObjectUtils.disposeObject(_goodsBack);
         }
         _goodsBack = null;
         if(_goodsView)
         {
            ObjectUtils.disposeObject(_goodsView);
         }
         _goodsView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

