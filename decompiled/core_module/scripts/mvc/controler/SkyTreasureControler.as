package mvc.controler
{
   import mvc.FrameController;
   
   public class SkyTreasureControler extends FrameController
   {
      
      public function SkyTreasureControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "skytreasure.frame";
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

