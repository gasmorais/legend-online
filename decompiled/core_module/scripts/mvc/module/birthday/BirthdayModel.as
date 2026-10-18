package mvc.module.birthday
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class BirthdayModel extends EventDispatcher
   {
      
      public static const MODEL_UPDATE_EVENT:String = "MODEL_UPDATE_EVENT";
      
      private var _wishCount:uint;
      
      private var _activeMsgLeaveInfoList:Array;
      
      public function BirthdayModel()
      {
         super();
      }
      
      public function updateModel(param1:Array, param2:uint) : void
      {
         _activeMsgLeaveInfoList = param1;
         _wishCount = param2;
         dispatchEvent(new Event("MODEL_UPDATE_EVENT"));
      }
      
      public function get activeMsgLeaveInfoList() : Array
      {
         return _activeMsgLeaveInfoList;
      }
      
      public function get wishCount() : uint
      {
         return _wishCount;
      }
   }
}

