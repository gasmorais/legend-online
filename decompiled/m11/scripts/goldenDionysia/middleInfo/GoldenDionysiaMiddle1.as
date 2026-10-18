package goldenDionysia.middleInfo
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.cccactive.GoldCrazyMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoldenDionysiaManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class GoldenDionysiaMiddle1 extends Component implements Disposeable
   {
      
      private var _curPhase:int = -1;
      
      private var _cdBar:GoldenDionysiaCDBar;
      
      private var _dataBmp:Bitmap;
      
      private var _pondAnimationMc:MovieClip;
      
      private var _titleTxt:FilterFrameText;
      
      private var _dateTxt:FilterFrameText;
      
      private var _pondTitleBg:Bitmap;
      
      private var _curContain:Sprite;
      
      private var _curPondIcon:Image;
      
      private var _curPondTxt:MillionNumContainer;
      
      private var _helpImage:Image;
      
      private var _activatSignImage:ScaleFrameImage;
      
      private var _bg:Bitmap;
      
      private var _effectThresholdTxt:FilterFrameText;
      
      private var _effectIcon:Image;
      
      private var _myOrderNote:Bitmap;
      
      private var _myOrderTxt:FilterFrameText;
      
      private var _activeLinePoint:FilterFrameText;
      
      private var _activeLineNote:Bitmap;
      
      private var _myConsumNote:Bitmap;
      
      private var _myConsumPoint:FilterFrameText;
      
      private var _myConsumIcon:Image;
      
      private var _myConsumQualify:FilterFrameText;
      
      private var _description:FilterFrameText;
      
      private var _goldenMsg:GoldCrazyMsg;
      
      private var _prePoint:int = 2;
      
      private var _curPoint:int = 2;
      
      private var _tipsStrip1:StripView;
      
      private var _tipsStrip2:StripView;
      
      public function GoldenDionysiaMiddle1()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _cdBar = ComponentFactory.Instance.creatCustomObject("goldenDionysia.middleInfo.GoldenDionysiaCDBar");
         _dataBmp = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.lotteryTime");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaLotteryTime.title");
         _dateTxt = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaLotteryTime.date");
         _pondTitleBg = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.curPondNumTitle");
         _curPondIcon = ComponentFactory.Instance.creatComponentByStylename("goldenDionysia.VoucherBack");
         _curPondTxt = ComponentFactory.Instance.creatCustomObject("goldenDionysia.middleInfo.MillionNumContainer");
         _activatSignImage = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaEffectInfo.effectWord");
         _bg = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.effetTipBg");
         _helpImage = ComponentFactory.Instance.creatComponentByStylename("goldendionysia.activatedHelpImage");
         _pondAnimationMc = ComponentFactory.Instance.creatCustomObject("goldenDionysia.pondAnimation");
         _effectIcon = ComponentFactory.Instance.creatComponentByStylename("goldenDionysia.effectIcon");
         _effectThresholdTxt = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaFrame.effectThreshold");
         _myOrderNote = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.myOrderNote");
         _myOrderTxt = ComponentFactory.Instance.creatComponentByStylename("GoldenDionysiaMiddle1.myOrderTxt");
         _activeLinePoint = ComponentFactory.Instance.creatComponentByStylename("GoldenDionysiaMiddle1.activeLinePoint");
         _activeLineNote = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.LinePointNote");
         _myConsumNote = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.myConsumPoint");
         _myConsumPoint = ComponentFactory.Instance.creatComponentByStylename("GoldenDionysiaMiddle1.myConsumPoint");
         _myConsumIcon = ComponentFactory.Instance.creatComponentByStylename("goldenDionysia.myConsumIcon");
         _myConsumQualify = ComponentFactory.Instance.creatComponentByStylename("GoldenDionysiaMiddle1.qualifyNote");
         _description = ComponentFactory.Instance.creatComponentByStylename("GoldenDionysiaMiddle1.description");
         _tipsStrip1 = ComponentFactory.Instance.creatComponentByStylename("goldenDionysia.tipsStripView1");
         _tipsStrip2 = ComponentFactory.Instance.creatComponentByStylename("goldenDionysia.tipsStripView2");
         _curContain = new Sprite();
         _tipsStrip1.setHitArea(0,0,109,20);
         _tipsStrip2.setHitArea(0,0,170,40);
         addChild(_bg);
         addChild(_cdBar);
         _cdBar.x = 30;
         _cdBar.y = 6;
         addChild(_activatSignImage);
         addChild(_helpImage);
         addChild(_pondAnimationMc);
         addChild(_pondTitleBg);
         addChild(_curPondIcon);
         addChild(_curPondTxt);
         addChild(_dataBmp);
         addChild(_titleTxt);
         addChild(_dateTxt);
         addChild(_effectThresholdTxt);
         addChild(_effectIcon);
         addChild(_myOrderNote);
         addChild(_myOrderTxt);
         addChild(_curContain);
         addChild(_myConsumNote);
         addChild(_myConsumPoint);
         addChild(_myConsumIcon);
         addChild(_myConsumQualify);
         addChild(_description);
         addChild(_tipsStrip1);
         addChild(_tipsStrip2);
         _curContain.addChild(_activeLinePoint);
         _curContain.addChild(_activeLineNote);
         _pondAnimationMc.mouseChildren = _pondAnimationMc.mouseEnabled = false;
         _titleTxt.text = LanguageMgr.GetTranslation("goldenDionysiaLotteryTime.titleTxt");
         _helpImage.tipData = LanguageMgr.GetTranslation("goldendionysia.activatedHelpImage.tip");
         _tipsStrip1.tipData = LanguageMgr.GetTranslation("GoldenDionysiaMiddle1.tipsStrip1");
         _tipsStrip2.tipData = LanguageMgr.GetTranslation("GoldenDionysiaMiddle1.tipsStrip2");
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("GOLDEN_DIONYSIA_INFO",__updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("GOLDEN_DIONYSIA_INFO",__updateViewHandler);
      }
      
      private function __updateViewHandler(param1:NotificationEvent = null) : void
      {
         var _loc2_:Boolean = false;
         _goldenMsg = GoldenDionysiaManager.instance.goldenMsg;
         if(_goldenMsg.state != GoldenDionysiaManager.STATE1)
         {
            return;
         }
         var _loc6_:Number = Number(DateFormatter.parse(_goldenMsg.stopTime,"YYYY-MM-DD hh:mm:ss").time);
         var _loc5_:Number = _loc6_ / 1000 - playerModel.sysCurTimeBySecond;
         _cdBar.curPhase = _goldenMsg.state - 1;
         _cdBar.startCD(_loc5_);
         _curPondTxt.updateUI(_goldenMsg.currentPoint);
         _curPondTxt.x = (380 - _curPondTxt.containerWidth) / 2;
         _curPondIcon.x = _curPondTxt.x + _curPondTxt.containerWidth + 5;
         _effectThresholdTxt.text = LanguageMgr.GetTranslation("GoldenDionysiaMiddle1.activeRewardPoint",_goldenMsg.activeRewardPoint);
         _dateTxt.htmlText = LanguageMgr.GetTranslation("GoldenDionysiaMiddle1.dateTxt",_goldenMsg.stopTime);
         _myOrderTxt.text = _goldenMsg.myOrder.toString();
         _activeLinePoint.text = _goldenMsg.activeLinePoint.toString();
         _myConsumPoint.text = _goldenMsg.myConsumPoint.toString();
         _description.htmlText = LanguageMgr.GetTranslation("GoldenDionysiaMiddle1.description",_goldenMsg.joinTotalPoint,_goldenMsg.joinOnePoint,_goldenMsg.onePointPer);
         if(_goldenMsg.myConsumPoint < _goldenMsg.joinTotalPoint)
         {
            _myConsumQualify.text = LanguageMgr.GetTranslation("GoldenDionysiaFrame.myConsumQualify1");
            _myConsumQualify.setFrame(1);
         }
         else
         {
            _myConsumQualify.text = LanguageMgr.GetTranslation("GoldenDionysiaFrame.myConsumQualify2");
            _myConsumQualify.setFrame(2);
         }
         _curContain.visible = false;
         _activatSignImage.visible = false;
         var _loc3_:int = 0;
         var _loc4_:Boolean = Boolean(GoldenDionysiaManager.instance.allocationActive);
         if(_goldenMsg.activeRewardPoint > 0)
         {
            _loc4_ = true;
         }
         _effectThresholdTxt.visible = _effectIcon.visible = _loc4_;
         if(_loc4_)
         {
            _loc3_ = int(_goldenMsg.activeRewardPoint);
            if(_goldenMsg.currentPoint < _goldenMsg.activeLinePoint)
            {
               _curContain.visible = true;
            }
            else if(_goldenMsg.currentPoint < _goldenMsg.activeRewardPoint)
            {
               _activatSignImage.visible = true;
               _activatSignImage.setFrame(1);
               _prePoint = 1;
               _curPoint = 1;
            }
            else
            {
               _activatSignImage.visible = true;
               _activatSignImage.setFrame(2);
               _loc2_ = true;
               _curPoint = 2;
            }
         }
         else
         {
            _loc3_ = int(_goldenMsg.activeLinePoint);
            _curContain.visible = true;
         }
         if(_curPoint > _prePoint)
         {
            _prePoint = 2;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("GOLDEN_DIONYSIA_SHINE"));
         }
         updatePondAnimationMc(_goldenMsg.currentPoint,_loc3_,_loc2_);
      }
      
      public function updatePondAnimationMc(param1:Number, param2:Number, param3:Boolean, param4:Boolean = true) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:MovieClip = null;
         if(param2 == 0)
         {
            _loc9_ = 0;
         }
         else
         {
            _loc9_ = param1 / (param2 + param2 * 0.2);
         }
         if(_loc9_ > 1)
         {
            _loc9_ = 1;
         }
         else if(_loc9_ < 0)
         {
            _loc9_ = 0;
         }
         var _loc12_:MovieClip = _pondAnimationMc["pondMask_mc"] as MovieClip;
         var _loc7_:MovieClip = _pondAnimationMc["goldPlane_mc"] as MovieClip;
         var _loc11_:MovieClip = _pondAnimationMc["greyPlane_mc"] as MovieClip;
         var _loc5_:MovieClip = _pondAnimationMc["goldCircle_mc"] as MovieClip;
         var _loc8_:MovieClip = _pondAnimationMc["greyCircle_mc"] as MovieClip;
         _loc7_.visible = false;
         _loc11_.visible = false;
         _loc5_.visible = false;
         _loc8_.visible = false;
         if(param3)
         {
            _loc10_ = _loc7_;
            _loc5_.visible = true;
         }
         else
         {
            _loc10_ = _loc11_;
            _loc8_.visible = true;
         }
         _loc10_.visible = true;
         var _loc6_:Number = (1 - _loc9_) * 270;
         TweenMax.killTweensOf(_loc12_);
         TweenMax.killTweensOf(_loc10_);
         if(param4)
         {
            TweenMax.allTo([_loc12_,_loc10_],0.5,{"y":_loc6_});
         }
         else
         {
            _loc12_.y = _loc10_.y = _loc6_;
         }
         if(_loc9_ > 0.08 && _loc9_ < 0.92)
         {
            _loc10_.visible = true;
            if(_loc9_ > 0.7)
            {
               _loc10_.scaleY = 1 - _loc9_;
            }
            else
            {
               _loc10_.scaleY = 1;
            }
         }
         else
         {
            _loc10_.visible = false;
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_cdBar);
         _cdBar = null;
         ObjectUtils.disposeObject(_dataBmp);
         _dataBmp = null;
         ObjectUtils.disposeViolentMc(_pondAnimationMc);
         _pondAnimationMc = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_dateTxt);
         _dateTxt = null;
         ObjectUtils.disposeObject(_pondTitleBg);
         _pondTitleBg = null;
         ObjectUtils.disposeObject(_curPondIcon);
         _curPondIcon = null;
         ObjectUtils.disposeObject(_curPondTxt);
         _curPondTxt = null;
         ObjectUtils.disposeObject(_curContain);
         _curContain = null;
         ObjectUtils.disposeObject(_helpImage);
         _helpImage = null;
         ObjectUtils.disposeObject(_activatSignImage);
         _activatSignImage = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_effectThresholdTxt);
         _effectThresholdTxt = null;
         ObjectUtils.disposeObject(_effectIcon);
         _effectIcon = null;
         ObjectUtils.disposeObject(_myOrderNote);
         _myOrderNote = null;
         ObjectUtils.disposeObject(_myOrderTxt);
         _myOrderTxt = null;
         ObjectUtils.disposeObject(_activeLinePoint);
         _activeLinePoint = null;
         ObjectUtils.disposeObject(_activeLineNote);
         _activeLineNote = null;
         ObjectUtils.disposeObject(_myConsumNote);
         _myConsumNote = null;
         ObjectUtils.disposeObject(_myConsumPoint);
         _myConsumPoint = null;
         ObjectUtils.disposeObject(_myConsumIcon);
         _myConsumIcon = null;
         ObjectUtils.disposeObject(_myConsumQualify);
         _myConsumQualify = null;
         ObjectUtils.disposeObject(_description);
         _description = null;
         ObjectUtils.disposeObject(_tipsStrip1);
         _tipsStrip1 = null;
         ObjectUtils.disposeObject(_tipsStrip2);
         _tipsStrip2 = null;
         _goldenMsg = null;
         super.dispose();
      }
   }
}

