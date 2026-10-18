package sevenyear.view.battleflag
{
   import chat.ChatManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.SevenYearEvent;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.SevenYearManager;
   import mvc.module.chess.SelfChessManager;
   import mvc.module.sevenyear.SevenYearModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.SwitchInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class SevenYearSelfChessView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _snowTime:FilterFrameText;
      
      private var _snowLastTxt:FilterFrameText;
      
      private var _snowIconTxt:FilterFrameText;
      
      private var _matchingImg:Image;
      
      private var _matchCountTxt:GradientText;
      
      private var _starBtn:TextButton;
      
      private var _stopBtn:TextButton;
      
      private var _inviteBtn:BaseButton;
      
      private var _helpBtn:BaseButton;
      
      private var maxCount:int;
      
      private var maxPoint:int;
      
      private var endTime:Date;
      
      private var _timeOut:int;
      
      private var lastSend:int = -1;
      
      private const SEND_TIME:int = 30000;
      
      public function SevenYearSelfChessView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("SevenYearSnowView.bg2");
         _snowTime = ComponentFactory.Instance.creatComponentByStylename("SevenYearSnowView.snowTime");
         _snowLastTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearSnowView.snowLastTxt");
         _snowIconTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearSnowView.snowIconTxt");
         _matchingImg = ComponentFactory.Instance.creatComponentByStylename("SevenYearSnowView.matchingImg");
         _matchCountTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearSnowView.matchCountTxt");
         _starBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearSnowView.starBtn");
         _stopBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearSnowView.stopBtn");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("ui.SevenYearSelfChess.inviteBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("selfchess.helpBtn");
         addChild(_bg);
         if(SwitchInfo.SELF_CHESS)
         {
            addChild(_snowTime);
         }
         addChild(_snowLastTxt);
         addChild(_snowIconTxt);
         addChild(_matchingImg);
         addChild(_matchCountTxt);
         addChild(_stopBtn);
         addChild(_starBtn);
         addChild(_inviteBtn);
         addChild(_helpBtn);
         _snowLastTxt.text = LanguageMgr.GetTranslation("SevenYearSnowView.snowLastTxt.text");
         _starBtn.text = LanguageMgr.GetTranslation("SevenYearSnowView.starBtn.text");
         _stopBtn.text = LanguageMgr.GetTranslation("SevenYearSnowView.stopBtn.text");
         _inviteBtn.visible = false;
         maxCount = SelfChessManager.Ins.ROOM_MAX;
         maxPoint = ConfigInfoManager.instance.getSnowVehicleDailyRewardMax();
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("seven_year_stop_date");
         var _loc2_:String = _loc1_.ConfigValue;
         endTime = DateFormatter.parse(_loc2_,"YYYY-MM-DD hh:mm");
      }
      
      public function updateTime() : void
      {
         var _loc1_:int = 0;
         if(endTime && endTime.time > playerModel.sysCurtime.time)
         {
            _loc1_ = (endTime.time - playerModel.sysCurtime.time) / 1000;
            _snowTime.text = DateFormatter.getStopDateString(_loc1_);
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function initEvent() : void
      {
         _starBtn.addEventListener("click",__startSnowBallHandler);
         _stopBtn.addEventListener("click",__stopMatchingHandler);
         _inviteBtn.addEventListener("click",inviteHandler);
         _helpBtn.addEventListener("click",helpHandler);
         model.addEventListener("UPDATE_USER_INFO",__updateSnowScoreHandler);
         MsgMan.addObserver("UPDATE_SNOW_TEAM_COUNT",this,__updateMatchingHandler);
      }
      
      private function removeEvent() : void
      {
         if(_starBtn)
         {
            _starBtn.removeEventListener("click",__startSnowBallHandler);
         }
         if(_stopBtn)
         {
            _stopBtn.removeEventListener("click",__stopMatchingHandler);
         }
         _inviteBtn.removeEventListener("click",inviteHandler);
         _helpBtn.removeEventListener("click",helpHandler);
         MsgMan.removeObserver("UPDATE_SNOW_TEAM_COUNT",this,__updateMatchingHandler);
         model.removeEventListener("UPDATE_USER_INFO",__updateSnowScoreHandler);
      }
      
      private function helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("selfchess.helpFrame");
         _loc2_.show();
      }
      
      private function inviteHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = getTimer();
         if(lastSend != -1 && _loc3_ - lastSend < 30000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("chat.view.ChatInputView.command02",30));
            return;
         }
         lastSend = _loc3_;
         var _loc2_:String = LanguageMgr.GetTranslation("sevenyear.selfchess.invite");
         ChatManager.instance.chatNormal(_loc2_,8,"",[],[],[],[]);
      }
      
      private function __startSnowBallHandler(param1:MouseEvent) : void
      {
         if(!SwitchInfo.SELF_CHESS)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.unopen.wait"));
            return;
         }
         SelfChessManager.Ins.sendMatch(1);
      }
      
      private function __stopMatchingHandler(param1:MouseEvent = null) : void
      {
         SelfChessManager.Ins.sendMatch(2);
      }
      
      private function __updateSnowScoreHandler(param1:SevenYearEvent) : void
      {
         _snowIconTxt.text = model.snowScore + "/" + maxPoint;
      }
      
      private function __updateMatchingHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         _snowIconTxt.text = model.snowScore + "/" + maxPoint;
         var _loc1_:int = int(SelfChessManager.Ins.model.playerNum);
         _starBtn.visible = _loc1_ <= 0;
         _stopBtn.visible = _loc1_ > 0;
         if(_loc1_ > 0)
         {
            _matchingImg.visible = true;
            _matchCountTxt.text = _loc1_ + "/" + maxCount;
            _inviteBtn.visible = true;
         }
         else
         {
            _matchingImg.visible = false;
            _inviteBtn.visible = false;
            _matchCountTxt.text = "";
         }
         updateTime();
         clearTimeout(_timeOut);
         if(_loc1_ == SelfChessManager.Ins.ROOM_MAX)
         {
            _stopBtn.enable = false;
            _timeOut = setTimeout(laterGotoSence,1000);
         }
         else
         {
            _stopBtn.enable = true;
         }
      }
      
      private function laterGotoSence() : void
      {
         SceneManager.instance.setScene("SELF_CHESS_SCENE");
      }
      
      private function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      override public function dispose() : void
      {
         clearTimeout(_timeOut);
         removeEvent();
         if(SelfChessManager.Ins.model.playerNum > 0)
         {
            __stopMatchingHandler();
            SelfChessManager.Ins.model.playerNum = 0;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_snowTime);
         _snowTime = null;
         ObjectUtils.disposeObject(_snowLastTxt);
         _snowLastTxt = null;
         ObjectUtils.disposeObject(_snowIconTxt);
         _snowIconTxt = null;
         ObjectUtils.disposeObject(_matchingImg);
         _matchingImg = null;
         ObjectUtils.disposeObject(_matchCountTxt);
         _matchCountTxt = null;
         ObjectUtils.disposeObject(_stopBtn);
         _stopBtn = null;
         ObjectUtils.disposeObject(_starBtn);
         _starBtn = null;
         ObjectUtils.disposeObject(_inviteBtn);
         _inviteBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
      }
   }
}

