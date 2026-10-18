package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class PerkinLabControler extends FrameController
   {
      
      public function PerkinLabControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "perkinlab.PerkinLabFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data.openType);
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

