package publicegg
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.sumpassion.SumGiftList;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.PublicEggManager;
   import yishi.utils.DateFormatter;
   
   public class PublicGiftView extends Component
   {
      
      private var _timer:Timer;
      
      private var _bg:DisplayObject;
      
      private var _leftTimeTxt:FilterFrameText;
      
      private var _giftListMsg:SumGiftList;
      
      private var _rewardsScroll:ScrollPanel;
      
      private var _luckShowScroll:ScrollPanel;
      
      private var _rewardsVBox:VBox;
      
      private var _luckShowVBox:VBox;
      
      private var _hasRechargeTxt:FilterFrameText;
      
      public function PublicGiftView()
      {
         super();
         initView();
         initEvent();
         PublicEggManager.instance.OperateGiftReq(1);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.publicgift.bg");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("publicgift.leftTimeTxt");
         _hasRechargeTxt = ComponentFactory.Instance.creatComponentByStylename("publicgift.hasRechargeTxt");
         _rewardsScroll = ComponentFactory.Instance.creatComponentByStylename("publicgift.RewardsListScrollPanel");
         _luckShowScroll = ComponentFactory.Instance.creatComponentByStylename("publicgift.LuckShowListScrollPanel");
         _rewardsVBox = ComponentFactory.Instance.creatComponentByStylename("publicgift.RewardsVBox");
         _luckShowVBox = ComponentFactory.Instance.creatComponentByStylename("publicgift.LuckShowVBox");
         addChild(_bg);
         addChild(_leftTimeTxt);
         addChild(_hasRechargeTxt);
         addChild(_rewardsScroll);
         addChild(_luckShowScroll);
         addChild(_rewardsVBox);
         addChild(_luckShowVBox);
         _rewardsScroll.setView(_rewardsVBox);
         _luckShowScroll.setView(_luckShowVBox);
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("PUBLIC_GIFT_UPDATE",__updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("PUBLIC_GIFT_UPDATE",__updateViewHandler);
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         var _loc2_:PublicGiftItem = null;
         var _loc3_:int = 0;
         if(PublicEggManager.instance.giftListMsg.op != 1)
         {
            return;
         }
         _giftListMsg = PublicEggManager.instance.giftListMsg;
         _hasRechargeTxt.text = LanguageMgr.GetTranslation("pblicegg.hasRecharge",_giftListMsg.charge);
         _rewardsVBox.removeAllChild();
         _rewardsVBox.disposeAllChildren();
         _rewardsVBox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < _giftListMsg.buyLevel.length)
         {
            _loc2_ = new PublicGiftItem();
            _loc2_.giftType = 1;
            _loc2_.data = _giftListMsg.buyLevel[_loc3_];
            _rewardsVBox.addChild(_loc2_);
            _loc3_++;
         }
         _rewardsVBox.commitChanges();
         _rewardsScroll.invalidateViewport(false);
         _luckShowVBox.removeAllChild();
         _luckShowVBox.disposeAllChildren();
         _luckShowVBox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < _giftListMsg.chargeLevel.length)
         {
            _loc2_ = new PublicGiftItem();
            _loc2_.giftType = 2;
            _loc2_.data = _giftListMsg.chargeLevel[_loc3_];
            _luckShowVBox.addChild(_loc2_);
            _loc3_++;
         }
         _luckShowVBox.commitChanges();
         _luckShowScroll.invalidateViewport(false);
         timeHandler(null);
      }
      
      private function timeHandler(param1:TimerEvent) : void
      {
         var _loc4_:String = null;
         if(_timer == null)
         {
            _timer = new Timer(1000);
            _timer.addEventListener("timer",timeHandler);
            _timer.start();
         }
         var _loc2_:Date = DateFormatter.parse(_giftListMsg.stopTime,"YYYY-MM-DD hh:mm:ss");
         var _loc3_:Number = _loc2_.time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         if(_loc3_ > 0)
         {
            if(_loc3_ >= 60)
            {
               _leftTimeTxt.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullTimeString(_loc3_));
            }
            else
            {
               _loc4_ = LanguageMgr.GetTranslation("funny.groupbuy.buyRestTimeSecond",_loc3_);
               _leftTimeTxt.text = _loc4_;
            }
         }
         else
         {
            _leftTimeTxt.text = LanguageMgr.GetTranslation("mainBar.TopToolsBar.rechargeBtn.click04");
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
            _timer = null;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_leftTimeTxt);
         _leftTimeTxt = null;
         ObjectUtils.disposeObject(_rewardsScroll);
         _rewardsScroll = null;
         ObjectUtils.disposeObject(_luckShowScroll);
         _luckShowScroll = null;
         ObjectUtils.disposeObject(_rewardsVBox);
         _rewardsVBox = null;
         ObjectUtils.disposeObject(_luckShowVBox);
         _luckShowVBox = null;
         ObjectUtils.disposeObject(_hasRechargeTxt);
         _hasRechargeTxt = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
            _timer = null;
         }
         _giftListMsg = null;
         super.dispose();
      }
   }
}

