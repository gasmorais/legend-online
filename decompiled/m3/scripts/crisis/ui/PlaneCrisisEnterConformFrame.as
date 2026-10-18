package crisis.ui
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
   import yishi.manager.PlaneCrisisManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.TimeDownView;
   
   public class PlaneCrisisEnterConformFrame extends Frame
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
      
      private var _maxTime:int;
      
      public function PlaneCrisisEnterConformFrame()
      {
         super();
         _maxTime = TempleteManager.instance.getConfigValue("crisis_available_times");
         initView();
         initEvent();
      }
      
      public function show(param1:String) : void
      {
         var _loc2_:int = _maxTime - PlayerManager.instance.currentPlayerModel.playerInfo.usePlaneCrisis;
         _content.text = LanguageMgr.GetTranslation("planeCriris.doEnterContent",param1,_loc2_,_maxTime);
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         if(_loc2_ == 0)
         {
            _incomeBtn.selected = false;
            _incomeBtn.enable = false;
         }
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(_frameBack1)
         {
            _frameBack1.dispose();
         }
         _frameBack1 = null;
         if(_frameBack2)
         {
            _frameBack2.dispose();
         }
         _frameBack2 = null;
         _titleImg = null;
         if(_incomeBtn)
         {
            _incomeBtn.dispose();
         }
         _incomeBtn = null;
         if(_titleTxt)
         {
            _titleTxt.dispose();
         }
         _titleTxt = null;
         if(_closeBtn)
         {
            _closeBtn.dispose();
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
         super.dispose();
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
         _incomeBtn.selected = true;
         _incomeBtn.x = 96;
         _incomeBtn.y = 50;
         _content.y = 30;
         _time.timeCount = 10;
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
         _time.removeEventListener("timerDown_complete",_timeCompleteHandler);
         _confirmBtn.removeEventListener("click",__confirmHandler);
         _cancelBtn.removeEventListener("click",__cancelHandler);
         _closeBtn.removeEventListener("click",__cancelHandler);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = _incomeBtn.selected ? 1 : 0;
         PlaneCrisisManager.Instance.gameOp(9,_loc2_,0);
         dispose();
      }
      
      private function _timeCompleteHandler(param1:Event) : void
      {
         dispose();
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = _incomeBtn.selected ? 1 : 0;
         PlaneCrisisManager.Instance.gameOp(9,_loc2_,1);
         dispose();
      }
   }
}

