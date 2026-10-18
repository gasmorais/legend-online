package mvc.module.apex
{
   import com.road.yishi.proto.apex.ApexRankMsg;
   import com.road.yishi.proto.apex.ApexRankTeamMsg;
   
   public class ApexRankData
   {
      
      public var group:int;
      
      public var teamList:Array;
      
      public function ApexRankData(param1:ApexRankMsg)
      {
         super();
         group = param1.group;
         teamList = [];
         for each(var _loc2_:ApexRankTeamMsg in param1.teamList)
         {
            teamList.push(new ApexRankTeamData(_loc2_,group));
         }
      }
   }
}

