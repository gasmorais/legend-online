package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class AntaeusController extends FrameController
   {
      
      public static const TYPE_MAINVIEW:int = 1;
      
      public function AntaeusController()
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
      
      override public function get frameClassName() : String
      {
         if(int(_data.openType) == 1)
         {
            return "antaeus.AntaeusFrame";
         }
         return "antaeus.AntaeusFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

