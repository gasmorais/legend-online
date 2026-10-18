package mvc.module.room
{
   import events.RoomEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class SimpleRoomInfo extends EventDispatcher
   {
      
      public var id:int;
      
      public var mapName:String;
      
      public var roomDifficulty:int;
      
      public var capacity:int;
      
      public var roomType:int;
      
      public var isLock:Boolean;
      
      public var curCount:int;
      
      public var password:String;
      
      public var serverName:String = "";
      
      private var _placesState:Array;
      
      private var _roomState:int;
      
      public function SimpleRoomInfo(param1:IEventDispatcher = null)
      {
         super(param1);
         placesState = [0,0,0,0];
      }
      
      public function get placesState() : Array
      {
         return _placesState;
      }
      
      public function set placesState(param1:Array) : void
      {
         var _loc3_:int = 0;
         _placesState = param1;
         var _loc2_:int = 0;
         if(param1)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               if(param1[_loc3_] >= 0)
               {
                  _loc2_++;
               }
               _loc3_++;
            }
         }
         dispatchEvent(new RoomEvent("ROOM_PLACE_STATE_CHANGE",param1));
      }
      
      public function existEmptyPos() : Boolean
      {
         var _loc1_:int = 0;
         if(capacity <= 1)
         {
            return false;
         }
         _loc1_ = 0;
         while(_loc1_ < placesState.length)
         {
            if(placesState[_loc1_] == 0)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function get roomState() : int
      {
         return _roomState;
      }
      
      public function set roomState(param1:int) : void
      {
         _roomState = param1;
      }
      
      public function commit() : void
      {
         this.dispatchEvent(new RoomEvent("UPDATE_ROOM_BASE_DATA",this));
      }
   }
}

