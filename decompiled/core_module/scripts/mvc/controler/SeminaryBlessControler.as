package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class SeminaryBlessControler extends FrameController
   {
      
      public function SeminaryBlessControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "seminaryBless.SeminaryBlessFrame";
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

