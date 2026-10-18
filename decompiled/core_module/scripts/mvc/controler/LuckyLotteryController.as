package mvc.controler
{
   import mvc.FrameController;
   
   public class LuckyLotteryController extends FrameController
   {
      
      public function LuckyLotteryController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "luckylottery.frame";
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

