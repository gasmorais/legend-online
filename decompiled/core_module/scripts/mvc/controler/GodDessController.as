package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class GodDessController extends FrameController
   {
      
      public static const LOOK_UP_GODDESS:String = "LOOK_UP_GODDESS";
      
      public static const LOOK_UP_GODDESS_EQUIP:String = "LOOK_UP_GODDESS_EQUIP";
      
      public function GodDessController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.openType == 3)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"](_data);
         }
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == "LOOK_UP_GODDESS")
         {
            return "goddess.lookup.GodDessInfoCheckView";
         }
         if(_data.openType == "LOOK_UP_GODDESS_EQUIP")
         {
            return "goddess.lookup.GodDessEquipInfoView";
         }
         return "goddess.GodDessFrame";
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

