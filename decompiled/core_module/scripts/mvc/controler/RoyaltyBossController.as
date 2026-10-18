package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class RoyaltyBossController extends FrameController
   {
      
      public static const MAIN_FRAME:int = 1;
      
      public static const FIGHT_FRAME:int = 2;
      
      public static const RANK_FRAME:int = 3;
      
      public function RoyaltyBossController()
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
            return "royaltyboss.RoyaltyFightFrame";
         }
         if(_data.openType == 3)
         {
            return "royaltyboss.RoyaltyRankFrame";
         }
         return "royaltyboss.RoyaltyBossFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

