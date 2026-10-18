package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.campaign.OprateReplacemntMsg;
   import com.road.yishi.proto.player.PayTypeMsg;
   import com.road.yishi.proto.worldmap.WorldBossMsg;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   import yishi.view.tips.MessageTipManager;
   
   public class WorldBossSocketOutManager
   {
      
      private static var _intervalTime:Number = 0;
      
      public function WorldBossSocketOutManager()
      {
         super();
      }
      
      public static function sendWorldBossCmd(param1:int) : void
      {
         if(getTimer() - _intervalTime < 5000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _intervalTime = getTimer();
         var _loc3_:PackageOut = new PackageOut(8258);
         var _loc2_:WorldBossMsg = new WorldBossMsg();
         _loc2_.param1 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function reqWorldBossCmd(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8259);
         var _loc2_:WorldBossMsg = new WorldBossMsg();
         _loc2_.mapId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function reqWorldBossStates() : void
      {
         var _loc1_:PackageOut = new PackageOut(8271);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendRiver(param1:Boolean = true) : void
      {
         var _loc3_:PackageOut = new PackageOut(8264);
         var _loc2_:PayTypeMsg = new PayTypeMsg();
         _loc2_.payType = 0;
         if(!param1)
         {
            _loc2_.payType = 1;
         }
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendEnterBattle(param1:Boolean = true) : void
      {
         var _loc3_:PackageOut = new PackageOut(8264);
         var _loc2_:PayTypeMsg = new PayTypeMsg();
         _loc2_.payType = 0;
         if(!param1)
         {
            _loc2_.payType = 1;
         }
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendBuyStunmanFor(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8526);
         var _loc2_:OprateReplacemntMsg = new OprateReplacemntMsg();
         _loc2_.op = 1;
         _loc2_.campaignId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendCancelStunmanFor(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8526);
         var _loc2_:OprateReplacemntMsg = new OprateReplacemntMsg();
         _loc2_.op = 2;
         _loc2_.campaignId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
   }
}

