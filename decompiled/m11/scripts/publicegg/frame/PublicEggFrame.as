package publicegg.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import publicegg.PublicEggView;
   
   public class PublicEggFrame extends Frame implements IManualSize
   {
      
      private var _back:DisplayObject;
      
      private var _view:PublicEggView;
      
      public function PublicEggFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,888,621);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("publicegg.frame.PublicEggFrame.titleText");
         _back = ComponentFactory.Instance.creatComponentByStylename("publicegg.PublicEggFrame.back");
         _view = ComponentFactory.Instance.creatCustomObject("publicegg.PublicEggView");
         _view.x = 3;
         _view.y = 3;
         addToContent(_back);
         addToContent(_view);
      }
      
      private function addEvent() : void
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
      }
   }
}

