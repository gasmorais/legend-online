package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class PetHallowsControler extends FrameController
   {
      
      public static const MAIN_FRAME:int = 1;
      
      public static const UPGRADE_FRAME:int = 2;
      
      public function PetHallowsControler()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override public function get frameClassName() : String
      {
         switch(_data.openType)
         {
            case 1:
               return "pethallows.PetHallowsFrame";
            case 2:
               return "PetContracIconView.upgradeFrame";
            default:
               return "pethallows.PetHallowsFrame";
         }
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_frame)
         {
            if(_data && _frame.hasOwnProperty("data"))
            {
               _frame["data"] = _data.frameData;
            }
            _frame["show"]();
         }
      }
   }
}

