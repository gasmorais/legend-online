package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   
   public class ChildNSSkillView extends Component
   {
      
      private var back:ScaleFrameImage;
      
      private var activeBtn:SelectedIconButton;
      
      private var profoundBtn:SelectedIconButton;
      
      private var passiveBtn:SelectedIconButton;
      
      private var awakeBtn:SelectedIconButton;
      
      private var btnHbox:HBox;
      
      private var btnGroup:SelectedButtonGroup;
      
      private var alertText:FilterFrameText;
      
      private var helpImage:Image;
      
      private var activeView:ChildNSActiveSkillView;
      
      private var profoundView:ChildNSProfoundSkillView;
      
      private var passiveView:ChildNSPassiveSkillView;
      
      private var awakeView:ChildNSAwakeView;
      
      public function ChildNSSkillView()
      {
         super();
         initView();
         addEvent();
         btnGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildNSSkillView.back");
         activeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSSkillView.activeBtn");
         profoundBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSSkillView.profoundBtn");
         passiveBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSSkillView.passiveBtn");
         awakeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSSkillView.awakeBtn");
         btnHbox = ComponentFactory.Instance.creatComponentByStylename("ChildNSSkillView.btnHbox");
         alertText = ComponentFactory.Instance.creatComponentByStylename("ChildNSSkillView.alertText");
         helpImage = ComponentFactory.Instance.creatComponentByStylename("ChildNSSkillView.helpImage");
         btnGroup = new SelectedButtonGroup();
         btnHbox.addChild(activeBtn);
         btnHbox.addChild(profoundBtn);
         btnHbox.addChild(passiveBtn);
         btnHbox.addChild(awakeBtn);
         btnGroup.addSelectItem(activeBtn);
         btnGroup.addSelectItem(profoundBtn);
         btnGroup.addSelectItem(passiveBtn);
         btnGroup.addSelectItem(awakeBtn);
         addChild(btnHbox);
         addChild(back);
         back.setFrame(1);
         addChild(alertText);
         addChild(helpImage);
         alertText.text = LanguageMgr.GetTranslation("ChildNSPassiveSkillView.descText.text");
         helpImage.tipData = LanguageMgr.GetTranslation("ChildNSSkillView.helpImage.tipData",8);
      }
      
      private function addEvent() : void
      {
         if(btnGroup)
         {
            btnGroup.addEventListener("change",__tabChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(btnGroup)
         {
            btnGroup.removeEventListener("change",__tabChangeHandler);
         }
      }
      
      public function refreshView() : void
      {
         if(activeView)
         {
            activeView.refreshView();
         }
         if(profoundView)
         {
            profoundView.refreshView();
         }
         if(passiveView)
         {
            passiveView.refreshView();
         }
         if(awakeView)
         {
            awakeView.refreshView();
         }
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(btnGroup.getSelectedItem())
         {
            case activeBtn:
               back.setFrame(1);
               alertText.y = 32;
               helpImage.y = 30;
               if(!activeView)
               {
                  activeView = ComponentFactory.Instance.creatCustomObject("ChildNSSkillView.activeView");
               }
               addChild(activeView);
               ObjectUtils.disposeObject(profoundView);
               profoundView = null;
               ObjectUtils.disposeObject(passiveView);
               passiveView = null;
               ObjectUtils.disposeObject(awakeView);
               awakeView = null;
               break;
            case profoundBtn:
               back.setFrame(1);
               alertText.y = 32;
               helpImage.y = 30;
               if(!profoundView)
               {
                  profoundView = ComponentFactory.Instance.creatCustomObject("ChildNSSkillView.profoundView");
               }
               addChild(profoundView);
               ObjectUtils.disposeObject(activeView);
               activeView = null;
               ObjectUtils.disposeObject(passiveView);
               passiveView = null;
               ObjectUtils.disposeObject(awakeView);
               awakeView = null;
               break;
            case passiveBtn:
               back.setFrame(2);
               alertText.y = 70;
               helpImage.y = 65;
               if(!passiveView)
               {
                  passiveView = ComponentFactory.Instance.creatCustomObject("ChildNSSkillView.passiveView");
               }
               addChild(passiveView);
               ObjectUtils.disposeObject(activeView);
               activeView = null;
               ObjectUtils.disposeObject(profoundView);
               profoundView = null;
               ObjectUtils.disposeObject(awakeView);
               awakeView = null;
               break;
            case awakeBtn:
               back.setFrame(3);
               alertText.y = 70;
               helpImage.y = 65;
               if(!awakeView)
               {
                  awakeView = ComponentFactory.Instance.creatCustomObject("ChildNSSkillView.awakeView");
               }
               addChild(awakeView);
               ObjectUtils.disposeObject(activeView);
               activeView = null;
               ObjectUtils.disposeObject(passiveView);
               passiveView = null;
               ObjectUtils.disposeObject(profoundView);
               profoundView = null;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(alertText);
         alertText = null;
         ObjectUtils.disposeObject(helpImage);
         helpImage = null;
         ObjectUtils.disposeObject(activeBtn);
         activeBtn = null;
         ObjectUtils.disposeObject(profoundBtn);
         profoundBtn = null;
         ObjectUtils.disposeObject(passiveBtn);
         passiveBtn = null;
         ObjectUtils.disposeObject(awakeBtn);
         awakeBtn = null;
         ObjectUtils.disposeObject(btnHbox);
         btnHbox = null;
         ObjectUtils.disposeObject(activeView);
         activeView = null;
         ObjectUtils.disposeObject(profoundView);
         profoundView = null;
         ObjectUtils.disposeObject(passiveView);
         passiveView = null;
         ObjectUtils.disposeObject(awakeView);
         awakeView = null;
         super.dispose();
      }
   }
}

