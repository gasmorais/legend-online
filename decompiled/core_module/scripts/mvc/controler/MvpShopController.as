package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class MvpShopController extends FrameController
   {
      
      public function MvpShopController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "mvpshop.MvpShopFrame";
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

