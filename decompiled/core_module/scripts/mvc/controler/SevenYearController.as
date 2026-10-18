package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class SevenYearController extends FrameController
   {
      
      public static const OPEN_TYPE_STAR_AREA:int = 1;
      
      public function SevenYearController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "sevenyear.SevenYearMainFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.openType == 1)
         {
            _frame["show"](1);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
   }
}

