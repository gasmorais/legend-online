package year2023.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.YearActiveManager;
   import year2023.item.YearActivePointItem;
   import year2023.ui.view.YearActiveEnterViewUI;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class YearActiveEnterView extends YearActiveEnterViewUI
   {
      
      private var _timer:Timer;
      
      private var _goldPrice:YearActivePointItem;
      
      public function YearActiveEnterView()
      {
         super();
         addView();
         initData();
         initEvent();
      }
      
      private function addView() : void
      {
         _goldPrice = ComponentFactory.Instance.creatCustomObject("ui.yearactive.enterGoldPrice");
         addChild(_goldPrice);
      }
      
      private function initData() : void
      {
         var _loc2_:String = YearActiveManager.ins.openTime;
         var _loc1_:String = YearActiveManager.ins.stopTime;
         _enterTimeTxt.text = LanguageMgr.GetTranslation("SevenYear.time",_loc2_,_loc1_);
         __timerHandler();
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("EVENT_YEARACTIVITY_OP",_updateInfoHandler);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("EVENT_YEARACTIVITY_OP",_updateInfoHandler);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            _timer = null;
         }
      }
      
      private function __timerHandler(param1:TimerEvent = null) : void
      {
         _dayItem2.setRemainTime();
         _dayItem4.setRemainTime();
      }
      
      private function _updateInfoHandler(param1:NotificationEvent) : void
      {
         _dayItem2.updateView();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_goldPrice);
         _goldPrice = null;
         super.dispose();
      }
   }
}

