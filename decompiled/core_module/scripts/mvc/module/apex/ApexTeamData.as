package mvc.module.apex
{
   import com.road.yishi.proto.apex.ApexTeamMemberMsg;
   import com.road.yishi.proto.apex.ApexTeamMsg;
   import yishi.manager.ApexManager;
   import yishi.manager.ArmyManager;
   
   public class ApexTeamData
   {
      
      public var teamId:int;
      
      public var captainId:int;
      
      public var members:Array;
      
      public var isSelfTeam:Boolean;
      
      public var captain:ApexTeamMemberData;
      
      public function ApexTeamData(param1:ApexTeamMsg)
      {
         var _loc2_:ApexTeamMemberData = null;
         super();
         teamId = param1.teamId;
         captainId = param1.captainId;
         members = [];
         isSelfTeam = false;
         for each(var _loc3_:ApexTeamMemberMsg in param1.members)
         {
            _loc2_ = new ApexTeamMemberData(_loc3_);
            _loc2_.teamId = param1.teamId;
            if(_loc2_.userId == param1.captainId)
            {
               captain = _loc2_;
               _loc2_.isCaptain = true;
            }
            else
            {
               members.push(_loc2_);
            }
            if(_loc2_.userId == ArmyManager.instance.thane.userId)
            {
               isSelfTeam = true;
               ApexManager.instance.model.myTeamPlayer = _loc2_;
            }
         }
         members.unshift(captain);
      }
      
      public function getMemberByIndex(param1:int) : ApexTeamMemberData
      {
         if(members[param1])
         {
            return members[param1];
         }
         return null;
      }
      
      public function hasMember(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         for each(var _loc3_:ApexTeamMemberData in members)
         {
            if(_loc3_.userId == param1)
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
   }
}

