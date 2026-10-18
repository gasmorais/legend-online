package map.campaign.mediator.petland
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import events.FreedomTeamEvent;
   import managers.FreedomTeamManager;
   import map.campaign.view.ui.petboss.PetBossInfoView;
   import yishi.interfaces.IMediator;
   
   public class PetBossUIMediator implements IMediator
   {
      
      private var _infoView:PetBossInfoView;
      
      public function PetBossUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         initView();
      }
      
      private function initView() : void
      {
         _infoView = new PetBossInfoView();
         _infoView.x = 0;
         _infoView.y = 200;
         LayerManager.Instance.addToLayer(_infoView,4);
      }
      
      private function __teamInfoUpdateHandler(param1:FreedomTeamEvent) : void
      {
         if(FreedomTeamManager.instance.hasTeam && Boolean(FreedomTeamManager.instance.showTeam))
         {
            _infoView.x = 0;
         }
         else
         {
            _infoView.x = 0;
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_infoView)
         {
            ObjectUtils.disposeObject(_infoView);
         }
         _infoView = null;
      }
   }
}

