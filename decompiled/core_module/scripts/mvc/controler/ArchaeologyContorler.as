package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class ArchaeologyContorler extends FrameController
   {
      
      public function ArchaeologyContorler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "archaeology.ArchaeologyFrame";
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

