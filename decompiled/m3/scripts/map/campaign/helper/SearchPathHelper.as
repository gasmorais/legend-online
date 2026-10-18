package map.campaign.helper
{
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   
   public class SearchPathHelper
   {
      
      public function SearchPathHelper()
      {
         super();
      }
      
      public static function searchPath(param1:Point, param2:Point) : Array
      {
         return CampaignManager.instance.controller.findPath.find(new Point(int(param1.x / 20),int(param1.y / 20)),new Point(int(param2.x / 20),int(param2.y / 20)));
      }
      
      public static function astartFindPath(param1:Point, param2:Point) : Array
      {
         return CampaignManager.instance.mapModel.aStarPathFinder(param1,param2);
      }
      
      private static function getCurPoint(param1:int, param2:int) : Boolean
      {
         return CampaignManager.instance.mapModel.getWalkable(param1,param2);
      }
   }
}

