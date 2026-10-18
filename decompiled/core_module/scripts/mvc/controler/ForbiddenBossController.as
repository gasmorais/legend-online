package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class ForbiddenBossController extends FrameController
   {
      
      public static const MAIN_FRAME:int = 1;
      
      public static const REWARD_FRAME:int = 2;
      
      public static const RECORD_FRAME:int = 3;
      
      public static const MAP_FRAME:int = 4;
      
      public function ForbiddenBossController()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.frameData != null)
         {
            _frame["show"](_data);
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
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 2)
         {
            return "forbiddenboss.ForbiddenRewardsFrame";
         }
         if(_data.openType == 3)
         {
            return "forbiddenboss.ForbiddenRecordFrame";
         }
         if(_data.openType == 4)
         {
            return "forbiddenboss.ForbiddenBossMapFrame";
         }
         return "forbiddenboss.ForbiddenBossFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

