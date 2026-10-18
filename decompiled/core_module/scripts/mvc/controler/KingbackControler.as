package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class KingbackControler extends FrameController
   {
      
      public function KingbackControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "kingback.KingbackFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data);
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

