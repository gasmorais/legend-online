package view.inside
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import mvc.module.shop.MainShopInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.DateFormatter;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.ShopMainBuyFrame;
   
   public class ShopTimeItem extends Sprite implements Disposeable
   {
      
      private var bg:MutipleImage;
      
      private var _pricebit:Bitmap;
      
      private var _name:FilterFrameText;
      
      private var _price:FilterFrameText;
      
      private var _timeLabel:FilterFrameText;
      
      private var _timeValue:FilterFrameText;
      
      private var _count:FilterFrameText;
      
      private var _light:MovieClip;
      
      private var _valueIcon:ScaleFrameImage;
      
      private var _goods:BaseItemView;
      
      private var _panicBuy:IconButton;
      
      private var _data:MainShopInfo;
      
      public function ShopTimeItem()
      {
         super();
         bg = ComponentFactory.Instance.creatComponentByStylename("ShopTimeItem.bg");
         _pricebit = ComponentFactory.Instance.creatBitmap("asset.shopTimeItem.price");
         _name = ComponentFactory.Instance.creatComponentByStylename("shop.ShopTimeItemName");
         _price = ComponentFactory.Instance.creatComponentByStylename("shop.goodsItem4ValueTextStyle");
         _valueIcon = ComponentFactory.Instance.creatComponentByStylename("core.SmallValueIcon");
         _timeLabel = ComponentFactory.Instance.creatComponentByStylename("shop.shopItem.timeRemaininglabel");
         _timeValue = ComponentFactory.Instance.creatComponentByStylename("shop.shopItem.timeRemaining");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.ItemBaseItemView");
         _panicBuy = ComponentFactory.Instance.creatComponentByStylename("shop.panicBuyBtn");
         _count = ComponentFactory.Instance.creatComponentByStylename("shop.shopItem.count");
         _panicBuy.visible = false;
         _price.visible = false;
         _valueIcon.visible = false;
         _pricebit.visible = false;
         addChild(bg);
         addChild(_pricebit);
         addChild(_name);
         addChild(_price);
         _price.x = 116;
         _price.y = 126;
         addChild(_valueIcon);
         _valueIcon.y = 126;
         addChild(_goods);
         _goods.x = 33;
         _goods.y = 117;
         addChild(_timeLabel);
         addChild(_timeValue);
         addChild(_count);
         addChild(_panicBuy);
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__clickHandler);
      }
      
      public function get data() : MainShopInfo
      {
         return _data;
      }
      
      public function set data(param1:MainShopInfo) : void
      {
         var _loc2_:String = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc5_:Object = null;
         _goods.data = null;
         _data = param1;
         if(_data == null)
         {
            return;
         }
         var _loc4_:GoodsInfo = new GoodsInfo();
         _loc4_.templateId = _data.templateId;
         _loc4_.count = _data.counts;
         if(_data)
         {
            if(_data.isGift)
            {
               _goods.icon.icon = PathManager.info.REQUEST_PATH + _data.url;
               _loc2_ = _data.content;
               _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
               if(_loc3_ && _loc3_.SonType == 206)
               {
                  _loc2_ += "<br/><font color=\'#00ff00\'>" + _loc3_.Description + "</font>";
               }
               _loc5_ = {
                  "name":_data.names,
                  "content":_loc2_
               };
               _goods.icon.tipData = _loc5_;
               _goods.icon.tipStyle = "yishi.view.tips.ShopMainTips";
               _valueIcon.setFrame(1);
            }
            else
            {
               _goods.data = _loc4_;
            }
            _panicBuy.visible = true;
            _price.visible = true;
            _valueIcon.visible = true;
            _pricebit.visible = true;
            _name.text = _data.names;
            _price.text = _data.price + "";
            _panicBuy.enable = true;
            if(_data.canTotalCount == -1)
            {
               _count.visible = false;
            }
            else
            {
               _count.text = LanguageMgr.GetTranslation("shop.mainRightView.shoptimeitem.counttitle",_data.canTotalCount);
            }
            addEvent();
            return;
         }
         _panicBuy.enable = false;
         _timeLabel.text = "";
         _timeValue.text = "";
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(param1.target == _panicBuy)
         {
            if(_data.type == 4)
            {
               ShopManager.Instance.type = 1;
               ShopManager.Instance.currBuyGoods = _data;
               ShopManager.Instance.getGoodsBuyNum(_data.id,4);
            }
         }
      }
      
      private function __buyHandler(param1:MouseEvent) : void
      {
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
      }
      
      private function quickUIcallback() : void
      {
         var _loc1_:ShopMainBuyFrame = ComponentFactory.Instance.creatComponentByStylename("shop.ShopMainBuyFrame");
         _loc1_["show"]();
         _loc1_["data"](_data);
      }
      
      public function set timeText(param1:int) : void
      {
         if(_data.type == 4)
         {
            if(param1 > 2592000)
            {
               _timeLabel.text = "";
               _timeValue.text = "";
            }
            else
            {
               _timeLabel.text = LanguageMgr.GetTranslation("battle.view.buffer.BufferListItemTip.turnText01");
               _timeValue.text = DateFormatter.getStopDateString(param1);
            }
         }
      }
      
      public function updateView() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(bg);
         bg = null;
         ObjectUtils.disposeObject(_pricebit);
         _pricebit = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_price);
         _price = null;
         ObjectUtils.disposeObject(_valueIcon);
         _valueIcon = null;
         ObjectUtils.disposeObject(_timeLabel);
         _timeLabel = null;
         ObjectUtils.disposeObject(_timeValue);
         _timeValue = null;
         ObjectUtils.disposeObject(_count);
         _count = null;
         ObjectUtils.disposeObject(_goods);
         _goods = null;
         ObjectUtils.disposeObject(_panicBuy);
         _panicBuy = null;
         _data = null;
      }
   }
}

