package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class SteleSysController extends FrameController
   {
      
      public static const PAGE_SWITCH:String = "switch.page";
      
      public function SteleSysController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == "switch.page")
         {
            return "stelesys.SteleSwitchFrame";
         }
         return "stelesys.SteleSysFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data);
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

