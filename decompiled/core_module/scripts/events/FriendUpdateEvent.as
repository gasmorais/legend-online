package events
{
   import flash.events.Event;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class FriendUpdateEvent extends Event
   {
      
      public static const UPDATE_RECOMONDLIST:String = "UPDATE_RECOMONDLIST";
      
      public static const FRIEND_CHANGE:String = "friendchange";
      
      public static const FRIEND_UPDATE:String = "FRIEND_UPDATE";
      
      public static const ADD_FRIEND:String = "ADD_FRIEND";
      
      public static const REMOVE_FRIEND:String = "REMOVE_FRIEND";
      
      public static const ADD_RECENT_CONTACT:String = "ADD_RECENT_CONTACT";
      
      public static const RECENT_CONTACT_UPDATE:String = "RECENT_CONTACT_UPDATE";
      
      public static const CROSS_FRIENDS_UPDATE:String = "CROSS_FRIENDS_UPDATE";
      
      public static const INVITE_UPDATE:String = "INVITE_UPDATE";
      
      private var _data:Object;
      
      public function FriendUpdateEvent(param1:String, param2:Object = null)
      {
         _data = param2;
         super(param1,false,false);
      }
      
      public function get data() : ThaneInfo
      {
         return _data as ThaneInfo;
      }
      
      public function get object() : Object
      {
         return _data;
      }
   }
}

