package singlepass
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import singlepass.view.SinglePassView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SinglePassFrame extends Frame implements IManualSize
   {
      
      private var _scaleBg:ScaleBitmapImage;
      
      private var _helpBtn:BaseButton;
      
      private var _view:SinglePassView;
      
      public function SinglePassFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,715,550);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _scaleBg = ComponentFactory.Instance.creatComponentByStylename("singlepass.ScaleBg");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("singlepass.HelpBtn");
         _view = ComponentFactory.Instance.creatCustomObject("singlepass.SinglePassView",[this]);
         addToContent(_scaleBg);
         addToContent(_helpBtn);
         addToContent(_view);
         _helpBtn.tipData = LanguageMgr.GetTranslation("singlepass.view.SinglePassFrame.helpBtnTipData");
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_scaleBg);
         _scaleBg = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("singlepass.SinglePassHelpFrame");
         _loc2_.show();
      }
      
      private function __responseHandler(param1:FrameEvent) : void
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

