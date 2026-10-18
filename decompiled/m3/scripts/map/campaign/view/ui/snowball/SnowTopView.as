package map.campaign.view.ui.snowball
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import map.campaign.CampaignManager;
   import map.campaign.data.ActiveVehicleModel;
   import map.campaign.event.CampaignEvent;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   
   public class SnowTopView extends Component
   {
      
      private var _timer:Timer;
      
      private var _timeCount:int;
      
      private var _back:Bitmap;
      
      private var _numData:BitmapData;
      
      private var _sp:Sprite;
      
      private var _timeStr:String = "00:00";
      
      public function SnowTopView()
      {
         super();
         initView();
         initEvent();
         timeCount = activeVehicleModel.overTime;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.snowball.timeback");
         _numData = ComponentFactory.Instance.creatBitmap("asset.snowball.timeNum").bitmapData;
         _sp = new Sprite();
         _sp.x = 75;
         _sp.y = 39;
         addChild(_back);
         addChild(_sp);
         _timer = new Timer(1000);
         _timer.stop();
      }
      
      private function initEvent() : void
      {
         if(_timer)
         {
            _timer.addEventListener("timer",_timerHandler);
         }
         activeVehicleModel.addEventListener("ACTIVEVEHICLE_CAMPAIGNTIME",resetTimeHanler);
      }
      
      private function removeEvent() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",_timerHandler);
         }
         activeVehicleModel.removeEventListener("ACTIVEVEHICLE_CAMPAIGNTIME",resetTimeHanler);
      }
      
      private function resetTimeHanler(param1:CampaignEvent) : void
      {
         timeCount = activeVehicleModel.overTime;
      }
      
      private function _timerHandler(param1:TimerEvent) : void
      {
         _timeCount = _timeCount + 1;
         refreshBitTime(_timeCount);
      }
      
      private function refreshBitTime(param1:int) : void
      {
         _timeStr = DateFormatter.getCountDate(_timeCount,2,2);
         ObjectUtils.disposeAllChildren(_sp);
         NumberViewUtils.refreshTimeValue(_timeStr,_sp,_numData,24,32,22,24,"0123456789:");
      }
      
      public function set timeCount(param1:int) : void
      {
         _timeCount = param1;
         if(_timeCount >= 0)
         {
            refreshBitTime(_timeCount);
            _timer.reset();
            _timer.start();
         }
      }
      
      public function show() : void
      {
         resize();
         LayerManager.Instance.addToLayer(this,4,false,false,0,1);
      }
      
      public function resize() : void
      {
         x = (StageReferance.stageWidth - this.displayWidth) * 0.5;
         y = 5;
      }
      
      private function get activeVehicleModel() : ActiveVehicleModel
      {
         return CampaignManager.instance.activeVehicleModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_timer)
         {
            _timer.stop();
            _timer = null;
         }
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_sp);
         _sp = null;
         ObjectUtils.disposeObject(_numData);
         _numData = null;
         super.dispose();
      }
   }
}

