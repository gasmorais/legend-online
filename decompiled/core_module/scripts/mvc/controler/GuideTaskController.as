package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class GuideTaskController extends FrameController
   {
      
      public static var GUIDETYPE_MAIN:int = 1;
      
      public function GuideTaskController()
      {
         super();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data && _data.openType == GUIDETYPE_MAIN)
         {
         }
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         if(_data && _data.openType == GUIDETYPE_MAIN)
         {
            return "guidetask.GuideTaskFrame";
         }
         return "guidetask.GuideTaskFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

