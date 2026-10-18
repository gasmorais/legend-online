package yishi.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.SimpleAlert;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   
   public class WithChoiceAlert extends SimpleAlert
   {
      
      public static const P_choiceStyle:String = "choiceStyle";
      
      protected var _choiceBtn:SelectedCheckButton;
      
      protected var _choiceStyle:String;
      
      public function WithChoiceAlert()
      {
         super();
      }
      
      public function set choiceStyle(param1:String) : void
      {
         if(_choiceStyle == param1)
         {
            return;
         }
         _choiceStyle = param1;
         _choiceBtn = ComponentFactory.Instance.creatComponentByStylename(_choiceStyle);
         onPropertiesChanged("choiceStyle");
      }
      
      public function get choiceStyle() : String
      {
         return _choiceStyle;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_choiceBtn)
         {
            addChild(_choiceBtn);
            _choiceBtn.selected = true;
         }
      }
      
      override protected function layoutFrameRect() : void
      {
         var _loc2_:Boolean = false;
         if(_choiceBtn)
         {
            _choiceBtn.text = _info.choiceString;
            if(_smallTipTxt.text != "")
            {
               _choiceBtn.x = _textField.x + (_textField.width - _choiceBtn.width) / 2;
               _choiceBtn.y = _textField.y + _textField.textHeight + 15;
            }
            else if(_textField.numLines > 1)
            {
               _textField.y = 25;
            }
            else
            {
               _textField.y = 40;
            }
         }
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
         _height = _textField.textHeight + 120 > _frameMiniH ? _textField.textHeight + 120 : _frameMiniH;
         if(_smallTipTxt)
         {
            _smallTipTxt.width = _textField.width;
            _smallTipTxt.x = _textField.x + (_textField.width - _smallTipTxt.width) / 2;
            _smallTipTxt.y = _textField.y + _textField.textHeight - 5;
         }
         if(_choiceBtn)
         {
            _choiceBtn.x = _textField.x + (_textField.width - _choiceBtn.width) / 2;
            _choiceBtn.y = _textField.y + _textField.textHeight + 16;
         }
         if(_info.extraData && _info.extraData.hasOwnProperty("isActivityCampaign"))
         {
            _loc2_ = Boolean(_info.extraData["isActivityCampaign"]);
            _choiceBtn.visible = !_loc2_;
         }
      }
      
      override protected function __onSubmitClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(info.extraData)
         {
            _loc2_ = int(info.extraData);
            _loc5_ = PlayerManager.instance.currentPlayerModel.playerInfo.point;
            _loc4_ = PlayerManager.instance.currentPlayerModel.playerInfo.giftToken;
            _loc3_ = int(_choiceBtn.selected ? _loc5_ + _loc4_ : _loc5_);
            if(_loc3_ < _loc2_)
            {
               RechargeAlertMannager.show();
               return;
            }
            if(_submitSoundFunc != null)
            {
               _submitSoundFunc();
            }
            onResponse(3,_choiceBtn.selected);
            param1.stopPropagation();
         }
         else
         {
            if(_submitSoundFunc != null)
            {
               _submitSoundFunc();
            }
            onResponse(3,_choiceBtn.selected);
            param1.stopPropagation();
         }
      }
      
      override protected function __onCancelClick(param1:MouseEvent) : void
      {
         if(_submitSoundFunc != null)
         {
            _submitSoundFunc();
         }
         onResponse(0,_choiceBtn.selected);
         param1.stopPropagation();
         super.dispose();
      }
      
      override protected function __onCloseClick(param1:MouseEvent) : void
      {
         if(_submitSoundFunc != null)
         {
            _submitSoundFunc();
         }
         onResponse(4,_choiceBtn.selected);
         param1.stopPropagation();
         super.dispose();
      }
      
      override public function dispose() : void
      {
         if(_choiceBtn)
         {
            ObjectUtils.disposeObject(_smallTipTxt);
            _choiceBtn = null;
         }
         super.dispose();
      }
   }
}

