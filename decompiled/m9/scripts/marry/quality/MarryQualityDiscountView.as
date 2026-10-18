package marry.quality
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.templates.MarryQualityData;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.TimeDownView;
   
   public class MarryQualityDiscountView extends Sprite implements Disposeable
   {
      
      private var _discountText:FilterFrameText;
      
      private var _downTime:TimeDownView;
      
      private var _firstPrice:FilterFrameText;
      
      private var _smallPoint:Bitmap;
      
      private var _originalLine:Bitmap;
      
      private var _diacountCharacter:Bitmap;
      
      private var _discountImg:ScaleFrameImage;
      
      private var _discountContainer:Component;
      
      private var _discountNumber:BitmapData;
      
      private var _dotImg:Bitmap;
      
      private var _percent:Bitmap;
      
      private var _posArr:Array = [[255,223,256],[235,203,236],[235,203,236]];
      
      public function MarryQualityDiscountView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _discountText = ComponentFactory.Instance.creatComponentByStylename("MarryKiloView.disCountText");
         _discountText.text = LanguageMgr.GetTranslation("marry.view.weddingDiscountTxt");
         _downTime = ComponentFactory.Instance.creatComponentByStylename("MarryKiloView.TimeDown");
         _firstPrice = ComponentFactory.Instance.creatComponentByStylename("MarryKiloView.firstPrice");
         _smallPoint = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _discountImg = ComponentFactory.Instance.creatComponentByStylename("asset.marry.discountBg");
         _diacountCharacter = ComponentFactory.Instance.creatBitmap("asset.marry.discountChar");
         _originalLine = ComponentFactory.Instance.creatBitmap("asset.marry.fristLine");
         _dotImg = ComponentFactory.Instance.creatBitmap("asset.marry.discountDot");
         _percent = ComponentFactory.Instance.creatBitmap("asset.marry.percent");
         _discountNumber = ComponentFactory.Instance.creatBitmapData("asset.marry.discountNumber").clone();
         _discountContainer = ComponentFactory.Instance.creatCustomObject("MarryDisCountView.discountContainer");
         _smallPoint.x = 151;
         _smallPoint.y = 159;
         addChild(_discountText);
         addChild(_downTime);
         addChild(_firstPrice);
         addChild(_smallPoint);
         addChild(_discountImg);
         addChild(_diacountCharacter);
         addChild(_originalLine);
         addChild(_discountContainer);
         addChild(_percent);
      }
      
      public function setCount(param1:int) : void
      {
         if(!_downTime)
         {
            return;
         }
         _downTime.timeCount = param1;
      }
      
      public function setQuality(param1:int) : void
      {
         _discountImg.setFrame(param1);
         var _loc2_:MarryQualityData = TempleteManager.instance.getMarryQualityTemplateCate.getTempById(param1);
         if(_loc2_)
         {
            _discountContainer.x = _posArr[param1 - 1][0];
            _diacountCharacter.x = _posArr[param1 - 1][1];
            if(param1 == 1)
            {
               _percent.x = 270;
            }
            NumberViewUtils.getNumberView(Math.round(100 - _loc2_.Discount),_discountContainer,_discountNumber,17,27,17,17,"0123456789",1);
            _firstPrice.text = LanguageMgr.GetTranslation("funny.view.FunnyHotBuyItem.price1",_loc2_.Points);
            _smallPoint.x = _firstPrice.x + _firstPrice.textWidth + 5;
         }
      }
      
      public function dispose() : void
      {
         if(_discountImg)
         {
            _discountImg.dispose();
         }
         _discountImg = null;
         if(_discountText)
         {
            _discountText.dispose();
         }
         _discountText = null;
         if(_downTime)
         {
            _downTime.dispose();
         }
         _downTime = null;
         if(_firstPrice)
         {
            _firstPrice.dispose();
         }
         _firstPrice = null;
         if(_smallPoint)
         {
            _smallPoint.bitmapData.dispose();
         }
         _smallPoint = null;
         if(_originalLine)
         {
            _originalLine.bitmapData.dispose();
         }
         _originalLine = null;
         if(_diacountCharacter)
         {
            _diacountCharacter.bitmapData.dispose();
         }
         _diacountCharacter = null;
         if(_discountContainer)
         {
            _discountContainer.dispose();
         }
         _discountContainer = null;
         if(_discountNumber)
         {
            _discountNumber.dispose();
         }
         _discountNumber = null;
         if(_dotImg)
         {
            _dotImg.bitmapData.dispose();
         }
         _dotImg = null;
         if(_percent)
         {
            _percent.bitmapData.dispose();
         }
         _percent = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

