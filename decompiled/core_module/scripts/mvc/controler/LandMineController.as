package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class LandMineController extends FrameController
   {
      
      public static const MAIN_FRAME:int = 1;
      
      public static const TEAM_FRAME:int = 2;
      
      private var _isInLandMineFrame:Boolean = false;
      
      public function LandMineController()
      {
         super();
      }
      
      public function set isInLandMineFrame(param1:Boolean) : void
      {
         _isInLandMineFrame = param1;
      }
      
      public function get isInLandMineFrame() : Boolean
      {
         return _isInLandMineFrame;
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
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      public function closeFrame() : void
      {
         if(_frame && _data.openType != 2)
         {
            _frame.dispose();
         }
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 2)
         {
            return "landmine.LandMineTeamFrame";
         }
         return "landmine.LandMineFrame";
      }
   }
}

