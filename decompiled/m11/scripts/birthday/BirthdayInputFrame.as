package birthday
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import yishi.manager.BirthdayManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class BirthdayInputFrame extends Frame
   {
      
      private var _frameTitle:Bitmap;
      
      private var _wishTitle:Bitmap;
      
      private var _inputBg:Bitmap;
      
      private var _submitBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _inputTxt:FilterFrameText;
      
      private var _inputTipTxt:FilterFrameText;
      
      private var _curInputStr:String;
      
      private var _curWishCount:uint = 0;
      
      private var _curCharCount:uint = 0;
      
      private const BTN_GAP:uint = 50;
      
      private const MAX_CHAR_COUNT:uint = 50;
      
      private const MAX_COUNT_DAILY:uint = 3;
      
      public function BirthdayInputFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc1_:ComponentFactory = ComponentFactory.Instance;
         _frameTitle = _loc1_.creatBitmap("asset.birthday.inputTitle");
         _wishTitle = _loc1_.creatBitmap("asset.birthday.wishTitle");
         _inputBg = _loc1_.creatBitmap("asset.birthday.inputGg");
         _submitBtn = _loc1_.creatComponentByStylename("birthday.submitBtn");
         _cancelBtn = _loc1_.creatComponentByStylename("birthday.cancelBtn");
         _inputTxt = _loc1_.creatComponentByStylename("birthday.inputText");
         _inputTxt.type = "input";
         _inputTxt.wordWrap = false;
         _inputTxt.multiline = true;
         _inputTipTxt = _loc1_.creatComponentByStylename("birthday.inputTipText");
         _inputTipTxt.width = _inputTxt.width;
         _inputTipTxt.x = _inputTxt.x;
         _inputTipTxt.y = _inputTxt.y + _inputTxt.height;
         _inputBg.x = _inputTxt.x;
         _inputBg.y = _inputTxt.y;
         _wishTitle.x = _inputTxt.x;
         updateTip();
         _cancelBtn.y = _submitBtn.y;
         _cancelBtn.x = _submitBtn.x + 50 + _submitBtn.width;
         addToContent(_frameTitle);
         addToContent(_wishTitle);
         addToContent(_inputBg);
         addToContent(_submitBtn);
         addToContent(_cancelBtn);
         addToContent(_inputTxt);
         addToContent(_inputTipTxt);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",frameEventHandler);
         _submitBtn.addEventListener("click",onSubmitClickHandler);
         _cancelBtn.addEventListener("click",onCancelClickHandler);
         _inputTxt.addEventListener("change",onTextChangeHandler);
         BirthdayManager.instance.model.addEventListener("MODEL_UPDATE_EVENT",onWishCountUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",frameEventHandler);
         _submitBtn.removeEventListener("click",onSubmitClickHandler);
         _cancelBtn.removeEventListener("click",onCancelClickHandler);
         _inputTxt.removeEventListener("change",onTextChangeHandler);
         BirthdayManager.instance.model.removeEventListener("MODEL_UPDATE_EVENT",onWishCountUpdateHandler);
      }
      
      private function onSubmitClickHandler(param1:MouseEvent) : void
      {
         var msg:String;
         var txtLen:uint;
         var confirm:String;
         var cancel:String;
         var prompt:String;
         var content:String;
         var e:MouseEvent = param1;
         SoundManager.instance.play("022");
         msg = _inputTxt.text;
         msg = msg.replace(/^\s*|\s*$/g,"");
         msg = msg.replace(/\n/g,"");
         msg = msg.replace(/\r/g,"");
         msg = FilterWordManager.filterWrod(msg,["{invalid_utf8=230}{invalid_utf8=155}?"]);
         setInputText(msg);
         txtLen = uint(StringHelper.checkStringLength(msg));
         if(txtLen == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.customerService.textInput"));
         }
         else
         {
            SimpleAlertHelper.instance.data = [function(param1:Boolean, param2:Boolean):void
            {
               if(param1)
               {
                  BirthdayManager.instance.sendOperationToServer(101,1,msg);
                  setInputText("");
               }
            }];
            confirm = LanguageMgr.GetTranslation("public.confirm");
            cancel = LanguageMgr.GetTranslation("public.cancel");
            prompt = LanguageMgr.GetTranslation("yishi.manager.BaseManager.tip.title");
            content = LanguageMgr.GetTranslation("birthday.BirthdayBoardFrame.alterTip");
            SimpleAlertHelper.instance.popAlerFrame(prompt,content,confirm,cancel,true,false,false,2);
         }
      }
      
      private function setInputText(param1:String) : void
      {
         _inputTxt.text = param1;
         var _loc2_:uint = uint(StringHelper.checkStringLength(_inputTxt.text));
         curCharCount = _loc2_;
         _curInputStr = _inputTxt.text;
      }
      
      private function onCancelClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function frameEventHandler(param1:FrameEvent) : void
      {
         var _loc2_:int = int(param1.responseCode);
         if(_loc2_ == 0 || _loc2_ == 1)
         {
            dispose();
         }
      }
      
      private function onTextChangeHandler(param1:Event) : void
      {
         var _loc2_:uint = uint(StringHelper.checkStringLength(_inputTxt.text));
         if(_loc2_ > 50)
         {
            _inputTxt.text = _curInputStr;
         }
         else
         {
            curCharCount = _loc2_;
            _curInputStr = _inputTxt.text;
         }
      }
      
      private function onWishCountUpdateHandler(param1:Event) : void
      {
         curWishCount = BirthdayManager.instance.model.wishCount;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         curWishCount = BirthdayManager.instance.model.wishCount;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(this.parent != null)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
      
      private function set curWishCount(param1:uint) : void
      {
         _curWishCount = param1;
         updateTip();
      }
      
      private function set curCharCount(param1:uint) : void
      {
         _curCharCount = param1;
         updateTip();
      }
      
      private function updateTip() : void
      {
         _inputTipTxt.text = LanguageMgr.GetTranslation("birthday.BirthdayInputFrame.tip",3 - _curWishCount,3,_curCharCount,50);
      }
   }
}

