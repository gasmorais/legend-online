package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class PokerControler extends FrameController
   {
      
      public var showPoker:Boolean;
      
      public function PokerControler()
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
         if(_data.openType == 1)
         {
            _frame["show"](_data.frameData);
         }
         else if(_data.openType == 2)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "poker.PokerExchangeFrame";
         }
         if(_data.openType == 2)
         {
            return "poker.PokerPrizesFrame";
         }
         return "poker.PokerFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

