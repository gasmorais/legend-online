package encoGold.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import mvc.module.encoGold.EncoGoldItemInfo;
   
   public class EncoGoldDayItemView extends Sprite implements Disposeable
   {
      
      private var _daySprite:Bitmap;
      
      private var _dayTxt:FilterFrameText;
      
      private var _iconImages:ScaleFrameImage;
      
      private var _index:int;
      
      public function EncoGoldDayItemView(param1:int = 0)
      {
         _index = param1;
         super();
         initView();
      }
      
      private function initView() : void
      {
         _dayTxt = ComponentFactory.Instance.creatComponentByStylename("encoGold.DayTxt");
         _iconImages = ComponentFactory.Instance.creatComponentByStylename("encoGold.iconImages");
         addChild(_iconImages);
         setIndex(2);
      }
      
      public function set info(param1:EncoGoldItemInfo) : void
      {
         ObjectUtils.disposeObject(_daySprite);
         _daySprite = null;
         if(param1.type == 1)
         {
            if(param1.isDouble)
            {
               _iconImages.setFrame(2);
            }
            else
            {
               _iconImages.setFrame(3);
            }
         }
         else if(param1.type == 2)
         {
            _iconImages.setFrame(1);
         }
         ObjectUtils.disposeObject(_daySprite);
         _daySprite = null;
         setIndex(param1.day);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_dayTxt);
         _dayTxt = null;
         ObjectUtils.disposeObject(_daySprite);
         _daySprite = null;
         ObjectUtils.disposeObject(_iconImages);
         _iconImages = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function setIndex(param1:int) : void
      {
         _dayTxt.text = "day " + param1;
         _daySprite = getTextFieldBitmap(_dayTxt);
         addChild(_daySprite);
         _daySprite.x = -15;
         if(_index == 0)
         {
            _iconImages.x = -30;
            _iconImages.y = 20;
         }
         else if(_index == 1)
         {
            _daySprite.rotation = 45;
            _iconImages.x = -90;
            _iconImages.y = 77;
         }
         else if(_index == 2)
         {
            _daySprite.rotation = 90;
            _iconImages.x = -160;
            _iconImages.y = 27;
         }
         else if(_index == 3)
         {
            _daySprite.rotation = -45;
            _iconImages.x = -70;
            _iconImages.y = -88;
         }
         else if(_index == 4)
         {
            _iconImages.x = -30;
            _iconImages.y = -53;
         }
         else if(_index == 5)
         {
            _daySprite.rotation = 45;
            _iconImages.x = -5;
            _iconImages.y = -34;
         }
         else if(_index == 6)
         {
            _daySprite.rotation = -90;
            _iconImages.x = 20;
            _iconImages.y = -58;
         }
         else if(_index == 7)
         {
            _daySprite.rotation = -45;
            _iconImages.x = 10;
            _iconImages.y = 15;
         }
      }
      
      private function getTextFieldBitmap(param1:FilterFrameText) : Bitmap
      {
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(param1);
         var _loc3_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height);
         _loc3_.colorTransform(new Rectangle(0,0,_loc2_.width,_loc2_.height),new ColorTransform(0,0,0,0));
         _loc3_.draw(_loc2_,null,null,null,null,true);
         var _loc4_:Bitmap = new Bitmap(_loc3_);
         _loc4_.smoothing = true;
         return _loc4_;
      }
   }
}

