package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class EncoGoldControler extends FrameController
   {
      
      public function EncoGoldControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "encoGold.EncoGoldFrame";
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

