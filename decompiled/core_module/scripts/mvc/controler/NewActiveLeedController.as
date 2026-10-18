package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class NewActiveLeedController extends FrameController
   {
      
      public function NewActiveLeedController()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
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
      
      override public function get frameClassName() : String
      {
         return "newactiveleed.NewActiveLeedFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

