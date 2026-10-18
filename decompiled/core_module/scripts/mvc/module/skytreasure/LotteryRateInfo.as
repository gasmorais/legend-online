package mvc.module.skytreasure
{
   public class LotteryRateInfo
   {
      
      public var templateId:int;
      
      public var templateType:int;
      
      public var Templatecount:int;
      
      public var Templateshow:int;
      
      public var rate:String;
      
      public function LotteryRateInfo(param1:int, param2:int, param3:int, param4:int, param5:String)
      {
         super();
         this.templateId = param1;
         this.templateType = param2;
         this.Templatecount = param3;
         this.Templateshow = param4;
         this.rate = param5;
      }
   }
}

