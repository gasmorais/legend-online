package mvc.controler
{
   import mvc.FrameController;
   
   public class FundVeinController extends FrameController
   {
      
      public function FundVeinController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "fundVein.FundVeinFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      public function closeFrame() : void
      {
         _frame.dispose();
         _frame = null;
      }
   }
}

