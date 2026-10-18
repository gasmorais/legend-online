package mvc.module.apex
{
   import com.road.yishi.proto.apex.ApexBetPlayerMsg;
   
   public class ApexBetPlayerData
   {
      
      public var nickName:String;
      
      public var serverName:String;
      
      public var vipType:int;
      
      public var order:int;
      
      public function ApexBetPlayerData(param1:ApexBetPlayerMsg)
      {
         super();
         nickName = param1.nickName;
         serverName = param1.serverName;
         vipType = param1.vipType;
         order = param1.order;
      }
   }
}

