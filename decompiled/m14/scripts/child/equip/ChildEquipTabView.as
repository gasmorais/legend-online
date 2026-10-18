package child.equip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import yishi.datas.VersionSwitch;
   
   public class ChildEquipTabView extends Component
   {
      
      private var _group:SelectedButtonGroup;
      
      private var _bg:ScaleFrameImage;
      
      private var _upgradeBtn:SelectedIconButton;
      
      private var _refreshBtn:SelectedIconButton;
      
      private var _insertBtn:SelectedIconButton;
      
      private var _upgradeView:ChildUpgradeEquipView;
      
      private var _refreshView:ChildRefreshEquipView;
      
      private var _insertView:ChildInsertEquipView;
      
      private var _hbox:HBox;
      
      private var _gap:Image;
      
      public function ChildEquipTabView()
      {
         super();
         initView();
         initEvent();
         _group.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _group = new SelectedButtonGroup();
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildEquipTabView.equipBg");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("ChildEquipTabView.childEquipTabHbox");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildEquipTabView.equipUpgradeBtn");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("ChildEquipTabView.equipRefreshBtn");
         _insertBtn = ComponentFactory.Instance.creatComponentByStylename("ChildEquipTabView.equipInsetBtn");
         _gap = ComponentFactory.Instance.creatComponentByStylename("ChildEquipTabView.gap");
         _hbox.addChild(_upgradeBtn);
         if(VersionSwitch.CHILD_EQUITMENT)
         {
            _hbox.addChild(_refreshBtn);
            _hbox.addChild(_insertBtn);
         }
         _group.addSelectItem(_upgradeBtn);
         _group.addSelectItem(_refreshBtn);
         _group.addSelectItem(_insertBtn);
         addChild(_bg);
         addChild(_hbox);
         addChild(_gap);
      }
      
      private function initEvent() : void
      {
         if(_group)
         {
            _group.addEventListener("change",__groupChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_group)
         {
            _group.removeEventListener("change",__groupChangeHandler);
         }
      }
      
      private function __groupChangeHandler(param1:Event) : void
      {
         model.moveGoodsBack();
         if(_group)
         {
            refreshView(_group.selectIndex);
         }
      }
      
      public function changeToTab(param1:int) : void
      {
         _group.selectIndex = param1;
         refreshView(param1);
      }
      
      private function refreshView(param1:int) : void
      {
         if(param1 >= 0 && param1 < 4)
         {
            _bg.setFrame(param1 + 1);
         }
         switch(param1)
         {
            case 0:
               ChildManager.instance.currSelectedView = "CHILDEQUIPUPGRADEVIEW";
               _gap.y = 313;
               showTabView1();
               break;
            case 1:
               ChildManager.instance.currSelectedView = "CHILDEQUIPREFRESHVIEW";
               _gap.y = 313;
               showTabView2();
               break;
            case 2:
               ChildManager.instance.currSelectedView = "CHILDEQUIPINSERTVIEW";
               _gap.y = 267;
               showTabView3();
         }
      }
      
      private function showTabView1() : void
      {
         if(_upgradeView == null)
         {
            _upgradeView = new ChildUpgradeEquipView();
            _upgradeView.x = 10;
            _upgradeView.y = 10;
            addChild(_upgradeView);
         }
         if(_refreshView)
         {
            _refreshView.dispose();
         }
         _refreshView = null;
         if(_insertView)
         {
            _insertView.dispose();
         }
         _insertView = null;
      }
      
      private function showTabView2() : void
      {
         if(_refreshView == null)
         {
            _refreshView = new ChildRefreshEquipView();
            _refreshView.x = 10;
            _refreshView.y = 10;
            addChild(_refreshView);
         }
         if(_upgradeView)
         {
            _upgradeView.dispose();
         }
         _upgradeView = null;
         if(_insertView)
         {
            _insertView.dispose();
         }
         _insertView = null;
      }
      
      private function showTabView3() : void
      {
         if(_insertView == null)
         {
            _insertView = new ChildInsertEquipView();
            _insertView.x = 10;
            _insertView.y = 10;
            addChild(_insertView);
         }
         if(_upgradeView)
         {
            _upgradeView.dispose();
         }
         _upgradeView = null;
         if(_refreshView)
         {
            _refreshView.dispose();
         }
         _refreshView = null;
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_group);
         _group = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_upgradeBtn);
         _upgradeBtn = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_insertBtn);
         _insertBtn = null;
         ObjectUtils.disposeObject(_upgradeView);
         _upgradeView = null;
         ObjectUtils.disposeObject(_refreshView);
         _refreshView = null;
         ObjectUtils.disposeObject(_insertView);
         _insertView = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_gap);
         _gap = null;
         super.dispose();
      }
   }
}

