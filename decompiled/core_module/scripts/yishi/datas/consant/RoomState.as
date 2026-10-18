package yishi.datas.consant
{
   import manager.LanguageMgr;
   
   public class RoomState
   {
      
      public static const STATE_UNUSE:uint = 0;
      
      public static const STATE_USEING:uint = 1;
      
      public static const STATE_PLAYING:uint = 3;
      
      public static const STATE_COMPETEING:uint = 2;
      
      public function RoomState()
      {
         super();
      }
      
      public static function getStateName(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return LanguageMgr.GetTranslation("room.datas.RoomState.UNUSE");
            case 1:
               return LanguageMgr.GetTranslation("room.datas.RoomState.USEING");
            case 2:
               return LanguageMgr.GetTranslation("room.datas.RoomState.COMPETEING");
            case 3:
               return LanguageMgr.GetTranslation("room.datas.RoomState.PLAYING");
            default:
               return "";
         }
      }
      
      public static function getStateNameTips(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return LanguageMgr.GetTranslation("room.datas.RoomState.UNUSE01");
            case 1:
               return LanguageMgr.GetTranslation("room.datas.RoomState.USEING01");
            case 2:
               return LanguageMgr.GetTranslation("room.datas.RoomState.COMPETEING01");
            case 3:
               return LanguageMgr.GetTranslation("room.datas.RoomState.PLAYING01");
            default:
               return "";
         }
      }
   }
}

