package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class CarnivalController extends FrameController
   {
      
      public function CarnivalController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         return "carnvial.CarnvialMainFrame";
      }
      
      public function get frame() : Frame
      {
         return this._frame;
      }
   }
}

