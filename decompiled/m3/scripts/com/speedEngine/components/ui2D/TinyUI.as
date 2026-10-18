package com.speedEngine.components.ui2D
{
   import com.speedEngine.components.manager.ObjectManger;
   import com.speedEngine.components.manager.RepaintManger;
   import com.speedEngine.components.ui2D.controls.IViewPort;
   import com.speedEngine.game.Director;
   import com.speedEngine.game.view.BaseSprite;
   import com.speedEngine.res.ResourcesManager;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class TinyUI extends BaseSprite implements IViewPort
   {
      
      public static var STYLE:String = "style";
      
      public static var DATA:String = "data";
      
      public static var SIZE:String = "size";
      
      private var _xmlPath:String;
      
      private var _disposeList:Vector.<BitmapData> = new Vector.<BitmapData>(0);
      
      protected var _isValidate:Boolean = true;
      
      private var _readyRender:Boolean = true;
      
      protected var _className:String;
      
      protected var _index:int = 0;
      
      protected var _validateDic:Object = {};
      
      protected var _tWidth:int = -1;
      
      protected var _tHeight:int = -1;
      
      private var _layoutType:String;
      
      public function TinyUI()
      {
         super();
         _className = getQualifiedClassName(this);
         ObjectManger.instance.pushObject(_className,this);
      }
      
      public function getBoundRect(param1:DisplayObject = null) : Rectangle
      {
         var _loc12_:Rectangle = null;
         var _loc11_:Rectangle = null;
         var _loc10_:DisplayObject = null;
         var _loc7_:Rectangle = null;
         var _loc4_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc9_:int = 0;
         var _loc8_:Point = null;
         var _loc2_:int = this.numChildren;
         if(_tHeight != -1 || _tWidth != -1)
         {
            if(_tHeight != -1)
            {
               _loc12_ = getBounds(this);
               _loc12_.height = _tHeight;
            }
            if(_tWidth != -1)
            {
               _loc12_ = getBounds(this);
               _loc12_.width = _tWidth;
            }
         }
         else if(_loc2_ > 0)
         {
            _loc10_ = getChildAt(0);
            if(_loc10_ is TinyUI)
            {
               _loc12_ = (_loc10_ as TinyUI).getBoundRect(this);
            }
            else
            {
               _loc7_ = _loc10_.getBounds(this);
               if(_loc7_.width == 0 || _loc7_.height == 0)
               {
                  _loc7_.right = -2147483648;
                  _loc7_.x = 2147483647;
                  _loc7_.bottom = -2147483648;
                  _loc7_.y = 2147483647;
               }
               _loc12_ = _loc7_;
            }
            _loc4_ = _loc12_.right;
            _loc6_ = _loc12_.x;
            _loc5_ = _loc12_.bottom;
            _loc3_ = _loc12_.y;
            _loc9_ = 1;
            while(_loc9_ < _loc2_)
            {
               _loc11_ = null;
               _loc10_ = getChildAt(_loc9_);
               if(_loc10_ is TinyUI)
               {
                  _loc11_ = (_loc10_ as TinyUI).getBoundRect(this);
               }
               else
               {
                  _loc7_ = _loc10_.getBounds(this);
                  if(_loc7_.width == 0 || _loc7_.height == 0)
                  {
                     _loc7_.right = -2147483648;
                     _loc7_.x = 2147483647;
                     _loc7_.bottom = -2147483648;
                     _loc7_.y = 2147483647;
                  }
                  _loc11_ = _loc7_;
               }
               _loc3_ = _loc3_ > _loc11_.y ? _loc11_.y : _loc3_;
               _loc5_ = _loc5_ < _loc11_.bottom ? _loc11_.bottom : _loc5_;
               _loc6_ = _loc6_ > _loc11_.x ? _loc11_.x : _loc6_;
               _loc4_ = _loc4_ < _loc11_.right ? _loc11_.right : _loc4_;
               _loc9_++;
            }
            _loc12_.setTo(_loc6_,_loc3_,_loc4_ - _loc6_,_loc5_ - _loc3_);
         }
         else
         {
            _loc12_ = new Rectangle();
         }
         if(param1 != null)
         {
            _loc8_ = this.localToGlobal(new Point(0,0));
            _loc8_ = param1.globalToLocal(_loc8_);
            _loc12_.width += _loc8_.x;
            _loc12_.height += _loc8_.y;
         }
         return _loc12_;
      }
      
      final public function repaint() : void
      {
         var _loc2_:Boolean = false;
         if(_isValidate)
         {
            render();
            if(validateDic[SIZE])
            {
               _tWidth = _tHeight = -1;
            }
         }
         _readyRender = true;
         changAll(false);
         var _loc1_:DisplayObjectContainer = this.parent;
         if(null != layoutType && _loc1_)
         {
            if(this.parent is TinyUI)
            {
               _loc2_ = (this.parent as TinyUI)._readyRender;
               (this.parent as TinyUI)._readyRender = false;
            }
            this.parent.removeChild(this);
            switch(layoutType)
            {
               case "right":
                  this.x = _loc1_.width - this.width;
                  break;
               case "center":
                  this.x = _loc1_.width - this.width >> 1;
                  break;
               case "middle":
                  this.y = _loc1_.height - this.height >> 1;
                  break;
               case "bottom":
                  this.y = _loc1_.height - this.height;
            }
            _loc1_.addChild(this);
            if(this.parent is TinyUI)
            {
               (this.parent as TinyUI)._readyRender = _loc2_;
            }
         }
      }
      
      protected function changAll(param1:Boolean) : void
      {
         for(var _loc2_:String in _validateDic)
         {
            _validateDic[_loc2_] = param1;
         }
      }
      
      final protected function pushDisposeBitmap(param1:BitmapData) : void
      {
         if(param1 != null)
         {
            _disposeList.push(param1);
         }
      }
      
      public function __onAfterProp() : void
      {
      }
      
      public function render() : void
      {
         _index = _index + 1;
      }
      
      final public function validate(param1:String) : void
      {
         if(!_isValidate)
         {
            return;
         }
         _index = 0;
         if(_validateDic[param1] == null || _validateDic[param1] == false)
         {
            _validateDic[param1] = true;
            if(_readyRender)
            {
               RepaintManger.instance.addRenderComponent(this);
               _readyRender = false;
               _isValidate = true;
            }
         }
      }
      
      public function getMaxHeight() : Number
      {
         return height;
      }
      
      public function getMaxWidth() : Number
      {
         return width;
      }
      
      public function getScrollH() : Number
      {
         return x;
      }
      
      public function getScrollV() : Number
      {
         return y;
      }
      
      public function setScrollH(param1:Number) : void
      {
         x = param1;
      }
      
      public function setScrollV(param1:Number) : void
      {
         y = param1;
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         if(_isValidate)
         {
            RepaintManger.instance.removeRenderComponent(this);
            _isValidate = false;
            var _loc1_:int = int(_disposeList.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               ResourcesManager.instance.disposeBitmapData(_disposeList[_loc2_]);
               _loc2_++;
            }
            ObjectManger.instance.removeObject(_className,this);
            super.dispose();
            return;
         }
      }
      
      public function get validateDic() : Object
      {
         return _validateDic;
      }
      
      public function get xmlPath() : String
      {
         return _xmlPath;
      }
      
      public function set xmlPath(param1:String) : void
      {
         _xmlPath = param1;
      }
      
      public function getChildByPath(param1:String) : Object
      {
         var _loc4_:int = 0;
         var _loc3_:Array = param1.match(/[a-z,A-Z,0-9,_]+/g);
         var _loc2_:Object = this;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc2_ == null)
            {
               return null;
            }
            if(_loc2_.hasOwnProperty("getChildByName"))
            {
               _loc2_ = _loc2_.getChildByName(_loc3_[_loc4_]) as Object;
            }
            else
            {
               Director.instance.throwError("传入的目标对{invalid_utf8=232}{invalid_utf8=177}?" + this + "没有getChildByName方法");
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get className() : String
      {
         return _className;
      }
      
      override public function get height() : Number
      {
         if(_tHeight == -1)
         {
            return getBoundRect().height;
         }
         return _tHeight;
      }
      
      override public function set height(param1:Number) : void
      {
         _tHeight = param1;
         validate(SIZE);
      }
      
      override public function get width() : Number
      {
         if(_tWidth == -1)
         {
            return getBoundRect().width;
         }
         return _tWidth;
      }
      
      override public function set width(param1:Number) : void
      {
         _tWidth = param1;
         validate(SIZE);
      }
      
      public function get layoutType() : String
      {
         return _layoutType;
      }
      
      [Inspectable(type="String",enumeration="right,center,middle,bottom")]
      public function set layoutType(param1:String) : void
      {
         _layoutType = param1;
      }
   }
}

