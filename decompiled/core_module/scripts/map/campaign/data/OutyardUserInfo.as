package map.campaign.data
{
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class OutyardUserInfo
   {
      
      public var userUid:String;
      
      public var userId:int;
      
      public var nickName:String;
      
      public var defenceAlive:Boolean;
      
      public var defenceDebuffLevel:int;
      
      public var fightingCapacity:int;
      
      public var grades:int;
      
      public var firstChangeGrade:int;
      
      public var secondChangeGrade:int;
      
      public var changeBranch:int;
      
      public var job:int;
      
      private var _thane:ThaneInfo;
      
      public var index:int;
      
      public var alive:Boolean;
      
      public var inBattle:Boolean;
      
      public var isOnline:Boolean = true;
      
      public var vocationGrades:int;
      
      public var crossGuildTeamId:int;
      
      public function OutyardUserInfo()
      {
         super();
         _thane = new ThaneInfo();
      }
      
      public function get thane() : ThaneInfo
      {
         _thane.userId = userId;
         _thane.nickName = nickName;
         _thane.job = job;
         _thane.fightingCapacity = fightingCapacity;
         _thane.consortiaID = 1;
         _thane.grades = grades;
         _thane.state = 7;
         return _thane;
      }
      
      public function copy(param1:OutyardUserInfo) : OutyardUserInfo
      {
         param1.userUid = userUid;
         param1.userId = userId;
         param1.nickName = nickName;
         param1.defenceAlive = defenceAlive;
         param1.defenceDebuffLevel = defenceDebuffLevel;
         param1.fightingCapacity = fightingCapacity;
         param1.grades = grades;
         param1.firstChangeGrade = firstChangeGrade;
         param1.secondChangeGrade = secondChangeGrade;
         param1.changeBranch = changeBranch;
         param1.job = job;
         param1.isOnline = isOnline;
         return param1;
      }
   }
}

