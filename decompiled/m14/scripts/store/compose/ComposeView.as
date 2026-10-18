package store.compose
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mvc.ModuleFrameInfo;
   import mvc.controler.StoreControler;
   import mvc.module.store.StoreModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   
   public class ComposeView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _buttongroup:SelectedButtonGroup;
      
      private var _equipBtnBtn:SelectedButton;
      
      private var _gemBtn:SelectedButton;
      
      private var _crystalBtn:SelectedButton;
      
      private var _childBtn:SelectedButton;
      
      private var _shengeBtn:SelectedButton;
      
      private var _propertyBtn:SelectedButton;
      
      private var _updateEquipBtn:SelectedButton;
      
      private var _currentSelected:SelectedButton;
      
      private var _checkBtn:SelectedButton;
      
      private var _vBox:Sprite;
      
      private var _matetialView:ComposeMatetialView;
      
      private var _composeListView:ComposeListView;
      
      private var _composeSubListView:ComposeSubListView;
      
      private var _boxBg:ScaleBitmapImage;
      
      private var _makeBg:Bitmap;
      
      private var _storeFrameEquipBg:MovieClip;
      
      private var _tempListView:Object;
      
      private var _data:Object;
      
      public function ComposeView(param1:Object)
      {
         super();
         model.composeType = 0;
         _data = param1;
         refeshData();
         initView();
         addEvent();
         defaultView();
      }
      
      private function get model() : StoreModel
      {
         return control.model;
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      private function refeshData() : void
      {
         control.initComposeGoodsCount();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("store.ComposeViewBg");
         _propertyBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposePropertyBtn");
         _equipBtnBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposeEquipBtn");
         _gemBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposeActiveBtn");
         _updateEquipBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposeEquipUpdateBtn");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposeCheckButton");
         _boxBg = ComponentFactory.Instance.creatComponentByStylename("store.ComposeDescribeBackground2");
         _makeBg = ComponentFactory.Instance.creatBitmap("asset.store.ComposeMakeBg");
         _storeFrameEquipBg = ComponentFactory.Instance.creatCustomObject("store.StoreFrameEquipBg");
         addChild(_bg);
         _matetialView = new ComposeMatetialView();
         addChild(_matetialView);
         addChild(_boxBg);
         _vBox = new Sprite();
         addChild(_vBox);
         _vBox.y = 18;
         _vBox.addChild(_equipBtnBtn);
         _vBox.addChild(_gemBtn);
         if(thaneInfo.grades >= 55)
         {
            _crystalBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposeCrystalBtn");
            _vBox.addChild(_crystalBtn);
         }
         if(thaneInfo.grades >= 70)
         {
            _childBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposeChildBtn");
            _vBox.addChild(_childBtn);
         }
         if(thaneInfo.grades >= 50)
         {
            _shengeBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposeShengeBtn");
            _vBox.addChild(_shengeBtn);
         }
         _vBox.addChild(_propertyBtn);
         _vBox.addChild(_updateEquipBtn);
         _buttongroup = new SelectedButtonGroup();
         if(thaneInfo.grades >= 70)
         {
            _composeListView = new ComposeListView(205,124);
            _composeSubListView = new ComposeSubListView(205,124);
            _composeListView.setListPanelHeight(80);
            _composeSubListView.setListPanelHeight(80);
         }
         else if(thaneInfo.grades >= 55)
         {
            _composeListView = new ComposeListView(205,154);
            _composeSubListView = new ComposeSubListView(205,154);
            _composeListView.setListPanelHeight(113);
            _composeSubListView.setListPanelHeight(113);
         }
         else if(thaneInfo.grades >= 50)
         {
            _composeListView = new ComposeListView(205,184);
            _composeSubListView = new ComposeSubListView(205,184);
            _composeListView.setListPanelHeight(144);
            _composeSubListView.setListPanelHeight(144);
         }
         else
         {
            _composeListView = new ComposeListView(205,214);
            _composeSubListView = new ComposeSubListView(205,214);
            _composeListView.setListPanelHeight(169);
            _composeSubListView.setListPanelHeight(169);
         }
         addChild(_makeBg);
         addChild(_checkBtn);
         addChild(_storeFrameEquipBg);
         _storeFrameEquipBg.mouseEnabled = false;
         _storeFrameEquipBg.mouseChildren = true;
         _storeFrameEquipBg.x = 332;
         _storeFrameEquipBg.y = 94;
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_propertyBtn);
         _propertyBtn = null;
         ObjectUtils.disposeObject(_equipBtnBtn);
         _equipBtnBtn = null;
         ObjectUtils.disposeObject(_gemBtn);
         _gemBtn = null;
         ObjectUtils.disposeObject(_updateEquipBtn);
         _updateEquipBtn = null;
         ObjectUtils.disposeObject(_checkBtn);
         _checkBtn = null;
         ObjectUtils.disposeObject(_matetialView);
         _matetialView = null;
         ObjectUtils.disposeObject(_composeListView);
         _composeListView = null;
         ObjectUtils.disposeObject(_composeSubListView);
         _composeSubListView = null;
         ObjectUtils.disposeObject(_buttongroup);
         _buttongroup = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_boxBg);
         _boxBg = null;
         ObjectUtils.disposeObject(_makeBg);
         _makeBg = null;
         ObjectUtils.disposeObject(_currentSelected);
         _currentSelected = null;
         ObjectUtils.disposeObject(_storeFrameEquipBg);
         _storeFrameEquipBg = null;
         ObjectUtils.disposeObject(_crystalBtn);
         _crystalBtn = null;
         ObjectUtils.disposeObject(_childBtn);
         _childBtn = null;
         ObjectUtils.disposeObject(_shengeBtn);
         _shengeBtn = null;
         _data = null;
         _tempListView = null;
      }
      
      private function defaultView() : void
      {
         if(model.isCanMake)
         {
            _checkBtn.selected = true;
         }
         if(!_vBox)
         {
            return;
         }
         ObjectUtils.removeChildAllChildrenFromStage(_vBox);
         refreshMenu();
         var _loc1_:ModuleFrameInfo = _data as ModuleFrameInfo;
         if(_loc1_ && _loc1_.frameData is GoodsInfo)
         {
            model.currentUpdateEquip = _loc1_.frameData as GoodsInfo;
            _buttongroup.removeEventListener("change",__menuSelectedHandler);
            _buttongroup.selectIndex = _buttongroup.getIndexByItem(_updateEquipBtn);
            __menuSelectedHandler(null);
         }
         else if(StoreModel.defaultChildPanel == 3)
         {
            _buttongroup.selectIndex = 1;
            StoreModel.defaultChildPanel = 1;
         }
         else
         {
            _buttongroup.selectIndex = 0;
         }
      }
      
      private function addEvent() : void
      {
         GoodsManager.instance.addEventListener("UPDATE_BAG",__goodsChangeHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__goodsChangeHandler);
         _checkBtn.addEventListener("click",__onCheckBtnHandler);
      }
      
      private function removeEvent() : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__goodsChangeHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__goodsChangeHandler);
         _checkBtn.removeEventListener("click",__onCheckBtnHandler);
      }
      
      private function refreshMenu() : void
      {
         _buttongroup.removeEventListener("change",__menuSelectedHandler);
         _buttongroup.removeAllItem();
         _buttongroup.selectIndex = -1;
         _buttongroup.addSelectItem(_equipBtnBtn);
         _vBox.addChild(_equipBtnBtn);
         _buttongroup.addSelectItem(_gemBtn);
         _vBox.addChild(_gemBtn);
         if(thaneInfo.grades >= 55)
         {
            _buttongroup.addSelectItem(_crystalBtn);
            _vBox.addChild(_crystalBtn);
         }
         if(thaneInfo.grades >= 70)
         {
            _buttongroup.addSelectItem(_childBtn);
            _vBox.addChild(_childBtn);
         }
         if(thaneInfo.grades >= 50)
         {
            _buttongroup.addSelectItem(_shengeBtn);
            _vBox.addChild(_shengeBtn);
         }
         _buttongroup.addSelectItem(_propertyBtn);
         _vBox.addChild(_propertyBtn);
         _buttongroup.addSelectItem(_updateEquipBtn);
         _vBox.addChild(_updateEquipBtn);
         _buttongroup.addEventListener("change",__menuSelectedHandler);
      }
      
      private function get thaneInfo() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __menuSelectedHandler(param1:Event) : void
      {
         _currentSelected = _buttongroup.getSelectedItem() as SelectedButton;
         if(!_currentSelected)
         {
            return;
         }
         ObjectUtils.removeChildAllChildrenFromStage(_vBox);
         removeListView();
         refreshMenu();
         SoundManager.instance.play("022");
         var _loc2_:int = getMenuType(_currentSelected);
         selectListViewByType(_loc2_);
         model.selectedType = _loc2_;
         if(model.selectedDic[_loc2_] != null)
         {
            _tempListView.selectedByType(_loc2_,model.selectedDic[_loc2_]);
         }
         else
         {
            _tempListView.selectedByType(_loc2_,null);
         }
         _vBox.addChildAt(_tempListView as DisplayObject,_vBox.getChildIndex(_currentSelected));
         _vBox.removeChild(_currentSelected);
         refreshMenuPos();
         control.currComposeType = getMenuType(_currentSelected);
      }
      
      private function refreshMenuPos() : void
      {
         var _loc2_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc1_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < _vBox.numChildren)
         {
            _loc3_ = _vBox.getChildAt(_loc2_);
            _loc3_.y = _loc1_;
            if(_loc3_ is ComposeListView)
            {
               _loc1_ += (_loc3_ as ComposeListView).viewHeight + 2;
            }
            else if(_loc3_ is ComposeSubListView)
            {
               _loc1_ += (_loc3_ as ComposeSubListView).viewHeight + 2;
            }
            else
            {
               _loc1_ += _loc3_.height + 2;
            }
            _loc2_++;
         }
      }
      
      private function getMenuType(param1:SelectedButton) : int
      {
         switch(param1)
         {
            case _propertyBtn:
               return 2;
            case _equipBtnBtn:
               return 1;
            case _gemBtn:
               return 3;
            default:
               return -2147483648;
         }
      }
      
      private function selectListViewByType(param1:int) : void
      {
         switch(param1 - 1)
         {
            case 0:
               _tempListView = _composeSubListView;
               break;
            default:
               _tempListView = _composeListView;
         }
      }
      
      private function removeListView() : void
      {
         if(_composeListView.parent)
         {
            _composeListView.parent.removeChild(_composeListView);
         }
         if(_composeSubListView.parent)
         {
            _composeSubListView.parent.removeChild(_composeSubListView);
         }
      }
      
      private function __goodsChangeHandler(param1:Event) : void
      {
         refeshData();
         selectListViewByType(getMenuType(_currentSelected));
         if(model.selectedDic[model.selectedType] != null)
         {
            _tempListView.update(model.selectedDic[model.selectedType]);
         }
         else
         {
            _tempListView.update(null);
         }
         _matetialView.data = model.selectedCompose;
      }
      
      private function __onCheckBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         model.isCanMake = !model.isCanMake;
         selectListViewByType(getMenuType(_currentSelected));
         if(model.selectedDic[model.selectedType] != null)
         {
            _tempListView.update(model.selectedDic[model.selectedType]);
         }
         else
         {
            _tempListView.update(null);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get updateEquipBtn() : SelectedButton
      {
         return _updateEquipBtn;
      }
   }
}

