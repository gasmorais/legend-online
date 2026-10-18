package yishi.utils
{
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.view.tips.MessageTipManager;
   
   public class WorldMapHelper
   {
      
      public static const MAP1_ID:int = 1;
      
      public static const MAP2_ID:int = 2;
      
      public static const MAP3_ID:int = 3;
      
      public static const MAP4_ID:int = 4;
      
      public static const MAP5_ID:int = 5;
      
      public static const DEFAULT_ID:int = -1;
      
      public function WorldMapHelper()
      {
         super();
      }
      
      public static function tagNameToMapId(param1:String) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case "map1":
               _loc2_ = 1;
               break;
            case "map2":
               _loc2_ = 2;
               break;
            case "map3":
               _loc2_ = 3;
               break;
            case "map4":
               _loc2_ = 4;
               break;
            case "map5":
               _loc2_ = 5;
               break;
            default:
               _loc2_ = -1;
         }
         return _loc2_;
      }
      
      public static function chcekMapId(param1:int) : Boolean
      {
         switch(param1 - -1)
         {
            case 0:
               return noOpen();
            case 2:
               if(thane.grades >= 11)
               {
                  return true;
               }
               return noOpen();
               break;
            case 3:
               if(thane.grades >= 21)
               {
                  return true;
               }
               return noOpen();
               break;
            case 4:
               if(thane.grades >= 31)
               {
                  return true;
               }
               return noOpen();
               break;
            case 5:
               if(thane.grades >= 41)
               {
                  return true;
               }
               return noOpen();
               break;
            case 6:
               if(thane.grades >= 51)
               {
                  return true;
               }
               return noOpen();
               break;
            default:
               return true;
         }
      }
      
      private static function noOpen() : Boolean
      {
         var _loc1_:String = LanguageMgr.GetTranslation("worldmap.data.WorldMapHelper.command01");
         MessageTipManager.instance().show(_loc1_);
         return false;
      }
      
      private static function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

