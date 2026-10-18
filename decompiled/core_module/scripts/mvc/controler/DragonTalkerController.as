package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class DragonTalkerController extends FrameController
   {
      
      public static const MAIN_FRAME:String = "MAIN_FRAME";
      
      public static const SYMBIOTE_FRAME:String = "SYMBIOTE_FRAME";
      
      public static const BATTLE_BEAST_PREVIEW_FRAME:String = "BATTLE_BEAST_PREVIEW_FRAME";
      
      public static const PROFICIENCY_CHANGE_FRAME:String = "PROFICIENCY_CHANGE_FRAME";
      
      public function DragonTalkerController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data);
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = "DragonTalker.DragonTalkerFrame";
         if(_data && _data.openType == "MAIN_FRAME")
         {
            _loc1_ = "DragonTalker.DragonTalkerFrame";
         }
         else if(_data && _data.openType == "SYMBIOTE_FRAME")
         {
            _loc1_ = "DragonTalker.DragonTalkerSymbioteUpgradeFrame";
         }
         else if(_data && _data.openType == "BATTLE_BEAST_PREVIEW_FRAME")
         {
            _loc1_ = "DragonTalker.DragonTalkerMountPreviewFrame";
         }
         else if(_data && _data.openType == "PROFICIENCY_CHANGE_FRAME")
         {
            _loc1_ = "dragontalker.DragonTalkerProficiencyFrame";
         }
         return _loc1_;
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

