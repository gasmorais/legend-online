package mvc.controler
{
   import feedback.FeedBackFrame;
   import mvc.FrameController;
   
   public class FeedBackControler extends FrameController
   {
      
      public function FeedBackControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "feedback.FeedBackFrame";
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         (_frame as FeedBackFrame).show();
      }
   }
}

