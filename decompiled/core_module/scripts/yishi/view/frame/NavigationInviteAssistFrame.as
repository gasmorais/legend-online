package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.NavigationManager;
   import mvc.module.navigation.NavigationModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.BaseManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class NavigationInviteAssistFrame extends Frame
   {
      
      private var _frameBack1:Scale9CornerImage;
      
      private var _frameBack2:Scale9CornerImage;
      
      private var _titleImg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _time:TimeDownView;
      
      private var _content:FilterFrameText;
      
      private var _leftText:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _closeBtn:BaseButton;
      
      public var playerId:int;
      
      public var playerName:String;
      
      public var boatId:String;
      
      public var token:String;
      
      private var _maxAssistCount:int;
      
      private var _costStrength:int;
      
      private var _canGetCurrency:int;
      
      public function NavigationInviteAssistFrame()
      {
         super();
         _maxAssistCount = ConfigInfoManager.instance.getNavigationBoatUpgradeAssistNum();
         _costStrength = ConfigInfoManager.instance.getNavigationStrengthAssistSpeedup();
         _canGetCurrency = ConfigInfoManager.instance.getNavigationCurrencyAssistSpeedup();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _frameBack1 = ComponentFactory.Instance.creatComponentByStylename("core.InviteFrameBack1");
         _frameBack2 = ComponentFactory.Instance.creatComponentByStylename("core.InviteFrameBack2");
         _titleImg = ComponentFactory.Instance.creatBitmap("asset.core.invite.TitleBg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteTitleText");
         _time = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteTime");
         _content = ComponentFactory.Instance.creatComponentByStylename("NavigationInviteAssistFrame.RoomInviteContent");
         _leftText = ComponentFactory.Instance.creatComponentByStylename("NavigationInviteAssistFrame.leftText");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteConfirm");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteCancel");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteClose");
         addToContent(_frameBack1);
         _frameBack1.height = 140;
         addToContent(_frameBack2);
         _frameBack2.height = 134;
         addToContent(_titleImg);
         addToContent(_titleTxt);
         addToContent(_time);
         addToContent(_content);
         addToContent(_leftText);
         addToContent(_confirmBtn);
         _confirmBtn.y = 105;
         addToContent(_cancelBtn);
         _cancelBtn.y = 105;
         addToContent(_closeBtn);
      }
      
      private function initEvent() : void
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
         if(_time)
         {
            _time.removeEventListener("timerDown_complete",_timeCompleteHandler);
         }
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__cancelHandler);
         }
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__cancelHandler);
         }
      }
      
      private function setView() : void
      {
         _time.timeCount = 10;
         _titleTxt.text = LanguageMgr.GetTranslation("yishi.view.frame.NavigationInviteAssistFrame.titleText");
         _content.htmlText = LanguageMgr.GetTranslation("navigation.NavigationInviteAssistFrame.content",playerName,_costStrength,_canGetCurrency);
         var _loc1_:int = _maxAssistCount - model.hasAssistNum;
         _leftText.text = LanguageMgr.GetTranslation("navigation.NavigationInviteAssistFrame.leftAssistCount",_loc1_);
      }
      
      private function _timeCompleteHandler(param1:Event) : void
      {
         dispose();
      }
      
      private function confirmBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(model.strength < _costStrength)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("navigation.NavigationInviteAssistFrame.noStrength.alert"));
               return;
            }
            NavigationManager.instance.sendNavigationOperate(5,boatId,token,playerId);
         }
         dispose();
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         if(model.hasAssistNum >= _maxAssistCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("navigation.NavigationInviteAssistFrame.noAssistCount.alert"));
            dispose();
            return;
         }
         SimpleAlertHelper.instance.data = [confirmBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("navigation.NavigationInviteAssistFrame.assistAlert",_costStrength);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2,"SIMPLE_ALERT");
      }
      
      private function get model() : NavigationModel
      {
         return NavigationManager.instance.model;
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
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
         setView();
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         BaseManager.instance.existNavigationInvite = false;
         removeEvent();
         if(_titleImg)
         {
            ObjectUtils.disposeObject(_titleImg);
         }
         _titleImg = null;
         if(_frameBack1)
         {
            ObjectUtils.disposeObject(_frameBack1);
         }
         _frameBack1 = null;
         if(_frameBack2)
         {
            ObjectUtils.disposeObject(_frameBack2);
         }
         _frameBack2 = null;
         if(_titleTxt)
         {
            ObjectUtils.disposeObject(_titleTxt);
         }
         _titleTxt = null;
         if(_closeBtn)
         {
            ObjectUtils.disposeObject(_closeBtn);
         }
         _closeBtn = null;
         if(_time)
         {
            ObjectUtils.disposeObject(_time);
         }
         _time = null;
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
         }
         _content = null;
         if(_leftText)
         {
            ObjectUtils.disposeObject(_leftText);
         }
         _leftText = null;
         if(_confirmBtn)
         {
            ObjectUtils.disposeObject(_confirmBtn);
         }
         _confirmBtn = null;
         if(_cancelBtn)
         {
            ObjectUtils.disposeObject(_cancelBtn);
         }
         _cancelBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

