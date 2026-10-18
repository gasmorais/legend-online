package map.campaign.helper.mapview
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   
   public class CampaignMapCenterCheckHelper
   {
      
      private static var _startX:int = -10;
      
      private static var _startY:int = -10;
      
      public function CampaignMapCenterCheckHelper()
      {
         super();
      }
      
      public static function checkOutScene(param1:Point) : Point
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(param1.x > _startX)
         {
            param1.x = _startX;
         }
         if(param1.y > _startY)
         {
            param1.y = _startY;
         }
         var _loc2_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc2_)
         {
            if(StageReferance.stageWidth > _loc2_.mapTempInfo.Width)
            {
               _loc4_ = (StageReferance.stageWidth - _loc2_.mapTempInfo.Width) / 2;
            }
            else
            {
               _loc4_ = StageReferance.stageWidth - _loc2_.mapTempInfo.Width;
            }
            if(StageReferance.stageHeight > _loc2_.mapTempInfo.Height)
            {
               _loc3_ = (StageReferance.stageHeight - _loc2_.mapTempInfo.Height) / 2;
            }
            else
            {
               _loc3_ = StageReferance.stageHeight - _loc2_.mapTempInfo.Height;
            }
         }
         else
         {
            _loc4_ = StageReferance.stageWidth - 100000;
            _loc3_ = StageReferance.stageHeight - 100000;
         }
         if(param1.x < _loc4_)
         {
            param1.x = _loc4_;
         }
         if(param1.y < _loc3_)
         {
            param1.y = _loc3_;
         }
         return param1;
      }
   }
}

