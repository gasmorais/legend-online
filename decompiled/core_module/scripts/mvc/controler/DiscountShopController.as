package mvc.controler
{
   import mvc.FrameController;
   
   public class DiscountShopController extends FrameController
   {
      
      public function DiscountShopController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "discountshop.DiscountShopFrame";
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
      
      public function closeFrame() : void
      {
         _frame.dispose();
         _frame = null;
      }
   }
}

