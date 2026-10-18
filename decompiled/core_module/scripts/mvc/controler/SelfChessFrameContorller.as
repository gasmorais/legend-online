package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class SelfChessFrameContorller extends FrameController
   {
      
      public function SelfChessFrameContorller()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "chess.SelfChessGameOverFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data.frameData);
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

