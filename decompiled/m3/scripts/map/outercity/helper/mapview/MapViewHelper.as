package map.outercity.helper.mapview
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import map.internals.data.template.MapTemplate;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.view.OuterCityMap;
   
   public class MapViewHelper
   {
      
      private static const startY:int = 0;
      
      private static const startX:int = -30;
      
      public function MapViewHelper()
      {
         super();
      }
      
      public static function mapMoveCheck(param1:Point) : Point
      {
         var _loc2_:OuterCityMap = OuterCityManager.instance.mapView;
         if(param1.x > -30)
         {
            param1.x = -30;
         }
         else if(param1.x < StageReferance.stageWidth - getMapTemplate.Width)
         {
            param1.x = StageReferance.stageWidth - getMapTemplate.Width;
         }
         if(param1.y > startY)
         {
            param1.y = startY;
         }
         else if(param1.y < StageReferance.stageHeight - getMapTemplate.Height)
         {
            param1.y = StageReferance.stageHeight - getMapTemplate.Height;
         }
         return param1;
      }
      
      public static function targetSolveCenter(param1:Point) : Point
      {
         var _loc2_:Point = new Point();
         _loc2_.x = int(StageReferance.stageWidth / 2 - param1.x);
         _loc2_.y = int(StageReferance.stageHeight / 2 - param1.y);
         return mapMoveCheck(_loc2_);
      }
      
      public static function checkDistance(param1:int, param2:int, param3:int, param4:int) : int
      {
         var _loc5_:Number = (param1 - param3) * (param1 - param3) + (param2 - param4) * (param2 - param4);
         return Math.sqrt(_loc5_);
      }
      
      public static function checkTargetPoint(param1:Point) : Point
      {
         var _loc2_:OuterCityMap = OuterCityManager.instance.mapView;
         if(param1.x + StageReferance.stageWidth > getMapTemplate.Width)
         {
            param1.x = getMapTemplate.Width - StageReferance.stageWidth;
         }
         if(param1.y + StageReferance.stageHeight > getMapTemplate.Height)
         {
            param1.y = getMapTemplate.Height - StageReferance.stageHeight;
         }
         if(-param1.x > -30)
         {
            param1.x = -30;
         }
         else
         {
            param1.x = -param1.x;
         }
         if(-param1.y > startY)
         {
            param1.y = startY;
         }
         else
         {
            param1.y = -param1.y;
         }
         return param1;
      }
      
      public static function getCurrentMapRect(param1:DisplayObject) : Rectangle
      {
         var _loc2_:Rectangle = new Rectangle();
         _loc2_.x = -param1.x + StageReferance.stageWidth / 2;
         _loc2_.y = -param1.y + StageReferance.stageHeight / 2;
         _loc2_.width = StageReferance.stageWidth;
         _loc2_.height = StageReferance.stageHeight;
         return _loc2_;
      }
      
      public static function getScreenRect(param1:DisplayObject, param2:int = 200) : Rectangle
      {
         var _loc3_:Rectangle = new Rectangle();
         _loc3_.x = -param1.x - param2;
         _loc3_.y = -param1.y - param2;
         _loc3_.width = StageReferance.stageWidth + param2 * 2;
         _loc3_.height = StageReferance.stageHeight + param2 * 2;
         return _loc3_;
      }
      
      public static function get getMapTemplate() : MapTemplate
      {
         return OuterCityManager.instance.model.mapTempInfo;
      }
   }
}

