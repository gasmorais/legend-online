package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class WholeRebateController extends FrameController
   {
      
      private static var _instance:WholeRebateController;
      
      public function WholeRebateController()
      {
         super();
      }
      
      public static function get instance() : WholeRebateController
      {
         if(!_instance)
         {
            _instance = new WholeRebateController();
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
         return "wholerebate.WholeRebateFrame";
      }
   }
}

