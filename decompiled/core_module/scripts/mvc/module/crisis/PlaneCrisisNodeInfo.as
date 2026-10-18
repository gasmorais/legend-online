package mvc.module.crisis
{
   import yishi.datas.templates.PlaneCrisisEventTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class PlaneCrisisNodeInfo
   {
      
      public var nodeId:int;
      
      private var _isPick:Boolean;
      
      public var isOpen:Boolean;
      
      public var isPlay:Boolean;
      
      public var eventTempInfo:PlaneCrisisEventTempInfo;
      
      private var _isShowToSmall:Boolean;
      
      private var _eventId:int = -1;
      
      private var _eventType:int;
      
      public function PlaneCrisisNodeInfo()
      {
         super();
      }
      
      public function get eventId() : int
      {
         return _eventId;
      }
      
      public function set eventId(param1:int) : void
      {
         if(_eventId == param1)
         {
            if(_eventType == PlaneCrisisEventType.END_BOSS && isOpen && !_isShowToSmall)
            {
               NotificationManager.instance.sendNotification("PlaneCrisisEventType.showBossToSmall",nodeId);
               _isShowToSmall = true;
            }
            return;
         }
         _eventId = param1;
         if(_eventId == 0)
         {
            _eventType = PlaneCrisisEventType.NULL;
         }
         else
         {
            if(eventTempInfo == null)
            {
               eventTempInfo = TempleteManager.instance.planeCrisisEventTempCate.getEventTempInfo(_eventId);
            }
            if(eventTempInfo != null)
            {
               _eventType = eventTempInfo.EventType;
            }
            else
            {
               _eventType = PlaneCrisisEventType.NULL;
            }
         }
      }
      
      public function get eventType() : int
      {
         return _eventType;
      }
      
      public function get isPick() : Boolean
      {
         return _isPick;
      }
      
      public function set isPick(param1:Boolean) : void
      {
         if(_isPick == param1)
         {
            return;
         }
         _isPick = param1;
         NotificationManager.instance.sendNotification("PlaneCrisisEventType.updateSmallPoint",this);
      }
   }
}

