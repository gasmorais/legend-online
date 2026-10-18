package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class PlaneCrisisController extends FrameController
   {
      
      public static var ENTER_CRISIS:int = 1;
      
      public function PlaneCrisisController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:Object = _data.openType;
         if(ENTER_CRISIS !== _loc1_)
         {
            return "ui.crisis.PlaneCrisisReportFrame";
         }
         return "ui.crisis.PlaneCrisisEnterFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data.frameData);
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      public function closeFrame() : void
      {
         if(_frame && _data.openType == ENTER_CRISIS)
         {
            _frame.dispose();
            _frame = null;
         }
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

