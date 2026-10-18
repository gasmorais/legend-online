package goddess
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import goddess.page.GoddessAdvancePage;
   import goddess.page.GoddessDedicationPage;
   import goddess.page.GoddessEquipPage;
   import goddess.page.GoddessFormationPage;
   import goddess.page.GoddessLevelPage;
   import goddess.view.GoddessAvaterView;
   import goddess.view.GoddessChooseView;
   import managers.GodDessManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.goddess.GoddessInfo;
   import yishi.datas.VersionSwitch;
   import yishi.utils.MsgMan;
   import yishi.view.base.TabPageUtil;
   
   public class GodDessFrame extends Frame implements IManualSize
   {
      
      private var _tabPageUtil:TabPageUtil;
      
      private var _levelBtn:SelectedIconButton;
      
      private var _advanceBtn:SelectedIconButton;
      
      private var _dedicationBtn:SelectedIconButton;
      
      private var _formationBtn:SelectedIconButton;
      
      private var _equipBtn:SelectedIconButton;
      
      private var _chooseView:GoddessChooseView;
      
      private var _avaterView:GoddessAvaterView;
      
      public function GodDessFrame()
      {
         super();
         initView();
         initEvent();
         _chooseView.refreshData();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1006,624);
      }
      
      private function initView() : void
      {
         _levelBtn = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.levelSbtn");
         _advanceBtn = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.advanceSbtn");
         _dedicationBtn = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.dedicationSbtn");
         _formationBtn = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.formationSbtn");
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.equipTabSbtn");
         _chooseView = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.view.GoddessChooseView");
         _avaterView = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.view.GoddessAvaterView");
         addToContent(_levelBtn);
         addToContent(_advanceBtn);
         addToContent(_dedicationBtn);
         if(VersionSwitch.GODDESS_EQUIP)
         {
            addToContent(_equipBtn);
         }
         if(VersionSwitch.GODDESS_FORMATION)
         {
            addToContent(_formationBtn);
         }
         addToContent(_avaterView);
         addToContent(_chooseView);
         _tabPageUtil = new TabPageUtil();
         _tabPageUtil.addItemPage(_levelBtn,creatLevelPage);
         _tabPageUtil.addItemPage(_advanceBtn,creatAdvancePage);
         _tabPageUtil.addItemPage(_dedicationBtn,creatDedicationPage);
         _tabPageUtil.addItemPage(_equipBtn,creatEquipPage);
         _tabPageUtil.addItemPage(_formationBtn,creatFormationPage);
         _tabPageUtil.selectIndex = 0;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         if(param1 && param1.frameData)
         {
            _tabPageUtil.selectIndex = int(param1.frameData);
         }
      }
      
      private function creatLevelPage() : GoddessLevelPage
      {
         var _loc1_:GoddessLevelPage = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.page.GoddessLevelPage");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatAdvancePage() : GoddessAdvancePage
      {
         var _loc1_:GoddessAdvancePage = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.page.GoddessAdvancePage");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatDedicationPage() : GoddessDedicationPage
      {
         var _loc1_:GoddessDedicationPage = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.page.GoddessDedicationPage");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatFormationPage() : GoddessFormationPage
      {
         var _loc1_:GoddessFormationPage = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.page.GoddessFormationPage");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatEquipPage() : GoddessEquipPage
      {
         var _loc1_:GoddessEquipPage = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.page.GoddessEquipPage");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function initEvent() : void
      {
         _tabPageUtil.addEventListener("change",tabChangeHandler);
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("GodDessEvent.choose",this,chooseHandler);
         MsgMan.addObserver("GodDessEvent.isActive",this,activeHandler);
         MsgMan.addObserver("GodDessEvent.level",this,levelHandler);
         MsgMan.addObserver("GodDessEvent.devote",this,devoteHandler);
         MsgMan.addObserver("GodDessEvent.step",this,stepHandler);
         MsgMan.addObserver("GodDessEvent.isFight",this,fightHandler);
      }
      
      private function removeEvent() : void
      {
         _tabPageUtil.removeEventListener("change",tabChangeHandler);
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("GodDessEvent.choose",this,chooseHandler);
         MsgMan.removeObserver("GodDessEvent.isActive",this,activeHandler);
         MsgMan.removeObserver("GodDessEvent.level",this,levelHandler);
         MsgMan.removeObserver("GodDessEvent.devote",this,devoteHandler);
         MsgMan.removeObserver("GodDessEvent.step",this,stepHandler);
         MsgMan.removeObserver("GodDessEvent.isFight",this,fightHandler);
      }
      
      private function chooseHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         refreshView(_loc3_);
         _avaterView.data = _loc3_;
         _avaterView.flashBtn = false;
         _chooseView.chooseChange(_loc3_);
      }
      
      private function activeHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         refreshView(_loc3_);
         _avaterView.data = _loc3_;
         _avaterView.flashBtn = true;
         _chooseView.refreshData(false);
      }
      
      private function levelHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         if(_loc3_)
         {
            _avaterView.levelChange(_loc3_);
            _chooseView.levelChange(_loc3_);
         }
      }
      
      private function devoteHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         if(_loc3_)
         {
            _chooseView.devoteChange(_loc3_);
         }
      }
      
      private function stepHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         if(_loc3_)
         {
            _avaterView.stepChange(_loc3_);
            _chooseView.stepChange(_loc3_);
         }
      }
      
      private function fightHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         if(_loc3_)
         {
            _chooseView.fightChange(_loc3_);
         }
      }
      
      private function tabChangeHandler(param1:Event) : void
      {
         if(_tabPageUtil.selectIndex == 2 || _tabPageUtil.selectIndex == 4)
         {
            _avaterView.visible = false;
         }
         else
         {
            _avaterView.visible = true;
         }
         _chooseView.visible = _tabPageUtil.selectIndex == 4 ? false : true;
         var _loc2_:Boolean = _tabPageUtil.selectIndex == 3;
         _avaterView.isEquip = _loc2_;
      }
      
      private function refreshView(param1:GoddessInfo) : void
      {
         if(param1 != null)
         {
            if(param1.isActive)
            {
               _advanceBtn.enable = true;
               _dedicationBtn.enable = true;
               _formationBtn.enable = true;
               _equipBtn.enable = true;
            }
            else
            {
               _advanceBtn.enable = false;
               _dedicationBtn.enable = false;
               _formationBtn.enable = false;
               _equipBtn.enable = false;
               _tabPageUtil.selectIndex = 0;
            }
         }
         else
         {
            _advanceBtn.enable = false;
            _dedicationBtn.enable = false;
            _formationBtn.enable = false;
            _equipBtn.enable = false;
            _tabPageUtil.selectIndex = 0;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_tabPageUtil);
         _tabPageUtil = null;
         ObjectUtils.disposeObject(_levelBtn);
         _levelBtn = null;
         ObjectUtils.disposeObject(_advanceBtn);
         _advanceBtn = null;
         ObjectUtils.disposeObject(_dedicationBtn);
         _dedicationBtn = null;
         ObjectUtils.disposeObject(_formationBtn);
         _formationBtn = null;
         ObjectUtils.disposeObject(_equipBtn);
         _equipBtn = null;
         ObjectUtils.disposeObject(_chooseView);
         _chooseView = null;
         ObjectUtils.disposeObject(_avaterView);
         _avaterView = null;
         GodDessManager.instance.model.selectInfo = null;
         super.dispose();
      }
   }
}

