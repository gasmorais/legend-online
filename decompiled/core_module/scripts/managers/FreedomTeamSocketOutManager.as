package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.team.JoinTeamReqMsg;
   import com.road.yishi.proto.team.JoinTeamResultMsg;
   import com.road.yishi.proto.team.MemberFightPos;
   import com.road.yishi.proto.team.MemberFightPosListMsg;
   import yishi.comm.PackageOut;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   
   public class FreedomTeamSocketOutManager
   {
      
      public function FreedomTeamSocketOutManager()
      {
         super();
      }
      
      public static function sendApplyInvite(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(8734);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = param1;
         _loc3_.param7 = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendChangeCaptain(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8736);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendInvite(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8738);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendKickMember(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8739);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendAFK() : void
      {
         var _loc1_:PackageOut = new PackageOut(8740);
         sendProtoBuffer(_loc1_);
      }
      
      public static function sendQuik() : void
      {
         var _loc1_:PackageOut = new PackageOut(8741);
         sendProtoBuffer(_loc1_);
      }
      
      public static function sendEditTeamFightPos(param1:Boolean = true, param2:Array = null) : void
      {
         var _loc6_:MemberFightPos = null;
         var _loc5_:Array = [];
         if(!param1)
         {
            for each(var _loc4_:Object in param2)
            {
               _loc6_ = new MemberFightPos();
               _loc6_.memberId = _loc4_.userId;
               _loc6_.pos = _loc4_.heroPos;
               _loc5_.push(_loc6_);
            }
         }
         var _loc7_:PackageOut = new PackageOut(8737);
         var _loc3_:MemberFightPosListMsg = new MemberFightPosListMsg();
         _loc3_.isGet = param1;
         _loc3_.memberPos = _loc5_;
         sendProtoBuffer(_loc7_,_loc3_);
      }
      
      public static function sendJoinTeam(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8807);
         var _loc2_:JoinTeamReqMsg = new JoinTeamReqMsg();
         _loc2_.tarUserId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendJoinTeamReply(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8808);
         var _loc3_:JoinTeamResultMsg = new JoinTeamResultMsg();
         _loc3_.opType = param1;
         if(param1 != 2)
         {
            _loc3_.applyUserId = param2;
         }
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      private static function get selfServerName() : String
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
      }
      
      public static function sendApplyInviteCross(param1:int, param2:Boolean, param3:String) : void
      {
         var _loc5_:PackageOut = new PackageOut(25135);
         var _loc4_:PropertyMsg = new PropertyMsg();
         _loc4_.param1 = param1;
         _loc4_.param4 = selfServerName;
         _loc4_.param5 = param3;
         _loc4_.param7 = param2;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendChangeCaptainCross(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(25136);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = param1;
         _loc3_.param4 = selfServerName;
         _loc3_.param5 = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendInviteCross(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(25138);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = param1;
         _loc3_.param4 = selfServerName;
         _loc3_.param5 = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendKickMemberCross(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(25139);
         var _loc3_:PropertyMsg = new PropertyMsg();
         _loc3_.param1 = param1;
         _loc3_.param4 = selfServerName;
         _loc3_.param5 = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendQuikCross() : void
      {
         var _loc2_:PackageOut = new PackageOut(25140);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param4 = selfServerName;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function sendEditTeamFightPosCross(param1:Boolean = true, param2:Array = null) : void
      {
         var _loc6_:MemberFightPos = null;
         var _loc5_:Array = [];
         if(!param1)
         {
            for each(var _loc4_:Object in param2)
            {
               _loc6_ = new MemberFightPos();
               _loc6_.memberId = _loc4_.userId;
               _loc6_.serverName = _loc4_.serverName;
               _loc6_.pos = _loc4_.heroPos;
               _loc5_.push(_loc6_);
            }
         }
         var _loc7_:PackageOut = new PackageOut(25137);
         var _loc3_:MemberFightPosListMsg = new MemberFightPosListMsg();
         _loc3_.isGet = param1;
         _loc3_.memberPos = _loc5_;
         _loc3_.serverName = selfServerName;
         sendProtoBuffer(_loc7_,_loc3_);
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message = null) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
   }
}

