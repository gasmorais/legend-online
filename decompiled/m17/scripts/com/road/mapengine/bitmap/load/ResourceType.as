package com.road.mapengine.bitmap.load
{
   public class ResourceType
   {
      
      public static const RESOURCE_X:int = 1;
      
      public static const RESOURCE_XY:int = 2;
      
      public static const RESOURCE_AVATA:int = 3;
      
      public static const RESOURCE_PLAYER:int = 4;
      
      public static const RESOURCE_NPC:int = 5;
      
      public static const RESOURCE_TANK:int = 6;
      
      public static const RESOURCE_VEHICLE_NPC:int = 7;
      
      public static const RESOURCE_NODE:int = 8;
      
      public static const RESOURCE_X_NAME:String = "X方向资源";
      
      public static const RESOURCE_XY_NAME:String = "XY方向资源";
      
      public static const RESOURCE_AVATA_NAME:String = "AVATAR资源";
      
      public static const RESOURCE_PLAYER_NAME:String = "Player资源";
      
      public static const RESOURCE_NPC_NAME:String = "NPC资源";
      
      public static const RESOURCE_TANK_NAME:String = "tank资源";
      
      public static const RESOURCE_VEHICLE_NPC_NAME:String = "载具中的npc";
      
      public function ResourceType()
      {
         super();
      }
      
      public static function checkResource(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return "X方向资源";
            case 1:
               return "XY方向资源";
            case 2:
               return "AVATAR资源";
            case 3:
               return "Player资源";
            case 4:
               return "NPC资源";
            case 5:
               return "tank资源";
            case 6:
               return "载具中的npc";
            default:
               return "";
         }
      }
   }
}

