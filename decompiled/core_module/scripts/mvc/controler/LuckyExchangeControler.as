package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class LuckyExchangeControler extends FrameController
   {
      
      public var openLuckyFrame:Boolean;
      
      public function LuckyExchangeControler()
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
         openLuckyFrame = true;
         return "luckyexchange.LuckyExchangeFrame";
      }
      
      override protected function exitFrame() : void
      {
         openLuckyFrame = false;
         super.exitFrame();
      }
   }
}

