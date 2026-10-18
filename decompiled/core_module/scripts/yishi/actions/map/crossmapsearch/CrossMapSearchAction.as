package yishi.actions.map.crossmapsearch
{
   import battle.actions.common.BaseAction;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.internals.data.CampaignNode;
   import map.space.SpaceManager;
   import map.space.SpaceModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   
   public class CrossMapSearchAction extends BaseAction
   {
      
      public var mapId:int;
      
      public var toPoint:int;
      
      public var toPosition:Point;
      
      public function CrossMapSearchAction()
      {
         super();
      }
      
      override public function prepare() : void
      {
      }
      
      override public function update() : void
      {
         if(this.finished)
         {
            return;
         }
         var _loc1_:String = SceneManager.instance.currentType;
         if(_loc1_ == "SPACE_SCENE")
         {
            findSpacePath();
         }
         else if(!CampaignManager.instance.mapView)
         {
            NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchSceneHandler);
         }
         else
         {
            findPath();
         }
         finished = true;
      }
      
      private function __switchSceneHandler(param1:NotificationEvent) : void
      {
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__switchSceneHandler);
         findPath();
      }
      
      private function findSpacePath() : void
      {
         var _loc1_:SpaceModel = null;
         if(toPosition)
         {
            _loc1_ = SpaceManager.instance.model;
            if(_loc1_ && SpaceManager.instance.controller)
            {
               SpaceManager.instance.controller.moveArmyByPos(toPosition.x,toPosition.y);
            }
         }
         else
         {
            SpaceManager.instance.visitSpaceNPC(toPoint);
         }
      }
      
      private function findPath() : void
      {
         var _loc2_:CampaignNode = null;
         var _loc1_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc1_ && CampaignManager.instance.controller)
         {
            if(toPosition)
            {
               CampaignManager.instance.controller.moveArmyByPos(toPosition.x,toPosition.y);
            }
            else
            {
               _loc2_ = _loc1_.getMapNodeByNodeId(toPoint);
               if(_loc2_)
               {
                  CampaignManager.instance.mapModel.selectNode = _loc2_;
                  CampaignManager.instance.controller.moveArmyByPos(_loc2_.x,_loc2_.y,false,true);
               }
            }
         }
      }
   }
}

