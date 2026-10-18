package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class RavePartyControler extends FrameController
   {
      
      public function RavePartyControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "raveparty.RavePartyFrame";
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

