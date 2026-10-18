package mvc.controler
{
   import mvc.FrameController;
   import mvc.module.firstpay.FirstpayModel;
   
   public class FirstPayControler extends FrameController
   {
      
      public var model:FirstpayModel;
      
      public function FirstPayControler()
      {
         super();
         model = new FirstpayModel();
      }
      
      override public function get frameClassName() : String
      {
         if(_data.moduleUIName == "firstpay")
         {
            return "firstpay.FirstFrame";
         }
         if(_data.moduleUIName == "rechargetime")
         {
            return "firstpay.RechargeFrame";
         }
         return "firstpay.RechargeFrame";
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

