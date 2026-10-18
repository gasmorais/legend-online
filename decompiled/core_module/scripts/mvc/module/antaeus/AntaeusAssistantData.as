package mvc.module.antaeus
{
   import com.road.yishi.proto.antaeus.AntaeusAssistantMsg;
   
   public class AntaeusAssistantData
   {
      
      public var userId:int;
      
      public var order:int;
      
      public var power:int;
      
      public var assists:int;
      
      public var showData:AntaeusShowData;
      
      private var assistantData:String;
      
      public function AntaeusAssistantData(param1:AntaeusAssistantMsg, param2:String)
      {
         super();
         userId = param1.userId;
         order = param1.order;
         power = param1.power;
         assists = param1.assists;
         this.assistantData = param2;
         if(param1.hasShowData)
         {
            showData = new AntaeusShowData(param1.showData);
         }
      }
      
      public function get assistCountForMe() : int
      {
         var _loc3_:Number = NaN;
         var _loc1_:Array = assistantData.split(",");
         for each(var _loc2_:String in _loc1_)
         {
            _loc3_ = Number(_loc2_.split("_")[0]);
            if(_loc3_ == userId)
            {
               return _loc2_.split("_")[1];
            }
         }
         return 0;
      }
      
      public function get assistShuttleCountForMe() : int
      {
         var _loc3_:Number = NaN;
         var _loc1_:Array = assistantData.split(",");
         for each(var _loc2_:String in _loc1_)
         {
            _loc3_ = Number(_loc2_.split("_")[0]);
            if(_loc3_ == userId)
            {
               return _loc2_.split("_")[2];
            }
         }
         return 0;
      }
   }
}

