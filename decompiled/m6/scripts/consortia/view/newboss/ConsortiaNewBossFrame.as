package consortia.view.newboss
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.view.newboss.item.ConsortiaNewBossRankItem;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import mvc.controler.ConsortiaControler;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaNewBossModel;
   import mvc.module.consortia.ConsortiaNewBossRankInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.ConsortiaNewBossRankRewardTemplateInfo;
   import yishi.datas.templates.ConsortiaNewBossTemplate;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.ConsortiaNewBossManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.IconFactory;
   import yishi.utils.StringHelper;
   import yishi.view.base.ProgressPanel;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.TimeDownView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaNewBossFrame extends Frame implements IManualSize
   {
      
      private var _titleBg:Bitmap;
      
      private var _leftRibbonImage:Image;
      
      private var _rightRibbonImage:Image;
      
      private var _titleImage:Bitmap;
      
      private var _helpBtn:BaseButton;
      
      private var _border:ScaleBitmapImage;
      
      private var _bg:MutipleImage;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _myRankTxt:FilterFrameText;
      
      private var _myDamageTxt:FilterFrameText;
      
      private var _successTxt:FilterFrameText;
      
      private var _failTxt:FilterFrameText;
      
      private var _openBtn:IconButton;
      
      private var _battelBtn:IconButton;
      
      private var _notOpenBtn:IconButton;
      
      private var _replyTimeTxt:FilterFrameText;
      
      private var _leftCountTxt:FilterFrameText;
      
      private var _bossNameBgImage:Image;
      
      private var _bossNameBgImage2:Image;
      
      private var _bossNameTxt:GradientText;
      
      private var _bossLvTxt:GradientText;
      
      private var _bossContent:Sprite;
      
      private var _bossIcon:BaseIconView;
      
      private var _bossIconBox:Bitmap;
      
      private var _bossWait:Bitmap;
      
      private var _bossWaitTxt:FilterFrameText;
      
      private var _bossHp:ProgressPanel;
      
      private var _bossGray:Array;
      
      private var _leftBattleTimeTxt:FilterFrameText;
      
      private var _damageRewardImg:Image;
      
      private var _bufferImg:Image;
      
      private var _bossLeftTimeBg:Image;
      
      private var _bossLvBg:Image;
      
      private var _leftCountImg:Image;
      
      private var _bufferShopBtn:BaseButton;
      
      private var _bossShopBtn:BaseButton;
      
      private var _successRewardHbox:HBox;
      
      private var _failRewardHbox:HBox;
      
      private var _fightCountTime:TimeDownView;
      
      private var _replyTxt:FilterFrameText;
      
      private var _skipHelp:BaseButton;
      
      private var _skipDesTxt:FilterFrameText;
      
      private var _sbDesTxt:FilterFrameText;
      
      private var _sb2DesTxt:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _timeStepIndex:Array = [];
      
      private var _timeStepValue:Array = [];
      
      private var _a:int;
      
      private var _isHideSkip:Boolean;
      
      private var _willDate:Date = new Date();
      
      public function ConsortiaNewBossFrame()
      {
         super();
         initView();
         addEvent();
         ConsortiaNewBossManager.instance.openFrame();
         refreshView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,965,633);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc5_:Array = null;
         var _loc1_:Array = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("consortia_newboss_time");
         if(_loc2_)
         {
            _loc5_ = _loc2_.ConfigValue.split("|");
            _loc4_ = 0;
            while(_loc4_ < _loc5_.length)
            {
               _loc3_ = _loc5_[_loc4_];
               _loc1_ = _loc3_.split(",");
               _timeStepIndex.push(int(_loc1_[0]));
               _timeStepValue.push(int(_loc1_[1]));
               _loc4_++;
            }
         }
         _loc2_ = TempleteManager.instance.getConfigInfoByConfigName("consortia_newboss_param");
         if(_loc2_)
         {
            _a = int(_loc2_.ConfigValue);
         }
         _titleBg = ComponentFactory.Instance.creatBitmap("asset.Consortia.ConsortiaFrame.titleImage");
         _titleImage = ComponentFactory.Instance.creatBitmap("asset.consortianewboss.titleImage");
         _leftRibbonImage = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaFrame.leftRibbonImage");
         _rightRibbonImage = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaFrame.rightRibbonImage");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.helpBtn");
         _skipHelp = ComponentFactory.Instance.creatComponentByStylename("consortia.helpBtn");
         _border = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.border");
         _bg = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bg");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.vbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.scrollPanel");
         _myRankTxt = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.myRankTxt");
         _myDamageTxt = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.myDamageTxt");
         _successTxt = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.successTxt");
         _failTxt = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.failTxt");
         _replyTimeTxt = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.replyTimeTxt");
         _leftCountTxt = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.leftCountTxt");
         _bossNameTxt = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bossNameTxt");
         _bossLvTxt = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bossLvTxt");
         _leftBattleTimeTxt = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.leftBattleTimeTxt");
         _damageRewardImg = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.damageRewardImg");
         _bufferImg = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bufferImg");
         _bossNameBgImage = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bossNameBgImage");
         _bossNameBgImage2 = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bossNameBgImage2");
         _bossLeftTimeBg = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bossLeftTimeBg");
         _bossLvBg = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bossLvBg");
         _leftCountImg = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.leftCountImg");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.openBtn");
         _notOpenBtn = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.notOpenBtn");
         _battelBtn = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.battelBtn");
         _bufferShopBtn = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bufferShopBtn");
         _bossShopBtn = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bossShopBtn");
         _successRewardHbox = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.successRewardHbox");
         _failRewardHbox = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.failRewardHbox");
         _fightCountTime = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.fightCountTime");
         _replyTxt = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.replyTxt");
         _skipDesTxt = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.skipDesTxt");
         _sbDesTxt = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.skipDesTxt");
         _sb2DesTxt = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.sbDesTxt");
         _bossIcon = ComponentFactory.Instance.creatCustomObject("ui.consortiaNewBoss.HeadIcon");
         _bossIconBox = ComponentFactory.Instance.creatBitmap("asset.consortianewboss.bg2Icon");
         _bossHp = ComponentFactory.Instance.creatCustomObject("ui.consortianewboss.bossHp");
         _bossHp.initView(null,"asset.consortianewboss.hpBar","ui.consortianewboss.bossHpTxt");
         _bossWaitTxt = ComponentFactory.Instance.creatComponentByStylename("asset.consortianewboss.waitTxt");
         _bossWait = ComponentFactory.Instance.creatBitmap("asset.consortianewboss.waitIcon");
         _bossGray = [UIFilter.getGrayFilter()];
         _bossContent = new Sprite();
         addToContent(_titleBg);
         _titleBg.y = -74;
         addToContent(_leftRibbonImage);
         _leftRibbonImage.y = -54;
         _leftRibbonImage.x = -75;
         addToContent(_rightRibbonImage);
         _rightRibbonImage.y = -54;
         _rightRibbonImage.x = 705;
         addToContent(_titleImage);
         addToContent(_border);
         addToContent(_bossLeftTimeBg);
         addToContent(_bg);
         addToContent(_vbox);
         addToContent(_scrollPanel);
         addToContent(_myRankTxt);
         addToContent(_myDamageTxt);
         addToContent(_helpBtn);
         _helpBtn.x = 880;
         _helpBtn.y = -40;
         addToContent(_successTxt);
         addToContent(_failTxt);
         addToContent(_openBtn);
         addToContent(_notOpenBtn);
         addToContent(_battelBtn);
         addToContent(_bossNameBgImage);
         addToContent(_bossNameBgImage2);
         addToContent(_bossLvBg);
         addToContent(_leftCountImg);
         addToContent(_replyTimeTxt);
         addToContent(_leftCountTxt);
         addToContent(_bossNameTxt);
         addToContent(_bossLvTxt);
         addToContent(_leftBattleTimeTxt);
         addToContent(_damageRewardImg);
         addToContent(_bufferImg);
         addToContent(_bufferShopBtn);
         addToContent(_bossShopBtn);
         addToContent(_successRewardHbox);
         addToContent(_failRewardHbox);
         addToContent(_fightCountTime);
         addToContent(_replyTxt);
         addToContent(_skipDesTxt);
         addToContent(_sbDesTxt);
         addToContent(_sb2DesTxt);
         addToContent(_skipHelp);
         addToContent(_bossContent);
         addToContent(_bossWait);
         addToContent(_bossWaitTxt);
         _bossContent.addChild(_bossIcon);
         _bossContent.addChild(_bossIconBox);
         _bossContent.addChild(_bossHp);
         _scrollPanel.setView(_vbox);
         _successTxt.text = LanguageMgr.GetTranslation("ConsortiaEmeDreamRewardFrame.winTitleText.text");
         _failTxt.text = LanguageMgr.GetTranslation("ConsortiaEmeDreamRewardFrame.lostTitleText.text");
         _bossWaitTxt.text = LanguageMgr.GetTranslation("consorienewboss.sbname2");
         _skipHelp.x = 720;
         _skipHelp.y = 62;
         _skipHelp.visible = false;
         _timer = new Timer(10000);
         _timer.start();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _openBtn.addEventListener("click",__openBtnHandler);
         _notOpenBtn.addEventListener("click",__openBtnHandler);
         _battelBtn.addEventListener("click",__battleBtnHandler);
         _bufferShopBtn.addEventListener("click",__bufferShopBtnHandler);
         _bossShopBtn.addEventListener("click",__bossShopBtnHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         _skipHelp.addEventListener("click",__skiphelpBtnClickHandler);
         _fightCountTime.addEventListener("timerDown_complete",_timeCompleteHandler);
         model.addEventListener("CONSORTIA_NEW_BOSS_BUFFER_CLEAR",__clearBufferTipsHandler);
         NotificationManager.instance.addEventListener("CONSORTIA_NEW_BOSS_INFO_UPDATE",__bossInfoUpdate);
         NotificationManager.instance.addEventListener("CONSORTIA_NEW_BOSS_RANK_UPDATE",__bossRankInfoUpdate);
         NotificationManager.instance.addEventListener("CONSORTIA_NEW_BOSS_USERINFO_UPDATE",__bossUserInfoUpdate);
         _timer.addEventListener("timer",timerHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _openBtn.removeEventListener("click",__openBtnHandler);
         _notOpenBtn.removeEventListener("click",__openBtnHandler);
         _battelBtn.removeEventListener("click",__battleBtnHandler);
         _bufferShopBtn.removeEventListener("click",__bufferShopBtnHandler);
         _bossShopBtn.removeEventListener("click",__bossShopBtnHandler);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         }
         if(_skipHelp)
         {
            _skipHelp.removeEventListener("click",__skiphelpBtnClickHandler);
         }
         _fightCountTime.removeEventListener("timerDown_complete",_timeCompleteHandler);
         model.removeEventListener("CONSORTIA_NEW_BOSS_BUFFER_CLEAR",__clearBufferTipsHandler);
         NotificationManager.instance.removeEventListener("CONSORTIA_NEW_BOSS_INFO_UPDATE",__bossInfoUpdate);
         NotificationManager.instance.removeEventListener("CONSORTIA_NEW_BOSS_RANK_UPDATE",__bossRankInfoUpdate);
         NotificationManager.instance.removeEventListener("CONSORTIA_NEW_BOSS_USERINFO_UPDATE",__bossUserInfoUpdate);
         _timer.removeEventListener("timer",timerHandler);
      }
      
      private function timerHandler(param1:TimerEvent = null) : void
      {
         var _loc8_:* = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Number = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
         var _loc3_:Number = _loc7_ - (model.startTime.time + _timeStepIndex[_timeStepIndex.length - 1] * 60 * 1000);
         if(_isHideSkip || _loc3_ > 0 || model.callLevel >= 1000 || model.callLevel <= model.passLevel)
         {
            _skipDesTxt.visible = false;
         }
         else
         {
            _skipDesTxt.visible = true;
            _skipHelp.visible = true;
            _loc2_ = int(model.callLevel);
            _loc5_ = 0;
            while(_loc5_ < _timeStepIndex.length)
            {
               _loc3_ = _loc7_ - (model.startTime.time + _timeStepIndex[_loc5_] * 60 * 1000);
               if(_loc3_ < 0)
               {
                  _loc8_ = _loc5_;
                  _willDate.time = model.startTime.time + _timeStepIndex[_loc5_] * 60 * 1000;
                  if(_loc5_ == 0)
                  {
                     _loc9_ = model.bestCount + 1;
                     if(_loc9_ >= 2)
                     {
                        _loc2_ += 7 + _a * (_loc9_ - 1);
                     }
                     else
                     {
                        _loc2_ += _timeStepValue[_loc8_];
                     }
                  }
                  else
                  {
                     _loc2_ += _timeStepValue[_loc8_];
                  }
                  break;
               }
               _loc5_++;
            }
            _loc4_ = int(model.maxLevel);
            if(_loc2_ >= _loc4_)
            {
               _loc2_ = _loc4_;
            }
            _loc6_ = DateFormatter.format(_willDate,"YYYY-MM-DD hh:mm:ss");
            _skipDesTxt.htmlText = LanguageMgr.GetTranslation("consorienewboss.skip.time",_loc6_,_loc2_);
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:GameHeroTempInfo = null;
         if(model.bossId > 0 && !model.isOver())
         {
            _skipHelp.visible = false;
            _bossContent.visible = true;
            _openBtn.visible = false;
            _notOpenBtn.visible = false;
            _battelBtn.visible = true;
            _bossNameBgImage.visible = true;
            _bossLvBg.visible = true;
            _fightCountTime.visible = true;
            _replyTxt.visible = true;
            _replyTimeTxt.visible = true;
            _leftCountTxt.visible = true;
            _sbDesTxt.text = "";
            _sb2DesTxt.text = "";
            _bossWaitTxt.visible = false;
            _bossWait.visible = false;
            _bossIcon.visible = true;
            _bossLvTxt.text = LanguageMgr.GetTranslation("public.level2",model.callLevel);
            _loc1_ = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(model.bossId);
            if(_loc1_)
            {
               _bossNameTxt.text = model.passLevel == 0 && model.hasCallCount == 0 ? LanguageMgr.GetTranslation("consorienewboss.sbname1") : _loc1_.TemplateName;
               _bossIcon.icon = IconFactory.getHeroIconByPics(_loc1_.Icon);
            }
            _bossContent.filters = null;
            _bossHp.showPrecent(model.hp,model.maxHp);
            _leftBattleTimeTxt.text = LanguageMgr.GetTranslation("ConsortiaNewBossFrame.leftBattleTimeTxt");
            if(StringHelper.isNullOrEmpty(getReplayTime()))
            {
               _replyTxt.text = "";
               _replyTimeTxt.text = "";
            }
            else
            {
               _replyTxt.htmlText = LanguageMgr.GetTranslation("ConsortiaNewBossFrame.replyTimeTxt2",getReplayTime());
               _replyTimeTxt.text = LanguageMgr.GetTranslation("ConsortiaNewBossFrame.replyTimeTxt");
            }
            _replyTimeTxt.y = 465;
            _replyTimeTxt.x = 845;
            _leftCountTxt.htmlText = LanguageMgr.GetTranslation("ConsortiaNewBossFrame.leftCountTxt",model.maxFightCount - model.fightCount,model.maxFightCount);
            _leftCountTxt.y = 480;
            _fightCountTime.timeCount = model.stopTime.time / 1000 - currentNumber;
            initDamageAndBUfferTip();
            _isHideSkip = false;
            timerHandler();
         }
         else
         {
            resetData();
         }
         refreshVbox();
         refreshHbox();
         if(model.myRank > 100)
         {
            _myRankTxt.text = LanguageMgr.GetTranslation("areslords.RankFrame.str05");
         }
         else
         {
            _myRankTxt.text = model.myRank.toString();
         }
         _myDamageTxt.text = model.myDamage.toString();
      }
      
      private function resetData() : void
      {
         if(consortiaControl.getRightsByIndex(1))
         {
            _leftCountTxt.htmlText = LanguageMgr.GetTranslation("ConsortiaNewBossFrame.leftCountTxt2",model.maxCallCount - model.hasCallCount,model.maxCallCount);
            _leftCountTxt.y = 472;
            _notOpenBtn.visible = false;
            _replyTimeTxt.visible = false;
            _openBtn.visible = true;
            _leftCountTxt.visible = true;
         }
         else
         {
            _replyTimeTxt.text = LanguageMgr.GetTranslation("ConsortiaNewBossFrame.openTxt");
            _replyTimeTxt.y = 475;
            _replyTimeTxt.x = 760;
            _openBtn.visible = false;
            _leftCountTxt.visible = false;
            _notOpenBtn.visible = true;
            _replyTimeTxt.visible = true;
         }
         if(model.callLevel > 0)
         {
            _bossContent.filters = _bossGray;
            _isHideSkip = true;
            _bossNameBgImage.visible = true;
            _bossLvBg.visible = true;
            _bossWaitTxt.visible = false;
            _skipHelp.visible = false;
            _leftBattleTimeTxt.text = LanguageMgr.GetTranslation("multilords.MultilordsBetFrame.str02");
            _bossLvTxt.text = LanguageMgr.GetTranslation("public.level2",model.callLevel);
            initDamageAndBUfferTip();
            _sbDesTxt.text = "";
            _sb2DesTxt.text = "";
            _skipHelp.visible = false;
            if(model.hp > 0)
            {
               _sb2DesTxt.htmlText = LanguageMgr.GetTranslation("consorienewboss.sbdes2");
               _skipHelp.visible = true;
            }
         }
         else
         {
            _isHideSkip = false;
            _bossNameBgImage.visible = false;
            _bossLvBg.visible = false;
            _leftBattleTimeTxt.text = "";
            _bossLvTxt.text = "";
            _sbDesTxt.text = "";
            _sb2DesTxt.text = "";
            if(model.passLevel == 0 && model.fightCount == 0)
            {
               _bossContent.visible = false;
               _bossWait.visible = true;
               _bossWaitTxt.visible = true;
               _bossIcon.visible = false;
            }
            else
            {
               _bossContent.visible = true;
               _bossWait.visible = false;
               _bossWaitTxt.visible = false;
               _bossIcon.visible = true;
            }
         }
         var _loc1_:ConsortiaNewBossTemplate = TempleteManager.instance.consortiaNewBossTempCate.getTemplateByLevel(model.callLevel);
         if(!_loc1_)
         {
            _loc1_ = TempleteManager.instance.consortiaNewBossTempCate.getTemplateByLevel(1);
         }
         var _loc2_:int = int(_loc1_.BossId.split(",")[0]);
         var _loc3_:GameHeroTempInfo = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc2_);
         if(_loc3_)
         {
            _bossNameTxt.text = model.passLevel == 0 && model.hasCallCount == 0 ? LanguageMgr.GetTranslation("consorienewboss.sbname1") : _loc3_.TemplateName;
            _bossIcon.icon = IconFactory.getHeroIconByPics(_loc3_.Icon);
         }
         _bossHp.showPrecent(model.hp,model.maxHp);
         _battelBtn.visible = false;
         _fightCountTime.visible = false;
         _replyTxt.visible = false;
      }
      
      private function initDamageAndBUfferTip() : void
      {
         var _loc2_:Object = {};
         var _loc4_:Object = {};
         var _loc3_:Array = TempleteManager.instance.consortiaNewBossDamageRewardTempCate.getTemplatesByTypeAndRank(model.callLevel,model.myDamage);
         if(_loc3_.length == 0)
         {
            _damageRewardImg.tipStyle = "yishi.view.tips.OneLineTip";
            _damageRewardImg.tipData = LanguageMgr.GetTranslation("consortianewboss.ConsortiaNewBossFrame.damageTips");
         }
         else
         {
            _damageRewardImg.tipStyle = "yishi.view.tips.ConsortiaNewBossDamageRewardTip";
            _loc2_.damageReward = _loc3_;
            _loc2_.damage = model.myDamage;
            _damageRewardImg.tipData = _loc2_;
         }
         var _loc1_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(model.bufferId);
         if(_loc1_)
         {
            _bufferImg.tipStyle = "yishi.view.tips.ConsortiaNewBossBufferTip";
            _loc4_.bufferName = _loc1_.TemplateName;
            _loc4_.bufferDesc = _loc1_.Description;
            _loc4_.leftTime = model.bufferStopTime.time / 1000;
            _loc4_.needCount = true;
            _bufferImg.tipData = _loc4_;
         }
         else
         {
            _bufferImg.tipStyle = "yishi.view.tips.OneLineTip";
            _bufferImg.tipData = LanguageMgr.GetTranslation("consortianewboss.ConsortiaNewBossFrame.bufferTips");
         }
      }
      
      private function _timeCompleteHandler(param1:Event) : void
      {
         resetData();
      }
      
      private function get currentNumber() : Number
      {
         return PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
      }
      
      private function getReplayTime() : String
      {
         var _loc6_:int = 0;
         var _loc13_:int = 0;
         var _loc5_:int = 0;
         var _loc11_:int = 0;
         var _loc1_:int = 0;
         var _loc10_:int = 0;
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc14_:int = 0;
         var _loc7_:int = 0;
         var _loc15_:Array = ConfigInfoManager.instance.getConsortiaNewBossRefreshTime();
         var _loc8_:int = int(PlayerManager.instance.currentPlayerModel.sysCurtime.hours);
         var _loc9_:int = int(PlayerManager.instance.currentPlayerModel.sysCurtime.minutes);
         var _loc12_:int = int(PlayerManager.instance.currentPlayerModel.sysCurtime.seconds);
         if(_loc15_)
         {
            _loc14_ = int(_loc15_.length);
            _loc7_ = 0;
            while(_loc7_ < _loc14_)
            {
               _loc2_ = _loc15_[_loc7_];
               _loc11_ = int(_loc2_.split(":")[0]);
               _loc1_ = int(_loc2_.split(":")[1]);
               _loc10_ = int(_loc2_.split(":")[2]);
               if(_loc7_ + 1 < _loc14_)
               {
                  _loc3_ = _loc15_[_loc7_ + 1];
                  _loc6_ = int(_loc3_.split(":")[0]);
                  _loc13_ = int(_loc3_.split(":")[1]);
                  _loc5_ = int(_loc3_.split(":")[2]);
               }
               else
               {
                  _loc3_ = _loc2_;
                  _loc6_ = _loc11_;
                  _loc13_ = _loc1_;
                  _loc5_ = _loc10_;
               }
               if(_loc8_ < _loc11_)
               {
                  _loc4_ = _loc2_;
               }
               else if(_loc8_ == _loc11_)
               {
                  if(_loc9_ < _loc1_)
                  {
                     _loc4_ = _loc2_;
                  }
                  else if(_loc9_ == _loc1_)
                  {
                     if(_loc12_ < _loc10_)
                     {
                        _loc4_ = _loc2_;
                     }
                  }
               }
               else if(_loc8_ > _loc11_)
               {
                  if(_loc8_ > _loc6_)
                  {
                     _loc4_ = "";
                  }
                  else if(_loc8_ == _loc6_)
                  {
                     if(_loc9_ > _loc13_)
                     {
                        _loc4_ = "";
                     }
                     else if(_loc9_ == _loc13_)
                     {
                        if(_loc12_ > _loc5_)
                        {
                           _loc4_ = "";
                        }
                        else
                        {
                           _loc4_ = _loc3_;
                        }
                     }
                  }
                  else if(_loc8_ < _loc6_)
                  {
                     _loc4_ = _loc3_;
                  }
               }
               if(!StringHelper.isNullOrEmpty(_loc4_))
               {
                  break;
               }
               _loc7_++;
            }
         }
         return _loc4_;
      }
      
      private function refreshVbox() : void
      {
         var _loc1_:ConsortiaNewBossRankItem = null;
         var _loc3_:int = 0;
         _vbox.removeAllChild();
         var _loc2_:Array = model.rankArray;
         if(!_loc2_ || _loc2_.length == 0)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = new ConsortiaNewBossRankItem();
            _loc1_.data = _loc2_[_loc3_] as ConsortiaNewBossRankInfo;
            _vbox.addChild(_loc1_);
            _loc3_++;
         }
         _scrollPanel.beginChanges();
         _scrollPanel.setView(_vbox);
         _scrollPanel.commitChanges();
         _scrollPanel.invalidateViewport();
      }
      
      private function refreshHbox() : void
      {
         var _loc2_:BaseItemView = null;
         var _loc4_:ConsortiaNewBossRankRewardTemplateInfo = null;
         var _loc7_:GoodsInfo = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         _successRewardHbox.removeAllChild();
         _failRewardHbox.removeAllChild();
         if(model.callLevel > 0)
         {
            _loc3_ = int(model.callLevel);
         }
         else
         {
            _loc3_ = 1;
         }
         var _loc5_:Array = TempleteManager.instance.consortiaNewBossRankRewardTempCate.getTemplatesByTypeAndRank(_loc3_,1);
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("consortianewboss.ItemBaseItemView");
            _loc4_ = _loc5_[_loc6_];
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = _loc4_.itemId;
            _loc7_.count = _loc4_.count;
            _loc2_.data = _loc7_;
            _successRewardHbox.addChild(_loc2_);
            _loc6_++;
         }
         var _loc1_:Array = TempleteManager.instance.consortiaNewBossRankRewardTempCate.getTemplatesByTypeAndRank(_loc3_,2);
         _loc6_ = 0;
         while(_loc6_ < _loc1_.length)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("consortianewboss.ItemBaseItemView");
            _loc4_ = _loc1_[_loc6_];
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = _loc4_.itemId;
            _loc7_.count = _loc4_.count;
            _loc2_.data = _loc7_;
            _failRewardHbox.addChild(_loc2_);
            _loc6_++;
         }
      }
      
      private function get consortiaControl() : ConsortiaControler
      {
         return FrameControllerManager.instance.consortiaController;
      }
      
      private function get model() : ConsortiaNewBossModel
      {
         return ConsortiaNewBossManager.instance.model;
      }
      
      private function __bossInfoUpdate(param1:Event) : void
      {
         refreshView();
      }
      
      private function __bossRankInfoUpdate(param1:Event) : void
      {
         refreshView();
      }
      
      private function __bossUserInfoUpdate(param1:Event) : void
      {
         refreshView();
      }
      
      private function __clearBufferTipsHandler(param1:Event) : void
      {
         if(model.bufferId <= 0)
         {
            _bufferImg.tipStyle = "yishi.view.tips.OneLineTip";
            _bufferImg.tipData = LanguageMgr.GetTranslation("consortianewboss.ConsortiaNewBossFrame.bufferTips");
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __openBtnHandler(param1:MouseEvent) : void
      {
         if(!checkHasConsortiaInfo())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("chat.view.ChatView.consortianewboss.command"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("consortianewboss",2);
      }
      
      private function __battleBtnHandler(param1:MouseEvent) : void
      {
         if(!checkHasConsortiaInfo())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("chat.view.ChatView.consortianewboss.command"));
            return;
         }
         ConsortiaNewBossManager.instance.fightBOSS();
      }
      
      private function checkHasConsortiaInfo() : Boolean
      {
         if(playerInfo.consortiaID == 0)
         {
            return false;
         }
         return true;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __bufferShopBtnHandler(param1:MouseEvent) : void
      {
         if(!checkHasConsortiaInfo())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("chat.view.ChatView.consortianewboss.command"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("shop",99999);
      }
      
      private function __bossShopBtnHandler(param1:MouseEvent) : void
      {
         if(!checkHasConsortiaInfo())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("chat.view.ChatView.consortianewboss.command"));
            return;
         }
         if(consortiaInfo.shopLevel > 0)
         {
            if(VersionSwitch.CROSS_GUILD)
            {
               FrameControllerManager.instance.openControllerByInfo("shop",2,{"type":5});
            }
            else
            {
               FrameControllerManager.instance.openControllerByInfo("shop",2,{"type":4});
            }
         }
         else if(VersionSwitch.CROSS_GUILD)
         {
            FrameControllerManager.instance.openControllerByInfo("shop",2,{"type":1});
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("shop",2,{"type":0});
         }
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return ConsortiaManager.instance.model.consortiaInfo;
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("consortianewboss.HelpFrame");
         _loc2_.show();
      }
      
      private function __skiphelpBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("consortianewboss",3);
      }
      
      public function show(param1:Object = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         if(_timer)
         {
            _timer.stop();
         }
         removeEvent();
         ConsortiaNewBossManager.instance.closeFrame();
         ObjectUtils.disposeObject(_titleImage);
         _titleImage = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_leftRibbonImage);
         _leftRibbonImage = null;
         ObjectUtils.disposeObject(_rightRibbonImage);
         _rightRibbonImage = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_successTxt);
         _successTxt = null;
         ObjectUtils.disposeObject(_failTxt);
         _failTxt = null;
         ObjectUtils.disposeObject(_openBtn);
         _openBtn = null;
         ObjectUtils.disposeObject(_battelBtn);
         _battelBtn = null;
         ObjectUtils.disposeObject(_replyTimeTxt);
         _replyTimeTxt = null;
         ObjectUtils.disposeObject(_leftCountTxt);
         _leftCountTxt = null;
         ObjectUtils.disposeObject(_bossNameTxt);
         _bossNameTxt = null;
         ObjectUtils.disposeObject(_bossIcon);
         _bossIcon = null;
         ObjectUtils.disposeObject(_bossLvTxt);
         _bossLvTxt = null;
         ObjectUtils.disposeObject(_leftBattleTimeTxt);
         _leftBattleTimeTxt = null;
         ObjectUtils.disposeObject(_damageRewardImg);
         _damageRewardImg = null;
         ObjectUtils.disposeObject(_bufferImg);
         _bufferImg = null;
         ObjectUtils.disposeObject(_bufferShopBtn);
         _bufferShopBtn = null;
         ObjectUtils.disposeObject(_bossShopBtn);
         _bossShopBtn = null;
         ObjectUtils.disposeObject(_successRewardHbox);
         _successRewardHbox = null;
         ObjectUtils.disposeObject(_failRewardHbox);
         _failRewardHbox = null;
         ObjectUtils.disposeObject(_bossLeftTimeBg);
         _bossLeftTimeBg = null;
         ObjectUtils.disposeObject(_bossLvBg);
         _bossLvBg = null;
         ObjectUtils.disposeObject(_leftCountImg);
         _leftCountImg = null;
         ObjectUtils.disposeObject(_fightCountTime);
         _fightCountTime = null;
         ObjectUtils.disposeObject(_notOpenBtn);
         _notOpenBtn = null;
         ObjectUtils.disposeObject(_skipHelp);
         _skipHelp = null;
         ObjectUtils.disposeObject(_skipDesTxt);
         _skipDesTxt = null;
         ObjectUtils.disposeObject(_sbDesTxt);
         _sbDesTxt = null;
         ObjectUtils.disposeObject(_sb2DesTxt);
         _sb2DesTxt = null;
         ObjectUtils.disposeObject(_bossIconBox);
         _bossIconBox = null;
         ObjectUtils.disposeObject(_bossHp);
         _bossHp = null;
         super.dispose();
         FrameControllerManager.instance.openControllerByInfo("consortia",3,5);
         _willDate = null;
         _timer = null;
         _bossGray = null;
      }
   }
}

