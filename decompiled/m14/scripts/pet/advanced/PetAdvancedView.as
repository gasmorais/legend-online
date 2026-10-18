package pet.advanced
{
   import bag.events.BagEvent;
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.PetSocketOut;
   import mvc.module.pet.PetData;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.PetTemplate;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class PetAdvancedView extends Component
   {
      
      private var _back:MovieImage;
      
      private var _blessTxt:Image;
      
      private var _blessBar:MovieImage;
      
      private var _goodsIcon:ScaleFrameImage;
      
      private var _petHeadIcon:BaseIconView;
      
      private var _petNameTxt:FilterFrameText;
      
      private var _blessPrecentTxt:FilterFrameText;
      
      private var _currNumberLabel:FilterFrameText;
      
      private var _currNumberTxt:FilterFrameText;
      
      private var _currMaxMesTxt:FilterFrameText;
      
      private var _oldAttrView:PetAttributeView;
      
      private var _newAttrView:PetAttributeView;
      
      private var _fullAttrView:PetAttributeView;
      
      private var _fightCapacityImg:Bitmap;
      
      private var _fightCapacityNumBD:BitmapData;
      
      private var _fightCapacityNumContainer:Sprite;
      
      private var _normalBtn:IconButton;
      
      private var _critMc:MovieClip;
      
      private var _priticeMc:MovieClip;
      
      private var _upgradeMc:MovieClip;
      
      private var _lightMc:MovieClip;
      
      private var _critNumBitmapData:BitmapData;
      
      private var _numContainer:Sprite;
      
      private var _playerInfo:PlayerInfo;
      
      private var _fightMc:MovieClip;
      
      private var _playFightMc:Boolean = false;
      
      private var _petFight:int;
      
      private const numberOfAdvanced:int = 50;
      
      private const onceExp:int = 10;
      
      private const MaxEverNum:int = 5;
      
      private var _trainCountImage:Image;
      
      private var _trainCountBottom:Image;
      
      private var _trainCountText:FilterFrameText;
      
      private var _hBox1:HBox;
      
      private var _hBox2:HBox;
      
      private var tempConfigInfo:ConfigInfosTempInfo;
      
      private var onceCost:int = 10;
      
      private var _lastCickTime1:int = 0;
      
      private var tempObj:Object;
      
      private var _data:PetData;
      
      private var _canPlayMovie:Boolean;
      
      private var _isCrit:Boolean;
      
      private var _critValue:int = 0;
      
      private var _lastGp:int;
      
      private var _lastGrade:int = 0;
      
      private var _isUpgrade:Boolean = false;
      
      private var _currentTimeLine:TimelineMax;
      
      private var _timerId:int = 0;
      
      private var _lastFrame:int = -1;
      
      public function PetAdvancedView()
      {
         super();
         _playerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         initView();
         addEvent();
         mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("petAdv.Back");
         _blessBar = ComponentFactory.Instance.creatComponentByStylename("petAdv.BlessBar");
         _blessBar.setFrame(1);
         _blessTxt = ComponentFactory.Instance.creatComponentByStylename("petAdv.BlessingTxt");
         _goodsIcon = ComponentFactory.Instance.creatComponentByStylename("petAdv.ShenghunStone");
         _goodsIcon.setFrame(1);
         _fightMc = ComponentFactory.Instance.creat("asset.core.powerMc");
         addChild(_back);
         addChild(_blessTxt);
         addChild(_blessBar);
         addChild(_goodsIcon);
         _upgradeMc = ComponentFactory.Instance.creat("asset.pet.UpQuaintlyMc");
         addChild(_upgradeMc);
         _petHeadIcon = ComponentFactory.Instance.creatCustomObject("petAdv.PetIcon");
         _petNameTxt = ComponentFactory.Instance.creatComponentByStylename("petAdv.PetNameTxt");
         addChild(_petHeadIcon);
         addChild(_petNameTxt);
         _blessPrecentTxt = ComponentFactory.Instance.creatComponentByStylename("petAdv.BlessBarTxt");
         _currNumberLabel = ComponentFactory.Instance.creatComponentByStylename("petAdv.NumLabelTxt");
         _currNumberTxt = ComponentFactory.Instance.creatComponentByStylename("petAdv.NumValueTxt");
         _currMaxMesTxt = ComponentFactory.Instance.creatComponentByStylename("petAdv.MaxMesTxt");
         _hBox1 = new HBox();
         _hBox2 = new HBox();
         _hBox1.spacing = _hBox2.spacing = 5;
         addChild(_hBox1);
         _hBox1.x = 132;
         _hBox1.y = 172;
         addChild(_hBox2);
         _hBox2.x = 347;
         _hBox2.y = 172;
         addChild(_blessPrecentTxt);
         addChild(_currNumberLabel);
         addChild(_currNumberTxt);
         addChild(_currMaxMesTxt);
         _oldAttrView = new PetAttributeView();
         _newAttrView = new PetAttributeView();
         _fullAttrView = new PetAttributeView();
         _fullAttrView.frame = 6;
         _fullAttrView.visible = false;
         _oldAttrView.x = 127;
         _oldAttrView.y = 192;
         _newAttrView.x = 347;
         _newAttrView.y = 192;
         _fullAttrView.x = 223;
         _fullAttrView.y = 192;
         addChild(_oldAttrView);
         addChild(_newAttrView);
         addChild(_fullAttrView);
         _fightCapacityImg = ComponentFactory.Instance.creatBitmap("asset.pet.FightCapacityTxt");
         _fightCapacityNumBD = ComponentFactory.Instance.creatBitmapData("asset.core.number_img_04");
         _fightCapacityNumContainer = ComponentFactory.Instance.creatCustomObject("pet.FightCapacityNumContainer");
         _normalBtn = ComponentFactory.Instance.creatComponentByStylename("petAdv.NormalBtn");
         _trainCountImage = ComponentFactory.Instance.creatComponentByStylename("PetAdvancedView.trainCountImage");
         _trainCountBottom = ComponentFactory.Instance.creatComponentByStylename("PetAdvancedView.trainCountBottom");
         _trainCountText = ComponentFactory.Instance.creatComponentByStylename("PetAdvancedView.trainCountText");
         addChild(_fightCapacityImg);
         addChild(_fightCapacityNumContainer);
         addChild(_trainCountImage);
         addChild(_trainCountBottom);
         addChild(_trainCountText);
         _trainCountText.text = "1";
         addChild(_normalBtn);
         addChild(_fightMc);
         _fightMc.x = 285;
         _fightMc.y = 326;
         _numContainer = new Sprite();
         _numContainer.x = 0;
         _critNumBitmapData = ComponentFactory.Instance.creatBitmapData("asset.pet.AdvCritNum");
         _lightMc = ComponentFactory.Instance.creat("asset.pet.AdvGreenLight");
         _lightMc.stop();
         _critMc = ComponentFactory.Instance.creat("asset.pet.AdvCritMc");
         _critMc.gotoAndStop(1);
         _critMc.y = -58;
         _priticeMc = ComponentFactory.Instance.creat("asset.pet.AdvParticleMc");
         _priticeMc.gotoAndStop(1);
         _upgradeMc.gotoAndStop(1);
         _upgradeMc.x = _blessBar.x + 120;
         _upgradeMc.y = _blessBar.y + 14;
         _critMc.visible = false;
         _priticeMc.visible = false;
         _upgradeMc.visible = false;
         _upgradeMc.mouseChildren = _upgradeMc.mouseEnabled = false;
         _critMc.mouseChildren = _critMc.mouseEnabled = false;
         _priticeMc.mouseChildren = _priticeMc.mouseEnabled = false;
         _blessBar.addChild(_blessBar.movie);
         _blessBar.addChild(_priticeMc);
         _blessBar.addChild(_critMc);
         tempConfigInfo = TempleteManager.instance.getConfigInfoByConfigName("pet_up_quality");
         _currNumberLabel.text = LanguageMgr.GetTranslation("pet.currentNumber");
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208023);
         if(_loc1_)
         {
            _goodsIcon.tipData = _loc1_.TemplateName;
         }
         if(tempConfigInfo)
         {
            onceCost = parseInt(tempConfigInfo.ConfigValue);
         }
         _normalBtn.tipData = LanguageMgr.GetTranslation("PetAdvancedView.normalTip",onceCost);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_blessTxt);
         _blessTxt = null;
         ObjectUtils.disposeObject(_blessBar);
         _blessBar = null;
         ObjectUtils.disposeObject(_goodsIcon);
         _goodsIcon = null;
         ObjectUtils.disposeObject(_hBox1);
         _hBox1 = null;
         ObjectUtils.disposeObject(_hBox2);
         _hBox2 = null;
         ObjectUtils.disposeObject(_petHeadIcon);
         _petHeadIcon = null;
         ObjectUtils.disposeObject(_petNameTxt);
         _petNameTxt = null;
         ObjectUtils.disposeObject(_blessPrecentTxt);
         _blessPrecentTxt = null;
         ObjectUtils.disposeObject(_currNumberLabel);
         _currNumberLabel = null;
         ObjectUtils.disposeObject(_currNumberTxt);
         _currNumberTxt = null;
         ObjectUtils.disposeObject(_currMaxMesTxt);
         _currMaxMesTxt = null;
         ObjectUtils.disposeObject(_oldAttrView);
         _oldAttrView = null;
         ObjectUtils.disposeObject(_newAttrView);
         _newAttrView = null;
         ObjectUtils.disposeObject(_fullAttrView);
         _fullAttrView = null;
         ObjectUtils.disposeViolentMc(_upgradeMc);
         _upgradeMc = null;
         ObjectUtils.disposeViolentMc(_priticeMc);
         _priticeMc = null;
         ObjectUtils.disposeViolentMc(_critMc);
         _critMc = null;
         ObjectUtils.disposeObject(_critNumBitmapData);
         _critNumBitmapData = null;
         ObjectUtils.disposeObject(_fightCapacityImg);
         _fightCapacityImg = null;
         ObjectUtils.disposeObject(_fightCapacityNumBD);
         _fightCapacityNumBD = null;
         ObjectUtils.disposeAllChildren(_fightCapacityNumContainer);
         _fightCapacityNumContainer = null;
         ObjectUtils.disposeAllChildren(_numContainer);
         _numContainer = null;
         ObjectUtils.disposeAllChildren(_normalBtn);
         _normalBtn = null;
         ObjectUtils.disposeAllChildren(_lightMc);
         _lightMc = null;
         ObjectUtils.disposeViolentMc(_fightMc);
         _fightMc = null;
         ObjectUtils.disposeObject(_trainCountBottom);
         _trainCountBottom = null;
         ObjectUtils.disposeObject(_trainCountImage);
         _trainCountImage = null;
         ObjectUtils.disposeObject(_trainCountText);
         _trainCountText = null;
      }
      
      private function addEvent() : void
      {
         if(_normalBtn)
         {
            _normalBtn.addEventListener("click",__normalHanlder);
         }
         GoodsManager.instance.addEventListener("UPDATE_BAG",__updateNumberHandler);
         PlayerManager.instance.currentPlayerModel.playerInfo.addEventListener("PLAYER_INFO_UPDATE",__playerInfoUpdateHandler);
         _trainCountText.addEventListener("change",__textChangHandler);
         _trainCountText.addEventListener("focusIn",__inHandler);
      }
      
      private function removeEvent() : void
      {
         if(_normalBtn)
         {
            _normalBtn.removeEventListener("click",__normalHanlder);
         }
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__updateNumberHandler);
         PlayerManager.instance.currentPlayerModel.playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__playerInfoUpdateHandler);
         _trainCountText.removeEventListener("change",__textChangHandler);
         _trainCountText.removeEventListener("focusIn",__inHandler);
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
      
      private function __normalHanlder(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         var _loc3_:int = getTimer();
         if(_loc3_ - _lastCickTime1 < 400)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _lastCickTime1 = _loc3_;
         if(!data)
         {
            return;
         }
         if(!data.qualityUpgradeTemplateInfo)
         {
            _loc2_ = LanguageMgr.GetTranslation("PetAdvancedView.tipCommand02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         checkPointForNormal();
      }
      
      private function checkPointForNormal() : void
      {
         var _loc3_:int = getOnceAdvancedCost();
         var _loc4_:int = parseInt(_trainCountText.text);
         var _loc6_:String = LanguageMgr.GetTranslation("PetAdvancedView.advance.tipCommand01",_loc4_,needItemName,_loc3_,needItemName);
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.data = [checkPointForNormalBack];
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc1_,_loc2_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert");
      }
      
      private function getOnceAdvancedCost() : int
      {
         var _loc1_:int = 10;
         if(tempConfigInfo)
         {
            _loc1_ = parseInt(tempConfigInfo.ConfigValue);
         }
         return _loc1_ * parseInt(_trainCountText.text);
      }
      
      private function checkPointForNormalBack(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         checkWillBeBindForNormal(param2);
      }
      
      private function checkWillBeBindForNormal(param1:Boolean) : void
      {
         tempObj = {
            "useBindPoint":param1,
            "useGoodsType":0,
            "useFlag":0
         };
         doNormal(tempObj.useBindPoint,tempObj.useGoodsType);
      }
      
      private function willUsedBindForNormal(param1:Boolean) : int
      {
         var _loc4_:Array = null;
         var _loc2_:int = 0;
         if(data && data.template && data.template.NeedGrade == 3)
         {
            _loc4_ = GoodsManager.instance.getBagGoodsByTemplateId(208045);
         }
         else
         {
            _loc4_ = GoodsManager.instance.getBagGoodsByTemplateId(208023);
         }
         var _loc3_:Boolean = false;
         for each(var _loc5_:GoodsInfo in _loc4_)
         {
            if(_loc5_.isBinds)
            {
               _loc3_ = true;
               break;
            }
         }
         if(_loc3_)
         {
            _loc2_ = 1;
         }
         if(param1 && PlayerManager.instance.currentPlayerModel.playerInfo.giftToken > 0)
         {
            _loc2_ = 2;
         }
         return _loc2_;
      }
      
      private function checkUseBindForNoraml(param1:int) : void
      {
         var _loc4_:TodayNotAlertFrame = null;
         var _loc3_:String = null;
         var _loc2_:String = null;
         tempObj.useFlag = param1;
         if(checkIsExpired(SharedManager.instance.petadvanceWillbeBindCheckDate1))
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert");
            if(param1 == 1)
            {
               _loc3_ = LanguageMgr.GetTranslation("GrowthInfoView.useBindGoodsTip");
               _loc4_.usebindPointTxt = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.useGood");
            }
            else
            {
               _loc3_ = LanguageMgr.GetTranslation("PetAdvancedView.useBindPointTip");
            }
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_.show(_loc3_,_loc2_,checkUseBindForNoramlBack,null,"center",2,true);
         }
         else
         {
            doNormal(tempObj.useBindPoint,SharedManager.instance.petadvanceWillbeBindCheck1);
         }
      }
      
      private function checkUseBindForNoramlBack(param1:Boolean, param2:Boolean) : void
      {
         if(!tempObj)
         {
            return;
         }
         if(tempObj.useFlag == 1 && !param2)
         {
            tempObj.useGoodsType = 2;
         }
         doNormal(tempObj.useBindPoint,tempObj.useGoodsType);
         if(param1)
         {
            SharedManager.instance.petadvanceWillbeBindCheckDate1 = new Date();
            SharedManager.instance.petadvanceWillbeBindCheck1 = tempObj.useGoodsType;
            SharedManager.instance.savePetadvanceWillbeBindCheck1();
         }
      }
      
      private function checkIsExpired(param1:Date) : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         if(param1)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == param1.fullYear && _loc2_.month == param1.month && _loc2_.date == param1.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      private function doNormal(param1:Boolean, param2:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(!data)
         {
            return;
         }
         if(param2 == 2)
         {
            param1 = false;
         }
         var _loc3_:int = getGoodsCount(param2);
         if(_loc3_ < 1)
         {
            _loc4_ = getOnceAdvancedCost();
            _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
            if(param1)
            {
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
            }
            if(_loc5_ < _loc4_)
            {
               RechargeAlertMannager.show();
               return;
            }
         }
         PetSocketOut.trainGrowthRate(data.petId,parseInt(_trainCountText.text),param1,param2);
      }
      
      private function __updateNumberHandler(param1:BagEvent) : void
      {
         _currNumberTxt.text = ownTrainNeed.toString();
         _trainCountText.text = "1";
      }
      
      private function get ownTrainNeed() : int
      {
         var _loc1_:int = 0;
         if(data.template.NeedGrade < 3)
         {
            _loc1_ = int(GoodsManager.instance.getGoodsNumByTempId(208023));
         }
         else if(data.template.NeedGrade == 3)
         {
            _loc1_ = int(GoodsManager.instance.getGoodsNumByTempId(208045));
         }
         return _loc1_;
      }
      
      private function get needItemName() : String
      {
         if(_data.template.NeedGrade >= 3)
         {
            return LanguageMgr.GetTranslation("PetAdvancedView.firstShenghunShi02");
         }
         return LanguageMgr.GetTranslation("PetAdvancedView.firstShenghunShi01");
      }
      
      private function __playerInfoUpdateHandler(param1:PlayerEvent) : void
      {
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_data && _data == param1)
         {
            _canPlayMovie = true;
            _loc4_ = calcTotalExp(_lastGrade,_lastGp);
            _loc2_ = calcTotalExp(param1.quality,param1.qualityGp);
            _loc3_ = _loc2_ - _loc4_;
            if(_loc3_ != 0)
            {
               _isCrit = _loc3_ > 10 * parseInt(_trainCountText.text);
               _critValue = _loc3_;
               _isUpgrade = _lastGrade != _data.quality;
            }
            else
            {
               _canPlayMovie = false;
               _isCrit = false;
            }
         }
         else
         {
            _canPlayMovie = false;
            _isCrit = false;
            _lastGp = 0;
            _lastGrade = 0;
         }
         _data = param1;
         if(_data)
         {
            refresh();
         }
         else
         {
            restore();
         }
      }
      
      private function calcTotalExp(param1:int, param2:int) : int
      {
         var _loc5_:int = 0;
         var _loc3_:Array = PetData.qualityUpgradeTemplates[data.template.NeedGrade];
         var _loc4_:int = param2;
         _loc5_ = 0;
         while(_loc5_ < param1)
         {
            if(_loc5_ < _loc3_.length)
            {
               _loc4_ += int(_loc3_[_loc5_].Data);
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function refresh() : void
      {
         var _loc14_:GoodsTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc13_:PetTemplate = null;
         var _loc8_:int = 0;
         var _loc12_:int = 0;
         var _loc2_:PetTemplate = null;
         var _loc16_:int = 0;
         var _loc10_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc15_:int = 0;
         var _loc4_:int = 0;
         var _loc19_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         _goodsIcon.visible = true;
         if(data.template.NeedGrade == 3)
         {
            _goodsIcon.setFrame(2);
            _loc14_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208045);
            if(_loc14_)
            {
               _goodsIcon.tipData = _loc14_.TemplateName;
            }
            _normalBtn.tipData = LanguageMgr.GetTranslation("PetAdvancedView.normalTip02",onceCost);
         }
         else
         {
            _goodsIcon.setFrame(1);
            _loc14_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208023);
            if(_loc14_)
            {
               _goodsIcon.tipData = _loc14_.TemplateName;
            }
            _normalBtn.tipData = LanguageMgr.GetTranslation("PetAdvancedView.normalTip",onceCost);
         }
         _petNameTxt.text = _data.name;
         _petNameTxt.setFrame(_data.quality);
         var _loc11_:UpgradeTemplateInfo = _data.currentQualityUpgradeTemplateInfo;
         var _loc1_:UpgradeTemplateInfo = _data.qualityUpgradeTemplateInfo;
         _fullAttrView.frame = _data.quality;
         if(_loc1_ && _loc11_)
         {
            _oldAttrView.visible = true;
            _newAttrView.visible = true;
            _fullAttrView.visible = false;
            _oldAttrView.frame = _data.quality;
            _newAttrView.frame = PetData.tempToQuality(_data.temQuality + 1);
            _loc5_ = _data.temQuality + 1;
            _loc13_ = _data.template;
            _loc8_ = _loc1_.TemplateId - _loc11_.TemplateId;
            _loc12_ = Math.floor(_loc8_ * 0.1);
            _oldAttrView.data = [_data.growthRate.toString(),toArialBold(_data.coeStrength + " / " + _data.coeStrengthLimit),toArialBold(_data.coeArmor + " / " + _data.coeArmorLimit),toArialBold(_data.coeIntellect + " / " + _data.coeIntellectLimit),toArialBold(_data.coeStamina + " / " + _data.coeStaminaLimit)];
            _loc2_ = _data.template;
            _loc16_ = int(_loc2_.TemplateId);
            _loc10_ = int(PetData.calculateCoeLimit(_loc2_,_loc5_,"PowerCoeLimit"));
            _loc6_ = int(PetData.calculateCoeLimit(_loc2_,_loc5_,"ArmorCoeLimit"));
            _loc3_ = int(PetData.calculateCoeLimit(_loc2_,_loc5_,"IntelCoeLimit"));
            _loc15_ = int(PetData.calculateCoeLimit(_loc2_,_loc5_,"PhysiCoeLimit"));
            _loc4_ = int(PetData.calculateCoeLimitMin(_data.coeStrength,_loc2_,_loc5_,"CoeStrength"));
            _loc19_ = int(PetData.calculateCoeLimitMin(_data.coeArmor,_loc2_,_loc5_,"CoeArmor"));
            _loc9_ = int(PetData.calculateCoeLimitMin(_data.coeIntellect,_loc2_,_loc5_,"CoeIntellect"));
            _loc7_ = int(PetData.calculateCoeLimitMin(_data.coeStamina,_loc2_,_loc5_,"CoeStamina"));
            _newAttrView.data = [_data.getGrowthRate(_loc5_).toString(),toArialBold(_loc4_ + " / " + _loc10_),toArialBold(_loc19_ + " / " + _loc6_),toArialBold(_loc9_ + " / " + _loc3_),toArialBold(_loc7_ + " / " + _loc15_)];
         }
         else
         {
            _oldAttrView.visible = false;
            _newAttrView.visible = false;
            _fullAttrView.visible = true;
            _fullAttrView.data = [_data.growthRate.toString(),toArialBold(_data.coeStrength + " / " + _data.coeStrengthLimit),toArialBold(_data.coeArmor + " / " + _data.coeArmorLimit),toArialBold(_data.coeIntellect + " / " + _data.coeIntellectLimit),toArialBold(_data.coeStamina + " / " + _data.coeStaminaLimit)];
         }
         var _loc20_:int = 0;
         var _loc17_:String = "";
         if(_hBox1)
         {
            _hBox1.removeAllChild();
         }
         if(_hBox2)
         {
            _hBox2.removeAllChild();
         }
         if(_loc1_)
         {
            _loc20_ = Math.floor(_data.qualityGp) / _loc1_.Data * 100;
            _loc17_ = _data.qualityGp + " / " + _loc1_.Data;
            _blessBar.tipData = _loc17_;
            _blessPrecentTxt.text = _data.qualityGp + " / " + _loc1_.Data;
            creatHBoxDivisionImg(_data.temQuality,1);
            if(_data.temQuality == 20 && _data.template.NeedGrade < 3 || _data.temQuality == 30 && _data.template.NeedGrade == 3)
            {
               _currMaxMesTxt.text = LanguageMgr.GetTranslation("pet.advanced.PetAdvancedView.currMaxMes");
               _currMaxMesTxt.x = 345;
            }
            else
            {
               creatHBoxDivisionImg(_data.temQuality + 1,2);
            }
            _hBox1.x = 132;
            _back.setFrame(1);
         }
         else
         {
            _blessBar.tipData = LanguageMgr.GetTranslation("PetAdvancedView.MaxQuality");
            _blessPrecentTxt.text = "MAX";
            _hBox1.x = 190;
            _currMaxMesTxt.text = LanguageMgr.GetTranslation("pet.advanced.PetAdvancedView.currMaxMes");
            _currMaxMesTxt.x = 222;
            _loc20_ = 100;
            _back.setFrame(2);
         }
         if(_isUpgrade)
         {
            _upgradeMc.visible = true;
            _upgradeMc.gotoAndPlay(1);
            _isUpgrade = false;
         }
         _lastGrade = _data.quality;
         _lastGp = _data.qualityGp;
         if(_canPlayMovie)
         {
            playMovieClip(_loc20_,_isCrit,_critValue);
            _isCrit = false;
            _critValue = 0;
         }
         else
         {
            _blessBar.setFrame(_loc20_);
         }
         __updateNumberHandler(null);
         var _loc18_:String = IconFactory.getPetHeadSmallIcon(_data.templateId);
         if(_petHeadIcon.icon != _loc18_)
         {
            _petHeadIcon.icon = _loc18_;
         }
         _petHeadIcon.tipData = _data;
         fightChange(_data.fightPower);
      }
      
      private function creatHBoxDivisionImg(param1:int, param2:int) : void
      {
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc7_:int = 0;
         var _loc10_:Bitmap = null;
         var _loc8_:int = 0;
         var _loc4_:Bitmap = null;
         var _loc9_:int = 0;
         var _loc6_:Bitmap = null;
         _currMaxMesTxt.text = "";
         if(param1 % 5 == 0)
         {
            if(param1 == 30)
            {
               _loc3_ = "asset.pet.bigMoonLightLevelImg";
            }
            else
            {
               _loc3_ = "asset.pet.StarLevelLightImg";
            }
            _loc7_ = 0;
            while(_loc7_ < 5)
            {
               _loc10_ = ComponentFactory.Instance.creatBitmap(_loc3_);
               if(param2 == 1)
               {
                  _hBox1.addChild(_loc10_);
               }
               if(param2 == 2)
               {
                  _hBox2.addChild(_loc10_);
               }
               _loc7_++;
            }
         }
         else
         {
            if(param1 >= 26)
            {
               _loc3_ = "asset.pet.bigMoonLightLevelImg";
               _loc5_ = "asset.pet.bigMoonDarkLevelImg";
            }
            else
            {
               _loc3_ = "asset.pet.StarLevelLightImg";
               _loc5_ = "asset.pet.StarLevelDarkImg";
            }
            _loc8_ = 0;
            while(_loc8_ < param1 % 5)
            {
               _loc4_ = ComponentFactory.Instance.creatBitmap(_loc3_);
               if(param2 == 1)
               {
                  _hBox1.addChild(_loc4_);
               }
               if(param2 == 2)
               {
                  _hBox2.addChild(_loc4_);
               }
               _loc8_++;
            }
            _loc9_ = 0;
            while(_loc9_ < 5 - param1 % 5)
            {
               _loc6_ = ComponentFactory.Instance.creatBitmap(_loc5_);
               if(param2 == 1)
               {
                  _hBox1.addChild(_loc6_);
               }
               if(param2 == 2)
               {
                  _hBox2.addChild(_loc6_);
               }
               _loc9_++;
            }
         }
      }
      
      private function toArialBold(param1:String) : String
      {
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
      
      public function playMovieClip(param1:int, param2:Boolean, param3:int = 0) : void
      {
         killTween();
         if(_timerId != 0)
         {
            clearTimeout(_timerId);
         }
         _timerId = 0;
         if(param1 == 100 && param1 == _blessBar.movie.currentFrame)
         {
            return;
         }
         if(_lastFrame != -1)
         {
            _blessBar.setFrame(_lastFrame);
            _lastFrame = param1;
         }
         var _loc5_:Number = 213 * param1 / 100;
         var _loc4_:MovieClip = _blessBar.movie;
         var _loc6_:MovieClip = _loc4_["flicker"] as MovieClip;
         var _loc7_:MovieClip = _loc6_["light"] as MovieClip;
         _blessBar.addChild(_loc4_);
         if(_priticeMc.parent)
         {
            _priticeMc.parent.removeChild(_priticeMc);
         }
         if(_critMc.parent)
         {
            _critMc.parent.removeChild(_critMc);
         }
         if(_lightMc.parent)
         {
            _lightMc.parent.removeChild(_lightMc);
         }
         if(_loc4_["pos"])
         {
            if(param2)
            {
               _loc4_["pos"].addChild(_priticeMc);
               _loc4_["pos"].addChild(_critMc);
            }
            else
            {
               _loc4_["pos"].addChild(_lightMc);
            }
         }
         _lightMc.gotoAndStop(1);
         _loc6_.gotoAndStop(1);
         _critMc.gotoAndStop(1);
         _critMc["numberContainer"]["con"].addChild(_numContainer);
         _critMc.visible = false;
         _priticeMc.gotoAndStop(1);
         _priticeMc.visible = false;
         _loc7_.visible = false;
         _loc7_.x = -40;
         _loc7_.alpha = 1;
         ObjectUtils.disposeAllChildren(_numContainer);
         if(param2)
         {
            NumberViewUtils.refreshValue(param3,_numContainer,_critNumBitmapData,32,32,20,29,"0123456789");
            _loc6_.gotoAndPlay(1);
            _loc7_.visible = true;
            _currentTimeLine = new TimelineMax({"onComplete":playCritMc});
            _currentTimeLine.append(TweenMax.to(_loc4_,0.4,{"frame":param1}));
            _currentTimeLine.append(TweenMax.to(_loc7_,0.4,{"x":_loc5_}),-0.4);
            _currentTimeLine.append(TweenMax.to(_loc7_,0.2,{"alpha":0}),-0.2);
         }
         else
         {
            _currentTimeLine = new TimelineMax({"onComplete":removeLightMc});
            if(param1 < _blessBar.movie.currentFrame)
            {
               _currentTimeLine.append(TweenMax.to(_loc4_,0.2,{"frame":100}));
               _currentTimeLine.append(TweenMax.fromTo(_loc4_,0.2,{"frame":1},{"frame":param1}));
            }
            else
            {
               _currentTimeLine.append(TweenMax.to(_loc4_,0.4,{"frame":param1}));
            }
            _lightMc.play();
         }
         _currentTimeLine.play();
      }
      
      private function playParticeMc() : void
      {
         killTween();
         if(_priticeMc)
         {
            _priticeMc.visible = true;
            _priticeMc.gotoAndPlay(1);
         }
      }
      
      private function playCritMc() : void
      {
         killTween();
         playParticeMc();
         if(_critMc)
         {
            _critMc.visible = true;
            _critMc.gotoAndPlay(1);
         }
      }
      
      private function removeLightMc() : void
      {
         killTween();
         if(_lightMc && _lightMc.parent)
         {
            _lightMc.gotoAndStop(1);
            _lightMc.parent.removeChild(_lightMc);
         }
      }
      
      private function killTween() : void
      {
         if(_currentTimeLine)
         {
            _currentTimeLine.kill();
            _currentTimeLine = null;
         }
      }
      
      private function getGoodsCount(param1:int = 0) : int
      {
         var _loc2_:Array = null;
         if(data && data.template && data.template.NeedGrade == 3)
         {
            _loc2_ = GoodsManager.instance.getBagGoodsByTemplateId(208045);
         }
         else
         {
            _loc2_ = GoodsManager.instance.getBagGoodsByTemplateId(208023);
         }
         var _loc3_:int = 0;
         for each(var _loc4_:GoodsInfo in _loc2_)
         {
            if(param1 == 0)
            {
               _loc3_ += _loc4_.count;
            }
            else if(param1 == 1 && Boolean(_loc4_.isBinds))
            {
               _loc3_ += _loc4_.count;
            }
            else if(param1 == 2 && !_loc4_.isBinds)
            {
               _loc3_ += _loc4_.count;
            }
         }
         return _loc3_;
      }
      
      public function restore() : void
      {
         _petNameTxt.text = "";
         _oldAttrView.data = null;
         _newAttrView.data = null;
         _fullAttrView.data = null;
         _petHeadIcon.icon = null;
         _petHeadIcon.tipData = null;
         _blessBar.setFrame(1);
         _blessPrecentTxt.text = "";
         _goodsIcon.visible = false;
      }
      
      public function show() : void
      {
         this.visible = true;
         addEvent();
      }
      
      public function hide() : void
      {
         this.visible = false;
         removeEvent();
      }
      
      public function fightChange(param1:int) : void
      {
         if(_petFight == param1)
         {
            return;
         }
         if(!_playFightMc)
         {
            _fightMc.gotoAndStop(24);
            NumberViewUtils.refreshValue(param1,_fightMc["new_power"],_fightCapacityNumBD,19,25,15,19,"0123456789");
            _petFight = param1;
            _playFightMc = true;
            return;
         }
         if(_petFight > 0)
         {
            NumberViewUtils.refreshValue(_petFight,_fightMc["old_power"],_fightCapacityNumBD,19,25,15,19,"0123456789");
         }
         NumberViewUtils.refreshValue(param1,_fightMc["new_power"],_fightCapacityNumBD,19,25,15,19,"0123456789");
         _fightMc["shine1"].x = _fightMc["shine2"].x = _fightMc["new_power"].width / 2;
         _fightMc.gotoAndPlay(1);
         _petFight = param1;
      }
      
      override public function dispose() : void
      {
         killTween();
         if(_timerId != 0)
         {
            clearTimeout(_timerId);
         }
         _timerId = 0;
         removeEvent();
         uintView();
         _playerInfo = null;
         super.dispose();
         _data = null;
      }
   }
}

