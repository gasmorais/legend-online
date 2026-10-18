package events
{
   import flash.events.Event;
   
   public class RemotePetEvent extends Event
   {
      
      public static const PET_CHANGE:String = "PET_CHANGE";
      
      public static const FRIEND_LIST:String = "FRIEND_LIST";
      
      public static const Turn_LIST:String = "Turn_LIST";
      
      public static const COMMIT:String = "COMMIT";
      
      public static const ORDERDATA_LOAD_COMPLETE:String = "ORDERDATA_LOAD_COMPLETE";
      
      public static const PAGE_UPDATE:String = "PAGE_UPDATE";
      
      public static const UPDATEMOPUP:String = "UPDATEMOPUP";
      
      public static const UPDATEORDER:String = "UPDATEORDER";
      
      public var data:Object;
      
      public function RemotePetEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

