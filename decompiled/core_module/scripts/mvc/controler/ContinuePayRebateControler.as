package mvc.controler
{
   import mvc.FrameController;
   
   public class ContinuePayRebateControler extends FrameController
   {
      
      public function ContinuePayRebateControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = _data.moduleUIName;
         if("continuepayrebate" !== _loc1_)
         {
            throw new Error("ContinuePayRebateControler: frameClassName missing!!!");
         }
         return "continuePayRebate.ContinuePayRebateFrame";
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

