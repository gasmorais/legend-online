package map.campaign.helper
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import map.campaign.view.ui.snowball.SnowballReportFrame;
   import mvc.module.sevenyear.SnowVehicleReportInfo;
   
   public class CampaignFrameHelper
   {
      
      public function CampaignFrameHelper()
      {
         super();
      }
      
      public static function showActiveVehicleAccoutFrameHandler(param1:SnowVehicleReportInfo) : void
      {
         var path:String;
         var snowInfo:SnowVehicleReportInfo = param1;
         var completeHandler:* = function(param1:LoaderInfo, param2:Object):void
         {
            var _loc3_:SnowballReportFrame = null;
            hasLoad = hasLoad + 1;
            if(hasLoad == list.length)
            {
               _loc3_ = ComponentFactory.Instance.createComponentGroupByStylename("map.campaign.view.ui.snowball.SnowballReportFrame");
               _loc3_.show(snowInfo);
            }
         };
         var hasLoad:int = 0;
         var list:Array = [ComponentSetting.getProjectSourcePath("3.png"),ComponentSetting.getUISourcePath("snowball")];
         for each(path in list)
         {
            LoaderManagerII.instance.load(path,3,0,completeHandler);
         }
      }
   }
}

