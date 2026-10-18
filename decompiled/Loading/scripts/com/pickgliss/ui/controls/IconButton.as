package com.pickgliss.ui.controls
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   
   public class IconButton extends AbstractTextButton
   {
      
      public static const P_icon:String = "icon";
      
      public static const P_iconInnerRect:String = "iconInnerRect";
      
      public var iconFrameChange:Boolean = true;
      
      protected var _icon:DisplayObject;
      
      protected var _iconInnerRect:InnerRectangle;
      
      protected var _iconInnerRectString:String;
      
      protected var _iconStyle:String;
      
      protected var _autoCenter:Boolean = true;
      
      protected var _offSetX:Number = 0;
      
      protected var _offSetY:Number = 0;
      
      public function IconButton()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
         }
         _icon = null;
         super.dispose();
      }
      
      public function get icon() : DisplayObject
      {
         return _icon;
      }
      
      public function set icon(param1:DisplayObject) : void
      {
         if(_icon == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_icon);
         _icon = param1;
         onPropertiesChanged("icon");
      }
      
      public function set iconInnerRectString(param1:String) : void
      {
         if(_iconInnerRectString == param1)
         {
            return;
         }
         _iconInnerRectString = param1;
         _iconInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_iconInnerRectString));
         onPropertiesChanged("iconInnerRect");
      }
      
      public function get iconInnerRectString() : String
      {
         return _iconInnerRectString;
      }
      
      public function set iconStyle(param1:String) : void
      {
         if(_iconStyle == param1)
         {
            return;
         }
         _iconStyle = param1;
         icon = ComponentFactory.Instance.creat(_iconStyle);
      }
      
      public function get iconStyle() : String
      {
         return _iconStyle;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_icon)
         {
            addChild(_icon);
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["width"] || _changedPropeties["height"] || _changedPropeties["iconInnerRect"] || _changedPropeties["icon"])
         {
            this.updataOtherPropperties();
         }
      }
      
      protected function updataOtherPropperties() : void
      {
         if(this._autoCenter)
         {
            this.autoDisplayCenter();
         }
         else
         {
            updateIconPos();
         }
      }
      
      protected function updateIconPos() : void
      {
         if(_icon && _iconInnerRect)
         {
            DisplayUtils.layoutDisplayWithInnerRect(_icon,_iconInnerRect,_width,_height);
         }
      }
      
      override public function setFrame(param1:int) : void
      {
         super.setFrame(param1);
         if(iconFrameChange)
         {
            DisplayUtils.setFrame(_icon,param1);
         }
      }
      
      protected function autoDisplayCenter() : void
      {
         if(!this._back)
         {
            return;
         }
         if(!_icon)
         {
            return;
         }
         if(_icon is Bitmap && (this._back.width > 0 && this._back.height > 0))
         {
            _icon.scaleX = 1;
            _icon.scaleY = 1;
            this._back.x = 0;
            this._back.y = 0;
            _icon.x = (this._back.width - _icon.width) / 2;
            _icon.y = (this._back.height - _icon.height) / 2;
            _icon.x += this._offSetX;
            _icon.y += this._offSetY;
         }
      }
      
      public function set autoCenter(param1:Boolean) : void
      {
         _autoCenter = param1;
         this.updataOtherPropperties();
      }
      
      public function get autoCenter() : Boolean
      {
         return _autoCenter;
      }
      
      public function set offSetX(param1:Number) : void
      {
         this._offSetX = param1;
         this.updataOtherPropperties();
      }
      
      public function get offSetX() : Number
      {
         return this._offSetX;
      }
      
      public function set offSetY(param1:Number) : void
      {
         this._offSetY = param1;
         this.updataOtherPropperties();
      }
      
      public function get offSetY() : Number
      {
         return this._offSetY;
      }
   }
}

