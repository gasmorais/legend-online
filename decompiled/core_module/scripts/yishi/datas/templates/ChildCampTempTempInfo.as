package yishi.datas.templates
{
   public class ChildCampTempTempInfo
   {
      
      public var Id:int;
      
      public var Grade:int;
      
      public var StationedTime:int;
      
      public var StationedAward:String;
      
      public var SneakCount2:int;
      
      public var SneakAward2:String;
      
      public var SneakFinishAward2:String;
      
      public var SneakCount3:int;
      
      public var SneakAward3:String;
      
      public var SneakFinishAward3:String;
      
      public var Exp:int;
      
      public var Monster:String;
      
      public var Desc:String;
      
      public function ChildCampTempTempInfo()
      {
         super();
      }
      
      public function getSneakCountByDiff(param1:int) : int
      {
         if(param1 == 2)
         {
            return SneakCount2;
         }
         if(param1 == 3)
         {
            return SneakCount3;
         }
         return 0;
      }
      
      public function getSneakAwardByDiff(param1:int) : String
      {
         if(param1 == 2)
         {
            return SneakAward2;
         }
         if(param1 == 3)
         {
            return SneakAward3;
         }
         return null;
      }
      
      public function getSneakFinshiAward(param1:int) : String
      {
         if(param1 == 2)
         {
            return SneakFinishAward2;
         }
         if(param1 == 3)
         {
            return SneakFinishAward3;
         }
         return null;
      }
   }
}

