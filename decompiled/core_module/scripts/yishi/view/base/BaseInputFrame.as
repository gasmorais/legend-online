package yishi.view.base
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.system.IME;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   
   public class BaseInputFrame extends Frame
   {
      
      protected var _back:MutipleImage;
      
      protected var _confirmBtn:TextButton;
      
      protected var _alertTxt:FilterFrameText;
      
      protected var _inputTxt:FilterFrameText;
      
      protected var _describtTxt:FilterFrameText;
      
      private var _backCall:Function;
      
      private var _inputFocuseTxt:String = "";
      
      private var _txtChange:String = "";
      
      public function BaseInputFrame()
      {
         super();
         enterEnable = true;
         escEnable = true;
         initView();
         initText();
         initEvent();
      }
      
      public function set backCall(param1:Function) : void
      {
         _backCall = param1;
      }
      
      protected function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("core.BaseInputFrameBack");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.BaseInputFrameBtn");
         _alertTxt = ComponentFactory.Instance.creatComponentByStylename("core.BaseInputFrameAlertTxt");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("core.BaseInputFrameInputTxt");
         _describtTxt = ComponentFactory.Instance.creatComponentByStylename("core.BaseInputFrameDescribeTxt");
         addToContent(_back);
         addToContent(_confirmBtn);
         addToContent(_alertTxt);
         addToContent(_inputTxt);
         addToContent(_describtTxt);
      }
      
      protected function initText() : void
      {
         _titleText = LanguageMgr.GetTranslation("yishi.view.base.BaseInputFrame.title");
         _alertTxt.text = LanguageMgr.GetTranslation("yishi.view.base.BaseInputFrame.alert");
         _inputTxt.text = _inputFocuseTxt;
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm");
         _describtTxt.text = "";
      }
      
      public function set inputText(param1:String) : void
      {
         _alertTxt.text = param1;
      }
      
      public function set inputFocuseText(param1:String) : void
      {
         _inputTxt.text = param1;
         _inputFocuseTxt = param1;
      }
      
      public function set displayAsPassword(param1:Boolean) : void
      {
         _inputTxt.displayAsPassword = param1;
      }
      
      public function set restrict(param1:String) : void
      {
         _inputTxt.restrict = param1;
      }
      
      public function set describtText(param1:String) : void
      {
         _describtTxt.text = param1;
      }
      
      protected function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         addEventListener("addedToStage",__onAddedToStage);
         _inputTxt.addEventListener("focusIn",__focuseInHandler);
         _inputTxt.addEventListener("focusOut",__focuseOutHandler);
         _inputTxt.addEventListener("keyDown",__keyDownHandler);
         _inputTxt.addEventListener("change",__textChangeHandler);
         _confirmBtn.addEventListener("click",__confirmHandler);
         _inputTxt.addEventListener("change",__onTxtChange);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         removeEventListener("addedToStage",__onAddedToStage);
         _inputTxt.removeEventListener("focusIn",__focuseInHandler);
         _inputTxt.removeEventListener("focusOut",__focuseOutHandler);
         _inputTxt.removeEventListener("keyDown",__keyDownHandler);
         _inputTxt.removeEventListener("change",__textChangeHandler);
         _confirmBtn.removeEventListener("click",__confirmHandler);
         _inputTxt.removeEventListener("change",__onTxtChange);
      }
      
      private function __onTxtChange(param1:Event) : void
      {
         var _loc2_:int = _inputTxt.text.replace(/[^\x00-\xff]/g,"xx").length;
         if(_loc2_ > 14)
         {
            _inputTxt.text = _txtChange;
         }
         _txtChange = _inputTxt.text;
      }
      
      protected function __onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",__onAddedToStage);
         stage.focus = _inputTxt;
      }
      
      protected function __focuseInHandler(param1:FocusEvent) : void
      {
         IME.enabled = true;
         param1.stopPropagation();
         if(_inputTxt.text == _inputFocuseTxt)
         {
            _inputTxt.text = "";
         }
      }
      
      protected function __focuseOutHandler(param1:FocusEvent) : void
      {
         IME.enabled = false;
         param1.stopPropagation();
         if(_inputTxt.text == "")
         {
            _inputTxt.text = _inputFocuseTxt;
         }
      }
      
      protected function __confirmHandler(param1:MouseEvent) : void
      {
         if(_backCall != null)
         {
            _backCall(_inputTxt.text);
         }
         dispose();
      }
      
      private function __textChangeHandler(param1:Event) : void
      {
         check();
      }
      
      protected function check() : void
      {
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         switch(int(param1.keyCode) - 13)
         {
            case 0:
               __confirmHandler(null);
               break;
            case 14:
               dispose();
         }
         param1.stopPropagation();
      }
      
      protected function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
               __confirmHandler(null);
         }
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         _backCall = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

