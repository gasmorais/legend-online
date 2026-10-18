package map.campaign.mediator.hero
{
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.view.physics.PvpWarFightArmyView;
   import map.internals.mediator.hero.MapBattleMovieMediater;
   
   public class BattleMovieMediator extends MapBattleMovieMediater
   {
      
      public function BattleMovieMediator()
      {
         super();
      }
      
      override public function register(param1:Object) : void
      {
         super.register(param1);
         if(data && target is PvpWarFightArmyView)
         {
            data.addEventListener("UPDATE_PVP_SCORE",__updatePvpScoreHandler);
            data.addEventListener("UPDATE_PVP_GESTE",__updatePvpGesteHandler);
         }
      }
      
      override public function unregister(param1:Object) : void
      {
         if(data && target is PvpWarFightArmyView)
         {
            data.removeEventListener("UPDATE_PVP_SCORE",__updatePvpScoreHandler);
            data.removeEventListener("UPDATE_PVP_GESTE",__updatePvpGesteHandler);
         }
         super.unregister(target);
      }
      
      private function __updatePvpScoreHandler(param1:CampaignMapEvent) : void
      {
         playScoreMovie(int(param1.data));
      }
      
      private function __updatePvpGesteHandler(param1:CampaignMapEvent) : void
      {
         playScoreMovie(int(param1.data),2);
      }
   }
}

