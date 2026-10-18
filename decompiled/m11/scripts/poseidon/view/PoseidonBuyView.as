package poseidon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import managers.PoseidonManager;
   import mvc.module.poseidon.PoseidonGoodInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.PoseidonShopTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PoseidonBuyView extends Sprite
   {
      
      public var _buyBack:Bitmap;
      
      public var _buyConfrim:IconButton;
      
      public var _buyNumBack:Image;
      
      public var _buyPriceBack:Image;
      
      public var _buyIcon:BaseIconView;
      
      public var _buyName:FilterFrameText;
      
      public var _buyNumTxt:FilterFrameText;
      
      public var _buyPriceTxt:FilterFrameText;
      
      public var _buyPriceIcon:ScaleFrameImage;
      
      public var _buyAdd:BaseButton;
      
      public var _buyReduce:BaseButton;
      
      public var _buyNumTxtIn:FilterFrameText;
      
      public var _buyPriceTxtIn:FilterFrameText;
      
      private var _info:PoseidonShopTempInfo;
      
      private var _buyNum:int = 1;
      
      private var _limit:int;
      
      private var _limitTxt:FilterFrameText;
      
      private var _limitTip:ScaleFrameImage;
      
      public function PoseidonBuyView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _buyBack = ComponentFactory.Instance.creatBitmap("asset.poseridon.buyFrameBack");
         _buyConfrim = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.buyConfrim");
         _buyNumBack = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.buyNumBack");
         _buyPriceBack = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.buyPriceBack");
         _buyIcon = ComponentFactory.Instance.creatCustomObject("ui.poseidonshop.buyIcon");
         _buyName = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.buyName");
         _buyNumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.buyNumTxt");
         _buyPriceTxt = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.buyPriceTxt");
         _buyPriceIcon = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.buyPriceIcon");
         _buyAdd = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.buyAdd");
         _buyReduce = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.buyReduce");
         _buyNumTxtIn = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.buyNumTxtIn");
         _buyPriceTxtIn = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.buyPriceTxtIn");
         _limitTxt = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.buy.limit");
         _limitTip = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.buy.limitTip");
         addChild(_buyBack);
         addChild(_buyConfrim);
         addChild(_buyNumBack);
         addChild(_buyIcon);
         addChild(_buyName);
         addChild(_buyNumTxt);
         addChild(_buyPriceTxt);
         addChild(_buyPriceIcon);
         addChild(_buyAdd);
         addChild(_buyReduce);
         addChild(_buyNumTxtIn);
         addChild(_buyPriceTxtIn);
         addChild(_limitTxt);
         addChild(_limitTip);
         _buyNumTxt.text = LanguageMgr.GetTranslation("poseidon.shop.buyNum");
         _buyPriceTxt.text = LanguageMgr.GetTranslation("poseidon.shop.buyPrice");
      }
      
      public function set info(param1:PoseidonShopTempInfo) : void
      {
         var _loc3_:GoodsTemplateInfo = null;
         var _loc4_:PoseidonGoodInfo = null;
         var _loc2_:int = 0;
         _info = param1;
         if(_info)
         {
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_info.ItemId);
            if(_loc3_)
            {
               _buyName.text = _loc3_.TemplateName;
            }
            _buyIcon.icon = IconFactory.getGoodsIconByTID(_info.ItemId);
            _buyPriceIcon.setFrame(_info.ShopType);
            _loc4_ = PoseidonManager.Ins.model.getGoodInfo(_info.Id);
            if(_info.ShopType == 1)
            {
               _limit = PlayerCurrencyManager.instance.currencyInfo.poseidonCoin.amount / _info.Price;
            }
            else if(_info.ShopType == 2)
            {
               _limit = PlayerManager.instance.currentPlayerModel.playerInfo.point / _info.Price;
            }
            _loc2_ = int(_info.LimitNumber);
            if(_loc4_)
            {
               _loc2_ -= _loc4_.buyCount;
               if(_loc2_ < 0)
               {
                  _loc2_ = 0;
               }
               _limitTxt.text = _loc4_.buyCount + "/" + _info.LimitNumber;
            }
            else
            {
               _limitTxt.text = "0/" + _info.LimitNumber;
            }
            if(_limit > _loc2_)
            {
               _limit = _loc2_;
            }
            _limitTip.setFrame(_info.LimitType);
            buyNumChangeHandler();
         }
      }
      
      private function initEvent() : void
      {
         _buyAdd.addEventListener("click",addHandler);
         _buyReduce.addEventListener("click",reduceHandler);
         if(_buyNumTxtIn)
         {
            _buyNumTxtIn.addEventListener("change",__buyNumChange);
         }
      }
      
      private function removeEvent() : void
      {
         _buyAdd.removeEventListener("click",addHandler);
         _buyReduce.removeEventListener("click",reduceHandler);
         if(_buyNumTxtIn)
         {
            _buyNumTxtIn.removeEventListener("change",__buyNumChange);
         }
      }
      
      private function __buyNumChange(param1:Event) : void
      {
         _buyNum = int(_buyNumTxtIn.text);
         buyNumChangeHandler();
      }
      
      private function buyNumChangeHandler() : void
      {
         if(_buyNum > _limit)
         {
            _buyNum = _limit;
         }
         if(_buyNum < 0)
         {
            _buyNum = 0;
         }
         _buyNumTxtIn.text = "" + _buyNum;
         _buyNum <= 1 ? (_buyReduce.enable = false) : (Boolean(_buyReduce.enable = true));
         _buyNum >= _limit ? (_buyAdd.enable = false) : (Boolean(_buyAdd.enable = true));
         _buyConfrim.enable = _buyNum > 0 ? true : false;
         _buyPriceTxtIn.text = _buyNum * _info.Price + "";
      }
      
      private function reduceHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _buyNum = _buyNum - 1;
         buyNumChangeHandler();
      }
      
      private function addHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _buyNum = _buyNum + 1;
         buyNumChangeHandler();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_buyBack);
         _buyBack = null;
         ObjectUtils.disposeObject(_buyConfrim);
         _buyConfrim = null;
         ObjectUtils.disposeObject(_buyNumBack);
         _buyNumBack = null;
         ObjectUtils.disposeObject(_buyPriceBack);
         _buyPriceBack = null;
         ObjectUtils.disposeObject(_buyIcon);
         _buyIcon = null;
         ObjectUtils.disposeObject(_buyName);
         _buyName = null;
         ObjectUtils.disposeObject(_buyNumTxt);
         _buyNumTxt = null;
         ObjectUtils.disposeObject(_buyPriceTxt);
         _buyPriceTxt = null;
         ObjectUtils.disposeObject(_buyPriceIcon);
         _buyPriceIcon = null;
         ObjectUtils.disposeObject(_buyAdd);
         _buyAdd = null;
         ObjectUtils.disposeObject(_buyReduce);
         _buyReduce = null;
         ObjectUtils.disposeObject(_buyNumTxtIn);
         _buyNumTxtIn = null;
         ObjectUtils.disposeObject(_buyPriceTxtIn);
         _buyPriceTxtIn = null;
         ObjectUtils.disposeObject(_limitTip);
         _limitTip = null;
         ObjectUtils.disposeObject(_limitTxt);
         _limitTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _info = null;
      }
      
      public function get info() : PoseidonShopTempInfo
      {
         return _info;
      }
      
      public function get doBuyNum() : int
      {
         return int(_buyNumTxtIn.text);
      }
      
      public function getGoodsName() : String
      {
         return _buyName.text;
      }
   }
}

