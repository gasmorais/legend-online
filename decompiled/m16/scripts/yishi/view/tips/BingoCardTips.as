package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.bingo.BingoCardTempMsg;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import yishi.utils.NumberViewUtils;
   
   public class BingoCardTips extends BaseTip
   {
      
      private var _numberBg:DisplayObject;
      
      private var _titleContain:Component;
      
      private var _titleAsset:BitmapData;
      
      private var _itemList:Array = [];
      
      public function BingoCardTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BingoCardItem = null;
         super.init();
         _bg.visible = false;
         _numberBg = ComponentFactory.Instance.creatBitmap("asset.tips.cardBingoBg");
         _titleAsset = ComponentFactory.Instance.creatBitmapData("asset.tips.cardTitleNumAsset");
         _titleContain = new Component();
         addChild(_numberBg);
         addChild(_titleContain);
         _loc2_ = 0;
         while(_loc2_ < 25)
         {
            _loc1_ = new BingoCardItem();
            _loc1_.x = 42 + int(_loc2_ % 5) * 50;
            _loc1_.y = 90 + int(_loc2_ / 5) * 50;
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
         this.scaleX = 0.7;
         this.scaleY = 0.7;
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:BingoCardTempMsg = null;
         var _loc2_:int = 0;
         if(tipData)
         {
            clean();
            _loc1_ = tipData as BingoCardTempMsg;
            _loc2_ = 0;
            while(_loc2_ < _itemList.length)
            {
               _itemList[_loc2_].data = _loc1_.cardNum[_loc2_];
               _loc2_++;
            }
            NumberViewUtils.refreshValue(_data.cardId,_titleContain,_titleAsset,28,39,25,28,"0123456789");
            _titleContain.x = (_numberBg.width - _titleContain.displayWidth) / 2;
            _titleContain.y = 10;
         }
      }
      
      private function clean() : void
      {
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.core.Component;
import flash.display.BitmapData;
import yishi.utils.NumberViewUtils;

class BingoCardItem extends Component
{
   
   private var _numberAsset:BitmapData;
   
   private var _numberContain:Component;
   
   public function BingoCardItem()
   {
      super();
      _numberAsset = ComponentFactory.Instance.creatBitmapData("asset.bingo.cardNumAsset");
      _numberContain = new Component();
      addChild(_numberContain);
   }
   
   public function set data(param1:int) : void
   {
      NumberViewUtils.refreshValue(param1,_numberContain,_numberAsset,15,20,13,15,"0123456789");
      _numberContain.x = param1 < 10 ? 17 : 10;
      _numberContain.y = 15;
      _numberContain.visible = param1 == 0 ? false : true;
   }
   
   override public function dispose() : void
   {
   }
}
