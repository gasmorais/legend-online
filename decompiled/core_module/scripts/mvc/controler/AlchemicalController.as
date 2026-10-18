package mvc.controler
{
   import mvc.FrameController;
   
   public class AlchemicalController extends FrameController
   {
      
      public function AlchemicalController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data);
      }
      
      override public function get frameClassName() : String
      {
         return "alchemical.AlchemicalFrame";
      }
   }
}

