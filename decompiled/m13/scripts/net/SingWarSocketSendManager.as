package net
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.campaign.CampaignReqMsg;
   import com.road.yishi.proto.worldmap.WorldBossMsg;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   import yishi.view.tips.MessageTipManager;
   
   public class SingWarSocketSendManager
   {
      
      private static var _enterTime:Number = 0;
      
      private static var _time:Number;
      
      public function SingWarSocketSendManager()
      {
         super();
      }
      
      public static function enterWarfield(param1:int) : void
      {
         if(getTimer() - _enterTime < 5000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _enterTime = getTimer();
         var _loc3_:PackageOut = new PackageOut(8332);
         var _loc2_:WorldBossMsg = new WorldBossMsg();
         _loc2_.param1 = param1;
         sendProtoBuffer(_loc2_,_loc3_);
      }
      
      public static function sendRequestPvpRemainNumber(param1:int) : void
      {
         if(getTimer() - _enterTime < 5000)
         {
            return;
         }
         _enterTime = getTimer();
         var _loc3_:PackageOut = new PackageOut(8599);
         var _loc2_:CampaignReqMsg = new CampaignReqMsg();
         _loc2_.paraInt1 = param1;
         sendProtoBuffer(_loc2_,_loc3_);
      }
      
      private static function sendProtoBuffer(param1:Message, param2:PackageOut) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param2,param1);
      }
      
      public static function sendStartCampaignScene(param1:int = 0, param2:int = 0, param3:Function = null) : void
      {
         var _loc5_:Number = getTimer();
         if(_loc5_ - _time < 3000)
         {
            if(param3 != null)
            {
               param3();
            }
            return;
         }
         _time = _loc5_;
         var _loc6_:PackageOut = new PackageOut(5039);
         var _loc4_:CampaignReqMsg = new CampaignReqMsg();
         if(param2 == 1)
         {
            _loc4_.paraInt1 = param2;
         }
         _loc4_.paraInt2 = param1;
         sendProtoBuffer(_loc4_,_loc6_);
      }
   }
}

