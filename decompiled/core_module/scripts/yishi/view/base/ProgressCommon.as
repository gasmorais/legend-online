package yishi.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import org.bytearray.display.ScaleBitmap;
   import utils.LogicUtils;
   
   public class ProgressCommon extends Component
   {
      
      private var _bg:ScaleBitmap;
      
      private var _bgName:String;
      
      private var _bar:ScaleBitmap;
      
      private var _contentName:String;
      
      private var _filterText:FilterFrameText;
      
      private var _text:String;
      
      private var _textStyleName:String;
      
      private var _value:Number = 0;
      
      private var _barMarginStr:String;
      
      private var _marginData:Array;
      
      private var _mask:ScaleBitmap;
      
      private var _isMaskChange:Boolean = false;
      
      private var _isContentChange:Boolean = false;
      
      public function ProgressCommon()
      {
         super();
      }
      
      public function set backgroundLink(param1:String) : void
      {
         var _loc2_:BitmapData = null;
         if(_bgName == param1)
         {
            return;
         }
         _bgName = param1;
         _isMaskChange = true;
         var _loc3_:Object = ClassUtils.getDefinition(param1);
         if(_loc3_)
         {
            _loc2_ = new _loc3_();
         }
         else
         {
            _loc2_ = ComponentFactory.Instance.creatBitmapData(param1);
         }
         if(_bg)
         {
            _bg.bitmapData = _loc2_;
         }
         else
         {
            _bg = new ScaleBitmap(_loc2_);
         }
         width = _bg.width;
         height = _bg.height;
         _isContentChange = true;
         updateView();
      }
      
      public function set barLink(param1:String) : void
      {
         var _loc2_:BitmapData = null;
         if(_contentName == param1)
         {
            return;
         }
         _contentName = param1;
         _isMaskChange = true;
         var _loc3_:Object = ClassUtils.getDefinition(param1);
         if(_loc3_)
         {
            _loc2_ = new _loc3_();
         }
         else
         {
            _loc2_ = ComponentFactory.Instance.creatBitmapData(param1);
         }
         if(_bar)
         {
            _bar.bitmapData = _loc2_;
         }
         else
         {
            _bar = new ScaleBitmap(_loc2_);
         }
         _isContentChange = true;
         updateView();
      }
      
      public function set barMargin(param1:String) : void
      {
         if(_barMarginStr == param1)
         {
            return;
         }
         _barMarginStr = param1;
         _marginData = _barMarginStr.split(",");
         _isContentChange = true;
         updateView();
      }
      
      public function get barMargin() : String
      {
         return _barMarginStr;
      }
      
      public function set textStyle(param1:String) : void
      {
         if(_textStyleName == param1)
         {
            return;
         }
         _textStyleName = param1;
         _filterText = ComponentFactory.Instance.creatComponentByStylename(param1);
         _isContentChange = true;
         updateView();
      }
      
      public function set value(param1:Number) : void
      {
         if(param1 == _value)
         {
            return;
         }
         _value = param1 > 1 ? 1 : param1;
         _value = param1 < 0 ? 0 : param1;
         updateView();
      }
      
      public function get value() : Number
      {
         return _value;
      }
      
      public function set text(param1:String) : void
      {
         if(_text == param1)
         {
            return;
         }
         _text = param1;
         _isContentChange = true;
         updateView();
      }
      
      private function updateView() : void
      {
         LogicUtils.addToRender(this,render);
      }
      
      private function render() : void
      {
         if(_filterText)
         {
            _filterText.text = _text;
         }
         if(_isContentChange)
         {
            this.setContent();
         }
         _mask.width = _bar.width * _value + 1;
      }
      
      private function setContent() : void
      {
         if(_bg && _bar)
         {
            _bar.x = _bg.width - _bar.width >> 1;
            _bar.y = _bg.height - _bar.height >> 1;
            if(_barMarginStr)
            {
               if(int(_marginData[0]) != 0 || int(_marginData[2]) != 0)
               {
                  _bar.x = int(_marginData[0]);
                  _bar.width = _bg.width - int(_marginData[0]) - int(_marginData[2]);
               }
               if(int(_marginData[1]) != 0 || int(_marginData[3]) != 0)
               {
                  _bar.y = int(_marginData[1]);
                  _bar.height = _bg.height - int(_marginData[1]) - int(_marginData[3]);
               }
            }
            if(_isMaskChange)
            {
               if(_mask)
               {
                  _mask.bitmapData = _bar.bitmapData;
               }
               else
               {
                  _mask = new ScaleBitmap(_bar.bitmapData);
               }
               _mask.width = _bar.width;
               _mask.height = _bar.height;
               _isMaskChange = false;
            }
            _mask.x = _bar.x - 1;
            _mask.y = _bar.y;
            _bar.mask = _mask;
            this.addChildAt(_bg,0);
            this.addChildAt(_bar,1);
            this.addChildAt(_mask,2);
            if(_filterText)
            {
               _filterText.x = _bar.x + (_bar.width - _filterText.width >> 1);
               _filterText.y = _bar.y + (_bar.height - _filterText.textHeight >> 1) - 2;
               this.addChildAt(_filterText,3);
            }
         }
         _isContentChange = false;
      }
      
      override public function get width() : Number
      {
         if(_bg)
         {
            return _bg.width;
         }
         return width;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bar);
         _bar = null;
         ObjectUtils.disposeObject(_filterText);
         _filterText = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         if(_marginData)
         {
            _marginData.length = 0;
         }
         _marginData = null;
         super.dispose();
      }
   }
}

