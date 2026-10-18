package map.internals.constant
{
   public class PosType
   {
      
      public static const VILLAGE:int = 0;
      
      public static const CASTLE:int = 1;
      
      public static const STRONGHOLD:int = 2;
      
      public static const RESOURCE:int = 20;
      
      public static const NPC:int = 21;
      
      public static const TREASURE:int = 22;
      
      public static const COPY_START:int = 40;
      
      public static const COPY_END:int = 41;
      
      public static const COPY_NPC:int = 42;
      
      public static const SUBMIT_GOODS:int = 51;
      
      public static const PASS_CARD:int = 52;
      
      public static const ATTACK_HANDLER:int = 53;
      
      public static const COPY_HANDLER:int = 61;
      
      public static const COPY_MAP_SEND:int = 62;
      
      public static const COPY_NODE_SEND:int = 63;
      
      public static const COPY_AI:int = 64;
      
      public static const MOVE_NPC:int = 67;
      
      public static const COPY_LOGO:int = 71;
      
      public static const STATIC:int = 81;
      
      public static const COLLECTION:int = 91;
      
      public static const FALL_CHEST:int = 92;
      
      public static const UNKNOW:int = 100;
      
      public static const ROBOT:int = 101;
      
      public static const DIE_CROSSING:int = 121;
      
      public static const ENEMY_CROSSING:int = 131;
      
      public static const TOWER_DEFENCE:int = 141;
      
      public static const BOMBER_MAN:int = 151;
      
      public static const COPY_NPC_HANDLER:int = 161;
      
      public static const COPY_NODE_SEND2:int = 171;
      
      public static const TREASURE_HUNTER:int = 181;
      
      public static const MOVIE:int = 201;
      
      public static const FARM_BIG_FIRE:int = 1001;
      
      public static const FARM_SMALL_FIRE:int = 1002;
      
      public static const PET_BOSS_MONSTER:int = 1003;
      
      public static const TRANSPORT_CAR:int = 1101;
      
      public static const MINERAL_CAR:int = 1102;
      
      public static const HOOK_NODE:int = 111;
      
      public static const STEEL_VICE:int = 191;
      
      public static const STEEL_DOOR:int = 192;
      
      public static const STEEL_TOWER:int = 193;
      
      public static const STEEL_CITY_CENTER:int = 194;
      
      public static const STEEL_ENERGY_CRYSTAL:int = 195;
      
      public static const STEEL_MONSTER:int = 196;
      
      public static const STEEL_DESTNATION:int = 197;
      
      public static const UNREAL_SHOOTING_BOSS:int = 202;
      
      public static const UNREAL_SHOOTING_BUFF:int = 203;
      
      public static const UNREAL_SHOOTING_MONSTER:int = 204;
      
      public static const UNREAL_SHOOTING_SOLDIER:int = 205;
      
      public static const UNREAL_SHOOTING_TOWER:int = 206;
      
      public static const AIR_GARDEN_BED:int = 207;
      
      public static const ACTIVE_SNOW:int = 99998;
      
      public static const STEEL_PROPS:int = 99999;
      
      public function PosType()
      {
         super();
      }
      
      public static function checkSendType(param1:int) : Boolean
      {
         if(param1 == 62 || param1 == 63)
         {
            return true;
         }
         return false;
      }
      
      public static function checkNeutralState(param1:int) : Boolean
      {
         switch(param1)
         {
            case 61:
            case 62:
            case 92:
            case 2:
            case 53:
            case 40:
            case 67:
            case 91:
               break;
            default:
               return false;
         }
         return true;
      }
   }
}

