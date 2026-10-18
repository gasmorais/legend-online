package map.space.manager
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.campaign.CampaignReqMsg;
   import com.road.yishi.proto.campaign.HangupAttackMsg;
   import com.road.yishi.proto.campaign.PosMsg;
   import com.road.yishi.proto.campaign.SpacePlayerArmyInfoReqMsg;
   import com.road.yishi.proto.campaign.SpacePlayerMoveMsg;
   import com.road.yishi.proto.campaign.SpacePlayerMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.geom.Point;
   import map.space.SpaceManager;
   import map.space.data.SpaceArmy;
   import yishi.comm.PackageOut;
   import yishi.manager.ArmyManager;
   import yishi.service.managers.SocketManager;
   
   public class SpaceSocketOutManager
   {
      
      private static var _instance:SpaceSocketOutManager;
      
      public function SpaceSocketOutManager()
      {
         super();
      }
      
      public static function get instance() : SpaceSocketOutManager
      {
         if(!_instance)
         {
            _instance = new SpaceSocketOutManager();
         }
         return _instance;
      }
      
      public function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public function resetSpacePosition() : void
      {
         var _loc1_:PackageOut = new PackageOut(8700);
         sendProtoBuffer(_loc1_,null);
      }
      
      public function enterSpace(param1:int = 10000) : void
      {
         var _loc3_:PackageOut = new PackageOut(8688);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function leaveSpace(param1:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(8689);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function move(param1:Array) : void
      {
         var _loc6_:PosMsg = null;
         var _loc5_:PackageOut = new PackageOut(8690);
         var _loc2_:SpacePlayerMoveMsg = new SpacePlayerMoveMsg();
         var _loc4_:SpacePlayerMsg = new SpacePlayerMsg();
         _loc4_.playerId = ArmyManager.instance.army.userId;
         for each(var _loc3_:Point in param1)
         {
            _loc6_ = new PosMsg();
            _loc6_.x = _loc3_.x;
            _loc6_.y = _loc3_.y;
            _loc4_.path.push(_loc6_);
         }
         _loc2_.players.push(_loc4_);
         sendProtoBuffer(_loc5_,_loc2_);
      }
      
      public function nodeTrigger(param1:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(8692);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function requestPlayerInfos(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(8701);
         var _loc2_:SpacePlayerArmyInfoReqMsg = new SpacePlayerArmyInfoReqMsg();
         _loc2_.userList = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendMapPkInviteTo(param1:int) : void
      {
         var _loc3_:SpaceArmy = SpaceManager.instance.model.selfArmy;
         var _loc4_:PackageOut = new PackageOut(9547);
         var _loc2_:HangupAttackMsg = new HangupAttackMsg();
         _loc2_.op = 1;
         _loc2_.attackId = _loc3_.userId;
         _loc2_.attackName = _loc3_.nickName;
         _loc2_.defenceId = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc2_);
      }
      
      public function sendHolidayExchange(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9586);
         var _loc3_:CampaignReqMsg = new CampaignReqMsg();
         _loc3_.paraInt1 = param1;
         _loc3_.paraInt2 = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

