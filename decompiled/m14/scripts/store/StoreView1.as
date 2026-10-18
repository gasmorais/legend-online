package store
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.module.store.StoreModel;
   import store.Intensify.IntensifyView;
   import store.cast.CastView;
   import store.mount.MountView;
   import store.refresh.RefreshView;
   import store.treasure.TreasureIntensifyView;
   import store.treasure.TreasureRefreshView;
   import yishi.datas.VersionSwitch;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.view.tips.MessageTipManager;
   
   public class StoreView1 extends Sprite implements Disposeable
   {
      
      private var _intensifyBtn:SelectedButton;
      
      private var _mountBtn:SelectedButton;
      
      private var _refreshBtn:SelectedButton;
      
      private var _castBtn:SelectedButton;
      
      private var _treasureBtn:SelectedButton;
      
      private var _treasureRefreshBtn:SelectedButton;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _hBox:HBox;
      
      private var _curSelectedPanel:String;
      
      private var _curSelectView:Sprite;
      
      private var _intensifyView:IntensifyView;
      
      private var _mountView:MountView;
      
      private var _storeBag:StoreBagII;
      
      private var _frameTitleBg:Bitmap;
      
      private var _mountBtnStrip:StripView;
      
      private var _refreshBtnStrip:StripView;
      
      private var _castBtnStrip:StripView;
      
      private var _treasureBtnStrip:StripView;
      
      private var _treasureRefreshBtnStrip:StripView;
      
      public function StoreView1()
      {
         super();
         initView();
         initEvent();
         initTabSelect(FrameControllerManager.instance.storeController.model.defalutPanel);
      }
      
      private function initView() : void
      {
         _intensifyBtn = ComponentFactory.Instance.creatComponentByStylename("make.store.IntensifyBtn");
         _mountBtn = ComponentFactory.Instance.creatComponentByStylename("make.store.MountBtn");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("make.store.refreshBtn");
         _castBtn = ComponentFactory.Instance.creatComponentByStylename("make.store.CastBtn");
         _treasureBtn = ComponentFactory.Instance.creatComponentByStylename("make.store.treasureBtn");
         _treasureRefreshBtn = ComponentFactory.Instance.creatComponentByStylename("make.store.treasureRefreshBtn");
         _storeBag = ComponentFactory.Instance.creatCustomObject("StoreView1.StoreBagII");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("make.store.hbox");
         _castBtnStrip = ComponentFactory.Instance.creatCustomObject("store.castBtnStrip");
         _mountBtnStrip = ComponentFactory.Instance.creatCustomObject("store.mountBtnStrip");
         _refreshBtnStrip = ComponentFactory.Instance.creatCustomObject("store.refreshBtnStrip");
         _treasureBtnStrip = ComponentFactory.Instance.creatCustomObject("store.treasureBtnStrip");
         _treasureRefreshBtnStrip = ComponentFactory.Instance.creatCustomObject("store.treasureRefreshBtnStrip");
         addChild(_storeBag);
         addChild(_hBox);
         _buttonGroup = new SelectedButtonGroup();
         var _loc2_:Vector.<SelectedButton> = new <SelectedButton>[_intensifyBtn,_mountBtn,_refreshBtn,_castBtn,_treasureBtn,_treasureRefreshBtn];
         for each(var _loc1_:SelectedButton in _loc2_)
         {
            _hBox.addChild(_loc1_);
            _buttonGroup.addSelectItem(_loc1_);
         }
         addChild(_mountBtnStrip);
         addChild(_refreshBtnStrip);
         addChild(_castBtnStrip);
         _mountBtn.enable = ArmyManager.instance.thane.grades >= 15;
         _mountBtnStrip.setTarget(_mountBtn);
         _mountBtnStrip.visible = ArmyManager.instance.thane.grades < 15;
         _mountBtnStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",15);
         _refreshBtn.enable = ArmyManager.instance.thane.grades >= 19;
         _refreshBtnStrip.setTarget(_refreshBtn);
         _refreshBtnStrip.visible = ArmyManager.instance.thane.grades < 19;
         _refreshBtnStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",19);
         _castBtn.enable = ArmyManager.instance.thane.grades >= 80;
         _castBtnStrip.setTarget(_castBtn);
         _castBtnStrip.visible = ArmyManager.instance.thane.grades < 80;
         _castBtnStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",80);
         _treasureBtn.visible = RoyaltyBossManager.instance.model.royaltyLevel > 0 && Boolean(VersionSwitch.TREASURE);
         _treasureRefreshBtn.visible = RoyaltyBossManager.instance.model.royaltyLevel > 0 && Boolean(VersionSwitch.TREASURE);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _buttonGroup.addEventListener("change",__onTabBtnHandler);
         _mountBtn.addEventListener("click",__mouseHandler,false,100);
         _intensifyBtn.addEventListener("click",__mouseHandler,false,100);
         _refreshBtn.addEventListener("click",__mouseHandler,false,100);
         _castBtn.addEventListener("click",__mouseHandler,false,100);
         _treasureBtn.addEventListener("click",__mouseHandler,false,100);
         _treasureRefreshBtn.addEventListener("click",__mouseHandler,false,100);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_buttonGroup != null)
         {
            _buttonGroup.removeEventListener("change",__onTabBtnHandler);
         }
         if(_mountBtn != null)
         {
            _mountBtn.removeEventListener("click",__mouseHandler);
         }
         if(_intensifyBtn != null)
         {
            _intensifyBtn.removeEventListener("click",__mouseHandler);
         }
         if(_refreshBtn != null)
         {
            _refreshBtn.removeEventListener("click",__mouseHandler);
         }
         if(_castBtn != null)
         {
            _castBtn.removeEventListener("click",__mouseHandler);
         }
         if(_treasureBtn != null)
         {
            _treasureBtn.removeEventListener("click",__mouseHandler);
         }
         if(_treasureRefreshBtn != null)
         {
            _treasureRefreshBtn.removeEventListener("click",__mouseHandler);
         }
      }
      
      private function initTabSelect(param1:String) : void
      {
         switch(param1)
         {
            case "STORE_PANEL_INTENSIFY":
               _buttonGroup.selectIndex = 0;
               break;
            case "STORE_PANEL_MOUNT":
               _buttonGroup.selectIndex = 1;
               break;
            case "STORE_PANEL_REFRESH":
               _buttonGroup.selectIndex = 2;
               break;
            case "STORE_PANEL_CAST":
               _buttonGroup.selectIndex = 3;
               break;
            case "STORE_PANEL_TREASURE_INTENSIFY":
               _buttonGroup.selectIndex = 4;
               break;
            default:
               _buttonGroup.selectIndex = 0;
               return;
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
      
      private function __onTabBtnHandler(param1:Event) : void
      {
         var _loc2_:StoreModel = FrameControllerManager.instance.storeController.model;
         if(_curSelectView != null)
         {
            ObjectUtils.disposeObject(_curSelectView);
         }
         _curSelectView = null;
         _storeBag.visible = true;
         switch(_buttonGroup.getSelectedItem())
         {
            case _intensifyBtn:
               _loc2_.selectedPanel = "STORE_PANEL_INTENSIFY";
               _curSelectView = ComponentFactory.Instance.creatCustomObject("store.IntensifyView") as IntensifyView;
               _intensifyView = _curSelectView as IntensifyView;
               break;
            case _mountBtn:
               _loc2_.selectedPanel = "STORE_PANEL_MOUNT";
               _curSelectView = ComponentFactory.Instance.creatCustomObject("store.MountView") as MountView;
               _mountView = _curSelectView as MountView;
               break;
            case _refreshBtn:
               _loc2_.selectedPanel = "STORE_PANEL_REFRESH";
               _curSelectView = ComponentFactory.Instance.creatCustomObject("store.RefreshView") as RefreshView;
               break;
            case _castBtn:
               _loc2_.selectedPanel = "STORE_PANEL_CAST";
               _curSelectView = ComponentFactory.Instance.creatCustomObject("store.CastView") as CastView;
               break;
            case _treasureBtn:
               _loc2_.selectedPanel = "STORE_PANEL_TREASURE_INTENSIFY";
               _curSelectView = ComponentFactory.Instance.creatCustomObject("store.IntensifyView.treasure") as TreasureIntensifyView;
               _storeBag.visible = false;
               break;
            case _treasureRefreshBtn:
               _loc2_.selectedPanel = "STORE_PANEL_TREASURE_REFRESH";
               _curSelectView = ComponentFactory.Instance.creatCustomObject("store.RefreshView.treasure") as TreasureRefreshView;
               _storeBag.visible = false;
               break;
            default:
               return;
         }
         SoundManager.instance.play("022",false,false);
         FrameControllerManager.instance.storeController.moveGoodsBack();
         _curSelectedPanel = _loc2_.selectedPanel;
         addChild(_curSelectView);
      }
      
      private function __mouseHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = "";
         if(ArmyManager.instance.thane.grades < 15 && param1.currentTarget == _mountBtn)
         {
            _loc2_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",15);
            MessageTipManager.instance().show(_loc2_);
            param1.stopImmediatePropagation();
         }
         else if(ArmyManager.instance.thane.grades < 19 && param1.currentTarget == _refreshBtn)
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
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_intensifyBtn);
         _intensifyBtn = null;
         ObjectUtils.disposeObject(_mountBtn);
         _mountBtn = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_castBtn);
         _castBtn = null;
         ObjectUtils.disposeObject(_storeBag);
         _storeBag = null;
         ObjectUtils.disposeObject(_frameTitleBg);
         _frameTitleBg = null;
         ObjectUtils.disposeObject(_mountBtnStrip);
         _mountBtnStrip = null;
         ObjectUtils.disposeObject(_refreshBtnStrip);
         _refreshBtnStrip = null;
         ObjectUtils.disposeObject(_castBtnStrip);
         _castBtnStrip = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      public function recoverSelectPanel() : void
      {
         if(_curSelectedPanel == null)
         {
            _curSelectedPanel = "STORE_PANEL_INTENSIFY";
         }
         _buttonGroup.selectIndex = -1;
         initTabSelect(_curSelectedPanel);
      }
      
      public function get storeBagII() : StoreBagII
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
      
      public function get buttonGroup() : SelectedButtonGroup
      {
         return _buttonGroup;
      }
      
      public function get godCastBtn() : SelectedButton
      {
         return _castBtn;
      }
   }
}

