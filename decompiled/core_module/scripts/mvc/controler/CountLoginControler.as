package mvc.controler
{
   import mvc.FrameController;
   import mvc.module.countlogin.CountLoginModel;
   
   public class CountLoginControler extends FrameController
   {
      
      private var _model:CountLoginModel;
      
      public function CountLoginControler()
      {
         super();
         _model = new CountLoginModel();
      }
      
      override public function get frameClassName() : String
      {
         return "countlogin.CountFrame";
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

