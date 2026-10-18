package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.keyboard.KeyBoardRegister;
   
   public class DemonRoadShopController extends FrameController
   {
      
      public function DemonRoadShopController()
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
         KeyBoardRegister.instance.keyEnable = false;
         super.showFrame();
         _frame["show"]();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         return "view.subshop.DemonRoadSolveFrame";
      }
      
      override protected function exitFrame() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         super.exitFrame();
      }
   }
}

