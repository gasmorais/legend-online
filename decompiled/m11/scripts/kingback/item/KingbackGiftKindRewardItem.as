package kingback.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.kingback.KingbackInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class KingbackGiftKindRewardItem extends Sprite
   {
      
      public var _giftBg:Bitmap;
      
      public var _giftTitle:Bitmap;
      
      public var _nowPriceBg:Bitmap;
      
      public var _nowPrice:Bitmap;
      
      public var _oldPrice:Bitmap;
      
      public var _giftOldPriceTxt:FilterFrameText;
      
      public var _giftNowPriceTxt:FilterFrameText;
      
      public var _oldPriceLine:Bitmap;
      
      public var _giftOldPoint:Image;
      
      public var _giftNowPoint:Image;
      
      public var _giftRewardBox:HBox;
      
      private var _data:KingbackInfo;
      
      private var _itemList:Array = [];
      
      public function KingbackGiftKindRewardItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _giftBg = ComponentFactory.Instance.creatBitmap("asset.kingback.giftBg");
         _giftTitle = ComponentFactory.Instance.creatBitmap("asset.knigback.giftTitle");
         _nowPriceBg = ComponentFactory.Instance.creatBitmap("asset.kingback.nowPriceBg");
         _nowPrice = ComponentFactory.Instance.creatBitmap("asset.kingback.nowPrice");
         _oldPrice = ComponentFactory.Instance.creatBitmap("asset.kingback.oldPrice");
         _giftOldPriceTxt = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.giftOldPriceTxt");
         _giftNowPriceTxt = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.giftNowPriceTxt");
         _oldPriceLine = ComponentFactory.Instance.creatBitmap("asset.kingback.oldPriceLine");
         _giftOldPoint = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.giftOldPoint");
         _giftNowPoint = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.giftNowPoint");
         _giftRewardBox = ComponentFactory.Instance.creatCustomObject("ui.kingback.giftRewardBox");
         addChild(_giftBg);
         addChild(_giftTitle);
         addChild(_nowPriceBg);
         addChild(_nowPrice);
         addChild(_oldPrice);
         addChild(_giftOldPriceTxt);
         addChild(_giftNowPriceTxt);
         addChild(_oldPriceLine);
         addChild(_giftOldPoint);
         addChild(_giftNowPoint);
         addChild(_giftRewardBox);
      }
      
      private function initData() : void
      {
         var _loc2_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         var _loc6_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:Array = _data.tempInfo.getRewardList();
         var _loc1_:int = int(_loc3_ ? _loc3_.length : 0);
         ObjectUtils.removeChildAllChildrenFromStage(_giftRewardBox);
         _giftRewardBox.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc6_ = _loc3_[_loc4_];
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc6_[0];
            _loc5_.count = _loc6_[1];
            _loc2_ = _itemList[_loc4_];
            if(_loc2_ == null)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("ui.kingback.baseItemView");
            }
            _loc2_.data = _loc5_;
            _itemList[_loc4_] = _loc2_;
            _giftRewardBox.addChild(_loc2_);
            _loc4_++;
         }
         _giftRewardBox.commitChanges();
      }
      
      public function get data() : KingbackInfo
      {
         return _data;
      }
      
      public function set data(param1:KingbackInfo) : void
      {
         _data = param1;
         initData();
         _giftOldPriceTxt.text = _data.tempInfo.Param1;
         _giftNowPriceTxt.text = "" + _data.tempInfo.Point;
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:BaseItemView in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_giftBg);
         _giftBg = null;
         ObjectUtils.disposeObject(_giftTitle);
         _giftTitle = null;
         ObjectUtils.disposeObject(_nowPriceBg);
         _nowPriceBg = null;
         ObjectUtils.disposeObject(_nowPrice);
         _nowPrice = null;
         ObjectUtils.disposeObject(_oldPrice);
         _oldPrice = null;
         ObjectUtils.disposeObject(_giftOldPriceTxt);
         _giftOldPriceTxt = null;
         ObjectUtils.disposeObject(_giftNowPriceTxt);
         _giftNowPriceTxt = null;
         ObjectUtils.disposeObject(_oldPriceLine);
         _oldPriceLine = null;
         ObjectUtils.disposeObject(_giftOldPoint);
         _giftOldPoint = null;
         ObjectUtils.disposeObject(_giftNowPoint);
         _giftNowPoint = null;
         ObjectUtils.disposeObject(_giftRewardBox);
         _giftRewardBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

