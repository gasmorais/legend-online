package mvc.controler
{
   import mvc.FrameController;
   
   public class TimeBoxControler extends FrameController
   {
      
      public function TimeBoxControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "timeBox.TimeBoxFrame";
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

