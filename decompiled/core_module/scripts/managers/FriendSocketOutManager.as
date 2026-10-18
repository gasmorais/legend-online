package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.chat.RecentContractsStateReqMsg;
   import com.road.yishi.proto.friend.FriendRelationMsg;
   import com.road.yishi.proto.friend.MoveFriendReqMsg;
   import com.road.yishi.proto.friend.RelationGraphOpMsg;
   import com.road.yishi.proto.simple.FriendGroupMsg;
   import com.road.yishi.proto.simple.FriendSearchConditionReqMsg;
   import mvc.module.sns.BaseSnsInfo;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class FriendSocketOutManager
   {
      
      public function FriendSocketOutManager()
      {
         super();
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public static function send(param1:PackageOut) : void
      {
         SocketManager.instance.socket.send(param1);
      }
      
      public static function sendAddFriendRequest(param1:String, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(15003);
         var _loc3_:FriendRelationMsg = new FriendRelationMsg();
         _loc3_.nickName = param1;
         _loc3_.relation = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendFriendAddConfirm(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(15012);
         var _loc2_:FriendRelationMsg = new FriendRelationMsg();
         _loc2_.nickName = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendRemoveFriendRequest(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(15004);
         var _loc2_:FriendRelationMsg = new FriendRelationMsg();
         _loc2_.otherId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendRecommendFriend() : void
      {
         var _loc1_:PackageOut = new PackageOut(15013);
         send(_loc1_);
      }
      
      public static function sendAddGroup(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(15025);
         var _loc2_:FriendGroupMsg = new FriendGroupMsg();
         _loc2_.groupName = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendDelGroup(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(15026);
         var _loc2_:FriendGroupMsg = new FriendGroupMsg();
         _loc2_.groupId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendRenameGroup(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(15027);
         var _loc3_:FriendGroupMsg = new FriendGroupMsg();
         _loc3_.groupId = param1;
         _loc3_.groupName = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendMoveFriend(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(15028);
         var _loc3_:MoveFriendReqMsg = new MoveFriendReqMsg();
         _loc3_.firendId = param1;
         _loc3_.groupId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendReqChatState(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(15043);
         var _loc2_:RecentContractsStateReqMsg = new RecentContractsStateReqMsg();
         _loc2_.userId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendFindFriend(param1:BaseSnsInfo, param2:int) : void
      {
         var _loc4_:PackageOut = null;
         var _loc3_:FriendSearchConditionReqMsg = null;
         if(param1)
         {
            _loc4_ = new PackageOut(15042);
            _loc3_ = new FriendSearchConditionReqMsg();
            _loc3_.sex = param1.sex;
            _loc3_.birthMonth = param1.birthMonth;
            _loc3_.birthDay = param1.birthDay;
            _loc3_.starId = param1.horoscope;
            _loc3_.bloodType = param1.bloodType;
            _loc3_.country = param1.country;
            _loc3_.province = param1.province;
            _loc3_.city = param1.city;
            _loc3_.pageIndex = param2;
            SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
         }
      }
      
      public static function requestCrossFriendMsg(param1:int, param2:String = "", param3:String = "", param4:int = 1) : void
      {
         var _loc6_:PackageOut = new PackageOut(9606);
         var _loc5_:RelationGraphOpMsg = new RelationGraphOpMsg();
         _loc5_.op = param1;
         _loc5_.param1 = param2;
         _loc5_.param2 = param3;
         _loc5_.channel = param4;
         SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc5_);
      }
   }
}

