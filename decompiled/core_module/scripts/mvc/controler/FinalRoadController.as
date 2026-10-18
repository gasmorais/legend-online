package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class FinalRoadController extends FrameController
   {
      
      public function FinalRoadController()
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
         if(_data.openType == 1)
         {
            return "finalroad.FinalRoadLevelFrame";
         }
         if(_data.openType == 2)
         {
            return "finalroad.FinalRoadBuffFrame";
         }
         return "finalroad.FinalRoadFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

