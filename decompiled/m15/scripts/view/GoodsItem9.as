package view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import mvc.module.shop.MainShopInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class GoodsItem9 extends Sprite implements Disposeable
   {
      
      protected var _bg:ScaleFrameImage;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _valueTxt:FilterFrameText;
      
      protected var _goods:BaseItemView;
      
      protected var _buyBtn:IconButton;
      
      protected var _tips:FilterFrameText;
      
      protected var _lineImg:ScaleFrameImage;
      
      protected var _data:MainShopInfo;
      
      protected var _filter:IFilterFormat;
      
      protected var _canTotalText:FilterFrameText;
      
      protected var _canTotalValueText:FilterFrameText;
      
      public function GoodsItem9()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _filter = new UIFilter();
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsNameTextStyle");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("shop.ItemContributeTxtImg");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsValueTextStyle");
         _tips = ComponentFactory.Instance.creatComponentByStylename("shop.ItemShopTipsTextStyle");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ItemBuyBtn");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.GoodsItem9.ItemBaseItemView");
         _canTotalText = ComponentFactory.Instance.creatComponentByStylename("artifact.buyCanTotalTxt");
         _canTotalValueText = ComponentFactory.Instance.creatComponentByStylename("artifact.buyCanTotalValueTxt");
         _bg.setFrame(1);
         addChild(_bg);
         addChild(_lineImg);
         addChild(_nameTxt);
         addChild(_tips);
         addChild(_valueTxt);
         addChild(_buyBtn);
         addChild(_goods);
         addChild(_canTotalText);
         addChild(_canTotalValueText);
      }
      
      protected function addEvent() : void
      {
         this.addEventListener("click",__clickHandler);
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         NotificationManager.instance.addEventListener("SHOP_TIME_GIFT_REFRESH",__refreshHandler);
      }
      
      protected function removeEvent() : void
      {
         this.removeEventListener("click",__clickHandler);
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         NotificationManager.instance.removeEventListener("SHOP_TIME_GIFT_REFRESH",__refreshHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(param1.target == _buyBtn)
         {
            if(FrameControllerManager.instance.artifactControler.artifactOpen)
            {
               return;
            }
            ShopManager.Instance.type = 7;
            ShopManager.Instance.currBuyGoods3 = _data;
            ShopManager.Instance.getGoodsBuyNum(_data.id,7);
         }
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            _bg.setFrame(2);
         }
      }
      
      protected function __outHandler(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      private function __refreshHandler(param1:NotificationEvent) : void
      {
         if(_data && param1.data.goodId == _data.id)
         {
            setHasOwn(param1.data.count);
            _data.count = param1.data.count;
            _data.currentCount = param1.data.count;
         }
      }
      
      public function get data() : MainShopInfo
      {
         return _data;
      }
      
      public function set data(param1:MainShopInfo) : void
      {
         _data = param1;
         if(param1)
         {
            addEvent();
            setHasOwn();
            _nameTxt.text = getName();
            _valueTxt.text = _data.price + "";
            _nameTxt.visible = true;
            _valueTxt.visible = true;
            _buyBtn.visible = true;
            _lineImg.visible = true;
            _canTotalText.visible = true;
            _canTotalValueText.visible = true;
            setFilter();
         }
         else
         {
            clean();
            removeEvent();
         }
      }
      
      public function setHasOwn(param1:int = 0) : void
      {
         _canTotalText.text = LanguageMgr.GetTranslation("view.GoodsItem9.title");
         var _loc2_:int = int(param1 > 0 ? param1 : _data.maxCount - _data.canOneCount);
         _canTotalValueText.text = _loc2_ + "/" + _data.maxCount;
         if(_loc2_ >= _data.maxCount)
         {
            _canTotalText.text = LanguageMgr.GetTranslation("shop.view.GoodsItem.limited05");
            _canTotalValueText.text = "";
         }
      }
      
      protected function setFilter() : void
      {
         _lineImg.setFrame(1);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function getName() : String
      {
         var _loc2_:String = null;
         var _loc5_:Object = null;
         var _loc4_:GoodsInfo = null;
         var _loc1_:* = null;
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
         if(_data.isGift)
         {
            _goods.icon.icon = PathManager.info.REQUEST_PATH + _data.url;
            _loc2_ = _data.content;
            _loc5_ = {
               "name":_data.names,
               "content":_loc2_
            };
            _goods.icon.tipData = _loc5_;
            _goods.icon.tipStyle = "yishi.view.tips.ShopMainTips";
            return _data.names;
         }
         _loc4_ = new GoodsInfo();
         _loc4_.templateId = _data.templateId;
         _loc4_.count = _data.counts;
         _goods.data = _loc4_;
         if(!_loc3_)
         {
            _data = null;
            return LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaShopGoodsItem.noFindGoods");
         }
         return _loc3_.TemplateName;
      }
      
      protected function clean() : void
      {
         _nameTxt.visible = false;
         _valueTxt.visible = false;
         _buyBtn.visible = false;
         _lineImg.visible = false;
         _goods.data = null;
         _tips.text = "";
         _canTotalText.visible = false;
         _canTotalValueText.visible = false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

