package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class SecretaryContractControler extends FrameController
   {
      
      public function SecretaryContractControler()
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
         if(_data.openType == 1)
         {
            return "secretary.SecretaryAwardFrame";
         }
         return "secretary.LittleSecretaryFrame";
      }
   }
}

