package kingcontract
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class PresentComboxBox extends ComboBox
   {
      
      public static const P_friendBtn:String = "friendBtn";
      
      public static const P_consortiaBtn:String = "consortiaBtn";
      
      public static const FRIENDSELECTED:String = "friend_selected";
      
      public static const CONSORTIASELECTED:String = "consortia_selected";
      
      public static const SELECTTEXTFIELD:String = "select_textField";
      
      private var _friendBtnStyle:String;
      
      private var _consortiaBtnStyle:String;
      
      private var _friendBtn:SelectedCheckButton;
      
      private var _consortiaBtn:SelectedCheckButton;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _showView:Sprite;
      
      private var _autoSearchResultBox:PresentAutoSearchBox;
      
      private var _searchBoxHideTimeId:int;
      
      public function PresentComboxBox()
      {
         super();
      }
      
      override protected function init() : void
      {
         _buttonGroup = new SelectedButtonGroup();
         _showView = new Sprite();
         _autoSearchResultBox = new PresentAutoSearchBox();
         _autoSearchResultBox.visible = false;
         super.init();
         addEvent();
      }
      
      private function _friendClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispatchEvent(new Event("friend_selected"));
      }
      
      private function _consortiaClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispatchEvent(new Event("consortia_selected"));
      }
      
      private function addEvent() : void
      {
         _autoSearchResultBox.addEventListener("listItemMouseDown",__onSearchListItemClick);
      }
      
      private function removeEvent() : void
      {
         textField.removeEventListener("change",__textChangeHandler);
         textField.removeEventListener("click",__textClickHandler);
         textField.removeEventListener("focusOut",__textFocusOutHandler);
         _autoSearchResultBox.removeEventListener("listItemMouseDown",__onSearchListItemClick);
      }
      
      private function __onSearchListItemClick(param1:ListItemEvent) : void
      {
         var _loc2_:ThaneInfo = param1.cellValue as ThaneInfo;
         if(_loc2_)
         {
            _textField.text = _loc2_.nickName;
         }
      }
      
      public function get friendBtnStyle() : String
      {
         return _friendBtnStyle;
      }
      
      public function set friendBtnStyle(param1:String) : void
      {
         if(_friendBtnStyle == param1)
         {
            return;
         }
         _friendBtnStyle = param1;
         friendBtn = ComponentFactory.Instance.creat(_friendBtnStyle);
      }
      
      public function get friendBtn() : SelectedCheckButton
      {
         return _friendBtn;
      }
      
      public function set friendBtn(param1:SelectedCheckButton) : void
      {
         if(_friendBtn == param1)
         {
            return;
         }
         if(_friendBtn != null)
         {
            _buttonGroup.removeSelectItem(_friendBtn);
            _friendBtn.removeEventListener("click",_friendClick);
            ObjectUtils.disposeObject(_friendBtn);
         }
         _friendBtn = param1;
         _friendBtn.addEventListener("click",_friendClick);
         _buttonGroup.addSelectItem(_friendBtn);
         onPropertiesChanged("friendBtn");
      }
      
      public function get consortiaBtnStyle() : String
      {
         return _consortiaBtnStyle;
      }
      
      public function set consortiaBtnStyle(param1:String) : void
      {
         if(_consortiaBtnStyle == param1)
         {
            return;
         }
         _consortiaBtnStyle = param1;
         consortiaBtn = ComponentFactory.Instance.creat(_consortiaBtnStyle);
      }
      
      public function get consortiaBtn() : SelectedCheckButton
      {
         return _consortiaBtn;
      }
      
      public function set consortiaBtn(param1:SelectedCheckButton) : void
      {
         if(_consortiaBtn == param1)
         {
            return;
         }
         if(_consortiaBtn != null)
         {
            _buttonGroup.removeSelectItem(_consortiaBtn);
            _consortiaBtn.removeEventListener("click",_consortiaClick);
            ObjectUtils.disposeObject(_consortiaBtn);
         }
         _consortiaBtn = param1;
         _consortiaBtn.addEventListener("click",_consortiaClick);
         _buttonGroup.addSelectItem(_consortiaBtn);
         _buttonGroup.selectIndex = 0;
         onPropertiesChanged("consortiaBtn");
      }
      
      override public function doHide() : void
      {
         if(_state == HIDE)
         {
            return;
         }
         if(_button is SelectedButton)
         {
            (_button as SelectedButton).selected = false;
         }
         _defaultShowState = 0;
         TweenLite.killTweensOf(_listPanel);
         TweenLite.to(_showView,ComponentSetting.COMBOBOX_HIDE_TIME,{
            "y":_comboboxZeroPos.y - _listPanel.height,
            "ease":ComponentSetting.COMBOBOX_HIDE_EASE_FUNCTION,
            "onComplete":onHideComplete
         });
         _state = HIDE;
      }
      
      override public function doShow() : void
      {
         if(_state == SHOW)
         {
            return;
         }
         onPosChanged();
         _defaultShowState = 1;
         if(_listPanel)
         {
            _showView.addChild(_listPanel);
            ComponentSetting.COMBOX_LIST_LAYER.addChild(_showView);
         }
         ComponentSetting.COMBOX_LIST_LAYER.addChild(_maskShape);
         TweenLite.killTweensOf(_showView);
         TweenLite.to(_showView,ComponentSetting.COMBOBOX_SHOW_TIME,{
            "y":_comboboxZeroPos.y + _listInnerRect.para2,
            "ease":ComponentSetting.COMBOBOX_SHOW_EASE_FUNCTION
         });
         _state = SHOW;
      }
      
      override public function set textField(param1:TextField) : void
      {
         if(_textField == param1)
         {
            return;
         }
         _textField = param1;
         _autoSearchResultBox.x = _textField.x - 4;
         _autoSearchResultBox.y = _textField.y + _textField.height + 8;
         onPropertiesChanged("textField");
      }
      
      override public function set textStyle(param1:String) : void
      {
         super.textStyle = param1;
         textField.addEventListener("change",__textChangeHandler);
         textField.addEventListener("click",__textClickHandler);
         textField.addEventListener("focusOut",__textFocusOutHandler);
      }
      
      private function __textChangeHandler(param1:Event) : void
      {
         _autoSearchResultBox.setSearchString(_textField.text);
         _autoSearchResultBox.visible = _autoSearchResultBox.resultList.length > 0;
      }
      
      private function __textClickHandler(param1:MouseEvent) : void
      {
         __textChangeHandler(null);
      }
      
      private function __textFocusOutHandler(param1:FocusEvent) : void
      {
         clearTimeout(_searchBoxHideTimeId);
         _searchBoxHideTimeId = setTimeout(hideSearchBox,50);
      }
      
      private function hideSearchBox() : void
      {
         clearTimeout(_searchBoxHideTimeId);
         if(_autoSearchResultBox)
         {
            _autoSearchResultBox.visible = false;
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_autoSearchResultBox)
         {
            addChild(_autoSearchResultBox);
         }
      }
      
      override protected function onHideComplete() : void
      {
         if(_showView && _showView.parent)
         {
            _showView.parent.removeChild(_showView);
         }
         if(_maskShape && _maskShape.parent)
         {
            _maskShape.parent.removeChild(_maskShape);
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["textInnerRect"] || _changedPropeties["height"] || _changedPropeties["width"])
         {
            _autoSearchResultBox.x = _textField.x - 4;
            _autoSearchResultBox.y = _textField.y + _textField.height + 8;
         }
         if(_changedPropeties["listInnerRect"] || _changedPropeties["height"] || _changedPropeties["width"] || _changedPropeties["currentShowState"] || _changedPropeties["listPanel"])
         {
            _showView.addChild(_listPanel);
            onPosChanged();
            updateListSize();
            if(_listPanel)
            {
               _listPanel.list.addStateListener(updateListSize);
            }
         }
         if(_changedPropeties["friendBtn"] || _changedPropeties["consortiaBtn"])
         {
            if(_friendBtn && _friendBtn.parent == null)
            {
               _showView.addChild(_friendBtn);
            }
            if(_consortiaBtn && _consortiaBtn.parent == null)
            {
               _showView.addChild(_consortiaBtn);
            }
            onPosChanged();
            updateListSize();
         }
      }
      
      override protected function updateListPos() : void
      {
         if(_listInnerRect == null || _listPanel == null)
         {
            return;
         }
         var _loc1_:Rectangle = _listInnerRect.getInnerRect(_width,_height);
         _showView.x = _comboboxZeroPos.x + _loc1_.x;
         _showView.y = _comboboxZeroPos.y + _loc1_.y;
         if(_defaultShowState == 0)
         {
            _showView.y = _comboboxZeroPos.y - _showView.height;
         }
         else if(_defaultShowState == 1)
         {
            _showView.y = _comboboxZeroPos.y + _listInnerRect.para2;
         }
      }
      
      override protected function updateListSize(param1:InteractiveEvent = null) : void
      {
         if(_listPanel == null)
         {
            return;
         }
         var _loc2_:Rectangle = _listInnerRect.getInnerRect(_width,_height);
         if(_snapItemHeight)
         {
            _listPanel.height = _listPanel.list.getViewSize().height + _listPanel.getShowHScrollbarExtendHeight();
         }
         else
         {
            _listPanel.height = _loc2_.height;
         }
         _listPanel.width = _loc2_.width;
         _maskShape = DisplayUtils.drawRectShape(_showView.width + 2 * _maskExtends,_showView.height + _maskExtends * 2,_maskShape);
         updateMask();
      }
      
      override protected function updateMask() : void
      {
         if(!_listPanel)
         {
            return;
         }
         _showView.mask = _maskShape;
         _maskShape.x = _comboboxZeroPos.x - _maskExtends;
         _maskShape.y = _comboboxZeroPos.y + _height;
      }
      
      override protected function __onStageClick(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(DisplayUtils.isTargetOrContain(_loc2_,_friendBtn) || Boolean(DisplayUtils.isTargetOrContain(_loc2_,_consortiaBtn)))
         {
            return;
         }
         if(!DisplayUtils.isTargetOrContain(_loc2_,this) && !DisplayUtils.isTargetOrContain(_loc2_,_listPanel))
         {
            return;
         }
         if(DisplayUtils.isTargetOrContain(_loc2_,_button) || Boolean(DisplayUtils.isTargetOrContain(_loc2_,_listPanel.list)))
         {
            if(_state == HIDE)
            {
               doShow();
            }
            else
            {
               doHide();
            }
         }
         if(DisplayUtils.isTargetOrContain(_loc2_,_textField))
         {
            doHide();
            dispatchEvent(new Event("select_textField"));
         }
      }
      
      override protected function __onStageDown(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(DisplayUtils.isTargetOrContain(_loc2_,_friendBtn) || Boolean(DisplayUtils.isTargetOrContain(_loc2_,_consortiaBtn)))
         {
            return;
         }
         if(DisplayUtils.isTargetOrContain(_loc2_,_listPanel) || Boolean(DisplayUtils.isTargetOrContain(_loc2_,this)))
         {
            return;
         }
         doHide();
      }
      
      public function get textValue() : String
      {
         return _textField.text;
      }
      
      public function set textValue(param1:String) : void
      {
         if(_textField.text == param1)
         {
            return;
         }
         _textField.text = param1;
      }
      
      override public function dispose() : void
      {
         clearTimeout(_searchBoxHideTimeId);
         removeEvent();
         _buttonGroup = null;
         if(_friendBtn)
         {
            ObjectUtils.disposeObject(_friendBtn);
         }
         _friendBtn = null;
         if(_consortiaBtn)
         {
            ObjectUtils.disposeObject(_consortiaBtn);
         }
         _consortiaBtn = null;
         if(_autoSearchResultBox)
         {
            _autoSearchResultBox.dispose();
         }
         _autoSearchResultBox = null;
         super.dispose();
      }
   }
}

