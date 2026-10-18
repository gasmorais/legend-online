package planeswar.mediator
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.geom.Point;
   import mvc.module.planeswar.PlanesWarModel;
   import yishi.manager.PlanesWarManager;
   
   public class PlanesMapViewHelper
   {
      
      private static const startX:int = 0;
      
      private static const startY:int = 0;
      
      public function PlanesMapViewHelper()
      {
         super();
      }
      
      public static function mapMoveCheck(param1:Point) : Point
      {
         var _loc2_:int = (StageReferance.stageWidth - (model.COLUMN_NUM + 6) * 100) / 2;
         var _loc3_:int = (StageReferance.stageHeight - (model.ROW_NUM + 6) * 100) / 2;
         if(_loc2_ >= 0)
         {
            param1.x = _loc2_;
         }
         else if(param1.x > 0)
         {
            param1.x = 0;
         }
         else if(param1.x <= StageReferance.stageWidth - (model.COLUMN_NUM + 6) * 100)
         {
            param1.x = StageReferance.stageWidth - (model.COLUMN_NUM + 6) * 100;
         }
         if(_loc3_ >= 0)
         {
            param1.y = _loc3_;
         }
         else if(param1.y > 0)
         {
            param1.y = 0;
         }
         else if(param1.y <= StageReferance.stageHeight - (model.ROW_NUM + 6) * 100)
         {
            param1.y = StageReferance.stageHeight - (model.ROW_NUM + 6) * 100;
         }
         return param1;
      }
      
      public static function checkTargetPoint(param1:Point) : Point
      {
         if(param1.x + StageReferance.stageWidth > (model.COLUMN_NUM + 1) * 100)
         {
            param1.x = (model.COLUMN_NUM + 3) * 100 - StageReferance.stageWidth;
         }
         if(param1.y + StageReferance.stageHeight > (model.ROW_NUM + 1) * 100)
         {
            param1.y = (model.ROW_NUM + 3) * 100 - StageReferance.stageHeight;
         }
         if(-param1.x > 0)
         {
            param1.x = 0;
         }
         else
         {
            param1.x = -param1.x;
         }
         if(-param1.y > 0)
         {
            param1.y = 0;
         }
         else
         {
            param1.y = -param1.y;
         }
         return param1;
      }
      
      private static function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
   }
}

