package map.campaign.mediator.hero
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.campaign.PlayerNodeStateMsg;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.view.physics.CampaignArmyView;
   import map.internals.view.physics.MapPhysicsBase;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   
   public class TranseferWaitMediator implements IMediator, IEnterFrame
   {
      
      private var _cArmyView:CampaignArmyView;
      
      private var _cArmyData:CampaignArmy;
      
      private var _node:MapPhysicsBase;
      
      private var _nodeId:int;
      
      public function TranseferWaitMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cArmyView = param1 as CampaignArmyView;
         _cArmyData = _cArmyView.data;
         _cArmyData.addEventListener("transeferWaitState",__transeferWaitStateHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         if(_cArmyData)
         {
            _cArmyData.removeEventListener("transeferWaitState",__transeferWaitStateHandler);
         }
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      private function __transeferWaitStateHandler(param1:CampaignMapEvent) : void
      {
         var _loc2_:Object = param1.data;
         _node = CampaignManager.instance.mapModel.getNodeByNodeId(_loc2_.nodeId) as MapPhysicsBase;
         if(_node && _loc2_.state)
         {
            _nodeId = _loc2_.nodeId;
            EnterFrameManager.instance.registeEnterFrame(this);
         }
      }
      
      public function enterFrame() : void
      {
         var _loc1_:Point = new Point(_node.x,_node.y);
         var _loc2_:Point = new Point(_cArmyView.x,_cArmyView.y);
         if(Point.distance(_loc1_,_loc2_) > 100)
         {
            CampaignSocketOutManager.instance.sendTranseferState(sendTranseferState(_cArmyData.id,false,_cArmyData.mapId,_nodeId));
            EnterFrameManager.instance.unRegisteEnterFrame(this);
         }
      }
      
      public function sendTranseferState(param1:int, param2:Boolean, param3:int, param4:int) : Message
      {
         var _loc5_:PlayerNodeStateMsg = new PlayerNodeStateMsg();
         _loc5_.armyId = param1;
         _loc5_.isStand = param2;
         _loc5_.mapId = param3;
         _loc5_.nodeId = param4;
         return _loc5_;
      }
   }
}

