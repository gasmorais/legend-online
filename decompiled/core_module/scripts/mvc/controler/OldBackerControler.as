package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class OldBackerControler extends FrameController
   {
      
      public static const OLDFRAME:int = 1;
      
      public static const NEWFRAME:int = 2;
      
      public function OldBackerControler()
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
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "oldbacker.OldBackerFrame";
         }
         if(_data.openType == 2)
         {
            return "oldbacker.OldBackerNewFrame";
         }
         return "oldbacker.OldBackerFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

