package mvc.module.slot
{
   import events.SlotEvent;
   import flash.events.EventDispatcher;
   
   public class SlotModel extends EventDispatcher
   {
      
      private var _isOpen:Boolean;
      
      public var status:int;
      
      public var slotResult:String;
      
      public var type:int;
      
      public var rewardTemplateId:int;
      
      public var findCost:int;
      
      public var op:int;
      
      public var slotRefuseInvitation:Boolean;
      
      public var slotRefuseInvite:Boolean;
      
      public var slotRefuseTeamInvite:Boolean;
      
      public function SlotModel()
      {
         super();
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         if(_isOpen != param1)
         {
            _isOpen = param1;
            dispatchEvent(new SlotEvent("SLOTSATECHANGE"));
         }
      }
   }
}

