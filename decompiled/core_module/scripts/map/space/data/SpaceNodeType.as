package map.space.data
{
   public class SpaceNodeType
   {
      
      public static const STATIC:int = 0;
      
      public static const MOVEMENT:int = 1;
      
      public static const BORN_POINT:int = 40;
      
      public static const TRIGGER:int = 42;
      
      public static const TRANSFER:int = 62;
      
      public static const TREASURE_MAP:int = 191;
      
      public static const PARAM_TRANSFER:int = 2;
      
      public static const ID_OFFER_REWARD:int = 1;
      
      public static const ID_PVE_ROOMLIST:int = 2;
      
      public static const ID_PET_CHALLENGE:int = 3;
      
      public static const ID_PET_EXCHANGE:int = 5;
      
      public static const ID_PVP:int = 6;
      
      public static const ID_SUPER_MARKET:int = 8;
      
      public static const ID_AMETHYST_FIELD:int = 15;
      
      public static const ID_RING_TASK:int = 17;
      
      public static const RAPID_THROUGH:int = 19;
      
      public static const ID_SINGLE_PASS:int = 20;
      
      public static const ID_VEHICLE_DAIMON_TRAIL:int = 23;
      
      public static const ID_HOOKROOM:int = 24;
      
      public static const ID_MOLONG:int = 26;
      
      public static const ID_MONOPOLY:int = 27;
      
      public static const ID_CHILD:int = 28;
      
      public static const ID_REMOTE_PET:int = 31;
      
      public static const ID_SACRIFICE_ROOM:int = 99;
      
      public static const ID_FARM_BIG_BONFIRE:int = 1001;
      
      public static const ID_FARM_SMALL_BONFIRE:int = 1002;
      
      public static const ID_MARRY_CAR:int = 9999;
      
      public static const ID_HOLIDAY_NPC:int = 32;
      
      public static const ID_OUTYARD_NPC_1:int = 35;
      
      public static const ID_OUTYARD_NPC_2:int = 36;
      
      public static const ID_ECLIPTIC_PALACE:int = 45;
      
      public static const ID_ANTAEUS:int = 47;
      
      public static const ID_MONSTER_EXPLORE:int = 48;
      
      public static const ID_FORBIDDEN_BOSS:int = 49;
      
      public static const ID_REDEPTION_ROAD:int = 50;
      
      public static const ID_REVENGE_ROAD:int = 51;
      
      public static const ID_GAMEBOX:int = 44;
      
      public function SpaceNodeType()
      {
         super();
      }
      
      public static function isYearNode(param1:int) : Boolean
      {
         return param1 >= 300 && param1 <= 315 || param1 == 410;
      }
   }
}

