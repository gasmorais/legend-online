package sandbox.daylight
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.controler.DayLightController;
   import sandbox.daylight.data.DayLightUnitInfo;
   import sandbox.daylight.event.DayLightEvent;
   import sandbox.net.DayLightOuterManager;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.QuickenMovieClip;
   
   public class DayLightView extends Sprite implements Disposeable, IEnterFrame
   {
      
      private var _bg:Image;
      
      private var _blueDefendInfoBg:Image;
      
      private var _blueDefendInfoTxt:FilterFrameText;
      
      private var _blueBlessingInfoBg:Image;
      
      private var _blueBlessingInfoTxt:FilterFrameText;
      
      private var _blueLairInfoBg:Image;
      
      private var _blueLairInfoTxt:FilterFrameText;
      
      private var _blueScoreBar:MovieClip;
      
      private var _blueScoreTxt:FilterFrameText;
      
      private var _blueLairLaunchContainer:Sprite;
      
      private var _blueLairAvatar:Image;
      
      private var _blueLairFleeMC:MovieClip;
      
      private var _blueLairFleeView:QuickenMovieClip;
      
      private var _blueRaidAvatar:Image;
      
      private var _blueRaidInfoBg:Image;
      
      private var _blueRaidInfoTxt:FilterFrameText;
      
      private var _blueDefendBtn:BaseButton;
      
      private var _redDefendInfoBg:Image;
      
      private var _redDefendInfoTxt:FilterFrameText;
      
      private var _redBlessingInfoBg:Image;
      
      private var _redBlessingInfoTxt:FilterFrameText;
      
      private var _redLairInfoBg:Image;
      
      private var _redLairInfoTxt:FilterFrameText;
      
      private var _redScoreBar:MovieClip;
      
      private var _redScoreTxt:FilterFrameText;
      
      private var _redLairLaunchContainer:Sprite;
      
      private var _redLairAvatar:Image;
      
      private var _redLairFleeMC:MovieClip;
      
      private var _redLairFleeView:QuickenMovieClip;
      
      private var _redRaidAvatar:Image;
      
      private var _redRaidInfoBg:Image;
      
      private var _redRaidInfoTxt:FilterFrameText;
      
      private var _redDefendBtn:BaseButton;
      
      private var _reviveViewContainer:Sprite;
      
      private var _reviveTipImg:Image;
      
      private var _reviveCountContainer:Sprite;
      
      private var _battleInfoViewContainer:Sprite;
      
      private var _battleInfoTipImg:Image;
      
      private var _battleInfoCountContainer1:Sprite;
      
      private var _battleInfoColonImg:Image;
      
      private var _battleInfoCountContainer2:Sprite;
      
      private var _timeNumBmdLair:BitmapData;
      
      private var _timeNumBmd:BitmapData;
      
      private var _helpBtn:BaseButton;
      
      private var _blueBattleView:DayLightBattleView;
      
      private var _redBattleView:DayLightBattleView;
      
      private var _topBar:DayLightTopBar;
      
      private var _rightView:DayLightRightView;
      
      private var _reviveCount:int = 0;
      
      private var _battleCount:int = 0;
      
      private var _blueLairCount:int = 0;
      
      private var _redLairCount:int = 0;
      
      private var _lastUpdateTime:Number = getTimer();
      
      private var _blueLairFleeFlag:Boolean = false;
      
      private var _redLairFleeFlag:Boolean = false;
      
      private var _controller:DayLightController = FrameControllerManager.instance.dayLightControler;
      
      private var _model:DayLightModel = _controller.model;
      
      public function DayLightView()
      {
         super();
         initView();
         addEvent();
         refreshTimeCountView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.Bg");
         _blueDefendInfoBg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.blueDefendInfoBg");
         _blueDefendInfoTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.blueDefendInfoTxt");
         _blueBlessingInfoBg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.blueBlessingInfoBg");
         _blueBlessingInfoTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.blueBlessingInfoTxt");
         _blueLairInfoBg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.blueLairInfoBg");
         _blueLairInfoTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.blueLairInfoTxt");
         _blueScoreBar = ComponentFactory.Instance.creatCustomObject("daylight.DayLightView.blueScoreBar");
         _blueScoreTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.blueScoreTxt");
         _blueLairLaunchContainer = ComponentFactory.Instance.creatCustomObject("daylight.DayLightView.blueLairLaunchContainer");
         _blueLairAvatar = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.blueLairAvatar");
         _blueLairFleeMC = ComponentFactory.Instance.creatCustomObject("daylight.DayLightView.blueLairFleeMC");
         _blueLairFleeView = new QuickenMovieClip(_blueLairFleeMC);
         _blueRaidAvatar = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.blueRaidAvatar");
         _blueRaidInfoBg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.blueRaidInfoBg");
         _blueRaidInfoTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.blueRaidInfoTxt");
         _blueDefendBtn = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.blueDefendBtn");
         _redDefendInfoBg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.redDefendInfoBg");
         _redDefendInfoTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.redDefendInfoTxt");
         _redBlessingInfoBg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.redBlessingInfoBg");
         _redBlessingInfoTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.redBlessingInfoTxt");
         _redLairInfoBg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.redLairInfoBg");
         _redLairInfoTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.redLairInfoTxt");
         _redScoreBar = ComponentFactory.Instance.creatCustomObject("daylight.DayLightView.redScoreBar");
         _redScoreTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.redScoreTxt");
         _redLairLaunchContainer = ComponentFactory.Instance.creatCustomObject("daylight.DayLightView.redLairLaunchContainer");
         _redLairAvatar = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.redLairAvatar");
         _redLairFleeMC = ComponentFactory.Instance.creatCustomObject("daylight.DayLightView.redLairFleeMC");
         _redLairFleeView = new QuickenMovieClip(_redLairFleeMC);
         _redRaidAvatar = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.redRaidAvatar");
         _redRaidInfoBg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.redRaidInfoBg");
         _redRaidInfoTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.redRaidInfoTxt");
         _redDefendBtn = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.redDefendBtn");
         _reviveViewContainer = ComponentFactory.Instance.creatCustomObject("daylight.DayLightView.reviveViewContainer");
         _reviveTipImg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.reviveTipImg");
         _reviveCountContainer = ComponentFactory.Instance.creatCustomObject("daylight.DayLightView.reviveCountContainer");
         _battleInfoViewContainer = ComponentFactory.Instance.creatCustomObject("daylight.DayLightView.battleInfoViewContainer");
         _battleInfoTipImg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.battleInfoTipImg");
         _battleInfoCountContainer1 = ComponentFactory.Instance.creatCustomObject("daylight.DayLightView.battleInfoCountContainer1");
         _battleInfoColonImg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.battleInfoColonImg");
         _battleInfoCountContainer2 = ComponentFactory.Instance.creatCustomObject("daylight.DayLightView.battleInfoCountContainer2");
         _timeNumBmdLair = ComponentFactory.Instance.creatBitmapData("asset.daylight.NumberAsset2");
         _timeNumBmd = ComponentFactory.Instance.creatBitmapData("asset.daylight.NumberAsset1");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightView.helpBtn");
         _blueBattleView = new DayLightBattleView(1);
         _blueBattleView.x = 263;
         _blueBattleView.y = 160;
         _redBattleView = new DayLightBattleView(2);
         _redBattleView.x = 263;
         _redBattleView.y = 425;
         _topBar = new DayLightTopBar();
         _topBar.x = (_bg.width - _topBar.width) * 0.5;
         _rightView = new DayLightRightView();
         _rightView.x = 960;
         _rightView.y = 155;
         _blueDefendInfoTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightView.tipsTxt01",0);
         _blueBlessingInfoTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightView.tipsTxt02",0);
         _blueLairInfoTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightView.tipsTxt03",0);
         _redDefendInfoTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightView.tipsTxt01",0);
         _redBlessingInfoTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightView.tipsTxt02",0);
         _redLairInfoTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightView.tipsTxt03",0);
         _blueScoreTxt.text = "0";
         _redScoreTxt.text = "0";
         _blueRaidInfoTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightView.tipsTxt04",0);
         _redRaidInfoTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightView.tipsTxt04",0);
         _blueScoreBar.gotoAndStop(100);
         _redScoreBar.gotoAndStop(100);
         _blueLairAvatar.visible = true;
         _blueLairFleeView.visible = false;
         _blueLairFleeView.gotoAndStop(0);
         _blueLairFleeView.addFrameScript(_blueLairFleeView.totalFrames - 1,blueLairFleeViewPlayComplete);
         refreshTimeCountValueLair("30",_blueLairLaunchContainer);
         _blueLairLaunchContainer.visible = false;
         _blueRaidAvatar.visible = false;
         _blueRaidInfoBg.visible = false;
         _blueRaidInfoTxt.visible = false;
         refreshTimeCountValueLair("30",_redLairLaunchContainer);
         _redLairLaunchContainer.visible = false;
         _redLairAvatar.visible = true;
         _redLairFleeView.visible = false;
         _redLairFleeView.gotoAndStop(0);
         _redLairFleeView.addFrameScript(_redLairFleeView.totalFrames - 1,redLairFleeViewPlayComplete);
         _redRaidAvatar.visible = false;
         _redRaidInfoBg.visible = false;
         _redRaidInfoTxt.visible = false;
         _blueDefendBtn.visible = false;
         _redDefendBtn.visible = false;
         _blueBattleView.setUIVisible(false);
         _redBattleView.setUIVisible(false);
         refreshTimeCountValue("30",_reviveCountContainer);
         refreshTimeCountValue("05",_battleInfoCountContainer1);
         refreshTimeCountValue("00",_battleInfoCountContainer2);
         _reviveViewContainer.visible = false;
         _battleInfoViewContainer.visible = false;
         _reviveViewContainer.addChild(_reviveTipImg);
         _reviveViewContainer.addChild(_reviveCountContainer);
         _battleInfoViewContainer.addChild(_battleInfoTipImg);
         _battleInfoViewContainer.addChild(_battleInfoCountContainer1);
         _battleInfoViewContainer.addChild(_battleInfoColonImg);
         _battleInfoViewContainer.addChild(_battleInfoCountContainer2);
         addChild(_bg);
         addChild(_blueDefendInfoBg);
         addChild(_blueDefendInfoTxt);
         addChild(_blueBlessingInfoBg);
         addChild(_blueBlessingInfoTxt);
         addChild(_blueLairInfoBg);
         addChild(_blueLairInfoTxt);
         addChild(_blueScoreBar);
         addChild(_blueScoreTxt);
         addChild(_blueLairLaunchContainer);
         addChild(_blueLairAvatar);
         addChild(_blueLairFleeView);
         addChild(_blueRaidAvatar);
         addChild(_blueRaidInfoBg);
         addChild(_blueRaidInfoTxt);
         addChild(_blueDefendBtn);
         addChild(_redDefendInfoBg);
         addChild(_redDefendInfoTxt);
         addChild(_redBlessingInfoBg);
         addChild(_redBlessingInfoTxt);
         addChild(_redLairInfoBg);
         addChild(_redLairInfoTxt);
         addChild(_redScoreBar);
         addChild(_redScoreTxt);
         addChild(_redLairLaunchContainer);
         addChild(_redLairAvatar);
         addChild(_redLairFleeView);
         addChild(_redRaidAvatar);
         addChild(_redRaidInfoBg);
         addChild(_redRaidInfoTxt);
         addChild(_redDefendBtn);
         addChild(_reviveViewContainer);
         addChild(_battleInfoViewContainer);
         addChild(_helpBtn);
         addChild(_blueBattleView);
         addChild(_redBattleView);
         addChild(_topBar);
         addChild(_rightView);
      }
      
      private function blueLairFleeViewPlay() : void
      {
         _blueLairFleeFlag = true;
         _blueLairAvatar.visible = false;
         _blueLairFleeView.visible = true;
         _blueLairFleeView.gotoAndPlay(1);
      }
      
      private function redLairFleeViewPlay() : void
      {
         _redLairFleeFlag = true;
         _redLairAvatar.visible = false;
         _redLairFleeView.visible = true;
         _redLairFleeView.gotoAndPlay(1);
      }
      
      private function blueLairFleeViewPlayComplete() : void
      {
         _blueLairFleeFlag = false;
         _blueLairAvatar.visible = true;
         _blueLairFleeView.visible = false;
         _blueLairFleeView.gotoAndStop(0);
      }
      
      private function redLairFleeViewPlayComplete() : void
      {
         _redLairFleeFlag = false;
         _redLairAvatar.visible = true;
         _redLairFleeView.visible = false;
         _redLairFleeView.gotoAndStop(0);
      }
      
      private function uninitView() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_blueDefendInfoBg)
         {
            ObjectUtils.disposeObject(_blueDefendInfoBg);
         }
         _blueDefendInfoBg = null;
         if(_blueDefendInfoTxt)
         {
            ObjectUtils.disposeObject(_blueDefendInfoTxt);
         }
         _blueDefendInfoTxt = null;
         if(_blueBlessingInfoBg)
         {
            ObjectUtils.disposeObject(_blueBlessingInfoBg);
         }
         _blueBlessingInfoBg = null;
         if(_blueBlessingInfoTxt)
         {
            ObjectUtils.disposeObject(_blueBlessingInfoTxt);
         }
         _blueBlessingInfoTxt = null;
         if(_blueLairInfoBg)
         {
            ObjectUtils.disposeObject(_blueLairInfoBg);
         }
         _blueLairInfoBg = null;
         if(_blueLairInfoTxt)
         {
            ObjectUtils.disposeObject(_blueLairInfoTxt);
         }
         _blueLairInfoTxt = null;
         if(_blueScoreBar)
         {
            ObjectUtils.disposeObject(_blueScoreBar);
         }
         _blueScoreBar = null;
         if(_blueScoreTxt)
         {
            ObjectUtils.disposeObject(_blueScoreTxt);
         }
         _blueScoreTxt = null;
         if(_blueLairLaunchContainer)
         {
            ObjectUtils.disposeObject(_blueLairLaunchContainer);
         }
         _blueLairLaunchContainer = null;
         if(_blueLairAvatar)
         {
            ObjectUtils.disposeObject(_blueLairAvatar);
         }
         _blueLairAvatar = null;
         if(_blueLairFleeMC)
         {
            ObjectUtils.disposeObject(_blueLairFleeMC);
         }
         _blueLairFleeMC = null;
         if(_blueLairFleeView)
         {
            ObjectUtils.disposeObject(_blueLairFleeView);
         }
         _blueLairFleeView = null;
         if(_blueRaidAvatar)
         {
            ObjectUtils.disposeObject(_blueRaidAvatar);
         }
         _blueRaidAvatar = null;
         if(_blueRaidInfoBg)
         {
            ObjectUtils.disposeObject(_blueRaidInfoBg);
         }
         _blueRaidInfoBg = null;
         if(_blueRaidInfoTxt)
         {
            ObjectUtils.disposeObject(_blueRaidInfoTxt);
         }
         _blueRaidInfoTxt = null;
         if(_blueDefendBtn)
         {
            ObjectUtils.disposeObject(_blueDefendBtn);
         }
         _blueDefendBtn = null;
         if(_redDefendInfoBg)
         {
            ObjectUtils.disposeObject(_redDefendInfoBg);
         }
         _redDefendInfoBg = null;
         if(_redDefendInfoTxt)
         {
            ObjectUtils.disposeObject(_redDefendInfoTxt);
         }
         _redDefendInfoTxt = null;
         if(_redBlessingInfoBg)
         {
            ObjectUtils.disposeObject(_redBlessingInfoBg);
         }
         _redBlessingInfoBg = null;
         if(_redBlessingInfoTxt)
         {
            ObjectUtils.disposeObject(_redBlessingInfoTxt);
         }
         _redBlessingInfoTxt = null;
         if(_redLairInfoBg)
         {
            ObjectUtils.disposeObject(_redLairInfoBg);
         }
         _redLairInfoBg = null;
         if(_redLairInfoTxt)
         {
            ObjectUtils.disposeObject(_redLairInfoTxt);
         }
         _redLairInfoTxt = null;
         if(_redScoreBar)
         {
            ObjectUtils.disposeObject(_redScoreBar);
         }
         _redScoreBar = null;
         if(_redScoreTxt)
         {
            ObjectUtils.disposeObject(_redScoreTxt);
         }
         _redScoreTxt = null;
         if(_redLairLaunchContainer)
         {
            ObjectUtils.disposeObject(_redLairLaunchContainer);
         }
         _redLairLaunchContainer = null;
         if(_redLairAvatar)
         {
            ObjectUtils.disposeObject(_redLairAvatar);
         }
         _redLairAvatar = null;
         if(_redLairFleeMC)
         {
            ObjectUtils.disposeObject(_redLairFleeMC);
         }
         _redLairFleeMC = null;
         if(_redLairFleeView)
         {
            ObjectUtils.disposeObject(_redLairFleeView);
         }
         _redLairFleeView = null;
         if(_redRaidAvatar)
         {
            ObjectUtils.disposeObject(_redRaidAvatar);
         }
         _redRaidAvatar = null;
         if(_redRaidInfoBg)
         {
            ObjectUtils.disposeObject(_redRaidInfoBg);
         }
         _redRaidInfoBg = null;
         if(_redRaidInfoTxt)
         {
            ObjectUtils.disposeObject(_redRaidInfoTxt);
         }
         _redRaidInfoTxt = null;
         if(_redDefendBtn)
         {
            ObjectUtils.disposeObject(_redDefendBtn);
         }
         _redDefendBtn = null;
         if(_reviveViewContainer)
         {
            ObjectUtils.disposeObject(_reviveViewContainer);
         }
         _reviveViewContainer = null;
         if(_reviveTipImg)
         {
            ObjectUtils.disposeObject(_reviveTipImg);
         }
         _reviveTipImg = null;
         if(_reviveCountContainer)
         {
            ObjectUtils.disposeObject(_reviveCountContainer);
         }
         _reviveCountContainer = null;
         if(_battleInfoViewContainer)
         {
            ObjectUtils.disposeObject(_battleInfoViewContainer);
         }
         _battleInfoViewContainer = null;
         if(_battleInfoTipImg)
         {
            ObjectUtils.disposeObject(_battleInfoTipImg);
         }
         _battleInfoTipImg = null;
         if(_battleInfoCountContainer1)
         {
            ObjectUtils.disposeObject(_battleInfoCountContainer1);
         }
         _battleInfoCountContainer1 = null;
         if(_battleInfoColonImg)
         {
            ObjectUtils.disposeObject(_battleInfoColonImg);
         }
         _battleInfoColonImg = null;
         if(_battleInfoCountContainer2)
         {
            ObjectUtils.disposeObject(_battleInfoCountContainer2);
         }
         _battleInfoCountContainer2 = null;
         if(_timeNumBmdLair)
         {
            ObjectUtils.disposeObject(_timeNumBmdLair);
         }
         _timeNumBmdLair = null;
         if(_timeNumBmd)
         {
            ObjectUtils.disposeObject(_timeNumBmd);
         }
         _timeNumBmd = null;
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
         }
         _helpBtn = null;
         if(_blueBattleView)
         {
            ObjectUtils.disposeObject(_blueBattleView);
         }
         _blueBattleView = null;
         if(_redBattleView)
         {
            ObjectUtils.disposeObject(_redBattleView);
         }
         _redBattleView = null;
         if(_topBar)
         {
            ObjectUtils.disposeObject(_topBar);
         }
         _topBar = null;
         if(_rightView)
         {
            ObjectUtils.disposeObject(_rightView);
         }
         _rightView = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _controller = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         _model.addEventListener("SANDBOX_INFO_UPDATE",__sandboxInfoUpdateHandler);
         _model.addEventListener("SELF_INFO_UPDATE",__selfInfoUpdateHandler);
         _model.addEventListener("UNIT_INFO_LIST_UPDATE",__unitInfoListUpdateHandler);
         _model.addEventListener("SKILL_USE_RESULT_UPDATE",__skillUseResultUpdateHandler);
         _blueDefendBtn.addEventListener("click",__defendBtnClickHandler);
         _redDefendBtn.addEventListener("click",__defendBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         _model.removeEventListener("SANDBOX_INFO_UPDATE",__sandboxInfoUpdateHandler);
         _model.removeEventListener("SELF_INFO_UPDATE",__selfInfoUpdateHandler);
         _model.removeEventListener("UNIT_INFO_LIST_UPDATE",__unitInfoListUpdateHandler);
         _model.removeEventListener("SKILL_USE_RESULT_UPDATE",__skillUseResultUpdateHandler);
         _blueDefendBtn.removeEventListener("click",__defendBtnClickHandler);
         _redDefendBtn.removeEventListener("click",__defendBtnClickHandler);
      }
      
      private function __defendBtnClickHandler(param1:MouseEvent) : void
      {
         if(_model.selfInfo && _model.selfInfo.state == 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("sandbox.scence.dieOp"));
            return;
         }
         DayLightOuterManager.defend();
      }
      
      private function __sandboxInfoUpdateHandler(param1:DayLightEvent) : void
      {
         refreshView();
      }
      
      private function __selfInfoUpdateHandler(param1:DayLightEvent) : void
      {
         refreshSelfView();
      }
      
      private function __unitInfoListUpdateHandler(param1:DayLightEvent) : void
      {
         refreshBattleView();
      }
      
      private function __skillUseResultUpdateHandler(param1:DayLightEvent) : void
      {
         if(_model.skillUseId == 410201)
         {
            if(_model.skillUseTeam == 1)
            {
               if(!_blueLairFleeFlag)
               {
                  blueLairFleeViewPlay();
               }
            }
            else if(!_redLairFleeFlag)
            {
               redLairFleeViewPlay();
            }
         }
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("daylight.HelperFrame");
         _loc2_.show();
      }
      
      private function setBlueRaidVisible(param1:Boolean = false) : void
      {
         _blueRaidAvatar.visible = param1;
         _blueRaidInfoBg.visible = param1;
         _blueRaidInfoTxt.visible = param1;
      }
      
      private function setRedRaidVisible(param1:Boolean = false) : void
      {
         _redRaidAvatar.visible = param1;
         _redRaidInfoBg.visible = param1;
         _redRaidInfoTxt.visible = param1;
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 1;
         var _loc1_:int = 1;
         var _loc2_:int = 1;
         setBlueRaidVisible();
         setRedRaidVisible();
         if(_model.blueTeamInfo)
         {
            _blueDefendInfoTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightView.tipsTxt01",_model.blueTeamInfo.defendCount);
            _blueBlessingInfoTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightView.tipsTxt02",_model.blueTeamInfo.blessCount);
            _blueLairInfoTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightView.tipsTxt03",_model.blueTeamInfo.leftNpcCount);
            _blueRaidInfoTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightView.tipsTxt04",_model.blueTeamInfo.assaultCount);
            if(_model.blueTeamInfo.assaultCount > 0)
            {
               setBlueRaidVisible(true);
            }
            _loc1_ = int(_model.blueTeamInfo.towerHp);
            _loc2_ = int(_model.blueTeamInfo.towerMaxHp);
            _blueScoreTxt.text = _model.blueTeamInfo.towerHp.toString();
         }
         _loc3_ = _loc1_ * 100 / _loc2_;
         if(_loc3_ <= 0)
         {
            _loc3_ = 1;
         }
         _blueScoreBar.gotoAndStop(_loc3_);
         if(_model.redTeamInfo)
         {
            _redDefendInfoTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightView.tipsTxt01",_model.redTeamInfo.defendCount);
            _redBlessingInfoTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightView.tipsTxt02",_model.redTeamInfo.blessCount);
            _redLairInfoTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightView.tipsTxt03",_model.redTeamInfo.leftNpcCount);
            _redRaidInfoTxt.text = LanguageMgr.GetTranslation("sandbox.daylight.DayLightView.tipsTxt04",_model.redTeamInfo.assaultCount);
            if(_model.redTeamInfo.assaultCount > 0)
            {
               setRedRaidVisible(true);
            }
            _loc1_ = int(_model.redTeamInfo.towerHp);
            _loc2_ = int(_model.redTeamInfo.towerMaxHp);
            _redScoreTxt.text = _model.redTeamInfo.towerHp.toString();
         }
         _loc3_ = _loc1_ * 100 / _loc2_;
         if(_loc3_ <= 0)
         {
            _loc3_ = 1;
         }
         _redScoreBar.gotoAndStop(_loc3_);
         initTimeCount();
      }
      
      private function refreshSelfView() : void
      {
         _blueDefendBtn.visible = false;
         _redDefendBtn.visible = false;
         _blueBattleView.setUIVisible(false);
         _redBattleView.setUIVisible(false);
         if(_model.selfInfo)
         {
            if(_model.selfInfo.team == 1)
            {
               _blueDefendBtn.visible = true;
               _blueBattleView.setUIVisible(attackEnable);
            }
            else
            {
               _redDefendBtn.visible = true;
               _redBattleView.setUIVisible(attackEnable);
            }
         }
         initSelfTimeCount();
      }
      
      private function get attackEnable() : Boolean
      {
         var _loc1_:Boolean = false;
         if(_model.selfInfo)
         {
            if(_model.selfInfo.state != 1 && _model.selfInfo.state != 2)
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      private function refreshBattleView() : void
      {
         var _loc4_:DayLightUnitInfo = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         if(_model.blueUnitList)
         {
            _loc1_ = int(_model.blueUnitList.length);
            _loc6_ = _blueBattleView.avatarIdList.concat();
            _loc7_ = [];
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc4_ = _model.blueUnitList[_loc2_];
               _loc3_ = _loc6_.indexOf(_loc4_.id);
               if(_loc3_ != -1)
               {
                  _loc7_.push(_loc4_.id);
               }
               _blueBattleView.addUnit(_loc4_);
               _loc2_++;
            }
            _loc1_ = int(_loc6_.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc5_ = int(_loc6_[_loc2_]);
               _loc3_ = _loc7_.indexOf(_loc5_);
               if(_loc3_ == -1)
               {
                  _blueBattleView.removeUnitById(_loc5_);
               }
               _loc2_++;
            }
         }
         if(_model.redUnitList)
         {
            _loc1_ = int(_model.redUnitList.length);
            _loc6_ = _redBattleView.avatarIdList.concat();
            _loc7_ = [];
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc4_ = _model.redUnitList[_loc2_];
               _loc3_ = _loc6_.indexOf(_loc4_.id);
               if(_loc3_ != -1)
               {
                  _loc7_.push(_loc4_.id);
               }
               _redBattleView.addUnit(_loc4_);
               _loc2_++;
            }
            _loc1_ = int(_loc6_.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc5_ = int(_loc6_[_loc2_]);
               _loc3_ = _loc7_.indexOf(_loc5_);
               if(_loc3_ == -1)
               {
                  _redBattleView.removeUnitById(_loc5_);
               }
               _loc2_++;
            }
         }
      }
      
      private function initSelfTimeCount() : void
      {
         if(_model.selfInfo)
         {
            _reviveCount = _model.selfInfo.reviveCd;
         }
      }
      
      private function initTimeCount() : void
      {
         _battleCount = _model.fightBeginCd;
         if(_model.blueTeamInfo)
         {
            _blueLairCount = _model.blueTeamInfo.createNpcCd;
         }
         if(_model.redTeamInfo)
         {
            _redLairCount = _model.redTeamInfo.createNpcCd;
         }
      }
      
      private function refreshTimeCountValueLair(param1:String, param2:Sprite) : void
      {
         NumberViewUtils.refreshTimeValue(param1,param2,_timeNumBmdLair,24,30,24,24,"0123456789");
      }
      
      private function refreshTimeCountValue(param1:String, param2:Sprite) : void
      {
         NumberViewUtils.refreshTimeValue(param1,param2,_timeNumBmd,20,27,20,20,"0123456789");
      }
      
      public function getIntStrAtLength(param1:uint, param2:uint) : String
      {
         return DateFormatter.getIntStrAtLength(param1,param2);
      }
      
      private function refreshTimeCountView() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(_reviveCount > 0)
         {
            refreshTimeCountValue(_reviveCount.toString(),_reviveCountContainer);
            _reviveViewContainer.visible = true;
         }
         else
         {
            _reviveViewContainer.visible = false;
         }
         if(_battleCount > 0)
         {
            _loc3_ = Math.floor(_battleCount / 60);
            _loc4_ = Math.floor(_battleCount % 60);
            _loc1_ = getIntStrAtLength(_loc3_,2);
            _loc2_ = getIntStrAtLength(_loc4_,2);
            refreshTimeCountValue(_loc1_,_battleInfoCountContainer1);
            refreshTimeCountValue(_loc2_,_battleInfoCountContainer2);
            _battleInfoViewContainer.visible = true;
            if(_reviveViewContainer.visible)
            {
               _battleInfoViewContainer.y = 100;
            }
            else
            {
               _battleInfoViewContainer.y = 85;
            }
         }
         else
         {
            _battleInfoViewContainer.visible = false;
         }
         if(_blueLairCount > 0)
         {
            refreshTimeCountValueLair(_blueLairCount.toString(),_blueLairLaunchContainer);
            _blueLairLaunchContainer.visible = true;
         }
         else
         {
            _blueLairLaunchContainer.visible = false;
         }
         if(_redLairCount > 0)
         {
            refreshTimeCountValueLair(_redLairCount.toString(),_redLairLaunchContainer);
            _redLairLaunchContainer.visible = true;
         }
         else
         {
            _redLairLaunchContainer.visible = false;
         }
      }
      
      public function enterFrame() : void
      {
         var _loc2_:Number = getTimer();
         var _loc1_:Number = _loc2_ - _lastUpdateTime;
         var _loc3_:int = 0;
         if(_loc1_ >= 1000)
         {
            _loc3_ = _loc1_ / 1000;
            _reviveCount -= _loc3_;
            _battleCount -= _loc3_;
            _blueLairCount -= _loc3_;
            _redLairCount -= _loc3_;
            refreshTimeCountView();
            _lastUpdateTime = _loc2_;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

