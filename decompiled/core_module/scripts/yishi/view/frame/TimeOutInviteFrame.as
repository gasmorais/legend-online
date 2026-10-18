package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.view.community.TimeDownView;
   
   public class TimeOutInviteFrame extends Frame
   {
      
      private var _frameBack1:Scale9CornerImage;
      
      private var _frameBack2:Scale9CornerImage;
      
      private var _titleImg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _time:TimeDownView;
      
      private var _content:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _closeBtn:BaseButton;
      
      private var _incomeBtn:SelectedCheckButton;
      
      private var _params:Array;
      
      private var _confirmCallBack:Function;
      
      private var _cancelCallBack:Function;
      
      public function TimeOutInviteFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _frameBack1 = ComponentFactory.Instance.creatComponentByStylename("core.InviteFrameBack1");
         _frameBack2 = ComponentFactory.Instance.creatComponentByStylename("core.InviteFrameBack2");
         _titleImg = ComponentFactory.Instance.creatBitmap("asset.core.invite.TitleBg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteTitleText");
         _time = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteTime");
         _content = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteContent");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteConfirm");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteCancel");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteClose");
         _incomeBtn = ComponentFactory.Instance.creatComponentByStylename("core.useBindPointBtn");
         addToContent(_frameBack1);
         addToContent(_frameBack2);
         addToContent(_titleImg);
         addToContent(_titleTxt);
         addToContent(_time);
         addToContent(_content);
         addToContent(_confirmBtn);
         addToContent(_cancelBtn);
         addToContent(_closeBtn);
         addToContent(_incomeBtn);
         _incomeBtn.text = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.alertConent");
         _incomeBtn.visible = false;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_frameBack1);
         _frameBack1 = null;
         ObjectUtils.disposeObject(_frameBack2);
         _frameBack2 = null;
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_incomeBtn);
         _incomeBtn = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         ObjectUtils.disposeObject(_time);
         _time = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _time.addEventListener("timerDown_complete",_timeCompleteHandler);
         _confirmBtn.addEventListener("click",__confirmHandler);
         _cancelBtn.addEventListener("click",__cancelHandler);
         _closeBtn.addEventListener("click",__cancelHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _time.removeEventListener("timerDown_complete",_timeCompleteHandler);
         _confirmBtn.removeEventListener("click",__confirmHandler);
         _cancelBtn.removeEventListener("click",__cancelHandler);
         _closeBtn.removeEventListener("click",__cancelHandler);
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         if(_cancelCallBack != null)
         {
            _cancelCallBack();
         }
         dispose();
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         if(_confirmCallBack != null)
         {
            if(_incomeBtn.visible)
            {
               if(_params != null)
               {
                  _confirmCallBack(true,_params,_incomeBtn.selected);
               }
               else
               {
                  _confirmCallBack(true,_incomeBtn.selected);
               }
            }
            else if(_params != null)
            {
               _confirmCallBack(true,_params);
            }
            else
            {
               _confirmCallBack(true);
            }
         }
         dispose();
      }
      
      private function _timeCompleteHandler(param1:Event) : void
      {
         dispose();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
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
      
      override public function set titleText(param1:String) : void
      {
         _titleTxt.text = param1;
      }
      
      public function set content(param1:String) : void
      {
         _content.htmlText = param1;
         _content.height = _content.textHeight + 5;
         _content.y = _titleImg.y + _titleImg.height + (_confirmBtn.y - _titleImg.y - _titleImg.height - _content.height) * 0.5;
      }
      
      public function get txt() : FilterFrameText
      {
         return _content;
      }
      
      public function set time(param1:Number) : void
      {
         _time.timeCount = param1;
      }
      
      public function set confirmCallBack(param1:Function) : void
      {
         _confirmCallBack = param1;
      }
      
      public function set cancelCallBack(param1:Function) : void
      {
         _cancelCallBack = param1;
      }
      
      public function set params(param1:Array) : void
      {
         _params = param1;
      }
      
      public function showIncomeBtn() : void
      {
         _incomeBtn.visible = true;
         _incomeBtn.x = 101;
         _incomeBtn.y = 78;
         _frameBack1.height = 150;
         _frameBack2.height = 144;
         _confirmBtn.y = 110;
         _cancelBtn.y = 110;
         _incomeBtn.selected = true;
      }
      
      public function hideIncomeBtn() : void
      {
         _incomeBtn.visible = false;
         _frameBack1.height = 120;
         _frameBack2.height = 114;
         _confirmBtn.y = 80;
         _cancelBtn.y = 80;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

