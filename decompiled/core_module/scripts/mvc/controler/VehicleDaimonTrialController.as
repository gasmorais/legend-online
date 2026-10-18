package mvc.controler
{
   import com.netease.protobuf.Message;
   import com.pickgliss.ui.ComponentFactory;
   import com.road.yishi.proto.room.RoomMsg;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.RoomListSocketOutManager;
   import yishi.service.managers.SocketManager;
   
   public class VehicleDaimonTrialController extends FrameController
   {
      
      public function VehicleDaimonTrialController()
      {
         super();
      }
      
      private static function sendProtoBuffer(param1:Message, param2:PackageOut) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param2,param1);
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4370,__searchRoomHandler);
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4370,__searchRoomHandler);
      }
      
      private function __searchRoomHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:RoomMsg = new RoomMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as RoomMsg;
         if(_loc2_.isSetPassword)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("core.RoomPasswordFrame");
            _loc3_.backCall = inviteBackCall;
            _loc3_.show(_loc2_.roomId);
         }
         else
         {
            enterRoom(2,_loc2_.roomId,"",false);
         }
      }
      
      private function inviteBackCall(param1:int, param2:String) : void
      {
         enterRoom(2,param1,param2,false);
      }
      
      public function enterRoom(param1:int, param2:int, param3:String, param4:Boolean) : void
      {
         if(param1 == 2)
         {
            RoomListSocketOutManager.addRoomById(param1,param2,param3,param4);
         }
      }
      
      public function createRoom() : void
      {
         RoomListSocketOutManager.sendCreateRoom(4,2,"");
      }
      
      public function quickStart() : void
      {
         RoomListSocketOutManager.quickStart();
      }
      
      public function searchRoom(param1:int) : void
      {
         RoomListSocketOutManager.sendSearchRoomInfo(2,param1);
      }
      
      public function cancelStart() : void
      {
         RoomListSocketOutManager.cancelQuickStart();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
         if(_data.openType == 2)
         {
            removeEvent();
         }
         else
         {
            addEvent();
         }
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
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
         if(_data.openType == 2)
         {
            return "vehicle.VehicleRoomFrame";
         }
         return "vehicle.DaimonTrialFrame";
      }
      
      override protected function exitFrame() : void
      {
         removeEvent();
         super.exitFrame();
      }
      
      public function closeCurrentFrame() : void
      {
         if(_frame)
         {
            _frame.dispose();
         }
      }
   }
}

