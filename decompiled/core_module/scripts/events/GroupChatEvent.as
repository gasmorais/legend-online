package events
{
   import flash.events.Event;
   
   public class GroupChatEvent extends Event
   {
      
      public static const CONSORTIA_GROUPCHAT_UPDATE:String = "consortiagroupchatupdate";
      
      public static const CONSORTIA_GROUPCHAT_ITEM_SELECTED:String = "consortiagroupchatitemselected";
      
      public static const CONSORTIA_GROUPCHAT_ITEM_UPDATE:String = "consortiagroupchatitemupdate";
      
      private var _data:Object;
      
      private var _item:Object;
      
      public function GroupChatEvent(param1:String, param2:Object, param3:Object = null)
      {
         super(param1,false,false);
         _data = param2;
         _item = param3;
      }
      
      override public function clone() : Event
      {
         return new GroupChatEvent(type,data);
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get item() : Object
      {
         return _item;
      }
   }
}

