package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.keyboard.KeyBoardRegister;
   
   public class ChristmasTreeControler extends FrameController
   {
      
      public function ChristmasTreeControler()
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
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         return "christmastree.ChristmasTreeFrame";
      }
      
      override protected function exitFrame() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         super.exitFrame();
      }
   }
}

