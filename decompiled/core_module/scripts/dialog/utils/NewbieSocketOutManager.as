package dialog.utils
{
   import battle.BattleManager;
   import com.road.yishi.proto.battle.BattleReqMsg;
   import com.road.yishi.proto.campaign.CallBackReqMsg;
   import com.road.yishi.proto.novice.NoviceReqMsgMsg;
   import yishi.comm.PackageOut;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   
   public class NewbieSocketOutManager
   {
      
      public function NewbieSocketOutManager()
      {
         super();
      }
      
      public static function sendSaveProcess(param1:int) : void
      {
         var _loc3_:PackageOut = null;
         var _loc2_:NoviceReqMsgMsg = null;
         if(param1 > 0)
         {
            PlayerManager.instance.newbieProcess = param1;
            _loc3_ = new PackageOut(5017);
            _loc2_ = new NoviceReqMsgMsg();
            _loc2_.noviceProcess = param1;
            SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
         }
      }
      
      public static function sendEnterCampaign(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5127);
         var _loc2_:NoviceReqMsgMsg = new NoviceReqMsgMsg();
         _loc2_.type = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function sendBattlePause() : void
      {
         var _loc2_:PackageOut = new PackageOut(10010);
         var _loc1_:BattleReqMsg = new BattleReqMsg();
         _loc1_.battleId = BattleManager.getInstance().battleModel.battleId;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public static function sendBattleContinue() : void
      {
         var _loc2_:PackageOut = new PackageOut(10022);
         var _loc1_:BattleReqMsg = new BattleReqMsg();
         _loc1_.battleId = BattleManager.getInstance().battleModel.battleId;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public static function sendInitBuildAndQueue() : void
      {
         var _loc1_:PackageOut = new PackageOut(8281);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
      
      public static function sendCallInCampaign(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(5032);
         var _loc4_:CallBackReqMsg = new CallBackReqMsg();
         _loc4_.mapId = param1;
         _loc4_.nodeId = param2;
         _loc4_.cmd = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function sendEnterCollectionBattle() : void
      {
         var _loc1_:PackageOut = new PackageOut(8699);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
   }
}

