package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class GuildWantedController extends FrameController
   {
      
      public function GuildWantedController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "consortia.view.wanted.GuildWantedFrame";
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

