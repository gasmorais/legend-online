package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildNursingSpiritModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ChildNSAwakeView extends Component
   {
      
      private var descImage:MutipleImage;
      
      private var alertText:FilterFrameText;
      
      private var skillIcon:BaseIconView;
      
      private var addBtn:BaseButton;
      
      public function ChildNSAwakeView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         descImage = ComponentFactory.Instance.creatComponentByStylename("ChildNSAwakeView.descImage");
         alertText = ComponentFactory.Instance.creatComponentByStylename("ChildNSAwakeView.alertText");
         skillIcon = ComponentFactory.Instance.creatCustomObject("ChildNSAwakeView.skillIcon");
         addBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSAwakeView.addBtn");
         addChild(descImage);
         addChild(alertText);
         addChild(skillIcon);
         addChild(addBtn);
         alertText.text = LanguageMgr.GetTranslation("ChildNSAwakeView.alertText.text");
      }
      
      private function addEvent() : void
      {
         addBtn.addEventListener("click",__addSkillHandler);
      }
      
      private function removeEvent() : void
      {
         if(addBtn)
         {
            addBtn.removeEventListener("click",__addSkillHandler);
         }
      }
      
      private function __addSkillHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         FrameControllerManager.instance.openControllerByInfo("childnursingspirit","AWAKE_UPGRADE_FRAME");
      }
      
      public function refreshView() : void
      {
         if(!nsData)
         {
            return;
         }
         var _loc1_:SkillTempInfo = nsModel.getAwakeSkillTempByGrade(nsData);
         var _loc2_:SkillTempInfo = nsModel.getAwakeSkillTempByGrade(nsData,true);
         skillIcon.icon = IconFactory.getTecIconByIcon(_loc1_.Icons);
         skillIcon.tipData = _loc1_;
         addBtn.visible = _loc2_ != null;
      }
      
      private function get nsData() : ChildData
      {
         return nsModel.selectedNsChild;
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(descImage);
         descImage = null;
         ObjectUtils.disposeObject(alertText);
         alertText = null;
         ObjectUtils.disposeObject(skillIcon);
         skillIcon = null;
         ObjectUtils.disposeObject(addBtn);
         addBtn = null;
         super.dispose();
      }
   }
}

