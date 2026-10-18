package mvc.module.skytreasure
{
   public class SkyTreasureExchangeTemplateData
   {
      
      private var _actId:String;
      
      private var _templateId:int;
      
      private var _exchangeTimes:int;
      
      public function SkyTreasureExchangeTemplateData(param1:String, param2:int, param3:int)
      {
         super();
         _actId = param1;
         _templateId = param2;
         _exchangeTimes = param3;
      }
      
      public function get actId() : String
      {
         return _actId;
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function get exchangeNum() : int
      {
         return _exchangeTimes;
      }
      
      public function updateExchangeNum(param1:int) : void
      {
         _exchangeTimes = Math.max(0,param1);
      }
   }
}

