package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class ExchangeBoxControler extends FrameController
   {
      
      public static const FASHION_BOX:int = 1;
      
      public static const MOUNT_BOX:int = 2;
      
      public var isOpenFrame:Boolean;
      
      public function ExchangeBoxControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "exchangebox.ExchangeBoxFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data.openType);
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

