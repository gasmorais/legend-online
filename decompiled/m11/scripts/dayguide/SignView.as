package dayguide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.VIPEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.FileReference;
   import flash.net.URLRequest;
   import manager.LanguageMgr;
   import managers.DayGuideManager;
   import managers.VIPManager;
   import mvc.controler.DayGuideController;
   import mvc.module.vip.VIPModel;
   import yishi.manager.ConfigManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.NoviceBtnGlowEffect;
   
   public class SignView extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private var _signDayArr:Array;
      
      private var _singBack:ScaleBitmapImage;
      
      private var _signCount:FilterFrameText;
      
      private var _signValue:FilterFrameText;
      
      private var _signBtn:IconButton;
      
      private var _buttonEffect:MovieClip;
      
      private var _clientDownBtn:IconButton;
      
      private var _giftBagBtn:IconButton;
      
      private var _disEffect:NoviceBtnGlowEffect;
      
      private var _signCountImg:Bitmap;
      
      private var _rewardItemArr:Array;
      
      private const SIGN_DAY_INDEX:Array = [2,5,8,10];
      
      private var _signCdTxt:FilterFrameText;
      
      private var _resetDateTxt:FilterFrameText;
      
      public function SignView()
      {
         super();
         initView();
         initEvent();
         updateView();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SignDayView = null;
         var _loc3_:SignRewardItemView = null;
         _signDayArr = [];
         _rewardItemArr = [];
         _bg = ComponentFactory.Instance.creatBitmap("asset.dayGuide.BgNew");
         addChild(_bg);
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new SignDayView(_loc2_);
            _signDayArr.push(_loc1_);
            _loc1_.x = 47 + _loc2_ % 5 * 100;
            _loc1_.y = 17 + int(_loc2_ / 5) * 55;
            addChild(_loc1_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < SIGN_DAY_INDEX.length)
         {
            _loc3_ = new SignRewardItemView(SIGN_DAY_INDEX[_loc2_]);
            addChild(_loc3_);
            _loc3_.x = 11 + _loc2_ * 138;
            _loc3_.y = 255;
            _rewardItemArr.push(_loc3_);
            _loc2_++;
         }
         _singBack = ComponentFactory.Instance.creatComponentByStylename("dayGuide.SignBack");
         _signCount = ComponentFactory.Instance.creatComponentByStylename("dayGuide.SignCountTxt");
         _signCount.text = LanguageMgr.GetTranslation("dayGuide.view.SignView.signCount.text");
         _signValue = ComponentFactory.Instance.creatComponentByStylename("dayGuide.SignValueTxt");
         _signBtn = ComponentFactory.Instance.creatComponentByStylename("dayGuide.SignButton");
         _buttonEffect = ComponentFactory.Instance.creatCustomObject("dayGuide.SignButtonMc");
         _buttonEffect["pos"].addChild(_signBtn);
         _buttonEffect.gotoAndStop(1);
         _clientDownBtn = ComponentFactory.Instance.creatComponentByStylename("dayGuide.ClientDownBtn");
         _giftBagBtn = ComponentFactory.Instance.creatComponentByStylename("dayGuide.VipgiftBagBtn");
         _signCountImg = ComponentFactory.Instance.creatBitmap("asset.dayGuide.SignCountImg");
         _signCdTxt = ComponentFactory.Instance.creatComponentByStylename("dayGuide.SignCdTxt");
         _resetDateTxt = ComponentFactory.Instance.creatComponentByStylename("dayGuide.resetDateTxt");
         addChild(_singBack);
         addChild(_signCount);
         addChild(_signValue);
         addChild(_buttonEffect);
         addChild(_giftBagBtn);
         addChild(_signCountImg);
         addChild(_signCdTxt);
         addChild(_resetDateTxt);
         _disEffect = new NoviceBtnGlowEffect(_giftBagBtn,9);
         if(vipModel.vipInfo.IsTakeGift && Boolean(vipModel.vipInfo.IsVipAndNoExpirt))
         {
            _disEffect.play();
         }
         else
         {
            _disEffect.stop();
         }
         var _loc4_:Boolean = Boolean(ConfigManager.info.CLIENT_DOWNLAND);
         if(_loc4_)
         {
            addChild(_clientDownBtn);
         }
      }
      
      private function __UpViewFrame(param1:VIPEvent) : void
      {
         if(vipModel.vipInfo.IsTakeGift && Boolean(vipModel.vipInfo.IsVipAndNoExpirt))
         {
            _disEffect.play();
         }
         else
         {
            _disEffect.stop();
         }
      }
      
      private function initEvent() : void
      {
         _clientDownBtn.addEventListener("click",__clientDownClick);
         NotificationManager.instance.addEventListener("DAY_SIGN_INFO",onInfo);
         _giftBagBtn.addEventListener("click",__gifHandler);
         _signBtn.addEventListener("click",__signHandler);
         vipModel.addEventListener("upframeview_change",__UpViewFrame);
      }
      
      private function removeEvent() : void
      {
         if(_clientDownBtn)
         {
            _clientDownBtn.removeEventListener("click",__clientDownClick);
         }
         NotificationManager.instance.removeEventListener("DAY_SIGN_INFO",onInfo);
         _giftBagBtn.removeEventListener("click",__gifHandler);
         if(_signBtn)
         {
            _signBtn.removeEventListener("click",__signHandler);
         }
         vipModel.removeEventListener("upframeview_change",__UpViewFrame);
      }
      
      private function __signHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.sendSign();
      }
      
      private function get control() : DayGuideController
      {
         return FrameControllerManager.instance.dayGuideController;
      }
      
      private function __gifHandler(param1:MouseEvent) : void
      {
         if(vipModel.vipInfo.IsTakeGift && Boolean(vipModel.vipInfo.IsVipAndNoExpirt))
         {
            FrameControllerManager.instance.openControllerByInfo("vip",VIPModel.OPEN_GIFT_FRAME);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("vip");
         }
      }
      
      private function onInfo(param1:Event) : void
      {
         updateView();
      }
      
      public function updateView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:SignDayView = null;
         _signValue.text = String(DayGuideManager.instance.daySignInfo.signCount);
         _loc3_ = 0;
         while(_loc3_ < _signDayArr.length)
         {
            _loc1_ = _signDayArr[_loc3_];
            _loc1_.setData(DayGuideManager.instance.daySignInfo.signArr[_loc3_]);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _rewardItemArr.length)
         {
            _rewardItemArr[_loc3_].updateView();
            _loc3_++;
         }
         _signCdTxt.text = LanguageMgr.GetTranslation("dayguide.SignView.signCdTxt",DayGuideManager.instance.daySignInfo.signCycle - DayGuideManager.instance.daySignInfo.todayIndex);
         _resetDateTxt.text = LanguageMgr.GetTranslation("dayguide.SignView.resetDateTxt",DayGuideManager.instance.daySignInfo.resetDate);
         var _loc2_:int = int(DayGuideManager.instance.daySignInfo.signArr[DayGuideManager.instance.daySignInfo.todayIndex - 1]);
         _signBtn.enable = _loc2_ == 1 ? false : true;
         if(_signBtn.enable)
         {
            _buttonEffect.gotoAndPlay(1);
         }
         else
         {
            _buttonEffect.gotoAndStop(1);
         }
      }
      
      private function __clientDownClick(param1:MouseEvent) : void
      {
         var _loc6_:String = null;
         var _loc4_:String = null;
         SoundManager.instance.play("022");
         var _loc7_:String = PathManager.getClientLoginPath();
         var _loc3_:String = PathManager.getClientLoginName() + ".exe";
         if(_loc7_.substr(-3) != "exe")
         {
            _loc6_ = PlayerManager.instance.currentPlayerModel.userInfo.user;
            _loc4_ = PlayerManager.instance.currentPlayerModel.userInfo.site;
            if(_loc7_.indexOf("?") == -1)
            {
               _loc7_ += "?";
            }
            else
            {
               _loc7_ += "&";
            }
            _loc7_ += "u=" + _loc6_ + "&site=" + _loc4_;
         }
         _loc7_ = encodeURI(_loc7_);
         var _loc2_:URLRequest = new URLRequest(_loc7_);
         var _loc5_:FileReference = new FileReference();
         _loc5_.download(_loc2_,_loc3_);
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         if(_signDayArr != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _signDayArr.length)
            {
               ObjectUtils.disposeObject(_signDayArr[_loc1_]);
               _signDayArr[_loc1_] = null;
               _loc1_++;
            }
            _signDayArr = null;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_singBack);
         _singBack = null;
         ObjectUtils.disposeObject(_signValue);
         _signValue = null;
         ObjectUtils.disposeObject(_signBtn);
         _signBtn = null;
         ObjectUtils.disposeViolentMc(_buttonEffect);
         _buttonEffect = null;
         ObjectUtils.disposeObject(_signCount);
         _signCount = null;
         ObjectUtils.disposeObject(_clientDownBtn);
         _clientDownBtn = null;
         ObjectUtils.disposeObject(_giftBagBtn);
         _giftBagBtn = null;
         ObjectUtils.disposeObject(_disEffect);
         _disEffect = null;
         ObjectUtils.disposeObject(_signCountImg);
         _signCountImg = null;
         ObjectUtils.disposeObject(_signCdTxt);
         _signCdTxt = null;
         ObjectUtils.disposeObject(_resetDateTxt);
         _resetDateTxt = null;
         if(_rewardItemArr != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _rewardItemArr.length)
            {
               ObjectUtils.disposeObject(_rewardItemArr[_loc1_]);
               _rewardItemArr[_loc1_] = null;
               _loc1_++;
            }
            _rewardItemArr = null;
         }
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

