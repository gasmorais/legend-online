package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildNursingSpiritModel;
   import mvc.module.children.ChildSender;
   
   public class ChildNSTalentItemView extends Component
   {
      
      private var talentIcon:ScaleFrameImage;
      
      private var levelTxt:FilterFrameText;
      
      private var addBtn:BaseButton;
      
      private var _level:int;
      
      private var index:int;
      
      public function ChildNSTalentItemView(param1:int)
      {
         super();
         index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         talentIcon = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentItemView.TalentIcon" + index);
         levelTxt = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentItemView.levelTxt");
         addBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentItemView.TalentAddBtn");
         addChild(talentIcon);
         addChild(levelTxt);
         addChild(addBtn);
         talentIcon.setFrame(1);
         addBtn.visible = false;
      }
      
      private function addEvent() : void
      {
         talentIcon.addEventListener("mouseOver",__overHandler);
         talentIcon.addEventListener("mouseOut",__outHandler);
         addBtn.addEventListener("click",__addHandler);
      }
      
      private function removeEvent() : void
      {
         if(talentIcon)
         {
            talentIcon.removeEventListener("mouseOver",__overHandler);
         }
         if(talentIcon)
         {
            talentIcon.removeEventListener("mouseOut",__outHandler);
         }
         if(addBtn)
         {
            addBtn.removeEventListener("click",__addHandler);
         }
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         talentIcon.setFrame(2);
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         talentIcon.setFrame(1);
      }
      
      private function __addHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         ChildSender.nsUpgradeTalent(37,nsModel.selectedNsChild.childId,index);
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
         levelTxt.text = LanguageMgr.GetTranslation("public.level2",_level);
         addBtn.visible = nsModel.selectedNsChild.nursingSpiritInfo.talentPoint > 0 && _level < 80;
         var _loc2_:Object = {};
         _loc2_.type = index;
         _loc2_.nsInfo = nsModel.selectedNsChild.nursingSpiritInfo;
         this.tipData = _loc2_;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(talentIcon);
         talentIcon = null;
         ObjectUtils.disposeObject(levelTxt);
         levelTxt = null;
         ObjectUtils.disposeObject(addBtn);
         addBtn = null;
         super.dispose();
      }
   }
}

