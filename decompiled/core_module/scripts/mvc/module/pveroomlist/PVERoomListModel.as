package mvc.module.pveroomlist
{
   import events.PVERoomListEvent;
   import flash.events.EventDispatcher;
   import mvc.module.room.RoomInfo;
   
   public class PVERoomListModel extends EventDispatcher
   {
      
      public static var OPEN_ROOMINVITEFRAME:int = 1;
      
      public static var OPEN_QUICKINVITEFRAME:int = 2;
      
      public var roomList:Vector.<RoomInfo>;
      
      public var searchId:int;
      
      public function PVERoomListModel()
      {
         super();
         roomList = new Vector.<RoomInfo>();
      }
      
      public function addRoom(param1:RoomInfo, param2:int, param3:int) : void
      {
         roomList.push(param1);
         if(param2 == param3 - 1)
         {
            dispatchEvent(new PVERoomListEvent("REFRESH_ROOM_LIST"));
         }
      }
      
      public function getRoomInfoById(param1:int) : RoomInfo
      {
         for each(var _loc2_:RoomInfo in roomList)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

