package sale
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import funny.FunnyEvent;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import managers.SaleManager;
   import mvc.module.sale.SaleEvent;
   import mvc.module.sale.SaleModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SaleFrame extends Frame implements IManualSize
   {
      
      private var items:Vector.<SaleItemView>;
      
      private var _timer:Timer;
      
      private var _rightView:SaleRightView;
      
      private var _leftBg:Image;
      
      private var _rightBg:Image;
      
      private var _TitleIcon:FilterFrameText;
      
      private var _TitleName:FilterFrameText;
      
      private var _TitleLeftTime:FilterFrameText;
      
      private var _TitleAuctionInfo:FilterFrameText;
      
      private var _activityLeftTime:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      public function SaleFrame()
      {
         FunnyManager.instance.sendGetBag(1);
         super();
         initView();
         initData();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,693,506);
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:SaleItemView = null;
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("sale.leftBg");
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("sale.rightBg");
         _rightView = new SaleRightView();
         _TitleIcon = ComponentFactory.Instance.creatComponentByStylename("SaleFrame.TitleIcon");
         _TitleName = ComponentFactory.Instance.creatComponentByStylename("SaleFrame.TitleName");
         _TitleLeftTime = ComponentFactory.Instance.creatComponentByStylename("SaleFrame.TitleLeftTime");
         _TitleAuctionInfo = ComponentFactory.Instance.creatComponentByStylename("SaleFrame.TitleAuctionInfo");
         _activityLeftTime = ComponentFactory.Instance.creatComponentByStylename("SaleFrame.activityLeftTime");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("sale.helpBtn");
         addToContent(_leftBg);
         addToContent(_rightBg);
         addToContent(_rightView);
         _rightView.x = 500;
         _rightView.y = 50;
         addToContent(_TitleIcon);
         addToContent(_TitleName);
         addToContent(_TitleLeftTime);
         addToContent(_TitleAuctionInfo);
         addToContent(_activityLeftTime);
         addToContent(_helpBtn);
         _TitleIcon.text = LanguageMgr.GetTranslation("SaleFrame.title1");
         _TitleName.text = LanguageMgr.GetTranslation("SaleFrame.title2");
         _TitleLeftTime.text = LanguageMgr.GetTranslation("SaleFrame.title3");
         _TitleAuctionInfo.text = LanguageMgr.GetTranslation("SaleFrame.title4");
         _activityLeftTime.text = "";
         var _loc1_:Component = new Component();
         _loc1_.x = 10;
         _loc1_.y = 41;
         items = new Vector.<SaleItemView>();
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = new SaleItemView();
            _loc2_.y = _loc3_ * 88;
            _loc1_.addChild(_loc2_);
            items.push(_loc2_);
            _loc3_++;
         }
         addToContent(_loc1_);
      }
      
      private function initData() : void
      {
         __timerHandler(null);
      }
      
      private function addTimeEvent() : void
      {
         if(!_timer)
         {
            return;
         }
         _timer.stop();
         _timer.removeEventListener("timer",__timerHandler);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function removeTimeEvent() : void
      {
         if(!_timer)
         {
            return;
         }
         _timer.stop();
         _timer.removeEventListener("timer",__timerHandler);
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         FunnyManager.instance.addEventListener("REFRESH_ITEM",__refreshHandler);
         NotificationManager.instance.addEventListener("SaleEvent.SALE_DATA",__saleDataHandler);
         _helpBtn.addEventListener("click",__helpHandler);
      }
      
      protected function __saleDataHandler(param1:SaleEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < items.length)
         {
            items[_loc2_].data = model.items[_loc2_];
            _loc2_++;
         }
         _rightView.data = model.specialItem;
         _activityLeftTime.text = LanguageMgr.GetTranslation("SaleFrame.leftTime") + getTimeString(model.leftSecond);
      }
      
      private function getTimeString(param1:int) : String
      {
         if(param1 < 60)
         {
            return LanguageMgr.GetTranslation("SaleItemView.lessThanOneMinute");
         }
         if(param1 < 3600)
         {
            return int(param1 / 60) + LanguageMgr.GetTranslation("yishi.utils.DateFormatter.timeStr.minShort");
         }
         return int(param1 / 3600) + LanguageMgr.GetTranslation("public.time.hour");
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         FunnyManager.instance.removeEventListener("REFRESH_ITEM",__refreshHandler);
         NotificationManager.instance.removeEventListener("SaleEvent.SALE_DATA",__saleDataHandler);
         _helpBtn.removeEventListener("click",__helpHandler);
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = null;
         _loc2_ = ComponentFactory.Instance.creatComponentByStylename("sale.helpFrame");
         _loc2_.show();
      }
      
      protected function __onPayBtnClick(param1:MouseEvent) : void
      {
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function __refreshHandler(param1:FunnyEvent) : void
      {
         initData();
      }
      
      private function get model() : SaleModel
      {
         return SaleManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         titleText = LanguageMgr.GetTranslation("SaleFrame.title");
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_TitleIcon);
         _TitleIcon = null;
         SaleManager.instance.sendCloseWindow();
         super.dispose();
      }
   }
}

