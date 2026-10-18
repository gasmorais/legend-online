package armyII.viewII.stone.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class StonePreCell extends Sprite
   {
      
      private var _bit:Bitmap;
      
      private var _line:ScaleFrameImage;
      
      private var _isNeedLine:Boolean = false;
      
      private var _xing:int;
      
      public function StonePreCell(param1:Boolean = true)
      {
         super();
         _isNeedLine = param1;
         initView();
      }
      
      public function set xing(param1:int) : void
      {
         _xing = param1;
         if(_bit)
         {
            _bit.bitmapData = ComponentFactory.Instance.creatBitmapData("asset.army.stone.shape" + _xing);
         }
      }
      
      private function initView() : void
      {
         _bit = new Bitmap();
         addChild(_bit);
         if(_isNeedLine)
         {
            _line = ComponentFactory.Instance.creatComponentByStylename("army.rune.suitLine");
            addChild(_line);
            _line.setFrame(2);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bit);
         _bit = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

