package mvc.controler
{
   import mvc.FrameController;
   
   public class BattleViewController extends FrameController
   {
      
      public function BattleViewController()
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
         return "";
      }
   }
}

