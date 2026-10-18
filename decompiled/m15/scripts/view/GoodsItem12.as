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
   import mvc.module.wishpool.WishPoolShopInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.WishPoolShopBuyFrame;
   
   public class GoodsItem12 extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _lineImg:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _valueTxt:FilterFrameText;
      
      private var _goods:BaseItemView;
      
      private var _buyBtn:IconButton;
      
      protected var _data:WishPoolShopInfo;
      
      public function GoodsItem12()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsNameTextStyle");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("shop.ItemContributeTxtImg");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsValueTextStyle");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ItemBuyBtn");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.ItemBaseItemView");
         _bg.setFrame(1);
         addChild(_bg);
         addChild(_lineImg);
         _lineImg.y = 50;
         addChild(_nameTxt);
         addChild(_valueTxt);
         addChild(_buyBtn);
         addChild(_goods);
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         this.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         this.removeEventListener("click",__clickHandler);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            _bg.setFrame(2);
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(param1.target == _buyBtn)
         {
            __onBuyBtnHandler(param1);
         }
      }
      
      public function get data() : WishPoolShopInfo
      {
         return _data;
      }
      
      public function set data(param1:WishPoolShopInfo) : void
      {
         _data = param1;
         if(_data)
         {
            addEvent();
            _nameTxt.text = getName();
            _lineImg.setFrame(_data.payType);
            _valueTxt.text = _data.price + "";
            _buyBtn.visible = true;
            _lineImg.visible = true;
         }
         else
         {
            clean();
            removeEvent();
         }
      }
      
      private function getName() : String
      {
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = _data.tempalteId;
         _loc2_.count = _data.count;
         _goods.data = _loc2_;
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.tempalteId);
         if(!_loc1_)
         {
            return "";
         }
         return _loc1_.TemplateName;
      }
      
      private function __onBuyBtnHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
      }
      
      private function quickUIcallback() : void
      {
         var _loc1_:WishPoolShopBuyFrame = ComponentFactory.Instance.creatComponentByStylename("quickbuy.WishPoolShopBuyFrame");
         _loc1_.data = _data;
         _loc1_.show();
      }
      
      protected function clean() : void
      {
         _nameTxt.text = "";
         _valueTxt.text = "";
         _buyBtn.visible = false;
         _lineImg.visible = false;
         _goods.data = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_valueTxt);
         _valueTxt = null;
         ObjectUtils.disposeObject(_goods);
         _goods = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_lineImg);
         _lineImg = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

