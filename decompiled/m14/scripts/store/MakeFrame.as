package store
{
   import bag.helper.BagHelper;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.store.StoreModel;
   import store.Intensify.IntensifyView;
   import store.mount.MountView;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class MakeFrame extends Frame implements IManualSize
   {
      
      private var _bg1:MutipleImage;
      
      private var _bg:ScaleBitmapImage;
      
      private var _storeBtn:SelectedButton;
      
      private var _composeBtn:SelectedButton;
      
      private var _switchBtn:SelectedButton;
      
      private var _resolveBtn:SelectedButton;
      
      private var _storeView:StoreView1;
      
      private var _composeView:ComposeView1;
      
      private var _switchView:SwitchView1;
      
      private var _resolveView:NewResolveView;
      
      private var _curSelectView:DisplayObject;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _hBox:HBox;
      
      private var _curFrameInfo:ModuleFrameInfo;
      
      private var _selectIndex:int;
      
      private var _helpBtn:BaseButton;
      
      private var _composeBtnStrip:StripView;
      
      private var _resolveBtnStrip:StripView;
      
      private var _switchBtnStrip:StripView;
      
      public function MakeFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,728,500);
      }
      
      public function get storeBag() : StoreBagII
      {
         return _storeView.storeBagII;
      }
      
      public function get intensifyView() : IntensifyView
      {
         return _storeView.intensifyView;
      }
      
      public function get mountView() : MountView
      {
         return _storeView.mountView;
      }
      
      public function get mountBtn() : SelectedButton
      {
         return _storeView.mountBtn;
      }
      
      public function get refreshBtn() : SelectedButton
      {
         return _storeView.refreshBtn;
      }
      
      public function get buttonGroup() : SelectedButtonGroup
      {
         return _storeView.buttonGroup;
      }
      
      public function get godCastBtn() : SelectedButton
      {
         return _storeView.godCastBtn;
      }
      
      public function get composeBtn() : SelectedButton
      {
         return _composeBtn;
      }
      
      override public function get groups() : Array
      {
         return ["BAG_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         _curFrameInfo = param1;
         var _loc2_:* = FrameControllerManager.instance.storeController.model.defalutPanel;
         if("STORE_PANEL_COMPOSE" !== _loc2_)
         {
            _btnGroup.selectIndex = 0;
            _helpBtn.visible = false;
         }
         else
         {
            _btnGroup.selectIndex = 1;
            _helpBtn.visible = true;
         }
         LayerManager.Instance.addToLayer(this,3,true,true);
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
         NotificationManager.instance.dispatchEvent(new NotificationEvent("BEHAVIOR_ANALYSIS",this));
      }
      
      private function initView() : void
      {
         _titleText = LanguageMgr.GetTranslation("store.view.MakeFrame.title");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("make.Bg1");
         _bg = ComponentFactory.Instance.creatComponentByStylename("make.Back1");
         _storeBtn = ComponentFactory.Instance.creatComponentByStylename("make.storeBtn");
         _composeBtn = ComponentFactory.Instance.creatComponentByStylename("make.composeBtn");
         _switchBtn = ComponentFactory.Instance.creatComponentByStylename("make.switchBtn");
         _resolveBtn = ComponentFactory.Instance.creatComponentByStylename("make.resolveBtn");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("make.btnHbox");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("make.helpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("public.help");
         _composeBtnStrip = ComponentFactory.Instance.creatCustomObject("store.composeBtnStrip");
         _switchBtnStrip = ComponentFactory.Instance.creatCustomObject("store.switchBtnStrip");
         _resolveBtnStrip = ComponentFactory.Instance.creatCustomObject("store.resolveBtnStrip");
         _btnGroup = new SelectedButtonGroup();
         _hBox.addChild(_storeBtn);
         _hBox.addChild(_composeBtn);
         _hBox.addChild(_switchBtn);
         _hBox.addChild(_resolveBtn);
         _btnGroup.addSelectItem(_storeBtn);
         _btnGroup.addSelectItem(_composeBtn);
         _btnGroup.addSelectItem(_switchBtn);
         _btnGroup.addSelectItem(_resolveBtn);
         addToContent(_bg1);
         addToContent(_bg);
         addToContent(_hBox);
         addToContent(_helpBtn);
         addToContent(_composeBtnStrip);
         addToContent(_resolveBtnStrip);
         addToContent(_switchBtnStrip);
         _composeBtn.enable = ArmyManager.instance.thane.grades >= 15;
         _composeBtnStrip.setHitArea(0,0,_composeBtn.width,_composeBtn.height);
         _composeBtnStrip.visible = ArmyManager.instance.thane.grades < 15;
         _composeBtnStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",15);
         _resolveBtn.enable = ArmyManager.instance.thane.grades >= 19;
         _resolveBtnStrip.setTarget(_resolveBtn);
         _resolveBtnStrip.visible = ArmyManager.instance.thane.grades < 19;
         _resolveBtnStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",19);
         _switchBtn.enable = ArmyManager.instance.thane.grades >= 19;
         _switchBtnStrip.setTarget(_switchBtn);
         _switchBtnStrip.visible = ArmyManager.instance.thane.grades < 19;
         _switchBtnStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",19);
      }
      
      private function uintView() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_storeBtn);
         _storeBtn = null;
         ObjectUtils.disposeObject(_composeBtn);
         _composeBtn = null;
         ObjectUtils.disposeObject(_switchBtn);
         _switchBtn = null;
         ObjectUtils.disposeObject(_resolveBtn);
         _resolveBtn = null;
         ObjectUtils.disposeObject(_composeBtnStrip);
         _composeBtnStrip = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_resolveBtnStrip);
         _resolveBtnStrip = null;
         ObjectUtils.disposeObject(_switchBtnStrip);
         _switchBtnStrip = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _btnGroup.addEventListener("change",__tabChangeHandler);
         _composeBtn.addEventListener("click",checkComposeCondition,false,100);
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__helpBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _btnGroup.removeEventListener("change",__tabChangeHandler);
         _composeBtn.removeEventListener("click",checkComposeCondition);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.storeController.openHelpFrame();
      }
      
      private function checkComposeCondition(param1:MouseEvent) : void
      {
         if(ArmyManager.instance.thane.grades < 15)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("store.view.StoreFrame.command01",15));
            param1.stopImmediatePropagation();
         }
      }
      
      private function clearCurSelectView() : void
      {
         ObjectUtils.disposeObject(_curSelectView);
         _curSelectView = null;
         if(_storeView)
         {
            ObjectUtils.disposeObject(_storeView);
         }
         _storeView = null;
         if(_composeView)
         {
            ObjectUtils.disposeObject(_composeView);
         }
         _composeView = null;
         if(_switchView)
         {
            ObjectUtils.disposeObject(_switchView);
         }
         _switchView = null;
         if(_resolveView)
         {
            ObjectUtils.disposeObject(_resolveView);
         }
         _resolveView = null;
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         _bg.height = 395;
         FrameControllerManager.instance.storeController.moveGoodsBack();
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _curSelectView = showStoreView();
               _helpBtn.visible = false;
               _bg.height = 400;
               break;
            case 1:
               _helpBtn.visible = true;
               _curSelectView = showComposeView();
               (_curSelectView as ComposeView1).refreshSelectedCompose();
               FrameControllerManager.instance.storeController.model.selectedPanel = "STORE_PANEL_COMPOSE";
               break;
            case 2:
               _curSelectView = showSwitchView();
               _helpBtn.visible = false;
               FrameControllerManager.instance.storeController.model.selectedPanel = "STORE_PANEL_SWITCH";
               break;
            case 3:
               _curSelectView = showResolveView();
               _helpBtn.visible = false;
               FrameControllerManager.instance.storeController.model.selectedPanel = "STORE_PANEL_RESOLVE";
               break;
            default:
               return;
         }
         _selectIndex = _btnGroup.selectIndex;
         addToContent(_curSelectView);
      }
      
      private function showStoreView() : DisplayObject
      {
         var _loc1_:GoodsInfo = null;
         clearCurSelectView();
         if(_storeView == null)
         {
            _storeView = ComponentFactory.Instance.creatCustomObject("store.StoreView1");
         }
         _storeView.recoverSelectPanel();
         if(_storeView.storeBagII != null)
         {
            _loc1_ = _curFrameInfo.frameData as GoodsInfo;
            if(_loc1_ != null)
            {
               _storeView.storeBagII.moveItem(_loc1_);
               _curFrameInfo = null;
            }
         }
         return _storeView;
      }
      
      private function showComposeView() : DisplayObject
      {
         clearCurSelectView();
         if(_composeView == null)
         {
            _composeView = ComponentFactory.Instance.creatCustomObject("store.ComposeView1",[_curFrameInfo]);
         }
         return _composeView;
      }
      
      private function showSwitchView() : DisplayObject
      {
         clearCurSelectView();
         if(_switchView == null)
         {
            _switchView = ComponentFactory.Instance.creatCustomObject("store.SwitchView1",[_curFrameInfo]);
         }
         return _switchView;
      }
      
      private function showResolveView() : DisplayObject
      {
         clearCurSelectView();
         if(_resolveView == null)
         {
            _resolveView = ComponentFactory.Instance.creatCustomObject("store.NewResolveView");
         }
         return _resolveView;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get model() : StoreModel
      {
         return FrameControllerManager.instance.storeController.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _curFrameInfo = null;
         uintView();
         clearCurSelectView();
         BagHelper.instance.stopSelling();
         DragManager.getInstance().stopDrag();
         NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_FIGHT"));
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
         model.selectedPanel = "";
         super.dispose();
      }
   }
}

