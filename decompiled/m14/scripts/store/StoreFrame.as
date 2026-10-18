package store
{
   import bag.helper.BagHelper;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.controler.StoreControler;
   import mvc.module.store.StoreModel;
   import store.Intensify.IntensifyView;
   import store.cast.CastView;
   import store.compose.ComposeView;
   import store.mount.MountView;
   import store.refresh.RefreshView;
   import store.resolve.ResolveView;
   import store.switched.SwitchView;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class StoreFrame extends Frame implements IManualSize
   {
      
      private var _intensifyBtn:SelectedButton;
      
      private var _mountBtn:SelectedButton;
      
      private var _composeBtn:SelectedButton;
      
      private var _refreshBtn:SelectedButton;
      
      private var _resolveBtn:SelectedButton;
      
      private var _switchBtn:SelectedButton;
      
      private var _castBtn:SelectedButton;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _intensifyView:IntensifyView;
      
      private var _mountView:MountView;
      
      private var _composeView:ComposeView;
      
      private var _refreshView:RefreshView;
      
      private var _resolveView:ResolveView;
      
      private var _switchView:SwitchView;
      
      private var _castView:CastView;
      
      private var _storeBag:StoreBag;
      
      private var _frameTitleBg:Bitmap;
      
      private var _frameData:ModuleFrameInfo;
      
      public function StoreFrame()
      {
         super();
         initView();
         addEvent();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      private function get model() : StoreModel
      {
         return control.model;
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,728,465);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _titleText = LanguageMgr.GetTranslation("store.view.StoreFrame.title");
         _frameTitleBg = ComponentFactory.Instance.creatBitmap("asset.store.StoreFrameTitle");
         _intensifyBtn = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyBtn");
         _mountBtn = ComponentFactory.Instance.creatComponentByStylename("store.MountBtn");
         _composeBtn = ComponentFactory.Instance.creatComponentByStylename("store.FusionBtn");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("store.refreshBtn");
         _resolveBtn = ComponentFactory.Instance.creatComponentByStylename("store.resolveBtn");
         _switchBtn = ComponentFactory.Instance.creatComponentByStylename("store.switchBtn");
         _castBtn = ComponentFactory.Instance.creatComponentByStylename("store.CastBtn");
         _storeBag = ComponentFactory.Instance.creatCustomObject("store.StoreBag",[7,6]);
         addToContent(_frameTitleBg);
         _buttonGroup = new SelectedButtonGroup();
         addToContent(_intensifyBtn);
         addToContent(_mountBtn);
         addToContent(_composeBtn);
         addToContent(_refreshBtn);
         addToContent(_resolveBtn);
         addToContent(_switchBtn);
         if(VersionSwitch.STORE_CAST)
         {
            addToContent(_castBtn);
         }
         addToContent(_storeBag);
         _buttonGroup.addSelectItem(_intensifyBtn);
         _buttonGroup.addSelectItem(_mountBtn);
         _buttonGroup.addSelectItem(_composeBtn);
         _buttonGroup.addSelectItem(_refreshBtn);
         _buttonGroup.addSelectItem(_resolveBtn);
         _buttonGroup.addSelectItem(_switchBtn);
         if(VersionSwitch.STORE_CAST)
         {
            _buttonGroup.addSelectItem(_castBtn);
         }
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_frameTitleBg);
         _frameTitleBg = null;
         ObjectUtils.disposeObject(_intensifyBtn);
         _intensifyBtn = null;
         ObjectUtils.disposeObject(_mountBtn);
         _mountBtn = null;
         ObjectUtils.disposeObject(_composeBtn);
         _composeBtn = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_resolveBtn);
         _resolveBtn = null;
         ObjectUtils.disposeObject(_switchBtn);
         _switchBtn = null;
         ObjectUtils.disposeObject(_castBtn);
         _castBtn = null;
         ObjectUtils.disposeObject(_composeView);
         _composeView = null;
         ObjectUtils.disposeObject(_refreshView);
         _refreshView = null;
         ObjectUtils.disposeObject(_resolveView);
         _resolveView = null;
         ObjectUtils.disposeObject(_switchView);
         _switchView = null;
         ObjectUtils.disposeObject(_intensifyView);
         _intensifyView = null;
         ObjectUtils.disposeObject(_mountView);
         _mountView = null;
         ObjectUtils.disposeObject(_castView);
         _castView = null;
         ObjectUtils.disposeAllChildren(this);
         DragManager.getInstance().stopDrag();
         CursorManagerII.instance.resetCursor();
      }
      
      protected function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _buttonGroup.addEventListener("change",__onTapBtnHandler);
         _mountBtn.addEventListener("click",__mouseHandler,false,100);
         _composeBtn.addEventListener("click",__mouseHandler,false,100);
         _intensifyBtn.addEventListener("click",__mouseHandler,false,100);
         _refreshBtn.addEventListener("click",__mouseHandler,false,100);
         _resolveBtn.addEventListener("click",__mouseHandler,false,100);
         _switchBtn.addEventListener("click",__mouseHandler,false,100);
         _castBtn.addEventListener("click",__mouseHandler,false,100);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _buttonGroup.removeEventListener("change",__onTapBtnHandler);
         _mountBtn.removeEventListener("click",__mouseHandler);
         _composeBtn.removeEventListener("click",__mouseHandler);
         _intensifyBtn.removeEventListener("click",__mouseHandler);
         _refreshBtn.removeEventListener("click",__mouseHandler);
         _resolveBtn.removeEventListener("click",__mouseHandler);
         _switchBtn.removeEventListener("click",__mouseHandler);
         _castBtn.removeEventListener("click",__mouseHandler);
      }
      
      private function __mouseHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = "";
         if(ArmyManager.instance.thane.grades < 15 && (param1.currentTarget == _composeBtn || param1.currentTarget == _mountBtn))
         {
            _loc2_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",15);
            MessageTipManager.instance().show(_loc2_);
            param1.stopImmediatePropagation();
         }
         else if(ArmyManager.instance.thane.grades < 19 && (param1.currentTarget == _refreshBtn || param1.currentTarget == _resolveBtn || param1.currentTarget == _switchBtn))
         {
            _loc2_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",19);
            MessageTipManager.instance().show(_loc2_);
            param1.stopImmediatePropagation();
         }
         else if(PlayerManager.instance.currentPlayerModel.playerInfo.vocationGrades <= 0 && param1.currentTarget == _castBtn)
         {
            _loc2_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command02",80);
            MessageTipManager.instance().show(_loc2_);
            param1.stopImmediatePropagation();
         }
      }
      
      private function __onTapBtnHandler(param1:Event) : void
      {
         SoundManager.instance.play("022",false,false);
         control.moveGoodsBack();
         _storeBag.visible = true;
         switch(_buttonGroup.getSelectedItem())
         {
            case _intensifyBtn:
               model.selectedPanel = "STORE_PANEL_INTENSIFY";
               if(!_intensifyView)
               {
                  _intensifyView = ComponentFactory.Instance.creatCustomObject("store.IntensifyView");
               }
               addToContent(_intensifyView);
               ObjectUtils.disposeObject(_composeView);
               _composeView = null;
               ObjectUtils.disposeObject(_mountView);
               _mountView = null;
               ObjectUtils.disposeObject(_refreshView);
               _refreshView = null;
               ObjectUtils.disposeObject(_resolveView);
               _resolveView = null;
               ObjectUtils.disposeObject(_switchView);
               _switchView = null;
               ObjectUtils.disposeObject(_castView);
               _castView = null;
               break;
            case _mountBtn:
               model.selectedPanel = "STORE_PANEL_MOUNT";
               if(!_mountView)
               {
                  _mountView = ComponentFactory.Instance.creatCustomObject("store.MountView");
               }
               addToContent(_mountView);
               ObjectUtils.disposeObject(_composeView);
               _composeView = null;
               ObjectUtils.disposeObject(_intensifyView);
               _intensifyView = null;
               ObjectUtils.disposeObject(_refreshView);
               _refreshView = null;
               ObjectUtils.disposeObject(_resolveView);
               _resolveView = null;
               ObjectUtils.disposeObject(_switchView);
               _switchView = null;
               ObjectUtils.disposeObject(_castView);
               _castView = null;
               break;
            case _composeBtn:
               model.selectedPanel = "STORE_PANEL_COMPOSE";
               if(!_composeView)
               {
                  _composeView = ComponentFactory.Instance.creatCustomObject("store.ComposeView",[_frameData]);
               }
               _frameData = null;
               addToContent(_composeView);
               ObjectUtils.disposeObject(_intensifyView);
               _intensifyView = null;
               ObjectUtils.disposeObject(_mountView);
               _mountView = null;
               ObjectUtils.disposeObject(_refreshView);
               _refreshView = null;
               ObjectUtils.disposeObject(_resolveView);
               _resolveView = null;
               ObjectUtils.disposeObject(_switchView);
               _switchView = null;
               ObjectUtils.disposeObject(_castView);
               _castView = null;
               _storeBag.visible = false;
               break;
            case _refreshBtn:
               model.selectedPanel = "STORE_PANEL_REFRESH";
               if(!_refreshView)
               {
                  _refreshView = ComponentFactory.Instance.creatCustomObject("store.RefreshView");
               }
               addToContent(_refreshView);
               ObjectUtils.disposeObject(_composeView);
               _composeView = null;
               ObjectUtils.disposeObject(_intensifyView);
               _intensifyView = null;
               ObjectUtils.disposeObject(_mountView);
               _mountView = null;
               ObjectUtils.disposeObject(_resolveView);
               _resolveView = null;
               ObjectUtils.disposeObject(_switchView);
               _switchView = null;
               ObjectUtils.disposeObject(_castView);
               _castView = null;
               break;
            case _resolveBtn:
               model.selectedPanel = "STORE_PANEL_RESOLVE";
               if(!_resolveView)
               {
                  _resolveView = ComponentFactory.Instance.creatCustomObject("store.ResolveView");
               }
               addToContent(_resolveView);
               ObjectUtils.disposeObject(_composeView);
               _composeView = null;
               ObjectUtils.disposeObject(_intensifyView);
               _intensifyView = null;
               ObjectUtils.disposeObject(_mountView);
               _mountView = null;
               ObjectUtils.disposeObject(_refreshView);
               _refreshView = null;
               ObjectUtils.disposeObject(_switchView);
               _switchView = null;
               ObjectUtils.disposeObject(_castView);
               _castView = null;
               break;
            case _switchBtn:
               model.selectedPanel = "STORE_PANEL_SWITCH";
               if(!_switchView)
               {
                  _switchView = ComponentFactory.Instance.creatCustomObject("store.SwitchView");
               }
               addToContent(_switchView);
               ObjectUtils.disposeObject(_composeView);
               _composeView = null;
               ObjectUtils.disposeObject(_intensifyView);
               _intensifyView = null;
               ObjectUtils.disposeObject(_mountView);
               _mountView = null;
               ObjectUtils.disposeObject(_refreshView);
               _refreshView = null;
               ObjectUtils.disposeObject(_resolveView);
               _resolveView = null;
               ObjectUtils.disposeObject(_castView);
               _castView = null;
               break;
            case _castBtn:
               model.selectedPanel = "STORE_PANEL_CAST";
               if(!_castView)
               {
                  _castView = ComponentFactory.Instance.creatCustomObject("store.CastView");
               }
               addToContent(_castView);
               ObjectUtils.disposeObject(_composeView);
               _composeView = null;
               ObjectUtils.disposeObject(_intensifyView);
               _intensifyView = null;
               ObjectUtils.disposeObject(_mountView);
               _mountView = null;
               ObjectUtils.disposeObject(_refreshView);
               _refreshView = null;
               ObjectUtils.disposeObject(_resolveView);
               _resolveView = null;
               ObjectUtils.disposeObject(_switchView);
               _switchView = null;
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
      
      public function show(param1:ModuleFrameInfo) : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("BEHAVIOR_ANALYSIS",this));
         _frameData = param1;
         switch(model.defalutPanel)
         {
            case "STORE_PANEL_INTENSIFY":
               _buttonGroup.selectIndex = 0;
               break;
            case "STORE_PANEL_MOUNT":
               _buttonGroup.selectIndex = 1;
               break;
            case "STORE_PANEL_COMPOSE":
               _buttonGroup.selectIndex = 2;
               break;
            case "STORE_PANEL_REFRESH":
               _buttonGroup.selectIndex = 3;
               break;
            case "STORE_PANEL_RESOLVE":
               _buttonGroup.selectIndex = 4;
               break;
            case "STORE_PANEL_SWITCH":
               _buttonGroup.selectIndex = 5;
               break;
            case "STORE_PANEL_CAST":
               _buttonGroup.selectIndex = 6;
         }
         if(_storeBag && _frameData)
         {
            _storeBag.moveItem(_frameData.frameData as GoodsInfo);
            _frameData = null;
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function get storeBag() : StoreBag
      {
         return _storeBag;
      }
      
      public function get intensifyView() : IntensifyView
      {
         return _intensifyView;
      }
      
      public function get mountView() : MountView
      {
         return _mountView;
      }
      
      public function get mountBtn() : SelectedButton
      {
         return _mountBtn;
      }
      
      public function get refreshBtn() : SelectedButton
      {
         return _refreshBtn;
      }
      
      public function get resolveBtn() : SelectedButton
      {
         return _resolveBtn;
      }
      
      public function get buttonGroup() : SelectedButtonGroup
      {
         return _buttonGroup;
      }
      
      public function get composeBtn() : SelectedButton
      {
         return _composeBtn;
      }
      
      public function get switchBtn() : SelectedButton
      {
         return _switchBtn;
      }
      
      public function get godCastBtn() : SelectedButton
      {
         return _castBtn;
      }
      
      public function get composeEquipUpgradeBtn() : SelectedButton
      {
         if(_composeView && _composeView.updateEquipBtn)
         {
            return _composeView.updateEquipBtn;
         }
         return null;
      }
      
      override public function dispose() : void
      {
         var _loc1_:DisplayObject = null;
         if(isAddToPool)
         {
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
            KeyBoardRegister.instance.keyEnable = true;
            _loc1_ = StageReferance.stage.focus as DisplayObject;
            if(_loc1_ && contains(_loc1_))
            {
               StageReferance.stage.focus = null;
            }
            ComponentFactory.Instance.preStylename = "";
            NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_FIGHT"));
            return;
         }
         KeyBoardRegister.instance.keyEnable = true;
         BagHelper.instance.stopSelling();
         DragManager.getInstance().stopDrag();
         removeEvent();
         uninit();
         super.dispose();
         NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_FIGHT"));
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
      }
   }
}

