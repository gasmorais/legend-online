package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class GoldendionysiaController extends FrameController
   {
      
      public static const GOLDEN_DIONYSIA_FRAME:uint = 1;
      
      public static const WINNER_LIST_FRAME:uint = 2;
      
      public function GoldendionysiaController()
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
         var _loc1_:String = null;
         switch(int(_data.openType) - 1)
         {
            case 0:
               _loc1_ = "goldenDionysia.prizeInfo.GoldenDionysiaFrame";
               break;
            case 1:
               _loc1_ = "goldenDionysia.rank.GoldenDionysiaWinnerFrame";
         }
         return _loc1_;
      }
   }
}

