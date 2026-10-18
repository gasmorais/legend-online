package yishi.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.SimpleAlert;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   
   public class UseBindPointAlert extends SimpleAlert
   {
      
      public static const P_useBindPointStyle:String = "useBindPointStyle";
      
      public static const P_notJoinActStyle:String = "notJoinActStyle";
      
      protected var _useBindPointBtn:SelectedCheckButton;
      
      protected var _notJoinActTxt:FilterFrameText;
      
      protected var _usebindPointStyle:String;
      
      protected var _notJoinActStyle:String;
      
      public function UseBindPointAlert()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(_useBindPointBtn)
         {
            ObjectUtils.disposeObject(_smallTipTxt);
            _useBindPointBtn = null;
            _notJoinActTxt = null;
         }
         super.dispose();
      }
      
      public function set usebindPointStyle(param1:String) : void
      {
         if(_usebindPointStyle == param1)
         {
            return;
         }
         _usebindPointStyle = param1;
         _useBindPointBtn = ComponentFactory.Instance.creatComponentByStylename(_usebindPointStyle);
         _useBindPointBtn.text = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.useBind");
      }
      
      public function get usebindPointStyle() : String
      {
         return _usebindPointStyle;
      }
      
      public function set notJoinActStyle(param1:String) : void
      {
         if(_notJoinActStyle == param1)
         {
            return;
         }
         _notJoinActStyle = param1;
         _notJoinActTxt = ComponentFactory.Instance.creatComponentByStylename(_notJoinActStyle);
         _notJoinActTxt.text = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.promptTxt");
      }
      
      public function get notJoinActStyle() : String
      {
         return _notJoinActStyle;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_useBindPointBtn)
         {
            addChild(_useBindPointBtn);
            _useBindPointBtn.selected = true;
         }
         if(_notJoinActTxt)
         {
            addChild(_notJoinActTxt);
         }
      }
      
      override protected function layoutFrameRect() : void
      {
         super.layoutFrameRect();
         if(_useBindPointBtn)
         {
            if(_smallTipTxt.text != "")
            {
               if(_notJoinActTxt)
               {
                  _useBindPointBtn.x = _textField.x + (_textField.width - _useBindPointBtn.width) / 2;
                  _useBindPointBtn.y = _textField.y + _textField.textHeight + 15;
                  _notJoinActTxt.x = _textField.x + (_textField.width - _notJoinActTxt.width) / 2;
                  _notJoinActTxt.y = _useBindPointBtn.y + 23;
               }
               else
               {
                  _useBindPointBtn.x = _textField.x + (_textField.width - _useBindPointBtn.width) / 2;
                  _useBindPointBtn.y = _textField.y + _textField.textHeight + 15;
               }
            }
            else
            {
               _textField.y = 30;
               if(_notJoinActTxt)
               {
                  _useBindPointBtn.x = _textField.x + (_textField.width - _useBindPointBtn.width) / 2;
                  _useBindPointBtn.y = _textField.textHeight + 30;
                  _notJoinActTxt.x = _textField.x + (_textField.width - _notJoinActTxt.width) / 2;
                  _notJoinActTxt.y = _useBindPointBtn.y + 23;
               }
               else
               {
                  _useBindPointBtn.x = _textField.x + (_textField.width - _useBindPointBtn.width) / 2;
                  _useBindPointBtn.y = _textField.textHeight + 40;
               }
            }
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
            _loc3_ = int(_useBindPointBtn.selected ? _loc5_ + _loc4_ : _loc5_);
            if(_loc3_ < _loc2_)
            {
               RechargeAlertMannager.show();
               return;
            }
            if(_submitSoundFunc != null)
            {
               _submitSoundFunc();
            }
            onResponse(3,_useBindPointBtn.selected);
            param1.stopPropagation();
         }
         else
         {
            if(_submitSoundFunc != null)
            {
               _submitSoundFunc();
            }
            onResponse(3,_useBindPointBtn.selected);
            param1.stopPropagation();
         }
      }
      
      override protected function __onCancelClick(param1:MouseEvent) : void
      {
         if(_submitSoundFunc != null)
         {
            _submitSoundFunc();
         }
         onResponse(0,_useBindPointBtn.selected);
         param1.stopPropagation();
         super.dispose();
      }
      
      override protected function __onCloseClick(param1:MouseEvent) : void
      {
         if(_submitSoundFunc != null)
         {
            _submitSoundFunc();
         }
         onResponse(4,_useBindPointBtn.selected);
         param1.stopPropagation();
         super.dispose();
      }
   }
}

