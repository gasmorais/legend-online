package events
{
   import flash.events.Event;
   
   public class SkyTreasureEvent extends Event
   {
      
      public static const SKYTREASURE_UPDATE_BOX_STATUS:String = "SKYTREASURE_UPDATE_BOX_STATUS";
      
      public static const SKYTREASURE_PLAYER_BOX_GOODS:String = "SKYTREASURE_PLAYER_BOX_GOODS";
      
      public static const SKYTREASURE_ADD_INTERGAL:String = "SKYTREASURE_ADD_INTERGAL";
      
      public static const SKYTREASURE_UPDATE_BAG:String = "SKYTREASURE_UPDATE_BAG";
      
      public static const SKYTREASURE_PLAYER_GRAIN:String = "SKYTREASURE_PLAYER_GRAIN";
      
      public static const SKYTREASURE_LOAD_RANK:String = "SKYTREASURE_LOAD_RANK";
      
      public static const SKYTREASURE_GET_INIT_INFO:String = "SKYTREASURE_GET_INIT_INFO";
      
      public static const SKYTREASURE_RANK_UPDATE:String = "SKYTREASURE_RANK_UPDATE";
      
      public static const SKYTREASURE_ACTIVES_INFO:String = "SKYTREASURE_ACTIVES_INFO";
      
      public static const SKYTREASURE_HIT_BOX:String = "SKYTREASURE_HIT_BOX";
      
      public static const SKYTREASURE_SPEEDUP:String = "SKYTREASURE_SPEEDUP";
      
      public static const SKYTREASURE_CREATE_BOX:String = "SKYTREASURE_CREATE_BOX";
      
      public static const SKYTREASURE_FINISH:String = "SKYTREASURE_FINISH";
      
      public static const SKY_TREASURE_RANKINFO_UPDATE:String = "SKY_TREASURE_RANKINFO_UPDATE";
      
      public static const SKY_TREASURE_RANKHISTORY_UPDATE:String = "SKY_TREASURE_RANKHISTORY_UPDATE";
      
      public static const SKY_TREASURE_LOTTERYINFO_UPDATE:String = "SKY_TREASURE_LOTTERYINFO_UPDATE";
      
      public static const SKY_TREASURE_LOTTERYRECORD_UPDATE:String = "SKY_TREASURE_LOTTERYRECORD_UPDATE";
      
      public static const SKY_TREASURE_EXCHANGEINFO_UPDATE:String = "SKY_TREASURE_EXCHANGEINFO_UPDATE";
      
      public static const SKY_TREASURE_EXCHANGETEMPLATEINFO_UPDATE:String = "SKY_TREASURE_EXCHANGETEMPLATEINFO_UPDATE";
      
      public static const SKY_TREASURE_ACTTEMPLATEINFO_UPDATE:String = "SKY_TREASURE_ACTTEMPLATEINFO_UPDATE";
      
      public var data:*;
      
      public function SkyTreasureEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

