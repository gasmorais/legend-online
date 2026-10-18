package mvc.module.singlecampaign
{
   import map.internals.data.template.MapTemplate;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.manager.TempleteManager;
   
   public class SingleCampaignModel
   {
      
      private var _mapId:int;
      
      public var curIndex:int;
      
      public var campaignTemp:CampaignTemplate;
      
      public function SingleCampaignModel()
      {
         super();
      }
      
      public function get mapId() : int
      {
         return _mapId;
      }
      
      public function set mapId(param1:int) : void
      {
         _mapId = param1;
         var _loc2_:MapTemplate = TempleteManager.instance.mapTemplateCate.getTemplateByID(_mapId);
         campaignTemp = TempleteManager.instance.campaignTemplateDic[_loc2_.CampaignId];
      }
      
      public function get campaignId() : int
      {
         return campaignTemp ? campaignTemp.CampaignId : 0;
      }
   }
}

