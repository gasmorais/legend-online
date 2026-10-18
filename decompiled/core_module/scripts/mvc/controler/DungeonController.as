package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class DungeonController extends FrameController
   {
      
      private static var _instance:DungeonController;
      
      public function DungeonController()
      {
         super();
      }
      
      public static function get instance() : DungeonController
      {
         if(!_instance)
         {
            _instance = new DungeonController();
         }
         return _instance;
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
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "dungeonturn.DungeonTurnFrame";
         }
         if(_data.openType == 2)
         {
            return "dungeonturn.DiceControlView";
         }
         if(_data.openType == 3)
         {
            return "dungeonturn.RewardFrame";
         }
         return "";
      }
   }
}

