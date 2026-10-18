package mvc.controler
{
   import mvc.FrameController;
   
   public class GameBoxControler extends FrameController
   {
      
      public function GameBoxControler()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         return "gamebox.GameBoxEnterFrameStyle";
      }
   }
}

