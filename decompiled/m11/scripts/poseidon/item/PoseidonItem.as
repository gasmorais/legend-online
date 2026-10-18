package poseidon.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PoseidonManager;
   import mvc.module.poseidon.PoseidonGoodInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.PoseidonShopTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class PoseidonItem extends Sprite
   {
      
      public var _itemBack:Bitmap;
      
      public var _buy:IconButton;
      
      public var _name:FilterFrameText;
      
      public var _price:FilterFrameText;
      
      public var _limit:FilterFrameText;
      
      public var _icon:BaseItemView;
      
      public var _tip:FilterFrameText;
      
      public var _empty:Bitmap;
      
      public var _itemPriceIcon:ScaleFrameImage;
      
      public var _limitTip:ScaleFrameImage;
      
      private var _info:PoseidonShopTempInfo;
      
      private var _data:PoseidonGoodInfo;
      
      private var _buySp:Sprite;
      
      public function PoseidonItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _itemBack = ComponentFactory.Instance.creatBitmap("asset.poseridon.itemBack");
         _buy = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.buy");
         _name = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.name");
         _price = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.price");
         _limit = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.limit");
         _icon = ComponentFactory.Instance.creatCustomObject("ui.poseidonshop.itemView");
         _tip = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.tip");
         _empty = ComponentFactory.Instance.creatBitmap("asset.poseridon.empty");
         _itemPriceIcon = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.itemPriceIcon");
         _limitTip = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.limitTip");
         _buySp = new Sprite();
         addChild(_itemBack);
         addChild(_name);
         addChild(_limit);
         addChild(_icon);
         addChild(_tip);
         addChild(_empty);
         addChild(_limitTip);
         addChild(_buySp);
         _buySp.addChild(_price);
         _buySp.addChild(_itemPriceIcon);
         _buySp.addChild(_buy);
         _empty.visible = false;
         _buySp.visible = false;
         _buy.enable = false;
      }
      
      public function set info(param1:PoseidonShopTempInfo) : void
      {
         var _loc2_:GoodsTemplateInfo = null;
         var _loc4_:GoodsInfo = null;
         var _loc3_:int = 0;
         _info = param1;
         if(_info)
         {
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_info.ItemId);
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _info.ItemId;
            _icon.data = _loc4_;
            _price.text = "" + _info.Price;
            if(_loc2_)
            {
               _name.text = _loc2_.TemplateName;
            }
            _itemPriceIcon.setFrame(_info.ShopType);
            _limitTip.setFrame(_info.LimitType);
            _loc3_ = int(RoyaltyBossManager.instance.model.royaltyLevel);
            if(_loc3_ < _info.OpenCondition)
            {
               _tip.visible = true;
               _buySp.visible = false;
               _tip.text = LanguageMgr.GetTranslation("poseidon.shop.lvTip",_info.OpenCondition);
            }
            else
            {
               _tip.visible = false;
               _buySp.visible = true;
            }
            this.refreshView();
         }
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         if(_info)
         {
            _data = PoseidonManager.Ins.model.getGoodInfo(_info.Id);
            if(_data)
            {
               _loc1_ = _info.LimitNumber - _data.buyCount;
               _limit.text = _data.buyCount + "/" + _info.LimitNumber;
               _empty.visible = _loc1_ > 0 ? false : true;
               _buy.enable = !_empty.visible;
            }
            else
            {
               _limit.text = "0/" + _info.LimitNumber;
               _empty.visible = false;
               _buy.enable = true;
            }
         }
      }
      
      private function initEvent() : void
      {
         _buy.addEventListener("click",buyHandler);
      }
      
      private function removeEvent() : void
      {
         if(_buy)
         {
            _buy.removeEventListener("click",buyHandler);
         }
      }
      
      private function buyHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("poseidonshop",1,_info);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBack);
         _itemBack = null;
         ObjectUtils.disposeObject(_buy);
         _buy = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_price);
         _price = null;
         ObjectUtils.disposeObject(_limit);
         _limit = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_tip);
         _tip = null;
         ObjectUtils.disposeObject(_empty);
         _empty = null;
         ObjectUtils.disposeObject(_itemPriceIcon);
         _itemPriceIcon = null;
         ObjectUtils.disposeObject(_limitTip);
         _limitTip = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _info = null;
         _data = null;
      }
   }
}

