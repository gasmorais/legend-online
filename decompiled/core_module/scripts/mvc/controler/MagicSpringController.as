package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class MagicSpringController extends FrameController
   {
      
      public function MagicSpringController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "magicspring.MagicSpringFrame";
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

