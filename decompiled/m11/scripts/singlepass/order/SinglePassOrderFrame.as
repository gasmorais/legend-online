package singlepass.order
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   
   public class SinglePassOrderFrame extends Frame
   {
      
      private var _back1:ScaleBitmapImage;
      
      private var _back2:Scale9CornerImage;
      
      private var _closeBtn:TextButton;
      
      private var _list:SinglePassOrderView;
      
      public function SinglePassOrderFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("singlepass.order.SinglePassOrderBack1");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("singlepass.singlePassOrderBack2");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("singlepass.order.SinglePassOrderCloseBtn");
         _closeBtn.text = LanguageMgr.GetTranslation("public.close");
         _list = new SinglePassOrderView();
         addToContent(_back1);
         addToContent(_back2);
         addToContent(_list);
         addToContent(_closeBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _closeBtn.addEventListener("click",__onCloseClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _closeBtn.removeEventListener("click",__onCloseClick);
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
         titleText = LanguageMgr.GetTranslation("singlepass.order.SinglePassOrderFrame.TitleTxt");
         LayerManager.Instance.addToLayer(this,3,true,true,2);
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

