package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class MineFieldControler extends FrameController
   {
      
      public function MineFieldControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "mineField.MineFieldFrame";
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

