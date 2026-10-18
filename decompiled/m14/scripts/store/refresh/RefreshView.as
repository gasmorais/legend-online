package store.refresh
{
   import bag.events.BagEvent;
   import cell.view.storebag.StoreRefreshCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.store.RefreshPropertyRepMsg;
   import com.road.yishi.proto.store.SmithFreshRspMsg;
   import events.StoreEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.StoreSocketOutManager;
   import mvc.controler.StoreControler;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.comm.PackageIn;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class RefreshView extends Component
   {
      
      private static var _len:int = 5;
      
      private var _bg:MutipleImage;
      
      private var _equip:StoreRefreshCell;
      
      private var _mate:RefreshNeededMaterialItem;
      
      private var _refreshAttribute:Bitmap;
      
      private var _refreshAttributeBtn:IconButton;
      
      private var _refreshReplaceBtn:IconButton;
      
      private var _pointBuy:SelectedButton;
      
      private var _pointBuyFirst:Boolean;
      
      private var _refreshConsumeTxt:Bitmap;
      
      private var _refreshPointTxt:FilterFrameText;
      
      private var _valueIcon:ScaleFrameImage;
      
      private var _refreshIcon:Bitmap;
      
      private var _refreshbuyTxt:FilterFrameText;
      
      private var _itemDic:SimpleDictionary;
      
      private var _bindingTxt:FilterFrameText;
      
      private var _bindingBut:SelectedButton;
      
      private var _refreshAttriList:Array;
      
      private var _price:int;
      
      private var _lockCount:int;
      
      private var _storeFrameEquipBg:MovieClip;
      
      private var _refreshLockTxt:FilterFrameText;
      
      private var _refreshLockCount:int;
      
      private var _refreshLockCountTxt:FilterFrameText;
      
      private var _refreshLockBack:Bitmap;
      
      private const REFRESHLOCK_TEMPID:int = 208027;
      
      private var lockPoint:int;
      
      private var _bindsMaterialCount:int;
      
      private var _nobindsMaterialCount:int;
      
      private var _needMaterialCount:int;
      
      private var _ownMaterialCount:int;
      
      private var bindingType:int;
      
      private var _allNeedPoint:int;
      
      private var refreshArr:Array;
      
      private var refreshShopInfo:ShopGoodsInfo;
      
      public function RefreshView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RefreshAttriItem = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("store.RefreshViewBg");
         _equip = ComponentFactory.Instance.creatCustomObject("store.RefreshEquiItem");
         _mate = ComponentFactory.Instance.creatCustomObject("refresh.RefreshNeededMaterialItem");
         _refreshAttribute = ComponentFactory.Instance.creatBitmap("asset.store.RefreshAttributeBg");
         _refreshAttributeBtn = ComponentFactory.Instance.creatComponentByStylename("store.RefreshAttribute");
         _refreshReplaceBtn = ComponentFactory.Instance.creatComponentByStylename("store.RefreshReplace");
         _pointBuy = ComponentFactory.Instance.creatComponentByStylename("store.RefreshShopSelectButton");
         _refreshConsumeTxt = ComponentFactory.Instance.creatBitmap("asset.store.refreshConsumeTxt");
         _refreshPointTxt = ComponentFactory.Instance.creatComponentByStylename("store.RefreshPointTxt");
         _valueIcon = ComponentFactory.Instance.creatComponentByStylename("core.PayType");
         _refreshIcon = ComponentFactory.Instance.creatBitmap("asset.mainToolBar.IntensifyIcon");
         _refreshbuyTxt = ComponentFactory.Instance.creatComponentByStylename("store.refreshbuyTxt");
         _bindingTxt = ComponentFactory.Instance.creatComponentByStylename("store.bindingTxt");
         _bindingBut = ComponentFactory.Instance.creatComponentByStylename("store.BindingShopSelectButton");
         _storeFrameEquipBg = ComponentFactory.Instance.creatCustomObject("store.StoreFrameEquipBg");
         _refreshLockTxt = ComponentFactory.Instance.creatComponentByStylename("store.refreshLockTxt");
         _refreshLockCountTxt = ComponentFactory.Instance.creatComponentByStylename("store.refreshLockCountTxt");
         _refreshLockBack = ComponentFactory.Instance.creatBitmap("asset.store.RefreshLockBack");
         addChild(_bg);
         addChild(_refreshAttribute);
         addChild(_equip);
         _equip.sonType = -1;
         addChild(_mate);
         addChild(_refreshAttributeBtn);
         _refreshAttributeBtn.enable = false;
         addChild(_refreshReplaceBtn);
         _refreshReplaceBtn.enable = false;
         addChild(_pointBuy);
         addChild(_bindingBut);
         _bindingBut.selected = true;
         addChild(_refreshConsumeTxt);
         addChild(_refreshPointTxt);
         _refreshPointTxt.text = "0";
         addChild(_valueIcon);
         _valueIcon.x = 262;
         _valueIcon.y = 270;
         _valueIcon.setFrame(1);
         _valueIcon.setFrame(1);
         addChild(_refreshIcon);
         _refreshIcon.x = 186;
         _refreshIcon.y = 127;
         addChild(_refreshbuyTxt);
         _refreshbuyTxt.text = LanguageMgr.GetTranslation("store.view.refresh.RefreshView.buyTxt");
         addChild(_bindingTxt);
         _bindingTxt.text = LanguageMgr.GetTranslation("store.view.refresh.RefreshView.bindingTxt");
         _refreshAttributeBtn.tipData = LanguageMgr.GetTranslation("store.view.refresh.RefreshView.refreshAttributeBtn");
         if(VersionSwitch.REFRESH_LOCK)
         {
            addChild(_refreshLockBack);
            _refreshLockCount = GoodsManager.instance.goodsCountByTempId[208027];
            addChild(_refreshLockTxt);
            _refreshLockTxt.text = LanguageMgr.GetTranslation("store.view.refresh.RefreshLock.text");
            addChild(_refreshLockCountTxt);
            _refreshLockCountTxt.text = _refreshLockCount.toString();
            _refreshLockCountTxt.setFrame(1);
         }
         _refreshAttriList = [];
         _loc2_ = 0;
         while(_loc2_ < _len)
         {
            _loc1_ = new RefreshAttriItem();
            addChild(_loc1_);
            _loc1_.x = 35;
            _loc1_.y = 132 + _loc2_ * 27;
            _refreshAttriList.push(_loc1_);
            _loc2_++;
         }
         _itemDic = new SimpleDictionary(true);
         _itemDic.add("0_0_0",_equip);
         addChild(_storeFrameEquipBg);
         _storeFrameEquipBg.mouseEnabled = false;
         _storeFrameEquipBg.mouseChildren = true;
         _storeFrameEquipBg.x = 97;
         _storeFrameEquipBg.y = 18;
         lockPoint = int(TempleteManager.instance.getConfigInfoByConfigName("Lock_Point").ConfigValue);
      }
      
      private function initEvent() : void
      {
         _refreshAttributeBtn.addEventListener("click",__refreshAttributeHandle);
         _refreshReplaceBtn.addEventListener("click",__refreshReplaceHandle);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4258,__refreshSkillHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4368,__refreshProperty);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 115,__bagUpdateHandler);
         _pointBuy.addEventListener("click",__pointSelectedHandler);
         _bindingBut.addEventListener("click",__bindingSelectedHandler);
         if(control && control.model)
         {
            control.model.addEventListener("REFRESH_LOCK_CHANGE",_itemLockHandler);
         }
      }
      
      private function __bagUpdateHandler(param1:SLGSocketEvent) : void
      {
         _refreshLockCount = GoodsManager.instance.goodsCountByTempId[208027];
         _refreshLockCountTxt.text = _refreshLockCount.toString();
         refreshLockTxtChange();
      }
      
      public function removeEvent() : void
      {
         _refreshAttributeBtn.removeEventListener("click",__refreshAttributeHandle);
         _refreshReplaceBtn.removeEventListener("click",__refreshReplaceHandle);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4258,__refreshSkillHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4368,__refreshProperty);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 115,__bagUpdateHandler);
         _pointBuy.removeEventListener("click",__pointSelectedHandler);
         _bindingBut.removeEventListener("click",__bindingSelectedHandler);
         if(control && control.model)
         {
            control.model.removeEventListener("REFRESH_LOCK_CHANGE",_itemLockHandler);
         }
      }
      
      private function __pointSelectedHandler(param1:MouseEvent) : void
      {
         if(!_equip.data)
         {
            _pointBuy.selected = false;
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("refresh.refreshMaterial.noEquipAlert"));
            return;
         }
         if(!refreshShopInfo)
         {
            _pointBuy.selected = false;
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("refresh.refreshMaterial.shopNoBuy"));
            return;
         }
         if(_pointBuy.selected)
         {
            if(showBuyAlert())
            {
               return;
            }
         }
         _refreshAttributeBtn.enable = checkIsShowBtn();
         refreshPoint();
      }
      
      private function showBuyAlert() : Boolean
      {
         var _loc7_:TodayNotAlertFrame = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc3_:Date = SharedManager.instance.storeRefreshBuyCheckDate;
         var _loc4_:Date = new Date();
         var _loc1_:Boolean = false;
         var _loc5_:Boolean = Boolean(SharedManager.instance.storeRefreshBuy);
         if(!_loc5_ || _loc3_.month < _loc4_.month || _loc3_.date < _loc4_.date)
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            _pointBuy.selected = false;
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("store.RefreshBuyAlertFrame");
            _loc6_ = LanguageMgr.GetTranslation("store.view.refresh.RefreshView.content");
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc7_.show(_loc6_,_loc2_,startBuyAlertBack);
         }
         return _loc1_;
      }
      
      private function startBuyAlertBack(param1:Boolean) : void
      {
         SharedManager.instance.storeRefreshBuy = param1;
         SharedManager.instance.storeRefreshBuyCheckDate = new Date();
         SharedManager.instance.saveStoreRefreshBuyCheck();
         _confirmPointBuy();
      }
      
      private function _confirmPointBuy() : void
      {
         _pointBuy.selected = true;
         _refreshAttributeBtn.enable = checkIsShowBtn();
         refreshPoint();
      }
      
      private function __bindingSelectedHandler(param1:MouseEvent) : void
      {
         updateMateMaterial();
      }
      
      private function _itemLockHandler(param1:StoreEvent) : void
      {
         var _loc2_:int = 0;
         _lockCount = 0;
         _loc2_ = 0;
         while(_loc2_ < _len)
         {
            if(_refreshAttriList[_loc2_].selected)
            {
               _lockCount = _lockCount + 1;
            }
            _loc2_++;
         }
         refreshLockTxtChange();
         refreshPoint();
      }
      
      private function refreshLockTxtChange() : void
      {
         if(_lockCount <= _refreshLockCount)
         {
            _refreshLockCountTxt.setFrame(1);
         }
         else
         {
            _refreshLockCountTxt.setFrame(2);
         }
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = _loc3_;
            updateRandomSkillView();
            StoreSocketOutManager.sendRefreshProperty(_loc2_.data.id);
         }
         updateMaterialPoite();
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = null;
            updateRandomSkillView();
         }
         updateMaterialPoite();
      }
      
      private function updateRandomSkillView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _len)
         {
            _refreshAttriList[_loc1_].randomSkill = _equip.data ? _equip.data["randomSkill" + (_loc1_ + 1)] : -1;
            _refreshAttriList[_loc1_].randomNewSkill = -1;
            _loc1_++;
         }
         _refreshAttributeBtn.enable = false;
         _refreshReplaceBtn.enable = false;
         updateMaterialPoite();
      }
      
      private function __refreshSkillHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SmithFreshRspMsg = new SmithFreshRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as SmithFreshRspMsg;
         _loc3_ = 0;
         while(_loc3_ < _len)
         {
            _refreshAttriList[_loc3_].randomNewSkill = _loc2_.randomSkill[_loc3_];
            _loc3_++;
         }
         _refreshReplaceBtn.enable = true;
         updateMaterialPoite();
      }
      
      private function __refreshProperty(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:RefreshPropertyRepMsg = new RefreshPropertyRepMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as RefreshPropertyRepMsg;
         if(_loc2_.result == 1)
         {
            _loc3_ = 0;
            while(_loc3_ < _len)
            {
               _refreshAttriList[_loc3_].randomNewSkill = _loc2_.randomSkill[_loc3_];
               _refreshAttriList[_loc3_].selected = _loc2_.lockPos[_loc3_];
               _loc3_++;
            }
            _refreshReplaceBtn.enable = true;
         }
         else
         {
            _refreshReplaceBtn.enable = false;
         }
         _refreshAttributeBtn.enable = checkIsShowBtn();
         _itemLockHandler(null);
      }
      
      private function updateMateMaterial() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:Array = null;
         _bindsMaterialCount = 0;
         _nobindsMaterialCount = 0;
         _pointBuy.visible = true;
         _refreshbuyTxt.visible = true;
         refreshArr = [];
         var _loc4_:GoodsInfo = _equip.data;
         if(_loc4_)
         {
            _refreshAttributeBtn.enable = true;
            _loc3_ = int(TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_.templateId).Refresh);
            _loc1_ = int(TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_.templateId).Profile);
            refreshShopInfo = TempleteManager.instance.getShopTempInfoByItemId(_loc3_);
            _loc5_ = GoodsManager.instance.getBagGoodsByTemplateId(_loc4_.templateInfo.Refresh);
            for each(var _loc2_:GoodsInfo in _loc5_)
            {
               if(_loc2_.isBinds)
               {
                  _bindsMaterialCount += _loc2_.count;
               }
               else
               {
                  _nobindsMaterialCount += _loc2_.count;
               }
            }
            switch(_loc1_ - 1)
            {
               case 0:
               case 1:
                  _needMaterialCount = 1;
                  break;
               case 2:
                  _needMaterialCount = 4;
                  break;
               case 3:
               case 4:
                  _needMaterialCount = 18;
                  break;
               case 5:
                  _needMaterialCount = 24;
                  break;
               case 6:
                  _needMaterialCount = 48;
            }
            _ownMaterialCount = _bindingBut.selected ? _bindsMaterialCount + _nobindsMaterialCount : _nobindsMaterialCount;
            if(refreshShopInfo)
            {
               if(_ownMaterialCount < _needMaterialCount)
               {
                  _price = refreshShopInfo.GiftToken * (_needMaterialCount - _ownMaterialCount);
               }
               else
               {
                  _price = 0;
               }
            }
            else
            {
               _pointBuy.selected = false;
            }
            _refreshAttributeBtn.enable = checkIsShowBtn();
         }
         else
         {
            _loc3_ = -1;
            _price = 0;
            _needMaterialCount = 0;
            _ownMaterialCount = 0;
            _refreshAttributeBtn.enable = false;
            refreshShopInfo = null;
         }
         refreshPoint();
         _mate.material(_loc3_,_needMaterialCount,_ownMaterialCount);
      }
      
      private function updateMaterialPoite() : void
      {
         updateMateMaterial();
         refreshPoint();
      }
      
      private function __refreshAttributeHandle(param1:MouseEvent) : void
      {
         var _loc2_:String = "";
         if(_equip.data.isLock)
         {
            _loc2_ = LanguageMgr.GetTranslation("store.refresh.RefreshView.equipIsLock");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         refreshConfirm(true,false);
      }
      
      private function refreshConfirm(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         var _loc7_:Array = null;
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:int = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         if(param1)
         {
            bindingType = _bindingBut.selected ? 0 : 2;
            if(_lockCount >= lockOverflow)
            {
               _loc3_ = LanguageMgr.GetTranslation("store.view.refresh.RefreshView.command01");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            _loc7_ = [];
            _loc9_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _len)
            {
               _loc7_.push(_refreshAttriList[_loc8_].selected);
               if(_refreshAttriList[_loc8_].selected)
               {
                  _loc9_++;
               }
               _loc8_++;
            }
            refreshArr = _loc7_;
            if(_refreshAttriList)
            {
               _loc6_ = int(_refreshAttriList.length);
               _loc10_ = 0;
               while(_loc10_ < _loc6_)
               {
                  param2 = check(_refreshAttriList[_loc10_] as RefreshAttriItem);
                  if(param2)
                  {
                     break;
                  }
                  _loc10_++;
               }
            }
            if(param2)
            {
               _loc4_ = LanguageMgr.GetTranslation("public.confirm");
               _loc5_ = LanguageMgr.GetTranslation("public.cancel");
               _loc11_ = LanguageMgr.GetTranslation("public.prompt");
               _loc12_ = LanguageMgr.GetTranslation("Store.refreshView.refreshConfirm");
               SimpleAlertHelper.instance.data = [_refreshConfirm];
               SimpleAlertHelper.instance.popAlerFrame(_loc11_,_loc12_,_loc4_,_loc5_,true,true,false);
            }
            else
            {
               refreshCheckNumAndPoint();
            }
         }
      }
      
      private function refreshCheckNumAndPoint() : void
      {
         var _loc2_:String = null;
         var _loc1_:String = null;
         if(_allNeedPoint > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.petEquipNotEnoughTips2",_allNeedPoint);
            _loc1_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            SharedManagerHelper.ins.needAlert("store.refreshView.refershAlert",askToSendRefresh,_loc1_,_loc2_,"");
         }
         else
         {
            StoreSocketOutManager.sendRefreshforRandom(refreshArr,bindingType,true);
         }
      }
      
      private function askToSendRefresh(param1:Boolean) : void
      {
         var _loc2_:int = int(param1 ? playerInfo.allPoint : int(playerInfo.point));
         if(_allNeedPoint > _loc2_)
         {
            RechargeAlertMannager.show();
            return;
         }
         StoreSocketOutManager.sendRefreshforRandom(refreshArr,bindingType,param1);
      }
      
      private function check(param1:RefreshAttriItem) : Boolean
      {
         var _loc2_:String = param1.refreshAttributeNewTxt.text;
         var _loc4_:String = LanguageMgr.GetTranslation("store.refresh.start.tip1");
         var _loc3_:String = LanguageMgr.GetTranslation("store.refresh.start.tip2");
         if(StringHelper.isNullOrEmpty(_loc2_))
         {
            return false;
         }
         if(_loc2_.indexOf(_loc4_) != -1 && !param1.selected || _loc2_.indexOf(_loc3_) != -1 && !param1.selected)
         {
            return true;
         }
         return false;
      }
      
      private function _refreshConfirm(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            refreshCheckNumAndPoint();
         }
      }
      
      private function checkEquipCanBuyRefreshProp(param1:GoodsInfo) : Boolean
      {
         return true;
      }
      
      private function get lockOverflow() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_equip && _equip.data && _equip.data.isViceEquip)
         {
            _loc1_ = int(_equip.data.templateInfo.Profile);
            if(_loc1_ > 5)
            {
               _loc1_ = 5;
            }
         }
         else
         {
            _loc2_ = 1;
            while(_loc2_ < 6)
            {
               if(_equip.data["randomSkill" + _loc2_] > 0)
               {
                  _loc1_++;
               }
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      private function __refreshReplaceHandle(param1:MouseEvent) : void
      {
         StoreSocketOutManager.sendRefreshforReplace();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      private function refreshPoint() : void
      {
         var _loc1_:int = 0;
         if(VersionSwitch.REFRESH_LOCK)
         {
            _loc1_ = _lockCount <= _refreshLockCount ? 0 : _lockCount - _refreshLockCount;
            if(_pointBuy.selected)
            {
               _allNeedPoint = _price + _loc1_ * lockPoint;
            }
            else
            {
               _allNeedPoint = _loc1_ * lockPoint;
            }
         }
         else if(_pointBuy.selected)
         {
            _allNeedPoint = _price + _lockCount * lockPoint;
         }
         else
         {
            _allNeedPoint = _lockCount * lockPoint;
         }
         _refreshPointTxt.text = _allNeedPoint + "";
         _valueIcon.x = _refreshPointTxt.x + _refreshPointTxt.textWidth + 5;
      }
      
      private function checkIsShowBtn() : Boolean
      {
         if(!_equip.data)
         {
            return false;
         }
         if(!refreshShopInfo && _ownMaterialCount < _needMaterialCount)
         {
            return false;
         }
         if(!_pointBuy.selected && _ownMaterialCount < _needMaterialCount)
         {
            return false;
         }
         return true;
      }
      
      override public function dispose() : void
      {
         _pointBuyFirst = false;
         control.clcikLockFirst = false;
         _itemDic = null;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

