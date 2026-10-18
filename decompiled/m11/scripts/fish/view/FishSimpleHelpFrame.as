package fish.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   
   public class FishSimpleHelpFrame extends Frame
   {
      
      private var _text:FilterFrameText;
      
      private var _bg:Bitmap;
      
      public function FishSimpleHelpFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("fish.FishSimpleHelpFrame.title");
         _bg = ComponentFactory.Instance.creatBitmap("asset.fish.helpFrameBg");
         _text = ComponentFactory.Instance.creatComponentByStylename("fish.FishSimpleHelpFrame.text");
         _text.text = LanguageMgr.GetTranslation("fish.FishSimpleHelpFrame.text");
         addToContent(_bg);
         addToContent(_text);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
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
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

