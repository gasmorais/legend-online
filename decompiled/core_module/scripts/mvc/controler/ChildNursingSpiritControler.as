package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class ChildNursingSpiritControler extends FrameController
   {
      
      public static const MAIN:String = "MAIN";
      
      public static const OTHER_GROWTH:String = "OTHER_GROWTH";
      
      public static const SKILL_LEARN:String = "SKILL_LEARN";
      
      public static const PREVIEW_FRAME:String = "PREVIEW_FRAME";
      
      public static const AWAKE_UPGRADE_FRAME:String = "AWAKE_UPGRADE_FRAME";
      
      public static const ENCHANT:String = "ENCHANT";
      
      public static const CALL:String = "CALL";
      
      public static const NS:String = "NS";
      
      public static const NS_BUFF:String = "NS_BUFF";
      
      public function ChildNursingSpiritControler()
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
         var _loc1_:String = "nursingspirit.ChildNursingSpiritFrame";
         if(_data && _data.openType == "MAIN")
         {
            _loc1_ = "nursingspirit.ChildNursingSpiritFrame";
         }
         else if(_data && _data.openType == "OTHER_GROWTH")
         {
            _loc1_ = "nursingspirit.ChildNsEmblemResiUpFrame";
         }
         else if(_data && _data.openType == "SKILL_LEARN")
         {
            _loc1_ = "nursingspirit.ChildNSLearnSkillFrame";
         }
         else if(_data && _data.openType == "PREVIEW_FRAME")
         {
            _loc1_ = "nursingspirit.ChildNSPreviewFrame";
         }
         else if(_data && _data.openType == "AWAKE_UPGRADE_FRAME")
         {
            _loc1_ = "nursingspirit.ChildNSAwakeSkillUpgradeFrame";
         }
         else if(_data && _data.openType == "ENCHANT")
         {
            _loc1_ = "nursingspirit.ChildNSTreasureMostEnchantFrame";
         }
         else if(_data && _data.openType == "CALL")
         {
            _loc1_ = "nursingspirit.ChildNSCallFrame";
         }
         else if(_data && _data.openType == "NS")
         {
            _loc1_ = "nursingspirit.ChildNSFrame";
         }
         else if(_data && _data.openType == "NS_BUFF")
         {
            _loc1_ = "nursingspirit.ChildNsUpBuffFrame";
         }
         return _loc1_;
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

