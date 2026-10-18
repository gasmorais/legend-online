package view.inside
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.FashionEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class AllBuyItem extends Sprite implements Disposeable
   {
      
      private var _itemBack:Bitmap;
      
      private var _goods:BaseItemView;
      
      private var _pointIcon:ScaleFrameImage;
      
      private var _nameText:FilterFrameText;
      
      private var _valueText:FilterFrameText;
      
      private var _selectedBtn:SelectedButton;
      
      private var _data:ShopGoodsInfo;
      
      public function AllBuyItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _itemBack = ComponentFactory.Instance.creatBitmap("asset.shop.allBuyItemBack");
         _goods = ComponentFactory.Instance.creatCustomObject("core.BaseItemView");
         _pointIcon = ComponentFactory.Instance.creatComponentByStylename("core.SmallValueIcon");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsNameTextStyle");
         _valueText = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsValueTextStyle");
         _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("shop.hideFashionBtn");
         addChild(_itemBack);
         addChild(_goods);
         _goods.x = 13;
         _goods.y = 12;
         addChild(_pointIcon);
         _pointIcon.setFrame(1);
         _pointIcon.x = 179;
         _pointIcon.y = 39;
         addChild(_nameText);
         _nameText.x = 66;
         _nameText.y = 8;
         addChild(_valueText);
         _valueText.x = 111;
         _valueText.y = 39;
         addChild(_selectedBtn);
         _selectedBtn.x = 216;
         _selectedBtn.y = 22;
      }
      
      public function set data(param1:ShopGoodsInfo) : void
      {
         if(!param1)
         {
            dispose();
            return;
         }
         _data = param1;
         _nameText.text = getName();
         _valueText.text = _data.price + "";
         _selectedBtn.selected = true;
         addEvent();
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
      
      public function get data() : ShopGoodsInfo
      {
         return _data;
      }
      
      public function get selected() : Boolean
      {
         return _selectedBtn.selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selectedBtn.selected = param1;
      }
      
      private function addEvent() : void
      {
         if(_selectedBtn)
         {
            _selectedBtn.addEventListener("select",__selectedHandler);
         }
      }
      
      protected function __selectedHandler(param1:Event) : void
      {
         dispatchEvent(new FashionEvent("BUY_ITEM_SELECTED",null,true));
      }
      
      private function removeEvent() : void
      {
         if(_selectedBtn)
         {
            _selectedBtn.removeEventListener("select",__selectedHandler);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBack);
         ObjectUtils.disposeObject(_goods);
         ObjectUtils.disposeObject(_nameText);
         ObjectUtils.disposeObject(_valueText);
         ObjectUtils.disposeObject(_pointIcon);
         ObjectUtils.disposeObject(_selectedBtn);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

