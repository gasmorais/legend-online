package ancientartifact.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import yishi.manager.AncientArtifactManager;
   
   public class AncientArmoryView extends Component
   {
      
      private var _back:ScaleFrameImage;
      
      private var _armroySelectBtn01:SelectedIconButton;
      
      private var _armroySelectBtn02:SelectedIconButton;
      
      private var _armroySelectBtn03:SelectedIconButton;
      
      private var _armroySelectBtn04:SelectedIconButton;
      
      private var _tabGroup:SelectedButtonGroup;
      
      private var _bagView:AncientArmoryBagView;
      
      private var _titleTxt:FilterFrameText;
      
      private var _currentView:Component;
      
      public function AncientArmoryView()
      {
         super();
         initView();
         initEvent();
         _tabGroup.selectIndex = 0;
      }
      
      public function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryBack");
         _armroySelectBtn01 = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armorySelectedBtn");
         _armroySelectBtn02 = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryMarkSelectedBtn");
         _armroySelectBtn03 = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryGradeSelectedBtn");
         _armroySelectBtn04 = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryDeleteSelectedBtn");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryTitleTxt");
         _bagView = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientArmoryBagView");
         addChild(_back);
         addChild(_armroySelectBtn01);
         addChild(_armroySelectBtn02);
         addChild(_armroySelectBtn03);
         addChild(_armroySelectBtn04);
         addChild(_titleTxt);
         addChild(_bagView);
         _tabGroup = new SelectedButtonGroup();
         _tabGroup.addSelectItem(_armroySelectBtn01);
         _tabGroup.addSelectItem(_armroySelectBtn02);
         _tabGroup.addSelectItem(_armroySelectBtn03);
         _tabGroup.addSelectItem(_armroySelectBtn04);
         _titleTxt.text = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryTitle");
      }
      
      private function initEvent() : void
      {
         _tabGroup.addEventListener("change",__panelChangeHandler);
      }
      
      private function __panelChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         ObjectUtils.disposeObject(_currentView);
         _currentView = null;
         model.currentArmoryIndx = _tabGroup.selectIndex;
         model.isGradeItemInfo = false;
         model.chooseId = 0;
         model.chooseList = [];
         if(_tabGroup.selectIndex == 0)
         {
            _back.setFrame(1);
            _bagView.type = 1;
            _currentView = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientArmoryEquipView");
         }
         else if(_tabGroup.selectIndex == 1)
         {
            _back.setFrame(2);
            _bagView.type = 2;
            _currentView = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientArmoryMarkView");
         }
         else if(_tabGroup.selectIndex == 2)
         {
            _back.setFrame(2);
            _bagView.type = 2;
            _currentView = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientArmoryGradeView");
         }
         else
         {
            _back.setFrame(2);
            _bagView.type = 2;
            _currentView = ComponentFactory.Instance.creatCustomObject("ancientartifact.AcnientArmoryDeleteView");
         }
         addChild(_currentView);
      }
      
      private function removeEvent() : void
      {
         if(_tabGroup)
         {
            _tabGroup.removeEventListener("change",__panelChangeHandler);
         }
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_armroySelectBtn01);
         _armroySelectBtn01 = null;
         ObjectUtils.disposeObject(_armroySelectBtn02);
         _armroySelectBtn02 = null;
         ObjectUtils.disposeObject(_armroySelectBtn03);
         _armroySelectBtn03 = null;
         ObjectUtils.disposeObject(_armroySelectBtn04);
         _armroySelectBtn04 = null;
         ObjectUtils.disposeObject(_tabGroup);
         _tabGroup = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         ObjectUtils.disposeObject(_currentView);
         _currentView = null;
         super.dispose();
      }
   }
}

