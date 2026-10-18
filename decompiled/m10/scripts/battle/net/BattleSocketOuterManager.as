package battle.net
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.battle.AttackModeMsg;
   import com.road.yishi.proto.battle.BattleReqMsg;
   import com.road.yishi.proto.battle.QteMsg;
   import yishi.comm.PackageOut;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   
   public class BattleSocketOuterManager
   {
      
      public function BattleSocketOuterManager()
      {
         super();
      }
      
      public static function sendQTE(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(10015);
         var _loc2_:QteMsg = new QteMsg();
         _loc2_.serverName = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         _loc2_.battleId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public static function sendFightMode(param1:String, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(10016);
         var _loc3_:AttackModeMsg = new AttackModeMsg();
         _loc3_.serverName = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         _loc3_.battleId = param1;
         _loc3_.mode = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendEndBattle(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8727);
         var _loc2_:BattleReqMsg = new BattleReqMsg();
         _loc2_.battleId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

