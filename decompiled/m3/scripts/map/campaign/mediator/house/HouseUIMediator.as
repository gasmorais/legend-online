package map.campaign.mediator.house
{
   import battle.chat.FurnitureChatController;
   import com.pickgliss.ui.LayerManager;
   import farm.FarmManager;
   import map.campaign.view.CampaignMapView;
   import map.campaign.view.house.HouseUIView;
   import yishi.interfaces.IMediator;
   import yishi.manager.FrameControllerManager;
   
   public class HouseUIMediator implements IMediator
   {
      
      private var _houseUIView:HouseUIView;
      
      private var _mapView:CampaignMapView;
      
      private var _isAdd:Boolean;
      
      public function HouseUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _mapView = param1 as CampaignMapView;
         FarmManager.instance.model.defaultSelectedUserInfo();
         addHouseUIView();
         checkIsShowHomeFrame();
      }
      
      public function unregister(param1:Object) : void
      {
         if(_houseUIView)
         {
            _houseUIView.dispose();
         }
         _houseUIView = null;
         FarmManager.instance.model.showHomeFarmValue = 0;
         FarmManager.instance.model.curSelectedUserInfo = null;
         FarmManager.instance.model.masterId = 0;
         _mapView = null;
      }
      
      private function addHouseUIView() : void
      {
         if(_isAdd)
         {
            return;
         }
         _isAdd = true;
         _mapView.setFurniture();
         _houseUIView = new HouseUIView();
         FurnitureChatController.getInstance().container = _houseUIView;
         LayerManager.Instance.addToLayer(_houseUIView,4);
      }
      
      private function checkIsShowHomeFrame() : void
      {
         var _loc1_:int = int(FarmManager.instance.model.showHomeFarmValue);
         if(_loc1_ != 0)
         {
            FrameControllerManager.instance.openControllerByInfo("farm","HOME_NEW_FRAME",_loc1_);
         }
      }
   }
}

