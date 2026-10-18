package task.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.player.CheckSend;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.net.URLVariables;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.TaskSocketManager;
   import mvc.module.task.TaskTemplate;
   import task.net.TaskSocketSendManager;
   import yishi.comm.PackageIn;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.view.tips.MessageTipManager;
   
   public class TaskMobilePhoneView extends Sprite implements Disposeable
   {
      
      private var _phoneNumInputText:FilterFrameText;
      
      private var _identifyNumInputText:FilterFrameText;
      
      private var _phoneNumTip:FilterFrameText;
      
      private var _identifyNumTip1:FilterFrameText;
      
      private var _identifyNumTip2:FilterFrameText;
      
      private var _timerText1:FilterFrameText;
      
      private var _timerText2:FilterFrameText;
      
      private var _timerText3:FilterFrameText;
      
      private var _timerText4:FilterFrameText;
      
      private var _sendBtn:IconButton;
      
      private var _checkBtn:IconButton;
      
      private var _reSendBtn:IconButton;
      
      private var _leftBg:Bitmap;
      
      private var _rightBg:Bitmap;
      
      private var _phoneNumBmp:Bitmap;
      
      private var _checkBmp:Bitmap;
      
      private var _sendedBack:ScaleBitmapImage;
      
      private var _checkedBack:ScaleBitmapImage;
      
      private var _sendImage:ScaleBitmapImage;
      
      private var _checkImage:ScaleBitmapImage;
      
      private var _timer3:Timer;
      
      private var _regExp:RegExp;
      
      private var _sendCount:int;
      
      private var _userId:int;
      
      private var _key:String;
      
      private var _isSended:Boolean;
      
      private var _temp:TaskTemplate;
      
      public function TaskMobilePhoneView()
      {
         super();
         _userId = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         _key = PlayerManager.instance.currentPlayerModel.userInfo.key;
         initView();
         initEvent();
      }
      
      public function set taskTemp(param1:TaskTemplate) : void
      {
         if(!param1 || param1.conditionList[0].CondictionType != 48)
         {
            return;
         }
         _temp = param1;
         if(_temp)
         {
            if(_temp.taskInfo.checkNumber == 0)
            {
               TaskSocketManager.sendCheckMobileNumber();
            }
            else if(_temp.taskInfo.checkNumber == -1)
            {
               setAreaView(false);
            }
            else if(_temp.taskInfo.checkNumber == 1)
            {
               setAreaView(true);
            }
            _temp.taskInfo.addEventListener("change",refresh);
            if(_temp.taskInfo.phoneStr && _temp.taskInfo.phoneStr != "")
            {
               _phoneNumInputText.text = _temp.taskInfo.phoneStr;
            }
         }
         refresh(null);
      }
      
      private function refresh(param1:Event) : void
      {
         if(_sendBtn)
         {
            _sendBtn.buttonMode = true;
         }
         if(_checkBtn)
         {
            _checkBtn.buttonMode = true;
         }
         if(_temp)
         {
            if(_timerText1)
            {
               _timerText1.text = "" + _temp.taskInfo.sendTime;
            }
            if(_temp.taskInfo.sendTime > 0)
            {
               setSendedView(true);
            }
            else
            {
               setSendedView(false);
            }
            if(_timerText3)
            {
               _timerText3.text = "" + _temp.taskInfo.checkTime;
            }
            if(_temp.taskInfo.checkTime > 0)
            {
               setCheckedView(true);
            }
            else
            {
               setCheckedView(false);
            }
         }
         else
         {
            if(_sendBtn)
            {
               _sendBtn.buttonMode = false;
            }
            if(_checkBtn)
            {
               _checkBtn.buttonMode = false;
            }
         }
      }
      
      private function initView() : void
      {
         _leftBg = ComponentFactory.Instance.creatBitmap("asset.task.TaskPhoneBg");
         _rightBg = ComponentFactory.Instance.creatBitmap("asset.task.TaskPhoneBg");
         _phoneNumBmp = ComponentFactory.Instance.creatBitmap("asset.task.TaskPhoneNumber");
         _checkBmp = ComponentFactory.Instance.creatBitmap("asset.task.TaskPhoneCheckNum");
         _sendedBack = ComponentFactory.Instance.creatComponentByStylename("asset.task.TaskPhoneBtnBackImage1");
         _checkedBack = ComponentFactory.Instance.creatComponentByStylename("asset.task.TaskPhoneBtnBackImage2");
         _sendImage = ComponentFactory.Instance.creatComponentByStylename("asset.task.InputbackImage1");
         _checkImage = ComponentFactory.Instance.creatComponentByStylename("asset.task.InputbackImage2");
         _sendBtn = ComponentFactory.Instance.creatComponentByStylename("task.phoneNumSendBtn");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("task.checkBtn");
         _reSendBtn = ComponentFactory.Instance.creatComponentByStylename("task.reSendBtn");
         _phoneNumInputText = ComponentFactory.Instance.creatComponentByStylename("task.phoneNumInputText");
         _identifyNumInputText = ComponentFactory.Instance.creatComponentByStylename("task.identifyNumInputText");
         _phoneNumTip = ComponentFactory.Instance.creatComponentByStylename("task.phoneNumTip");
         _identifyNumTip1 = ComponentFactory.Instance.creatComponentByStylename("task.identifyNumTip1");
         _identifyNumTip2 = ComponentFactory.Instance.creatComponentByStylename("task.identifyNumTip2");
         _timerText1 = ComponentFactory.Instance.creatComponentByStylename("task.timerText1");
         _timerText2 = ComponentFactory.Instance.creatComponentByStylename("task.timerText2");
         _timerText3 = ComponentFactory.Instance.creatComponentByStylename("task.timerText3");
         _timerText4 = ComponentFactory.Instance.creatComponentByStylename("task.timerText4");
         _timerText2.text = _timerText4.text = LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text1");
         _phoneNumTip.text = LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text2");
         _identifyNumTip1.text = LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text3");
         _identifyNumTip2.text = LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text4");
         _rightBg.scaleX = -1;
         _rightBg.x = _leftBg.x + _leftBg.width * 2;
         addChild(_leftBg);
         addChild(_rightBg);
         addChild(_phoneNumBmp);
         addChild(_checkBmp);
         addChild(_sendImage);
         addChild(_checkImage);
         addChild(_sendBtn);
         addChild(_checkBtn);
         addChild(_reSendBtn);
         addChild(_phoneNumInputText);
         addChild(_identifyNumInputText);
         addChild(_phoneNumTip);
         addChild(_identifyNumTip1);
         addChild(_identifyNumTip2);
         addChild(_sendedBack);
         addChild(_checkedBack);
         addChild(_timerText1);
         addChild(_timerText2);
         addChild(_timerText3);
         addChild(_timerText4);
         _identifyNumTip2.visible = false;
         setSendedView(false);
         setCheckedView(false);
         _sendBtn.buttonMode = false;
         _checkBtn.buttonMode = false;
         _regExp = /^[0-9]{8,11}$/;
         _phoneNumInputText.restrict = "0-9";
         _identifyNumInputText.restrict = "0-9";
         _timer3 = new Timer(3600000,1);
         hideAll();
      }
      
      private function hideAll() : void
      {
         _phoneNumBmp.visible = false;
         _checkBmp.visible = false;
         _sendImage.visible = false;
         _checkImage.visible = false;
         _sendBtn.visible = false;
         _checkBtn.visible = false;
         _reSendBtn.visible = false;
         _phoneNumInputText.visible = false;
         _identifyNumInputText.visible = false;
         _phoneNumTip.visible = false;
         _identifyNumTip1.visible = false;
         _identifyNumTip2.visible = false;
         _sendedBack.visible = false;
         _checkedBack.visible = false;
         _timerText1.visible = false;
         _timerText2.visible = false;
         _timerText3.visible = false;
         _timerText4.visible = false;
      }
      
      private function __setFirstView(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:CheckSend = new CheckSend();
         _loc2_ = _loc3_.readBody(_loc2_) as CheckSend;
         _temp.taskInfo.checkNumber = _loc2_.canSend;
         if(_temp.taskInfo.checkNumber == -1)
         {
            _isSended = false;
         }
         else if(_temp.taskInfo.checkNumber == 1)
         {
            _isSended = true;
         }
         if(visible == false)
         {
            return;
         }
         setAreaView(_isSended);
      }
      
      private function setCheckedView(param1:Boolean) : void
      {
         if(_timerText3)
         {
            _timerText3.visible = param1 && _isSended;
         }
         if(_timerText4)
         {
            _timerText4.visible = param1 && _isSended;
         }
         if(_checkedBack)
         {
            _checkedBack.visible = param1 && _isSended;
         }
      }
      
      private function setSendedView(param1:Boolean) : void
      {
         if(_timerText1)
         {
            _timerText1.visible = param1 && !_isSended;
         }
         if(_timerText2)
         {
            _timerText2.visible = param1 && !_isSended;
         }
         if(_sendedBack)
         {
            _sendedBack.visible = param1 && !_isSended;
         }
      }
      
      private function setAreaView(param1:Boolean) : void
      {
         _isSended = param1;
         _phoneNumBmp.visible = !param1;
         _sendImage.visible = !param1;
         _sendBtn.visible = !param1;
         _phoneNumInputText.visible = !param1;
         _phoneNumTip.visible = !param1;
         if(!param1 && _temp && _temp.taskInfo.sendTime > 0)
         {
            _sendedBack.visible = true;
            _timerText1.visible = true;
            _timerText2.visible = true;
         }
         else
         {
            _sendedBack.visible = false;
            _timerText1.visible = false;
            _timerText2.visible = false;
         }
         _checkBmp.visible = param1;
         _checkImage.visible = param1;
         _checkBtn.visible = param1;
         _reSendBtn.visible = param1;
         _identifyNumInputText.visible = param1;
         _identifyNumTip1.visible = param1;
         _identifyNumTip2.visible = param1;
         if(param1 && _temp && _temp.taskInfo.checkTime > 0)
         {
            _checkedBack.visible = true;
            _timerText3.visible = true;
            _timerText4.visible = true;
         }
         else
         {
            _checkedBack.visible = false;
            _timerText3.visible = false;
            _timerText4.visible = false;
         }
         _identifyNumInputText.text = "";
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4420,__setFirstView);
         _sendBtn.addEventListener("click",__sendBtnClick);
         _checkBtn.addEventListener("click",__checkBtnClick);
         _reSendBtn.addEventListener("click",__reSendHandler);
         _timer3.addEventListener("timerComplete",__invalidCode);
      }
      
      private function __reSendHandler(param1:MouseEvent) : void
      {
         setAreaView(false);
      }
      
      private function __invalidCode(param1:TimerEvent) : void
      {
         _identifyNumTip2.text = LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text5");
      }
      
      private function __sendBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_phoneNumInputText.text == "")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text6"));
            _phoneNumTip.text = LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text2");
            _phoneNumTip.textColor = 2408488;
         }
         else if(_phoneNumInputText.length < 8)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text7"));
            _phoneNumTip.text = LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text16");
            _phoneNumTip.textColor = 16711680;
         }
         else if(!_regExp.test(_phoneNumInputText.text))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text7"));
            _phoneNumTip.text = LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text8");
            _phoneNumTip.textColor = 16711680;
         }
         else
         {
            _phoneNumTip.text = "";
            _temp.taskInfo.phoneStr = _phoneNumInputText.text;
            setAreaView(true);
            _temp.taskInfo.sendTime = 30;
            sendPhone(_phoneNumInputText.text);
         }
         _phoneNumTip.x = 166;
      }
      
      private function sendPhone(param1:String) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["userId"] = _userId;
         _loc2_["phone"] = param1;
         _loc2_["key"] = _key;
         var _loc3_:String = PathManager.info.REQUEST_PATH + "getphone?userId=" + _userId + "&phone=" + param1 + "&key=" + _key;
         LoaderManagerII.instance.load(_loc3_,7,8,__onGetResultCompleted,null,null,null,_loc2_,"POST");
      }
      
      private function __onGetResultCompleted(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:int = int(param2);
         switch(_loc3_ - -6)
         {
            case 0:
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text18"));
               break;
            case 1:
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text7"));
               break;
            case 2:
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text11"));
               break;
            case 3:
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text10"));
               break;
            case 4:
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text17"));
               break;
            case 5:
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text9"));
               break;
            case 7:
               rightPhoneNum();
               break;
            default:
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text11"));
         }
      }
      
      private function rightPhoneNum() : void
      {
         _temp.taskInfo.checkNumber = 1;
         _timer3.reset();
         _timer3.start();
         _identifyNumTip2.visible = true;
         _phoneNumTip.text = LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text12");
         _phoneNumTip.textColor = 2408488;
         _phoneNumTip.x = 145;
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text13"));
      }
      
      private function socketOutNum(param1:String) : void
      {
         var _loc2_:int = int(param1);
         TaskSocketSendManager.sendPhoneTaskCode(_loc2_);
      }
      
      private function __checkBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_identifyNumInputText.text == "")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text3"));
            _identifyNumTip1.text = LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text3");
            _identifyNumTip1.textColor = 2408488;
         }
         else if(_identifyNumInputText.length < 6)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text15"));
            _identifyNumTip1.text = LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text16");
            _identifyNumTip1.textColor = 16711680;
         }
         else
         {
            _identifyNumTip1.text = "";
            _temp.taskInfo.checkTime = 10;
            socketOutNum(_identifyNumInputText.text);
         }
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4420,__setFirstView);
         _sendBtn.removeEventListener("click",__sendBtnClick);
         _checkBtn.removeEventListener("click",__checkBtnClick);
         _reSendBtn.removeEventListener("click",__reSendHandler);
         _timer3.removeEventListener("timerComplete",__invalidCode);
         if(_temp)
         {
            _temp.taskInfo.removeEventListener("change",refresh);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_phoneNumTip)
         {
            _phoneNumTip.dispose();
         }
         _phoneNumTip = null;
         if(_identifyNumTip1)
         {
            _identifyNumTip1.dispose();
         }
         _identifyNumTip1 = null;
         if(_identifyNumTip2)
         {
            _identifyNumTip2.dispose();
         }
         _identifyNumTip2 = null;
         if(_timerText1)
         {
            _timerText1.dispose();
         }
         _timerText1 = null;
         if(_timerText2)
         {
            _timerText2.dispose();
         }
         _timerText2 = null;
         if(_timerText3)
         {
            _timerText3.dispose();
         }
         _timerText3 = null;
         if(_timerText4)
         {
            _timerText4.dispose();
         }
         _timerText4 = null;
         if(_sendedBack)
         {
            _sendedBack.dispose();
         }
         _sendedBack = null;
         if(_checkedBack)
         {
            _checkedBack.dispose();
         }
         _checkedBack = null;
         if(_leftBg)
         {
            _leftBg = null;
         }
         if(_rightBg)
         {
            _rightBg = null;
         }
         if(_regExp)
         {
            _regExp = null;
         }
         if(_phoneNumBmp)
         {
            _phoneNumBmp = null;
         }
         if(_checkBmp)
         {
            _checkBmp = null;
         }
         if(_sendImage)
         {
            _sendImage = null;
         }
         if(_checkImage)
         {
            _checkImage = null;
         }
         if(_phoneNumInputText)
         {
            _phoneNumInputText.dispose();
         }
         _phoneNumInputText = null;
         if(_identifyNumInputText)
         {
            _identifyNumInputText.dispose();
         }
         _identifyNumInputText = null;
         if(_sendBtn)
         {
            _sendBtn.dispose();
         }
         _sendBtn = null;
         if(_checkBtn)
         {
            _checkBtn.dispose();
         }
         _checkBtn = null;
         if(_reSendBtn)
         {
            _reSendBtn.dispose();
         }
         _reSendBtn = null;
         if(_timer3)
         {
            _timer3.stop();
         }
         _timer3 = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

