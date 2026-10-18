package pvp
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import pvp.view.PvPMultiView;
   
   public class PvPFrame extends Frame
   {
      
      private var _back:Bitmap;
      
      private var _multiView:PvPMultiView;
      
      public function PvPFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.pvp.Back");
         _multiView = ComponentFactory.Instance.creatCustomObject("pvp.MultiView");
         addToContent(_back);
         addToContent(_multiView);
      }
      
      public function get multiView() : PvPMultiView
      {
         return _multiView;
      }
      
      private function initEvent() : void
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
      
      public function show(param1:int = 1) : void
      {
         titleText = LanguageMgr.GetTranslation("pvp.PvPFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

