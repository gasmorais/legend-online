package child.skill
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import yishi.utils.MsgMan;
   
   public class ChildSkillTabView extends Component
   {
      
      private var _drivingBtn:SelectedIconButton;
      
      private var _passiveBtn:SelectedIconButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _skillView:ChildSkillListView;
      
      private var _warnBg:Image;
      
      private var _warnTxt:FilterFrameText;
      
      public function ChildSkillTabView()
      {
         super();
         initView();
         initEvent();
         _group.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _drivingBtn = ComponentFactory.Instance.creatComponentByStylename("childSkill.DrivingBtn");
         _passiveBtn = ComponentFactory.Instance.creatComponentByStylename("childSkill.PassiveBtn");
         _warnBg = ComponentFactory.Instance.creatComponentByStylename("childSkill.WarnBg");
         _warnTxt = ComponentFactory.Instance.creatComponentByStylename("childSkill.WarnTxt");
         _group = new SelectedButtonGroup();
         _skillView = ComponentFactory.Instance.creatCustomObject("child.childSkill");
         _group.addSelectItem(_drivingBtn);
         _group.addSelectItem(_passiveBtn);
         addChild(_drivingBtn);
         addChild(_passiveBtn);
         addChild(_skillView);
         addChild(_warnBg);
         addChild(_warnTxt);
      }
      
      private function initEvent() : void
      {
         if(_group)
         {
            _group.addEventListener("change",__groupChangeHandler);
         }
         MsgMan.addObserver("ChildEvent.HEAD_CHANGE",this,__refreshView);
      }
      
      private function __groupChangeHandler(param1:Event) : void
      {
         if(_group.selectIndex == 0)
         {
            _skillView.selected = 0;
            _warnTxt.text = LanguageMgr.GetTranslation("child.ChildSkillFrame.WarnDriving");
         }
         else if(_group.selectIndex == 1)
         {
            _skillView.selected = 1;
            _warnTxt.text = LanguageMgr.GetTranslation("child.ChildSkillFrame.WarnPassive");
         }
      }
      
      private function removeEvent() : void
      {
         if(_group)
         {
            _group.removeEventListener("change",__groupChangeHandler);
         }
         MsgMan.removeObserver("ChildEvent.HEAD_CHANGE",this,__refreshView);
      }
      
      private function __refreshView(param1:String, param2:Object) : void
      {
         if(ChildManager.instance.model.selectedChild)
         {
            if(_group)
            {
               _group.selectIndex = 0;
            }
            if(_skillView)
            {
               _skillView.selected = 0;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_group)
         {
            ObjectUtils.disposeObject(_group);
         }
         _group = null;
         if(_warnBg)
         {
            ObjectUtils.disposeObject(_warnBg);
         }
         _warnBg = null;
         if(_warnTxt)
         {
            ObjectUtils.disposeObject(_warnTxt);
         }
         _warnTxt = null;
         if(_drivingBtn)
         {
            ObjectUtils.disposeObject(_drivingBtn);
         }
         _drivingBtn = null;
         if(_passiveBtn)
         {
            ObjectUtils.disposeObject(_passiveBtn);
         }
         _passiveBtn = null;
         if(_skillView)
         {
            ObjectUtils.disposeObject(_skillView);
         }
         _skillView = null;
         super.dispose();
      }
   }
}

