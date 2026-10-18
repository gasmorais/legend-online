package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class EclipticPalaceControl extends FrameController
   {
      
      public static const MAIN_FRAME:String = "MAIN_FRAME";
      
      public static const REWARD_FRAME:String = "REWARD_FRAME";
      
      public function EclipticPalaceControl()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         switch(_data.openType)
         {
            case "MAIN_FRAME":
               return "eclipticpalace.EclipticPalaceFrame";
            case "REWARD_FRAME":
               return "eclipticpalace.EclipticPalaceRewardFrame";
            default:
               return "eclipticpalace.EclipticPalaceFrame";
         }
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

