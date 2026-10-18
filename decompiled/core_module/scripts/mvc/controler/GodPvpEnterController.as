package mvc.controler
{
   import mvc.FrameController;
   
   public class GodPvpEnterController extends FrameController
   {
      
      public function GodPvpEnterController()
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
         return "godpvpenter.GodPvpEnterFrame";
      }
   }
}

