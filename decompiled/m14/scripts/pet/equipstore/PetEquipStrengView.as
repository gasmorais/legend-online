package pet.equipstore
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.store.StoreRspMsg;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.PetEquipManager;
   import managers.StoreSocketOutManager;
   import mvc.module.shop.ShopGoodsInfo;
   import pet.advanced.PetEquipBagView;
   import pet.equipstore.streng.PetEquipStrengAttributeTxt;
   import pet.equipstore.streng.PetEquipStrengItem;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.resource.ResourceData;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.ResourceManager;
   import yishi.manager.SharedManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class PetEquipStrengView extends Component
   {
      
      private static var _needAlert:Boolean = true;
      
      private var _bg:Bitmap;
      
      private var _itemBg01:Image;
      
      private var _itemBg02:Image;
      
      private var _attributeBg01:Image;
      
      private var _attributeBg02:Image;
      
      private var _arrow:Bitmap;
      
      private var _sucessRate:Bitmap;
      
      private var _progressBarImg:Bitmap;
      
      private var _maxStreng:Bitmap;
      
      private var _currEquipName:FilterFrameText;
      
      private var _nextEquipName:FilterFrameText;
      
      private var _successRateTxt:FilterFrameText;
      
      private var _blessingTxt:FilterFrameText;
      
      private var _progressMask:Shape;
      
      private var _progressBg:Bitmap;
      
      private var _progressBg02:Bitmap;
      
      private var _strengBtn:IconButton;
      
      private var _strengItem:PetEquipStrengItem;
      
      private var _equipBag:PetEquipBagView;
      
      private var _needItem1:NeedMaterialItem;
      
      private var _needItem2:NeedMaterialItem;
      
      private var _strengNextItem:BaseItemView;
      
      private var _itemDic:SimpleDictionary;
      
      private var _currAddImg:Bitmap;
      
      private var _nextAddImg:Bitmap;
      
      private var _bmd:BitmapData;
      
      private var _bmd2:BitmapData;
      
      private var _currSprite:Sprite;
      
      private var _nextSprite:Sprite;
      
      private var _currAttributeSprite:VBox;
      
      private var _nextAttributeSprite:VBox;
      
      private var _power:PetEquipStrengAttributeTxt;
      
      private var _agility:PetEquipStrengAttributeTxt;
      
      private var _ability:PetEquipStrengAttributeTxt;
      
      private var _physique:PetEquipStrengAttributeTxt;
      
      private var _captain:PetEquipStrengAttributeTxt;
      
      private var _attack:PetEquipStrengAttributeTxt;
      
      private var _magicAttack:PetEquipStrengAttributeTxt;
      
      private var _defence:PetEquipStrengAttributeTxt;
      
      private var _magicDefence:PetEquipStrengAttributeTxt;
      
      private var _parry:PetEquipStrengAttributeTxt;
      
      private var _live:PetEquipStrengAttributeTxt;
      
      private var _forceHit:PetEquipStrengAttributeTxt;
      
      private var _conat:PetEquipStrengAttributeTxt;
      
      private var _power2:PetEquipStrengAttributeTxt;
      
      private var _agility2:PetEquipStrengAttributeTxt;
      
      private var _ability2:PetEquipStrengAttributeTxt;
      
      private var _physique2:PetEquipStrengAttributeTxt;
      
      private var _captain2:PetEquipStrengAttributeTxt;
      
      private var _attack2:PetEquipStrengAttributeTxt;
      
      private var _magicAttack2:PetEquipStrengAttributeTxt;
      
      private var _defence2:PetEquipStrengAttributeTxt;
      
      private var _magicDefence2:PetEquipStrengAttributeTxt;
      
      private var _parry2:PetEquipStrengAttributeTxt;
      
      private var _live2:PetEquipStrengAttributeTxt;
      
      private var _forceHit2:PetEquipStrengAttributeTxt;
      
      private var _conat2:PetEquipStrengAttributeTxt;
      
      private var _effect:MovieImage;
      
      private var _autoBuySelectButton:SelectedButton;
      
      private var _autoBuyBtnText:FilterFrameText;
      
      private var _equipStrenghNoteTxt:FilterFrameText;
      
      private var totalPrice:int = 0;
      
      private var _curEvolveTimeStamp:int = 0;
      
      public function PetEquipStrengView()
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
         _bg = ComponentFactory.Instance.creatBitmap("asset.pet.equipStrengBg");
         _itemBg01 = ComponentFactory.Instance.creatComponentByStylename("pet.strengItemBg01");
         _itemBg02 = ComponentFactory.Instance.creatComponentByStylename("pet.strengItemBg02");
         _attributeBg01 = ComponentFactory.Instance.creatComponentByStylename("pet.attributeBg01");
         _attributeBg02 = ComponentFactory.Instance.creatComponentByStylename("pet.attributeBg02");
         _currEquipName = ComponentFactory.Instance.creatComponentByStylename("petEquip.currItemName");
         _nextEquipName = ComponentFactory.Instance.creatComponentByStylename("petEquip.nextItemName");
         _arrow = ComponentFactory.Instance.creatBitmap("asset.pet.arrowImg");
         _sucessRate = ComponentFactory.Instance.creatBitmap("asset.pet.successRateImg");
         _progressBarImg = ComponentFactory.Instance.creatBitmap("asset.pet.progressBarBg");
         _maxStreng = ComponentFactory.Instance.creatBitmap("asset.pet.StrengIsMax");
         _successRateTxt = ComponentFactory.Instance.creatComponentByStylename("petEquip.successRateTxt");
         _blessingTxt = ComponentFactory.Instance.creatComponentByStylename("petEquip.blessingValueTxt");
         _progressBg = ComponentFactory.Instance.creatBitmap("asset.pet.strengProgress01");
         _progressBg02 = ComponentFactory.Instance.creatBitmap("asset.pet.strengProgress02");
         _progressMask = new Shape();
         _strengBtn = ComponentFactory.Instance.creatComponentByStylename("pet.strengBtn");
         _strengItem = ComponentFactory.Instance.creatCustomObject("pet.PetEquipStrengItem");
         _needItem1 = ComponentFactory.Instance.creatCustomObject("pet.strengNeedMaterialItemView01");
         _needItem2 = ComponentFactory.Instance.creatCustomObject("pet.strengNeedMaterialItemView02");
         _strengNextItem = ComponentFactory.Instance.creatCustomObject("pet.PetEquipStrengNextItem");
         _equipBag = new PetEquipBagView(2,13,13,"pet.equipStrengScroll",false);
         _effect = ComponentFactory.Instance.creatComponentByStylename("pet.strengMaxEffect");
         _effect.movie.play();
         _autoBuySelectButton = ComponentFactory.Instance.creatComponentByStylename("pet.autoBuySelectButton");
         _autoBuyBtnText = ComponentFactory.Instance.creatComponentByStylename("pet.autoBuyBtnText");
         _equipStrenghNoteTxt = ComponentFactory.Instance.creatComponentByStylename("pet.equipStrenghNote");
         _equipBag.x = 3;
         _equipBag.y = 288;
         _itemDic = new SimpleDictionary();
         _currAddImg = ComponentFactory.Instance.creatBitmap("asset.tips.addImg");
         _currAddImg.x = 222;
         _currAddImg.y = 92;
         _nextAddImg = ComponentFactory.Instance.creatBitmap("asset.tips.addImg");
         _nextAddImg.x = 535;
         _nextAddImg.y = 92;
         _bmd = ComponentFactory.Instance.creatBitmapData("asset.tips.numImg");
         _bmd2 = ComponentFactory.Instance.creatBitmapData("asset.tips.numImg");
         _currSprite = new Sprite();
         _nextSprite = new Sprite();
         _currAttributeSprite = new VBox();
         _nextAttributeSprite = new VBox();
         addChild(_bg);
         addChild(_itemBg01);
         addChild(_itemBg02);
         addChild(_attributeBg01);
         addChild(_attributeBg02);
         addChild(_currEquipName);
         _currEquipName.text = "蓝色的英灵装{invalid_utf8=229}{invalid_utf8=164}?";
         _currEquipName.setFrame(3);
         addChild(_nextEquipName);
         _nextEquipName.text = "橙色的英灵装{invalid_utf8=229}{invalid_utf8=164}?";
         _nextEquipName.setFrame(5);
         addChild(_arrow);
         addChild(_sucessRate);
         addChild(_progressBarImg);
         addChild(_maxStreng);
         _maxStreng.visible = false;
         addChild(_successRateTxt);
         _successRateTxt.text = "100%";
         addChild(_progressBg02);
         addChild(_progressBg);
         _progressBg02.mask = _progressMask;
         addChild(_progressMask);
         _progressMask.x = 184;
         _progressMask.y = 209;
         addChild(_blessingTxt);
         addChild(_strengBtn);
         addChild(_needItem1);
         addChild(_needItem2);
         addChild(_equipBag);
         addChild(_strengItem);
         addChild(_strengNextItem);
         addChild(_currAddImg);
         addChild(_nextAddImg);
         addChild(_currSprite);
         _currSprite.x = 235;
         _currSprite.y = 93;
         addChild(_nextSprite);
         _nextSprite.x = 550;
         _nextSprite.y = 93;
         addChild(_currAttributeSprite);
         _currAttributeSprite.x = 54;
         _currAttributeSprite.y = 130;
         addChild(_nextAttributeSprite);
         _nextAttributeSprite.x = 368;
         _nextAttributeSprite.y = 130;
         addChild(_effect);
         addChild(_autoBuySelectButton);
         addChild(_autoBuyBtnText);
         _autoBuyBtnText.text = LanguageMgr.GetTranslation("store.view.refresh.RefreshView.buyTxt");
         addChild(_equipStrenghNoteTxt);
         _equipStrenghNoteTxt.text = LanguageMgr.GetTranslation("PetEquipStrengView.equipStrenghNote");
         _power = new PetEquipStrengAttributeTxt();
         _agility = new PetEquipStrengAttributeTxt();
         _ability = new PetEquipStrengAttributeTxt();
         _physique = new PetEquipStrengAttributeTxt();
         _captain = new PetEquipStrengAttributeTxt();
         _attack = new PetEquipStrengAttributeTxt();
         _magicAttack = new PetEquipStrengAttributeTxt();
         _defence = new PetEquipStrengAttributeTxt();
         _magicDefence = new PetEquipStrengAttributeTxt();
         _parry = new PetEquipStrengAttributeTxt();
         _live = new PetEquipStrengAttributeTxt();
         _forceHit = new PetEquipStrengAttributeTxt();
         _conat = new PetEquipStrengAttributeTxt();
         _power2 = new PetEquipStrengAttributeTxt();
         _agility2 = new PetEquipStrengAttributeTxt();
         _ability2 = new PetEquipStrengAttributeTxt();
         _physique2 = new PetEquipStrengAttributeTxt();
         _captain2 = new PetEquipStrengAttributeTxt();
         _attack2 = new PetEquipStrengAttributeTxt();
         _magicAttack2 = new PetEquipStrengAttributeTxt();
         _defence2 = new PetEquipStrengAttributeTxt();
         _magicDefence2 = new PetEquipStrengAttributeTxt();
         _parry2 = new PetEquipStrengAttributeTxt();
         _live2 = new PetEquipStrengAttributeTxt();
         _forceHit2 = new PetEquipStrengAttributeTxt();
         _conat2 = new PetEquipStrengAttributeTxt();
         var _loc1_:GoodsInfo = new GoodsInfo();
         _loc1_.templateId = 3250101;
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = 3260101;
         _needItem1.data = _loc1_;
         _needItem2.data = _loc2_;
      }
      
      private function initEvent() : void
      {
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         _strengBtn.addEventListener("click",__onStrengBtnClickHandler);
         _autoBuySelectButton.addEventListener("click",__autoBuySelectButtonClickHandler);
         NotificationManager.instance.addEventListener("PETEQUIPSTOREDATACHANGE",__itemDataChangeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4558,__mouldResult);
         NotificationManager.instance.addEventListener("PETEQUIPDROPSTART",__showEffect);
         NotificationManager.instance.addEventListener("PETEQUIPDROPOVER",__hideEffect);
      }
      
      private function initData() : void
      {
         _itemDic.add("0_0_0",_strengItem);
         updateView();
      }
      
      private function removeEvent() : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         _strengBtn.removeEventListener("click",__onStrengBtnClickHandler);
         _autoBuySelectButton.removeEventListener("click",__autoBuySelectButtonClickHandler);
         NotificationManager.instance.removeEventListener("PETEQUIPSTOREDATACHANGE",__itemDataChangeHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4558,__mouldResult);
         NotificationManager.instance.removeEventListener("PETEQUIPDROPSTART",__showEffect);
         NotificationManager.instance.removeEventListener("PETEQUIPDROPOVER",__hideEffect);
      }
      
      private function __autoBuySelectButtonClickHandler(param1:MouseEvent) : void
      {
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
         var _loc1_:int = int(GoodsManager.instance.getBagCountByTempId(1,3250101));
         var _loc2_:int = int(GoodsManager.instance.getBagCountByTempId(1,3260101));
         setStrengBtn(_loc1_,_loc2_);
      }
      
      private function showBuyAlert() : Boolean
      {
         var _loc7_:TodayNotAlertFrame = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc3_:Date = SharedManager.instance.petEquipStrengAutoBuyCheckDate;
         var _loc4_:Date = new Date();
         var _loc1_:Boolean = false;
         var _loc5_:Boolean = Boolean(SharedManager.instance.petEquipStrengAutoBuy);
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
         SharedManager.instance.petEquipStrengAutoBuy = param1;
         SharedManager.instance.petEquipStrengAutoBuyCheckDate = new Date();
         SharedManager.instance.savePetEquipStrengAutoBuyCheck();
         _autoBuySelectButton.selected = true;
         refreshBtnEnable();
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:PetEquipStrengItem = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_ && PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipStrengView")
         {
            _loc2_.data = _loc3_;
            updateView();
         }
      }
      
      private function __itemDataChangeHandler(param1:NotificationEvent) : void
      {
      }
      
      private function __mouldResult(param1:SLGSocketEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:StoreRspMsg = new StoreRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as StoreRspMsg;
         if(_loc2_.strengResult)
         {
            _loc3_ = LanguageMgr.GetTranslation("pet.equipstore.PetEquipStrengView.strengSuccess");
            MessageTipManager.instance().show(_loc3_);
         }
         else
         {
            if(_strengItem.data.mouldGrade < 10)
            {
               _loc3_ = LanguageMgr.GetTranslation("pet.equipstore.PetEquipStrengView.strengfaile",5);
            }
            else
            {
               _loc3_ = LanguageMgr.GetTranslation("pet.equipstore.PetEquipStrengView.strengfaile",3);
            }
            MessageTipManager.instance().show(_loc3_);
         }
         updateView();
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:PetEquipStrengItem = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_ && PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipStrengView")
         {
            _loc2_.data = null;
            updateView();
         }
      }
      
      private function __onStrengBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = getTimer();
         if(_loc2_ - _curEvolveTimeStamp < 500)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _curEvolveTimeStamp = _loc2_;
         askToSend();
      }
      
      public function strendCall(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            askToSend();
         }
      }
      
      private function askToSend() : void
      {
         var _loc1_:ShopGoodsInfo = null;
         var _loc3_:ShopGoodsInfo = null;
         var _loc5_:String = null;
         var _loc2_:String = null;
         var _loc4_:int = int(GoodsManager.instance.getBagCountByTempId(1,3250101));
         var _loc6_:int = int(GoodsManager.instance.getBagCountByTempId(1,3260101));
         if(_loc4_ >= 3 && _loc6_ >= 3)
         {
            StoreSocketOutManager.sendItemMould();
         }
         else
         {
            totalPrice = 0;
            _loc1_ = TempleteManager.instance.getShopTempInfoByItemId(3250101);
            _loc3_ = TempleteManager.instance.getShopTempInfoByItemId(3260101);
            if(_loc4_ < 3)
            {
               totalPrice += _loc1_.GiftToken * (3 - _loc4_);
            }
            if(_loc6_ < 3)
            {
               totalPrice += _loc3_.GiftToken * (3 - _loc6_);
            }
            _loc5_ = LanguageMgr.GetTranslation("pet.petEquipNotEnoughTips1",totalPrice);
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            SharedManagerHelper.ins.needAlert("pet.petEquip.costPoint.alert",askToSendBack,_loc2_,_loc5_,"");
         }
      }
      
      private function askToSendBack(param1:Boolean) : void
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
         if(totalPrice > _loc2_)
         {
            RechargeAlertMannager.show();
            return;
         }
         var _loc3_:int = param1 ? 0 : 1;
         StoreSocketOutManager.sendItemMould(_loc3_);
      }
      
      private function updateView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:* = 0;
         var _loc4_:GoodsInfo = null;
         clearVbox();
         if(_strengItem && _strengItem.data)
         {
            _needItem1.txtVisible(true);
            _needItem2.txtVisible(true);
            _currEquipName.visible = true;
            _nextEquipName.visible = true;
            _successRateTxt.text = strengRate(_strengItem.data) + "%";
            _blessingTxt.visible = true;
            _loc2_ = int(GoodsManager.instance.getBagCountByTempId(1,3250101));
            _loc3_ = int(GoodsManager.instance.getBagCountByTempId(1,3260101));
            _loc1_ = 3;
            _needItem1.needItemNum = _loc1_;
            _needItem2.needItemNum = _loc1_;
            _needItem1.updateTxt(_loc2_);
            _needItem2.updateTxt(_loc3_);
            updateShape(_strengItem.data.blessValue,100);
            _loc4_ = new GoodsInfo();
            _loc4_.id = _strengItem.data.id;
            _loc4_.templateId = _strengItem.data.templateId;
            _loc4_.pos = -1;
            _loc4_.userId = _strengItem.data.userId;
            _loc4_.isExist = false;
            _loc4_.objectId = -1;
            _loc4_.isBinds = true;
            _loc4_.isUsed = _strengItem.data.isUsed;
            _loc4_.isNew = _strengItem.data.isNew;
            _loc4_.validDate = _strengItem.data.validDate;
            _loc4_.beginDate = _strengItem.data.beginDate;
            _loc4_.count = 1;
            _loc4_.willSellCount = _strengItem.data.willSellCount;
            _loc4_.strengthenGrade = _strengItem.data.strengthenGrade;
            _loc4_.join1 = _strengItem.data.join1;
            _loc4_.join2 = _strengItem.data.join2;
            _loc4_.join3 = _strengItem.data.join3;
            _loc4_.join4 = _strengItem.data.join4;
            _loc4_.randomSkill1 = _strengItem.data.randomSkill1;
            _loc4_.randomSkill2 = _strengItem.data.randomSkill2;
            _loc4_.randomSkill3 = _strengItem.data.randomSkill3;
            _loc4_.randomSkill4 = _strengItem.data.randomSkill4;
            _loc4_.randomSkill5 = _strengItem.data.randomSkill5;
            _loc4_.blessValue = _strengItem.data.blessValue;
            _loc4_.suitCount = _strengItem.data.suitCount;
            _loc4_.jewelGrade = _strengItem.data.jewelGrade;
            _loc4_.showCount = _strengItem.data.showCount;
            _loc4_.identityed = _strengItem.data.identityed;
            _loc4_.property1 = _strengItem.data.property1;
            if(_strengItem.data.mouldGrade < TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_.templateId).StrengthenMax)
            {
               _loc4_.mouldGrade = _strengItem.data.mouldGrade + 1;
            }
            else
            {
               _loc4_.mouldGrade = _strengItem.data.mouldGrade;
            }
            if(_loc4_.mouldGrade >= _strengItem.data.templateInfo.StrengthenMax)
            {
               _effect.visible = true;
            }
            else
            {
               _effect.visible = false;
            }
            _strengNextItem.data = _loc4_;
            NumberViewUtils.refreshValue(_strengItem.data.mouldGrade,_currSprite,_bmd,19,22,15,19,"0123456789");
            NumberViewUtils.refreshValue(_loc4_.mouldGrade,_nextSprite,_bmd2,19,22,15,19,"0123456789");
            _nextEquipName.text = _currEquipName.text = _strengItem.data.templateInfo.TemplateName;
            _nextEquipName.setFrame(_strengItem.data.templateInfo.Profile);
            _currEquipName.setFrame(_strengItem.data.templateInfo.Profile);
            initAttribute(_strengItem.data,_strengItem.data.templateInfo);
            initNextAttribute(_loc4_,_strengItem.data.templateInfo);
            if(_strengItem.data.templateInfo.StrengthenMax <= _strengItem.data.mouldGrade)
            {
               _nextEquipName.visible = false;
               _attributeBg02.visible = false;
               _maxStreng.visible = true;
               _nextAddImg.visible = false;
               _nextSprite.visible = false;
               _currAttributeSprite.visible = true;
               _nextAttributeSprite.visible = false;
               _successRateTxt.text = "--";
               updateShape(0,100);
               _blessingTxt.visible = false;
            }
            else
            {
               _nextEquipName.visible = true;
               _attributeBg02.visible = true;
               _maxStreng.visible = false;
               _nextAddImg.visible = true;
               _nextSprite.visible = true;
               _currAttributeSprite.visible = true;
               _nextAttributeSprite.visible = true;
            }
            if(_strengItem.data.mouldGrade > 0)
            {
               _currAddImg.visible = true;
               _currSprite.visible = true;
               _currEquipName.width = 165;
            }
            else
            {
               _currAddImg.visible = false;
               _currSprite.visible = false;
               _currEquipName.width = 165;
            }
            setStrengBtn(_loc2_,_loc3_);
         }
         else
         {
            _needItem1.txtVisible(false);
            _needItem2.txtVisible(false);
            _currEquipName.visible = false;
            _nextEquipName.visible = false;
            _successRateTxt.text = "--";
            _blessingTxt.visible = false;
            updateShape(1,1000);
            _strengNextItem.data = null;
            _attributeBg02.visible = true;
            _maxStreng.visible = false;
            _currAddImg.visible = false;
            _nextAddImg.visible = false;
            _currSprite.visible = false;
            _nextSprite.visible = false;
            _currAttributeSprite.visible = false;
            _nextAttributeSprite.visible = false;
            _strengBtn.enable = false;
            _effect.visible = false;
         }
      }
      
      private function setStrengBtn(param1:int, param2:int) : void
      {
         if(_strengItem.data)
         {
            if(_strengItem.data.mouldGrade < _strengItem.data.templateInfo.StrengthenMax)
            {
               if(param1 >= 3 && param2 >= 3)
               {
                  _strengBtn.enable = true;
               }
               else if(_autoBuySelectButton.selected)
               {
                  _strengBtn.enable = true;
               }
               else
               {
                  _strengBtn.enable = false;
               }
            }
            else
            {
               _strengBtn.enable = false;
            }
         }
         else
         {
            _strengBtn.enable = false;
         }
      }
      
      private function get gold() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      private function updateShape(param1:int, param2:int) : void
      {
         _blessingTxt.text = LanguageMgr.GetTranslation("pet.equipstore.PetEquipStrengView.blessValue") + param1 + "/" + param2;
         if(param1 == param2 && Boolean(_blessingTxt.visible))
         {
            _successRateTxt.text = "100%";
         }
         _progressMask.graphics.clear();
         _progressMask.graphics.beginFill(0,0);
         _progressMask.graphics.drawRect(0,0,param1 * 245 / param2,14);
         _progressMask.graphics.endFill();
      }
      
      private function strengRate(param1:GoodsInfo) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 50 - param1.mouldGrade * 10;
         if(_loc2_ <= 0)
         {
            _loc2_ = 1;
         }
         _loc2_ += param1.blessValue;
         if(_loc2_ > 100)
         {
            _loc2_ = 100;
         }
         return _loc2_;
      }
      
      private function costGold(param1:GoodsInfo) : int
      {
         var _loc2_:int = 0;
         return int(30000 * param1.templateInfo.Profile * param1.mouldGrade);
      }
      
      private function initAttribute(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
         var _loc3_:String = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01");
         updateAttributeTxt(_power,_loc3_,param2.Power,getAdd(param2.Power,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02");
         updateAttributeTxt(_agility,_loc3_,param2.Agility,getAdd(param2.Agility,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03");
         updateAttributeTxt(_ability,_loc3_,param2.Intellect,getAdd(param2.Intellect,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04");
         updateAttributeTxt(_physique,_loc3_,param2.Physique,getAdd(param2.Physique,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip05");
         updateAttributeTxt(_captain,_loc3_,param2.Captain,getAdd(param2.Captain,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13");
         updateAttributeTxt(_attack,_loc3_,param2.Attack,getAdd(param2.Attack,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
         updateAttributeTxt(_magicAttack,_loc3_,param2.MagicAttack,getAdd(param2.MagicAttack,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14");
         updateAttributeTxt(_defence,_loc3_,param2.Defence,getAdd(param2.Defence,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16");
         updateAttributeTxt(_magicDefence,_loc3_,param2.MagicDefence,getAdd(param2.MagicDefence,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19");
         updateAttributeTxt(_parry,_loc3_,param2.Parry,getAdd(param2.Parry,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
         updateAttributeTxt(_live,_loc3_,param2.Live,getAdd(param2.Live,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10");
         updateAttributeTxt(_forceHit,_loc3_,param2.ForceHit,getAdd(param2.ForceHit,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip17");
         updateAttributeTxt(_conat,_loc3_,param2.Conat,getAdd(param2.Conat,param1));
      }
      
      private function initNextAttribute(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
         var _loc3_:String = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01");
         updateAttributeTxt(_power2,_loc3_,param2.Power,getAdd(param2.Power,param1),getNewAdd(param2.Power,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02");
         updateAttributeTxt(_agility2,_loc3_,param2.Agility,getAdd(param2.Agility,param1),getNewAdd(param2.Agility,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03");
         updateAttributeTxt(_ability2,_loc3_,param2.Intellect,getAdd(param2.Intellect,param1),getNewAdd(param2.Intellect,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04");
         updateAttributeTxt(_physique2,_loc3_,param2.Physique,getAdd(param2.Physique,param1),getNewAdd(param2.Physique,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip05");
         updateAttributeTxt(_captain2,_loc3_,param2.Captain,getAdd(param2.Captain,param1),getNewAdd(param2.Captain,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13");
         updateAttributeTxt(_attack2,_loc3_,param2.Attack,getAdd(param2.Attack,param1),getNewAdd(param2.Attack,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
         updateAttributeTxt(_magicAttack2,_loc3_,param2.MagicAttack,getAdd(param2.MagicAttack,param1),getNewAdd(param2.MagicAttack,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14");
         updateAttributeTxt(_defence2,_loc3_,param2.Defence,getAdd(param2.Defence,param1),getNewAdd(param2.Defence,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16");
         updateAttributeTxt(_magicDefence2,_loc3_,param2.MagicDefence,getAdd(param2.MagicDefence,param1),getNewAdd(param2.MagicDefence,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19");
         updateAttributeTxt(_parry2,_loc3_,param2.Parry,getAdd(param2.Parry,param1),getNewAdd(param2.Parry,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
         updateAttributeTxt(_live2,_loc3_,param2.Live,getAdd(param2.Live,param1),getNewAdd(param2.Live,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10");
         updateAttributeTxt(_forceHit2,_loc3_,param2.ForceHit,getAdd(param2.ForceHit,param1),getNewAdd(param2.ForceHit,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip17");
         updateAttributeTxt(_conat2,_loc3_,param2.Conat,getAdd(param2.Conat,param1),getNewAdd(param2.Conat,param1));
      }
      
      private function updateAttributeTxt(param1:PetEquipStrengAttributeTxt, param2:String, param3:int, param4:int, param5:int = 0) : void
      {
         if(param2 != "" && param3 > 0)
         {
            if(param5 == 0)
            {
               param2 += "+" + (param3 + param4);
               _currAttributeSprite.addChild(param1);
               param1.setTxtAndFlag(param2,false);
            }
            else
            {
               _nextAttributeSprite.addChild(param1);
               param2 += "+" + (param3 + param4) + " <font color=\'#00FF00\'>" + param5 + "</font>";
               param1.setTxtAndFlag(param2,true);
            }
         }
      }
      
      private function __showEffect(param1:NotificationEvent) : void
      {
         var _loc2_:GoodsInfo = param1.data as GoodsInfo;
         if(_loc2_ && _loc2_.templateInfo.MasterType == 5)
         {
            _strengItem.setSelectedEff();
         }
      }
      
      private function __hideEffect(param1:NotificationEvent) : void
      {
         _strengItem.setNotSelectedEff();
      }
      
      private function getAdd(param1:int, param2:GoodsInfo) : int
      {
         return GoodsHelp.getPetEquipStrengAddition(param1,param2.mouldGrade);
      }
      
      private function clearVbox() : void
      {
         while(_currAttributeSprite.numChildren)
         {
            _currAttributeSprite.removeChildAt(_currAttributeSprite.numChildren - 1);
         }
         while(_nextAttributeSprite.numChildren)
         {
            _nextAttributeSprite.removeChildAt(_nextAttributeSprite.numChildren - 1);
         }
      }
      
      private function getNewAdd(param1:int, param2:GoodsInfo) : int
      {
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.mouldGrade = param2.mouldGrade - 1;
         return getAdd(param1,param2) - getAdd(param1,_loc3_);
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

