package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class MailCheckControler extends FrameController
   {
      
      public static const TELEPHONECHECK:int = 1;
      
      public static const MAILCHENCK:int = 2;
      
      public function MailCheckControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "mailcheck.MobilephoneCheckFrame";
         }
         if(_data.openType == 2)
         {
            return "mailcheck.MailCheckFrame";
         }
         return "";
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
   }
}

