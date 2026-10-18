package com.pickgliss.ui.controls
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   [Event(name="select",type="flash.events.Event")]
   public class SelectedButton extends BaseButton implements ISelectable
   {
      
      public static const P_frameFilters:String = "frameFilters";
      
      public static const P_selectedStyle:String = "selectedStyle";
      
      public static const P_unSelectedStyle:String = "unSelectedStyle";
      
      protected var _selected:Boolean;
      
      protected var _selectedButton:DisplayObject;
      
      protected var _selectedStyle:String;
      
      protected var _unSelectedButton:DisplayObject;
      
      protected var _unSelectedStyle:String;
      
      private var _autoSelect:Boolean = true;
      
      public function SelectedButton()
      {
         super();
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
         if(_autoSelect == param1)
         {
            return;
         }
         _autoSelect = param1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_selectedButton);
         _selectedButton = null;
         ObjectUtils.disposeObject(_unSelectedButton);
         _unSelectedButton = null;
         super.dispose();
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_selectedButton)
         {
            _selectedButton.visible = _selected;
         }
         if(_unSelectedButton)
         {
            _unSelectedButton.visible = !_selected;
         }
         dispatchEvent(new Event("select"));
         drawHitArea();
      }
      
      public function get selectedStyle() : String
      {
         return _selectedStyle;
      }
      
      public function set selectedStyle(param1:String) : void
      {
         if(_selectedStyle == param1)
         {
            return;
         }
         _selectedStyle = param1;
         onPropertiesChanged("selectedStyle");
      }
      
      public function setSelectedButton(param1:DisplayObject) : void
      {
         ObjectUtils.disposeObject(_selectedButton);
         _selectedButton = param1;
         DisplayUtils.setDisplayObjectNotEnable(_selectedButton);
         setFrame(1);
      }
      
      public function setUnselectedButton(param1:DisplayObject) : void
      {
         ObjectUtils.disposeObject(_unSelectedButton);
         _unSelectedButton = param1;
         DisplayUtils.setDisplayObjectNotEnable(_unSelectedButton);
         setFrame(1);
      }
      
      public function get unSelectedStyle() : String
      {
         return _unSelectedStyle;
      }
      
      public function set unSelectedStyle(param1:String) : void
      {
         if(_unSelectedStyle == param1)
         {
            return;
         }
         _unSelectedStyle = param1;
         onPropertiesChanged("unSelectedStyle");
      }
      
      override protected function __onMouseClick(param1:MouseEvent) : void
      {
         super.__onMouseClick(param1);
         if(_autoSelect)
         {
            selected = !_selected;
         }
      }
      
      override protected function adaptHitArea() : void
      {
         if(!_selectedButton || !_unSelectedButton)
         {
            return;
         }
         _PNGHitArea.alpha = 0;
         _PNGHitArea.x = _selected ? _selectedButton.x : _unSelectedButton.x;
         _PNGHitArea.y = _selected ? _selectedButton.y : _unSelectedButton.y;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_selectedButton)
         {
            addChild(_selectedButton);
         }
         if(_unSelectedButton)
         {
            addChild(_unSelectedButton);
         }
      }
      
      override protected function getBitmap() : Bitmap
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:Bitmap = null;
         var _loc4_:BitmapData = null;
         var _loc3_:BitmapData = null;
         _loc2_ = _selected ? _selectedButton : _unSelectedButton;
         if(!_loc2_)
         {
            return new Bitmap();
         }
         if(_loc2_ is Component)
         {
            _loc4_ = new BitmapData(Component(_loc2_).displayWidth,Component(_loc2_).displayWidth,true,0);
            _loc4_.draw(_loc2_);
            _loc1_ = new Bitmap(_loc4_);
         }
         else if(_loc2_ is Bitmap)
         {
            _loc1_ = Bitmap(_loc2_);
         }
         else
         {
            _loc3_ = new BitmapData(_loc2_.width,_loc2_.height,true,0);
            _loc3_.draw(_loc2_);
            _loc1_ = new Bitmap(_loc3_);
         }
         return _loc1_;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["unSelectedStyle"])
         {
            setUnselectedButton(ComponentFactory.Instance.creat(_unSelectedStyle));
            selected = _selected;
            if(_selectedButton)
            {
               _width = _selectedButton.width;
               _height = _selectedButton.height;
            }
         }
         if(_changedPropeties["selectedStyle"])
         {
            setSelectedButton(ComponentFactory.Instance.creat(_selectedStyle));
            selected = _selected;
            if(_unSelectedButton)
            {
               _width = _unSelectedButton.width;
               _height = _unSelectedButton.height;
            }
         }
      }
      
      override public function setFrame(param1:int) : void
      {
         super.setFrame(param1);
         if(_selectedButton)
         {
            DisplayUtils.setFrame(_selectedButton,_currentFrameIndex);
         }
         if(_unSelectedButton)
         {
            DisplayUtils.setFrame(_unSelectedButton,_currentFrameIndex);
         }
      }
   }
}

