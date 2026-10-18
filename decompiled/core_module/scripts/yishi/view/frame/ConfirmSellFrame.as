package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.view.tips.MessageTipManager;
   
   public class ConfirmSellFrame extends Frame
   {
      
      private var _content:FilterFrameText;
      
      private var _icon:Bitmap;
      
      private var _inputBack:ScaleBitmapImage;
      
      private var _inputTxt:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _cancenBtn:IconButton;
      
      private var _contentValue:String;
      
      private var _callback:Function;
      
      private var _cell:Object;
      
      public function ConfirmSellFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatBitmap("asset.core.ConfirmSellIcon");
         _content = ComponentFactory.Instance.creatComponentByStylename("core.ConfirmSellContent");
         _inputBack = ComponentFactory.Instance.creatComponentByStylename("core.ConfirmSellInputBack");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("core.ConfirmSellInputTxt");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.ConfitmSellConfitmBtn");
         _cancenBtn = ComponentFactory.Instance.creatComponentByStylename("core.ConfitmSellCancelBtn");
         _inputTxt.maxChars = 3;
         addToContent(_icon);
         addToContent(_content);
         addToContent(_inputBack);
         addToContent(_inputTxt);
         addToContent(_confirmBtn);
         addToContent(_cancenBtn);
         titleText = LanguageMgr.GetTranslation("public.prompt");
         StageReferance.stage.focus = _inputTxt;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _inputTxt.addEventListener("keyDown",__inputEnterHandle);
         _confirmBtn.addEventListener("click",__confirmHandler);
         _cancenBtn.addEventListener("click",__cancelHandler);
      }
      
      private function removeEvent() : void
      {
         _inputTxt.removeEventListener("keyDown",__inputEnterHandle);
         removeEventListener("response",__frameResponseHandler);
         _confirmBtn.removeEventListener("click",__confirmHandler);
         _cancenBtn.removeEventListener("click",__cancelHandler);
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_inputTxt.text.toLocaleLowerCase() == "yes")
         {
            if(_callback != null)
            {
               _callback(true,true,_cell);
               _callback = null;
            }
            dispose();
         }
         else if(_inputTxt.text.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.view.ConfirmSellFrame.inputNull"));
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.view.ConfirmSellFrame.inputWrong"));
         }
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_callback != null)
         {
            _callback(false,true,_cell);
            _callback = null;
         }
         dispose();
      }
      
      private function __inputEnterHandle(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __confirmHandler(null);
         }
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 2)
         {
            __confirmHandler(null);
         }
         else
         {
            __cancelHandler(null);
         }
      }
      
      private function refreshView() : void
      {
         _content.htmlText = _contentValue;
         _content.height = _content.textHeight + 5;
         _inputBack.y = _content.y + _content.height;
         _inputTxt.y = _inputBack.y + 1;
         _cancenBtn.y = _confirmBtn.y = _inputBack.y + _inputBack.height + 5;
         height = _cancenBtn.y + 130;
      }
      
      public function show(param1:String, param2:Object, param3:Function) : void
      {
         _cell = param2;
         _contentValue = param1;
         _callback = param3;
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
         refreshView();
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         _cell = null;
         if(_callback != null)
         {
            _callback(false,false,_cell);
         }
         _callback = null;
         removeEvent();
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_inputBack);
         _inputBack = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_cancenBtn);
         _cancenBtn = null;
         super.dispose();
      }
   }
}

