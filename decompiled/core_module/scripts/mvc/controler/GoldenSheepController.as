package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class GoldenSheepController extends FrameController
   {
      
      public static const MAIN_FRAME:int = 1;
      
      public static const BOX_FRAME:int = 2;
      
      public function GoldenSheepController()
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
         _frame["show"]();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      public function closeFrame() : void
      {
         if(_frame && _data.openType == 2)
         {
            _frame.dispose();
         }
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 2)
         {
            return "goldensheep.GoldenSheepBoxFrame";
         }
         return "goldensheep.GoldenSheepFrame";
      }
   }
}

