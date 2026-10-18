package farm.view
{
   import farm.vo.FarmAnimationVO;
   import flash.display.Sprite;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class FarmAnimationLayer extends Sprite
   {
      
      public function FarmAnimationLayer()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("FARM_ARMY_ANIMATION",onPlayerAnimation);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("FARM_ARMY_ANIMATION",onPlayerAnimation);
      }
      
      private function onPlayerAnimation(param1:NotificationEvent) : void
      {
         var _loc2_:FarmAnimationVO = param1.data as FarmAnimationVO;
         var _loc5_:CampaignArmy = CampaignManager.instance.mapModel.allUserArmy["_" + _loc2_.armyId];
         var _loc3_:int = _loc5_.curPosX * 20;
         var _loc4_:int = _loc5_.curPosY * 20;
         createAnimation(_loc3_,_loc4_,_loc2_.value0,_loc2_.value1,_loc2_.name);
      }
      
      private function createAnimation(param1:int, param2:int, param3:int, param4:int, param5:String) : void
      {
         var _loc6_:FarmAnimationItem = new FarmAnimationItem(CampaignManager.instance.mapView,param1,param2,param3,param4,param5);
      }
      
      public function dispose() : void
      {
         removeEvent();
      }
   }
}

