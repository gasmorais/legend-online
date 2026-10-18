package mvc.module.emailII
{
   import map.internals.data.template.MapTemplate;
   import yishi.manager.TempleteManager;
   
   public class BattleInfo
   {
      
      public static const ATTACKED:int = 1;
      
      public var type:int;
      
      public var content:String;
      
      public var camp:int;
      
      public var result:int;
      
      private var _time:String;
      
      public var playerName:String;
      
      public var siteName:String;
      
      public var pos:String;
      
      public var mapId:int;
      
      public var selfHeroId:int;
      
      public var selfSite1Name:String;
      
      public var selfSite1Count:int;
      
      public var selfSite2Name:String;
      
      public var selfSite2Count:int;
      
      public var selfStrengry:int;
      
      public var selfGold:int;
      
      public var selfFight:String;
      
      public var selfGrade:int;
      
      public var selfCrystal:int;
      
      public var enemyHeroId:int;
      
      public var enemySite1Name:String;
      
      public var enemySite1Count:int;
      
      public var enemySite2Name:String;
      
      public var enemySite2Count:int;
      
      public var enemyStrengry:int;
      
      public var enemyGold:int;
      
      public var enemyFight:String;
      
      public var enemyGrade:int;
      
      public var enemyCrystal:int;
      
      public function BattleInfo()
      {
         super();
      }
      
      public function get time() : String
      {
         return _time;
      }
      
      public function set time(param1:String) : void
      {
         _time = param1;
      }
      
      public function get mapName() : String
      {
         var _loc1_:MapTemplate = TempleteManager.instance.mapTemplateCate.getTemplateByID(mapId);
         return _loc1_ ? _loc1_.MapName : "";
      }
   }
}

