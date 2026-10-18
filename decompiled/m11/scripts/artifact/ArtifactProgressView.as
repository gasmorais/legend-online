package artifact
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.artifactgiftactivity.ArtifactGiftActivityMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArtifactManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   
   public class ArtifactProgressView extends Component
   {
      
      private var _resetBtn:IconButton;
      
      private var _resetTxt:FilterFrameText;
      
      private var _resetBmp:Bitmap;
      
      private var _lotteryTxt:FilterFrameText;
      
      private var _progressTxt:FilterFrameText;
      
      private var _gradeBar:MovieClip;
      
      private var _resetNote1:Bitmap;
      
      private var _resetNote2:Bitmap;
      
      private var _resetNote3:Bitmap;
      
      private var _desTxt:FilterFrameText;
      
      private var _progressStrip:StripView;
      
      private var _resetBtnStrip:StripView;
      
      private var _resetTxtStrip:StripView;
      
      private var _activityMsg:ArtifactGiftActivityMsg;
      
      private var _remainTimeText:FilterFrameText;
      
      public function ArtifactProgressView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _resetBtn = ComponentFactory.Instance.creatComponentByStylename("artifact.resetBtn");
         _resetTxt = ComponentFactory.Instance.creatComponentByStylename("artifact.resetTxt");
         _resetBmp = ComponentFactory.Instance.creatBitmap("asset.artifact.resetBmp");
         _lotteryTxt = ComponentFactory.Instance.creatComponentByStylename("artifact.lotteryTxt");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("artifact.progressTxt");
         _gradeBar = ComponentFactory.Instance.creatCustomObject("artifact.ProgressBar");
         _resetNote1 = ComponentFactory.Instance.creatBitmap("asset.artifact.resetNote1");
         _resetNote2 = ComponentFactory.Instance.creatBitmap("asset.artifact.resetNote2");
         _resetNote3 = ComponentFactory.Instance.creatBitmap("asset.artifact.resetNote3");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("artifact.progressDesTxt");
         _progressStrip = ComponentFactory.Instance.creatCustomObject("artifact.progressStrip");
         _resetBtnStrip = ComponentFactory.Instance.creatCustomObject("artifact.resetBtnStrip");
         _resetTxtStrip = ComponentFactory.Instance.creatCustomObject("artifact.resetTxtStrip");
         _remainTimeText = ComponentFactory.Instance.creatComponentByStylename("artifact.remainTimeText");
         addChild(_resetTxt);
         addChild(_resetBmp);
         addChild(_gradeBar);
         addChild(_lotteryTxt);
         addChild(_progressTxt);
         addChild(_resetNote1);
         addChild(_resetNote2);
         addChild(_resetNote3);
         addChild(_desTxt);
         addChild(_progressStrip);
         addChild(_resetBtnStrip);
         addChild(_resetTxtStrip);
         addChild(_remainTimeText);
         _resetBtnStrip.addChild(_resetBtn);
         _progressStrip.setHitArea(0,0,306,18);
         _resetTxtStrip.setHitArea(0,0,100,20);
         _resetBtnStrip.tipData = LanguageMgr.GetTranslation("artifact.ArtifactBoxView.resetBtnStrip");
         _resetTxtStrip.tipData = LanguageMgr.GetTranslation("artifact.ArtifactBoxView.resetTxtStrip");
         _desTxt.htmlText = LanguageMgr.GetTranslation("artifact.ArtifactProgressView.descriptTxt");
         _gradeBar.gotoAndStop(1);
      }
      
      private function initEvent() : void
      {
         _resetBtn.addEventListener("click",__resetBtnHandler);
         NotificationManager.instance.addEventListener("ARTIFACT_MSG_RECORD",__activityMsgHandler);
         __activityMsgHandler(null);
      }
      
      private function removeEvent() : void
      {
         _resetBtn.removeEventListener("click",__resetBtnHandler);
         NotificationManager.instance.removeEventListener("ARTIFACT_MSG_RECORD",__activityMsgHandler);
      }
      
      private function __resetBtnHandler(param1:MouseEvent) : void
      {
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         _activityMsg = ArtifactManager.instance.activityMsg;
         if(!_activityMsg)
         {
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         if(_activityMsg.lotteryNum > 0)
         {
            SimpleAlertHelper.instance.data = [];
            _loc5_ = LanguageMgr.GetTranslation("artifact.ArtifactBoxView.resetAlertContent1",_activityMsg.lotteryNum);
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,"",true,false,false,2);
         }
         else if(_activityMsg.lotteryItems.length == ArtifactManager.instance.boxTempArr.length && !_activityMsg.rewarded)
         {
            SimpleAlertHelper.instance.data = [];
            _loc5_ = LanguageMgr.GetTranslation("artifact.ArtifactBoxView.resetAlertContent2");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,"",true,false,false,2);
         }
         else
         {
            SimpleAlertHelper.instance.data = [responseOperate];
            _loc5_ = LanguageMgr.GetTranslation("artifact.ArtifactBoxView.resetAlertContent3");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2);
         }
      }
      
      private function responseOperate(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(FrameControllerManager.instance.artifactControler.artifactOpen)
            {
               return;
            }
            ArtifactManager.instance.OperateArtifact(0);
         }
      }
      
      private function __activityMsgHandler(param1:NotificationEvent = null) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _activityMsg = ArtifactManager.instance.activityMsg;
         if(!_activityMsg)
         {
            return;
         }
         _resetTxt.text = String(_activityMsg.resetNum);
         _lotteryTxt.text = String(_activityMsg.lotteryNum);
         _resetBtn.enable = _activityMsg.resetNum > 0;
         if(ArtifactManager.instance.getMaxStep() <= _activityMsg.scoreStep)
         {
            _progressTxt.text = "max";
            _loc2_ = 100;
         }
         else
         {
            _loc4_ = int(_activityMsg.score);
            _loc3_ = int(ArtifactManager.instance.getNextStepTemp(_activityMsg.scoreStep).value);
            _progressTxt.text = _loc4_ + "/" + _loc3_;
            _loc2_ = _loc4_ / _loc3_ * 100;
         }
         _gradeBar.gotoAndStop(_loc2_);
         var _loc5_:int = int(ArtifactManager.instance.getCurrentTotalScore(_activityMsg.scoreStep,_activityMsg.score));
         _progressStrip.tipData = LanguageMgr.GetTranslation("artifact.ArtifactBoxView.progressStrip",_activityMsg.scoreStep,ArtifactManager.instance.getMaxStep(),_loc5_,ArtifactManager.instance.getAllScore());
         setRemainTime();
      }
      
      public function setRemainTime() : void
      {
         var _loc2_:Date = ArtifactManager.instance.ARTIFACT_END_DATE;
         var _loc1_:Number = _loc2_.time / 1000 - playerModel.sysCurTimeBySecond;
         if(_loc1_ >= 60)
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullTimeString(_loc1_));
         }
         else if(_loc1_ > 0)
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullDateString(_loc1_));
         }
         else
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate");
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         SimpleAlertHelper.instance.data = [];
         ObjectUtils.disposeObject(_resetBtn);
         _resetBtn = null;
         ObjectUtils.disposeObject(_resetTxt);
         _resetTxt = null;
         ObjectUtils.disposeObject(_resetBmp);
         _resetBmp = null;
         ObjectUtils.disposeObject(_lotteryTxt);
         _lotteryTxt = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeViolentMc(_gradeBar);
         _gradeBar = null;
         ObjectUtils.disposeObject(_resetNote1);
         _resetNote1 = null;
         ObjectUtils.disposeObject(_resetNote2);
         _resetNote2 = null;
         ObjectUtils.disposeObject(_resetNote3);
         _resetNote3 = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeObject(_progressStrip);
         _progressStrip = null;
         ObjectUtils.disposeObject(_resetBtnStrip);
         _resetBtnStrip = null;
         ObjectUtils.disposeObject(_resetTxtStrip);
         _resetTxtStrip = null;
         _activityMsg = null;
         super.dispose();
      }
   }
}

