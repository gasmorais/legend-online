package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class UpgradePresentController extends FrameController
   {
      
      public function UpgradePresentController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "upgradepresent.UpgradePresentFrame";
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

