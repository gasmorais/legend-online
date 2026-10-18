package map.campaign.data
{
   public class FantasyMatrixNodeInfo
   {
      
      public var posX:int;
      
      public var posY:int;
      
      public var pawnLevel:int;
      
      public var pawnTempId:int;
      
      public var pawnSonType:int;
      
      public var showBox:Boolean;
      
      public var showSkillId:int;
      
      public var isFighting:Boolean;
      
      public var state:int;
      
      public function FantasyMatrixNodeInfo()
      {
         super();
      }
      
      public function get posId() : int
      {
         return posX * 5 + posY;
      }
   }
}

