package poker
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.pet.PokerPlayerMsg;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PokerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class PokerLayer extends Component
   {
      
      private var _blackGound:Sprite;
      
      private var _startBtn:IconButton;
      
      private var _exchangeBtn:IconButton;
      
      private var _pointsBtn:IconButton;
      
      private var _cashStrip:StripView;
      
      private var _coreStrip:StripView;
      
      private var _cashTxtBg:DisplayObject;
      
      private var _coreTxtBg:DisplayObject;
      
      private var _cashImg:Image;
      
      private var _coreImg:Image;
      
      private var _cashTxt:FilterFrameText;
      
      private var _coreTxt:FilterFrameText;
      
      private var _desBack:DisplayObject;
      
      private var _desTxt:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _timeNumber:int;
      
      private var _timeSprite:Sprite;
      
      private var _timeBG:Bitmap;
      
      private var _timeFont:Bitmap;
      
      private var _timeTxt:FilterFrameText;
      
      private var _countdownTxt:FilterFrameText;
      
      public function PokerLayer()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _blackGound = new Sprite();
         _blackGound.graphics.clear();
         _blackGound.graphics.beginFill(0,0.6);
         _blackGound.graphics.drawRect(0,0,1113,635);
         _blackGound.graphics.endFill();
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("poker.startGameBtn");
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("poker.exchangeGameBtn");
         _pointsBtn = ComponentFactory.Instance.creatComponentByStylename("poker.pointsGameBtn");
         _cashStrip = ComponentFactory.Instance.creatCustomObject("poker.cashImgStrip");
         _coreStrip = ComponentFactory.Instance.creatCustomObject("poker.coreImgStrip");
         _cashTxtBg = ComponentFactory.Instance.creatComponentByStylename("poker.cashTxtBg");
         _coreTxtBg = ComponentFactory.Instance.creatComponentByStylename("poker.coreTxtBg");
         _cashImg = ComponentFactory.Instance.creatComponentByStylename("poker.cashImg");
         _coreImg = ComponentFactory.Instance.creatComponentByStylename("poker.coreImg");
         _cashTxt = ComponentFactory.Instance.creatComponentByStylename("poker.cashTxt");
         _coreTxt = ComponentFactory.Instance.creatComponentByStylename("poker.coreTxt");
         _desBack = ComponentFactory.Instance.creatComponentByStylename("poker.desLayerBack");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("poker.desLayerTxt");
         _countdownTxt = ComponentFactory.Instance.creatComponentByStylename("poker.countdownTxt");
         _timeSprite = ComponentFactory.Instance.creatCustomObject("poker.timeSprite1");
         _timeBG = ComponentFactory.Instance.creatBitmap("asset.poker.timeBG");
         _timeFont = ComponentFactory.Instance.creatBitmap("asset.poker.timeFontBG");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("poker.timeTxt");
         _timer = new Timer(1000,2147483647);
         _timer.addEventListener("timer",__timerHandler);
         addChild(_blackGound);
         addChild(_startBtn);
         addChild(_exchangeBtn);
         addChild(_pointsBtn);
         _cashStrip.addChild(_cashTxtBg);
         _coreStrip.addChild(_coreTxtBg);
         _cashStrip.addChild(_cashImg);
         _coreStrip.addChild(_coreImg);
         _cashStrip.addChild(_cashTxt);
         _coreStrip.addChild(_coreTxt);
         addChild(_cashStrip);
         addChild(_coreStrip);
         addChild(_desBack);
         addChild(_desTxt);
         addChild(_countdownTxt);
         addChild(_timeSprite);
         _timeSprite.addChild(_timeBG);
         _timeSprite.addChild(_timeFont);
         _timeSprite.addChild(_timeTxt);
         _timeSprite.visible = false;
         _cashStrip.tipData = LanguageMgr.GetTranslation("poker.PokerLayer.cashImg.tipData");
         _coreStrip.tipData = LanguageMgr.GetTranslation("poker.PokerLayer.coreImg.tipData");
         _desTxt.htmlText = LanguageMgr.GetTranslation("poker.PokerFrame.helpContent");
      }
      
      private function addEvent() : void
      {
         _startBtn.addEventListener("click",__startBtnHandler);
         _exchangeBtn.addEventListener("click",__exchangeBtnHandler);
         _pointsBtn.addEventListener("click",__pointsBtnHandler);
         NotificationManager.instance.addEventListener("POKER_PLAYER_MSG",__pokerMsgHandler);
         NotificationManager.instance.addEventListener("PLAYER_EXTRA_FIELD",__extraFieldHandler);
         __extraFieldHandler(null);
      }
      
      private function removeEvent() : void
      {
         if(_startBtn)
         {
            _startBtn.removeEventListener("click",__startBtnHandler);
         }
         if(_exchangeBtn)
         {
            _exchangeBtn.removeEventListener("click",__exchangeBtnHandler);
         }
         if(_pointsBtn)
         {
            _pointsBtn.removeEventListener("click",__pointsBtnHandler);
         }
         NotificationManager.instance.removeEventListener("POKER_PLAYER_MSG",__pokerMsgHandler);
         NotificationManager.instance.removeEventListener("PLAYER_EXTRA_FIELD",__extraFieldHandler);
      }
      
      private function __startBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:int = int(PokerManager.instance.pokerCash);
         if(_loc2_ < 10)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("poker.PokerLayer.lessPoint"));
            return;
         }
         if(!PokerManager.instance.openSign)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("poker.PokerLayer.timeOver"));
            return;
         }
         if(_timeNumber > 0)
         {
            return;
         }
         PokerManager.instance.RequestPoker(0);
         _timeTxt.text = "00:00";
         _timer.start();
         _timeNumber = 0;
         _timeSprite.visible = true;
      }
      
      public function refreshView() : void
      {
         _timeTxt.text = "00:00";
         _timer.stop();
         _timeNumber = 0;
         _timeSprite.visible = false;
      }
      
      private function __exchangeBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("poker",1,1000);
      }
      
      private function __pointsBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("shop",1003);
      }
      
      public function __pokerMsgHandler(param1:NotificationEvent) : void
      {
         var _loc2_:PokerPlayerMsg = PokerManager.instance.opStateMsg;
         if(_loc2_.state != 0)
         {
            if(_loc2_.state != 1)
            {
               if(_loc2_.state == 2)
               {
               }
            }
         }
      }
      
      private function __extraFieldHandler(param1:NotificationEvent) : void
      {
         _cashTxt.text = PokerManager.instance.pokerCash + "";
         _coreTxt.text = PokerManager.instance.pokerScore + "";
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         _timeNumber = _timeNumber + 1;
         _loc2_ = String(int(_timeNumber / 60) > 9 ? int(_timeNumber / 60) : "0" + int(_timeNumber / 60));
         _loc2_ += ":" + (String(int(_timeNumber % 60) > 9 ? int(_timeNumber % 60) : "0" + int(_timeNumber % 60)));
         _timeTxt.text = _loc2_;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_blackGound);
         _blackGound = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_exchangeBtn);
         _exchangeBtn = null;
         ObjectUtils.disposeObject(_pointsBtn);
         _pointsBtn = null;
         ObjectUtils.disposeObject(_cashTxtBg);
         _cashTxtBg = null;
         ObjectUtils.disposeObject(_coreTxtBg);
         _coreTxtBg = null;
         ObjectUtils.disposeObject(_cashImg);
         _cashImg = null;
         ObjectUtils.disposeObject(_coreImg);
         _coreImg = null;
         ObjectUtils.disposeObject(_cashTxt);
         _cashTxt = null;
         ObjectUtils.disposeObject(_coreTxt);
         _coreTxt = null;
         ObjectUtils.disposeObject(_cashStrip);
         _cashStrip = null;
         ObjectUtils.disposeObject(_coreStrip);
         _coreStrip = null;
         ObjectUtils.disposeObject(_desBack);
         _desBack = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeObject(_countdownTxt);
         _countdownTxt = null;
         ObjectUtils.disposeObject(_timeBG);
         _timeBG = null;
         ObjectUtils.disposeObject(_timeFont);
         _timeFont = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeAllChildren(_timeSprite);
         ObjectUtils.disposeObject(_timeSprite);
         _timeSprite = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            _timer = null;
         }
         super.dispose();
      }
   }
}

