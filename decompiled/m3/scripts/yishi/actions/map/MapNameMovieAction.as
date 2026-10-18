package yishi.actions.map
{
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.internals.view.displaye.MapNameMovie;
   
   public class MapNameMovieAction extends MapBaseAction
   {
      
      private var _count:int;
      
      public function MapNameMovieAction()
      {
         super();
      }
      
      override public function update() : void
      {
         var _loc2_:int = 0;
         var _loc1_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(!_loc1_ || !_loc1_.mapTempInfo)
         {
            dispose();
            return;
         }
         if(_count == 0)
         {
            _loc2_ = int(CampaignManager.instance.mapModel.mapTempInfo.MapFileId);
            new MapNameMovie(dispose).loadIcon(_loc2_);
         }
         else if(_count > 25)
         {
            dispose();
         }
         _count = _count + 1;
      }
      
      override public function dispose() : void
      {
         _count = 0;
         super.dispose();
      }
   }
}

