package yishi.manager
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.room.RoomReqMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   import yishi.view.tips.MessageTipManager;
   
   public class RoomListSocketOutManager
   {
      
      private static var _intervalTime:Number = 0;
      
      public function RoomListSocketOutManager()
      {
         super();
      }
      
      public static function requestRoomList(param1:int = 0, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(5026);
         var _loc3_:RoomReqMsg = new RoomReqMsg();
         _loc3_.roomType = param1;
         _loc3_.nameKey = param2.toString();
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function addRoomById(param1:int, param2:int, param3:String = "", param4:Boolean = false, param5:Boolean = false) : void
      {
         if(getTimer() - _intervalTime < 5000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _intervalTime = getTimer();
         var _loc7_:PackageOut = new PackageOut(5024);
         var _loc6_:RoomReqMsg = new RoomReqMsg();
         _loc6_.roomId = param2;
         _loc6_.password = param3;
         _loc6_.roomType = param1;
         _loc6_.isInvite = param4;
         _loc6_.isGet = param5;
         sendProtoBuffer(_loc7_,_loc6_);
      }
      
      public static function sendSearchRoomInfo(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8465);
         var _loc3_:RoomReqMsg = new RoomReqMsg();
         _loc3_.roomId = param2;
         _loc3_.roomType = param1;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendCreateRoom(param1:int, param2:int, param3:String) : void
      {
         if(getTimer() - _intervalTime < 5000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _intervalTime = getTimer();
         var _loc5_:PackageOut = new PackageOut(5023);
         var _loc4_:RoomReqMsg = new RoomReqMsg();
         _loc4_.capacity = param1;
         _loc4_.roomType = param2;
         _loc4_.password = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function quickStart() : void
      {
         var _loc1_:PackageOut = new PackageOut(8608);
         send(_loc1_);
      }
      
      public static function cancelQuickStart() : void
      {
         var _loc1_:PackageOut = new PackageOut(8609);
         send(_loc1_);
      }
      
      public static function sendSearchRoomState(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8780);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public static function send(param1:PackageOut) : void
      {
         SocketManager.instance.socket.send(param1);
      }
   }
}

