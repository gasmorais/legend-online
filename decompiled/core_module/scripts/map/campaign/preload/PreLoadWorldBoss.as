package map.campaign.preload
{
   import battle.BattleResPreloadManager;
   import map.campaign.data.CampaignMapModel;
   import yishi.manager.TempleteManager;
   
   public class PreLoadWorldBoss
   {
      
      private var _model:CampaignMapModel;
      
      public function PreLoadWorldBoss(param1:int, param2:int)
      {
         super();
         _model = new CampaignMapModel();
         _model.mapId = param1;
         preLoadMap();
      }
      
      private function preLoadMap() : void
      {
         new PreCampaignData(_model,true).syncBackCall(__loadMapCall);
      }
      
      private function __loadMapCall() : void
      {
         var _loc1_:int = TempleteManager.instance.mapTemplateCate.getTemplateByID(_model.mapId).BattleGround;
         BattleResPreloadManager.load([],[getHeroTempId],_loc1_);
      }
      
      private function get getHeroTempId() : int
      {
         var _loc1_:int = 0;
         switch(_model.mapId - 5001)
         {
            case 0:
            case 2:
               return 2001;
            case 1:
               return 2002;
            default:
               return 0;
         }
      }
   }
}

