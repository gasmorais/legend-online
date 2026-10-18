package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class SpaceTimeFaultController extends FrameController
   {
      
      public static const SPACETIME_SHARE:int = 1;
      
      public function SpaceTimeFaultController()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "spacetime.SpaceTimeFaultShareFrame";
         }
         return "spacetime.SpaceTimeFaultRewardFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.frameData != null)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

