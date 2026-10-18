package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class FoisonHornController extends FrameController
   {
      
      public function FoisonHornController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "foisonhorn.FoisonHornFrame";
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

