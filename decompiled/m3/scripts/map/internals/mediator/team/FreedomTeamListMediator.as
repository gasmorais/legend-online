package map.internals.mediator.team
{
   import com.pickgliss.ui.LayerManager;
   import map.internals.view.team.FreedomTeamListView;
   import yishi.interfaces.IMediator;
   
   public class FreedomTeamListMediator implements IMediator
   {
      
      private var _teamList:FreedomTeamListView;
      
      public function FreedomTeamListMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _teamList = new FreedomTeamListView();
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

