package map.campaign.data
{
   public class MineralCarInfo
   {
      
      public var ownerId:int = -1;
      
      public var armyId:int = -1;
      
      public var minerals:int = -1;
      
      public var quality:int = -1;
      
      public var get_count:int = -1;
      
      public var hand_count:int = -1;
      
      public var pick_count:int = -1;
      
      public var is_own:int = 0;
      
      public var isUpdate:Boolean;
      
      public function MineralCarInfo()
      {
         super();
      }
      
      public function get mineralType() : String
      {
         if(minerals == 0)
         {
            return "";
         }
         if(minerals < 200)
         {
            return "1";
         }
         return "2";
      }
   }
}

