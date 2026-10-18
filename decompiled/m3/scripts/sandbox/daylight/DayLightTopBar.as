package sandbox.daylight
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import map.campaign.view.ui.DownTimeView;
   import mvc.controler.DayLightController;
   import sandbox.daylight.event.DayLightEvent;
   import yishi.manager.FrameControllerManager;
   
   public class DayLightTopBar extends Sprite implements Disposeable
   {
      
      private var _bg:Image;
      
      private var _titleImg:Image;
      
      private var _blueLogo:Image;
      
      private var _blueScoreTip:StripView;
      
      private var _blueScoreBar:MovieClip;
      
      private var _blueScoreLabel:Image;
      
      private var _blueScoreTxt:FilterFrameText;
      
      private var _blueCountLabel:Image;
      
      private var _blueCountTxt:FilterFrameText;
      
      private var _blueConsoriaTxt:FilterFrameText;
      
      private var _redLogo:Image;
      
      private var _redScoreTip:StripView;
      
      private var _redScoreBar:MovieClip;
      
      private var _redScoreLabel:Image;
      
      private var _redScoreTxt:FilterFrameText;
      
      private var _redCountLabel:Image;
      
      private var _redCountTxt:FilterFrameText;
      
      private var _redConsoriaTxt:FilterFrameText;
      
      private var _topDownTime:DownTimeView;
      
      private var _lastCount:int = 0;
      
      private var _topDownInited:Boolean = false;
      
      private var _controller:DayLightController = FrameControllerManager.instance.dayLightControler;
      
      private var _model:DayLightModel = _controller.model;
      
      public function DayLightTopBar()
      {
         super();
         initView();
         addEvent();
         updateTime();
         update();
         this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightTopBar.bg");
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightTopBar.titleImg");
         _blueLogo = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightTopBar.blueLogo");
         _blueScoreTip = ComponentFactory.Instance.creatCustomObject("daylight.DayLightTopBar.buleScoreTip");
         _blueScoreBar = ComponentFactory.Instance.creatCustomObject("daylight.DayLightTopBar.buleScoreBar");
         _blueScoreLabel = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightTopBar.blueScoreLabel");
         _blueScoreTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightTopBar.blueScoreTxt");
         _blueCountLabel = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightTopBar.blueCountLabel");
         _blueCountTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightTopBar.blueCountTxt");
         _blueConsoriaTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightTopBar.blueConsoriaTxt");
         _redLogo = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightTopBar.redLogo");
         _redScoreTip = ComponentFactory.Instance.creatCustomObject("daylight.DayLightTopBar.redScoreTip");
         _redScoreBar = ComponentFactory.Instance.creatCustomObject("daylight.DayLightTopBar.redScoreBar");
         _redScoreLabel = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightTopBar.redScoreLabel");
         _redScoreTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightTopBar.redScoreTxt");
         _redCountLabel = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightTopBar.redCountLabel");
         _redCountTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightTopBar.redCountTxt");
         _redConsoriaTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightTopBar.redConsoriaTxt");
         _topDownTime = new DownTimeView(false);
         _topDownTime.x = 161;
         _topDownTime.y = -16;
         _blueScoreTxt.text = "0";
         _blueCountTxt.text = "0";
         _redScoreTxt.text = "0";
         _redCountTxt.text = "0";
         _blueScoreBar.gotoAndStop(100);
         _redScoreBar.gotoAndStop(100);
         _blueScoreTip.addChild(_blueScoreBar);
         _redScoreTip.addChild(_redScoreBar);
         addChild(_bg);
         addChild(_titleImg);
         addChild(_blueLogo);
         addChild(_blueScoreTip);
         addChild(_blueScoreLabel);
         addChild(_blueScoreTxt);
         addChild(_blueCountLabel);
         addChild(_blueCountTxt);
         addChild(_blueConsoriaTxt);
         addChild(_redLogo);
         addChild(_redScoreTip);
         addChild(_redScoreLabel);
         addChild(_redScoreTxt);
         addChild(_redCountLabel);
         addChild(_redCountTxt);
         addChild(_redConsoriaTxt);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_blueLogo);
         _blueLogo = null;
         ObjectUtils.disposeObject(_blueScoreTip);
         _blueScoreTip = null;
         ObjectUtils.disposeObject(_blueScoreBar);
         _blueScoreBar = null;
         ObjectUtils.disposeObject(_blueScoreLabel);
         _blueScoreLabel = null;
         ObjectUtils.disposeObject(_blueScoreTxt);
         _blueScoreTxt = null;
         ObjectUtils.disposeObject(_blueCountLabel);
         _blueCountLabel = null;
         ObjectUtils.disposeObject(_blueCountTxt);
         _blueCountTxt = null;
         ObjectUtils.disposeObject(_redLogo);
         _redLogo = null;
         ObjectUtils.disposeObject(_redCountLabel);
         _redCountLabel = null;
         ObjectUtils.disposeObject(_redCountTxt);
         _redCountTxt = null;
         ObjectUtils.disposeObject(_redScoreTip);
         _redScoreTip = null;
         ObjectUtils.disposeObject(_redScoreBar);
         _redScoreBar = null;
         ObjectUtils.disposeObject(_redScoreLabel);
         _redScoreLabel = null;
         ObjectUtils.disposeObject(_redScoreTxt);
         _redScoreTxt = null;
         ObjectUtils.disposeObject(_topDownTime);
         _topDownTime = null;
         ObjectUtils.disposeObject(_blueConsoriaTxt);
         _blueConsoriaTxt = null;
         ObjectUtils.disposeObject(_redConsoriaTxt);
         _redConsoriaTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         _model.addEventListener("SANDBOX_INFO_UPDATE",__sandboxInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("SANDBOX_INFO_UPDATE",__sandboxInfoUpdateHandler);
         }
      }
      
      private function __sandboxInfoUpdateHandler(param1:DayLightEvent) : void
      {
         update();
         updateTime();
      }
      
      private function updateTime() : void
      {
         if(_topDownTime)
         {
            if(!_topDownInited)
            {
               _topDownInited = true;
               _topDownTime.count = 0;
            }
            if(_model.fightBeginCd > 0)
            {
               if(_lastCount != 0)
               {
                  _topDownTime.count = 0;
                  _lastCount = 0;
               }
            }
            else if(_lastCount != _model.fightEndCd)
            {
               _topDownTime.count = _model.fightEndCd;
               _lastCount = _model.fightEndCd;
            }
         }
         if(!contains(_topDownTime))
         {
            addChild(_topDownTime);
         }
      }
      
      public function update() : void
      {
         var _loc3_:int = 1;
         var _loc1_:Number = 1;
         var _loc2_:Number = 1;
         if(_model.blueTeamInfo)
         {
            _blueScoreTxt.text = _model.blueTeamInfo.teamScore.toString();
            _blueCountTxt.text = _model.blueTeamInfo.teamCount.toString();
            _blueConsoriaTxt.text = _model.blueTeamInfo.consortiaName;
            _loc1_ = Number(_model.blueTeamInfo.towerHp);
            _loc2_ = Number(_model.blueTeamInfo.towerMaxHp);
         }
         _loc3_ = _loc1_ * 100 / _loc2_;
         if(_loc3_ <= 0)
         {
            _loc3_ = 1;
         }
         _blueScoreBar.gotoAndStop(_loc3_);
         _blueScoreTip.tipData = LanguageMgr.GetTranslation("map.campaign.view.ui.daylight.DayLightTopBar.blueScoreTip",_loc1_);
         if(_model.blueTeamInfo)
         {
            _redScoreTxt.text = _model.redTeamInfo.teamScore.toString();
            _redCountTxt.text = _model.redTeamInfo.teamCount.toString();
            _redConsoriaTxt.text = _model.redTeamInfo.consortiaName;
            _loc1_ = Number(_model.redTeamInfo.towerHp);
            _loc2_ = Number(_model.redTeamInfo.towerMaxHp);
         }
         _loc3_ = _loc1_ * 100 / _loc2_;
         if(_loc3_ <= 0)
         {
            _loc3_ = 1;
         }
         _redScoreBar.gotoAndStop(_loc3_);
         _redScoreTip.tipData = LanguageMgr.GetTranslation("map.campaign.view.ui.daylight.DayLightTopBar.redScoreTip",_loc1_);
      }
      
      override public function get width() : Number
      {
         return 501;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,false,false,0,0);
      }
      
      public function dispose() : void
      {
         removeEvent();
         uintView();
      }
   }
}

