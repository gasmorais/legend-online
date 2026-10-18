package map.campaign.data
{
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class SteelUserInfo
   {
      
      public var teamUid:String;
      
      public var userId:int;
      
      public var nickName:String;
      
      public var grades:int;
      
      public var job:int;
      
      public var fightPower:int;
      
      public var hostPlayer:int;
      
      public var isEnter:int;
      
      public var isExist:Boolean;
      
      public var isOnline:Boolean;
      
      public var property1:String;
      
      public var property2:String;
      
      public var serverName:String;
      
      public var point:int;
      
      public var rank:int;
      
      private var _thane:ThaneInfo;
      
      public function SteelUserInfo()
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

