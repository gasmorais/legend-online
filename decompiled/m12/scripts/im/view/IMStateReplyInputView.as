package im.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import managers.IMManager;
   import mvc.module.friends.IMModel;
   import mvc.module.friends.IMStateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class IMStateReplyInputView extends Frame
   {
      
      private var _tipTxt:FilterFrameText;
      
      private var _inputTxt:FilterFrameText;
      
      private var _inputBg:ScaleBitmapImage;
      
      private var _confirmBtn:TextButton;
      
      private var _cancleBtn:TextButton;
      
      private var _data:IMStateInfo;
      
      private var _tempStr:String = "";
      
      public function IMStateReplyInputView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("friends.IMStateReplyInputTipTxt");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("friends.IMStateReplyInputTxt");
         _inputBg = ComponentFactory.Instance.creatComponentByStylename("friends.IMStateReplyInputBg");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("friends.IMStateReplyInputConfirmBtn");
         _cancleBtn = ComponentFactory.Instance.creatComponentByStylename("friends.IMStateReplyInputCancleBtn");
         _tipTxt.text = LanguageMgr.GetTranslation("friends.im.view.IMStateReplyInputView.inputTip");
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm");
         _cancleBtn.text = LanguageMgr.GetTranslation("public.cancel");
         addToContent(_tipTxt);
         addToContent(_inputBg);
         addToContent(_inputTxt);
         addToContent(_confirmBtn);
         addToContent(_cancleBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _inputTxt.addEventListener("change",__inputNameHandler);
         _confirmBtn.addEventListener("click",__onConfirmClick);
         _cancleBtn.addEventListener("click",__onCloseClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _inputTxt.removeEventListener("change",__inputNameHandler);
         _confirmBtn.removeEventListener("click",__onConfirmClick);
         _cancleBtn.removeEventListener("click",__onCloseClick);
      }
      
      private function __inputNameHandler(param1:Event) : void
      {
         if(StringHelper.checkStringLength(_inputTxt.text) > 60)
         {
            _inputTxt.text = _tempStr;
         }
         _tempStr = _inputTxt.text;
      }
      
      private function __onConfirmClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(_data && _inputTxt)
         {
            _loc2_ = StringHelper.trimRight(_inputTxt.text);
            if(StringHelper.isNullOrEmpty(_loc2_))
            {
               _loc2_ = LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.leaveReply");
            }
            if(_loc2_ != FilterWordManager.filterWrod(_loc2_))
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.im.view.IMStateReplyInputView.dirtyWordTip"));
               return;
            }
            if(_data.id != imModel.curState || _data.replyContent != _loc2_)
            {
               IMManager.instance.sendChangeIMState(_data.id,_loc2_);
            }
         }
         dispose();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
            case 4:
               dispose();
               break;
            case 2:
            case 3:
               __onConfirmClick(null);
         }
      }
      
      public function refreshView() : void
      {
         if(_data)
         {
            _inputTxt.text = _data.replyContent;
            _inputTxt.setSelection(0,_inputTxt.length);
            _inputTxt.setFocus();
         }
      }
      
      public function set data(param1:IMStateInfo) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         refreshView();
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,false,false,1);
      }
      
      private function get imModel() : IMModel
      {
         return IMManager.instance.model;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         if(_tipTxt)
         {
            _tipTxt.dispose();
         }
         _tipTxt = null;
         if(_inputTxt)
         {
            _inputTxt.dispose();
         }
         _inputTxt = null;
         if(_inputBg)
         {
            _inputBg.dispose();
         }
         _inputBg = null;
         if(_confirmBtn)
         {
            _confirmBtn.dispose();
         }
         _confirmBtn = null;
         if(_cancleBtn)
         {
            _cancleBtn.dispose();
         }
         _cancleBtn = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

