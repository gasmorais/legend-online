package mvc.controler
{
   import mvc.FrameController;
   
   public class LlkController extends FrameController
   {
      
      public function LlkController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == "LLK_FRAME")
         {
            return "llk.view.LlkFrame";
         }
         if(_data.openType == "LLK_SORT")
         {
            return "llk.view.LlkSortFrame";
         }
         return "llk.view.LlkFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
   }
}

