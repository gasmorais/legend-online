package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class NewYearActController extends FrameController
   {
      
      public static var CONTINOUSLOGIN:int = 1;
      
      public static var LOTTERY:int = 2;
      
      public static var HANDLSEL:int = 3;
      
      public var curOpenLotteryFrame:Boolean;
      
      public function NewYearActController()
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
         _frame["show"](_data);
      }
      
      override public function get frameClassName() : String
      {
         if(_data && _data.openType == NewYearActController.CONTINOUSLOGIN)
         {
            return "newYearAct.ContinuousLoginFrame";
         }
         if(_data && _data.openType == NewYearActController.LOTTERY)
         {
            curOpenLotteryFrame = true;
            return "newYearAct.NewYearLotteryFrame";
         }
         if(_data && _data.openType == NewYearActController.HANDLSEL)
         {
            return "newYearAct.HandlselFrame";
         }
         return "";
      }
      
      override protected function exitFrame() : void
      {
         curOpenLotteryFrame = false;
         super.exitFrame();
      }
   }
}

