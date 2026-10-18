package sevenyear.view.battleflag
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import events.SevenYearEvent;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.SevenYearManager;
   import map.campaign.CampaignSocketOutManager;
   import mvc.module.sevenyear.SevenYearModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class SevenYearSnowView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _snowTime:FilterFrameText;
      
      private var _snowLastTxt:FilterFrameText;
      
      private var _snowIconTxt:FilterFrameText;
      
      private var _matchingImg:Image;
      
      private var _matchCountTxt:GradientText;
      
      private var _starBtn:TextButton;
      
      private var _stopBtn:TextButton;
      
      private var _tipIcon:Image;
      
      private var maxCount:int;
      
      private var maxPoint:int;
      
      private var endTime:Date;
      
      private var _preClickTime:Number = 0;
      
      public function SevenYearSnowView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("SevenYearSnowView.bg");
         _snowTime = ComponentFactory.Instance.creatComponentByStylename("SevenYearSnowView.snowTime");
         _snowLastTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearSnowView.snowLastTxt");
         _snowIconTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearSnowView.snowIconTxt");
         _matchingImg = ComponentFactory.Instance.creatComponentByStylename("SevenYearSnowView.matchingImg");
         _matchCountTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearSnowView.matchCountTxt");
         _starBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearSnowView.starBtn");
         _stopBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearSnowView.stopBtn");
         _tipIcon = ComponentFactory.Instance.creatComponentByStylename("SevenYear.icontip");
         _tipIcon.x = 15;
         _tipIcon.y = 60;
         addChild(_bg);
         addChild(_snowTime);
         addChild(_snowLastTxt);
         addChild(_snowIconTxt);
         addChild(_matchingImg);
         addChild(_matchCountTxt);
         addChild(_stopBtn);
         addChild(_starBtn);
         addChild(_tipIcon);
         _tipIcon.tipData = LanguageMgr.GetTranslation("SevenYearGradeView.icon.tip");
         _snowLastTxt.text = LanguageMgr.GetTranslation("SevenYearSnowView.snowLastTxt.text");
         _starBtn.text = LanguageMgr.GetTranslation("SevenYearSnowView.starBtn.text");
         _stopBtn.text = LanguageMgr.GetTranslation("SevenYearSnowView.stopBtn.text");
         maxCount = ConfigInfoManager.instance.getSnowVehicleMatchMax();
         maxPoint = ConfigInfoManager.instance.getSnowVehicleDailyRewardMax();
         var _loc1_:String = ConfigInfoManager.instance.getSnowVehicleOpenTime()[1];
         endTime = DateFormatter.parse(_loc1_,"YYYY-MM-DD hh:mm");
      }
      
      private function initEvent() : void
      {
         _starBtn.addEventListener("click",__startSnowBallHandler);
         _stopBtn.addEventListener("click",__stopMatchingHandler);
         MsgMan.addObserver("UPDATE_SNOW_TEAM_COUNT",this,__updateMatchingHandler);
         model.addEventListener("UPDATE_USER_INFO",__updateSnowScoreHandler);
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
         MsgMan.removeObserver("UPDATE_SNOW_TEAM_COUNT",this,__updateMatchingHandler);
         model.removeEventListener("UPDATE_USER_INFO",__updateSnowScoreHandler);
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
         _starBtn.visible = model.snowTeamNum <= 0;
         _stopBtn.visible = model.snowTeamNum > 0;
         if(model.snowTeamNum > 0)
         {
            _matchingImg.visible = true;
            _matchCountTxt.text = model.snowTeamNum + "/" + maxCount;
         }
         else
         {
            _matchingImg.visible = false;
            _matchCountTxt.text = "";
         }
         updateTime();
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
      
      private function __startSnowBallHandler(param1:MouseEvent) : void
      {
         var _loc2_:Number = getTimer();
         if(_loc2_ - _preClickTime < 5000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _preClickTime = _loc2_;
         CampaignSocketOutManager.instance.sendEnterSnowBallVehicle(1);
      }
      
      private function __stopMatchingHandler(param1:MouseEvent) : void
      {
         CampaignSocketOutManager.instance.sendEnterSnowBallVehicle(0);
      }
      
      private function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(model.snowTeamNum > 0)
         {
            CampaignSocketOutManager.instance.sendEnterSnowBallVehicle(0);
            model.snowTeamNum = 0;
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
         ObjectUtils.disposeObject(_tipIcon);
         _tipIcon = null;
         super.dispose();
      }
   }
}

