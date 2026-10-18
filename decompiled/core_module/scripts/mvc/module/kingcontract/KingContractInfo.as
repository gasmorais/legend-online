package mvc.module.kingcontract
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import yishi.datas.templates.KingContractTemplateInfo;
   import yishi.manager.PlayerManager;
   import yishi.timer.TimerTicker;
   
   public class KingContractInfo extends EventDispatcher
   {
      
      public var templateId:int;
      
      public var template:KingContractTemplateInfo;
      
      private var _endData:Date;
      
      private var _leftTime:Number = -1;
      
      private var _time:TimerTicker;
      
      public function KingContractInfo()
      {
         super();
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         _leftTime = _leftTime - 1;
         dispatchEvent(new Event("change"));
         if(_leftTime == 0)
         {
            dispatchEvent(new Event("complete"));
            if(_time)
            {
               _time.stop();
            }
         }
      }
      
      public function set leftTime(param1:Number) : void
      {
         _leftTime = param1;
         if(_leftTime > 0)
         {
            if(!_time)
            {
               _time = new TimerTicker(1000);
            }
            _time.addEventListener("timer",__timerHandler);
            _time.start();
         }
         else if(_time)
         {
            _time.stop();
         }
      }
      
      public function get leftTime() : Number
      {
         return _leftTime;
      }
      
      public function get endData() : Date
      {
         return _endData;
      }
      
      public function set endData(param1:Date) : void
      {
         _endData = param1;
         if(endData == null || endData && endData.time < currentTime.time)
         {
            leftTime = -1;
            return;
         }
         leftTime = (endData.time - currentTime.time) / 1000;
      }
      
      private function get currentTime() : Date
      {
         return PlayerManager.instance.currentPlayerModel.sysCurtime;
      }
   }
}

