package lordtrial
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.LordTrialEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import lordtrial.pray.LordTrialPrayFrame;
   import lordtrial.rank.LordTrialRankFrame;
   import mainBar.view.LordTrialHPExpView;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.armyII.UserArmy;
   import mvc.module.lordtrial.LordTrialModel;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.LordTrialManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.MagicSpringBufferAddView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class LordTrialMainFrame extends Frame
   {
      
      private var _frameBg:Scale9CornerImage;
      
      private var _bg:MutipleImage;
      
      private var _leftBg:ScaleFrameImage;
      
      private var _soulTrialTxt:FilterFrameText;
      
      private var _rankTxt:FilterFrameText;
      
      private var _rankBtn:TextButton;
      
      private var _soulImg:Image;
      
      private var _geteBmp:Bitmap;
      
      private var _geteSprite:Component;
      
      private var _startBtn:IconButton;
      
      private var _alertText:FilterFrameText;
      
      private var _currentType:int;
      
      private var _currentIndex:int;
      
      private var _selfRank:int;
      
      private var _enterBattleMc:MovieClip;
      
      private var _enterBattleMc2:MovieClip;
      
      private var _helpBtn:BaseButton;
      
      private var _bg2:Image;
      
      private var _currentPlayerTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _icon:BaseIconView;
      
      private var _playerHpImg:Image;
      
      private var _hpView:LordTrialHPExpView;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _currentDifficultyImg:Image;
      
      private var _currentImage:ScaleFrameImage;
      
      private var _fallGoodsOldView:LordTrialRightGoodsView;
      
      private var _vbox:VBox;
      
      private var _mopupBtn:IconButton;
      
      private var _prayerBtn:IconButton;
      
      private var _restBtn:IconButton;
      
      private var _model:LordTrialModel;
      
      private var _orderArray:Array;
      
      private var _maxIndexArrar:Array;
      
      private var _type:int;
      
      private var _index:int;
      
      private var _bufferView:MagicSpringBufferAddView;
      
      public function LordTrialMainFrame()
      {
         super();
         TempleteManager.instance.lordTrialTempCate.getTemplates();
         _model = LordTrialManager.instance.model;
         initView();
         addEvent();
         __updateViewHandler(null);
         LordTrialManager.openMainFrame();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("lordtrial.LordTrialFrame.titleText");
         _frameBg = ComponentFactory.Instance.creatComponentByStylename("leftView.frameBg");
         _bg = ComponentFactory.Instance.creatComponentByStylename("leftView.bg");
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("leftView.leftBg");
         _enterBattleMc = ComponentFactory.Instance.creatCustomObject("leftView.enterBattleMc");
         _enterBattleMc2 = ComponentFactory.Instance.creatCustomObject("leftView.enterBattleMc2");
         _soulTrialTxt = ComponentFactory.Instance.creatComponentByStylename("leftView.soulTrialTxt");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("leftView.rankTxt");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("leftView.rankBtn");
         _soulImg = ComponentFactory.Instance.creatComponentByStylename("leftView.soulImg");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("leftView.startBtn");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("leftView.alertText");
         _geteBmp = ComponentFactory.Instance.creatBitmap("asset.lordtrial.gateNumAsset");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("rightView.bg");
         _currentPlayerTxt = ComponentFactory.Instance.creatComponentByStylename("rightView.currentPlayerTxt");
         _playerHpImg = ComponentFactory.Instance.creatComponentByStylename("rightView.playerHpImg");
         _hpView = ComponentFactory.Instance.creatCustomObject("rightView.hpView");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("rightView.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("rightView.nextBtn");
         _currentDifficultyImg = ComponentFactory.Instance.creatComponentByStylename("rightView.currentDifficultyImg");
         _currentImage = ComponentFactory.Instance.creatComponentByStylename("rightView.currentImage");
         _fallGoodsOldView = ComponentFactory.Instance.creatCustomObject("rightView.fallGoodsOldView");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("rightView.vbox");
         _mopupBtn = ComponentFactory.Instance.creatComponentByStylename("rightView.mopupBtn");
         _prayerBtn = ComponentFactory.Instance.creatComponentByStylename("rightView.prayerBtn");
         _restBtn = ComponentFactory.Instance.creatComponentByStylename("rightView.restBtn");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("rightView.descTxt");
         _icon = ComponentFactory.Instance.creatCustomObject("rightView.icon");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("rightView.helpBtn");
         _icon.mask = creatShape();
         _geteSprite = new Component();
         _geteSprite.x = 234;
         _geteSprite.y = 34;
         addToContent(_frameBg);
         addToContent(_leftBg);
         addToContent(_enterBattleMc);
         addToContent(_enterBattleMc2);
         addToContent(_bg);
         addToContent(_soulTrialTxt);
         addToContent(_rankTxt);
         addToContent(_rankBtn);
         addToContent(_soulImg);
         addToContent(_geteSprite);
         addToContent(_startBtn);
         addToContent(_alertText);
         addToContent(_bg2);
         addToContent(_currentPlayerTxt);
         addToContent(_descTxt);
         addToContent(_playerHpImg);
         addToContent(_hpView);
         addToContent(_preBtn);
         addToContent(_nextBtn);
         addToContent(_currentDifficultyImg);
         addToContent(_currentImage);
         addToContent(_fallGoodsOldView);
         addToContent(_vbox);
         addToContent(_mopupBtn);
         addToContent(_prayerBtn);
         addToContent(_restBtn);
         addToContent(_icon);
         addToContent(_helpBtn);
         _enterBattleMc.visible = _enterBattleMc2.visible = false;
         _geteSprite.mouseEnabled = _geteSprite.mouseChildren = false;
         _leftBg.mouseEnabled = _leftBg.mouseChildren = true;
         _rankBtn.text = LanguageMgr.GetTranslation("mainBar.SmallMapBar.rankingBtnTipData");
         _currentPlayerTxt.text = LanguageMgr.GetTranslation("lordtrial.lordTrialRightView.currentPlayerTxt");
         _descTxt.text = LanguageMgr.GetTranslation("lordtrial.lordTrialMainFrame.descTxt");
         _alertText.text = LanguageMgr.GetTranslation("lordtrial.lordTrialMainFrame.alertText");
         var _loc1_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(19);
         if(_loc1_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc1_);
            _bufferView.setDescText(_loc1_.tempInfo.Desc);
            _bufferView.x = 270;
            _bufferView.y = 330;
            addToContent(_bufferView);
         }
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_frameBg);
         _frameBg = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_soulTrialTxt);
         _soulTrialTxt = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_soulImg);
         _soulImg = null;
         ObjectUtils.disposeObject(_geteBmp);
         _geteBmp = null;
         ObjectUtils.disposeObject(_geteSprite);
         _geteSprite = null;
         ObjectUtils.disposeViolentMc(_enterBattleMc);
         _enterBattleMc = null;
         ObjectUtils.disposeViolentMc(_enterBattleMc2);
         _enterBattleMc2 = null;
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         ObjectUtils.disposeObject(_currentPlayerTxt);
         _currentPlayerTxt = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_playerHpImg);
         _playerHpImg = null;
         ObjectUtils.disposeObject(_hpView);
         _hpView = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_currentDifficultyImg);
         _currentDifficultyImg = null;
         ObjectUtils.disposeObject(_currentImage);
         _currentImage = null;
         ObjectUtils.disposeObject(_fallGoodsOldView);
         _fallGoodsOldView = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_mopupBtn);
         _mopupBtn = null;
         ObjectUtils.disposeObject(_prayerBtn);
         _prayerBtn = null;
         ObjectUtils.disposeObject(_restBtn);
         _restBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_rankBtn)
         {
            _rankBtn.addEventListener("click",__rankBtnHandler);
         }
         if(_startBtn)
         {
            _startBtn.addEventListener("click",__startBtnHandler);
         }
         if(_mopupBtn)
         {
            _mopupBtn.addEventListener("click",__mopupBtnHandler);
         }
         if(_prayerBtn)
         {
            _prayerBtn.addEventListener("click",__prayerBtnHandler);
         }
         if(_restBtn)
         {
            _restBtn.addEventListener("click",__restBtnHandler);
         }
         if(_preBtn)
         {
            _preBtn.addEventListener("click",__preBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__nextBtnHandler);
         }
         if(_model)
         {
            _model.addEventListener("UPDATE_VIEW",__updateViewHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__onHelperBtnClick);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_rankBtn)
         {
            _rankBtn.removeEventListener("click",__rankBtnHandler);
         }
         if(_startBtn)
         {
            _startBtn.removeEventListener("click",__startBtnHandler);
         }
         if(_mopupBtn)
         {
            _mopupBtn.removeEventListener("click",__mopupBtnHandler);
         }
         if(_prayerBtn)
         {
            _prayerBtn.removeEventListener("click",__prayerBtnHandler);
         }
         if(_restBtn)
         {
            _restBtn.removeEventListener("click",__restBtnHandler);
         }
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__preBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__nextBtnHandler);
         }
         if(_model)
         {
            _model.removeEventListener("UPDATE_VIEW",__updateViewHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__onHelperBtnClick);
         }
      }
      
      private function __onHelperBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("lordtrial.helperFrame");
         _loc2_.show();
      }
      
      private function __updateViewHandler(param1:LordTrialEvent) : void
      {
         refreshIcon();
         _soulTrialTxt.text = playerInfo.lordTrialKeyCount.toString();
         _currentType = playerInfo.currentType;
         _currentIndex = playerInfo.currentIndex;
         _orderArray = playerInfo.order;
         _maxIndexArrar = playerInfo.maxIndex;
         refreshView();
      }
      
      private function refreshView() : void
      {
         _mopupBtn.enable = false;
         _nextBtn.enable = false;
         _preBtn.enable = false;
         _startBtn.visible = true;
         if(playerInfo.currentType == -1)
         {
            _type = _currentType + 1;
            _nextBtn.enable = _type <= 1 ? true : false;
            _preBtn.enable = 1 <= _type ? true : false;
            if(_maxIndexArrar[_type] > 0)
            {
               _mopupBtn.enable = true;
            }
            _index = 1;
            _restBtn.enable = false;
         }
         else
         {
            _restBtn.enable = true;
            _type = _currentType;
            if(_currentIndex <= _maxIndexArrar[_type])
            {
               _mopupBtn.enable = true;
            }
            _index = _currentIndex;
            if(_index > 30)
            {
               _index = 30;
            }
         }
         refreshCommData();
      }
      
      private function refreshCommData() : void
      {
         initBufferInfo();
         initFallGoods(_type,_index);
         NumberViewUtils.getNumberView(_index,_geteSprite,_geteBmp.bitmapData,18,25,18,18,"0123456789",1);
         _currentImage.setFrame(_type + 1);
         if(_index % 5 == 0)
         {
            _leftBg.setFrame(2);
         }
         else
         {
            _leftBg.setFrame(1);
         }
         if(_orderArray)
         {
            if(_orderArray[_type] <= 0 || _orderArray[_type] > 100)
            {
               _rankTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
            }
            else
            {
               _rankTxt.text = _orderArray[_type].toString();
            }
         }
      }
      
      private function initFallGoods(param1:int, param2:int) : void
      {
         var _loc3_:String = TempleteManager.instance.lordTrialTempCate.getItemsByPara1AndPara2(param1,param2);
         _fallGoodsOldView.data = _loc3_;
      }
      
      private function initBufferInfo() : void
      {
         var _loc1_:LordTrialRightVBoxItem = null;
         var _loc3_:Array = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(_vbox)
         {
            _vbox.removeAllChild();
         }
         if(!StringHelper.isNullOrEmpty(skillIdStr))
         {
            _loc3_ = skillIdStr.split(",");
            if(_loc3_)
            {
               _loc2_ = int(_loc3_.length);
            }
            _loc4_ = 1;
            while(_loc4_ < _loc2_ + 1)
            {
               _loc1_ = new LordTrialRightVBoxItem();
               _loc1_.setTypeImg(_loc4_);
               _loc1_.setDesc(getSkillDesc(_loc3_[_loc4_ - 1]));
               _vbox.addChild(_loc1_);
               _loc4_++;
            }
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __mopupBtnHandler(param1:MouseEvent) : void
      {
         if(!_model.isInActivity)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("lordtrial.mainframe.activityNotOpen"));
            return;
         }
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mopup.MopupManager.noMopupAlert"));
            return;
         }
         _model.maxMopupIndex = _maxIndexArrar[_type];
         _model.currentType = _type;
         FrameControllerManager.instance.openControllerByInfo("mopup",9);
      }
      
      private function __prayerBtnHandler(param1:MouseEvent) : void
      {
         if(!_model.isInActivity)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("lordtrial.mainframe.activityNotOpen"));
            return;
         }
         var _loc2_:LordTrialPrayFrame = ComponentFactory.Instance.creatComponentByStylename("lordtrial.LordTrialPrayFrame");
         _loc2_.show();
      }
      
      private function __restBtnHandler(param1:MouseEvent) : void
      {
         if(!_model.isInActivity)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("lordtrial.mainframe.activityNotOpen"));
            return;
         }
         LordTrialManager.reset();
      }
      
      private function __preBtnHandler(param1:MouseEvent) : void
      {
         _currentType = _currentType - 1;
         refreshView();
      }
      
      private function __nextBtnHandler(param1:MouseEvent) : void
      {
         _currentType = _currentType + 1;
         refreshView();
      }
      
      private function __rankBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:LordTrialRankFrame = ComponentFactory.Instance.creatComponentByStylename("lordtrial.LordTrialRankFrame");
         _loc2_.show();
      }
      
      private function __startBtnHandler(param1:MouseEvent) : void
      {
         if(!_model.isInActivity)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("lordtrial.mainframe.activityNotOpen"));
            return;
         }
         if(playerInfo.hpPrecent <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("lordtrial.mainframe.hpIsZero"));
            return;
         }
         if(playerInfo.lordTrialKeyCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("lordtrial.mainframe.enterbattle"));
            return;
         }
         if(playerInfo.currentIndex > 30)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("lordtrial.mainframe.hasClearance"));
            return;
         }
         if(_index % 5 == 0)
         {
            _enterBattleMc.visible = false;
            _enterBattleMc2.visible = true;
            _startBtn.visible = false;
            _enterBattleMc2.play();
            _enterBattleMc2.addFrameScript(_enterBattleMc2.totalFrames - 1,enterBattle);
         }
         else
         {
            _enterBattleMc.visible = true;
            _enterBattleMc2.visible = false;
            _startBtn.visible = false;
            _enterBattleMc.play();
            _enterBattleMc.addFrameScript(_enterBattleMc.totalFrames - 1,enterBattle);
         }
      }
      
      private function enterBattle() : void
      {
         _enterBattleMc.stop();
         _enterBattleMc2.stop();
         LordTrialManager.enterBattle(_type,_currentIndex);
      }
      
      private function refreshIcon() : void
      {
         var _loc1_:String = IconFactory.getPlayerIcon(thane.snsInfo.headId,"head");
         _icon.icon = _loc1_;
         _hpView.data = serialArmy;
      }
      
      private function getSkillDesc(param1:int) : String
      {
         var _loc2_:String = null;
         var _loc3_:SkillTempInfo = TempleteManager.instance.getSkillById(param1);
         if(_loc3_)
         {
            _loc2_ = _loc3_.Description;
         }
         return _loc2_;
      }
      
      private function get skillIdStr() : String
      {
         var _loc2_:String = null;
         var _loc1_:Array = playerInfo.debuffer;
         if(_loc1_ && _loc1_[_type])
         {
            _loc2_ = _loc1_[_type];
         }
         return _loc2_;
      }
      
      private function creatShape() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawCircle(546,46,23);
         _loc1_.graphics.endFill();
         addToContent(_loc1_);
         return _loc1_;
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
      
      private function get serialArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

