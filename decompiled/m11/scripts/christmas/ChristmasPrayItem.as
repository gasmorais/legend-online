package christmas
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChristmasLotteryTempInfo;
   import yishi.view.community.BaseItemView;
   
   public class ChristmasPrayItem extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _goods:BaseItemView;
      
      private var _data:ChristmasLotteryTempInfo;
      
      public function ChristmasPrayItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.ChristmasPrayFrame.itemBg");
         _goods = ComponentFactory.Instance.creatCustomObject("christmasPrayItem.goodsItemView");
         addChild(_bg);
         addChild(_goods);
         _goods.data = null;
      }
      
      public function set data(param1:ChristmasLotteryTempInfo) : void
      {
         var _loc2_:GoodsInfo = null;
         _data = param1;
         if(_data)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _data.ItemId;
            _loc2_.count = _data.Num;
            _goods.data = _loc2_;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_goods);
         _goods = null;
      }
   }
}

