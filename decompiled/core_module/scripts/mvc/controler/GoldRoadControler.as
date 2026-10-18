package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class GoldRoadControler extends FrameController
   {
      
      public function GoldRoadControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "goldroad.GoldRoadFrame";
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

