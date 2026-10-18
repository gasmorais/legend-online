package battle.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import yishi.utils.NumberViewUtils;
   import yishi.view.tips.BaseTip;
   
   public class SpTip extends BaseTip
   {
      
      private var _numBitmapData:BitmapData;
      
      private var _titleBm:Bitmap;
      
      private var _currentSpSprite:Sprite;
      
      private var _totalSpSprite:Sprite;
      
      private var _divisionSign:Bitmap;
      
      private var _container:Sprite;
      
      public function SpTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.mouseEnabled = false;
         this.mouseChildren = false;
         _numBitmapData = ComponentFactory.Instance.creatBitmapData("asset.core.number_img_01");
         _container = new Sprite();
         addChild(_container);
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _container.addChild(_bg);
         _titleBm = ComponentFactory.Instance.creatBitmap("asset.battle.PowerUISpTipTitle");
         _container.addChild(_titleBm);
         _currentSpSprite = new Sprite();
         _container.addChild(_currentSpSprite);
         _divisionSign = ComponentFactory.Instance.creatBitmap("asset.battle.PowerUISpTipDivision");
         _container.addChild(_divisionSign);
         _totalSpSprite = new Sprite();
         NumberViewUtils.refreshValue(100,_totalSpSprite,_numBitmapData,13,17,14,13);
         _container.addChild(_totalSpSprite);
         refreshView();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_numBitmapData);
         _numBitmapData = null;
         ObjectUtils.disposeObject(_titleBm);
         _titleBm = null;
         ObjectUtils.disposeObject(_divisionSign);
         _divisionSign = null;
         ObjectUtils.removeChildAllChildren(_totalSpSprite);
         _totalSpSprite = null;
         ObjectUtils.removeChildAllChildren(_currentSpSprite);
         _currentSpSprite = null;
         ObjectUtils.disposeViolentMc(_container);
         _container = null;
         super.dispose();
      }
      
      override protected function updateTransform() : void
      {
         ObjectUtils.removeChildAllChildren(_currentSpSprite);
         var _loc1_:Component = new Component();
         NumberViewUtils.refreshValue(int(_data),_loc1_,_numBitmapData,13,17,14,13);
         _currentSpSprite.addChild(_loc1_);
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:Number = 3;
         var _loc2_:Number = 2;
         var _loc3_:Number = 2;
         _titleBm.x = _loc1_;
         _titleBm.y = _loc3_;
         _currentSpSprite.x = _titleBm.x + _titleBm.width;
         _currentSpSprite.y = _loc3_ + _loc2_;
         _divisionSign.x = _currentSpSprite.x + _currentSpSprite.width;
         _divisionSign.y = _loc3_;
         _totalSpSprite.x = _divisionSign.x + _divisionSign.width - 2;
         _totalSpSprite.y = _loc3_ + _loc2_;
         _bg.width = _totalSpSprite.x + _totalSpSprite.width + _loc1_ + 3;
         _bg.height = 25;
         _container.x = 20;
         _container.y = 19;
      }
   }
}

