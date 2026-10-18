package map.campaign.mediator.hero
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.helper.SearchPathHelper;
   import map.campaign.helper.hero.CampaignArmyViewHelper;
   import map.campaign.view.physics.NpcAvatarView;
   import map.internals.constant.NodeState;
   import map.internals.data.CampaignNode;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   
   public class ChaseNPCMediator implements IMediator, IEnterFrame
   {
      
      private var _map:DisplayObject;
      
      private var _mapId:int;
      
      private var _selectFlag:DisplayObject;
      
      private var _selfArmy:CampaignArmy;
      
      private var _selfArmyView:Object;
      
      private var _npcInfo:CampaignNode;
      
      private var _npcView:NpcAvatarView;
      
      private var _targetPoint:Point;
      
      private var _count:int = 0;
      
      public function ChaseNPCMediator()
      {
         super();
         _targetPoint = new Point();
      }
      
      public function register(param1:Object) : void
      {
         _map = param1 as DisplayObject;
         _mapId = CampaignManager.instance.mapId;
         _selectFlag = ComponentFactory.Instance.creatCustomObject("asset.map.SelectTargetAsset");
         _selfArmy = CampaignManager.instance.mapModel.selfMemberData;
         if(_selfArmy)
         {
            _selfArmyView = CampaignManager.instance.controller.getArmyView(_selfArmy);
         }
         NotificationManager.instance.addEventListener("CHASE_NPC",__chaseNPCHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         NotificationManager.instance.removeEventListener("CHASE_NPC",__chaseNPCHandler);
         ObjectUtils.disposeObject(_selectFlag);
         _selectFlag = null;
         _selfArmy = null;
         _selfArmyView = null;
         _map = null;
      }
      
      private function __chaseNPCHandler(param1:NotificationEvent) : void
      {
         _npcInfo = param1.data as CampaignNode;
         if(_npcInfo)
         {
            _npcView = _npcInfo.nodeView as NpcAvatarView;
            if(_npcView)
            {
               _targetPoint.x = _npcView.x;
               _targetPoint.y = _npcView.y;
            }
            lockWarFight();
         }
         else
         {
            unLockWarFight();
         }
      }
      
      private function lockWarFight() : void
      {
         if(_npcView)
         {
            _npcView.addChildAt(_selectFlag,0);
         }
         _count = 0;
         EnterFrameManager.instance.registeEnterFrame(this);
         _map.addEventListener("mouseDown",__onClickHandler);
      }
      
      private function unLockWarFight() : void
      {
         if(_selectFlag && _selectFlag.parent)
         {
            _selectFlag.parent.removeChild(_selectFlag);
         }
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         if(_map)
         {
            _map.removeEventListener("mouseDown",__onClickHandler);
         }
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = 0;
         if(param1.target == _npcView)
         {
            _loc2_ = uint(_npcView.getCurrentPixels());
            if(_loc2_ > 50)
            {
               return;
            }
         }
         unLockWarFight();
      }
      
      public function enterFrame() : void
      {
         var _loc1_:Boolean = false;
         if(!(_selfArmyView && _npcView && NodeState.displayState(_npcInfo.info.state)))
         {
            unLockWarFight();
            return;
         }
         _targetPoint.x = _npcView.x;
         _targetPoint.y = _npcView.y;
         var _loc3_:int = _selfArmyView.x - _targetPoint.x;
         var _loc4_:int = _selfArmyView.y - _targetPoint.y;
         var _loc2_:int = _loc3_ * _loc3_ + _loc4_ * _loc4_;
         if(_loc2_ < 3200)
         {
            _selfArmyView.info.pathInfo = [];
            CampaignArmyViewHelper.selfArmyToEnd(_selfArmyView.aiInfo,_selfArmyView);
            EnterFrameManager.instance.unRegisteEnterFrame(this);
         }
         else if(_count % 25 == 0)
         {
            searchPath(_selfArmyView.x,_selfArmyView.y,_targetPoint.x,_targetPoint.y);
         }
         _count = _count + 1;
      }
      
      private function searchPath(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:Array = SearchPathHelper.searchPath(new Point(param1,param2),new Point(param3,param4));
         if(!_loc5_)
         {
            return;
         }
         if(_loc5_.length > 2)
         {
            _loc5_.shift();
         }
         if(_selfArmyView)
         {
            _selfArmyView.aiInfo.pathInfo = _loc5_;
         }
      }
   }
}

