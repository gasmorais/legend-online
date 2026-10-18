package mvc.module.groupfb
{
   import com.road.yishi.proto.marriage.MarriageOpMsg;
   import com.road.yishi.proto.marriage.PropertyListMsg;
   import managers.GroupfbManager;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class GroupfbSender
   {
      
      public static const TEAM_CREATE:int = 1;
      
      public static const TEAM_FIND:int = 2;
      
      public static const TEAM_LIST:int = 3;
      
      public static const TEAM_EXIT:int = 4;
      
      public static const TEAM_INVITE:int = 5;
      
      public static const TEAM_ENTER:int = 6;
      
      public static const TEAM_CAMPAIGN_START:int = 7;
      
      public static const TEAM_STATE_EDIT:int = 8;
      
      public static const UPDATE_NAME:int = 9;
      
      public static const UPDATE_PWD:int = 10;
      
      public static const CHANGE_MASTER:int = 11;
      
      public static const EDIT_FIGHT_POS:int = 12;
      
      public static const REMOVE_PLAYER:int = 13;
      
      public static const ROOM_INFO:int = 14;
      
      public static const CHANGE_TEAM:int = 15;
      
      public static const BOSS_REINFORCE:int = 16;
      
      public static const USE_INCOME:int = 17;
      
      public function GroupfbSender()
      {
         super();
      }
      
      public static function creatGroup() : void
      {
         var _loc2_:PackageOut = new PackageOut(8972);
         var _loc1_:MarriageOpMsg = new MarriageOpMsg();
         _loc1_.opType = 1;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public static function requestList() : void
      {
         var _loc2_:PackageOut = new PackageOut(8972);
         var _loc1_:MarriageOpMsg = new MarriageOpMsg();
         _loc1_.opType = 3;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public static function exitGroup() : void
      {
         var _loc2_:PackageOut = new PackageOut(8972);
         var _loc1_:MarriageOpMsg = new MarriageOpMsg();
         _loc1_.opType = 4;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public static function inviteGroup(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8972);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 5;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function searchRoom(param1:int, param2:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(8972);
         var _loc3_:MarriageOpMsg = new MarriageOpMsg();
         _loc3_.opType = 14;
         _loc3_.property1 = param1;
         _loc3_.property5 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function enterGroup(param1:int, param2:String = "", param3:Boolean = false, param4:Boolean = false) : void
      {
         var _loc6_:PackageOut = new PackageOut(8972);
         var _loc5_:MarriageOpMsg = new MarriageOpMsg();
         _loc5_.opType = 6;
         _loc5_.property1 = param1;
         _loc5_.property3 = param2;
         _loc5_.property5 = param3;
         _loc5_.isNoGet = param4;
         SocketManager.instance.socket.sendProtobuffer(_loc6_,_loc5_);
      }
      
      public static function startCampaign(param1:Boolean = false) : void
      {
         var _loc3_:PackageOut = new PackageOut(8972);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 7;
         _loc2_.isNoGet = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function editGroup(param1:int, param2:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(8972);
         var _loc3_:MarriageOpMsg = new MarriageOpMsg();
         _loc3_.opType = 8;
         _loc3_.property1 = param1;
         _loc3_.isNoGet = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function useIncome(param1:Boolean = false) : void
      {
         var _loc3_:PackageOut = new PackageOut(8972);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 17;
         _loc2_.isNoGet = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function renameCampaign(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8972);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 9;
         _loc2_.property3 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function changePassward(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8972);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 10;
         _loc2_.property3 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function changeMaster(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8972);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 11;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function editPos() : void
      {
         var _loc5_:PropertyListMsg = null;
         var _loc6_:PackageOut = new PackageOut(8972);
         var _loc1_:MarriageOpMsg = new MarriageOpMsg();
         _loc1_.opType = 12;
         var _loc2_:Vector.<GroupfbPlayerInfo> = GroupfbManager.instance.model.selfTeam.list;
         var _loc4_:Array = [];
         for each(var _loc3_:GroupfbPlayerInfo in _loc2_)
         {
            _loc5_ = new PropertyListMsg();
            _loc5_.property1 = _loc3_.userId;
            _loc5_.property2 = _loc3_.pos;
            _loc4_.push(_loc5_);
         }
         _loc1_.properties = _loc4_;
         SocketManager.instance.socket.sendProtobuffer(_loc6_,_loc1_);
      }
      
      public static function delPlayer(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8972);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 13;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function reinforce(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8972);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 16;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function changeTeam(param1:PropertyListMsg) : void
      {
         var _loc3_:PackageOut = new PackageOut(8972);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 15;
         _loc2_.properties.push(param1);
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
   }
}

