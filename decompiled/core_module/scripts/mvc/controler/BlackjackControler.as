package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class BlackjackControler extends FrameController
   {
      
      public var openBlackFrame:Boolean;
      
      public function BlackjackControler()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         openBlackFrame = true;
         return "blackjack.BlackjackFrame";
      }
      
      override protected function exitFrame() : void
      {
         openBlackFrame = false;
         super.exitFrame();
      }
   }
}

