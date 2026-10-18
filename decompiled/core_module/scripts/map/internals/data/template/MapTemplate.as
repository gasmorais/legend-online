package map.internals.data.template
{
   public class MapTemplate
   {
      
      public static const NEW_MAP_ID:int = 100000;
      
      public var Id:int;
      
      public var CampaignId:int;
      
      public var MapName:String;
      
      public var Type:int;
      
      public var MinLevel:int;
      
      public var MaxLevel:int;
      
      public var MinArmyGrade:int;
      
      public var MaxArmyGrade:int;
      
      public var AreaId:int;
      
      public var AreaName:String;
      
      public var PreCampaign:String;
      
      public var PosX:int;
      
      public var PosY:int;
      
      public var Width:int;
      
      public var Height:int;
      
      public var MapFileId:int;
      
      public var Items:String;
      
      public var BattleGround:int;
      
      public var MusicPath:String;
      
      public var DungeonId:int;
      
      private var _district:int;
      
      public var CampaignTypes:int;
      
      public var Index:int;
      
      public var WinCondition:String;
      
      public var DifficultyGrade:int;
      
      public var Description:String;
      
      public var Path:String = "h_tree.png|v_tree.png";
      
      public var CardPayment:int;
      
      public var state:int;
      
      public var levelRect:String;
      
      public function MapTemplate()
      {
         super();
      }
      
      public function set District(param1:int) : void
      {
         _district = param1;
      }
      
      public function get District() : int
      {
         return _district;
      }
   }
}

