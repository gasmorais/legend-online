package planeswar.view.eventframe
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import yishi.keyboard.KeyBoardRegister;
   
   public class PlanesEventBaseFrame extends Frame
   {
      
      public function PlanesEventBaseFrame()
      {
         super();
         initEvent();
      }
      
      protected function initEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      protected function uintEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      protected function __frameResponse(param1:FrameEvent) : void
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
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         uintEvent();
         super.dispose();
         if(this.parent != null)
         {
            this.parent.removeChild(this);
         }
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

