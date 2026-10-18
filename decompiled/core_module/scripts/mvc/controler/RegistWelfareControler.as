package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class RegistWelfareControler extends FrameController
   {
      
      public function RegistWelfareControler()
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
         if(_data.frameData && _data.openType != null)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "registwelfare.RegistWelfareConfirmFrame";
         }
         return "registwelfare.RegistWelfareFrame";
      }
   }
}

