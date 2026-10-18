package yishi.datas.templates
{
   public class GodArriveData
   {
      
      public var Id:int;
      
      public var CampaignId:int;
      
      public var NodeName:String;
      
      public var MasterType:int;
      
      public var SonType:int;
      
      public var Property1:int;
      
      public var Property2:int;
      
      public var Property3:int;
      
      public var Property4:int;
      
      public var HeroGP:int;
      
      public var Level:int;
      
      public var BattleType:int;
      
      public var StyleType:int;
      
      public var Formation:int;
      
      public var PatrolPos:String;
      
      public var AttackTypes:int;
      
      public var NameColor:int;
      
      public var SizeType:int;
      
      public var Param1:int;
      
      public var Param2:int;
      
      public var Param3:int;
      
      public var Param4:int;
      
      public var Param5:int;
      
      public var Param6:int;
      
      public var HeroIds:String;
      
      public function GodArriveData()
      {
         super();
      }
      
      public function get bossId() : int
      {
         return int(HeroIds.split(",")[0]);
      }
   }
}

