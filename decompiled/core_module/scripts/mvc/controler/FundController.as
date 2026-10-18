package mvc.controler
{
   import mvc.FrameController;
   import mvc.module.fund.FundInfo;
   
   public class FundController extends FrameController
   {
      
      public var _model:FundInfo;
      
      public function FundController()
      {
         super();
         _model = new FundInfo();
      }
      
      override public function get frameClassName() : String
      {
         if(_data && _data.openType == 2)
         {
            return "fund.FundFrame";
         }
         return "fund.FundFrame";
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
         if(_data && _data.openType == 1)
         {
            _frame.dispose();
            _frame = null;
         }
      }
   }
}

