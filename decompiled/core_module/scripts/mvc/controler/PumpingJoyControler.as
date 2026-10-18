package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class PumpingJoyControler extends FrameController
   {
      
      public static const MAIN_FRAME:String = "MAIN_FRAME";
      
      public static const REWARD_FRAME:String = "REWARD_FRAME";
      
      public function PumpingJoyControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         if(_data && _data.openType == "REWARD_FRAME")
         {
            return "pumpingjoy.PumpingJoyRewardFrame";
         }
         return "pumpingjoy.PumpingJoyFrame";
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

