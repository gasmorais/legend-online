package map.campaign.view.physics
{
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.action.UnrealShootingShootAction;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.skill.MapSkillResultInfo;
   import map.campaign.view.physics.physicsview.CampaignNpcView;
   import map.internals.data.CampaignNode;
   import map.internals.data.MapPhysics;
   import map.internals.data.PhysicsEvent;
   import yishi.interfaces.IAction;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.ActionQueueManager;
   import yishi.manager.EnterFrameManager;
   import yishi.utils.AsynActionManager;
   
   public class UnrealShootingNpcPhysics extends CampaignNpcView implements IEnterFrame
   {
      
      private var _actionQueue:ActionQueueManager;
      
      private var _asynActionMgr:AsynActionManager;
      
      private var _controller:CampaignMapController;
      
      private var _mapModel:CampaignMapModel;
      
      public var isAttack:Boolean;
      
      public function UnrealShootingNpcPhysics()
      {
         super();
         _controller = CampaignManager.instance.controller;
         _mapModel = CampaignManager.instance.mapModel;
         _actionQueue = new ActionQueueManager();
         _asynActionMgr = new AsynActionManager();
      }
      
      public function enterFrame() : void
      {
         if(_actionQueue)
         {
            _actionQueue.update();
         }
         if(_asynActionMgr)
         {
            _asynActionMgr.update();
         }
      }
      
      public function addAction(param1:IAction, param2:Boolean = false) : void
      {
         if(!_actionQueue || !_asynActionMgr)
         {
            return;
         }
         if(param2)
         {
            _asynActionMgr.addAction(param1);
         }
         else
         {
            _actionQueue.addAction(param1);
         }
      }
      
      override public function set info(param1:MapPhysics) : void
      {
         node = param1 as CampaignNode;
         super.info = param1;
         info.addEventListener("ADD_BUFF",__onAddBuffHandler);
         info.addEventListener("USE_SKILL",__onUseSkillHandler);
         EnterFrameManager.instance.registeEnterFrame(this);
         __updateCurHpHandler(null);
      }
      
      private function __onAddBuffHandler(param1:PhysicsEvent) : void
      {
      }
      
      private function __onUseSkillHandler(param1:PhysicsEvent) : void
      {
         var _loc2_:UnrealShootingShootAction = new UnrealShootingShootAction(info,param1.data as MapSkillResultInfo);
         addAction(_loc2_);
      }
      
      override protected function __updateNodeStateHandler(param1:PhysicsEvent) : void
      {
         super.__updateNodeStateHandler(param1);
         if(_controller.curSelectedObject == this && info.info.state != 1)
         {
            _controller.curSelectedObject = null;
         }
      }
      
      public function changeDirectionTo(param1:int, param2:int) : void
      {
      }
      
      public function getShootPoint() : Point
      {
         var _loc1_:Point = new Point(this.x,this.y);
         if(_movie && _movie["bombpos"])
         {
            _loc1_.x += _movie.bombpos.x * _movie.scaleX;
            _loc1_.y += _movie.bombpos.y;
         }
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         if(info)
         {
            info.removeEventListener("ADD_BUFF",__onAddBuffHandler);
            info.removeEventListener("USE_SKILL",__onUseSkillHandler);
         }
         super.dispose();
      }
      
      override public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         if(mouseHitTest() && isAttackState)
         {
            return attackFun();
         }
         return false;
      }
      
      override public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         if(mouseHitTest() && isAttackState)
         {
            return true;
         }
         return false;
      }
      
      override public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         if(mouseHitTest() && isAttackState)
         {
            return true;
         }
         return false;
      }
      
      override public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         if(mouseHitTest() && isAttackState)
         {
            return true;
         }
         return false;
      }
      
      public function attackFun() : Boolean
      {
         if(!_mapModel.mapTielsData)
         {
            return false;
         }
         CampaignManager.instance.mapModel.selectNode = null;
         _controller.curSelectedObject = this;
         return true;
      }
      
      private function get isAttackState() : Boolean
      {
         if(isFriend())
         {
            return false;
         }
         return true;
      }
      
      private function isFriend() : Boolean
      {
         return CampaignManager.instance.mapModel.selfMemberData.teamId == node.param1;
      }
   }
}

