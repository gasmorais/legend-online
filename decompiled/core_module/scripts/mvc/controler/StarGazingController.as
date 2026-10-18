package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class StarGazingController extends FrameController
   {
      
      public function StarGazingController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "stargazing.StarGazingFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data);
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

