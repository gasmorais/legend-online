package map.campaign.mediator.mapview
{
   import com.pickgliss.ui.LayerManager;
   import map.campaign.view.ui.TeamListView;
   import yishi.interfaces.IMediator;
   
   public class TeamListMediator implements IMediator
   {
      
      private var _teamList:TeamListView;
      
      public function TeamListMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _teamList = new TeamListView();
         LayerManager.Instance.addToLayer(_teamList,4,false,false,0,3);
      }
      
      public function unregister(param1:Object) : void
      {
         if(_teamList)
         {
            _teamList.dispose();
         }
         _teamList = null;
      }
   }
}

