package pet.equipstore
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.store.RefreshPropertyRepMsg;
   import com.road.yishi.proto.store.SmithFreshRspMsg;
   import events.StoreEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PetEquipManager;
   import managers.StoreSocketOutManager;
   import mvc.controler.StoreControler;
   import mvc.module.shop.ShopGoodsInfo;
   import pet.advanced.PetEquipBagView;
   import pet.equipstore.refinery.PetEquipRefinerySkillItem;
   import pet.equipstore.streng.PetEquipStrengItem;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class PetEquipRefineryView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _itemBg:Image;
      
      private var _arrow:Bitmap;
      
      private var _leftBorder:Image;
      
      private var _rightBorder:Image;
      
      private var _costImg:Bitmap;
      
      private var _costTxt:FilterFrameText;
      
      private var _pointImg:Bitmap;
      
      private var _replaceBtn:BaseButton;
      
      private var _washBtn:BaseButton;
      
      private var _leftTitleTxt:FilterFrameText;
      
      private var _rightTitleTxt:FilterFrameText;
      
      private var _equipBag:PetEquipBagView;
      
      private var _refineryItem:PetEquipStrengItem;
      
      private var _needItem:NeedMaterialItem;
      
      private var _itemDic:SimpleDictionary;
      
      private var _refreshItem0:PetEquipRefinerySkillItem;
      
      private var _refreshItem1:PetEquipRefinerySkillItem;
      
      private var _refreshItem2:PetEquipRefinerySkillItem;
      
      private var _refreshItem3:PetEquipRefinerySkillItem;
      
      private var _refreshItem4:PetEquipRefinerySkillItem;
      
      private var _itemVbox:VBox;
      
      private var _itemList:Array;
      
      private var _lockCount:int;
      
      private var _lockArr:Array;
      
      private var _buyNum:int = 0;
      
      private var _selectedId:int;
      
      private var _autoBuySelectButton:SelectedButton;
      
      private var _autoBuyBtnText:FilterFrameText;
      
      private var lockPoint:int;
      
      private var totalNeedPoint:int;
      
      private var refreshArr:Array;
      
      private var left:Number;
      
      public function PetEquipRefineryView()
      {
         super();
         initView();
         initEvent();
         initData();
         var _loc1_:Array = GoodsManager.instance.getGoodsByBagType(0);
         for each(var _loc2_:GoodsInfo in _loc1_)
         {
            PlayerManager.instance.moveBagToBag(_loc2_.bagType,_loc2_.objectId,_loc2_.pos,1,0,0,1);
         }
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:PetEquipRefinerySkillItem = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.pet.equipRefineryBg");
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("pet.refineryItemBg");
         _arrow = ComponentFactory.Instance.creatCustomObject("petEquipRefineryView.arrow");
         addChild(_bg);
         addChild(_itemBg);
         addChild(_arrow);
         _itemDic = new SimpleDictionary();
         _lockArr = [];
         _needItem = ComponentFactory.Instance.creatCustomObject("pet.refineryNeedMaterialItemView");
         _costImg = ComponentFactory.Instance.creatCustomObject("petEquipRefineryView.costImg");
         _costTxt = ComponentFactory.Instance.creatComponentByStylename("petEquipRefineryView.costTxt");
         _pointImg = ComponentFactory.Instance.creatCustomObject("petEquipRefineryView.pointImg");
         _itemVbox = ComponentFactory.Instance.creatComponentByStylename("pet.refineryItemVbox");
         _replaceBtn = ComponentFactory.Instance.creatComponentByStylename("petEquipRefineryView.replaceBtn");
         _washBtn = ComponentFactory.Instance.creatComponentByStylename("petEquipRefineryView.washBtn");
         _refineryItem = ComponentFactory.Instance.creatCustomObject("pet.petEquipRefineryItem");
         _equipBag = new PetEquipBagView(2,13,13,"pet.equipStrengScroll",false);
         _equipBag.x = 3;
         _equipBag.y = 288;
         _autoBuySelectButton = ComponentFactory.Instance.creatComponentByStylename("pet.autoBuySelectButton");
         _autoBuyBtnText = ComponentFactory.Instance.creatComponentByStylename("pet.autoBuyBtnText");
         addChild(_needItem);
         _needItem.needItemNum = 1;
         addChild(_itemVbox);
         _itemList = [];
         addChild(_costImg);
         addChild(_costTxt);
         addChild(_pointImg);
         addChild(_replaceBtn);
         addChild(_washBtn);
         var _loc2_:BitmapData = ClassUtils.CreatInstance("asset.pet.bigAttributeBg");
         _leftBorder = ComponentFactory.Instance.creatComponentByStylename("pet.refineryLeftBg");
         _rightBorder = ComponentFactory.Instance.creatComponentByStylename("pet.refineryRightBg");
         addChild(_leftBorder);
         addChild(_rightBorder);
         _leftTitleTxt = ComponentFactory.Instance.creatComponentByStylename("petEquipRefineryView.leftTitleTxt");
         _rightTitleTxt = ComponentFactory.Instance.creatComponentByStylename("petEquipRefineryView.rightTitleTxt");
         addChild(_leftTitleTxt);
         addChild(_rightTitleTxt);
         addChild(_itemVbox);
         addChild(_autoBuySelectButton);
         addChild(_autoBuyBtnText);
         _autoBuyBtnText.text = LanguageMgr.GetTranslation("store.view.refresh.RefreshView.buyTxt");
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc1_ = this["_refreshItem" + _loc3_] as PetEquipRefinerySkillItem;
            _loc1_ = new PetEquipRefinerySkillItem();
            _itemVbox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc3_++;
         }
         var _loc4_:GoodsInfo = new GoodsInfo();
         _loc4_.templateId = 3270101;
         _needItem.data = _loc4_;
         lockPoint = int(TempleteManager.instance.getConfigInfoByConfigName("Lock_Point").ConfigValue);
         _washBtn.tipData = LanguageMgr.GetTranslation("store.view.refresh.RefreshView.refreshAttributeBtn");
         _costTxt.text = "0";
         _leftTitleTxt.text = "蓝色装备品质";
         _rightTitleTxt.text = "紫色装备品质";
         addChild(_equipBag);
         addChild(_refineryItem);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_arrow);
         _arrow = null;
         ObjectUtils.disposeObject(_leftTitleTxt);
         _leftTitleTxt = null;
         ObjectUtils.disposeObject(_rightTitleTxt);
         _rightTitleTxt = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_refineryItem);
         _refineryItem = null;
         ObjectUtils.disposeObject(_needItem);
         _needItem = null;
         ObjectUtils.disposeObject(_costImg);
         _costImg = null;
         ObjectUtils.disposeObject(_costTxt);
         _costTxt = null;
         ObjectUtils.disposeObject(_pointImg);
         _pointImg = null;
         ObjectUtils.disposeObject(_replaceBtn);
         _replaceBtn = null;
         ObjectUtils.disposeObject(_washBtn);
         _washBtn = null;
         ObjectUtils.disposeObject(_equipBag);
         _equipBag = null;
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
      }
      
      private function initEvent() : void
      {
         _replaceBtn.addEventListener("click",__onReplaceBtnClickHandler);
         _washBtn.addEventListener("click",__onWashBtnClickHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         NotificationManager.instance.addEventListener("PETEQUIPSTOREDATACHANGE",__itemDataChangeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4258,__refreshSkillHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4368,__refreshProperty);
         NotificationManager.instance.addEventListener("REFRESH_LOCK_CHANGE",_itemLockHandler);
         NotificationManager.instance.addEventListener("PETEQUIPDROPSTART",__showEffect);
         NotificationManager.instance.addEventListener("PETEQUIPDROPOVER",__hideEffect);
         _autoBuySelectButton.addEventListener("click",__autoBuySelectButtonClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_replaceBtn)
         {
            _replaceBtn.removeEventListener("click",__onReplaceBtnClickHandler);
         }
         if(_washBtn)
         {
            _washBtn.removeEventListener("click",__onWashBtnClickHandler);
         }
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         NotificationManager.instance.removeEventListener("PETEQUIPSTOREDATACHANGE",__itemDataChangeHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4258,__refreshSkillHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4368,__refreshProperty);
         NotificationManager.instance.removeEventListener("REFRESH_LOCK_CHANGE",_itemLockHandler);
         NotificationManager.instance.removeEventListener("PETEQUIPDROPSTART",__showEffect);
         NotificationManager.instance.removeEventListener("PETEQUIPDROPOVER",__hideEffect);
         _autoBuySelectButton.removeEventListener("click",__autoBuySelectButtonClickHandler);
      }
      
      private function __autoBuySelectButtonClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("pet.petEquipNotEnoughTips");
         refreshBtnEnable();
         if(_autoBuySelectButton.selected)
         {
            if(showBuyAlert())
            {
               return;
            }
         }
         refreshPoint();
         refreshBtnEnable();
      }
      
      private function refreshBtnEnable() : void
      {
         _washBtn.enable = true;
         var _loc1_:int = int(GoodsManager.instance.getBagCountByTempId(1,3270101));
         if(!_autoBuySelectButton.selected && _refineryItem && _refineryItem.data)
         {
            if(_loc1_ < getNeedPro(_refineryItem.data.templateInfo.Profile))
            {
               _washBtn.enable = false;
            }
         }
         if(_autoBuySelectButton.selected)
         {
            _washBtn.enable = true;
         }
      }
      
      private function showBuyAlert() : Boolean
      {
         var _loc7_:TodayNotAlertFrame = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc3_:Date = SharedManager.instance.petEquipRefineryAutoBuyCheckDate;
         var _loc4_:Date = new Date();
         var _loc1_:Boolean = false;
         var _loc5_:Boolean = Boolean(SharedManager.instance.petEquipRefineryAutoBuy);
         if(!_loc5_ || _loc3_.month < _loc4_.month || _loc3_.date < _loc4_.date)
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            _autoBuySelectButton.selected = false;
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("store.RefreshBuyAlertFrame");
            _loc6_ = LanguageMgr.GetTranslation("pet.petEquipNotEnoughTips");
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc7_.show(_loc6_,_loc2_,startBuyAlertBack);
         }
         refreshBtnEnable();
         return _loc1_;
      }
      
      private function startBuyAlertBack(param1:Boolean) : void
      {
         SharedManager.instance.petEquipRefineryAutoBuy = param1;
         SharedManager.instance.petEquipRefineryAutoBuyCheckDate = new Date();
         SharedManager.instance.savePetEquipRefineryAutoBuyCheck();
         _autoBuySelectButton.selected = true;
         refreshPoint();
         refreshBtnEnable();
      }
      
      private function initData() : void
      {
         _itemDic.add("0_0_0",_refineryItem);
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc1_:int = 0;
         clear();
         refreshArr = [];
         if(_refineryItem.data)
         {
            initItemBox(_refineryItem.data);
            _loc1_ = int(GoodsManager.instance.getBagCountByTempId(1,3270101));
            _needItem.needItemNum = getNeedPro(_refineryItem.data.templateInfo.Profile);
            _needItem.updateTxt(_loc1_);
            _needItem.txtVisible(true);
            _leftTitleTxt.visible = true;
            _itemVbox.visible = true;
            _leftTitleTxt.setFrame(_refineryItem.data.templateInfo.Profile);
            _rightTitleTxt.setFrame(_refineryItem.data.templateInfo.Profile);
            _leftTitleTxt.text = _refineryItem.data.templateInfo.TemplateName;
            _rightTitleTxt.text = _refineryItem.data.templateInfo.TemplateName;
            updateRandomSkill(_refineryItem.data);
            _washBtn.enable = true;
            refreshPoint();
            refreshBtnEnable();
         }
         else
         {
            _needItem.txtVisible(false);
            _leftTitleTxt.visible = false;
            _rightTitleTxt.visible = false;
            _itemVbox.visible = true;
            _replaceBtn.enable = false;
            _washBtn.enable = false;
            _costTxt.text = "0";
         }
         updateRandomSkill(_refineryItem.data);
      }
      
      private function updateRandomSkill(param1:GoodsInfo) : void
      {
         var _loc4_:int = 0;
         var _loc2_:PetEquipRefinerySkillItem = null;
         var _loc3_:int = int(_itemList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _itemList[_loc4_] as PetEquipRefinerySkillItem;
            _loc2_.selected = false;
            _loc2_.randomSkill = _refineryItem.data ? param1["randomSkill" + (_loc4_ + 1)] : -1;
            _loc2_.randomNewSkill = -1;
            _loc4_++;
         }
         _replaceBtn.enable = false;
      }
      
      private function __showEffect(param1:NotificationEvent) : void
      {
         var _loc2_:GoodsInfo = param1.data as GoodsInfo;
         if(_loc2_)
         {
            if(_loc2_.templateInfo.MasterType == 5)
            {
               _refineryItem.setSelectedEff();
            }
         }
      }
      
      private function __hideEffect(param1:NotificationEvent) : void
      {
         _refineryItem.setNotSelectedEff();
      }
      
      private function __refreshSkillHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SmithFreshRspMsg = new SmithFreshRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as SmithFreshRspMsg;
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _itemList[_loc3_].randomNewSkill = _loc2_.randomSkill[_loc3_];
            _loc3_++;
         }
         _replaceBtn.enable = true;
      }
      
      private function setWashBtn(param1:int) : void
      {
      }
      
      private function __refreshProperty(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:RefreshPropertyRepMsg = new RefreshPropertyRepMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as RefreshPropertyRepMsg;
         var _loc3_:Boolean = true;
         if(_loc2_.result == 1)
         {
            _selectedId = _refineryItem.data.id;
            _loc4_ = 0;
            while(_loc4_ < _itemList.length)
            {
               _itemList[_loc4_].randomNewSkill = _loc2_.randomSkill[_loc4_];
               _itemList[_loc4_].selected = _loc2_.lockPos[_loc4_];
               if(_loc2_.randomSkill[_loc4_] > 0)
               {
                  _lockArr[_loc4_] = _loc2_.lockPos[_loc4_];
                  _loc3_ = false;
               }
               _loc4_++;
            }
            _replaceBtn.enable = true;
            _rightTitleTxt.visible = true;
         }
         else
         {
            _replaceBtn.enable = false;
            _rightTitleTxt.visible = false;
            if(_refineryItem.data.id != _selectedId)
            {
               _lockArr = [];
            }
         }
         if(_loc3_)
         {
            _loc5_ = 0;
            while(_loc5_ < _itemList.length)
            {
               _itemList[_loc5_].selected = _lockArr[_loc5_];
               _loc5_++;
            }
         }
         _itemLockHandler(null);
      }
      
      private function clear() : void
      {
         var _loc1_:DisplayObject = null;
         while(_itemVbox.numChildren)
         {
            _loc1_ = _itemVbox.getChildAt(_itemVbox.numChildren - 1);
            _itemVbox.removeChild(_loc1_);
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = [];
      }
      
      private function initItemBox(param1:GoodsInfo) : void
      {
         var _loc4_:int = 0;
         var _loc2_:PetEquipRefinerySkillItem = null;
         var _loc3_:int = 0;
         if(param1.templateInfo.Profile == 3)
         {
            _loc3_ = 3;
         }
         else if(param1.templateInfo.Profile == 4)
         {
            _loc3_ = 4;
         }
         else if(param1.templateInfo.Profile == 5 || param1.templateInfo.Profile == 6)
         {
            _loc3_ = 5;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this["_refreshItem" + _loc4_] as PetEquipRefinerySkillItem;
            _loc2_ = new PetEquipRefinerySkillItem();
            _itemVbox.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc4_++;
         }
      }
      
      private function _itemLockHandler(param1:StoreEvent) : void
      {
         var _loc2_:int = 0;
         _lockCount = 0;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            if(_itemList[_loc2_].selected)
            {
               _lockCount = _lockCount + 1;
            }
            _loc2_++;
         }
         refreshPoint();
      }
      
      private function refreshPoint() : void
      {
         var _loc4_:int = 0;
         var _loc1_:ShopGoodsInfo = null;
         var _loc2_:int = int(GoodsManager.instance.getBagCountByTempId(1,3270101));
         var _loc3_:int = 0;
         if(_autoBuySelectButton.selected && _refineryItem && _refineryItem.data)
         {
            if(_loc2_ < getNeedPro(_refineryItem.data.templateInfo.Profile))
            {
               _loc4_ = getNeedPro(_refineryItem.data.templateInfo.Profile) - _loc2_;
               _loc1_ = TempleteManager.instance.getShopTempInfoByItemId(_needItem.data.templateId);
               _loc3_ = _loc1_.GiftToken * _loc4_;
            }
         }
         _costTxt.text = _lockCount * lockPoint + _loc3_ + "";
         _pointImg.x = _costTxt.x + _costTxt.textWidth + 5;
      }
      
      private function __onReplaceBtnClickHandler(param1:MouseEvent) : void
      {
         StoreSocketOutManager.sendRefreshforReplace();
      }
      
      private function __onWashBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc10_:String = null;
         var _loc12_:String = null;
         if(!_refineryItem || !_refineryItem.data)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetEquipRefineryView.onWashBtnClickNoEquip"));
            return;
         }
         var _loc11_:Number = new Date().time;
         var _loc2_:String = "";
         if(_loc11_ - left < 500)
         {
            _loc2_ = LanguageMgr.GetTranslation("activity.view.ActivityItem.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         left = _loc11_;
         var _loc5_:Array = [];
         var _loc7_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            if(_loc6_ < _itemList.length)
            {
               _loc5_.push(_itemList[_loc6_].selected);
               if(_itemList[_loc6_].selected)
               {
                  _loc7_++;
               }
            }
            else
            {
               _loc5_.push(false);
            }
            _loc6_++;
         }
         refreshArr = _loc5_;
         var _loc8_:Boolean = true;
         _loc9_ = 0;
         while(_loc9_ < _itemList.length)
         {
            if(!PetEquipRefinerySkillItem(_itemList[_loc9_]).selected)
            {
               _loc8_ = false;
               break;
            }
            _loc9_++;
         }
         if(_loc8_)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.equipstore.PetEquipRefineryView.isAllLocked");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(getFlag())
         {
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc10_ = LanguageMgr.GetTranslation("public.prompt");
            _loc12_ = LanguageMgr.GetTranslation("Store.refreshView.refreshConfirm");
            SimpleAlertHelper.instance.data = [_refreshConfirm,_loc5_];
            SimpleAlertHelper.instance.popAlerFrame(_loc10_,_loc12_,_loc3_,_loc4_,true,true,false);
         }
         else
         {
            refreshCheckNumAndPoint(_loc5_);
         }
      }
      
      private function refreshCheckNumAndPoint(param1:Array) : void
      {
         var _loc2_:ShopGoodsInfo = null;
         var _loc5_:String = null;
         var _loc3_:String = null;
         totalNeedPoint = _lockCount * lockPoint;
         var _loc4_:int = int(GoodsManager.instance.getBagCountByTempId(1,3270101));
         if(_loc4_ < getNeedPro(_refineryItem.data.templateInfo.Profile))
         {
            _buyNum = getNeedPro(_refineryItem.data.templateInfo.Profile) - _loc4_;
            _loc2_ = TempleteManager.instance.getShopTempInfoByItemId(_needItem.data.templateId);
            totalNeedPoint = _lockCount * lockPoint + _loc2_.GiftToken * _buyNum;
         }
         if(totalNeedPoint > 0)
         {
            _loc5_ = LanguageMgr.GetTranslation("pet.petEquipNotEnoughTips2",totalNeedPoint);
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            SharedManagerHelper.ins.needAlert("pet.petEquip.refreshPoint.alert",askToSendRefresh,_loc3_,_loc5_,"");
         }
         else
         {
            StoreSocketOutManager.sendPetRefreshToServer(refreshArr,0);
         }
      }
      
      private function askToSendRefresh(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         else
         {
            _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         }
         if(totalNeedPoint > _loc2_)
         {
            RechargeAlertMannager.show();
            return;
         }
         StoreSocketOutManager.sendPetRefreshToServer(refreshArr,0,param1);
      }
      
      private function _refreshConfirm(param1:Boolean, param2:Boolean, param3:Array) : void
      {
         if(param1)
         {
            refreshCheckNumAndPoint(param3);
         }
      }
      
      private function getFlag() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_itemList)
         {
            _loc2_ = int(_itemList.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = check(_itemList[_loc3_] as PetEquipRefinerySkillItem);
               if(_loc1_)
               {
                  break;
               }
               _loc3_++;
            }
         }
         return _loc1_;
      }
      
      private function check(param1:PetEquipRefinerySkillItem) : Boolean
      {
         var _loc2_:String = param1.refineryAttributeNewTxt.text;
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
      
      private function openBuyFrame(param1:int) : void
      {
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback,[param1]);
      }
      
      private function quickUIcallback(param1:Array) : void
      {
         var _loc3_:int = int(param1[0]);
         var _loc2_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         var _loc4_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(_loc3_);
         _loc2_.data(_loc4_,_buyNum);
         _loc2_.show();
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:PetEquipStrengItem = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_ && PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipRefineryView")
         {
            _loc2_.data = _loc3_;
            StoreSocketOutManager.sendRefreshProperty(_loc2_.data.id);
            updateView();
         }
         else if(_loc3_.templateInfo.SonType == 327)
         {
            refreshPro();
         }
      }
      
      private function get playerinfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:PetEquipStrengItem = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_ && PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipRefineryView")
         {
            _loc2_.data = null;
            updateView();
         }
      }
      
      private function refreshPro() : void
      {
         var _loc1_:int = 0;
         if(_refineryItem.data)
         {
            _loc1_ = int(GoodsManager.instance.getBagCountByTempId(1,3270101));
            _needItem.needItemNum = getNeedPro(_refineryItem.data.templateInfo.Profile);
            _needItem.updateTxt(_loc1_);
         }
      }
      
      private function __itemDataChangeHandler(param1:NotificationEvent) : void
      {
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      private function getNeedPro(param1:int) : int
      {
         switch(param1 - 2)
         {
            case 0:
               return 1;
            case 1:
               return 4;
            case 2:
            case 3:
               return 18;
            case 4:
               return 24;
            default:
               return 100;
         }
      }
      
      override public function dispose() : void
      {
         PetEquipManager.isFirstClick = true;
         removeEvent();
         uintView();
         super.dispose();
         if(_itemDic)
         {
            _itemDic.clear();
         }
         _itemDic = null;
      }
   }
}

