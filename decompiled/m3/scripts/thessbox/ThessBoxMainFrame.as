package thessbox
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import thessbox.view.ThessboxMainView;
   import yishi.datas.ComponentGroupType;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class ThessBoxMainFrame extends Frame implements IManualSize
   {
      
      private var _view:ThessboxMainView;
      
      private var _helpBtn:BaseButton;
      
      public function ThessBoxMainFrame()
      {
         super();
         initView();
         initEvent();
         TheseussoulManager.Instance.opThessbox(0,0);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,837,546);
      }
      
      private function initView() : void
      {
         _view = new ThessboxMainView();
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("thesstbox.helpBtn");
         addToContent(_view);
         addToContent(_helpBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         TheseussoulManager.Instance.addEventListener("EVENT_BOX_USER",updateViewHandler);
         _helpBtn.addEventListener("click",__helpBtnHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         TheseussoulManager.Instance.removeEventListener("EVENT_BOX_USER",updateViewHandler);
         _helpBtn.removeEventListener("click",__helpBtnHandler);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("thessbox.helpFrame");
         _loc2_.show();
      }
      
      private function updateViewHandler(param1:Event) : void
      {
         _view.updateView();
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
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("thessbox.mainTitle");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

