package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class RegressControler extends FrameController
   {
      
      public function RegressControler()
      {
         super();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         return "regress.RegressFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

