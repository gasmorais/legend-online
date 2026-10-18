package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class AvengerControler extends FrameController
   {
      
      public static const MAIN_FRAME:String = "MAIN_FRAME";
      
      public static const UPGARDE_FRAME:String = "UPGARDE_FRAME";
      
      public static const OTHER_INFO_FRAME:String = "OTHER_INFO_FRAME";
      
      public static const DEVILARMOR_CARVE_FRAME:String = "DEVILARMOR_CARVE_FRAME";
      
      public static const CHILDNS_PROP_FRAME:String = "CHILDNS_PROP_FRAME";
      
      public static const CHILDNS_SKILL_FRAME:String = "CHILDNS_SKILL_FRAME";
      
      public static const OTHER_INFO_DEVILARMOR_FRAME:String = "OTHER_INFO_DEVILARMOR_FRAME";
      
      public function AvengerControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         if(_data && _data.openType == "UPGARDE_FRAME")
         {
            return "avenger.AvengerSkillEvolveFrame";
         }
         if(_data && _data.openType == "DEVILARMOR_CARVE_FRAME")
         {
            return "avenger.AvengerDevilArmorCarveFrame";
         }
         if(_data && _data.openType == "OTHER_INFO_FRAME")
         {
            return "playerInfo.avengerOtherView";
         }
         if(_data && _data.openType == "CHILDNS_PROP_FRAME")
         {
            return "avenger.AvengerChildNsSwordUpgradeFrame";
         }
         if(_data && _data.openType == "CHILDNS_SKILL_FRAME")
         {
            return "avenger.AvengerChildNsSkillFrame";
         }
         if(_data && _data.openType == "OTHER_INFO_DEVILARMOR_FRAME")
         {
            return "playerInfo.devilArmorInfoView";
         }
         return "avenger.AvengerFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.openType == 1)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"](_data);
         }
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

