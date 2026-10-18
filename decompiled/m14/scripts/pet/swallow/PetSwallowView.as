package pet.swallow
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.TransformableComponent;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.MonopolySocketOutManager;
   import managers.PetSocketOut;
   import mvc.module.pet.PetData;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GameDrag;
   import yishi.utils.GraphicsUtils;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class PetSwallowView extends Component
   {
      
      private var _back:MovieClip;
      
      private var _mainPetTxt:GradientText;
      
      private var _secondPetTxt:GradientText;
      
      private var _mainPetNameTxt:FilterFrameText;
      
      private var _secondPetNameTxt:FilterFrameText;
      
      private var _swallowBtn:IconButton;
      
      private var _mainIcon:BaseIconView;
      
      private var _secondIcon:BaseIconView;
      
      private var _mainMask:MovieImage;
      
      private var _secondMask:MovieImage;
      
      private var _expNumber:Sprite;
      
      private var _numBitmapData:BitmapData;
      
      private var _tipComponent:TransformableComponent;
      
      private var removePetCallBack:Function;
      
      private var _yellowExpView:Bitmap;
      
      private var _greenExpView:Bitmap;
      
      private var _yellowMask:Sprite;
      
      private var _greenMask:Sprite;
      
      private var _lvTxt:FilterFrameText;
      
      private var _gradeMc:MovieClip;
      
      private var _curGradeTxt:FilterFrameText;
      
      private var _nextGradeTxt:FilterFrameText;
      
      private var _expTipView:Component;
      
      private var _cricleShape:Sprite;
      
      private var _checkForFullExpBtn:SelectedCheckButton;
      
      private var _pointImg:Bitmap;
      
      private var _mainPet:PetData;
      
      private var _secondPet:PetData;
      
      public var tweenAngle:Number;
      
      private var delayId:int = 0;
      
      private const specGoodsTempId:int = 208029;
      
      private var _specGoodsTemplate:GoodsTemplateInfo;
      
      public function PetSwallowView(param1:Function = null)
      {
         super();
         removePetCallBack = param1;
         initView();
         addEvent();
         this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creat("asset.pet.SwallowBack");
         addChild(_back);
         _yellowExpView = ComponentFactory.Instance.creatBitmap("asset.pet.YellowExp");
         _greenExpView = ComponentFactory.Instance.creatBitmap("asset.pet.GreenExp");
         addChild(_greenExpView);
         addChild(_yellowExpView);
         _expTipView = ComponentFactory.Instance.creatComponentByStylename("PetSwallowView.ExpTipView");
         var _loc1_:DisplayObject = GraphicsUtils.drawDisplayMask(_yellowExpView);
         _loc1_.alpha = 0;
         _expTipView.addChild(_loc1_);
         _expTipView.width = _loc1_.width;
         _expTipView.height = _loc1_.height;
         addChild(_expTipView);
         _yellowMask = new Sprite();
         _greenMask = new Sprite();
         _yellowMask.x = _yellowExpView.x + 65;
         _yellowMask.y = _yellowExpView.y + 45;
         _greenMask.x = _greenExpView.x + 65;
         _greenMask.y = _greenExpView.y + 45;
         _yellowExpView.mask = _yellowMask;
         _greenExpView.mask = _greenMask;
         addChild(_yellowMask);
         addChild(_greenMask);
         _cricleShape = new Sprite();
         _cricleShape.graphics.beginFill(16711680,0);
         _cricleShape.graphics.drawCircle(0,0,180);
         _cricleShape.graphics.endFill();
         _cricleShape.x = 253;
         _cricleShape.y = 190;
         addChild(_cricleShape);
         _mainPetTxt = ComponentFactory.Instance.creatComponentByStylename("pet.MainPetText");
         _secondPetTxt = ComponentFactory.Instance.creatComponentByStylename("pet.SecondPetText");
         _mainPetNameTxt = ComponentFactory.Instance.creatComponentByStylename("pet.MainPetNameText");
         _secondPetNameTxt = ComponentFactory.Instance.creatComponentByStylename("pet.SecondPetNameText");
         _swallowBtn = ComponentFactory.Instance.creatComponentByStylename("swallow.SwallowBtn");
         _mainIcon = ComponentFactory.Instance.creatCustomObject("pet.MainPetIcon");
         _secondIcon = ComponentFactory.Instance.creatCustomObject("pet.SecondPetIcon");
         _mainMask = ComponentFactory.Instance.creatComponentByStylename("pet.Adornment1");
         _mainMask.mouseEnabled = false;
         _secondMask = ComponentFactory.Instance.creatComponentByStylename("pet.Adornment2");
         _secondMask.mouseEnabled = false;
         _expNumber = new Sprite();
         _expNumber.x = 180;
         _expNumber.y = 363;
         _numBitmapData = ComponentFactory.Instance.creatBitmapData("asset.core.number_img_04");
         _tipComponent = new TransformableComponent();
         _tipComponent.x = 30;
         _tipComponent.y = 370;
         _tipComponent.tipStyle = "yishi.view.tips.OneLineTip";
         _tipComponent.graphics.beginFill(0,0);
         _tipComponent.graphics.drawRect(0,0,126,20);
         _tipComponent.graphics.endFill();
         addChild(_mainPetTxt);
         addChild(_secondPetTxt);
         addChild(_mainPetNameTxt);
         addChild(_secondPetNameTxt);
         addChild(_swallowBtn);
         addChild(_mainIcon);
         addChild(_secondIcon);
         addChild(_mainMask);
         addChild(_secondMask);
         addChild(_expNumber);
         addChild(_tipComponent);
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("PetSwallowView.LvTxt");
         _gradeMc = ComponentFactory.Instance.creatCustomObject("pet.SwallowGradeMc");
         _gradeMc.gotoAndStop(1);
         _gradeMc.mouseChildren = _gradeMc.mouseEnabled = false;
         addChild(_lvTxt);
         addChild(_gradeMc);
         _curGradeTxt = ComponentFactory.Instance.creatComponentByStylename("PetSwallowView.GradeTxt");
         _nextGradeTxt = ComponentFactory.Instance.creatComponentByStylename("PetSwallowView.GradeTxt");
         (_gradeMc["curMc"] as MovieClip).addChild(_curGradeTxt);
         (_gradeMc["nextMc"] as MovieClip).addChild(_nextGradeTxt);
         _mainIcon.mouseChildren = false;
         _secondIcon.mouseChildren = false;
         _mainIcon.graphics.beginFill(0,0);
         _mainIcon.graphics.drawRect(0,0,_mainIcon.iconWidth,_mainIcon.iconHeight);
         _mainIcon.graphics.endFill();
         _secondIcon.graphics.beginFill(0,0);
         _secondIcon.graphics.drawRect(0,0,_secondIcon.iconWidth,_secondIcon.iconHeight);
         _secondIcon.graphics.endFill();
         _checkForFullExpBtn = ComponentFactory.Instance.creatComponentByStylename("petswallow.checkBtnForFullExp");
         _checkForFullExpBtn.text = LanguageMgr.GetTranslation("petswallow.FullExp",costPoint);
         _pointImg = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.VoucherIconAsset");
         _pointImg.x = 100;
         _pointImg.y = 4;
         addChild(_checkForFullExpBtn);
         _checkForFullExpBtn.addChild(_pointImg);
         _lvTxt.text = LanguageMgr.GetTranslation("public.level4");
         _lvTxt.visible = false;
         _gradeMc.visible = false;
         _tipComponent.tipData = LanguageMgr.GetTranslation("PetSwallowView.tip");
         _mainPetTxt.text = LanguageMgr.GetTranslation("pet.PetFrame.mainPet");
         _secondPetTxt.text = LanguageMgr.GetTranslation("pet.PetFrame.secondPet");
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_mainPetTxt);
         _mainPetTxt = null;
         ObjectUtils.disposeObject(_secondPetTxt);
         _secondPetTxt = null;
         ObjectUtils.disposeObject(_mainPetNameTxt);
         _mainPetNameTxt = null;
         ObjectUtils.disposeObject(_secondPetNameTxt);
         _secondPetNameTxt = null;
         ObjectUtils.disposeObject(_swallowBtn);
         _swallowBtn = null;
         ObjectUtils.disposeObject(_mainIcon);
         _mainIcon = null;
         ObjectUtils.disposeObject(_secondIcon);
         _secondIcon = null;
         ObjectUtils.disposeObject(_mainMask);
         _mainMask = null;
         ObjectUtils.disposeObject(_secondMask);
         _secondMask = null;
         ObjectUtils.disposeObject(_expNumber);
         _expNumber = null;
         ObjectUtils.disposeObject(_numBitmapData);
         _numBitmapData = null;
         ObjectUtils.disposeObject(_tipComponent);
         _tipComponent = null;
         ObjectUtils.disposeObject(_yellowExpView);
         _yellowExpView = null;
         ObjectUtils.disposeObject(_greenExpView);
         _greenExpView = null;
         ObjectUtils.disposeObject(_yellowMask);
         _yellowMask = null;
         ObjectUtils.disposeObject(_greenMask);
         _greenMask = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_gradeMc);
         _gradeMc = null;
         ObjectUtils.disposeObject(_curGradeTxt);
         _curGradeTxt = null;
         ObjectUtils.disposeObject(_nextGradeTxt);
         _nextGradeTxt = null;
         ObjectUtils.disposeObject(_checkForFullExpBtn);
         _checkForFullExpBtn = null;
         ObjectUtils.disposeObject(_pointImg);
         _pointImg = null;
      }
      
      private function addEvent() : void
      {
         _mainIcon.addEventListener("mouseUp",__iconMouseUpHandler);
         _mainIcon.addEventListener("mouseDown",__mouseDownHandler);
         _secondIcon.addEventListener("mouseUp",__iconMouseUpHandler);
         _secondIcon.addEventListener("mouseDown",__mouseDownHandler);
         _checkForFullExpBtn.addEventListener("select",__selectedChangeHandler);
         _swallowBtn.addEventListener("click",__swallowClickHandler);
         NotificationManager.instance.addEventListener("END_DRAG",__endDragHandler);
      }
      
      private function removeEvent() : void
      {
         if(_mainIcon)
         {
            _mainIcon.removeEventListener("mouseUp",__iconMouseUpHandler);
            _mainIcon.removeEventListener("mouseDown",__mouseDownHandler);
            _mainIcon.removeEventListener("mouseMove",__mouseMoveHandler);
         }
         if(_secondIcon)
         {
            _secondIcon.removeEventListener("mouseUp",__iconMouseUpHandler);
            _secondIcon.removeEventListener("mouseDown",__mouseDownHandler);
            _secondIcon.removeEventListener("mouseMove",__mouseMoveHandler);
         }
         if(_checkForFullExpBtn)
         {
            _checkForFullExpBtn.removeEventListener("select",__selectedChangeHandler);
         }
         if(_swallowBtn)
         {
            _swallowBtn.removeEventListener("click",__swallowClickHandler);
         }
         NotificationManager.instance.removeEventListener("END_DRAG",__endDragHandler);
      }
      
      private function __iconMouseUpHandler(param1:MouseEvent) : void
      {
         (param1.currentTarget as EventDispatcher).removeEventListener("mouseMove",__mouseMoveHandler);
         if(delayId > 0)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         if(param1.currentTarget == _mainIcon)
         {
            mainPet = null;
         }
         else
         {
            secondPet = null;
         }
      }
      
      private function __selectedChangeHandler(param1:Event) : void
      {
         updateExp();
         updateGradeMc();
      }
      
      private function __swallowClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:String = "";
         if(!mainPet)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.PetFrame.noMainPet");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(!secondPet)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.PetFrame.noSecondPet");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc3_:Array = GoodsManager.instance.getPetEquipListById(secondPet.petId);
         if(_loc3_.length > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.inPetChanglle5");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(secondPet && secondPet.isLock)
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description4");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(mainPet == secondPet)
         {
            return;
         }
         _loc2_ = getCheckTip(secondPet);
         if(_loc2_)
         {
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_checkForFullExpBtn.selected)
         {
            showUseGoodsConfirmFrame();
            return;
         }
         if(secondPet.isDefenser)
         {
            checkDefenser();
            return;
         }
         showConfirmFrame();
      }
      
      private function updateToPlayerInfo(param1:int) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         playerInfo.beginChanges();
         _loc2_ = int(playerInfo.petMonopolyFormationOfArray.indexOf(param1.toString()));
         if(_loc2_ != -1)
         {
            playerInfo.petMonopolyFormationOfArray[_loc2_] = -1;
            _loc3_ = playerInfo.petMonopolyFormationOfArray.join(",");
            playerInfo.petMonopolyFormation = _loc3_;
            MonopolySocketOutManager.sendPetFormation(_loc3_);
         }
         playerInfo.commit();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function getCheckTip(param1:PetData) : String
      {
         var _loc2_:String = null;
         if(param1.isEnterWar)
         {
            _loc2_ = LanguageMgr.GetTranslation("PetSwallowView.inEnterWar");
         }
         else if(param1.isPractice)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.inPractice2");
         }
         else if(mainPet && mainPet.isFullExp())
         {
            _loc2_ = LanguageMgr.GetTranslation("PetSwallowView.fullExp");
         }
         else if(getSwallowExpFrom(param1) <= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("PetSwallowView.zeroExp");
         }
         else if(playerInfo.petChallengeFormationOfArray.indexOf(param1.petId + "") >= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.inPetChanglle2");
         }
         else if(param1.isRemote)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.inRemotePet2");
         }
         return _loc2_;
      }
      
      private function showUseGoodsConfirmFrame() : void
      {
         var _loc4_:TodayNotAlertFrame = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc1_:String = null;
         if(SharedManager.instance.petswallowNotShow)
         {
            confirmBack(true,SharedManager.instance.petswallowNotShowResult,true);
         }
         else
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert");
            _loc2_ = specGoodsTemplate ? specGoodsTemplate.TemplateName : "";
            _loc3_ = LanguageMgr.GetTranslation("petSwallowView.exp100",costPoint,_loc2_);
            _loc1_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_.show(_loc3_,_loc1_,useGoodsConfirmFrameBack,null,"center",2,true);
         }
      }
      
      private function useGoodsConfirmFrameBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.petswallowNotShow = true;
            SharedManager.instance.petswallowNotShowResult = param2;
         }
         confirmBack(true,param2,true);
      }
      
      private function checkDefenser() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("PetSwallowView.inGuard");
         _loc4_ = _loc4_ + ("<br/>" + LanguageMgr.GetTranslation("PetSwallowView.showConfirmFrameContent"));
         SimpleAlertHelper.instance.data = [confirmBack,false];
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,true,true,2,"SIMPLE_ALERT",0,"",null);
      }
      
      private function showConfirmFrame() : void
      {
         var _loc4_:String = null;
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         if(_mainPet.isBind)
         {
            _loc4_ = LanguageMgr.GetTranslation("PetSwallowView.showConfirmFrameContent");
         }
         else
         {
            _loc4_ = LanguageMgr.GetTranslation("PetSwallowView.showConfirmFrameContent2");
         }
         SimpleAlertHelper.instance.data = [confirmBack,false];
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,true,true,2,"SIMPLE_ALERT",0,"",null);
      }
      
      private function confirmBack(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         if(isDie)
         {
            return;
         }
         if(!mainPet)
         {
            return;
         }
         if(!secondPet)
         {
            return;
         }
         if(param1)
         {
            swallow(getPayType(param3,param2));
         }
      }
      
      private function getPayType(param1:Boolean, param2:Boolean) : int
      {
         var _loc3_:int = -1;
         if(param1)
         {
            if(hasSpecGoods)
            {
               _loc3_ = 3;
            }
            else if(param2)
            {
               _loc3_ = 2;
            }
            else
            {
               _loc3_ = 1;
            }
         }
         return _loc3_;
      }
      
      private function get hasSpecGoods() : Boolean
      {
         var _loc1_:int = int(GoodsManager.instance.getGoodsNumByTempId(208029));
         return _loc1_ > 0;
      }
      
      private function swallow(param1:int = -1) : void
      {
         if((param1 == 1 || param1 == 2) && getMyPoints(param1) < costPoint)
         {
            RechargeAlertMannager.show();
            return;
         }
         updateToPlayerInfo(secondPet.petId);
         PetSocketOut.swallowPet(mainPet.petId,secondPet.petId,param1);
         if(_checkForFullExpBtn)
         {
            _checkForFullExpBtn.selected = false;
         }
      }
      
      private function getMyPoints(param1:int) : int
      {
         var _loc2_:int = 0;
         if(param1 == 1)
         {
            _loc2_ = int(playerInfo.point);
         }
         else
         {
            _loc2_ = int(playerInfo.allPoint);
         }
         return _loc2_;
      }
      
      private function get costPoint() : int
      {
         var _loc2_:int = 50;
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("swallow_fullgp_points");
         if(_loc1_)
         {
            _loc2_ = parseInt(_loc1_.ConfigValue);
         }
         return _loc2_;
      }
      
      private function getSwallowExpFrom(param1:PetData) : Number
      {
         var _loc2_:Number = 0;
         if(!param1)
         {
            return _loc2_;
         }
         if(_checkForFullExpBtn && _checkForFullExpBtn.selected)
         {
            _loc2_ = Number(param1.totalExp);
         }
         else
         {
            _loc2_ = Math.floor(param1.totalExp * 0.5);
         }
         return _loc2_;
      }
      
      public function get mainPet() : PetData
      {
         return _mainPet;
      }
      
      public function set mainPet(param1:PetData) : void
      {
         var _loc2_:String = null;
         _mainPet = param1;
         if(_mainPet)
         {
            _mainPetNameTxt.text = _mainPet.name;
            _mainPetNameTxt.setFrame(_mainPet.quality);
            _loc2_ = IconFactory.getPetHeadSmallIcon(_mainPet.templateId);
            if(_loc2_ != _mainIcon.icon)
            {
               _mainIcon.icon = _loc2_;
            }
            _mainIcon.tipData = _mainPet;
         }
         else
         {
            _mainPetNameTxt.text = "";
            _mainIcon.icon = null;
            _mainIcon.tipData = null;
            _lvTxt.visible = false;
         }
         updateExp();
         updateGradeMc();
         updateListView();
      }
      
      public function get secondPet() : PetData
      {
         return _secondPet;
      }
      
      public function set secondPet(param1:PetData) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(param1)
         {
            _loc2_ = getCheckTip(param1);
            if(_loc2_)
            {
               MessageTipManager.instance().show(_loc2_);
               return;
            }
         }
         _secondPet = param1;
         if(_secondPet)
         {
            _secondPetNameTxt.text = _secondPet.name;
            _secondPetNameTxt.setFrame(_secondPet.quality);
            _loc3_ = IconFactory.getPetHeadSmallIcon(_secondPet.templateId);
            if(_loc3_ != _secondIcon.icon)
            {
               _secondIcon.icon = _loc3_;
            }
            _secondIcon.tipData = _secondPet;
         }
         else
         {
            _secondPetNameTxt.text = "";
            _secondIcon.icon = null;
            _secondIcon.tipData = null;
            ObjectUtils.disposeAllChildren(_expNumber);
            _lvTxt.visible = false;
         }
         updateExp();
         updateGradeMc();
         updateListView();
      }
      
      private function updateExp() : void
      {
         var _loc1_:Number = getSwallowExpFrom(secondPet);
         NumberViewUtils.refreshValue(_loc1_,_expNumber,_numBitmapData,19,25,15,19,"0123456789");
      }
      
      private function updateGradeMc() : void
      {
         var _loc1_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc4_:Number = NaN;
         var _loc7_:int = 0;
         var _loc2_:Number = NaN;
         _yellowMask.graphics.clear();
         _greenMask.graphics.clear();
         _lvTxt.visible = false;
         _gradeMc.visible = false;
         _gradeMc.stop();
         _curGradeTxt.text = "";
         _nextGradeTxt.text = "";
         _expTipView.tipData = null;
         TweenMax.killTweensOf(this);
         if(mainPet)
         {
            if(_mainPet.upgradeTemplte)
            {
               _loc1_ = 270 * _mainPet.curExp / _mainPet.upgradeTemplte.Data;
               _loc6_ = _mainPet.curExp + " / " + _mainPet.upgradeTemplte.Data;
            }
            else
            {
               _loc1_ = 270;
               _loc6_ = LanguageMgr.GetTranslation("mainBar.PlayerExperenceView.msg");
            }
            GraphicsUtils.changeSectorAngle(_yellowMask,0,0,65,135,_loc1_);
            _expTipView.tipData = createHtmlTipString(_loc6_);
         }
         if(checkCanSwallow(secondPet))
         {
            _loc5_ = getSwallowExpFrom(secondPet);
            _loc4_ = _mainPet.curExp + _loc5_;
            _loc3_ = 270 * _loc4_ / _mainPet.upgradeTemplte.Data;
            if(_loc3_ > 270)
            {
               _loc3_ = 270;
            }
            _lvTxt.visible = true;
            _gradeMc.visible = true;
            _loc7_ = getAfterSwallowGrade(_loc5_);
            _curGradeTxt.text = mainPet.grade + "";
            _nextGradeTxt.text = _loc7_ + "";
            if(_loc7_ != mainPet.grade)
            {
               _gradeMc.play();
            }
            else
            {
               _gradeMc.gotoAndStop(17);
            }
            this.tweenAngle = _loc1_;
            _loc2_ = (int(_loc3_ - _loc1_)) * 0.27 * 0.02;
            TweenMax.to(this,0.4,{
               "tweenAngle":_loc3_,
               "onUpdate":tweenUpdateHandler
            });
            _loc6_ = _loc4_ + " / " + _mainPet.upgradeTemplte.Data;
            if(_loc5_ > 0)
            {
               _expTipView.tipData = createHtmlTipString(_loc6_,"#00ff40");
            }
         }
      }
      
      private function checkCanSwallow(param1:PetData) : Boolean
      {
         if(!param1 || !mainPet || Boolean(mainPet.isFullExp()) || Boolean(param1.isEnterWar) || Boolean(param1.isPractice))
         {
            return false;
         }
         return true;
      }
      
      private function tweenUpdateHandler() : void
      {
         GraphicsUtils.changeSectorAngle(_greenMask,0,0,65,135,tweenAngle);
      }
      
      private function getAfterSwallowGrade(param1:Number) : int
      {
         var _loc4_:int = 0;
         var _loc2_:UpgradeTemplateInfo = null;
         if(!_mainPet)
         {
            return -1;
         }
         if(!_secondPet)
         {
            return -1;
         }
         var _loc3_:int = int(PetData.maxGrade);
         if(mainPet.grade >= _loc3_)
         {
            return -1;
         }
         var _loc6_:Number = _mainPet.curExp + param1;
         _loc4_ = int(mainPet.grade);
         while(_loc4_ < _loc3_)
         {
            _loc2_ = PetData.upgradeTemplates[_loc4_] as UpgradeTemplateInfo;
            if(_loc6_ <= _loc2_.Data)
            {
               break;
            }
            _loc6_ -= _loc2_.Data;
            _loc2_ = null;
            _loc4_++;
         }
         var _loc5_:int = int(ArmyManager.instance.thane.grades);
         if(_loc4_ > _loc5_)
         {
            _loc4_ = _loc5_;
         }
         return _loc4_;
      }
      
      private function createHtmlTipString(param1:String, param2:String = "#ffffff") : String
      {
         return "<font color=\'" + param2 + "\' face=\'Arial\'>" + param1 + "</font>";
      }
      
      private function updateListView() : void
      {
         if(removePetCallBack != null)
         {
            removePetCallBack([mainPet,secondPet]);
         }
      }
      
      private function __endDragHandler(param1:NotificationEvent) : void
      {
         var _loc3_:BaseIconView = param1.data.target as BaseIconView;
         var _loc2_:PetData = param1.data.data as PetData;
         if(_loc3_ == _mainIcon)
         {
            mainPet = _loc2_;
         }
         else if(_loc3_ == _secondIcon)
         {
            secondPet = _loc2_;
         }
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         (param1.currentTarget as EventDispatcher).addEventListener("mouseMove",__mouseMoveHandler);
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:PetData = null;
         (param1.currentTarget as EventDispatcher).removeEventListener("mouseMove",__mouseMoveHandler);
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         if(param1.currentTarget == _mainIcon)
         {
            _loc2_ = mainPet;
         }
         else if(param1.currentTarget == _secondIcon)
         {
            _loc2_ = secondPet;
         }
         if(!_loc2_)
         {
            return;
         }
         clearTimeout(delayId);
         delayId = setTimeout(beginDrag,100,"down",_loc2_);
      }
      
      private function beginDrag(param1:String, param2:PetData) : void
      {
         clearTimeout(delayId);
         delayId = 0;
         var _loc4_:BaseIconView = ComponentFactory.Instance.creatCustomObject("taskTraceTips.PetIcon");
         _loc4_.icon = IconFactory.getPetHeadSmallIcon(param2.templateId);
         _loc4_.mouseChildren = _loc4_.mouseEnabled = false;
         _loc4_.width = _loc4_.iconWidth;
         _loc4_.height = _loc4_.iconHeight;
         var _loc3_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":_loc4_,
            "type":param1
         });
         _loc3_.data = param2;
         _loc3_.onDrop = dragBack;
         _loc3_.dropChecks = [BaseIconView,_cricleShape,Stage];
      }
      
      private function dragBack(param1:GameDrag) : void
      {
         if(param1.dropTarget == _secondIcon)
         {
            if(param1.data == mainPet)
            {
               mainPet = secondPet;
               secondPet = param1.data;
               if(mainPet == secondPet)
               {
                  secondPet = null;
               }
            }
         }
         else if(param1.dropTarget == _mainIcon)
         {
            if(param1.data == secondPet)
            {
               secondPet = mainPet;
               mainPet = param1.data;
               if(mainPet == secondPet)
               {
                  secondPet = null;
               }
            }
         }
         else if(param1.dropTarget != _cricleShape)
         {
            if(param1.data == mainPet)
            {
               mainPet = null;
            }
            else if(param1.data == secondPet)
            {
               secondPet = null;
            }
         }
         ObjectUtils.disposeAllChildren(param1.dragIcon as Sprite);
         ObjectUtils.disposeObject(param1.dragIcon);
      }
      
      public function set data(param1:PetData) : void
      {
         if(!mainPet)
         {
            if(param1 == secondPet)
            {
               mainPet = null;
            }
            else
            {
               mainPet = param1;
            }
         }
         else if(param1 == mainPet)
         {
            secondPet = null;
         }
         else
         {
            secondPet = param1;
         }
      }
      
      private function get specGoodsTemplate() : GoodsTemplateInfo
      {
         if(!_specGoodsTemplate)
         {
            _specGoodsTemplate = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208029);
         }
         return _specGoodsTemplate;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         TweenMax.killTweensOf(this);
         removePetCallBack = null;
         removeEvent();
         uintView();
         super.dispose();
         _mainPet = null;
         _secondPet = null;
         _cricleShape = null;
      }
   }
}

