package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class CustomizedVipControl extends FrameController
   {
      
      public static const MAIN_FRAME:String = "MAIN_FRAME";
      
      public static const CUSTOMIZED_FRAME:String = "CUSTOMIZED_FRAME";
      
      public static const BUY_FRAME:String = "BUY_FRAME";
      
      public function CustomizedVipControl()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         if(_data && _data.openType == "CUSTOMIZED_FRAME")
         {
            return "customizedvip.CustomizedVipFrame";
         }
         if(_data && _data.openType == "BUY_FRAME")
         {
            return "customizedvip.CustomizedVipBuyFrame";
         }
         return "customizedvip.CustomizedVipMainFrame";
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

