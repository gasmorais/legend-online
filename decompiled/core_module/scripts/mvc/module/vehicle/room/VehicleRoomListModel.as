package mvc.module.vehicle.room
{
   import events.RoomEvent;
   import flash.events.EventDispatcher;
   import mvc.module.room.RoomInfo;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   
   public class VehicleRoomListModel extends EventDispatcher
   {
      
      private var _roomList:Vector.<RoomInfo> = new Vector.<RoomInfo>();
      
      private var _currentPageIndex:int;
      
      public function VehicleRoomListModel()
      {
         super();
      }
      
      public function get roomList() : Vector.<RoomInfo>
      {
         return _roomList;
      }
      
      public function set roomList(param1:Vector.<RoomInfo>) : void
      {
         if(param1)
         {
            _roomList = param1;
         }
         else
         {
            _roomList = new Vector.<RoomInfo>();
         }
         this.dispatchEvent(new RoomEvent("REFRESH_ROOM_LIST",this));
      }
      
      public function getRoomInfo(param1:int) : RoomInfo
      {
         for each(var _loc2_:RoomInfo in _roomList)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get playerList() : SimpleDictionary
      {
         return PlayerManager.instance.watingList;
      }
      
      public function get currentPageIndex() : int
      {
         return _currentPageIndex;
      }
      
      public function set currentPageIndex(param1:int) : void
      {
         if(param1 < 0)
         {
            _currentPageIndex = 0;
         }
         else
         {
            _currentPageIndex = param1;
         }
      }
   }
}

