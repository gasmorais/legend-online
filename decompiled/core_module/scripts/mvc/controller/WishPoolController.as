package mvc.controller
{
   import mvc.FrameController;
   
   public class WishPoolController extends FrameController
   {
      
      public function WishPoolController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "wishpool.frame";
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
         _frame["show"]();
      }
   }
}

