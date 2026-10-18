package mvc.controler
{
   import mvc.FrameController;
   
   public class BirthdayController extends FrameController
   {
      
      public static const MESSAGE_BOARD_FRAME:String = "MESSAGE_BOARD_FRAME";
      
      public static const MESSAGE_INPUT_FRAME:String = "MESSAGE_INPUT_FRAME";
      
      public function BirthdayController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
         if(_data.openType == "MESSAGE_INPUT_FRAME")
         {
            setPreFrame(_data.moduleUIName,"MESSAGE_BOARD_FRAME");
         }
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = null;
         switch(_data.openType)
         {
            case "MESSAGE_BOARD_FRAME":
               _loc1_ = "birthday.BirthdayBoardFrame";
               break;
            case "MESSAGE_INPUT_FRAME":
               _loc1_ = "birthday.BirthdayInputFrame";
               break;
            default:
               throw new Error("undefind frame type");
         }
         return _loc1_;
      }
   }
}

