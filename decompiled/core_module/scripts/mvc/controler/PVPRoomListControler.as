package mvc.controler
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.road.yishi.proto.room.RoomListRspMsg;
   import com.road.yishi.proto.room.RoomMsg;
   import events.PVPRoomListEvent;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.pvproomlist.PVPRoomListModel;
   import mvc.module.room.RoomInfo;
   import yishi.comm.PackageIn;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.RoomListSocketOutManager;
   import yishi.service.managers.SocketManager;
   
   public class PVPRoomListControler extends FrameController
   {
      
      public var model:PVPRoomListModel;
      
      private var _searchFrame:Frame;
      
      public function PVPRoomListControler()
      {
         super();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 13,__roomListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4270,__updateRoomHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4370,__searchRoomHandler);
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 13,__roomListHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4270,__updateRoomHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4370,__searchRoomHandler);
      }
      
      private function __roomListHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:RoomMsg = null;
         var _loc6_:RoomInfo = null;
         model.roomList.splice(0,model.roomList.length);
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:RoomListRspMsg = new RoomListRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as RoomListRspMsg;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.room.length)
         {
            _loc4_ = _loc2_.room[_loc3_] as RoomMsg;
            _loc6_ = new RoomInfo();
            _loc6_.id = _loc4_.roomId;
            _loc6_.campaignId = _loc4_.campaignId;
            _loc6_.mapName = _loc4_.name;
            _loc6_.curCount = _loc4_.count;
            _loc6_.capacity = _loc4_.capacity;
            _loc6_.roomState = _loc4_.roomState;
            _loc6_.roomType = _loc4_.roomType;
            _loc6_.isLock = _loc4_.isSetPassword;
            model.addRoom(_loc6_,_loc3_,_loc2_.room.length);
            _loc3_++;
         }
         if(_loc2_.room.length == 0)
         {
            model.dispatchEvent(new PVPRoomListEvent("REFRESH_ROOM_LIST"));
         }
      }
      
      private function __updateRoomHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:RoomMsg = new RoomMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as RoomMsg;
         var _loc4_:RoomInfo = model.getRoomInfoById(_loc2_.roomId);
         if(_loc4_)
         {
            _loc4_.campaignId = _loc2_.campaignId;
            _loc4_.mapName = _loc2_.name;
            _loc4_.curCount = _loc2_.count;
            _loc4_.capacity = _loc2_.capacity;
            _loc4_.roomState = _loc2_.roomState;
            _loc4_.roomType = _loc2_.roomType;
            _loc4_.isLock = _loc2_.isSetPassword;
            _loc4_.commit();
            if(_loc4_.capacity == 0 || _loc4_.roomState == 3 || _loc4_.roomState == 2)
            {
               requestRoomInfo();
            }
         }
      }
      
      private function __searchRoomHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:RoomMsg = new RoomMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as RoomMsg;
         var _loc5_:RoomInfo = model.getRoomInfoById(_loc2_.roomId);
         if(_loc5_)
         {
            _loc5_.isLock = _loc2_.isSetPassword;
            _loc5_.commit();
         }
         if(_loc2_.isSetPassword)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("core.RoomPasswordFrame");
            _loc3_.backCall = inviteBackCall;
            _loc3_.show(_loc2_.roomId);
         }
         else
         {
            sendEnterRoom(1,_loc2_.roomId,"",false);
         }
      }
      
      private function inviteBackCall(param1:int, param2:String) : void
      {
         sendEnterRoom(1,param1,param2,false);
      }
      
      public function requestRoomInfo() : void
      {
         RoomListSocketOutManager.requestRoomList(1);
      }
      
      public function sendCreateRoom() : void
      {
         RoomListSocketOutManager.sendCreateRoom(3,1,"");
      }
      
      public function sendEnterRoom(param1:int, param2:int, param3:String, param4:Boolean) : void
      {
         if(param1 == 1)
         {
            RoomListSocketOutManager.addRoomById(param1,param2,param3,param4);
         }
      }
      
      public function sendSearchRoomInfo(param1:int, param2:int) : void
      {
         RoomListSocketOutManager.sendSearchRoomInfo(param1,param2);
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         if(!model)
         {
            model = new PVPRoomListModel();
         }
         addEvent();
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
         requestRoomInfo();
      }
      
      public function closeFrame() : void
      {
         if(_frame)
         {
            _frame.dispose();
         }
      }
      
      override public function get frameClassName() : String
      {
         return "pvproomlist.PVPRoomListFrame";
      }
      
      override protected function exitFrame() : void
      {
         model = null;
         removeEvent();
         super.exitFrame();
         if(_searchFrame && _searchFrame.parent)
         {
            _searchFrame.dispose();
         }
         _searchFrame = null;
      }
      
      public function openSearchFrame() : void
      {
         if(_searchFrame)
         {
            _searchFrame.dispose();
            _searchFrame = null;
         }
         _searchFrame = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.SearchRoomFrame");
         _searchFrame["show"]();
         _searchFrame.addEventListener("response",__frameCloseHandler);
      }
      
      private function __frameCloseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            (param1.currentTarget as Frame).dispose();
            (param1.currentTarget as Frame).removeEventListener("response",__frameCloseHandler);
            if(param1.currentTarget == _searchFrame)
            {
               _searchFrame = null;
            }
         }
      }
   }
}

