package yishi.view.community
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class CrossBugleFrame extends Frame
   {
      
      public static const MAX_CONTENT:int = 76;
      
      private var _inputBack:ScaleBitmapImage;
      
      private var _alertImage:Bitmap;
      
      private var _contentTxt:FilterFrameText;
      
      private var _wordCountTxt:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _tempStr:String = "";
      
      private var _tempContent:String = "";
      
      private var _data:GoodsInfo;
      
      public function CrossBugleFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("CrossBugleFrame.title.text");
         _alertImage = ComponentFactory.Instance.creatBitmap("asset.core.crossAlertImage");
         _inputBack = ComponentFactory.Instance.creatComponentByStylename("CrossBugleFrame.inputBack");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("CrossBugleFrame.ContentTxt");
         _wordCountTxt = ComponentFactory.Instance.creatComponentByStylename("CrossBugleFrame.WordCountTxt");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("CrossBugleFrame.ConfirmBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("CrossBugleFrame.CancleBtn");
         _wordCountTxt.text = LanguageMgr.GetTranslation("yishi.view.RosePresentView.wordCount",0,76);
         addToContent(_alertImage);
         addToContent(_inputBack);
         addToContent(_contentTxt);
         addToContent(_wordCountTxt);
         addToContent(_confirmBtn);
         addToContent(_cancelBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _confirmBtn.addEventListener("click",__onConfirmClick);
         _cancelBtn.addEventListener("click",__onCancleClick);
         _contentTxt.addEventListener("change",__contentInputHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _confirmBtn.removeEventListener("click",__onConfirmClick);
         _cancelBtn.removeEventListener("click",__onCancleClick);
         _contentTxt.removeEventListener("change",__contentInputHandler);
      }
      
      private function __onConfirmClick(param1:MouseEvent) : void
      {
         var _loc2_:String = StringHelper.trim(_contentTxt.text);
         if(StringHelper.isNullOrEmpty(_loc2_))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.im.view.IMStateReplyInputView.dirtyWordTip"));
            return;
         }
         if(FilterWordManager.isGotForbiddenWords(_loc2_) || FilterWordManager.containSpecificChar(_loc2_,"<>"))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.im.view.IMStateReplyInputView.dirtyWordTip"));
            return;
         }
         SocketSendManager.instance.sendUseItem(_data.pos,1,1,_loc2_,0);
         dispose();
      }
      
      public function setData(param1:GoodsInfo) : void
      {
         _data = param1;
      }
      
      private function __contentInputHandler(param1:Event) : void
      {
         var _loc2_:int = StringHelper.checkStringLength(_contentTxt.text);
         if(_loc2_ > 76)
         {
            _contentTxt.text = _tempContent;
         }
         _tempContent = _contentTxt.text;
         _wordCountTxt.text = LanguageMgr.GetTranslation("yishi.view.RosePresentView.wordCount",StringHelper.checkStringLength(_tempContent),76);
      }
      
      private function __onCancleClick(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
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
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_inputBack);
         _inputBack = null;
         ObjectUtils.disposeObject(_alertImage);
         _alertImage = null;
         ObjectUtils.disposeObject(_contentTxt);
         _contentTxt = null;
         ObjectUtils.disposeObject(_wordCountTxt);
         _wordCountTxt = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         super.dispose();
      }
   }
}

