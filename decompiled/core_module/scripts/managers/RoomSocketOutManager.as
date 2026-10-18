package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.campaign.CampaignReqMsg;
   import com.road.yishi.proto.room.RoomReqMsg;
   import manager.LanguageMgr;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class RoomSocketOutManager
   {
      
      public function RoomSocketOutManager()
      {
         super();
      }
      
      public static function sendChangeRoomOwner(param1:int, param2:String = "") : void
      {
         var _loc4_:PackageOut = new PackageOut(5030);
         var _loc3_:CampaignReqMsg = new CampaignReqMsg();
         _loc3_.paraInt1 = param1;
         _loc3_.paraString1 = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendKickPlayerAlert(param1:int, param2:String = "") : void
      {
         SimpleAlertHelper.instance.data = [kickPlayerAlertCallBack,param1,param2];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("room.manager.RoomSocketOutManager.content");
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc3_,_loc4_,true,false,false);
      }
      
      private static function kickPlayerAlertCallBack(param1:Boolean, param2:Boolean, param3:int, param4:String = "") : void
      {
         if(param1)
         {
            sendKickingInfo(param3,param4);
         }
      }
      
      public static function sendKickingInfo(param1:int, param2:String = "") : void
      {
         var _loc4_:PackageOut = new PackageOut(5031);
         var _loc3_:RoomReqMsg = new RoomReqMsg();
         _loc3_.userId = param1;
         _loc3_.nameKey = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendRequestTeamPos() : void
      {
         var _loc1_:PackageOut = new PackageOut(8278);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendRequestCrossTeamPos(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(25159);
         var _loc2_:RoomReqMsg = new RoomReqMsg();
         _loc2_.serverName = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendClose(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(5029);
         var _loc3_:RoomReqMsg = new RoomReqMsg();
         _loc3_.index = param1;
         _loc3_.open = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendCrossGoOn(param1:int, param2:int, param3:String) : void
      {
         var _loc5_:PackageOut = new PackageOut(25156);
         var _loc4_:RoomReqMsg = new RoomReqMsg();
         _loc4_.state = param1;
         _loc4_.userId = param2;
         _loc4_.serverName = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendInviteOther(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(9557);
         var _loc3_:RoomReqMsg = new RoomReqMsg();
         _loc3_.roomId = param1;
         _loc3_.isGet = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function send(param1:PackageOut) : void
      {
         SocketManager.instance.socket.send(param1);
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
   }
}

