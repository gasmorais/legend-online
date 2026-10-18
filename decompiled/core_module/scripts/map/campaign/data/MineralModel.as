package map.campaign.data
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import map.campaign.event.CampaignEvent;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   
   public class MineralModel extends EventDispatcher
   {
      
      public var activeTime:int;
      
      public var maxCount:int;
      
      public var multiple:int;
      
      private var _carInfos:Dictionary;
      
      public function MineralModel(param1:IEventDispatcher = null)
      {
         super(param1);
         _carInfos = new Dictionary();
      }
      
      public function get carInfos() : Dictionary
      {
         return _carInfos;
      }
      
      public function resetCarInfos() : void
      {
         for each(var _loc1_:MineralCarInfo in _carInfos)
         {
            _loc1_.isUpdate = false;
         }
      }
      
      public function addCarInfo(param1:MineralCarInfo) : void
      {
         _carInfos[param1.ownerId] = param1;
      }
      
      public function getCarInfoById(param1:int) : MineralCarInfo
      {
         return _carInfos[param1] as MineralCarInfo;
      }
      
      public function get selfCarInfo() : MineralCarInfo
      {
         return carInfos[playerInfo.userId];
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function updateCar(param1:CampaignArmy) : void
      {
         dispatchEvent(new CampaignEvent("UPDATE_MINERAL_CAR",param1));
      }
      
      public function commit() : void
      {
         for each(var _loc1_:MineralCarInfo in _carInfos)
         {
            if(!_loc1_.isUpdate)
            {
               delete _carInfos[_loc1_.ownerId];
            }
         }
         dispatchEvent(new CampaignEvent("UPDATE_MINERAL_INFO",null));
      }
   }
}

