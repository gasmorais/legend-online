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
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.store.StoreRspMsg;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PetEquipManager;
   import managers.StoreSocketOutManager;
   import mvc.module.shop.ShopGoodsInfo;
   import pet.advanced.PetEquipBagView;
   import pet.equipstore.streng.PetEquipStrengItem;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.resource.ResourceData;
   import yishi.datas.templates.ComposeGoodsTemplete;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.ResourceManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class PetEquipUpgradeView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _itemBg:Image;
      
      private var _arrow:Bitmap;
      
      private var _item2:BaseItemView;
      
      private var _needItem:NeedMaterialItem;
      
      private var _leftBg:Image;
      
      private var _rightBg:Image;
      
      private var _leftTitleTxt:FilterFrameText;
      
      private var _rightTitleTxt:FilterFrameText;
      
      private var _leftContentTxt:FilterFrameText;
      
      private var _rightContentTxt:FilterFrameText;
      
      private var _needGoldImg:Bitmap;
      
      private var _needGoldTxt:FilterFrameText;
      
      private var _upgradeBtn:BaseButton;
      
      private var _equipBag:PetEquipBagView;
      
      private var _upgradeItem:PetEquipStrengItem;
      
      private var _itemDic:SimpleDictionary;
      
      private var _power:FilterFrameText;
      
      private var _agility:FilterFrameText;
      
      private var _ability:FilterFrameText;
      
      private var _physique:FilterFrameText;
      
      private var _captain:FilterFrameText;
      
      private var _attack:FilterFrameText;
      
      private var _magicAttack:FilterFrameText;
      
      private var _defence:FilterFrameText;
      
      private var _magicDefence:FilterFrameText;
      
      private var _parry:FilterFrameText;
      
      private var _live:FilterFrameText;
      
      private var _forceHit:FilterFrameText;
      
      private var _conat:FilterFrameText;
      
      private var _power2:FilterFrameText;
      
      private var _agility2:FilterFrameText;
      
      private var _ability2:FilterFrameText;
      
      private var _physique2:FilterFrameText;
      
      private var _captain2:FilterFrameText;
      
      private var _attack2:FilterFrameText;
      
      private var _magicAttack2:FilterFrameText;
      
      private var _defence2:FilterFrameText;
      
      private var _magicDefence2:FilterFrameText;
      
      private var _parry2:FilterFrameText;
      
      private var _live2:FilterFrameText;
      
      private var _forceHit2:FilterFrameText;
      
      private var _conat2:FilterFrameText;
      
      private var _addGem:FilterFrameText;
      
      private var _addRefinery:FilterFrameText;
      
      private var _addStreng:FilterFrameText;
      
      private var _vbox1:VBox;
      
      private var _vbox2:VBox;
      
      private var _promptID:int = 0;
      
      private var _autoBuySelectButton:SelectedButton;
      
      private var _autoBuyBtnText:FilterFrameText;
      
      public function PetEquipUpgradeView()
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
         _bg = ComponentFactory.Instance.creatBitmap("asset.pet.equipUpgradeBg");
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeItemBg");
         _arrow = ComponentFactory.Instance.creatCustomObject("petEquipRefineryView.arrow");
         addChild(_bg);
         addChild(_itemBg);
         addChild(_arrow);
         _itemDic = new SimpleDictionary();
         _item2 = ComponentFactory.Instance.creatCustomObject("petEquipUpgradeView.item2");
         _needItem = ComponentFactory.Instance.creatCustomObject("pet.upgradeNeedMaterialItemView");
         addChild(_item2);
         addChild(_needItem);
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("pet.refineryLeftBg");
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("pet.refineryRightBg");
         addChild(_leftBg);
         addChild(_rightBg);
         _leftTitleTxt = ComponentFactory.Instance.creatComponentByStylename("petEquipRefineryView.leftTitleTxt");
         _rightTitleTxt = ComponentFactory.Instance.creatComponentByStylename("petEquipRefineryView.rightTitleTxt");
         addChild(_leftTitleTxt);
         addChild(_rightTitleTxt);
         _leftContentTxt = ComponentFactory.Instance.creatComponentByStylename("petEquipRefineryView.leftContentTxt");
         _rightContentTxt = ComponentFactory.Instance.creatComponentByStylename("petEquipRefineryView.rightContentTxt");
         _needGoldImg = ComponentFactory.Instance.creatCustomObject("petEquipUpgradeView.needGoldImg");
         _needGoldTxt = ComponentFactory.Instance.creatComponentByStylename("petEquipRefineryView.needGoldTxt");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("petEquipRefineryView.upgradeBtn");
         _autoBuySelectButton = ComponentFactory.Instance.creatComponentByStylename("pet.autoBuySelectButton");
         _autoBuyBtnText = ComponentFactory.Instance.creatComponentByStylename("pet.autoBuyBtnText");
         _equipBag = new PetEquipBagView(2,13,13,"pet.equipStrengScroll",false);
         _equipBag.x = 3;
         _equipBag.y = 288;
         _power = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeleftTxt");
         _agility = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeleftTxt");
         _ability = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeleftTxt");
         _physique = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeleftTxt");
         _captain = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeleftTxt");
         _attack = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeleftTxt");
         _magicAttack = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeleftTxt");
         _defence = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeleftTxt");
         _magicDefence = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeleftTxt");
         _parry = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeleftTxt");
         _live = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeleftTxt");
         _forceHit = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeleftTxt");
         _conat = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeleftTxt");
         _power2 = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightTxt");
         _agility2 = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightTxt");
         _ability2 = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightTxt");
         _physique2 = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightTxt");
         _captain2 = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightTxt");
         _attack2 = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightTxt");
         _magicAttack2 = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightTxt");
         _defence2 = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightTxt");
         _magicDefence2 = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightTxt");
         _parry2 = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightTxt");
         _live2 = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightTxt");
         _forceHit2 = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightTxt");
         _conat2 = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightTxt");
         _addGem = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightTxt");
         _addRefinery = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightTxt");
         _addStreng = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightTxt");
         _vbox1 = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeLeftVbox");
         _vbox2 = ComponentFactory.Instance.creatComponentByStylename("pet.upgradeAttributeRightVbox");
         _upgradeItem = ComponentFactory.Instance.creatCustomObject("pet.petEquipUpgradeItem");
         addChild(_needGoldImg);
         addChild(_needGoldTxt);
         addChild(_upgradeBtn);
         addChild(_equipBag);
         addChild(_upgradeItem);
         addChild(_vbox1);
         addChild(_vbox2);
         addChild(_autoBuySelectButton);
         addChild(_autoBuyBtnText);
         _autoBuyBtnText.text = LanguageMgr.GetTranslation("store.view.refresh.RefreshView.buyTxt");
         var _loc1_:GoodsInfo = new GoodsInfo();
         _loc1_.templateId = 208008;
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = 3240101;
         _item2.data = _loc1_;
         _needItem.data = _loc2_;
         _leftTitleTxt.text = "蓝色装备品质";
         _rightTitleTxt.text = "紫色装备品质";
         _needGoldTxt.text = "99999";
         _leftContentTxt.htmlText = "物防 2000\n魔防 2030";
         _rightContentTxt.htmlText = "物防 3000\n魔防 3030\n宝石槽增{invalid_utf8=229}{invalid_utf8=138}?\n炼化属{invalid_utf8=230}?{invalid_utf8=167}条目增{invalid_utf8=229}{invalid_utf8=138}?";
         _leftContentTxt.x = 146 - _leftContentTxt.textWidth >> 1;
         _leftContentTxt.y = 35 + (90 - _leftContentTxt.textHeight >> 1);
         _rightContentTxt.x = 146 - _rightContentTxt.textWidth >> 1;
         _rightContentTxt.y = 35 + (90 - _rightContentTxt.textHeight >> 1);
         _needItem.visible = false;
      }
      
      private function initEvent() : void
      {
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         NotificationManager.instance.addEventListener("PETEQUIPSTOREDATACHANGE",__itemDataChangeHandler);
         _upgradeBtn.addEventListener("click",__upgradeBtnClickHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 89,__onComposeCallback);
         NotificationManager.instance.addEventListener("PETEQUIPDROPSTART",__showEffect);
         NotificationManager.instance.addEventListener("PETEQUIPDROPOVER",__hideEffect);
         _autoBuySelectButton.addEventListener("click",__autoBuySelectButtonClickHandler);
      }
      
      private function removeEvent() : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         NotificationManager.instance.removeEventListener("PETEQUIPSTOREDATACHANGE",__itemDataChangeHandler);
         _upgradeBtn.removeEventListener("click",__upgradeBtnClickHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 89,__onComposeCallback);
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
         refreshBtnEnable();
      }
      
      private function refreshBtnEnable() : void
      {
         var _loc1_:ComposeGoodsTemplete = null;
         var _loc2_:int = 0;
         if(_upgradeItem.data)
         {
            _loc1_ = TempleteManager.instance.getEquipUpdateComposeTempleteByMainMaterialId(_upgradeItem.data.templateInfo.TemplateId);
            _loc2_ = int(GoodsManager.instance.getBagCountByTempId(1,_loc1_.Material2));
            if(_loc1_)
            {
               setUpgradeBtn(_loc1_.Count2,_loc2_);
               if(_autoBuySelectButton.selected)
               {
                  _upgradeBtn.enable = true;
               }
               return;
            }
         }
         _upgradeBtn.enable = false;
      }
      
      private function showBuyAlert() : Boolean
      {
         var _loc7_:TodayNotAlertFrame = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc3_:Date = SharedManager.instance.petEquipUpgradeAutoBuyCheckDate;
         var _loc4_:Date = new Date();
         var _loc1_:Boolean = false;
         var _loc5_:Boolean = Boolean(SharedManager.instance.petEquipUpgradeAutoBuy);
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
         SharedManager.instance.petEquipUpgradeAutoBuy = param1;
         SharedManager.instance.petEquipUpgradeAutoBuyCheckDate = new Date();
         SharedManager.instance.savePetEquipUpgradeAutoBuyCheck();
         _autoBuySelectButton.selected = true;
         refreshBtnEnable();
      }
      
      private function initData() : void
      {
         _itemDic.add("0_0_0",_upgradeItem);
         updateView();
      }
      
      private function __showEffect(param1:NotificationEvent) : void
      {
         var _loc2_:GoodsInfo = param1.data as GoodsInfo;
         if(_loc2_)
         {
            if(_loc2_.templateInfo.MasterType == 5)
            {
               _upgradeItem.setSelectedEff();
            }
         }
      }
      
      private function __hideEffect(param1:NotificationEvent) : void
      {
         _upgradeItem.setNotSelectedEff();
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:PetEquipStrengItem = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_ && PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipUpgradeView" && _loc3_.templateInfo.Profile >= 3 && _loc3_.templateInfo.Profile <= 5)
         {
            _loc2_.data = _loc3_;
            updateView();
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:PetEquipStrengItem = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_ && PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipUpgradeView")
         {
            _loc2_.data = null;
            updateView();
         }
      }
      
      private function __onComposeCallback(param1:SLGSocketEvent) : void
      {
         var _loc4_:String = null;
         var _loc3_:Array = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:StoreRspMsg = new StoreRspMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as StoreRspMsg;
         if(_loc2_.composeResult)
         {
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.composeTemplateId).TemplateName;
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("pet.equipstore.PetEquipUpgradeView.success",_loc4_));
            _upgradeItem.data = null;
            updateView();
            _loc3_ = GoodsManager.instance.getGoodsByBagType(0);
            for each(var _loc5_:GoodsInfo in _loc3_)
            {
               PlayerManager.instance.moveBagToBag(_loc5_.bagType,_loc5_.objectId,_loc5_.pos,1,0,0,1);
            }
            NotificationManager.instance.dispatchEvent(new NotificationEvent("PETSELECTEDCHANGE"));
         }
      }
      
      private function updateView() : void
      {
         var _loc2_:ComposeGoodsTemplete = null;
         var _loc4_:int = 0;
         var _loc1_:GoodsInfo = null;
         var _loc3_:GoodsInfo = null;
         var _loc5_:GoodsInfo = null;
         var _loc6_:GoodsTemplateInfo = null;
         clearVbox(_vbox1);
         clearVbox(_vbox2);
         if(_upgradeItem.data)
         {
            _loc2_ = TempleteManager.instance.getEquipUpdateComposeTempleteByMainMaterialId(_upgradeItem.data.templateInfo.TemplateId);
            if(_loc2_)
            {
               _loc4_ = int(GoodsManager.instance.getBagCountByTempId(1,_loc2_.Material2));
               _loc1_ = new GoodsInfo();
               _loc1_.templateId = _loc2_.Material2;
               _needItem.data = _loc1_;
               _needItem.txtVisible(true);
               _needItem.visible = true;
               _leftTitleTxt.visible = true;
               _rightTitleTxt.visible = true;
               _needItem.needItemNum = _loc2_.Count2;
               _loc3_ = new GoodsInfo();
               _loc3_.templateId = _loc2_.Material2;
               _needItem.data = _loc3_;
               _needItem.updateTxt(_loc4_);
               _loc5_ = new GoodsInfo();
               _loc5_.templateId = _loc2_.NewMaterial;
               _loc5_.mouldGrade = 0;
               _loc5_.join1 = _upgradeItem.data.join1;
               _loc5_.join2 = _upgradeItem.data.join2;
               _loc5_.join3 = _upgradeItem.data.join3;
               _loc5_.join4 = _upgradeItem.data.join4;
               if(_upgradeItem.data.randomSkill1 > 0)
               {
                  _loc5_.randomSkill1 = _upgradeItem.data.randomSkill1;
               }
               if(_upgradeItem.data.randomSkill2 > 0)
               {
                  _loc5_.randomSkill2 = _upgradeItem.data.randomSkill2;
               }
               if(_upgradeItem.data.randomSkill3 > 0)
               {
                  _loc5_.randomSkill3 = _upgradeItem.data.randomSkill3;
               }
               if(_upgradeItem.data.randomSkill4 > 0)
               {
                  _loc5_.randomSkill4 = _upgradeItem.data.randomSkill4;
               }
               if(_upgradeItem.data.randomSkill5 > 0)
               {
                  _loc5_.randomSkill5 = _upgradeItem.data.randomSkill5;
               }
               _loc5_.isBinds = true;
               _loc5_.id = _upgradeItem.data.id;
               _loc5_.objectId = _upgradeItem.data.objectId;
               _loc5_.userId = _upgradeItem.data.userId;
               _item2.data = _loc5_;
               _leftTitleTxt.text = _upgradeItem.data.templateInfo.TemplateName;
               _leftTitleTxt.setFrame(_upgradeItem.data.templateInfo.Profile);
               _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_.templateId);
               _rightTitleTxt.text = _loc6_.TemplateName;
               _rightTitleTxt.setFrame(_loc6_.Profile);
               setCurrAttribute(_upgradeItem.data,_upgradeItem.data.templateInfo);
               setNextAttribute(_loc5_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_.templateId));
               _needGoldTxt.text = _loc2_.NeedGold + "";
               setUpgradeBtn(_loc2_.Count2,_loc4_);
            }
            else
            {
               _needItem.txtVisible(false);
               _needItem.visible = false;
               _item2.data = null;
               _leftTitleTxt.visible = false;
               _rightTitleTxt.visible = false;
               _needGoldTxt.text = "--";
               _upgradeBtn.enable = false;
            }
         }
         else
         {
            _needItem.txtVisible(false);
            _item2.data = null;
            _needItem.visible = false;
            _leftTitleTxt.visible = false;
            _rightTitleTxt.visible = false;
            _needGoldTxt.text = "--";
            _upgradeBtn.enable = false;
         }
         refreshBtnEnable();
      }
      
      private function setUpgradeBtn(param1:int, param2:int) : void
      {
         if(_upgradeItem.data)
         {
            if(param1 <= param2)
            {
               _upgradeBtn.enable = true;
            }
            else
            {
               _upgradeBtn.enable = false;
            }
         }
         else
         {
            _upgradeBtn.enable = false;
         }
      }
      
      private function get gold() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      private function __upgradeBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc7_:int = 0;
         var _loc5_:ShopGoodsInfo = null;
         var _loc8_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc2_:String = "";
         if(gold.count < parseInt(_needGoldTxt.text))
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.equipstore.PetEquipUpgradeView.cannotSendPrompt01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc6_:ComposeGoodsTemplete = TempleteManager.instance.getEquipUpdateComposeTempleteByMainMaterialId(_upgradeItem.data.templateInfo.TemplateId);
         var _loc9_:int = int(GoodsManager.instance.getBagCountByTempId(1,_loc6_.Material2));
         if(!_loc6_)
         {
            return;
         }
         _promptID = _loc6_.NewMaterial;
         if(_loc6_ && _loc6_.Count2 > _loc9_)
         {
            _loc7_ = _loc6_.Count2 - _loc9_;
            _loc5_ = TempleteManager.instance.getShopTempInfoByItemId(_loc6_.Material2);
            _loc8_ = _loc5_.GiftToken * _loc7_;
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc10_ = LanguageMgr.GetTranslation("public.prompt");
            _loc11_ = LanguageMgr.GetTranslation("pet.petEquipNotEnoughTips3",_loc8_);
            SimpleAlertHelper.instance.data = [askToSendBack,_loc8_];
            SimpleAlertHelper.instance.popAlerFrame(_loc10_,_loc11_,_loc3_,_loc4_,true,true,true,2,"USEBINDPOINT_ALERT",195,"",null,"SimpleAlert");
         }
         else
         {
            StoreSocketOutManager.sendUpdateEquip(_loc6_.Id,1,true,false);
         }
      }
      
      private function askToSendBack(param1:Boolean, param2:Boolean, param3:int = 0) : void
      {
         var _loc5_:int = 0;
         var _loc4_:ComposeGoodsTemplete = null;
         if(param1)
         {
            if(param2)
            {
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
            }
            else
            {
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
            }
            if(param3 > _loc5_)
            {
               RechargeAlertMannager.show();
               return;
            }
            _loc4_ = TempleteManager.instance.getEquipUpdateComposeTempleteByMainMaterialId(_upgradeItem.data.templateInfo.TemplateId);
            StoreSocketOutManager.sendUpdateEquip(_loc4_.Id,1,param2,false);
         }
      }
      
      private function clearVbox(param1:VBox) : void
      {
         while(param1.numChildren)
         {
            param1.removeChildAt(param1.numChildren - 1);
         }
      }
      
      private function setCurrAttribute(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
         var _loc3_:String = null;
         if(param1)
         {
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01");
            updateAttributeTxt(_vbox1,_power,_loc3_,param2.Power,getAdd(param2.Power,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02");
            updateAttributeTxt(_vbox1,_agility,_loc3_,param2.Agility,getAdd(param2.Agility,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03");
            updateAttributeTxt(_vbox1,_ability,_loc3_,param2.Intellect,getAdd(param2.Intellect,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04");
            updateAttributeTxt(_vbox1,_physique,_loc3_,param2.Physique,getAdd(param2.Physique,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip05");
            updateAttributeTxt(_vbox1,_captain,_loc3_,param2.Captain,getAdd(param2.Captain,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13");
            updateAttributeTxt(_vbox1,_attack,_loc3_,param2.Attack,getAdd(param2.Attack,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
            updateAttributeTxt(_vbox1,_magicAttack,_loc3_,param2.MagicAttack,getAdd(param2.MagicAttack,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14");
            updateAttributeTxt(_vbox1,_defence,_loc3_,param2.Defence,getAdd(param2.Defence,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16");
            updateAttributeTxt(_vbox1,_magicDefence,_loc3_,param2.MagicDefence,getAdd(param2.MagicDefence,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19");
            updateAttributeTxt(_vbox1,_parry,_loc3_,param2.Parry,getAdd(param2.Parry,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
            updateAttributeTxt(_vbox1,_live,_loc3_,param2.Live,getAdd(param2.Live,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10");
            updateAttributeTxt(_vbox1,_forceHit,_loc3_,param2.ForceHit,getAdd(param2.ForceHit,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip17");
            updateAttributeTxt(_vbox1,_conat,_loc3_,param2.Conat,getAdd(param2.Conat,param1));
         }
      }
      
      private function setNextAttribute(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
         var _loc3_:String = null;
         if(param1)
         {
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01");
            updateAttributeTxt(_vbox2,_power2,_loc3_,param2.Power,getAdd(param2.Power,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02");
            updateAttributeTxt(_vbox2,_agility2,_loc3_,param2.Agility,getAdd(param2.Agility,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03");
            updateAttributeTxt(_vbox2,_ability2,_loc3_,param2.Intellect,getAdd(param2.Intellect,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04");
            updateAttributeTxt(_vbox2,_physique2,_loc3_,param2.Physique,getAdd(param2.Physique,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip05");
            updateAttributeTxt(_vbox2,_captain2,_loc3_,param2.Captain,getAdd(param2.Captain,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13");
            updateAttributeTxt(_vbox2,_attack2,_loc3_,param2.Attack,getAdd(param2.Attack,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
            updateAttributeTxt(_vbox2,_magicAttack2,_loc3_,param2.MagicAttack,getAdd(param2.MagicAttack,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14");
            updateAttributeTxt(_vbox2,_defence2,_loc3_,param2.Defence,getAdd(param2.Defence,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16");
            updateAttributeTxt(_vbox2,_magicDefence2,_loc3_,param2.MagicDefence,getAdd(param2.MagicDefence,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19");
            updateAttributeTxt(_vbox2,_parry2,_loc3_,param2.Parry,getAdd(param2.Parry,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
            updateAttributeTxt(_vbox2,_live2,_loc3_,param2.Live,getAdd(param2.Live,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10");
            updateAttributeTxt(_vbox2,_forceHit2,_loc3_,param2.ForceHit,getAdd(param2.ForceHit,param1));
            _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip17");
            updateAttributeTxt(_vbox2,_conat2,_loc3_,param2.Conat,getAdd(param2.Conat,param1));
         }
         _vbox2.addChild(_addStreng);
         _addStreng.text = LanguageMgr.GetTranslation("pet.equipstore.PetEquipUpgradeView.addStreng");
         _vbox2.addChild(_addGem);
         _addGem.text = LanguageMgr.GetTranslation("pet.equipstore.PetEquipUpgradeView.addGemTxt");
         _vbox2.addChild(_addRefinery);
         _addRefinery.text = LanguageMgr.GetTranslation("pet.equipstore.PetEquipUpgradeView.addRefinery");
         var _loc4_:GoodsInfo = _upgradeItem.data;
         _addGem.visible = _addRefinery.visible = true;
         if(_loc4_ != null && _loc4_.templateInfo.Profile >= 5)
         {
            _addGem.visible = _addRefinery.visible = false;
         }
      }
      
      private function updateAttributeTxt(param1:VBox, param2:FilterFrameText, param3:String, param4:int, param5:int) : void
      {
         if(param3 != "" && param4 > 0)
         {
            param3 += param4 + param5;
            param2.text = param3;
            param1.addChild(param2);
         }
      }
      
      private function getAdd(param1:int, param2:GoodsInfo) : int
      {
         return GoodsHelp.getPetEquipStrengAddition(param1,param2.mouldGrade);
      }
      
      private function __itemDataChangeHandler(param1:NotificationEvent) : void
      {
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(_itemDic)
         {
            _itemDic.clear();
         }
         _itemDic = null;
         super.dispose();
      }
   }
}

