package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class RemainsExploreController extends FrameController
   {
      
      public static const MAIN_FRAME:int = 1;
      
      public static const NODE_FRAME:int = 2;
      
      public static const DROP_FRAME:int = 3;
      
      public static const ACTIVITY_FRAME:int = 4;
      
      public var openFrameType:int;
      
      public function RemainsExploreController()
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
         openFrameType = 0;
         if(_data.openType == 2)
         {
            openFrameType = 2;
            return "remainsexplore.RemainsExploreNodeFrame";
         }
         if(_data.openType == 3)
         {
            return "remainsexplore.RemainsExploreDropFrame";
         }
         if(_data.openType == 4)
         {
            return "remainsexplore.RemainsExploreActivityFrame";
         }
         return "remainsexplore.RemainsExploreFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

