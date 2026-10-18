package gamehall.room
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.ComboBox;
   import flash.geom.Rectangle;
   
   public class GameHallComboBox extends ComboBox
   {
      
      protected var _maskHeightExtends:int = 20;
      
      protected var _listHeightExtends:int = 3;
      
      public function GameHallComboBox()
      {
         super();
      }
      
      override protected function updateMask() : void
      {
         if(!_listPanel)
         {
            return;
         }
         _listPanel.mask = _maskShape;
         _maskShape.x = _comboboxZeroPos.x - _maskExtends;
         _maskShape.y = _comboboxZeroPos.y - _listPanel.height - _maskHeightExtends;
      }
      
      override protected function updateListPos() : void
      {
         if(_listInnerRect == null || _listPanel == null)
         {
            return;
         }
         var _loc1_:Rectangle = _listInnerRect.getInnerRect(_width,_height);
         _listPanel.x = _comboboxZeroPos.x + _loc1_.x;
         _listPanel.y = _comboboxZeroPos.y + _loc1_.y;
         if(_defaultShowState == 0)
         {
            _listPanel.y = _comboboxZeroPos.y + _listInnerRect.para2;
         }
         else if(_defaultShowState == 1)
         {
            _listPanel.y = _comboboxZeroPos.y - _listPanel.height - _listHeightExtends;
         }
      }
      
      override public function doHide() : void
      {
         if(_state == HIDE)
         {
            return;
         }
         if(_listPanel.vectorListModel.getSize() == 0)
         {
            return;
         }
         _defaultShowState = 0;
         TweenLite.killTweensOf(_listPanel);
         TweenLite.to(_listPanel,ComponentSetting.COMBOBOX_HIDE_TIME,{
            "y":direction * (_comboboxZeroPos.y + _listInnerRect.para2),
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
         if(_listPanel.vectorListModel.getSize() == 0)
         {
            return;
         }
         onPosChanged();
         _defaultShowState = 1;
         if(_listPanel)
         {
            ComponentSetting.COMBOX_LIST_LAYER.addChild(_listPanel.asDisplayObject());
         }
         ComponentSetting.COMBOX_LIST_LAYER.addChild(_maskShape);
         TweenLite.killTweensOf(_listPanel);
         TweenLite.to(_listPanel,ComponentSetting.COMBOBOX_SHOW_TIME,{
            "y":_comboboxZeroPos.y - direction * _listPanel.height - _listHeightExtends,
            "ease":ComponentSetting.COMBOBOX_SHOW_EASE_FUNCTION
         });
         _state = SHOW;
      }
   }
}

