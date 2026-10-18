package mvc.module.groupfb
{
   import yishi.manager.PlayerManager;
   
   public class GroupfbModel
   {
      
      public var switchFlag:Boolean;
      
      public var roomList:Vector.<GroupfbRoomInfo>;
      
      public var selfTeam:GroupfbRoomInfo;
      
      public function GroupfbModel()
      {
         super();
         roomList = new Vector.<GroupfbRoomInfo>();
      }
      
      public function get hasGroupTeam() : Boolean
      {
         return selfTeam && selfTeam.selfInfo && selfTeam.state != 3;
      }
      
      public function get isCaptain() : Boolean
      {
         return hasGroupTeam && selfTeam.captainId == PlayerManager.instance.currentPlayerModel.playerInfo.userId;
      }
      
      public function get isWait() : Boolean
      {
         return hasGroupTeam && selfTeam.selfInfo.state == 1;
      }
      
      public function get isReady() : Boolean
      {
         return hasGroupTeam && selfTeam.selfInfo.state == 2;
      }
      
      public function get canStart() : Boolean
      {
         if(isCaptain == false)
         {
            return false;
         }
         for each(var _loc1_:GroupfbPlayerInfo in selfTeam.list)
         {
            if(_loc1_.state <= 1 && _loc1_.userId != selfTeam.captainId)
            {
               return false;
            }
         }
         return true;
      }
      
      public function getRoomInfoById(param1:int) : GroupfbRoomInfo
      {
         for each(var _loc2_:GroupfbRoomInfo in roomList)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

