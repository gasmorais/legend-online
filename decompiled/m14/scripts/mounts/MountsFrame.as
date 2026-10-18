package mounts
{
   import com.greensock.TimelineLite;
   import com.greensock.TweenMax;
   import com.greensock.core.TweenCore;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ArmyEvent;
   import events.MountsEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import map.space.SpaceManager;
   import map.space.manager.SpaceSocketOutManager;
   import mvc.controler.MountsController;
   import mvc.module.mounts.MountInfo;
   import mvc.module.mounts.MountTrainData;
   import mvc.module.mounts.PropertyInfo;
   import mvc.module.mounts.WildSoulCollection;
   import mvc.module.mounts.WildSoulInfo;
   import yishi.SwitchPageHelp;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.base.StarBar;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.SimpleMovie;
   
   public class MountsFrame extends Frame
   {
      
      private static var selectIndex:int = 0;
      
      private var _bg:Bitmap;
      
      private var _bgBorder:ScaleBitmapImage;
      
      private var _leftBg:Scale9CornerImage;
      
      private var _rightBorder:ScaleBitmapImage;
      
      private var _bottomBg:Bitmap;
      
      private var _mountNameBg:Bitmap;
      
      private var _moveSpeed:Bitmap;
      
      private var _temp:Bitmap;
      
      private var _mountNameTxt:FilterFrameText;
      
      private var _mountGradeTxt:FilterFrameText;
      
      private var _mountNextGradeTxt:FilterFrameText;
      
      private var _mountSpeedTxt:FilterFrameText;
      
      private var _mountGrowValueTxt:FilterFrameText;
      
      private var _wildSoulBtn:IconButton;
      
      private var _trainBtn:SimpleBitmapButton;
      
      private var _dismountBtn:IconButton;
      
      private var _mountBtn:IconButton;
      
      private var _helpBtn:BaseButton;
      
      private var _mountGrowBar:MovieClip;
      
      private var _vBox:VBox;
      
      private var _group:SelectedButtonGroup = new SelectedButtonGroup();
      
      private var _itemArray:Array;
      
      private var _showArea:Component;
      
      private var _mountsAvatar:MountsAvatarView;
      
      private var _mountMovieClip:MovieClip;
      
      private var _propNameArray:Array;
      
      private var _trainData:MountTrainData;
      
      private var _levelupMc:MovieClip;
      
      private var _levelupEffect:MovieClip;
      
      private var _proplevelupEffect:MovieClip;
      
      private var _wildSoilBtnBg:Bitmap;
      
      private var _curNumBg:Bitmap;
      
      private var _curNumLabel:FilterFrameText;
      
      private var _cunNumTxt:FilterFrameText;
      
      private var _discountBack:Bitmap;
      
      private var _discountNum:ScaleFrameImage;
      
      private var _trainCountImage:Image;
      
      private var _trainCountBottom:Image;
      
      private var _trainCountText:FilterFrameText;
      
      private var speedStrip:StripView;
      
      private var _mountShopBtn:SimpleBitmapButton;
      
      private const starCount:int = 5;
      
      private var _promotBtn:BaseButton;
      
      private var _starBox:StarBar;
      
      private var _flashMc:MovieClip;
      
      private var _promotBtnStrip:StripView;
      
      private var _refiningSouleBtn:IconButton;
      
      private var _flyMountBtn:BaseButton;
      
      private var _notFlyMountBtn:BaseButton;
      
      private var _price:int;
      
      private var frameIndex:int;
      
      private var _curGrade:int = -1;
      
      private var _oldGp:int = 0;
      
      private var _tweenCore:TweenCore;
      
      private var _lastClickTime:int = 0;
      
      public function MountsFrame()
      {
         super();
         _trainData = new MountTrainData();
         initView();
         addEvent();
         update();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.mounts.MainBg");
         _bgBorder = ComponentFactory.Instance.creatComponentByStylename("mounts.MainBgBorder");
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("mounts.LeftBg");
         _rightBorder = ComponentFactory.Instance.creatComponentByStylename("mounts.RightBg");
         _bottomBg = ComponentFactory.Instance.creatBitmap("asset.mounts.BottomBg");
         _mountNameBg = ComponentFactory.Instance.creatBitmap("asset.mounts.MountNameBg");
         _moveSpeed = ComponentFactory.Instance.creatBitmap("asset.mounts.MoveSpeed");
         _mountNameTxt = ComponentFactory.Instance.creatComponentByStylename("mounts.MountNameText");
         _mountGradeTxt = ComponentFactory.Instance.creatComponentByStylename("mounts.MountGradeText");
         _mountNextGradeTxt = ComponentFactory.Instance.creatComponentByStylename("mounts.MountGradeText");
         _wildSoulBtn = ComponentFactory.Instance.creatComponentByStylename("mounts.WildSoulBtn");
         _trainBtn = ComponentFactory.Instance.creatComponentByStylename("mounts.DomesticateBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("mounts.helpBtn");
         _mountShopBtn = ComponentFactory.Instance.creatComponentByStylename("mounts.mountShopBtn");
         _wildSoilBtnBg = ComponentFactory.Instance.creatBitmap("asset.mounts.WildSoulBtnBg");
         _curNumBg = ComponentFactory.Instance.creatBitmap("asset.mounts.CurNumBg");
         _curNumLabel = ComponentFactory.Instance.creatComponentByStylename("mounts.curNumLabel");
         _cunNumTxt = ComponentFactory.Instance.creatComponentByStylename("mounts.curNumValue");
         _mountSpeedTxt = ComponentFactory.Instance.creatComponentByStylename("mounts.MountSpeedTxt");
         _mountGrowValueTxt = ComponentFactory.Instance.creatComponentByStylename("mounts.GrowValueTxt");
         _mountGrowBar = ComponentFactory.Instance.creat("asset.mounts.GrowBar");
         _mountGrowBar.x = 152;
         _mountGrowBar.y = 375;
         _dismountBtn = ComponentFactory.Instance.creatComponentByStylename("mount.dismountBtn");
         _mountBtn = ComponentFactory.Instance.creatComponentByStylename("mount.mountBtn");
         _trainCountImage = ComponentFactory.Instance.creatComponentByStylename("mount.trainCountImage");
         _trainCountBottom = ComponentFactory.Instance.creatComponentByStylename("mount.trainCountBottom");
         _trainCountText = ComponentFactory.Instance.creatComponentByStylename("mount.trainCountText");
         speedStrip = ComponentFactory.Instance.creatComponentByStylename("mount.speedStrip");
         _refiningSouleBtn = ComponentFactory.Instance.creatComponentByStylename("mount.refiningSouleBtn");
         _levelupMc = ComponentFactory.Instance.creat("mounts.Levelupmc");
         _levelupMc["pre_txt"].addChild(_mountGradeTxt);
         _levelupMc["next_txt"].addChild(_mountNextGradeTxt);
         _levelupMc.gotoAndStop(1);
         _vBox = ComponentFactory.Instance.creatComponentByStylename("mounts.Vbox");
         _vBox.beginChanges();
         _propNameArray = LanguageMgr.GetTranslation("mounts.command02").split(",");
         _itemArray = [ComponentFactory.Instance.creatCustomObject("mounts.PropertyItem",["Strength"]),ComponentFactory.Instance.creatCustomObject("mounts.PropertyItem",["Intellect"]),ComponentFactory.Instance.creatCustomObject("mounts.PropertyItem",["Stamina"]),ComponentFactory.Instance.creatCustomObject("mounts.PropertyItem",["Armor"])];
         for each(var _loc1_:PropertyItem in _itemArray)
         {
            _loc1_.data = mountInfo;
            _group.addSelectItem(_loc1_);
            _vBox.addChild(_loc1_);
         }
         _group.selectIndex = selectIndex;
         _vBox.commitChanges();
         _flyMountBtn = ComponentFactory.Instance.creatComponentByStylename("mount.flyMountBtn");
         _notFlyMountBtn = ComponentFactory.Instance.creatComponentByStylename("mount.notFlyMountBtn");
         addToContent(_bg);
         addToContent(_bgBorder);
         addToContent(_leftBg);
         addToContent(_rightBorder);
         addToContent(_bottomBg);
         _showArea = new Component();
         _mountsAvatar = new MountsAvatarView();
         _mountsAvatar.x = 155;
         _mountsAvatar.y = 235;
         _temp = ComponentFactory.Instance.creatBitmap("asset.mounts.MountBg");
         _showArea.addChild(_temp);
         _showArea.addChild(_mountsAvatar);
         _showArea.addChild(_flyMountBtn);
         _showArea.addChild(_notFlyMountBtn);
         addToContent(_showArea);
         addToContent(_mountNameBg);
         addToContent(_mountNameTxt);
         addToContent(_wildSoilBtnBg);
         addToContent(_curNumBg);
         addToContent(_wildSoulBtn);
         addToContent(_vBox);
         addToContent(_trainBtn);
         addToContent(_curNumLabel);
         addToContent(_cunNumTxt);
         addToContent(_trainCountImage);
         addToContent(_trainCountBottom);
         addToContent(_trainCountText);
         _curNumLabel.text = LanguageMgr.GetTranslation("mountsFrmae.currentshoulingshi");
         _cunNumTxt.text = "0";
         _trainCountText.text = "1";
         addToContent(speedStrip);
         speedStrip.addChild(_moveSpeed);
         speedStrip.addChild(_mountSpeedTxt);
         addToContent(_mountGrowBar);
         addToContent(_mountGrowValueTxt);
         addToContent(_dismountBtn);
         addToContent(_mountBtn);
         addToContent(_mountShopBtn);
         if(VersionSwitch.MOUNT_REFINING_SOUL)
         {
            addToContent(_refiningSouleBtn);
         }
         speedStrip.tipData = LanguageMgr.GetTranslation("mountsFrmae.speedStrip.tipData");
         _mountGrowBar["halo"].visible = false;
         frameIndex = Math.max(1,Math.min(100,int(this.mountInfo.currentGrowExp * 100 / this.mountInfo.growExpMax)));
         _mountGrowBar.gotoAndStop(frameIndex);
         _curGrade = mountInfo.grade;
         _oldGp = this.mountInfo.currentGrowExp;
         _helpBtn.tipData = LanguageMgr.GetTranslation("mounts.tips05");
         _mountGradeTxt.text = LanguageMgr.GetTranslation("mounts.command01",this.mountInfo.grade);
         this.titleText = LanguageMgr.GetTranslation("mounts.command07");
         addToContent(_levelupMc);
         _discountBack = ComponentFactory.Instance.creatBitmap("asset.mounts.discountBack");
         _discountNum = ComponentFactory.Instance.creatComponentByStylename("mounts.discountImage");
         addToContent(_discountBack);
         _discountBack.visible = false;
         addToContent(_discountNum);
         _discountNum.setFrame(0);
         _starBox = new StarBar(5,0,"asset.wildsoul.EmptyStar","asset.wildsoul.FullStar");
         _starBox.mouseEnabled = _starBox.mouseChildren = false;
         _starBox.x = 15;
         _starBox.y = 16;
         addToContent(_starBox);
         _flashMc = ComponentFactory.Instance.creat("asset.core.TaskRewardButtonMc3");
         _flashMc.gotoAndStop(1);
         _flashMc.pos.mouseEnabled = false;
         _flashMc.mouseEnabled = false;
         _promotBtn = ComponentFactory.Instance.creatComponentByStylename("wildSoulItem.promotBtn");
         _promotBtn.tipData = LanguageMgr.GetTranslation("refine");
         _promotBtn.y = 14;
         _flashMc.pos.addChild(_promotBtn);
         addToContent(_flashMc);
         _promotBtnStrip = ComponentFactory.Instance.creatCustomObject("wildsoul.promotBtnStrip");
         _promotBtnStrip.setTarget(_promotBtn);
         _promotBtnStrip.visible = ArmyManager.instance.thane.grades < 70;
         _promotBtnStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",70);
         addToContent(_promotBtnStrip);
         _price = ConfigInfoManager.instance.getMountFlyPrice();
         _flyMountBtn.tipData = LanguageMgr.GetTranslation("mountFrame.flyMountBtn.tips");
         _notFlyMountBtn.tipData = LanguageMgr.GetTranslation("mountFrame.notFlyMountBtn.tips");
         __flyStatuChange(null);
         if(MountsManager.instance.avatarList.firstBless)
         {
            flash();
         }
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_promotBtn);
         _promotBtn = null;
         ObjectUtils.disposeObject(_starBox);
         _starBox = null;
         ObjectUtils.disposeObject(_mountsAvatar);
         _mountsAvatar = null;
         ObjectUtils.disposeObject(_showArea);
         ObjectUtils.disposeAllChildren(_vBox);
         ObjectUtils.disposeObject(speedStrip);
         speedStrip = null;
         ObjectUtils.disposeViolentMc(_flashMc);
         _flashMc = null;
         ObjectUtils.disposeViolentMc(_mountMovieClip);
         _mountMovieClip = null;
         ObjectUtils.disposeViolentMc(_levelupMc);
         _levelupMc = null;
         ObjectUtils.disposeViolentMc(_levelupEffect);
         _levelupEffect = null;
         ObjectUtils.disposeViolentMc(_proplevelupEffect);
         _proplevelupEffect = null;
         ObjectUtils.disposeViolentMc(_mountGrowBar);
         _mountGrowBar = null;
         ObjectUtils.disposeObject(_promotBtnStrip);
         _promotBtnStrip = null;
         ObjectUtils.disposeObject(_refiningSouleBtn);
         _refiningSouleBtn = null;
         ObjectUtils.disposeObject(_flyMountBtn);
         _flyMountBtn = null;
         ObjectUtils.disposeObject(_notFlyMountBtn);
         _notFlyMountBtn = null;
         _bg = null;
         _bgBorder = null;
         _leftBg = null;
         _rightBorder = null;
         _bottomBg = null;
         _showArea = null;
         _mountNameBg = null;
         _temp = null;
         _mountNameBg = null;
         _mountNameTxt = null;
         _mountGradeTxt = null;
         _wildSoulBtn = null;
         _vBox = null;
         _trainBtn = null;
         _mountNameBg = null;
         _moveSpeed = null;
         _mountSpeedTxt = null;
         _mountGrowValueTxt = null;
         _dismountBtn = null;
         _mountBtn = null;
         _group = null;
         _itemArray = null;
         _propNameArray = null;
         _mountNextGradeTxt = null;
         _wildSoilBtnBg = null;
         _curNumBg = null;
         _curNumLabel = null;
         _cunNumTxt = null;
         _trainCountBottom = null;
         _trainCountImage = null;
         _trainCountText = null;
         _mountShopBtn = null;
      }
      
      private function addEvent() : void
      {
         avatarList.addEventListener("mountListChange",__onListChange);
         mountInfo.addEventListener("mountInfoChange",__onMountInfoChange);
         mountInfo.addEventListener("propLevelup",__showPropLevelupEffect);
         mountInfo.addEventListener("mountLevelup",__showLevelupEffect);
         _wildSoulBtn.addEventListener("click",__onWildSoulClick);
         _trainBtn.addEventListener("click",__onTrainBtnClick);
         _mountBtn.addEventListener("click",__onMountBtnClick);
         _dismountBtn.addEventListener("click",__onDismountBtnClick);
         ArmyManager.instance.army.addEventListener("ARMY_PAWN_CHANGE",__onArmyMountStateChange);
         _helpBtn.addEventListener("click",__onHelperBtnClick);
         _promotBtn.addEventListener("click",__onPromotBtnClick);
         this.addEventListener("response",__frameResponse);
         if(_notFlyMountBtn)
         {
            _notFlyMountBtn.addEventListener("click",__notFlyMountBtnHandler);
         }
         _trainCountText.addEventListener("change",__textChangHandler);
         _trainCountText.addEventListener("focusIn",__inHandler);
         _mountShopBtn.addEventListener("click",__openMountShopHandler);
         _refiningSouleBtn.addEventListener("click",__refiningSoulBtnHandler);
         MsgMan.addObserver("MOUNT_REFINING_SOUL_CHANGE",this,__updateRefiningSoulHandler);
         avatarList.addEventListener("mountItemChange",__flyStatuChange);
      }
      
      private function removeEvent() : void
      {
         avatarList.removeEventListener("mountListChange",__onListChange);
         mountInfo.removeEventListener("mountInfoChange",__onMountInfoChange);
         mountInfo.removeEventListener("propLevelup",__showPropLevelupEffect);
         mountInfo.removeEventListener("mountLevelup",__showLevelupEffect);
         _wildSoulBtn.removeEventListener("click",__onWildSoulClick);
         _trainBtn.removeEventListener("click",__onTrainBtnClick);
         _mountBtn.removeEventListener("click",__onMountBtnClick);
         _dismountBtn.removeEventListener("click",__onDismountBtnClick);
         ArmyManager.instance.army.removeEventListener("ARMY_PAWN_CHANGE",__onArmyMountStateChange);
         _helpBtn.removeEventListener("click",__onHelperBtnClick);
         _promotBtn.removeEventListener("click",__onPromotBtnClick);
         this.removeEventListener("response",__frameResponse);
         if(_notFlyMountBtn)
         {
            _notFlyMountBtn.removeEventListener("click",__notFlyMountBtnHandler);
         }
         _trainCountText.removeEventListener("change",__textChangHandler);
         _trainCountText.removeEventListener("focusIn",__inHandler);
         _mountShopBtn.removeEventListener("click",__openMountShopHandler);
         if(_refiningSouleBtn)
         {
            _refiningSouleBtn.removeEventListener("click",__refiningSoulBtnHandler);
         }
         MsgMan.removeObserver("MOUNT_REFINING_SOUL_CHANGE",this,__updateRefiningSoulHandler);
         avatarList.removeEventListener("mountItemChange",__flyStatuChange);
      }
      
      private function __updateRefiningSoulHandler(param1:String, param2:Object) : void
      {
         for each(var _loc3_:PropertyItem in _itemArray)
         {
            _loc3_.update();
         }
      }
      
      private function __onListChange(param1:MountsEvent) : void
      {
         refreshStar();
      }
      
      public function get avatarList() : WildSoulCollection
      {
         return MountsManager.instance.avatarList;
      }
      
      private function __onMountInfoChange(param1:MountsEvent) : void
      {
         update();
         __flyStatuChange(null);
      }
      
      private function __openMountShopHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("shop",1002);
      }
      
      private function __refiningSoulBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("mounts",3);
      }
      
      private function getBagCount() : int
      {
         return GoodsManager.instance.getGoodsNumByTempId(_trainData.mountFoodTemplateId);
      }
      
      private function update() : void
      {
         var gradeStr:String;
         var timeId:int;
         var duration:Number;
         var timeline:TimelineLite;
         var item:PropertyItem;
         if(_tweenCore && _tweenCore.hasOwnProperty("currentProgress"))
         {
            _tweenCore["currentProgress"] = 1;
         }
         disposeTween();
         _cunNumTxt.text = String(getBagCount());
         _trainCountText.text = "1";
         _mountNameTxt.text = this.mountInfo.template ? this.mountInfo.template.TemplateName : "";
         _mountNameTxt.y = _mountNameTxt.numLines > 1 ? 11 : 16;
         gradeStr = LanguageMgr.GetTranslation("mounts.command01",this.mountInfo.grade);
         if(gradeStr != _mountGradeTxt.text && this.mountInfo.grade != 1)
         {
            _mountNextGradeTxt.text = gradeStr;
            _levelupMc.gotoAndPlay(1);
         }
         timeId = int(setTimeout(function():void
         {
            clearTimeout(timeId);
            _mountGradeTxt && (_mountGradeTxt.text = gradeStr);
         },700));
         _mountSpeedTxt.text = MountsManager.instance.avatarList.getSpeedMaxMount() + "%";
         _mountGrowValueTxt.text = this.mountInfo.currentGrowExp + " / " + this.mountInfo.growExpMax;
         frameIndex = Math.max(1,Math.min(100,int(mountInfo.currentGrowExp * 100 / mountInfo.growExpMax)));
         duration = 0.3;
         if(mountInfo.grade != _curGrade)
         {
            if(mountInfo.isMaxGrade)
            {
               _tweenCore = TweenMax.to(_mountGrowBar,duration,{
                  "frame":100,
                  "onComplete":__onFinishTween
               });
            }
            else
            {
               timeline = new TimelineLite({"onComplete":__onFinishTween});
               if(100 - _mountGrowBar.currentFrame > 25)
               {
                  duration = 0.8;
               }
               timeline.append(TweenMax.to(_mountGrowBar,0.3,{"frame":100}));
               if(frameIndex > 25)
               {
                  duration = 0.8;
               }
               else
               {
                  duration = 0.3;
               }
               timeline.append(TweenMax.fromTo(_mountGrowBar,duration,{"frame":1},{"frame":frameIndex}));
               timeline.play();
               _tweenCore = timeline;
               timeline = null;
            }
         }
         else if(_oldGp != mountInfo.currentGrowExp)
         {
            if(frameIndex - _mountGrowBar.currentFrame > 25)
            {
               duration = 0.8;
            }
            _tweenCore = TweenMax.to(_mountGrowBar,duration,{
               "frame":frameIndex,
               "onComplete":__onFinishTween
            });
         }
         _curGrade = mountInfo.grade;
         _oldGp = mountInfo.currentGrowExp;
         for each(item in _itemArray)
         {
            item.update();
         }
         if(mountInfo.discount < 10 && mountInfo.discount > 0)
         {
            _discountBack.visible = true;
            _discountNum.setFrame(mountInfo.discount);
            _trainBtn.tipData = LanguageMgr.GetTranslation("mounts.tips06",_trainData.trainPoint,mountInfo.addPointCount);
         }
         else
         {
            _discountBack.visible = false;
            _discountNum.setFrame(0);
            _trainBtn.tipData = LanguageMgr.GetTranslation("mounts.tips02",_trainData.trainPoint);
         }
         _mountsAvatar.data = mountInfo.template;
         __onArmyMountStateChange(null);
         refreshStar();
      }
      
      private function __flyStatuChange(param1:MountsEvent) : void
      {
         var _loc2_:WildSoulInfo = MountsManager.instance.avatarList.getWildSoulInfo(mountInfo.templateId);
         if(_loc2_)
         {
            _flyMountBtn.visible = _loc2_.isBuyFly || mountInfo.template.IsFly == 1 ? true : false;
            _notFlyMountBtn.visible = !_flyMountBtn.visible;
         }
      }
      
      private function refreshStar() : void
      {
         var _loc1_:WildSoulInfo = MountsManager.instance.avatarList.getWildSoulInfo(mountInfo.templateId);
         if(_loc1_)
         {
            _starBox.progress = _loc1_.star;
            _starBox.count = _loc1_.template.maxStarGrade;
         }
         _starBox.x = _mountNameTxt.x + _mountNameTxt.textWidth + 5;
         _promotBtn.x = _starBox.x + _starBox.width + 2;
         _promotBtnStrip.x = _promotBtn.x;
         _starBox.visible = _promotBtn.visible = MountsManager.instance.canShowStar(mountInfo.templateId);
         _promotBtnStrip.setTarget(_promotBtn);
         _promotBtn.enable = ArmyManager.instance.thane.grades >= 70;
      }
      
      public function flash() : void
      {
         if(_flashMc)
         {
            _flashMc.play();
         }
      }
      
      public function unFlash() : void
      {
         if(_flashMc)
         {
            _flashMc.gotoAndStop(1);
         }
      }
      
      private function __onFinishTween() : void
      {
         disposeTween();
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(_trainCountText.text);
         if(_loc2_ <= 0)
         {
            _trainCountText.text = "1";
         }
         if(_loc2_ >= 10000)
         {
            _trainCountText.text = "9999";
         }
      }
      
      private function __inHandler(param1:FocusEvent) : void
      {
         _trainCountText.setSelection(0,_trainCountText.text.length);
      }
      
      private function __onWildSoulClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("mounts",2);
      }
      
      private function __onTrainBtnClick(param1:MouseEvent) : void
      {
         var _loc18_:* = null;
         var _loc8_:String = null;
         var _loc3_:String = null;
         var _loc14_:ThaneInfo = null;
         var _loc16_:int = 0;
         var _loc12_:String = null;
         var _loc11_:int = getTimer();
         if(_loc11_ - _lastClickTime < 400)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _lastClickTime = _loc11_;
         SoundManager.instance.play("022");
         var _loc4_:PropertyItem = _group.getSelectedItem() as PropertyItem;
         if(!_loc4_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mounts.command09"));
            return;
         }
         var _loc7_:Boolean = true;
         var _loc15_:Boolean = true;
         var _loc13_:Date = new Date();
         var _loc5_:Date = SharedManager.instance.domesticateAlertDate;
         if(_loc5_)
         {
            if(_loc13_.fullYear == _loc5_.fullYear && _loc13_.month == _loc5_.month && _loc13_.date == _loc5_.date)
            {
               _loc15_ = true;
            }
         }
         _loc5_ = SharedManager.instance.domesticateAlertDate2;
         if(_loc5_)
         {
            if(_loc13_.fullYear == _loc5_.fullYear && _loc13_.month == _loc5_.month && _loc13_.date == _loc5_.date)
            {
               _loc7_ = true;
            }
         }
         var _loc10_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc6_:int = parseInt(_trainCountText.text) * _trainData.trainPoint;
         var _loc9_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc17_:String = LanguageMgr.GetTranslation("public.prompt");
         if(mountInfo.discount < 10 && mountInfo.discount > 0)
         {
            _loc6_ = Math.ceil(_loc6_ * mountInfo.discount / 10);
         }
         if(_loc15_)
         {
            _loc3_ = "";
            _loc14_ = ArmyManager.instance.thane;
            _loc16_ = int(_loc14_.templateInfo.Job);
            if(_loc16_ == 2 || _loc16_ == 1)
            {
               if(_loc4_.type == "Intellect")
               {
                  _loc12_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03");
                  _loc3_ = LanguageMgr.GetTranslation("mounts.mountframe.trainTip01",_loc6_,_loc12_,parseInt(_trainCountText.text));
               }
            }
            else if(_loc16_ == 3)
            {
               if(_loc4_.type == "Strength")
               {
                  _loc12_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01");
                  _loc3_ = LanguageMgr.GetTranslation("mounts.mountframe.trainTip01",_loc6_,_loc12_,parseInt(_trainCountText.text));
               }
            }
            _loc14_ = null;
            if(_loc3_ != "")
            {
               SimpleAlertHelper.instance.data = [__todayNotAlertTrain];
               _loc8_ = _loc3_;
               SimpleAlertHelper.instance.popAlerFrame(_loc17_,_loc8_,_loc9_,_loc2_,true,true,true,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert");
               return;
            }
         }
         if(_loc7_)
         {
            SimpleAlertHelper.instance.data = [__todayNotAlertTrain2];
            _loc8_ = LanguageMgr.GetTranslation("mounts.normaltip",_loc6_,parseInt(_trainCountText.text));
            SimpleAlertHelper.instance.popAlerFrame(_loc17_,_loc8_,_loc9_,_loc2_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert");
            return;
         }
         doTrain();
      }
      
      private function __todayNotAlertTrain(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         SharedManager.instance.domesticateAlertDate = new Date();
         SharedManager.instance.saveDomesticateAlert();
         SharedManager.instance.advDomesticateUseBindDate = new Date();
         SharedManager.instance.advDomesticateUseBind = param2;
         SharedManager.instance.saveAdvDomesticateUseBind();
         doTrain();
      }
      
      private function __todayNotAlertTrain2(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         SharedManager.instance.domesticateAlertDate2 = new Date();
         SharedManager.instance.saveDomesticate2Alert();
         SharedManager.instance.advDomesticateUseBind = param2;
         doTrain();
      }
      
      private function doTrain() : void
      {
         var _loc9_:int = 0;
         var _loc1_:Boolean = false;
         var _loc5_:int = 0;
         if(isDie)
         {
            return;
         }
         var _loc7_:int = parseInt(_trainCountText.text);
         var _loc2_:PropertyItem = _group.getSelectedItem() as PropertyItem;
         if(_loc2_.propertyInfo.isLimit)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mounts.gradeIsMax"));
            return;
         }
         var _loc3_:Boolean = false;
         var _loc4_:int = int(playerInfo.point);
         if(SharedManager.instance.advDomesticateUseBind)
         {
            _loc4_ = playerInfo.point + playerInfo.giftToken;
         }
         var _loc6_:Array = GoodsManager.instance.getBagGoodsByTemplateId(_trainData.mountFoodTemplateId);
         var _loc8_:int = _loc7_ * _trainData.trainPoint;
         if(mountInfo.discount < 10 && mountInfo.discount > 0)
         {
            _loc8_ = Math.ceil(_loc8_ * mountInfo.discount / 10);
         }
         if(_loc6_ && _loc6_.length > 0 || _loc4_ >= _loc8_)
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            _loc9_ = int(PropertyInfo.getPropertyValue(_loc2_.type));
            _loc1_ = true;
            if(!SharedManager.instance.advDomesticateUseBind)
            {
               _loc1_ = Boolean(SharedManager.instance.advDomesticateUseBind);
            }
            _loc5_ = 0;
            if(_loc1_ == false)
            {
               _loc5_ = 1;
            }
            MountsManager.instance.mountOperateSend(1,_loc9_,_loc5_,_loc7_);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function __onMountBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = getTimer();
         if(_loc2_ - _lastClickTime < 900)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         SoundManager.instance.play("022");
         if(ArmyManager.instance.thane.changeShapeId > 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mountsFrame.CannotMount"));
            return;
         }
         MountsManager.instance.mountOperateSend(3,0,0,1,0);
         _lastClickTime = _loc2_;
      }
      
      private function __onDismountBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = getTimer();
         if(_loc2_ - _lastClickTime < 900)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         SoundManager.instance.play("022");
         if(SpaceManager.instance.model && !SpaceManager.instance.model.canLand())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.space.CannotLand"));
            return;
         }
         if(SwitchPageHelp.isInCampaign && Boolean(PlayerManager.instance.currentPlayerModel.isOnObstacle))
         {
            SpaceSocketOutManager.instance.resetSpacePosition();
         }
         MountsManager.instance.mountOperateSend(3,0,0,0,0);
         _lastClickTime = _loc2_;
      }
      
      private function __onArmyMountStateChange(param1:ArmyEvent) : void
      {
         var _loc2_:int = int(ArmyManager.instance.army.mountTemplateId);
         if(_loc2_ > 0)
         {
            this._dismountBtn.visible = true;
            this._mountBtn.visible = false;
         }
         else
         {
            this._dismountBtn.visible = false;
            this._mountBtn.visible = true;
         }
      }
      
      private function __onHelperBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("mounts.MountHelperFrame");
         _loc2_.show();
      }
      
      private function __onPromotBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
         FrameControllerManager.instance.openControllerByInfo("mounts",2,mountInfo.templateId);
      }
      
      private function __notFlyMountBtnHandler(param1:MouseEvent) : void
      {
         SimpleAlertHelper.instance.data = [__alertBackHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:int = int(GoodsManager.instance.getGoodsNumByTempId(MountsManager.STONE_TEMPID));
         var _loc6_:String = LanguageMgr.GetTranslation("mountsFrame.mountFly.text",_price,_loc4_);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,false,true);
      }
      
      private function __alertBackHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            MountsManager.instance.mountOperateSend(13,0,0,mountInfo.templateId);
         }
      }
      
      private function __showLevelupEffect(param1:Event = null) : void
      {
         if(!_levelupEffect)
         {
            _levelupEffect = ComponentFactory.Instance.creatCustomObject("mounts.levelupeffect");
         }
         var _loc2_:SimpleMovie = new SimpleMovie(_levelupEffect);
         _showArea.addChild(_loc2_);
         MountsManager.instance.requestWildSoulList();
      }
      
      private function __showPropLevelupEffect(param1:Event = null) : void
      {
         if(!_proplevelupEffect)
         {
            _proplevelupEffect = ComponentFactory.Instance.creatCustomObject("mounts.porplevelupeffect");
         }
         var _loc2_:PropertyItem = _group.getSelectedItem() as PropertyItem;
         var _loc3_:SimpleMovie = new SimpleMovie(_proplevelupEffect);
         _loc2_.addChild(_loc3_);
         _proplevelupEffect = null;
      }
      
      public function show() : void
      {
         if(isDie)
         {
            return;
         }
         LayerManager.Instance.addToLayer(this,3,true,true);
         _mountMovieClip && _mountMovieClip.play();
      }
      
      public function hide() : void
      {
         this.parent && this.parent.removeChild(this);
         _mountMovieClip && _mountMovieClip.stop();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get mountInfo() : MountInfo
      {
         return MountsManager.instance.mountInfo;
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
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
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         if(_discountBack)
         {
            _discountBack = null;
         }
         if(_discountNum)
         {
            _discountNum.dispose();
            _discountNum = null;
         }
         selectIndex = _group.selectIndex;
         disposeTween();
         removeEvent();
         uintView();
         _trainData = null;
         super.dispose();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
         NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_FIGHT"));
      }
      
      private function disposeTween() : void
      {
         if(_tweenCore)
         {
            _tweenCore.kill();
            _tweenCore = null;
         }
      }
      
      public function get controller() : MountsController
      {
         return FrameControllerManager.instance.mountsController;
      }
   }
}

