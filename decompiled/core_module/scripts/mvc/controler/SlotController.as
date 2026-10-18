package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class SlotController extends FrameController
   {
      
      public function SlotController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "slot.SlotFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

