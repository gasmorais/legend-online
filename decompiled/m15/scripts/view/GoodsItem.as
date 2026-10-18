package view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.data.FarmInfo;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import managers.PlayerCurrencyManager;
   import managers.ShopManager;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.currency.PlayerCurrencyInfo;
   import mvc.module.pet.PetData;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaNewBossManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.HonorHelper;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.tips.MessageTipManager;
   
   public class GoodsItem extends Sprite implements Disposeable
   {
      
      protected var _bg:ScaleFrameImage;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _valueTxt:FilterFrameText;
      
      protected var _goods:BaseItemView;
      
      protected var _lookBtn:TextButton;
      
      protected var _buyBtn:IconButton;
      
      protected var _tips:FilterFrameText;
      
      protected var _lineImg:ScaleFrameImage;
      
      protected var _data:ShopGoodsInfo;
      
      protected var _filter:IFilterFormat;
      
      protected var _hasOwnTxt:FilterFrameText;
      
      private var _flag:ScaleFrameImage;
      
      public function GoodsItem()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _filter = new UIFilter();
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsNameTextStyle");
         _hasOwnTxt = ComponentFactory.Instance.creatComponentByStylename("shop.hasOwnTxt");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("shop.ItemContributeTxtImg");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsValueTextStyle");
         _tips = ComponentFactory.Instance.creatComponentByStylename("shop.ItemShopTipsTextStyle");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("core.TryOnButton");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ItemBuyBtn");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.ItemBaseItemView");
         _bg.setFrame(1);
         _lookBtn.visible = false;
         _lookBtn.text = LanguageMgr.GetTranslation("view.GoodsItem3.tryOnBtn.text");
         addChild(_bg);
         addChild(_lineImg);
         addChild(_nameTxt);
         addChild(_tips);
         addChild(_valueTxt);
         addChild(_buyBtn);
         addChild(_goods);
      }
      
      protected function addEvent() : void
      {
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         this.addEventListener("click",__clickHandler);
         NotificationManager.instance.addEventListener("SHOP_TIME_GIFT_REFRESH",__refreshHandler);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         this.removeEventListener("click",__clickHandler);
         NotificationManager.instance.removeEventListener("SHOP_TIME_GIFT_REFRESH",__refreshHandler);
      }
      
      private function __refreshHandler(param1:NotificationEvent) : void
      {
         if(_data && param1.data.goodId == _data.Id)
         {
            _data.OneCurrentCount = param1.data.count;
            updateLimit(param1.data.count);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(param1.target == _buyBtn)
         {
            __onBuyBtnHandler(param1);
         }
         else if(isFashion)
         {
            __onLookBtnHandler(param1);
         }
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            _bg.setFrame(2);
         }
         if(_lookBtn && isFashion)
         {
            _lookBtn.visible = true;
         }
      }
      
      protected function __outHandler(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
         if(_lookBtn)
         {
            _lookBtn.visible = false;
         }
      }
      
      protected function __onLookBtnHandler(param1:MouseEvent) : void
      {
         if(isFashion)
         {
            FrameControllerManager.instance.fashionCodeController.model.tryOnShopInfo = _data;
            ShopManager.Instance.model.switchToFashionTab();
         }
      }
      
      protected function get isFashion() : Boolean
      {
         if(!_data)
         {
            return false;
         }
         if(!TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.ItemId))
         {
            return false;
         }
         switch(int(TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.ItemId).SonType) - 109)
         {
            case 0:
               return true;
            case 1:
               return true;
            case 2:
               return true;
            case 3:
               return true;
            default:
               return false;
         }
      }
      
      private function buyWingFunction(param1:Vector.<ShopGoodsInfo>) : void
      {
         __onBuyBtnHandler(null);
      }
      
      protected function __onBuyBtnHandler(param1:MouseEvent) : void
      {
         var _loc5_:GoodsTemplateInfo = null;
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         if(!_data)
         {
            return;
         }
         var _loc6_:PlayerCurrencyInfo = PlayerCurrencyManager.instance.currencyInfo;
         if(_data.ShopType == 3)
         {
            _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.ItemId);
            if(_loc5_ && _loc5_.MasterType == 1)
            {
               _loc2_ = Boolean(GoodsManager.instance.checkExistGoodsByTempIdInAllBag(_loc5_.TemplateId));
               if(_loc2_)
               {
                  SimpleAlertHelper.instance.data = [conformBuy];
                  _loc3_ = LanguageMgr.GetTranslation("public.confirm");
                  _loc4_ = LanguageMgr.GetTranslation("public.cancel");
                  _loc7_ = LanguageMgr.GetTranslation("public.prompt");
                  _loc8_ = LanguageMgr.GetTranslation("public.ShopExistGoods");
                  SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc3_,_loc4_,true);
                  return;
               }
            }
         }
         else
         {
            if(_data.ShopType == 2)
            {
               ShopManager.Instance.type = 2;
               ShopManager.Instance.currBuyGoods = null;
               ShopManager.Instance.currBuyGoods2 = _data;
               ShopManager.Instance.getGoodsBuyNum(_data.Id,0,false);
               return;
            }
            if(_data.ShopType == 17)
            {
               ShopManager.Instance.type = 17;
               ShopManager.Instance.currBuyGoods = null;
               ShopManager.Instance.currBuyGoods2 = _data;
               ShopManager.Instance.getGoodsBuyNum(_data.Id,0,false);
               return;
            }
            if(_data.ShopType == 1004)
            {
               ShopManager.Instance.type = 1004;
               ShopManager.Instance.currBuyGoods = null;
               ShopManager.Instance.currBuyGoods2 = _data;
               ShopManager.Instance.getGoodsBuyNum(_data.Id,0,false);
               return;
            }
            if(_data.ShopType == 1005)
            {
               ShopManager.Instance.type = 1005;
               ShopManager.Instance.currBuyGoods = null;
               ShopManager.Instance.currBuyGoods2 = _data;
               ShopManager.Instance.getGoodsBuyNum(_data.Id,0,false);
               return;
            }
            if(_data.ShopType == 20)
            {
               ShopManager.Instance.type = 20;
               ShopManager.Instance.currBuyGoods = null;
               ShopManager.Instance.currBuyGoods2 = _data;
               ShopManager.Instance.getGoodsBuyNum(_data.Id,0,false);
               return;
            }
            if(_data.ShopType == 1034)
            {
               ShopManager.Instance.type = 1034;
               ShopManager.Instance.currBuyGoods = null;
               ShopManager.Instance.currBuyGoods2 = _data;
               ShopManager.Instance.getGoodsBuyNum(_data.Id,_data.ShopType,false);
               return;
            }
            if(_data.ShopType == 1008)
            {
               ShopManager.Instance.type = 1008;
               ShopManager.Instance.currBuyGoods = null;
               ShopManager.Instance.currBuyGoods2 = _data;
               ShopManager.Instance.getGoodsBuyNum(_data.Id,0,false);
               return;
            }
            if(_data.ShopType == 1009)
            {
               ShopManager.Instance.type = 1009;
               ShopManager.Instance.currBuyGoods = null;
               ShopManager.Instance.currBuyGoods2 = _data;
               ShopManager.Instance.getGoodsBuyNum(_data.Id,0,false);
               return;
            }
            if(_data.ShopType == 1010)
            {
               ShopManager.Instance.type = 1010;
               ShopManager.Instance.currBuyGoods = null;
               ShopManager.Instance.currBuyGoods2 = _data;
               ShopManager.Instance.getGoodsBuyNum(_data.Id,0,false);
               return;
            }
            if(_data.ShopType == 1011)
            {
               ShopManager.Instance.type = 1011;
               ShopManager.Instance.currBuyGoods = null;
               ShopManager.Instance.currBuyGoods2 = _data;
               ShopManager.Instance.getGoodsBuyNum(_data.Id,0,false);
               return;
            }
            if(_data.ShopType == 1012)
            {
               ShopManager.Instance.type = 1012;
               ShopManager.Instance.currBuyGoods = null;
               ShopManager.Instance.currBuyGoods2 = _data;
               ShopManager.Instance.getGoodsBuyNum(_data.Id,0,false);
               return;
            }
            if(_data.ShopType == 1014)
            {
               ShopManager.Instance.type = 1014;
               ShopManager.Instance.currBuyGoods = null;
               ShopManager.Instance.currBuyGoods2 = _data;
               ShopManager.Instance.getGoodsBuyNum(_data.Id,0,false);
               return;
            }
            if(_data.ShopType == 1027)
            {
               ShopManager.Instance.type = 1027;
               ShopManager.Instance.currBuyGoods = null;
               ShopManager.Instance.currBuyGoods2 = _data;
               ShopManager.Instance.getGoodsBuyNum(_data.Id,1027,false);
               return;
            }
            if(_data.ShopType == 10)
            {
               if(_loc6_.aresHeart.amount < _data.price)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.aresHeartTip"));
                  return;
               }
            }
            else if(_data.ShopType == 16)
            {
               if(_loc6_.athenaTear.amount < _data.price)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.resourcebar.view.quickbuy.QuickBuyFrame.athenaTearTip"));
                  return;
               }
            }
            else if(_data.ShopType == 1018)
            {
               if(_loc6_.airGardenPropCoin.amount < _data.price)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("quickbuy.QuickBuyFrame.noAirGardenPropCoinAlert"));
                  return;
               }
            }
            else if(_data.ShopType == 1020)
            {
               if(_loc6_.flameTempleCoin.amount < _data.price)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("quickbuy.QuickBuyFrame.noFlameTempleCoinAlert"));
                  return;
               }
            }
            else if(_data.ShopType == 1021)
            {
               if(_loc6_.duskAreaCoin.amount < _data.price)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("quickbuy.QuickBuyFrame.noDuskAreaAlert"));
                  return;
               }
            }
            else if(_data.ShopType == 1023)
            {
               if(_loc6_.darkmazeSoulCoin.amount < _data.price)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("quickbuy.QuickBuyFrame.noDarkMazeCoinAlert"));
                  return;
               }
            }
            else
            {
               if(_data.ShopType == 1029)
               {
                  ShopManager.Instance.type = 1029;
                  ShopManager.Instance.currBuyGoods = null;
                  ShopManager.Instance.currBuyGoods2 = _data;
                  ShopManager.Instance.getGoodsBuyNum(_data.Id,1029,false);
                  return;
               }
               if(_data.ShopType == 1030)
               {
                  ShopManager.Instance.type = 1030;
                  ShopManager.Instance.currBuyGoods = null;
                  ShopManager.Instance.currBuyGoods2 = _data;
                  ShopManager.Instance.getGoodsBuyNum(_data.Id,1030,false);
                  return;
               }
               if(_data.ShopType == 1031)
               {
                  ShopManager.Instance.type = 1031;
                  ShopManager.Instance.currBuyGoods = null;
                  ShopManager.Instance.currBuyGoods2 = _data;
                  ShopManager.Instance.getGoodsBuyNum(_data.Id,1031,false);
                  return;
               }
               if(_data.ShopType == 1031)
               {
                  ShopManager.Instance.type = 1031;
                  ShopManager.Instance.currBuyGoods = null;
                  ShopManager.Instance.currBuyGoods2 = _data;
                  ShopManager.Instance.getGoodsBuyNum(_data.Id,1031,false);
                  return;
               }
            }
         }
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
      }
      
      private function quickUIcallback() : void
      {
         var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         _loc1_.data(_data);
         _loc1_.show();
      }
      
      private function conformBuy(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
         }
      }
      
      public function get data() : ShopGoodsInfo
      {
         return _data;
      }
      
      public function set data(param1:ShopGoodsInfo) : void
      {
         var _loc2_:String = null;
         _data = param1;
         buttonMode = isFashion;
         if(param1)
         {
            _loc2_ = "shop.ItemGoodsNameTextStyle2_t";
            if(param1.PayType == 1022 && _nameTxt.textFormatStyle != _loc2_)
            {
               _nameTxt.textFormatStyle = _loc2_;
               _nameTxt.x = 85;
               _nameTxt.wordWrap = true;
               _nameTxt.height = 40;
            }
            addEvent();
            setHasOwn(_data);
            updateLimit();
            _nameTxt.text = getName();
            setPosition();
            _nameTxt.visible = true;
            _valueTxt.text = _data.price + "";
            setFilter();
         }
         else
         {
            clean();
            removeEvent();
            if(_hasOwnTxt)
            {
               _hasOwnTxt.text = "";
            }
         }
      }
      
      private function setPosition() : void
      {
         if(_nameTxt.text.length > 30)
         {
            _nameTxt.text = _nameTxt.text.substr(0,29) + "...";
         }
         if(_nameTxt.numLines > 1)
         {
            _nameTxt.y = 10;
         }
         else
         {
            _nameTxt.y = 21;
         }
      }
      
      public function setHasOwn(param1:ShopGoodsInfo) : void
      {
         var _loc3_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:PetData = null;
         var _loc5_:Boolean = false;
         var _loc4_:int = int(param1.ItemId);
         var _loc7_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_);
         var _loc2_:int = int(_loc7_.SonType);
         var _loc6_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         if(!_hasOwnTxt)
         {
            return;
         }
         _hasOwnTxt.text = "";
         switch(_loc2_)
         {
            case 211:
               if(_loc6_.composeList.indexOf(_loc7_.Property1) > 0)
               {
                  _hasOwnTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.ComposeTip.vStudy");
                  addChild(_hasOwnTxt);
               }
               break;
            case 218:
               if(MountsManager.instance.avatarList.isLightTemplate(_loc7_.Property1))
               {
                  _hasOwnTxt.text = LanguageMgr.GetTranslation("Task.view.GoodsItem.hasOwnTxt.text");
                  addChild(_hasOwnTxt);
               }
               break;
            case 303:
               _loc3_ = _loc6_.petList;
               _loc8_ = 0;
               while(_loc8_ < _loc3_.length)
               {
                  _loc9_ = _loc3_[_loc8_] as PetData;
                  _loc5_ = Boolean(_loc9_.checkSkillIsLearned(_loc7_.Property1));
                  if(_loc5_)
                  {
                     _hasOwnTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.ComposeTip.vStudy");
                     addChild(_hasOwnTxt);
                     break;
                  }
                  _loc8_++;
               }
         }
      }
      
      private function updateLimit(param1:int = 0) : void
      {
         if(_data.ShopType == 1027 || _data.ShopType == 1031)
         {
            if(_data.VIP0Count > 0)
            {
               _hasOwnTxt.text = LanguageMgr.GetTranslation("ui.theseuspvp.seasonLimit");
               addChild(_hasOwnTxt);
            }
         }
      }
      
      private function setFlag(param1:int = 0) : void
      {
         if(param1 > 0)
         {
            _flag = ComponentFactory.Instance.creatComponentByStylename("shop.ItemLabel");
            addChild(_flag);
            _flag.mouseChildren = _flag.mouseEnabled = false;
            _flag.setFrame(param1 + 1);
         }
      }
      
      protected function setFilter() : void
      {
         var _loc1_:UpgradeTemplateInfo = null;
         var _loc2_:GoodsTemplateInfo = null;
         if(_data.ShopType == 2 || _data.ShopType == 17 || _data.ShopType == 1009)
         {
            if(_data.NeedConsortiaLevels > consortiaInfo.shopLevel)
            {
               _tips.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaShopGoodsItem.tips",_data.NeedConsortiaLevels);
            }
            else
            {
               _tips.text = "";
            }
         }
         else if(_data.ShopType == 6)
         {
            if(_data.NeedGrades > farmInfo.grade)
            {
               _tips.text = LanguageMgr.GetTranslation("farm.view.FarmShopItem.needGradeTip",_data.NeedGrades);
            }
            else
            {
               _tips.text = "";
            }
         }
         else if(_data.ShopType == 3 || _data.ShopType == 10 || _data.ShopType == 16 || _data.ShopType == 1020 || _data.ShopType == 1021)
         {
            _loc1_ = HonorHelper.getHonorNameByValue(_data.NeedGeste);
            if(_data.NeedGeste > thane.honer)
            {
               _tips.text = LanguageMgr.GetTranslation("room.view.pvp.PVPShop.Condition",_loc1_.TemplateName);
            }
            else
            {
               _tips.text = "";
            }
         }
         else if(_data.ShopType == 4)
         {
            _tips.text = "";
            if(_data.MazeLayers > PlayerManager.instance.currentPlayerModel.towerInfo1.maxIndex)
            {
               _tips.text = LanguageMgr.GetTranslation("maze.shop.tips",_data.MazeLayers);
            }
            if(_data.MazeLayers2 > PlayerManager.instance.currentPlayerModel.towerInfo2.maxIndex)
            {
               _tips.text = LanguageMgr.GetTranslation("maze.shop.tips2",_data.MazeLayers2);
            }
         }
         else if(_data.ShopType == 1024)
         {
            _tips.text = "";
            if(_data.MazeLayers > ConsortiaNewBossManager.instance.model.passLevel || !isGradeFix(_data))
            {
               if(_data.NeedMinGrade == 0)
               {
                  _tips.text = LanguageMgr.GetTranslation("consortiaNewShop.shop.tips0",_data.MazeLayers);
               }
               else if(_data.NeedMinGrade == 81)
               {
                  _tips.text = LanguageMgr.GetTranslation("consortiaNewShop.shop.tips1",1,_data.MazeLayers);
               }
               else if(_data.NeedMinGrade == 161)
               {
                  _tips.text = LanguageMgr.GetTranslation("consortiaNewShop.shop.tips1",2,_data.MazeLayers);
               }
               else if(_data.NeedMinGrade == 241)
               {
                  _tips.text = LanguageMgr.GetTranslation("consortiaNewShop.shop.tips1",3,_data.MazeLayers);
               }
            }
         }
         else
         {
            _tips.text = "";
         }
         if(_tips.text != "")
         {
            _filter.setGrayFilter(_nameTxt);
            _filter.setGrayFilter(_goods);
            _buyBtn.visible = false;
            _lineImg.visible = false;
            _valueTxt.visible = false;
         }
         else
         {
            _filter.setNormalFilter(_nameTxt);
            _filter.setNormalFilter(_goods);
            _lineImg.setFrame(_data.PayType);
            _lineImg.tipData = null;
            _loc2_ = null;
            if(_data.PayType == 8)
            {
               _buyBtn.iconStyle = "asset.core.shopExchangeText";
            }
            else if(_data.PayType == 17)
            {
               _lineImg.tipData = LanguageMgr.GetTranslation("tips.pokerScoreTip.StripView");
            }
            else if(_data.PayType == 18)
            {
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-3400);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 19)
            {
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-3800);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 12)
            {
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-1400);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 5)
            {
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208001);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 11)
            {
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-1100);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 15)
            {
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-1500);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 16)
            {
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-1600);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 7)
            {
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-3500);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 10)
            {
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-3600);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 13)
            {
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-3700);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 20)
            {
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-3900);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 21)
            {
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-4100);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 22)
            {
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-4200);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 28)
            {
               _lineImg.setFrame(23);
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-4400);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 2001)
            {
               _lineImg.setFrame(24);
            }
            else if(_data.PayType == 25)
            {
               _lineImg.setFrame(25);
            }
            else if(_data.PayType == 29)
            {
               _lineImg.setFrame(26);
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-4700);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 30)
            {
               _lineImg.setFrame(27);
               _lineImg.x = 196;
               _lineImg.y = 50;
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-4800);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 31)
            {
               _lineImg.setFrame(28);
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-2900);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 32)
            {
               _lineImg.setFrame(29);
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-4900);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 33)
            {
               _lineImg.setFrame(30);
               _lineImg.y = 51;
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-5000);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 37)
            {
               _lineImg.setFrame(32);
               _lineImg.x = 196;
               _lineImg.y = 54;
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208080);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 38)
            {
               _lineImg.setFrame(33);
               _lineImg.x = 196;
               _lineImg.y = 54;
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208081);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 1022)
            {
               _lineImg.setFrame(34);
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-16000);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 39)
            {
               _lineImg.setFrame(35);
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-17000);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 40)
            {
               _lineImg.setFrame(36);
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-18000);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 1034)
            {
               _lineImg.setFrame(43);
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-5000);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 41)
            {
               _lineImg.setFrame(37);
               _lineImg.y = 49;
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(7640001);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 44)
            {
               _lineImg.setFrame(40);
               _lineImg.y = 49;
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-21000);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 45)
            {
               _lineImg.setFrame(41);
               _lineImg.y = 49;
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-23000);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else if(_data.PayType == 46)
            {
               _lineImg.setFrame(42);
               _lineImg.y = 49;
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(7650001);
               if(_loc2_)
               {
                  _lineImg.tipData = _loc2_.Description;
               }
            }
            else
            {
               _buyBtn.iconStyle = "asset.core.ShopBuyTxt";
            }
            _buyBtn.visible = true;
            _lineImg.visible = true;
            _valueTxt.visible = true;
            if(_data.ShopType == 4)
            {
               _valueTxt.x = 109;
               _lineImg.x = 184;
            }
            else if(_data.ShopType == 3)
            {
               _lineImg.x = 194;
            }
            else if(_data.ShopType == 10)
            {
               _lineImg.x = 194;
               _lineImg.y = 53;
            }
            else if(_data.ShopType == 13 || _data.ShopType == 1010 || _data.ShopType == 1011 || _data.ShopType == 1012)
            {
               _lineImg.x = 194;
               _lineImg.y = 51;
            }
            else if(_data.ShopType == 35)
            {
               _lineImg.x = 194;
               _lineImg.y = 50;
            }
            else if(_data.ShopType == 1014)
            {
               _lineImg.x = 194;
               _lineImg.y = 50;
               _valueTxt.x = 120;
               _valueTxt.y = 52;
            }
            else if(_data.ShopType == 17 || _data.ShopType == 1009)
            {
               _lineImg.y = 56;
               _valueTxt.x = 120;
               _valueTxt.y = 52;
            }
            else if(_data.ShopType == 2)
            {
               _lineImg.y = 56;
               _valueTxt.x = 75;
               _valueTxt.y = 52;
            }
         }
      }
      
      private function isGradeFix(param1:ShopGoodsInfo) : Boolean
      {
         var _loc2_:Boolean = false;
         if(thane.isAvenger)
         {
            _loc2_ = true;
         }
         else if(thane.isChangeJob && param1.NeedMinGrade <= 161)
         {
            _loc2_ = true;
         }
         else if(thane.vocationGrades > 0 && thane.vocationIndex == 0 && param1.NeedMinGrade <= 81)
         {
            _loc2_ = true;
         }
         else if((thane.vocationGrades < 0 || thane.vocationGrades == 0) && param1.NeedMinGrade < 81)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return FrameControllerManager.instance.consortiaController.model.consortiaInfo;
      }
      
      private function get farmInfo() : FarmInfo
      {
         return FarmManager.instance.model.myFarm;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function getName() : String
      {
         var _loc1_:* = null;
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = _data.ItemId;
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.ItemId);
         if(!_loc2_)
         {
            _data = null;
            return LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaShopGoodsItem.noFindGoods");
         }
         _loc3_.validDate = _data.ValidDate;
         _goods.data = _loc3_;
         return _loc2_.TemplateName;
      }
      
      protected function clean() : void
      {
         _nameTxt.visible = false;
         _valueTxt.visible = false;
         if(_lookBtn)
         {
            _lookBtn.visible = false;
         }
         _buyBtn.visible = false;
         _lineImg.visible = false;
         _goods.data = null;
         _tips.text = "";
      }
      
      public function dispose() : void
      {
         removeEvent();
         _filter = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_valueTxt);
         _valueTxt = null;
         ObjectUtils.disposeObject(_goods);
         _goods = null;
         ObjectUtils.disposeObject(_lookBtn);
         _lookBtn = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_tips);
         _tips = null;
         ObjectUtils.disposeObject(_lineImg);
         _lineImg = null;
         ObjectUtils.disposeObject(_hasOwnTxt);
         _hasOwnTxt = null;
         ObjectUtils.disposeObject(_flag);
         _flag = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

