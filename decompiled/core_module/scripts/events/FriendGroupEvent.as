package events
{
   import flash.events.Event;
   
   public class FriendGroupEvent extends Event
   {
      
      public static const ADD_GROUP:String = "ADD_GROUP";
      
      public static const DEL_GROUP:String = "DEL_GROUP";
      
      public static const RENAME_GROUP:String = "RENAME_GROUP";
      
      public static const MOVE_FRIEND:String = "MOVE_FRIEND";
      
      public static const FRIEND_ITEM_SELECTED:String = "FRIEND_ITEM_SELECTED";
      
      private var _data:Object;
      
      private var _item:Object;
      
      public function FriendGroupEvent(param1:String, param2:Object, param3:Object = null)
      {
         super(param1);
         _data = param2;
         _item = param3;
      }
      
      override public function clone() : Event
      {
         return new FriendGroupEvent(type,data);
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

