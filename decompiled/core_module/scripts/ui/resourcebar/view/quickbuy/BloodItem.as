package ui.resourcebar.view.quickbuy
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class BloodItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _bg:Bitmap;
      
      private var _goldIcon:ScaleFrameImage;
      
      private var _selected:Boolean;
      
      private var _overBg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _priceTxt:FilterFrameText;
      
      private var _icon:BaseItemView;
      
      private var _data:ShopGoodsInfo;
      
      private var _goods:GoodsInfo;
      
      public function BloodItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.resourceBar.QuickBuyItemBg");
         _overBg = ComponentFactory.Instance.creatBitmap("asset.resourceBar.QuickBuyMouseOver");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("resourceBar.BloodTxt");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("resourceBar.BloodGoldTxt");
         _goldIcon = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.BloodGoldIcon");
         _icon = ComponentFactory.Instance.creatCustomObject("resourcesBar.BaseItemView1");
         _goods = new GoodsInfo();
         _overBg.visible = false;
         addChild(_bg);
         addChild(_overBg);
         addChild(_nameTxt);
         addChild(_priceTxt);
         addChild(_goldIcon);
         addChild(_icon);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _data = null;
      }
      
      public function get data() : ShopGoodsInfo
      {
         return _data;
      }
      
      public function set data(param1:ShopGoodsInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(_data)
         {
            _goods.templateId = _data.ItemId;
            _icon.data = _goods;
            _nameTxt.text = _goods.templateInfo.TemplateName;
            if(_data.Gold != 0)
            {
               _priceTxt.text = _data.Gold.toString();
               _goldIcon.setFrame(1);
            }
            else if(_data.Point != 0)
            {
               _priceTxt.text = _data.Point.toString();
               _goldIcon.setFrame(2);
            }
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _overBg.visible = _selected;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

