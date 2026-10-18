package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class GoodsListControler extends FrameController
   {
      
      public function GoodsListControler()
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
         return "auction.GoodsListFrame";
      }
   }
}

