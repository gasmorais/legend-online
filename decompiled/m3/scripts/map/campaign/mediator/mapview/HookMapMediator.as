package map.campaign.mediator.mapview
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import map.campaign.CampaignManager;
   import map.campaign.view.ui.HookTimeView;
   import yishi.interfaces.IMediator;
   
   public class HookMapMediator implements IMediator
   {
      
      private static var _view:HookTimeView;
      
      public function HookMapMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         if(!_view)
         {
            _view = new HookTimeView();
         }
         LayerManager.Instance.addToLayer(_view,4,false,false);
      }
      
      public function unregister(param1:Object) : void
      {
         if(CampaignManager.instance.exit)
         {
            ObjectUtils.disposeObject(_view);
            _view = null;
         }
         else
         {
            _view.parent && _view.parent.removeChild(_view);
         }
      }
   }
}

