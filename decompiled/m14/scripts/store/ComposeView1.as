package store
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.ModuleFrameInfo;
   import mvc.controler.StoreControler;
   import mvc.module.store.StoreModel;
   import store.compose.ComposeListView;
   import store.compose.ComposeMatetialView;
   import store.compose.ComposeSubListView;
   import store.compose.IComposeList;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class ComposeView1 extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _equipBtnBtn:SelectedButton;
      
      private var _gemBtn:SelectedButton;
      
      private var _propertyBtn:SelectedButton;
      
      private var _theseusBtn:SelectedButton;
      
      private var _revengeBtn:SelectedButton;
      
      private var _checkBtn:SelectedButton;
      
      private var _hbox:HBox;
      
      private var _matetialView:ComposeMatetialView;
      
      private var _curTreeComponent:Sprite;
      
      private var _composeListView:ComposeListView;
      
      private var _composeSubListView:ComposeSubListView;
      
      private var _boxBg:ScaleBitmapImage;
      
      private var _makeBg:Bitmap;
      
      private var _storeFrameEquipBg:MovieClip;
      
      public function ComposeView1(param1:ModuleFrameInfo)
      {
         super();
         FrameControllerManager.instance.storeController.initComposeGoodsCount();
         FrameControllerManager.instance.storeController.model.composeType = 0;
         initView();
         initEvent();
         initTabSelect(param1);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("store.ComposeViewBg");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("make.compose.hbox");
         _buttonGroup = new SelectedButtonGroup();
         var _loc2_:Vector.<SelectedButton> = new Vector.<SelectedButton>();
         _equipBtnBtn = ComponentFactory.Instance.creatComponentByStylename("make.compose.ComposeEquipBtn");
         _loc2_.push(_equipBtnBtn);
         var _loc3_:ThaneInfo = ArmyManager.instance.thane;
         _propertyBtn = ComponentFactory.Instance.creatComponentByStylename("make.compose.ComposePropertyBtn");
         _loc2_.push(_propertyBtn);
         _gemBtn = ComponentFactory.Instance.creatComponentByStylename("make.compose.ComposeActiveBtn");
         _loc2_.push(_gemBtn);
         _theseusBtn = ComponentFactory.Instance.creatComponentByStylename("make.compose.ComposeTheseusBtn");
         _loc2_.push(_theseusBtn);
         _revengeBtn = ComponentFactory.Instance.creatComponentByStylename("make.compose.ComposeRevengeBtn");
         if(VersionSwitch.AVENGER)
         {
            _loc2_.push(_revengeBtn);
         }
         for each(var _loc1_:SelectedButton in _loc2_)
         {
            _hbox.addChild(_loc1_);
            _buttonGroup.addSelectItem(_loc1_);
         }
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposeCheckButton");
         _boxBg = ComponentFactory.Instance.creatComponentByStylename("store.ComposeDescribeBackground2");
         _makeBg = ComponentFactory.Instance.creatBitmap("asset.store.ComposeMakeBg");
         _storeFrameEquipBg = ComponentFactory.Instance.creatCustomObject("store.StoreFrameEquipBg");
         _storeFrameEquipBg.mouseEnabled = false;
         _storeFrameEquipBg.mouseChildren = true;
         var _loc5_:uint = 50;
         var _loc6_:uint = 195;
         var _loc4_:uint = 275;
         _composeListView = new ComposeListView(0,0);
         _composeSubListView = new ComposeSubListView(0,0);
         _composeListView.setListPanelHeight(_loc4_);
         _composeListView.setListPanelWidth(_loc6_);
         _composeSubListView.setListPanelHeight(_loc4_);
         _composeSubListView.setListPanelWidth(_loc6_);
         _composeListView.y = _composeSubListView.y = _loc5_;
         _matetialView = new ComposeMatetialView();
         _matetialView.y = _loc5_;
         addChild(_bg);
         addChild(_matetialView);
         addChild(_boxBg);
         addChild(_hbox);
         addChild(_makeBg);
         addChild(_checkBtn);
         addChild(_storeFrameEquipBg);
         if(!ArmyManager.instance.thane.isAvenger)
         {
            _revengeBtn.enable = false;
         }
         _theseusBtn.enable = RoyaltyBossManager.instance.model.royaltyLevel > 0;
      }
      
      private function initEvent() : void
      {
         GoodsManager.instance.addEventListener("UPDATE_BAG",goodsChangeHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",goodsChangeHandler);
         _revengeBtn.addEventListener("click",onCheckRevenge,false,10);
         _buttonGroup.addEventListener("change",tabSelectHandler);
         _checkBtn.addEventListener("click",onCheckBtnHandler);
         MsgMan.addObserver("DEVIL_ARMOR_BAG_UPDATE",this,__updateBagCountViewHandler);
         MsgMan.addObserver("EVENT_THESEUS_BAG_UPDATE",this,__updateBagCountViewHandler);
         _theseusBtn.addEventListener("click",onCheckTheseus,false,10);
         TheseussoulManager.Instance.addEventListener("EVENT_SUIT_UPDATE",__suitUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BAG",goodsChangeHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",goodsChangeHandler);
         if(_buttonGroup != null)
         {
            _buttonGroup.removeEventListener("change",tabSelectHandler);
         }
         if(_revengeBtn != null)
         {
            _revengeBtn.removeEventListener("click",onCheckRevenge);
         }
         if(_checkBtn != null)
         {
            _checkBtn.removeEventListener("click",onCheckBtnHandler);
         }
         MsgMan.removeObserver("DEVIL_ARMOR_BAG_UPDATE",this,__updateBagCountViewHandler);
         MsgMan.removeObserver("EVENT_THESEUS_BAG_UPDATE",this,__updateBagCountViewHandler);
         if(_theseusBtn != null)
         {
            _theseusBtn.removeEventListener("click",onCheckTheseus);
         }
         TheseussoulManager.Instance.removeEventListener("EVENT_SUIT_UPDATE",__suitUpdateHandler);
      }
      
      private function __updateBagCountViewHandler(param1:String, param2:Object) : void
      {
         FrameControllerManager.instance.storeController.initComposeGoodsCount();
         updateTreeComponent();
         if(_matetialView)
         {
            _matetialView.data = FrameControllerManager.instance.storeController.model.selectedCompose;
         }
      }
      
      private function onCheckTheseus(param1:MouseEvent) : void
      {
      }
      
      private function onCheckRevenge(param1:MouseEvent) : void
      {
         if(!ArmyManager.instance.thane.isAvenger)
         {
            param1.stopImmediatePropagation();
            param1.stopPropagation();
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MainToolBar.needAvenger"));
         }
      }
      
      private function initTabSelect(param1:ModuleFrameInfo) : void
      {
         var _loc2_:StoreControler = FrameControllerManager.instance.storeController;
         var _loc3_:StoreModel = _loc2_.model;
         if(_loc3_.isCanMake)
         {
            _checkBtn.selected = true;
         }
         if(StoreModel.defaultChildPanel == 3)
         {
            _buttonGroup.selectIndex = 1;
            StoreModel.defaultChildPanel = 1;
         }
         else
         {
            _buttonGroup.selectIndex = 0;
         }
      }
      
      private function onCheckBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:StoreModel = FrameControllerManager.instance.storeController.model;
         _loc2_.isCanMake = !_loc2_.isCanMake;
         updateTreeComponent();
      }
      
      private function updateTreeComponent() : void
      {
         var _loc1_:StoreModel = null;
         var _loc2_:int = getModelTypeByTab(_buttonGroup.getSelectedItem() as SelectedButton);
         if(_loc2_ > 0)
         {
            _loc1_ = FrameControllerManager.instance.storeController.model;
            _curTreeComponent = getTreeComponentByModelType(_loc2_);
            if(_curTreeComponent == _composeSubListView)
            {
               (_curTreeComponent as IComposeList).update(_loc1_.selectedDic[_loc1_.selectedType]);
            }
            else if(_curTreeComponent == _composeListView)
            {
               (_curTreeComponent as IComposeList).update(_loc1_.selectedDic[_loc1_.selectedType + "SUIT_SUBCELL"]);
            }
         }
      }
      
      private function goodsChangeHandler(param1:Event) : void
      {
         FrameControllerManager.instance.storeController.initComposeGoodsCount();
         updateTreeComponent();
         if(_matetialView)
         {
            _matetialView.data = FrameControllerManager.instance.storeController.model.selectedCompose;
         }
      }
      
      private function __suitUpdateHandler(param1:Event) : void
      {
         FrameControllerManager.instance.storeController.initComposeGoodsCount();
         updateTreeComponent();
         if(_matetialView)
         {
            _matetialView.data = FrameControllerManager.instance.storeController.model.selectedCompose;
         }
      }
      
      public function refreshSelectedCompose() : void
      {
         _matetialView.refreshSelectedCompose();
      }
      
      private function tabSelectHandler(param1:Event) : void
      {
         var _loc2_:StoreModel = null;
         SoundManager.instance.play("022");
         var _loc3_:int = getModelTypeByTab(_buttonGroup.getSelectedItem() as SelectedButton);
         if(_loc3_ > 0)
         {
            clearTreeComponent();
            _curTreeComponent = getTreeComponentByModelType(_loc3_);
            addChild(_curTreeComponent);
            _loc2_ = FrameControllerManager.instance.storeController.model;
            _loc2_.selectedDic[_loc2_.selectedType + "scrollValue"] = 0;
            if(_loc2_.selectedCompose)
            {
               _loc2_.selectedCompose.selected = false;
            }
            _loc2_.selectedCompose = null;
            _loc2_.selectedDic[_loc2_.selectedType] = null;
            (_curTreeComponent as IComposeList).selectedByType(_loc3_,_loc2_.selectedDic[_loc3_]);
            FrameControllerManager.instance.storeController.currComposeType = _loc3_;
         }
      }
      
      private function getTreeComponentByModelType(param1:int) : Sprite
      {
         var _loc2_:Sprite = null;
         switch(param1 - 1)
         {
            case 0:
            case 2:
            case 3:
            case 4:
               _loc2_ = _composeSubListView;
               break;
            default:
               _loc2_ = _composeListView;
         }
         return _loc2_;
      }
      
      private function getModelTypeByTab(param1:SelectedButton) : int
      {
         switch(param1)
         {
            case _propertyBtn:
               return 2;
            case _equipBtnBtn:
               return 1;
            case _gemBtn:
               return 3;
            case _revengeBtn:
               return 4;
            case _theseusBtn:
               return 5;
            default:
               return -1;
         }
      }
      
      private function clearTreeComponent() : void
      {
         if(_curTreeComponent != null)
         {
            if(_curTreeComponent.parent != null)
            {
               _curTreeComponent.parent.removeChild(_curTreeComponent);
            }
         }
         _curTreeComponent = null;
      }
      
      public function dispose() : void
      {
         clearTreeComponent();
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_buttonGroup);
         _buttonGroup = null;
         ObjectUtils.disposeObject(_equipBtnBtn);
         _equipBtnBtn = null;
         ObjectUtils.disposeObject(_gemBtn);
         _gemBtn = null;
         ObjectUtils.disposeObject(_revengeBtn);
         _revengeBtn = null;
         ObjectUtils.disposeObject(_propertyBtn);
         _propertyBtn = null;
         ObjectUtils.disposeObject(_checkBtn);
         _checkBtn = null;
         ObjectUtils.disposeObject(_matetialView);
         _matetialView = null;
         ObjectUtils.disposeObject(_curTreeComponent);
         _curTreeComponent = null;
         ObjectUtils.disposeObject(_composeListView);
         _composeListView = null;
         ObjectUtils.disposeObject(_composeSubListView);
         _composeSubListView = null;
         ObjectUtils.disposeObject(_boxBg);
         _boxBg = null;
         ObjectUtils.disposeObject(_makeBg);
         _makeBg = null;
         ObjectUtils.disposeViolentMc(_storeFrameEquipBg);
         _storeFrameEquipBg = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

