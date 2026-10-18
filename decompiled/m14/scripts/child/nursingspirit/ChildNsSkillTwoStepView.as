package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import yishi.view.community.BaseIconView;
   
   public class ChildNsSkillTwoStepView extends Sprite
   {
      
      private var back:ScaleFrameImage;
      
      private var skillItem:BaseIconView;
      
      private var addBtn:BaseButton;
      
      public function ChildNsSkillTwoStepView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildNSSkillItemView.back");
         skillItem = ComponentFactory.Instance.creatCustomObject("ChildNSSkillItemView.skillItem");
         addBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSSkillItemView.addBtn");
         addChild(back);
         addChild(skillItem);
         addChild(addBtn);
      }
      
      private function initEvent() : void
      {
         addBtn.addEventListener("click",__addSkillClickHandler);
      }
      
      private function removeEvent() : void
      {
         addBtn.removeEventListener("click",__addSkillClickHandler);
      }
      
      private function __addSkillClickHandler(param1:MouseEvent) : void
      {
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(skillItem);
         skillItem = null;
         ObjectUtils.disposeObject(addBtn);
         addBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

