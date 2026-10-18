package room.net
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.campaign.CampaignReqMsg;
   import com.road.yishi.proto.campaign.EnterTowerInfoMsg;
   import com.road.yishi.proto.campaign.TowerInfoReqMsg;
   import com.road.yishi.proto.room.RoomEditMsg;
   import com.road.yishi.proto.room.RoomReqMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   import yishi.view.tips.MessageTipManager;
   
   public class RoomSocketOuterManager
   {
      
      private static var _intervalTime:Number = 0;
      
      private static var _time:Number;
      
      public function RoomSocketOuterManager()
      {
         super();
      }
      
      public static function sendLockCampaignRoom(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(8344);
         var _loc3_:RoomEditMsg = new RoomEditMsg();
         _loc3_.roomId = param1;
         _loc3_.roomPwd = param2;
         sendProtoBuffer(_loc3_,_loc4_);
      }
      
      private static function sendProtoBuffer(param1:Message, param2:PackageOut) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param2,param1);
      }
      
      public static function resetTowerInfo(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8299);
         var _loc2_:TowerInfoReqMsg = new TowerInfoReqMsg();
         _loc2_.index = param1;
         sendProtoBuffer(_loc2_,_loc3_);
      }
      
      public static function enterTowerInfo(param1:int, param2:int = 1, param3:int = 1) : void
      {
         if(getTimer() - _intervalTime < 5000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _intervalTime = getTimer();
         var _loc5_:PackageOut = new PackageOut(8296);
         var _loc4_:EnterTowerInfoMsg = new EnterTowerInfoMsg();
         _loc4_.chooseIndex = param2;
         _loc4_.campaignId = param1;
         _loc4_.isDouble = param3;
         sendProtoBuffer(_loc4_,_loc5_);
      }
      
      public static function updateRoomInfo(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(5034);
         var _loc4_:RoomReqMsg = new RoomReqMsg();
         _loc4_.roomId = param1;
         _loc4_.dungeonId = param2;
         _loc4_.campaignId = param3;
         sendProtoBuffer(_loc4_,_loc5_);
      }
      
      public static function sendStartCampaignScene(param1:int = 0, param2:int = 0, param3:Function = null, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc7_:Number = getTimer();
         if(_loc7_ - _time < 3000)
         {
            if(param3 != null)
            {
               param3();
            }
            return;
         }
         _time = _loc7_;
         var _loc8_:PackageOut = new PackageOut(5039);
         var _loc6_:CampaignReqMsg = new CampaignReqMsg();
         if(param2 == 1)
         {
            _loc6_.paraInt1 = param2;
         }
         _loc6_.paraBool1 = param4;
         _loc6_.paraInt2 = param1;
         _loc6_.isCross = param5;
         sendProtoBuffer(_loc6_,_loc8_);
      }
      
      public static function sendPlayerState(param1:int, param2:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(5036);
         var _loc3_:RoomReqMsg = new RoomReqMsg();
         _loc3_.state = param1;
         _loc3_.isGet = param2;
         sendProtoBuffer(_loc3_,_loc4_);
      }
      
      public static function sendRoomState(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5037);
         var _loc2_:RoomReqMsg = new RoomReqMsg();
         _loc2_.state = param1;
         sendProtoBuffer(_loc2_,_loc3_);
      }
      
      public static function sendRoomInvite(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5028);
         var _loc2_:RoomReqMsg = new RoomReqMsg();
         _loc2_.userId = param1;
         sendProtoBuffer(_loc2_,_loc3_);
      }
      
      public static function sendCrossAlertResult(param1:int, param2:String, param3:String) : void
      {
         var _loc5_:PackageOut = new PackageOut(25157);
         var _loc4_:PropertyMsg = new PropertyMsg();
         _loc4_.param1 = param1;
         _loc4_.param5 = param2;
         _loc4_.param6 = param3;
         sendProtoBuffer(_loc4_,_loc5_);
      }
   }
}

