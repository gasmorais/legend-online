package view.subshop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.FarmModel;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.frame.BuyFrameI;
   
   public class FarmShopItem extends Sprite implements Disposeable
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _buffTxt:FilterFrameText;
      
      private var _priceTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _profitTxt:FilterFrameText;
      
      private var _unReachTxt:FilterFrameText;
      
      private var _priceUnitImg:Bitmap;
      
      private var _buyBtn:IconButton;
      
      private var _filter:UIFilter;
      
      private var _data:ShopGoodsInfo;
      
      private var _tempStr:String = "";
      
      private var _smallPointImg:Bitmap;
      
      public function FarmShopItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("farm.FarmShopItemNameTxt");
         _buffTxt = ComponentFactory.Instance.creatComponentByStylename("farm.FarmShopItemBuffTxt");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("farm.FarmShopItemPriceTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("farm.FarmShopItemTimeTxt");
         _profitTxt = ComponentFactory.Instance.creatComponentByStylename("farm.FarmShopItemProfitTxt");
         _unReachTxt = ComponentFactory.Instance.creatComponentByStylename("farm.FarmShopItemUnreachTxt");
         _priceUnitImg = ComponentFactory.Instance.creatBitmap("asset.core.GoldIcon");
         _smallPointImg = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("farm.FarmShopItemBuyBtn");
         _filter = new UIFilter();
         _priceUnitImg.x = 254;
         _priceUnitImg.y = 9;
         _smallPointImg.x = 194;
         _smallPointImg.y = 9;
         _smallPointImg.visible = false;
         addChild(_nameTxt);
         addChild(_buffTxt);
         addChild(_timeTxt);
         addChild(_profitTxt);
      }
      
      private function addEvent() : void
      {
         _buyBtn.addEventListener("click",__buyClick);
      }
      
      private function removeEvent() : void
      {
         _buyBtn.removeEventListener("click",__buyClick);
      }
      
      private function __buyClick(param1:MouseEvent) : void
      {
         if(_data)
         {
            CheckUIModuleUtil.instance.tryCall("quickbuy",showBuyFrameCall,[_data]);
         }
      }
      
      private function showBuyFrameCall(param1:Array) : void
      {
         var _loc2_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         _loc2_.data(param1[0]);
         _loc2_.show();
      }
      
      public function set data(param1:ShopGoodsInfo) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         refreshView();
         _nameTxt.numLines == 2 ? (_nameTxt.y = 10) : (Number(_nameTxt.y = 18));
      }
      
      public function refreshView() : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc1_:GoodsTemplateInfo = null;
         if(_data)
         {
            _loc3_ = new GoodsInfo();
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.ItemId);
            _loc3_.templateId = _data.ItemId;
            if(!_loc2_)
            {
               clean();
               _nameTxt.text = LanguageMgr.GetTranslation("pvp.view.PvPShopItem.name");
               _nameTxt.setFrame(1);
               return;
            }
            _nameTxt.text = _loc2_.TemplateName;
            _nameTxt.setFrame(_loc2_.Profile);
            if(int(_loc2_.Property1 / 60) <= 0)
            {
               _tempStr = LanguageMgr.GetTranslation("public.needMinutes",_loc2_.Property1 % 60);
            }
            else if(_loc2_.Property1 % 60 == 0)
            {
               _tempStr = int(_loc2_.Property1 / 60) + LanguageMgr.GetTranslation("public.time.hour");
            }
            else
            {
               _tempStr = LanguageMgr.GetTranslation("public.needHM",int(_loc2_.Property1 / 60),_loc2_.Property1 % 60);
            }
            _timeTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SeedTip.matureTime1",_tempStr);
            if(int(_loc2_.Property1 / 60) == 0)
            {
               _timeTxt.text = "";
            }
            _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.Property2);
            if(_loc1_)
            {
               _tempStr = _loc2_.Property3 + _loc1_.TemplateName;
            }
            else
            {
               _tempStr = _loc2_.Property3.toString();
            }
            _profitTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SeedTip.output1",_tempStr);
            if(_loc2_.Property3 == 0)
            {
               _profitTxt.text = "";
            }
            if(model.myFarm.grade < _data.NeedGrades)
            {
               _unReachTxt.text = LanguageMgr.GetTranslation("farm.view.FarmShopItem.needGradeTip",_data.NeedGrades);
               setUnreachView(true);
            }
            else
            {
               setUnreachView(false);
            }
            if(_data.GiftToken > 0)
            {
               _priceTxt.text = String(_data.GiftToken);
            }
            else
            {
               _priceTxt.text = String(_data.Gold);
            }
         }
         else
         {
            clean();
         }
      }
      
      private function setUnreachView(param1:Boolean) : void
      {
         if(param1)
         {
            if(_buyBtn.parent)
            {
               _buyBtn.parent.removeChild(_buyBtn);
            }
            _filter.setGrayFilter(_nameTxt);
            _filter.setGrayFilter(_timeTxt);
            _filter.setGrayFilter(_profitTxt);
            addChild(_unReachTxt);
         }
         else
         {
            if(_unReachTxt.parent)
            {
               _unReachTxt.parent.removeChild(_unReachTxt);
            }
            _filter.setNormalFilter(_nameTxt);
            _filter.setNormalFilter(_timeTxt);
            _filter.setNormalFilter(_profitTxt);
            addChild(_buyBtn);
         }
         addChild(_priceTxt);
         addChild(_priceUnitImg);
         addChild(_smallPointImg);
         if(_data.GiftToken > 0)
         {
            _smallPointImg.visible = true;
            _priceUnitImg.visible = false;
         }
         else
         {
            _smallPointImg.visible = false;
            _priceUnitImg.visible = true;
         }
      }
      
      private function clean() : void
      {
         _nameTxt.text = "";
         _priceTxt.text = "";
         _timeTxt.text = "";
         _profitTxt.text = "";
         _unReachTxt.text = "";
         if(_priceUnitImg && _priceUnitImg.parent)
         {
            _priceUnitImg.parent.removeChild(_priceUnitImg);
         }
         if(_smallPointImg && _smallPointImg.parent)
         {
            _smallPointImg.parent.removeChild(_smallPointImg);
         }
         if(_buyBtn && _buyBtn.parent)
         {
            _buyBtn.parent.removeChild(_buyBtn);
         }
      }
      
      private function get model() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeObject(_priceUnitImg);
         _priceUnitImg = null;
         ObjectUtils.disposeObject(_smallPointImg);
         _smallPointImg = null;
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(_buffTxt)
         {
            _buffTxt.dispose();
         }
         _buffTxt = null;
         if(_priceTxt)
         {
            _priceTxt.dispose();
         }
         _priceTxt = null;
         if(_timeTxt)
         {
            _timeTxt.dispose();
         }
         _timeTxt = null;
         if(_profitTxt)
         {
            _profitTxt.dispose();
         }
         _profitTxt = null;
         if(_unReachTxt)
         {
            _unReachTxt.dispose();
         }
         _unReachTxt = null;
         if(_buyBtn)
         {
            _buyBtn.dispose();
         }
         _buyBtn = null;
         _filter = null;
         _data = null;
         _tempStr = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

