package com.speedEngine.components.ui2D
{
   import com.speedEngine.res.ResourcesManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class SimpleNumber extends TinyUI
   {
      
      public static const CENTER:String = "center";
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
      
      public static const TOP:String = "top";
      
      public static const BOTTOM:String = "bottom";
      
      public static const MIDDLE:String = "middle";
      
      protected static const VIEWPOS:String = "viewpos";
      
      private var _resPath:String = "";
      
      private var _text:String = "";
      
      private var _gap:int = 0;
      
      private var _align:String = "center";
      
      private var _vAlign:String = "bottom";
      
      private var _format:String = "";
      
      private var _specialDic:Dictionary = new Dictionary(true);
      
      private var _textures:Array = [];
      
      private var _imgArr:Vector.<Bitmap> = new Vector.<Bitmap>(0);
      
      private var _displayContainer:TinyUI = new TinyUI();
      
      private var _customWidth:Number = -1;
      
      private var _customHeight:Number = -1;
      
      private var _textLen:int = 0;
      
      private var _highest:int = 0;
      
      private var _hasChange:Boolean = false;
      
      public function SimpleNumber()
      {
         super();
         addChild(_displayContainer);
         initSpecocalDic();
      }
      
      private function initSpecocalDic() : void
      {
         _specialDic["0"] = 0;
         _specialDic["1"] = 1;
         _specialDic["2"] = 2;
         _specialDic["3"] = 3;
         _specialDic["4"] = 4;
         _specialDic["5"] = 5;
         _specialDic["6"] = 6;
         _specialDic["7"] = 7;
         _specialDic["8"] = 8;
         _specialDic["9"] = 9;
         _specialDic["."] = ".";
      }
      
      private function initDisplay() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Bitmap = null;
         if(_displayContainer.numChildren > 0)
         {
            _displayContainer.removeChildren();
         }
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _textLen)
         {
            _loc1_ = _imgArr[_loc3_];
            _loc1_.x = _loc2_ + _loc3_ * _gap;
            _loc2_ += _loc1_.width;
            moveImgY(_loc1_);
            _displayContainer.addChild(_loc1_);
            _loc3_++;
         }
         validate("viewpos");
      }
      
      private function moveImgY(param1:Bitmap) : void
      {
         switch(_vAlign)
         {
            case "middle":
               param1.y = _highest - param1.height >> 1;
               break;
            case "bottom":
               param1.y = _highest - param1.height;
               break;
            case "top":
            default:
               param1.y = 0;
         }
      }
      
      private function getTexture(param1:String) : BitmapData
      {
         return ResourcesManager.instance.getBitmapData(param1);
      }
      
      private function refreshViewPos() : void
      {
         if(_customHeight != -1)
         {
            switch(_vAlign)
            {
               case "middle":
                  _displayContainer.y = _customHeight - _displayContainer.height >> 1;
                  break;
               case "bottom":
                  _displayContainer.y = _customHeight - _displayContainer.height;
                  break;
               case "top":
               default:
                  _displayContainer.y = 0;
            }
         }
         if(_customWidth != -1)
         {
            switch(_align)
            {
               case "center":
                  _displayContainer.x = _customWidth - _displayContainer.width >> 1;
                  break;
               case "right":
                  _displayContainer.x = _customWidth - _displayContainer.width;
                  break;
               case "left":
               default:
                  _displayContainer.x = 0;
            }
         }
      }
      
      override public function __onAfterProp() : void
      {
      }
      
      override public function render() : void
      {
         super.render();
         if(validateDic[STYLE])
         {
            initDisplay();
         }
         if(validateDic["viewpos"])
         {
            refreshViewPos();
         }
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function set text(param1:String) : void
      {
         var _loc3_:BitmapData = null;
         var _loc4_:int = 0;
         var _loc2_:String = null;
         if(!_isValidate)
         {
            return;
         }
         _textLen = param1.length;
         _highest = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = param1.charAt(_loc4_);
            if(_loc2_ in _specialDic)
            {
               if(_hasChange || _textures[_loc2_] == null)
               {
                  if(_loc2_ == ".")
                  {
                     _textures[_loc2_] = getTexture(_resPath + "point" + format);
                  }
                  else
                  {
                     _textures[_loc2_] = getTexture(_resPath + _loc2_ + format);
                  }
                  pushDisposeBitmap(_textures[_loc2_]);
               }
               _loc3_ = _textures[_loc2_];
            }
            if(_loc3_ == null)
            {
               throw new Error("字符" + _loc2_ + "不存在对应纹理， 请检查图片资{invalid_utf8=230}{invalid_utf8=186}?");
            }
            _imgArr.length <= _loc4_ ? (_imgArr[_loc4_] = new Bitmap(_loc3_)) : (_imgArr[_loc4_].bitmapData = _loc3_);
            _imgArr[_loc4_].width = _loc3_.width;
            _imgArr[_loc4_].height = _loc3_.height;
            if(_highest < _loc3_.height)
            {
               _highest = _loc3_.height;
            }
            _loc4_++;
         }
         _hasChange = false;
         _text = param1;
         validate(STYLE);
      }
      
      override public function get height() : Number
      {
         return _customHeight == -1 ? super.height : _customHeight;
      }
      
      override public function set height(param1:Number) : void
      {
         _customHeight = param1;
         validate("viewpos");
         super.height = param1;
      }
      
      override public function get width() : Number
      {
         return _customWidth == -1 ? super.width : _customWidth;
      }
      
      override public function set width(param1:Number) : void
      {
         _customWidth = param1;
         validate("viewpos");
         super.width = param1;
      }
      
      public function get vAlign() : String
      {
         return _vAlign;
      }
      
      public function set vAlign(param1:String) : void
      {
         if(_vAlign == param1)
         {
            return;
         }
         validate(STYLE);
         _vAlign = param1;
      }
      
      public function get align() : String
      {
         return _align;
      }
      
      public function set align(param1:String) : void
      {
         if(_align == param1)
         {
            return;
         }
         validate("viewpos");
         _align = param1;
      }
      
      public function get gap() : int
      {
         return _gap;
      }
      
      public function set gap(param1:int) : void
      {
         if(_gap == param1)
         {
            return;
         }
         validate(STYLE);
         _gap = param1;
      }
      
      public function get resPath() : String
      {
         return _resPath;
      }
      
      public function set resPath(param1:String) : void
      {
         if(_resPath != param1)
         {
            _resPath = param1;
            _hasChange = true;
         }
      }
      
      override public function dispose() : void
      {
         if(!_isValidate)
         {
            return;
         }
         _displayContainer.dispose();
         if(_displayContainer.numChildren > 0)
         {
            _displayContainer.removeChildren();
         }
         this.removeChild(_displayContainer);
         _displayContainer = null;
         _imgArr.splice(0,_imgArr.length);
         _textures.splice(0,_textures.length);
         _imgArr = null;
         _specialDic = null;
         super.dispose();
      }
      
      public function get format() : String
      {
         return _format;
      }
      
      public function set format(param1:String) : void
      {
         _format = param1;
      }
   }
}

