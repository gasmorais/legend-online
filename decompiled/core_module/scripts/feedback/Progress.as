package feedback
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class Progress extends Sprite implements Disposeable
   {
      
      private var _iconStyle:String;
      
      private var _icon:Bitmap;
      
      private var _mask:Shape;
      
      private var _current:int;
      
      private var _totle:int;
      
      private var _textStyle:String;
      
      private var _progressTxt:FilterFrameText;
      
      public function Progress(param1:String = "", param2:String = "")
      {
         super();
         _iconStyle = param1;
         _textStyle = param2;
         initView();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatBitmap(_iconStyle);
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename(_textStyle);
         addChild(_icon);
         addChild(_progressTxt);
         _mask = new Shape();
         _mask.graphics.beginFill(16777215,0);
         _mask.graphics.drawRect(0,0,_icon.width,_icon.height);
         _mask.graphics.endFill();
         _mask.x = _icon.x;
         _mask.y = _icon.y;
         _icon.mask = _mask;
         addChild(_mask);
      }
      
      public function setData(param1:int, param2:int) : void
      {
         _current = param1;
         _totle = param2;
         refresh();
      }
      
      private function refresh() : void
      {
         _progressTxt.text = _current + " / " + _totle;
         _mask.width = _icon.width * _current / _totle;
      }
      
      private function clear() : void
      {
         _progressTxt.text = "0 / 0";
         _mask.width = 1;
      }
      
      public function dispose() : void
      {
         if(_icon)
         {
            if(_icon.parent)
            {
               _icon.parent.removeChild(_icon);
            }
            _icon.mask = null;
         }
         if(_mask)
         {
            _mask.graphics.clear();
            if(_mask.parent)
            {
               _mask.parent.removeChild(_mask);
            }
         }
         ObjectUtils.disposeObject(_icon);
         ObjectUtils.disposeObject(_progressTxt);
         ObjectUtils.disposeObject(_mask);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

