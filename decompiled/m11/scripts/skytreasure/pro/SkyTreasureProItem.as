package skytreasure.pro
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.skytreasure.LotteryRateInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class SkyTreasureProItem extends Sprite
   {
      
      protected var _itemBg:Bitmap;
      
      protected var _ItemNameTxt:FilterFrameText;
      
      protected var _ItemProTxt:FilterFrameText;
      
      private var _goodsIcon:BaseItemView;
      
      private var _data:LotteryRateInfo;
      
      public function SkyTreasureProItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _goodsIcon = ComponentFactory.Instance.creatCustomObject("Sky.GameHallEastShopItemView.goodsIcon");
         _itemBg = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.itemBg");
         _ItemNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.ItemNameTxt");
         _ItemProTxt = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.ItemProTxt");
         addChild(_itemBg);
         addChild(_ItemNameTxt);
         addChild(_ItemProTxt);
         addChild(_goodsIcon);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_goodsIcon);
         _goodsIcon = null;
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_ItemNameTxt);
         _ItemNameTxt = null;
         ObjectUtils.disposeObject(_ItemProTxt);
         _ItemProTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      public function set data(param1:LotteryRateInfo) : void
      {
         _data = param1;
         if(_data)
         {
            refreshView();
         }
         else
         {
            clear();
         }
      }
      
      private function clear() : void
      {
         _goodsIcon.data = null;
         _ItemNameTxt.text = "";
         _ItemProTxt.text = "";
      }
      
      private function refreshView() : void
      {
         var _loc1_:GoodsTemplateInfo = null;
         var _loc2_:GoodsInfo = null;
         if(_data.templateId && _data.templateId != 0)
         {
            _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _data.templateId;
            _loc2_.count = _data.Templatecount;
            _loc2_.showCount = true;
            _goodsIcon.data = _loc2_;
            _ItemNameTxt.text = _loc1_ ? _loc1_.TemplateName : "xxx";
         }
         _ItemProTxt.text = _data.rate.toString();
      }
      
      public function dispose() : void
      {
         uninitView();
      }
   }
}

