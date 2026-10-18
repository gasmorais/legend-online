package oldplayerreturn.shop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.OldPlayerReturnShopTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class OldPlayerReturnShopBuyFrame extends Frame
   {
      
      public var _buyBack:Bitmap;
      
      public var _buyConfrim:IconButton;
      
      public var _buyNumBack:Image;
      
      public var _buyItemView:BaseItemView;
      
      public var _buyName:FilterFrameText;
      
      public var _buyNumTxt:FilterFrameText;
      
      public var _buyPriceTxt:FilterFrameText;
      
      public var _buyPriceIcon:ScaleFrameImage;
      
      public var _buyAdd:BaseButton;
      
      public var _buyReduce:BaseButton;
      
      public var _buyNumTxtIn:FilterFrameText;
      
      public var _buyPriceTxtIn:FilterFrameText;
      
      private var _data:OldPlayerReturnShopTempInfo;
      
      private var _buyNum:int = 1;
      
      private var _limit:int;
      
      private var _limitNum:int;
      
      private var _limitTip:FilterFrameText;
      
      public function OldPlayerReturnShopBuyFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _buyBack = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnShop.buyFrameBack");
         _buyConfrim = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnShop.buyConfrim");
         _buyNumBack = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnShop.buyNumBack");
         _buyItemView = ComponentFactory.Instance.creatCustomObject("OldPlayerReturnShop.buyItemView");
         _buyName = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnShop.buyName");
         _buyNumTxt = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnShop.buyNumTxt");
         _buyPriceTxt = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnShop.buyPriceTxt");
         _buyPriceIcon = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnTaskItem.icon");
         _buyAdd = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnShop.buyAdd");
         _buyReduce = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnShop.buyReduce");
         _buyNumTxtIn = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnShop.buyNumTxtIn");
         _buyPriceTxtIn = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnShop.buyPriceTxtIn");
         _limitTip = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnShop.buy.limitTip");
         addToContent(_buyBack);
         addToContent(_buyConfrim);
         addToContent(_buyNumBack);
         addToContent(_buyItemView);
         addToContent(_buyName);
         addToContent(_buyNumTxt);
         addToContent(_buyPriceTxt);
         addToContent(_buyPriceIcon);
         addToContent(_buyAdd);
         addToContent(_buyReduce);
         addToContent(_buyNumTxtIn);
         addToContent(_buyPriceTxtIn);
         addToContent(_limitTip);
         _buyNumTxt.text = LanguageMgr.GetTranslation("poseidon.shop.buyNum");
         _buyPriceTxt.text = LanguageMgr.GetTranslation("poseidon.shop.buyPrice");
         _buyPriceIcon.x = 130;
         _buyPriceIcon.y = 150;
      }
      
      public function set data(param1:OldPlayerReturnShopTempInfo) : void
      {
         var _loc9_:GoodsInfo = null;
         if(!param1)
         {
            return;
         }
         _data = param1;
         var _loc7_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.CommodityId);
         if(_loc7_)
         {
            _loc9_ = new GoodsInfo();
            _loc9_.templateId = _data.CommodityId;
            _loc9_.count = _data.CommodityAmount;
            _buyItemView.data = _loc9_;
            _buyName.text = _loc7_.TemplateName;
         }
         _buyPriceIcon.setFrame(_data.PlayerType);
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         if(model.shopLimitList[_data.Id])
         {
            _loc8_ = int(model.shopLimitList[_data.Id]);
         }
         var _loc2_:Array = _data.Limited.split(",");
         if(_loc2_[model.contractLevel - 1])
         {
            _loc5_ = int(_loc2_[model.contractLevel - 1]);
         }
         var _loc4_:int = _loc5_ - _loc8_ < 0 ? 0 : _loc5_ - _loc8_;
         _limitTip.text = LanguageMgr.GetTranslation("OldPlayerReturnShopItem.limitedTxt.text",_loc4_,_loc5_);
         var _loc6_:int = model.isReturnPlayer ? 208701 : 208702;
         var _loc3_:int = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc6_));
         _limitNum = Math.floor(_loc3_ / _data.MoneyNum);
         _limit = Math.min(_limitNum,_loc4_);
         buyNumChangeHandler();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _buyAdd.addEventListener("click",addHandler);
         _buyReduce.addEventListener("click",reduceHandler);
         if(_buyNumTxtIn)
         {
            _buyNumTxtIn.addEventListener("change",__buyNumChange);
         }
         _buyConfrim.addEventListener("click",confrimHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _buyAdd.removeEventListener("click",addHandler);
         _buyReduce.removeEventListener("click",reduceHandler);
         if(_buyNumTxtIn)
         {
            _buyNumTxtIn.removeEventListener("change",__buyNumChange);
         }
         _buyConfrim.removeEventListener("click",confrimHandler);
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
         if(_buyNum <= 0)
         {
            _buyNum = 1;
         }
         _buyNumTxtIn.text = "" + _buyNum;
         _buyNum <= 1 ? (_buyReduce.enable = false) : (Boolean(_buyReduce.enable = true));
         _buyNum >= _limit ? (_buyAdd.enable = false) : (Boolean(_buyAdd.enable = true));
         _buyConfrim.enable = _buyNum > 0 ? true : false;
         _buyPriceTxtIn.text = _buyNum * _data.MoneyNum + "";
      }
      
      private function reduceHandler(param1:MouseEvent) : void
      {
         _buyNum = _buyNum - 1;
         buyNumChangeHandler();
      }
      
      private function addHandler(param1:MouseEvent) : void
      {
         _buyNum = _buyNum + 1;
         buyNumChangeHandler();
      }
      
      private function confrimHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = int(_buyNumTxtIn.text);
         var _loc3_:int = _loc2_ * _data.MoneyNum;
         var _loc4_:int = model.isReturnPlayer ? 208701 : 208702;
         var _loc5_:int = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc4_));
         if(_loc5_ < _loc3_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("OldPlayerReturnShopItem.count.text" + model.type));
            return;
         }
         OldPlayerReturnManager.instance.send(7,_data.Id,_loc2_);
         dispose();
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
      
      private function get model() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         titleText = LanguageMgr.GetTranslation("public.prompt");
         if(param1 && param1.frameData)
         {
            data = param1.frameData as OldPlayerReturnShopTempInfo;
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_buyBack);
         _buyBack = null;
         ObjectUtils.disposeObject(_buyConfrim);
         _buyConfrim = null;
         ObjectUtils.disposeObject(_buyNumBack);
         _buyNumBack = null;
         ObjectUtils.disposeObject(_buyItemView);
         _buyItemView = null;
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
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

