package year2023.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import year2023.view.YearActiveShopView;
   
   public class YeraActiveShopFrame extends Frame implements IManualSize
   {
      
      protected var _typeBg2:MovieClip;
      
      private var _view:YearActiveShopView;
      
      public function YeraActiveShopFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1039,653);
      }
      
      private function initView() : void
      {
         _typeBg2 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.typeBg1");
         _view = new YearActiveShopView();
         addToContent(_typeBg2);
         addToContent(_view);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
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
         ObjectUtils.disposeViolentMc(_typeBg2);
         _typeBg2 = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP"];
      }
   }
}

