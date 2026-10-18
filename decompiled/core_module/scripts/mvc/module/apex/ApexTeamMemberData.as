package mvc.module.apex
{
   import com.road.yishi.proto.apex.ApexTeamMemberMsg;
   
   public class ApexTeamMemberData
   {
      
      public var userId:int;
      
      public var fightPower:int;
      
      public var nickName:String;
      
      public var guildName:String;
      
      public var headPics:int;
      
      public var level:int;
      
      public var isCaptain:Boolean;
      
      public var teamId:int;
      
      public function ApexTeamMemberData(param1:ApexTeamMemberMsg)
      {
         super();
         userId = param1.userId;
         fightPower = param1.fightPower;
         nickName = param1.nickName;
         guildName = param1.guildName;
         headPics = param1.headPics;
         level = param1.level;
      }
   }
}

