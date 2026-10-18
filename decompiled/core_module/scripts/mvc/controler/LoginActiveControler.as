package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class LoginActiveControler extends FrameController
   {
      
      public function LoginActiveControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "loginactivity.loginactiveframe";
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

