package mvc.module.skytreasure
{
   public class SkyTreasureGradeInfo
   {
      
      public var rank:int;
      
      public var server:String;
      
      public var name:String;
      
      public var grade:int;
      
      public function SkyTreasureGradeInfo(param1:int, param2:String, param3:String, param4:int)
      {
         super();
         this.rank = param1;
         this.server = param2;
         this.name = param3;
         this.grade = param4;
      }
   }
}

