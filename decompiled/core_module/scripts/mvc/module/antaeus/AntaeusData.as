package mvc.module.antaeus
{
   import com.road.yishi.proto.antaeus.AntaeusAssistantMsg;
   import com.road.yishi.proto.antaeus.AntaeusMsg;
   
   public class AntaeusData
   {
      
      public var userId:int;
      
      public var assistantData:String;
      
      public var assistantList:Array;
      
      public function AntaeusData(param1:AntaeusMsg)
      {
         super();
         assistantList = [];
         update(param1);
      }
      
      public function update(param1:AntaeusMsg) : void
      {
         userId = param1.userId;
         assistantData = param1.assistantData;
         if(param1.assistantList && param1.assistantList.length)
         {
            assistantList = [];
            for each(var _loc2_:AntaeusAssistantMsg in param1.assistantList)
            {
               assistantList.push(new AntaeusAssistantData(_loc2_,assistantData));
            }
            assistantList.sortOn("order",16);
         }
      }
      
      public function getDataByRank(param1:int) : AntaeusAssistantData
      {
         if(param1 <= assistantList.length)
         {
            return assistantList[param1 - 1];
         }
         return null;
      }
   }
}

