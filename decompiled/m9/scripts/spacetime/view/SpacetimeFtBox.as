package spacetime.view
{
   import com.pickgliss.effect.ColorMatrix;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import yishi.filter.UIFilter;
   
   public class SpacetimeFtBox extends Sprite
   {
      
      private var _boxImg:ScaleFrameImage;
      
      private var _lightImg:BitmapData;
      
      private var _grayImg:BitmapData;
      
      private var _bkBit:Bitmap;
      
      private var _bkBitData:BitmapData;
      
      private var _gray:Array;
      
      private var _currStar:int = -1;
      
      private var _boxCountText:FilterFrameText;
      
      public function SpacetimeFtBox()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _gray = [UIFilter.getGrayFilter()];
         _boxImg = ComponentFactory.Instance.creatComponentByStylename("xmlui.spacetimefault.fla.boxType");
         _lightImg = ComponentFactory.Instance.creatBitmap("asset.spacetimefault.circle0").bitmapData;
         _grayImg = ComponentFactory.Instance.creatBitmap("asset.spacetimefault.circle1").bitmapData;
         _boxCountText = ComponentFactory.Instance.creatComponentByStylename("SpacetimeFtBox.boxCountText");
         _bkBit = new Bitmap();
         _bkBitData = new BitmapData(32,32,true);
         addChild(_bkBit);
         addChild(_boxImg);
         addChild(_boxCountText);
         _boxCountText.setFrame(1);
         updateColor();
      }
      
      public function set boxType(param1:int) : void
      {
         _boxImg.setFrame(param1);
      }
      
      public function set count(param1:int) : void
      {
         _boxCountText.text = param1 + "";
      }
      
      public function set star(param1:int) : void
      {
         if(_currStar == param1)
         {
            return;
         }
         _currStar = param1;
         var _loc5_:int = 4 - param1;
         var _loc4_:int = param1;
         var _loc2_:Rectangle = new Rectangle(0,0,16,16);
         var _loc3_:Point = new Point(0,0);
         _boxImg.filters = null;
         _boxCountText.setFrame(1);
         if(param1 == 0)
         {
            _bkBit.bitmapData = _grayImg;
            _boxCountText.setFrame(2);
         }
         else if(param1 == 1)
         {
            _bkBitData.copyPixels(_lightImg,_loc2_,_loc3_);
            _loc3_.x = _loc2_.x = 16;
            _bkBitData.copyPixels(_grayImg,_loc2_,_loc3_);
            _loc3_.x = _loc2_.x = 0;
            _loc3_.y = _loc2_.y = 16;
            _loc2_.width = 32;
            _loc2_.height = 16;
            _bkBitData.copyPixels(_grayImg,_loc2_,_loc3_);
            _bkBit.bitmapData = _bkBitData;
         }
         else if(param1 == 2)
         {
            _loc2_.width = 16;
            _loc2_.height = 32;
            _bkBitData.copyPixels(_lightImg,_loc2_,_loc3_);
            _loc3_.x = _loc2_.x = 16;
            _bkBitData.copyPixels(_grayImg,_loc2_,_loc3_);
            _bkBit.bitmapData = _bkBitData;
         }
         else if(param1 == 3)
         {
            _bkBitData.copyPixels(_lightImg,_loc2_,_loc3_);
            _loc3_.x = _loc2_.x = 16;
            _bkBitData.copyPixels(_grayImg,_loc2_,_loc3_);
            _loc3_.x = _loc2_.x = 0;
            _loc3_.y = _loc2_.y = 16;
            _loc2_.width = 32;
            _loc2_.height = 16;
            _bkBitData.copyPixels(_lightImg,_loc2_,_loc3_);
            _bkBit.bitmapData = _bkBitData;
         }
         else if(param1 == 4)
         {
            _bkBit.bitmapData = _lightImg;
         }
      }
      
      private function updateColor() : void
      {
         var _loc2_:ColorMatrix = new ColorMatrix();
         var _loc1_:ColorMatrixFilter = new ColorMatrixFilter();
         _loc2_.SetBrightnessMatrix(12);
         _loc2_.SetContrastMatrix(19);
         _loc2_.SetSaturationMatrix(19);
         _loc2_.SetHueMatrix(0);
         _loc1_.matrix = _loc2_.GetFlatArray();
         this.filters = [_loc1_];
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_boxImg);
         _boxImg = null;
         ObjectUtils.disposeObject(_bkBit);
         _bkBit = null;
         ObjectUtils.disposeObject(_bkBitData);
         _bkBitData = null;
         ObjectUtils.disposeObject(_lightImg);
         _lightImg = null;
         ObjectUtils.disposeObject(_grayImg);
         _grayImg = null;
         ObjectUtils.disposeObject(_boxCountText);
         _boxCountText = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _gray = null;
      }
   }
}

