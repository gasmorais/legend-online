package mvc.module.apex
{
   import com.road.yishi.proto.apex.ApexResultMsg;
   import com.road.yishi.proto.apex.ApexRewardMsg;
   import yishi.manager.TempleteManager;
   
   public class ApexResultData
   {
      
      public var rewardList:Array;
      
      public var selfScore:int;
      
      public var selfRank:int;
      
      public var currentGroup:int;
      
      public var nextGroup:int;
      
      public var awardStr:String;
      
      public function ApexResultData(param1:ApexResultMsg)
      {
         super();
         selfScore = param1.selfScore;
         selfRank = param1.selfRank;
         currentGroup = param1.currentGroup;
         nextGroup = param1.nextGroup;
         rewardList = [];
         awardStr = "";
         for each(var _loc2_:ApexRewardMsg in param1.rewardList)
         {
            rewardList.push([_loc2_.itemTempId,_loc2_.itemCount]);
            awardStr += TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.itemTempId).TemplateName + " *" + _loc2_.itemCount;
            awardStr += ",";
         }
         awardStr = awardStr.slice(0,awardStr.length - 1);
      }
   }
}

