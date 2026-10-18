package com.pickgliss.ui.controls.alert
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class SimpleAlert extends BaseAlerFrame
   {
      
      public static const P_frameInnerRect:String = "frameInnerRect";
      
      public static const P_frameMiniH:String = "frameMiniH";
      
      public static const P_frameMiniW:String = "frameMiniW";
      
      public static const P_textField:String = "textFieldStyle";
      
      public static const P_smallTip:String = "smallTipStyle";
      
      protected var _frameMiniH:int = -2147483648;
      
      protected var _frameMiniW:int = -2147483648;
      
      protected var _textField:TextField;
      
      protected var _textFieldStyle:String;
      
      protected var _smallTipTxt:FilterFrameText;
      
      protected var _smallTipStyle:String;
      
      protected var _frameInnerRect:InnerRectangle;
      
      private var _frameInnerRectString:String;
      
      protected var _maxTextWidth:Number = 0;
      
      public function SimpleAlert()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(_textField)
         {
            ObjectUtils.disposeObject(_textField);
         }
         _textField = null;
         _frameInnerRect = null;
         if(_smallTipTxt)
         {
            _smallTipTxt.removeEventListener("link",__tipLinkHandler);
            ObjectUtils.disposeObject(_smallTipTxt);
            _smallTipTxt = null;
         }
         super.dispose();
      }
      
      public function set frameInnerRectString(param1:String) : void
      {
         if(_frameInnerRectString == param1)
         {
            return;
         }
         _frameInnerRectString = param1;
         _frameInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_frameInnerRectString));
         onPropertiesChanged("frameInnerRect");
      }
      
      public function get frameInnerRectString() : String
      {
         return _frameInnerRectString;
      }
      
      public function set frameMiniH(param1:int) : void
      {
         if(_frameMiniH == param1)
         {
            return;
         }
         _frameMiniH = param1;
         onPropertiesChanged("frameMiniH");
      }
      
      public function set frameMiniW(param1:int) : void
      {
         if(_frameMiniW == param1)
         {
            return;
         }
         _frameMiniW = param1;
         onPropertiesChanged("frameMiniW");
      }
      
      public function set textStyle(param1:String) : void
      {
         if(_textFieldStyle == param1)
         {
            return;
         }
         if(_textField)
         {
            ObjectUtils.disposeObject(_textField);
         }
         _textFieldStyle = param1;
         _textField = ComponentFactory.Instance.creat(_textFieldStyle);
         onPropertiesChanged("textFieldStyle");
      }
      
      public function get textStyle() : String
      {
         return _textFieldStyle;
      }
      
      public function set smallTipStyle(param1:String) : void
      {
         if(_smallTipStyle == param1)
         {
            return;
         }
         _smallTipStyle = param1;
         if(_smallTipTxt)
         {
            _smallTipTxt.removeEventListener("link",__tipLinkHandler);
            ObjectUtils.disposeObject(_smallTipTxt);
            _smallTipTxt = null;
         }
         _smallTipTxt = ComponentFactory.Instance.creat(_smallTipStyle);
         _smallTipTxt.addEventListener("link",__tipLinkHandler);
         onPropertiesChanged("smallTipStyle");
      }
      
      public function get smallTipStyle() : String
      {
         return _smallTipStyle;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_textField)
         {
            addChild(_textField);
         }
         if(_smallTipTxt)
         {
            addChild(_smallTipTxt);
         }
      }
      
      public function set maxTextWidth(param1:Number) : void
      {
         beginChanges();
         _maxTextWidth = param1;
         _changedPropeties["info"] = true;
         commitChanges();
      }
      
      protected function layoutFrameRect() : void
      {
         if(_maxTextWidth > 0 && _textField.width > _maxTextWidth)
         {
            _textField.width = _maxTextWidth;
         }
         var _loc1_:Rectangle = _frameInnerRect.getInnerRect(_textField.width,_textField.height);
         if(_loc1_.width > _frameMiniW)
         {
            _textField.x = _frameInnerRect.para1;
            _width = _loc1_.width;
         }
         else
         {
            _textField.x = _frameInnerRect.para1 + (_frameMiniW - _loc1_.width) / 2;
            _width = _frameMiniW;
         }
         _textField.y = 30;
         _height = _textField.numLines * 23 + 114 > _frameMiniH ? _textField.numLines * 23 + 114 : _frameMiniH;
         if(_smallTipTxt)
         {
            _smallTipTxt.width = _textField.width;
            _smallTipTxt.x = _textField.x + (_textField.width - _smallTipTxt.width) / 2;
            _smallTipTxt.y = _textField.y + _textField.height - 5;
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         if(_changedPropeties["info"])
         {
            updateMsg();
            if(_frameInnerRect)
            {
               layoutFrameRect();
               _changedPropeties["width"] = true;
               _changedPropeties["height"] = true;
            }
         }
         super.onProppertiesUpdate();
      }
      
      protected function updateMsg() : void
      {
         _textField.autoSize = "left";
         if(_info.mutiline)
         {
            _textField.multiline = true;
            if(!info.enableHtml)
            {
               _textField.wordWrap = true;
            }
            if(_info.textShowWidth > 0)
            {
               _textField.width = _info.textShowWidth;
            }
            else
            {
               _textField.width = DisplayUtils.getTextFieldMaxLineWidth(String(_info.data),_textField.defaultTextFormat,info.enableHtml);
            }
         }
         if(_info.enableHtml)
         {
            _textField.htmlText = _info.data + "";
         }
         else
         {
            _textField.text = String(_info.data);
         }
         if(_smallTipTxt)
         {
            _smallTipTxt.width = _textField.width;
            _smallTipTxt.htmlText = _info.smallTip;
         }
      }
      
      protected function __tipLinkHandler(param1:TextEvent) : void
      {
         if(_info && _info.smallTipCall != null)
         {
            _info.smallTipCall();
            dispose();
         }
      }
   }
}

