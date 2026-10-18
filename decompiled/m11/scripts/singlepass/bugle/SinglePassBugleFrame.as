package singlepass.bugle
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SinglePassBugleFrame extends Frame implements IManualSize
   {
      
      private var _helpBtn:BaseButton;
      
      private var _bugleView:SinglePassBugleView;
      
      public function SinglePassBugleFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,820,427);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("singlepass.bugle.HelpButton");
         _bugleView = new SinglePassBugleView();
         addToContent(_helpBtn);
         addToContent(_bugleView);
         _helpBtn.tipData = LanguageMgr.GetTranslation("singlepass.view.SinglePassBugleFrame.helpBtnTipData");
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_bugleView);
         _bugleView = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("singlepass.SinglePassBugleHelpFrame");
         _loc2_.show();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

