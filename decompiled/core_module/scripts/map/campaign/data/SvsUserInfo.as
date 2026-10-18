package map.campaign.data
{
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class SvsUserInfo
   {
      
      public var userId:int;
      
      public var nickName:String;
      
      public var teamUid:String;
      
      public var isEnterPvp:Boolean;
      
      public var isExist:Boolean;
      
      public var isOnline:Boolean;
      
      public var hasTeam:Boolean;
      
      public var grades:int;
      
      public var hostPlayer:int;
      
      public var job:int;
      
      public var fightPower:int;
      
      public var serverName:String;
      
      private var _thane:ThaneInfo;
      
      public function SvsUserInfo()
      {
         super();
         _thane = new ThaneInfo();
      }
      
      public function get thane() : ThaneInfo
      {
         _thane.userId = userId;
         _thane.nickName = nickName;
         _thane.job = job;
         _thane.fightingCapacity = fightPower;
         _thane.consortiaID = 1;
         _thane.serviceName = serverName;
         if(isOnline)
         {
            _thane.state = 7;
         }
         else
         {
            _thane.state = 0;
         }
         _thane.grades = grades;
         return _thane;
      }
   }
}

