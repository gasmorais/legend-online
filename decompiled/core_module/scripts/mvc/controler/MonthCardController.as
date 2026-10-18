package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class MonthCardController extends FrameController
   {
      
      public function MonthCardController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "monthcard.MonthCardFrame";
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

