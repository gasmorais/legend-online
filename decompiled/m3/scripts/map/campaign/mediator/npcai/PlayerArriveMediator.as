package map.campaign.mediator.npcai
{
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.view.physics.physicsview.CampaignNpcView;
   import map.internals.data.CampaignNode;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   
   public class PlayerArriveMediator implements IMediator, IEnterFrame
   {
      
      private var _target:CampaignNpcView;
      
      private var _node:CampaignNode;
      
      private var _mapModel:CampaignMapModel;
      
      private var _mapController:CampaignMapController;
      
      private var _visited:Boolean = false;
      
      public function PlayerArriveMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1 as CampaignNpcView;
         _node = _target.info as CampaignNode;
         _mapModel = CampaignManager.instance.mapModel;
         _mapController = CampaignManager.instance.controller;
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      public function unregister(param1:Object) : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _target = null;
         _node = null;
         _mapModel = null;
         _mapController = null;
      }
      
      public function enterFrame() : void
      {
         var _loc1_:CampaignArmy = _mapModel.selfMemberData;
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:Point = new Point(_loc1_.curPosX,_loc1_.curPosY);
         var _loc3_:Point = new Point(_node.curPosX,_node.curPosY);
         if(Point.distance(_loc2_,_loc3_) <= 12)
         {
            if(!_visited)
            {
               _visited = true;
               _mapController.sendCampaignArrive(_loc1_.id,_node.nodeId);
            }
         }
         else
         {
            _visited = false;
         }
      }
   }
}

