package stokesore
{
   import bottle.BottleNotic;
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.active.OreItemInfoMsg;
   import com.road.yishi.proto.active.OreRewardTempMsg;
   import events.StokesOreEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.StokesOreManager;
   import mvc.module.stokesore.StokesOreModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class StokesOreFrame extends Frame
   {
      
      private var _bg:MovieClip;
      
      private var _rewardsListScroll:ScrollPanel;
      
      private var _goodsListScroll:ScrollPanel;
      
      private var _luckShowListScroll:ScrollPanel;
      
      private var _rewardsVBox:VBox;
      
      private var _luckShowVBox:VBox;
      
      private var _openBtn1:IconButton;
      
      private var _openBtn2:IconButton;
      
      private var _openBtn1Txt:FilterFrameText;
      
      private var _openBtn2Txt:FilterFrameText;
      
      private var _nextOpenLeftTimeTxt:FilterFrameText;
      
      private var _todayLeftNumberBmp:BitmapData;
      
      private var _todayLeftNumber2Bmp:BitmapData;
      
      private var _leftNumbeSp:Sprite;
      
      private var _leftNumbe2Sp:Sprite;
      
      private var _progressBg:Image;
      
      private var _progressTxtBg:Image;
      
      private var _mask:Shape;
      
      private var _countDownTime:Timer;
      
      private var _topHbox:HBox;
      
      private var _progressTxt:FilterFrameText;
      
      private var _startTxt:FilterFrameText;
      
      private var _endTxt:FilterFrameText;
      
      private var _todayLeft1Image:Image;
      
      private var _todayLeft2Image:Image;
      
      private var _model:StokesOreModel;
      
      private var _treeShakeEnd:Boolean;
      
      private var _serverDataOk:Boolean;
      
      private var _openAnime:MovieClip;
      
      private var _delayId:uint = 0;
      
      private var _number:int;
      
      private var _startFlag:Boolean;
      
      private var _helpBtn:BaseButton;
      
      private var _hasPropTxt:FilterFrameText;
      
      private var _hasPropBg:Bitmap;
      
      private var _hasPropIcon:Image;
      
      private var _usePropImg1:ScaleFrameImage;
      
      private var _usePropImg2:ScaleFrameImage;
      
      private var _checkBtn:SelectedCheckButton;
      
      private var _checkTxt:FilterFrameText;
      
      private const PROP_ID:int = 208523;
      
      public function StokesOreFrame()
      {
         super();
         _model = StokesOreManager.instance.model;
         initView();
         initEvent();
         initData();
         StokesOreManager.instance.sendClientOperation(3);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatCustomObject("stokesOreFrame.bg");
         _nextOpenLeftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.nextOpenLeftTimeTxt");
         _rewardsListScroll = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.rewardsListScroll");
         _goodsListScroll = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.goodsListScroll");
         _luckShowListScroll = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.luckShowListScroll");
         _openBtn1 = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.openIconBtn1");
         _openBtn2 = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.openIconBtn2");
         _openBtn1Txt = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.openIconBtn1Txt");
         _openBtn2Txt = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.openIconBtn2Txt");
         _rewardsVBox = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.rewardsVBox");
         _luckShowVBox = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.luckShowVBox");
         _todayLeftNumberBmp = ComponentFactory.Instance.creatBitmapData("asset.stokesOreFrame.todayLeftNumberBmp");
         _todayLeftNumber2Bmp = ComponentFactory.Instance.creatBitmapData("asset.stokesOreFrame.todayLeftNumber2Bmp");
         _progressBg = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.progressBg");
         _progressTxtBg = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.progressTxtBg");
         _topHbox = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.topHbox");
         _openAnime = ComponentFactory.Instance.creat("asset.stokesOreFrame.openAnime");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.progressTxt");
         _startTxt = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.startTxt");
         _endTxt = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.endTxt");
         _todayLeft1Image = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.todayLeft1Image");
         _todayLeft2Image = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.todayLeft2Image");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.helpBtn");
         _leftNumbeSp = new Sprite();
         _leftNumbeSp.x = 425;
         _leftNumbeSp.y = 122;
         _leftNumbe2Sp = new Sprite();
         _leftNumbe2Sp.x = 550;
         _leftNumbe2Sp.y = 377;
         _hasPropTxt = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.hasPropTxt");
         _hasPropBg = ComponentFactory.Instance.creatBitmap("asset.stokesOreFrame.propBg");
         _hasPropIcon = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.hasPropIcon");
         _usePropImg1 = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.usePropImg1");
         _usePropImg2 = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.usePropImg2");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.checkBtn");
         _checkTxt = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.checkTxt");
         addToContent(_bg);
         addToContent(_nextOpenLeftTimeTxt);
         addToContent(_progressBg);
         addToContent(_progressTxtBg);
         addToContent(_rewardsListScroll);
         addToContent(_goodsListScroll);
         addToContent(_luckShowListScroll);
         addToContent(_openBtn1);
         addToContent(_openBtn2);
         addToContent(_openBtn1Txt);
         addToContent(_openBtn2Txt);
         addToContent(_topHbox);
         addToContent(_leftNumbeSp);
         addToContent(_leftNumbe2Sp);
         addToContent(_progressTxt);
         addToContent(_openAnime);
         addToContent(_startTxt);
         addToContent(_endTxt);
         addToContent(_todayLeft1Image);
         addToContent(_todayLeft2Image);
         addToContent(_helpBtn);
         addToContent(_hasPropBg);
         addToContent(_hasPropIcon);
         addToContent(_hasPropTxt);
         addToContent(_usePropImg1);
         addToContent(_usePropImg2);
         addToContent(_checkBtn);
         addToContent(_checkTxt);
         refreshPropIcons();
         refreshPropNums();
         _rewardsListScroll.setView(_rewardsVBox);
         _luckShowListScroll.setView(_luckShowVBox);
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208523);
         var _loc1_:String = _loc2_ ? _loc2_.TemplateName : "";
         _checkTxt.text = LanguageMgr.GetTranslation("wishpool.checkBtnTip",_loc1_);
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = 208523;
         _hasPropIcon.tipData = _loc3_;
         _mask = new Shape();
         _mask.graphics.beginFill(16777215,0);
         _mask.graphics.drawRect(0,0,_progressTxtBg.width,_progressTxtBg.height);
         _mask.graphics.endFill();
         _mask.x = _progressTxtBg.x - _progressTxtBg.width;
         _mask.y = 161;
         _progressTxtBg.mask = _mask;
         addToContent(_mask);
         _openAnime.x = 480;
         _openAnime.y = 355;
         _openAnime.visible = false;
         _openAnime.gotoAndStop(1);
         _countDownTime = new Timer(1000);
         _countDownTime.addEventListener("timer",__onTimer);
         _countDownTime.start();
      }
      
      private function uninitView() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_nextOpenLeftTimeTxt)
         {
            ObjectUtils.disposeObject(_nextOpenLeftTimeTxt);
         }
         _nextOpenLeftTimeTxt = null;
         if(_rewardsListScroll)
         {
            ObjectUtils.disposeObject(_rewardsListScroll);
         }
         _rewardsListScroll = null;
         if(_goodsListScroll)
         {
            ObjectUtils.disposeObject(_goodsListScroll);
         }
         _goodsListScroll = null;
         if(_luckShowListScroll)
         {
            ObjectUtils.disposeObject(_luckShowListScroll);
         }
         _luckShowListScroll = null;
         if(_rewardsVBox)
         {
            ObjectUtils.disposeObject(_rewardsVBox);
         }
         _rewardsVBox = null;
         if(_luckShowVBox)
         {
            ObjectUtils.disposeObject(_luckShowVBox);
         }
         _luckShowVBox = null;
         if(_todayLeftNumberBmp)
         {
            ObjectUtils.disposeObject(_todayLeftNumberBmp);
         }
         _todayLeftNumberBmp = null;
         if(_todayLeftNumber2Bmp)
         {
            ObjectUtils.disposeObject(_todayLeftNumber2Bmp);
         }
         _todayLeftNumber2Bmp = null;
         if(_openBtn1)
         {
            ObjectUtils.disposeObject(_openBtn1);
         }
         _openBtn1 = null;
         if(_openBtn2)
         {
            ObjectUtils.disposeObject(_openBtn2);
         }
         _openBtn2 = null;
         if(_openBtn1)
         {
            ObjectUtils.disposeObject(_progressBg);
         }
         _progressBg = null;
         if(_openBtn2)
         {
            ObjectUtils.disposeObject(_progressTxtBg);
         }
         _progressTxtBg = null;
         if(_topHbox)
         {
            ObjectUtils.disposeObject(_topHbox);
         }
         _topHbox = null;
         if(_leftNumbeSp)
         {
            ObjectUtils.disposeObject(_leftNumbeSp);
         }
         _leftNumbeSp = null;
         if(_leftNumbe2Sp)
         {
            ObjectUtils.disposeObject(_leftNumbe2Sp);
         }
         _leftNumbe2Sp = null;
         if(_openAnime)
         {
            ObjectUtils.disposeViolentMc(_openAnime);
         }
         _openAnime = null;
         if(_progressTxt)
         {
            ObjectUtils.disposeObject(_progressTxt);
         }
         _progressTxt = null;
         if(_startTxt)
         {
            ObjectUtils.disposeObject(_startTxt);
         }
         _startTxt = null;
         if(_endTxt)
         {
            ObjectUtils.disposeObject(_endTxt);
         }
         _endTxt = null;
         if(_todayLeft1Image)
         {
            ObjectUtils.disposeObject(_todayLeft1Image);
         }
         _todayLeft1Image = null;
         if(_todayLeft2Image)
         {
            ObjectUtils.disposeObject(_todayLeft2Image);
         }
         _todayLeft2Image = null;
         if(_mask)
         {
            ObjectUtils.disposeObject(_mask);
         }
         _mask = null;
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
         }
         _helpBtn = null;
         ObjectUtils.disposeObject(_openBtn1Txt);
         _openBtn1Txt = null;
         ObjectUtils.disposeObject(_openBtn2Txt);
         _openBtn2Txt = null;
         ObjectUtils.disposeObject(_hasPropTxt);
         _hasPropTxt = null;
         ObjectUtils.disposeObject(_hasPropBg);
         _hasPropBg = null;
         ObjectUtils.disposeObject(_hasPropIcon);
         _hasPropIcon = null;
         ObjectUtils.disposeObject(_usePropImg1);
         _usePropImg1 = null;
         ObjectUtils.disposeObject(_usePropImg2);
         _usePropImg2 = null;
         ObjectUtils.disposeObject(_checkBtn);
         _checkBtn = null;
         ObjectUtils.disposeObject(_checkTxt);
         _checkTxt = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_openBtn1)
         {
            _openBtn1.addEventListener("click",__openBtn1Handler);
         }
         if(_openBtn2)
         {
            _openBtn2.addEventListener("click",__openBtn2Handler);
         }
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__helpBtnHandler);
         }
         if(_model)
         {
            _model.addEventListener("START_NEXT_ORE",__resetProgresssHandler);
         }
         if(_model)
         {
            _model.addEventListener("UPDATE_REWARDS_INFO",__updateRewardsHandler);
         }
         if(_model)
         {
            _model.addEventListener("UPDATE_LUCK_SHOW_INFO",__updateLuckShowHandler);
         }
         if(_model)
         {
            _model.addEventListener("UPDATE_CROSSINFO",__updateCrossInfoHandler);
         }
         if(_model)
         {
            _model.addEventListener("UPDATE_STATUS",__updateActivityInfoHandler);
         }
         if(_checkBtn)
         {
            _checkBtn.addEventListener("select",_checkBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_openBtn1)
         {
            _openBtn1.removeEventListener("click",__openBtn1Handler);
         }
         if(_openBtn2)
         {
            _openBtn2.removeEventListener("click",__openBtn2Handler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
         if(_model)
         {
            _model.removeEventListener("START_NEXT_ORE",__resetProgresssHandler);
         }
         if(_model)
         {
            _model.removeEventListener("UPDATE_REWARDS_INFO",__updateRewardsHandler);
         }
         if(_model)
         {
            _model.removeEventListener("UPDATE_LUCK_SHOW_INFO",__updateLuckShowHandler);
         }
         if(_model)
         {
            _model.removeEventListener("UPDATE_CROSSINFO",__updateCrossInfoHandler);
         }
         if(_model)
         {
            _model.removeEventListener("UPDATE_STATUS",__updateActivityInfoHandler);
         }
         if(_checkBtn)
         {
            _checkBtn.removeEventListener("select",_checkBtnHandler);
         }
         _countDownTime.stop();
         _countDownTime.removeEventListener("timer",__onTimer);
         _countDownTime = null;
      }
      
      private function _checkBtnHandler(param1:Event) : void
      {
         refreshPropIcons();
      }
      
      private function refreshPropIcons() : void
      {
         var _loc1_:int = 1;
         _usePropImg1.setFrame(_loc1_);
         _usePropImg2.setFrame(_loc1_);
         _openBtn1Txt.setFrame(_loc1_);
         _openBtn2Txt.setFrame(_loc1_);
         if(_loc1_ == 1)
         {
            _openBtn1Txt.text = String(_model.oneOpenCost);
            _openBtn2Txt.text = String(_model.tenOpenCost);
         }
         else
         {
            _openBtn1Txt.text = "1";
            _openBtn2Txt.text = "10";
         }
      }
      
      private function refreshPropNums() : void
      {
         var _loc1_:int = int(GoodsManager.instance.getGoodsNumByTempId(208523));
         _hasPropTxt.text = "" + _loc1_;
      }
      
      private function initData() : void
      {
         initTopItem();
         initShowGoods();
         if(_model.oreRewardsInfo)
         {
            __updateRewardsHandler(null);
         }
      }
      
      private function initTopItem() : void
      {
         var _loc3_:Array = null;
         var _loc2_:int = 0;
         var _loc1_:StokesOreTopItem = null;
         var _loc4_:int = 0;
         if(_topHbox)
         {
            _topHbox.removeAllChild();
         }
         if(_model.layerArray)
         {
            _loc3_ = _model.layerArray;
            _loc2_ = int(_loc3_.length);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc1_ = new StokesOreTopItem();
               _loc1_.tipStyle = "yishi.view.tips.StokesOreGoodsShowTip";
               _loc1_.tipDirctions = "7,7,5,4,6";
               _loc1_.isFollowMouse = false;
               _loc1_.tipGapV = 180;
               _loc1_.tipGapH = 0;
               _loc1_.index = _loc4_ + 1;
               _loc1_.layer = _loc3_[_loc4_];
               _topHbox.addChild(_loc1_);
               _loc4_++;
            }
         }
         NumberViewUtils.refreshValue(_model.todayLeftNumber,_leftNumbeSp,_todayLeftNumberBmp,17,18,10,17,"0123456789");
         NumberViewUtils.refreshValue(_model.todayLeftNumber,_leftNumbe2Sp,_todayLeftNumber2Bmp,15,20,14,15,"0123456789");
         _startTxt.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData") + DateFormatter.format(_model.startDate,"YYYY-MM-DD hh:mm:ss");
         _endTxt.text = LanguageMgr.GetTranslation("MonthCardGiftItem.overActive.text") + DateFormatter.format(_model.endDate,"YYYY-MM-DD hh:mm:ss");
      }
      
      private function initShowGoods() : void
      {
         var _loc9_:GoodsInfo = null;
         var _loc2_:StokesOreDropItem = null;
         var _loc4_:Bitmap = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Array = [];
         if(!_model.goodsDic)
         {
            return;
         }
         var _loc1_:OreRewardTempMsg = _model.goodsDic[0];
         if(!_loc1_)
         {
            return;
         }
         for each(var _loc7_:OreItemInfoMsg in _loc1_.rewards)
         {
            _loc9_ = new GoodsInfo();
            _loc9_.templateId = _loc7_.templateId;
            _loc9_.count = _loc7_.count;
            _loc3_.push(_loc9_);
         }
         var _loc10_:Sprite = new Sprite();
         var _loc5_:int = 5;
         _loc8_ = Math.ceil(_loc3_.length / _loc5_);
         _loc3_.sort(sortFun);
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc2_ = new StokesOreDropItem();
            _loc2_.x = 2 + _loc6_ % _loc5_ * _loc2_.displayWidth;
            _loc2_.y = int(_loc6_ / _loc5_) * _loc2_.displayHeight;
            _loc2_.data = _loc3_[_loc6_];
            _loc10_.addChild(_loc2_);
            if(_loc6_ % _loc5_ == 0 && _loc6_ != _loc3_.length - 1)
            {
               _loc4_ = ComponentFactory.Instance.creatBitmap("asset.stokesOreCenterView.DropFrameLine");
               _loc4_.y = _loc2_.y + _loc2_.displayHeight - _loc4_.height;
               _loc10_.addChild(_loc4_);
            }
            _loc6_++;
         }
         if(_loc8_ > 0)
         {
            _loc10_.scrollRect = new Rectangle(0,0,200,_loc8_ * _loc2_.displayHeight);
         }
         _goodsListScroll.setView(_loc10_);
      }
      
      private function sortFun(param1:GoodsInfo, param2:GoodsInfo) : Number
      {
         var _loc3_:int = int(param1.templateInfo.SonType);
         var _loc4_:int = int(param2.templateInfo.SonType);
         if(param1.templateInfo.Profile > param2.templateInfo.Profile)
         {
            return -1;
         }
         if(param1.templateInfo.Profile < param2.templateInfo.Profile)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(param1.templateId < param2.templateId)
         {
            return 1;
         }
         if(param1.templateId > param2.templateId)
         {
            return -1;
         }
         return 0;
      }
      
      private function __resetProgresssHandler(param1:StokesOreEvent) : void
      {
         _mask.x = _progressTxtBg.x - _progressTxtBg.width;
         _progressTxt.text = "0 / " + _model.layerArray[4];
         _nextOpenLeftTimeTxt.text = "";
         _openBtn1.enable = _openBtn2.enable = true;
         _startFlag = false;
      }
      
      private function __updateRewardsHandler(param1:StokesOreEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:BottleNotic = null;
         var _loc2_:ChatData = null;
         refreshPropNums();
         _rewardsVBox.removeAllChild();
         _rewardsVBox.disposeAllChildren();
         _rewardsVBox.beginChanges();
         _delayId = 0;
         _serverDataOk = true;
         resetView();
         if(_model.oreRewardsInfo)
         {
            _loc3_ = 0;
            while(_loc3_ < _model.oreRewardsInfo.length)
            {
               _loc4_ = new BottleNotic();
               _loc2_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc2_.channel = 110;
               _loc2_.msg = _model.oreRewardsInfo[_loc3_];
               _loc2_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc2_);
               _loc4_.lineWidth = 200;
               _loc4_.data = _loc2_;
               _rewardsVBox.addChild(_loc4_);
               _loc3_++;
            }
         }
         _rewardsVBox.commitChanges();
         _rewardsListScroll.invalidateViewport(true);
      }
      
      private function __updateLuckShowHandler(param1:StokesOreEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:BottleNotic = null;
         var _loc2_:ChatData = null;
         _luckShowVBox.removeAllChild();
         _luckShowVBox.disposeAllChildren();
         _luckShowVBox.beginChanges();
         if(_model.oreLuckShowInfo)
         {
            _loc3_ = 0;
            while(_loc3_ < _model.oreLuckShowInfo.length)
            {
               _loc4_ = new BottleNotic();
               _loc2_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc2_.channel = 110;
               _loc2_.msg = _model.oreLuckShowInfo[_loc3_];
               _loc2_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc2_);
               _loc4_.lineWidth = 690;
               _loc4_.data = _loc2_;
               _luckShowVBox.addChild(_loc4_);
               _loc3_++;
            }
         }
         _luckShowVBox.commitChanges();
         _luckShowListScroll.invalidateViewport(true);
      }
      
      private function __updateCrossInfoHandler(param1:StokesOreEvent) : void
      {
         if(_model.todayLeftNumber >= 100)
         {
            _leftNumbeSp.x = 395;
         }
         else if(_model.todayLeftNumber >= 10)
         {
            _leftNumbeSp.x = 405;
         }
         else
         {
            _leftNumbeSp.x = 410;
         }
         NumberViewUtils.refreshValue(_model.todayLeftNumber,_leftNumbeSp,_todayLeftNumberBmp,17,18,10,17,"0123456789");
         NumberViewUtils.refreshValue(_model.todayLeftNumber2,_leftNumbe2Sp,_todayLeftNumber2Bmp,15,20,14,15,"0123456789");
         var _loc2_:int = int(_model.getLocationX(_model.curSeq));
         _mask.x = _progressTxtBg.x - _progressTxtBg.width + _loc2_;
         var _loc3_:int = int(_model.curSeq > _model.layerArray[4] ? _model.layerArray[4] : _model.curSeq);
         _progressTxt.text = _loc3_ + " / " + _model.layerArray[4];
         if(_model.countDown > 0 && _model.todayLeftNumber > 0)
         {
            _number = _model.countDown;
            _startFlag = true;
            _openBtn1.enable = _openBtn2.enable = false;
         }
         if(_model.todayLeftNumber <= 0)
         {
            _todayLeft1Image.visible = false;
            _leftNumbeSp.visible = false;
            _todayLeft2Image.visible = false;
            _leftNumbe2Sp.visible = false;
            _mask.x = 151;
            _progressTxt.text = _model.layerArray[4] + " / " + _model.layerArray[4];
         }
      }
      
      private function __updateActivityInfoHandler(param1:StokesOreEvent) : void
      {
         initData();
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         if(_nextOpenLeftTimeTxt && _number >= 0 && _startFlag)
         {
            _loc2_ = DateFormatter.getCountDateByMS(_number);
            _nextOpenLeftTimeTxt.text = LanguageMgr.GetTranslation("stokesore.stokesOreFrame.nextOpen",_loc2_);
            _number = _number - 1;
         }
      }
      
      private function __openBtn1Handler(param1:MouseEvent) : void
      {
         __openHandler(1);
      }
      
      private function __openBtn2Handler(param1:MouseEvent) : void
      {
         __openHandler(2);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("stokesore.StokesOreFrame.helpFrame");
         _loc2_.show();
      }
      
      private function __openHandler(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         if(PlayerManager.instance.currentPlayerModel.nowDate > StokesOreManager.instance.model.endDate.time)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.ActivityManager.command02"));
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.sysCurtime.hours == 0 && PlayerManager.instance.currentPlayerModel.sysCurtime.minutes <= 5)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("stokesore.stokesOreFrame.nextOpen2"));
            return;
         }
         if(_model.todayLeftNumber <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("stokesore.stokesoreFrame.openTips1"));
            return;
         }
         if(_model.todayLeftNumber2 == 0)
         {
            SimpleAlertHelper.instance.data = [__alertBackHandler,param1];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("stokesore.stokesoreFrame.openTips2");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,false,true);
         }
         else
         {
            sendOpen(param1);
         }
      }
      
      private function __alertBackHandler(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            sendOpen(param3);
         }
      }
      
      private function sendOpen(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         if(param1 == 1)
         {
            _loc2_ = int(_model.oneOpenCost);
            _loc3_ = 1;
         }
         else if(param1 == 2)
         {
            _loc2_ = int(_model.tenOpenCost);
            _loc3_ = 10;
         }
         var _loc5_:Boolean = Boolean(_checkBtn.selected);
         if(_loc5_)
         {
            _loc6_ = int(GoodsManager.instance.getGoodsNumByTempId(208523));
            _loc4_ = _loc3_ - _loc6_;
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            _loc2_ = _model.oneOpenCost * _loc4_;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _loc2_)
         {
            RechargeAlertMannager.show();
            return;
         }
         StokesOreManager.instance.sendClientOperation(param1,_loc5_);
         _openBtn1.enable = _openBtn2.enable = _closeButton.enable = false;
         _treeShakeEnd = false;
         _serverDataOk = false;
         setTimeout(__onTreeShakeEnd,1000);
         _delayId = setTimeout(timeEndFunc,15000);
         _openAnime.visible = true;
         _openAnime.gotoAndPlay(1);
         _openAnime.addFrameScript(29,playEnd);
      }
      
      private function timeEndFunc() : void
      {
         if(_delayId != 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("stokesore.stokesoreFrame.openTips3"));
            dispose();
         }
         _delayId = 0;
      }
      
      private function __onTreeShakeEnd() : void
      {
         _treeShakeEnd = true;
         resetView();
      }
      
      private function resetView() : void
      {
         if(_treeShakeEnd && _serverDataOk)
         {
            _closeButton.enable = true;
         }
         if(_treeShakeEnd && _serverDataOk && _model.countDown == 0)
         {
            _openBtn1.enable = _openBtn2.enable = true;
         }
      }
      
      private function playEnd() : void
      {
         _openAnime.visible = false;
         _openAnime.gotoAndStop(1);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
         }
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         clearTimeout(_delayId);
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

