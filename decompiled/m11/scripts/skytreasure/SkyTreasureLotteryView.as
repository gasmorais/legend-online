package skytreasure
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import events.SkyTreasureEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import funny.mountact.MountsAvatarView;
   import manager.LanguageMgr;
   import mvc.module.skytreasure.SkyTreasureActTemplateInfo;
   import mvc.module.skytreasure.SkyTreasureLotteryDataInfo;
   import mvc.module.skytreasure.SkyTreasureModelNew;
   import skytreasure.item.SkyTreasureLoRankItmem;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.SkyTreasureManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.ThaneEquipShowHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class SkyTreasureLotteryView extends Component
   {
      
      private var _index:int = 1;
      
      private var lotteryCount:int = 1;
      
      private var _waitMcPath:String;
      
      private var _showAvatar:ShowAvatar;
      
      private var result:ThaneInfo = new ThaneInfo();
      
      private var _isLoading:Boolean = false;
      
      private var _mc:MovieClip;
      
      private var _mount:MountsAvatarView;
      
      private var _lotteryBtn1:TextButton;
      
      private var _lotteryBtn10:TextButton;
      
      private var _lotteryBtn50:TextButton;
      
      private var _rankRewardBtn:TextButton;
      
      private var _lotteryRecordBtn:TextButton;
      
      private var _probabilityBtn:TextButton;
      
      private var _currentActId:String = "";
      
      private var _currentActInfo:SkyTreasureActTemplateInfo;
      
      private var _name:GradientText;
      
      private var _time:GradientText;
      
      private var _nine:Bitmap;
      
      protected var _FrameBack:Bitmap;
      
      protected var _icon1:ScaleFrameImage;
      
      protected var _alliconNum:FilterFrameText;
      
      protected var _icon2:ScaleFrameImage;
      
      protected var _cost1Num:FilterFrameText;
      
      protected var _icon3:ScaleFrameImage;
      
      protected var _cost10Num:FilterFrameText;
      
      protected var _icon4:ScaleFrameImage;
      
      protected var _cost50Num:FilterFrameText;
      
      protected var _LotteryNum:Bitmap;
      
      protected var _cost1freeTime:FilterFrameText;
      
      protected var _actTime:FilterFrameText;
      
      protected var _RankTime:FilterFrameText;
      
      protected var _MyRank:FilterFrameText;
      
      protected var _MyCoin:FilterFrameText;
      
      protected var _MyRankName:FilterFrameText;
      
      protected var _MyCoinName:FilterFrameText;
      
      protected var _coinNum:ScaleLeftRightImage;
      
      public var _tabVbox:HBox;
      
      public var _btnList:SelectedButtonGroup;
      
      protected var _paihangbangbg:Bitmap;
      
      protected var _tankRank:FilterFrameText;
      
      protected var _RanKName:FilterFrameText;
      
      protected var _tankcoin:FilterFrameText;
      
      private var _showInfoPanel:ScrollPanel;
      
      private var _showVBox:VBox;
      
      private var _timer:Timer;
      
      private var _timer1:Timer;
      
      private var _timer2:Timer;
      
      protected var _redbox1:Bitmap;
      
      protected var _redbox10:Bitmap;
      
      protected var _redbox50:Bitmap;
      
      public function SkyTreasureLotteryView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _paihangbangbg = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.paihangbangbg");
         _name = ComponentFactory.Instance.creatComponentByStylename("skytreasure.Lo.bossNameTxt1");
         _time = ComponentFactory.Instance.creatComponentByStylename("skytreasure.Lo.TimeTxt1");
         _nine = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.9btn");
         _FrameBack = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.FrameBack");
         _coinNum = ComponentFactory.Instance.creatComponentByStylename("skytreasure.rank.textBg");
         _icon1 = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.icon1");
         _alliconNum = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.alliconNum");
         _icon2 = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.icon2");
         _cost1Num = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.cost1Num");
         _icon3 = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.icon3");
         _cost10Num = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.cost10Num");
         _icon4 = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.icon4");
         _cost50Num = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.cost50Num");
         _LotteryNum = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.LotteryNum");
         _cost1freeTime = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.cost1freeTime");
         _actTime = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.actTime");
         _RankTime = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.RankTime");
         _MyRank = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.MyRank");
         _MyCoin = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.MyCoin");
         _MyRankName = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.MyRankName");
         _MyCoinName = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.MyCoinName");
         _tankRank = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.tankRank");
         _RanKName = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.RanKName");
         _tankcoin = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.tankcoin");
         _tabVbox = ComponentFactory.Instance.creatCustomObject("skyTreasure.otherHbox");
         _MyRankName.text = LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle2");
         _MyCoinName.text = LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle3");
         _redbox1 = ComponentFactory.Instance.creatBitmap("asset.sky.red");
         _redbox10 = ComponentFactory.Instance.creatBitmap("asset.sky.red");
         _redbox50 = ComponentFactory.Instance.creatBitmap("asset.sky.red");
         addChild(_FrameBack);
         addChild(_paihangbangbg);
         addChild(_tabVbox);
         _tabVbox.x = 520;
         addChild(_coinNum);
         addChild(_icon1);
         addChild(_alliconNum);
         addChild(_icon2);
         addChild(_cost1Num);
         addChild(_icon3);
         addChild(_cost10Num);
         addChild(_icon4);
         addChild(_cost50Num);
         addChild(_LotteryNum);
         addChild(_cost1freeTime);
         addChild(_actTime);
         addChild(_RankTime);
         addChild(_MyRank);
         addChild(_MyCoin);
         addChild(_MyRankName);
         addChild(_MyCoinName);
         addChild(_time);
         _lotteryBtn1 = ComponentFactory.Instance.creatComponentByStylename("skyTreasure.LotteryBtn1");
         _lotteryBtn10 = ComponentFactory.Instance.creatComponentByStylename("skyTreasure.LotteryBtn10");
         _lotteryBtn50 = ComponentFactory.Instance.creatComponentByStylename("skyTreasure.LotteryBtn50");
         _rankRewardBtn = ComponentFactory.Instance.creatComponentByStylename("skyTreasure.RankRewardBtn");
         _lotteryRecordBtn = ComponentFactory.Instance.creatComponentByStylename("skyTreasure.LotteryRecordBtn");
         _probabilityBtn = ComponentFactory.Instance.creatComponentByStylename("skyTreasure.ProbabilityBtn");
         addChild(_lotteryBtn1);
         addChild(_lotteryBtn10);
         addChild(_lotteryBtn50);
         addChild(_nine);
         _nine.x = 465;
         _nine.y = 400;
         addChild(_redbox1);
         _redbox1.x = 130;
         _redbox1.y = _redbox10.y = _redbox50.y = 400;
         addChild(_redbox10);
         _redbox10.x = 300;
         addChild(_redbox50);
         _redbox50.x = 490;
         addChild(_rankRewardBtn);
         addChild(_lotteryRecordBtn);
         addChild(_probabilityBtn);
         addChild(_tankRank);
         addChild(_RanKName);
         addChild(_tankcoin);
         _lotteryBtn1.text = LanguageMgr.GetTranslation("skyTreasure.lotteryBtn1");
         _lotteryBtn10.text = LanguageMgr.GetTranslation("skyTreasure.lotteryBtn10");
         _lotteryBtn50.text = LanguageMgr.GetTranslation("skyTreasure.lotteryBtn50");
         _tankRank.text = LanguageMgr.GetTranslation("SkyTreasureCoinRankFrame.tabTxt1");
         _RanKName.text = LanguageMgr.GetTranslation("SkyTreasureCoinRankFrame.tabTxt2");
         _tankcoin.text = LanguageMgr.GetTranslation("SkyTreasureCoinRankFrame.tabTxt3");
         _rankRewardBtn.text = LanguageMgr.GetTranslation("skyTreasure.rankRewardBtn");
         _lotteryRecordBtn.text = LanguageMgr.GetTranslation("skyTreasure.lotteryRecordBtn");
         _probabilityBtn.text = LanguageMgr.GetTranslation("skyTreasure.probabilityBtn");
         _showVBox = ComponentFactory.Instance.creatComponentByStylename("SkyTreasuremainRankView.panelvBox");
         _showAvatar = ComponentFactory.Instance.creatCustomObject("view.ShowAvatar");
         addChild(_showAvatar);
         _showAvatar.y = 50;
         _showAvatar.x = 160;
         _showAvatar.scaleX = 0.75;
         _showAvatar.scaleY = 0.75;
         _showInfoPanel = ComponentFactory.Instance.creatComponentByStylename("SkyTreasuremainRankView.panel");
         addChild(_showInfoPanel);
         _showInfoPanel.setView(_showVBox);
         addChild(_name);
         initData();
      }
      
      private function get model() : SkyTreasureModelNew
      {
         return SkyTreasureManager.Instance.modelNew;
      }
      
      private function __onTabClick(param1:Event) : void
      {
         _index = param1.currentTarget.selectIndex + 1;
         refreshShowInfo();
      }
      
      public function refreshShowInfo(param1:SkyTreasureEvent = null) : void
      {
         var _loc3_:SkyTreasureLoRankItmem = null;
         var _loc2_:int = 0;
         _showVBox.removeAllChild();
         _showVBox.disposeAllChildren();
         if(_index == 1)
         {
            _MyRank.text = model.roundRankInfo ? model.roundRankInfo.myRank + "" : LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle10");
            _MyCoin.text = model.roundRankInfo ? model.roundRankInfo.myGrade + "" : "0";
            if(!model.roundRankInfo)
            {
               _showVBox.commitChanges();
               _showInfoPanel.invalidateViewport(true);
               return;
            }
            _loc2_ = 0;
            while(_loc2_ < model.roundRankInfo.skyTreasureGradeRankArray.length)
            {
               _loc3_ = new SkyTreasureLoRankItmem();
               _loc3_.data = model.roundRankInfo.getOneGradeInfoByRank(model.roundRankInfo.skyTreasureGradeRankArray[_loc2_]);
               _loc3_.y = _loc2_ * (_loc3_.height + 5);
               _showVBox.addChild(_loc3_);
               _loc2_++;
            }
            _MyRank.text = model.roundRankInfo.myRank != 0 ? model.roundRankInfo.myRank + "" : LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle10");
         }
         else
         {
            _MyCoin.text = model.totalRankInfo ? model.totalRankInfo.myGrade + "" : "0";
            _MyRank.text = model.totalRankInfo ? model.totalRankInfo.myRank + "" : LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle10");
            if(!model.totalRankInfo)
            {
               _showVBox.commitChanges();
               _showInfoPanel.invalidateViewport(true);
               return;
            }
            _loc2_ = 0;
            while(_loc2_ < model.totalRankInfo.skyTreasureGradeRankArray.length)
            {
               _loc3_ = new SkyTreasureLoRankItmem();
               _loc3_.data = model.totalRankInfo.getOneGradeInfoByRank(model.totalRankInfo.skyTreasureGradeRankArray[_loc2_]);
               _loc3_.y = _loc2_ * (_loc3_.height + 5);
               _showVBox.addChild(_loc3_);
               _loc2_++;
            }
            _MyCoin.text = model.totalRankInfo.myGrade + "";
            _MyRank.text = model.totalRankInfo.myRank != 0 ? model.totalRankInfo.myRank + "" : LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle10");
         }
         _showVBox.commitChanges();
         _showInfoPanel.invalidateViewport(true);
         _showInfoPanel.scrollToTop();
      }
      
      private function initEvent() : void
      {
         _btnList.addEventListener("change",__onTabClick);
         _lotteryBtn1.addEventListener("click",__onLotteryClick);
         _lotteryBtn10.addEventListener("click",__onLotteryClick);
         _lotteryBtn50.addEventListener("click",__onLotteryClick);
         _rankRewardBtn.addEventListener("click",__onReferenceClick);
         _lotteryRecordBtn.addEventListener("click",__onReferenceClick);
         _probabilityBtn.addEventListener("click",__onReferenceClick);
         SkyTreasureManager.Instance.addEventListener("SKY_TREASURE_LOTTERYINFO_UPDATE",__onLotteryResult);
         SkyTreasureManager.Instance.addEventListener("SKY_TREASURE_LOTTERYRECORD_UPDATE",__onLotteryRecordUpdate);
         SkyTreasureManager.Instance.addEventListener("SKY_TREASURE_RANKINFO_UPDATE",refreshShowInfo);
      }
      
      private function initData() : void
      {
         var _loc4_:SelectedTextButton = null;
         var _loc3_:int = 0;
         _btnList = new SelectedButtonGroup();
         var _loc1_:Array = [LanguageMgr.GetTranslation("SkyTreasureCoinRankFrame.tab6"),LanguageMgr.GetTranslation("SkyTreasureCoinRankFrame.tab7")];
         var _loc2_:int = int(_loc1_ ? _loc1_.length : 0);
         _tabVbox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("SkyTreasureCoinRankFrame.Btn");
            _loc4_.text = _loc1_[_loc3_];
            _loc4_.x = _loc3_ * (_loc4_.width + 20);
            _tabVbox.addChild(_loc4_);
            _btnList.addSelectItem(_loc4_);
            _loc3_++;
         }
         _tabVbox.y = 15;
         _tabVbox.commitChanges();
         _btnList.selectIndex = 0;
      }
      
      private function removeEvent() : void
      {
         _btnList.removeEventListener("change",__onTabClick);
         _lotteryBtn1.removeEventListener("click",__onLotteryClick);
         _lotteryBtn10.removeEventListener("click",__onLotteryClick);
         _lotteryBtn50.removeEventListener("click",__onLotteryClick);
         _rankRewardBtn.removeEventListener("click",__onReferenceClick);
         _lotteryRecordBtn.removeEventListener("click",__onReferenceClick);
         _probabilityBtn.removeEventListener("click",__onReferenceClick);
         SkyTreasureManager.Instance.removeEventListener("SKY_TREASURE_LOTTERYINFO_UPDATE",__onLotteryResult);
         SkyTreasureManager.Instance.removeEventListener("SKY_TREASURE_LOTTERYRECORD_UPDATE",__onLotteryRecordUpdate);
         SkyTreasureManager.Instance.removeEventListener("SKY_TREASURE_RANKINFO_UPDATE",refreshShowInfo);
         SkyTreasureManager.Instance.removeEventListener("SKY_TREASURE_LOTTERYINFO_UPDATE",__onLotteryResult);
      }
      
      public function setCurrentActId(param1:SkyTreasureActTemplateInfo) : void
      {
         _currentActInfo = param1;
         updateRewards(_currentActInfo);
      }
      
      private function __onLotteryClick(param1:MouseEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:SkyTreasureLotteryDataInfo = null;
         var _loc7_:Number = NaN;
         var _loc9_:int = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_currentActInfo.actParam1));
         _loc6_ = int(_currentActInfo.actParam2);
         lotteryCount = 1;
         if(param1.target == _lotteryBtn10)
         {
            lotteryCount = 10;
            _loc6_ = _currentActInfo.actParam2 * (lotteryCount - _loc9_);
         }
         if(param1.target == _lotteryBtn50)
         {
            lotteryCount = 50;
            _loc6_ = _currentActInfo.actParam2 * (45 - _loc9_);
         }
         var _loc8_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc2_:String = LanguageMgr.GetTranslation("SkyTreasureExchangeLimitType.LimitTotalNum.content2",_loc6_);
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         if(param1.target != _lotteryBtn50 && _loc9_ < lotteryCount || param1.target == _lotteryBtn50 && _loc9_ < 45)
         {
            if(param1.target != _lotteryBtn1)
            {
               SimpleAlertHelper.instance.data = [openAlertBack];
               SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc2_,_loc3_,_loc4_,true);
               return;
            }
            _loc5_ = model.findSkyTreasureLotteryDataInfo(_currentActInfo.actId);
            _loc7_ = Number(_loc5_.freeLotteryLeftTimes);
            if(_loc7_ > 0)
            {
               SimpleAlertHelper.instance.data = [openAlertBack];
               SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc2_,_loc3_,_loc4_,true);
               return;
            }
         }
         if(!_currentActInfo)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("skyTreasure.noActivity"));
            return;
         }
         SkyTreasureManager.Instance.sendSkyTreasureLotteryReq(_currentActId,lotteryCount);
      }
      
      private function openAlertBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SkyTreasureManager.Instance.sendSkyTreasureLotteryReq(_currentActId,lotteryCount);
         }
      }
      
      private function __onReferenceClick(param1:MouseEvent) : void
      {
         if(param1.target == _rankRewardBtn)
         {
            FrameControllerManager.instance.openControllerByInfo("skytreasure1",3);
         }
         else if(param1.target == _lotteryRecordBtn)
         {
            FrameControllerManager.instance.openControllerByInfo("skytreasure1",4,_currentActInfo);
         }
         else if(param1.target == _probabilityBtn)
         {
            FrameControllerManager.instance.openControllerByInfo("skytreasure1",2,_currentActInfo);
         }
      }
      
      private function __onLotteryResult(param1:SkyTreasureEvent) : void
      {
         updateRewards(_currentActInfo);
         SkyTreasureManager.Instance.sendSkyTreasureLotteryRecordReq(_currentActId);
      }
      
      private function __onLotteryRecordUpdate(param1:SkyTreasureEvent) : void
      {
         updateRewards(_currentActInfo);
      }
      
      public function updateRewards(param1:SkyTreasureActTemplateInfo) : void
      {
         var _loc5_:GoodsTemplateInfo = null;
         var _loc3_:int = 0;
         var _loc4_:SkyTreasureModelNew = SkyTreasureManager.Instance.modelNew;
         if(!param1)
         {
            return;
         }
         _currentActInfo = param1;
         _currentActId = param1.actId;
         _name.text = param1.actParam5;
         _cost1Num.text = "1";
         _cost10Num.text = "10";
         _cost50Num.text = "45";
         _cost1freeTime.text = "";
         var _loc6_:int = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(param1.actParam1));
         _alliconNum.text = _loc6_ + "";
         _loc3_ = 0;
         while(_loc3_ < param1.lotteryRatePoolInfoArray.length)
         {
            if(param1.lotteryRatePoolInfoArray[_loc3_].templateType == 1)
            {
               _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.lotteryRatePoolInfoArray[_loc3_].templateId);
               if(_loc5_.SonType == 112 || _loc5_.SonType == 110 || _loc5_.SonType == 111 || _loc5_.SonType == 109)
               {
                  _showAvatar.data = createThaneInfo(_loc5_);
                  _showAvatar.visible = true;
                  if(_mount)
                  {
                     _mount.visible = false;
                  }
               }
               else
               {
                  if(!_mount)
                  {
                     _mount = new MountsAvatarView();
                     addChildAt(_mount,1);
                  }
                  _mount.visible = true;
                  _showAvatar.visible = false;
                  _mount.data = TempleteManager.instance.mountTemplateDic[_loc5_.Property1];
                  _mount.scaleX = _mount.scaleY = 0.75;
                  _mount.x = 270;
                  _mount.y = 240;
               }
            }
            _loc3_++;
         }
         _redbox10.visible = _loc6_ >= 10;
         _redbox50.visible = _loc6_ >= 45;
         var _loc2_:SkyTreasureLotteryDataInfo = _loc4_.findSkyTreasureLotteryDataInfo(_currentActInfo.actId);
         if(_loc2_)
         {
            updateRecord(_loc2_);
            _redbox1.visible = _loc2_.freeLotteryLeftTimes == 0 || _loc6_ >= 1;
         }
         else
         {
            _time.text = param1.actParam4 + "";
         }
         timeHandler(null);
         timeHandler2(null);
      }
      
      private function get thaneInfo() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function createThaneInfo(param1:GoodsTemplateInfo) : ThaneInfo
      {
         var _loc3_:Dictionary = null;
         result.templateId = thaneInfo.templateId;
         _loc3_ = ArmyManager.instance.fashionList;
         var _loc6_:GoodsInfo = _loc3_[8];
         var _loc4_:GoodsInfo = _loc3_[9];
         var _loc7_:GoodsInfo = _loc3_[10];
         var _loc5_:GoodsInfo = _loc3_[11];
         var _loc2_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         if(_loc2_ && !_loc2_.isHidenWingAvata)
         {
            result.wingAvata = result.wingAvata ? result.wingAvata : ThaneEquipShowHelper.getAvatarByEquipInfo(_loc6_);
         }
         if(_loc2_ && !_loc2_.isHidenArmAvata)
         {
            result.armsFashionAvata = result.armsFashionAvata ? result.armsFashionAvata : ThaneEquipShowHelper.getAvatarByEquipInfo(_loc5_);
         }
         if(_loc2_ && !_loc2_.isHidenClothAvata)
         {
            result.bodyFashionAvata = result.bodyFashionAvata ? result.bodyFashionAvata : ThaneEquipShowHelper.getAvatarByEquipInfo(_loc7_);
         }
         if(_loc2_ && !_loc2_.isHidenHatAvat)
         {
            result.hairFashionAvata = result.hairFashionAvata ? result.hairFashionAvata : ThaneEquipShowHelper.getAvatarByEquipInfo(_loc4_);
         }
         switch(int(param1.SonType) - 109)
         {
            case 0:
               result.wingAvata = param1.Avata;
               break;
            case 1:
               result.hairFashionAvata = param1.Avata;
               break;
            case 2:
               result.armsFashionAvata = param1.Avata;
               break;
            case 3:
               result.bodyFashionAvata = param1.Avata;
         }
         return result;
      }
      
      private function timeHandler2(param1:TimerEvent) : void
      {
         var _loc2_:SkyTreasureActTemplateInfo = null;
         var _loc4_:String = null;
         if(_timer2 == null)
         {
            _timer2 = new Timer(1000);
            _timer2.addEventListener("timer",timeHandler2);
            _timer2.start();
         }
         if(_index == 1 && model.roundRankInfo)
         {
            _loc2_ = model.findSkyTreasureActTempInfoByActId(model.roundRankInfo.actId);
         }
         else if(model.totalRankInfo)
         {
            _loc2_ = model.findSkyTreasureActTempInfoByActId(model.totalRankInfo.actId);
         }
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Number = Number(_loc2_.actLeftTime);
         if(--_loc3_ > 0)
         {
            if(_loc3_ >= 60)
            {
               _RankTime.text = LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle5",DateFormatter.getFullTimeString(_loc3_));
            }
            else
            {
               _loc4_ = LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle5",LanguageMgr.GetTranslation("funny.groupbuy.buyRestTimeSecond",_loc3_));
               _RankTime.text = _loc4_;
            }
         }
         else
         {
            _timer2.stop();
            _timer2.removeEventListener("timer",timeHandler2);
            _timer2 = null;
            _RankTime.text = "";
         }
      }
      
      private function timeHandler(param1:TimerEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:Number = Number(_currentActInfo.actLeftTime);
         _loc2_--;
         if(_timer == null)
         {
            _timer = new Timer(1000);
            _timer.addEventListener("timer",timeHandler);
            _timer.start();
         }
         if(_loc2_ > 0)
         {
            if(_loc2_ >= 60)
            {
               _actTime.text = LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle4") + DateFormatter.getFullTimeString(_loc2_);
            }
            else
            {
               _loc3_ = LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle4") + LanguageMgr.GetTranslation("funny.groupbuy.buyRestTimeSecond",_loc2_);
               _actTime.text = _loc3_;
            }
         }
         else
         {
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
            _timer = null;
         }
      }
      
      private function updateRecord(param1:SkyTreasureLotteryDataInfo) : void
      {
         _time.text = param1.nextBigGiftTimes + "";
         _cost1freeTime.text = "";
         timeHandler1(null);
      }
      
      private function timeHandler1(param1:TimerEvent) : void
      {
         var _loc4_:String = null;
         if(_timer1 == null)
         {
            _timer1 = new Timer(1000);
            _timer1.addEventListener("timer",timeHandler1);
            _timer1.start();
         }
         var _loc2_:SkyTreasureLotteryDataInfo = model.findSkyTreasureLotteryDataInfo(_currentActInfo.actId);
         var _loc3_:Number = Number(_loc2_.freeLotteryLeftTimes);
         if(--_loc3_ > 0)
         {
            if(_loc3_ >= 60)
            {
               _cost1freeTime.text = LanguageMgr.GetTranslation("skyTreasure.lotteryfree",DateFormatter.getFullTimeString(_loc3_));
            }
            else
            {
               _loc4_ = LanguageMgr.GetTranslation("skyTreasure.lotteryfree",LanguageMgr.GetTranslation("funny.groupbuy.buyRestTimeSecond",_loc3_));
               _cost1freeTime.text = _loc4_;
            }
            _lotteryBtn1.text = LanguageMgr.GetTranslation("skyTreasure.lotteryBtn1");
         }
         else
         {
            _lotteryBtn1.text = LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle1");
            _timer1.stop();
            _timer1.removeEventListener("timer",timeHandler1);
            _timer1 = null;
            _cost1freeTime.text = "";
         }
      }
      
      private function clearMC() : void
      {
         if(_mc != null)
         {
            if(_mc.parent != null)
            {
               _mc.parent.removeChild(_mc);
            }
            _mc.stop();
            _mc = null;
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_lotteryBtn1);
         _lotteryBtn1 = null;
         ObjectUtils.disposeObject(_lotteryBtn10);
         _lotteryBtn10 = null;
         ObjectUtils.disposeObject(_lotteryBtn50);
         _lotteryBtn50 = null;
         ObjectUtils.disposeObject(_rankRewardBtn);
         _rankRewardBtn = null;
         ObjectUtils.disposeObject(_lotteryRecordBtn);
         _lotteryRecordBtn = null;
         ObjectUtils.disposeObject(_probabilityBtn);
         _probabilityBtn = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_time);
         _time = null;
         ObjectUtils.disposeObject(_nine);
         _nine = null;
         ObjectUtils.disposeObject(_coinNum);
         _coinNum = null;
         ObjectUtils.disposeObject(_tabVbox);
         _tabVbox = null;
         ObjectUtils.disposeObject(_btnList);
         _btnList = null;
         ObjectUtils.disposeObject(_showInfoPanel);
         _showInfoPanel = null;
         ObjectUtils.disposeObject(_showVBox);
         _showVBox = null;
         ObjectUtils.disposeObject(_redbox1);
         _redbox1 = null;
         ObjectUtils.disposeObject(_redbox10);
         _redbox10 = null;
         ObjectUtils.disposeObject(_redbox50);
         _redbox50 = null;
         ObjectUtils.disposeObject(_FrameBack);
         _FrameBack = null;
         ObjectUtils.disposeObject(_icon1);
         _icon1 = null;
         ObjectUtils.disposeObject(_alliconNum);
         _alliconNum = null;
         ObjectUtils.disposeObject(_icon2);
         _icon2 = null;
         ObjectUtils.disposeObject(_cost1Num);
         _cost1Num = null;
         ObjectUtils.disposeObject(_icon3);
         _icon3 = null;
         ObjectUtils.disposeObject(_cost10Num);
         _cost10Num = null;
         ObjectUtils.disposeObject(_icon4);
         _icon4 = null;
         ObjectUtils.disposeObject(_cost50Num);
         _cost50Num = null;
         ObjectUtils.disposeObject(_LotteryNum);
         _LotteryNum = null;
         ObjectUtils.disposeObject(_paihangbangbg);
         _paihangbangbg = null;
         ObjectUtils.disposeObject(_cost1freeTime);
         _cost1freeTime = null;
         ObjectUtils.disposeObject(_actTime);
         _actTime = null;
         ObjectUtils.disposeObject(_RankTime);
         _RankTime = null;
         ObjectUtils.disposeObject(_MyRank);
         _MyRank = null;
         ObjectUtils.disposeObject(_MyCoin);
         _MyCoin = null;
         ObjectUtils.disposeObject(_MyRankName);
         _MyRankName = null;
         ObjectUtils.disposeObject(_MyCoinName);
         _MyCoinName = null;
         ObjectUtils.disposeObject(_tankRank);
         _tankRank = null;
         ObjectUtils.disposeObject(_RanKName);
         _RanKName = null;
         ObjectUtils.disposeObject(_tankcoin);
         _tankcoin = null;
         ObjectUtils.disposeAllChildren(this);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
            _timer = null;
         }
         if(_timer1)
         {
            _timer1.stop();
            _timer1.removeEventListener("timer",timeHandler1);
            _timer1 = null;
         }
         if(_timer2)
         {
            _timer2.stop();
            _timer2.removeEventListener("timer",timeHandler2);
            _timer2 = null;
         }
         ObjectUtils.disposeObject(_mount);
         _mount = null;
         clearMC();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

