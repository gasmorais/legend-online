package yishi.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckHtmlButton;
   import com.pickgliss.ui.controls.alert.SimpleAlert;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.SimpleAlertHelper;
   
   public class UseBindPointWithChoiceAutoLayoutAlert extends SimpleAlert
   {
      
      public static const P_useBindPointStyle:String = "useBindPointStyle";
      
      public static const P_notJoinActStyle:String = "notJoinActStyle";
      
      public static const P_choiceStyle:String = "choiceStyle";
      
      protected var _choiceBtn:SelectedCheckHtmlButton;
      
      protected var _choiceStyle:String;
      
      protected var _useBindPointBtn:SelectedCheckHtmlButton;
      
      protected var _notJoinActTxt:FilterFrameText;
      
      protected var _usebindPointStyle:String;
      
      protected var _notJoinActStyle:String;
      
      public function UseBindPointWithChoiceAutoLayoutAlert()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(_useBindPointBtn)
         {
            _useBindPointBtn.removeEventListener("click",__useBindPointBtnClickHandler);
         }
         ObjectUtils.disposeObject(_choiceBtn);
         _choiceBtn = null;
         ObjectUtils.disposeObject(_useBindPointBtn);
         _useBindPointBtn = null;
         ObjectUtils.disposeObject(_notJoinActTxt);
         _notJoinActTxt = null;
         super.dispose();
      }
      
      public function set choiceStyle(param1:String) : void
      {
         if(_choiceStyle == param1)
         {
            return;
         }
         _choiceStyle = param1;
         _choiceBtn = ComponentFactory.Instance.creatComponentByStylename(_choiceStyle);
         _choiceBtn.text = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.useBind");
      }
      
      public function get choiceStyle() : String
      {
         return _choiceStyle;
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
         _useBindPointBtn.addEventListener("click",__useBindPointBtnClickHandler);
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
      
      private function __useBindPointBtnClickHandler(param1:MouseEvent) : void
      {
         if(_useBindPointBtn.selected)
         {
            _choiceBtn.selected = true;
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_choiceBtn)
         {
            addChild(_choiceBtn);
            _choiceBtn.selected = false;
         }
         if(_useBindPointBtn)
         {
            addChild(_useBindPointBtn);
            _useBindPointBtn.selected = false;
         }
         if(_notJoinActTxt)
         {
            addChild(_notJoinActTxt);
         }
      }
      
      override protected function updateMsg() : void
      {
         super.updateMsg();
         if(info.choiceString)
         {
            _choiceBtn.text = _info.choiceString;
         }
         if(info.useBindTip)
         {
            _useBindPointBtn.text = info.useBindTip;
         }
         if(_smallTipTxt)
         {
            _smallTipTxt.width = _textField.width;
            _smallTipTxt.htmlText = _info.smallTip;
            _smallTipTxt.height = _smallTipTxt.textHeight + 5;
         }
      }
      
      override protected function layoutFrameRect() : void
      {
         super.layoutFrameRect();
         var _loc1_:Boolean = false;
         if(_choiceBtn)
         {
            _choiceBtn.x = _textField.x + (_textField.width - _choiceBtn.width) / 2;
            _choiceBtn.y = _textField.y + _textField.height + 5;
            _loc1_ = true;
         }
         if(_useBindPointBtn)
         {
            if(_loc1_)
            {
               _useBindPointBtn.x = _choiceBtn.x;
            }
            else
            {
               _useBindPointBtn.x = _textField.x + (_textField.width - _useBindPointBtn.width) / 2;
            }
            _useBindPointBtn.y = _choiceBtn.y + _choiceBtn.height + 5;
         }
         if(_smallTipTxt.text != "")
         {
            _smallTipTxt.x = _textField.x + (_textField.width - _smallTipTxt.width) / 2;
            _smallTipTxt.y = _useBindPointBtn.y + _useBindPointBtn.height + 5;
         }
         if(_notJoinActTxt)
         {
            _notJoinActTxt.x = _useBindPointBtn.x + 190;
            _notJoinActTxt.y = _useBindPointBtn.y + 3;
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
            if(_choiceBtn && _choiceBtn.selected)
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
      
      override protected function onResponse(param1:int, param2:Boolean = true) : void
      {
         SimpleAlertHelper.instance.addBackCallData(_choiceBtn.selected);
         super.onResponse(param1,_useBindPointBtn.selected);
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

