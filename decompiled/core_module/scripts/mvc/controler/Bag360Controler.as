package mvc.controler
{
   import mvc.FrameController;
   import mvc.module.bag360.Bag360Model;
   
   public class Bag360Controler extends FrameController
   {
      
      private var _model:Bag360Model;
      
      public function Bag360Controler()
      {
         super();
         _model = new Bag360Model();
      }
      
      override public function get frameClassName() : String
      {
         return "bag360.Bag360Frame";
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

