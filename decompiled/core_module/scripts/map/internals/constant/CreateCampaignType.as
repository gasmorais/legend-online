package map.internals.constant
{
   public class CreateCampaignType
   {
      
      public static const CREATE_TYPE_CREATE:int = 1;
      
      public static const CREATE_TYPE_ENTER:int = 2;
      
      public static const CREATE_TYPE_TRANS:int = 3;
      
      public static const CREATE_TYPE_INVENT:int = 4;
      
      public static const CAMPAIGN_GAME:int = -1;
      
      public function CreateCampaignType()
      {
         super();
      }
      
      public static function checkGoToTeamChat(param1:int) : Boolean
      {
         switch(param1 - 1)
         {
            case 0:
            case 3:
               return true;
            default:
               return false;
         }
      }
   }
}

