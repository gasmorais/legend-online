package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class ChildesalControler extends FrameController
   {
      
      public function ChildesalControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "childesal.ChildesalFrame";
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

