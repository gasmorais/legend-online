package map.campaign.view.frame
{
   import flash.events.MouseEvent;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignEvent;
   import map.internals.data.MapPhysics;
   import map.internals.view.frame.TreasureFrameView;
   import map.net.MapSocketOuterManager;
   import mvc.module.armyII.BaseArmy;
   
   public class NpcInfoFrame extends TreasureFrameView
   {
      
      private var _mapModel:CampaignMapModel;
      
      public function NpcInfoFrame()
      {
         super();
      }
      
      override protected function __onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:CampaignArmy = CampaignManager.instance.mapModel.selfMemberData;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Array = CampaignManager.instance.mapModel.getNeighbor(_info.x,_info.y);
         CampaignManager.instance.mapModel.moveArmyToRange(_loc2_.id,_loc3_);
         dispose();
      }
      
      override public function show(param1:Object) : void
      {
         _info = param1 as MapPhysics;
         showFrame(param1);
         addEvent();
         getArmyInfo();
      }
      
      private function getArmyInfo() : void
      {
         MapSocketOuterManager.sendSelectCampaignArmy(2,_info.info.id);
      }
      
      override protected function addEvent() : void
      {
         _mapModel = CampaignManager.instance.mapModel;
         super.addEvent();
         _mapModel.addEventListener("GET_SYS_ARMY_INFO",__getArmyInfoHandler);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _mapModel.removeEventListener("GET_SYS_ARMY_INFO",__getArmyInfoHandler);
      }
      
      private function __getArmyInfoHandler(param1:CampaignEvent) : void
      {
         var _loc2_:BaseArmy = param1.data as BaseArmy;
         if(_loc2_.curPosX == _info.posX && _loc2_.curPosY == _info.posY && _loc2_.type == 5)
         {
            reArmyView(_loc2_);
         }
      }
   }
}

