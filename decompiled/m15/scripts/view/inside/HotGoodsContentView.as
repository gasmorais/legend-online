package view.inside
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.shop.ShopGoodsInfo;
   import view.GoodsItem2;
   
   public class HotGoodsContentView extends Sprite implements Disposeable
   {
      
      private var _itemList:Vector.<GoodsItem2>;
      
      private var _label:Bitmap;
      
      private var _houIcon:Bitmap;
      
      public function HotGoodsContentView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:GoodsItem2 = null;
         _label = ComponentFactory.Instance.creatBitmap("shop.hotGoodsContentViewlabel");
         _houIcon = ComponentFactory.Instance.creatBitmap("asset.core.HotIconImg");
         addChild(_label);
         addChild(_houIcon);
         _itemList = new Vector.<GoodsItem2>();
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc1_ = new GoodsItem2();
            _loc1_.x = 13;
            _loc1_.y = _loc4_ * (_loc1_.height - 10) + 60;
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc4_++;
            _loc3_++;
         }
      }
      
      public function showList(param1:Array) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _itemList[_loc3_].data = null;
            _loc3_++;
         }
         var _loc2_:int = int(5 > param1.length ? 5 : param1.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _itemList[_loc3_].data = param1[_loc3_] as ShopGoodsInfo;
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         if(_label && _label.parent)
         {
            _label.parent.removeChild(_label);
         }
         if(_houIcon && _houIcon.parent)
         {
            _houIcon.parent.removeChild(_houIcon);
         }
         for each(var _loc1_:GoodsItem2 in _itemList)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         _itemList = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

