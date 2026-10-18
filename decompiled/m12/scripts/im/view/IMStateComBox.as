package im.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.DisplayUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.IMManager;
   import mvc.module.friends.IMModel;
   import mvc.module.friends.IMStateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class IMStateComBox extends ComboBox
   {
      
      protected var _frameImageStyle:String;
      
      protected var _frameImage:ScaleFrameImage;
      
      public function IMStateComBox()
      {
         super();
         addEvent();
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("IMSTATE_CHANGE",__imStateChangeHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("IMSTATE_CHANGE",__imStateChangeHandler);
      }
      
      private function setTipData(param1:int) : void
      {
         switch(param1 - 4)
         {
            case 0:
               tipData = LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.leaveState");
               break;
            case 1:
               tipData = LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.noDisturb");
               break;
            case 2:
               tipData = LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.busyState");
               break;
            case 3:
               tipData = LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.onlineState");
         }
      }
      
      private function __imStateChangeHandler(param1:NotificationEvent) : void
      {
         var _loc2_:IMStateInfo = param1.data as IMStateInfo;
         if(_loc2_)
         {
            _currentSelectedCellValue = _loc2_;
            _currentSelectedItem = _listPanel.list.getItemByValue(_loc2_);
            _currentSelectedIndex = _listPanel.vectorListModel.indexOf(_loc2_);
            if(_frameImage)
            {
               _frameImage.setFrame(_loc2_.id);
            }
            setTipData(_loc2_.id);
            dispatchEvent(new InteractiveEvent("stateChange"));
         }
      }
      
      public function setData() : void
      {
         listPanel.vectorListModel.appendAll(imModel.stateList.getList());
         _frameImage.setFrame(imModel.curState);
         setTipData(imModel.curState);
      }
      
      public function set frameImageStyle(param1:String) : void
      {
         if(_frameImageStyle == param1)
         {
            return;
         }
         _frameImageStyle = param1;
         _frameImage = ComponentFactory.Instance.creat(_frameImageStyle);
         _frameImage.mouseEnabled = _frameImage.mouseChildren = false;
         _frameImage.setFrame(1);
      }
      
      public function get frameImage() : ScaleFrameImage
      {
         return _frameImage;
      }
      
      private function get imModel() : IMModel
      {
         return IMManager.instance.model;
      }
      
      override protected function __onItemChanged(param1:ListItemEvent) : void
      {
         var _loc3_:IMStateReplyInputView = null;
         var _loc2_:Point = null;
         var _loc4_:IMStateInfo = param1.cellValue as IMStateInfo;
         if(!_loc4_)
         {
            return;
         }
         if(_loc4_.id == 7)
         {
            if(imModel.curState == 7)
            {
               return;
            }
            IMManager.instance.sendChangeIMState(_loc4_.id,"");
         }
         else
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("friends.IMStateReplyInputView");
            _loc2_ = new Point(this.x,this.y);
            _loc2_ = localToGlobal(_loc2_);
            _loc3_.x = _loc2_.x - _loc3_.width;
            _loc3_.y = _loc2_.y + 50;
            _loc3_.data = _loc4_;
            _loc3_.show();
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_frameImage)
         {
            addChild(_frameImage);
         }
      }
      
      override protected function __onStageClick(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(!DisplayUtils.isTargetOrContain(_loc2_,this) && !DisplayUtils.isTargetOrContain(_loc2_,_listPanel))
         {
            return;
         }
         if(DisplayUtils.isTargetOrContain(_loc2_,_button))
         {
            doShow();
         }
         if(DisplayUtils.isTargetOrContain(_loc2_,_listPanel.list) || Boolean(DisplayUtils.isTargetOrContain(_loc2_,_textField)) || Boolean(DisplayUtils.isTargetOrContain(_loc2_,_frameImage)))
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
      }
      
      override public function doShow() : void
      {
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
            "y":direction * (_comboboxZeroPos.y + _listInnerRect.para2),
            "ease":ComponentSetting.COMBOBOX_SHOW_EASE_FUNCTION
         });
         _state = SHOW;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_frameImage)
         {
            _frameImage.dispose();
         }
         _frameImage = null;
         super.dispose();
      }
   }
}

