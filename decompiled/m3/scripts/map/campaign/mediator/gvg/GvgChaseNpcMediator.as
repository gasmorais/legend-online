package map.campaign.mediator.gvg
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.helper.SearchPathHelper;
   import map.campaign.view.physics.CampaignArmyView;
   import map.campaign.view.physics.NpcAvatarView;
   import map.internals.data.CampaignNode;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   
   public class GvgChaseNpcMediator implements IMediator, IEnterFrame
   {
      
      private var _selfInfo:CampaignArmy;
      
      private var _targetInfo:CampaignNode;
      
      private var _targetPoint:Point = new Point();
      
      private var _container:Sprite;
      
      private var _count:int;
      
      private var _selectFlag:MovieClip;
      
      public function GvgChaseNpcMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _container = param1 as Sprite;
         _selectFlag = ComponentFactory.Instance.creatCustomObject("asset.map.SelectTargetAsset");
         _selfInfo = CampaignManager.instance.mapModel.selfMemberData;
         NotificationManager.instance.addEventListener("LOCK_PVP_WARFIGHT",__lockPvpWarFightHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         unLockWarFight();
         NotificationManager.instance.removeEventListener("LOCK_PVP_WARFIGHT",__lockPvpWarFightHandler);
         _container = null;
         if(_selectFlag && _selectFlag.parent)
         {
            _selectFlag.parent.removeChild(_selectFlag);
         }
         _selectFlag = null;
      }
      
      private function __lockPvpWarFightHandler(param1:NotificationEvent) : void
      {
         if(param1.data is CampaignArmy)
         {
            return;
         }
         _targetInfo = param1.data as CampaignNode;
         if(_targetInfo)
         {
            lockWarFight();
            _targetPoint.x = _targetInfo.nodeView.x;
            _targetPoint.y = _targetInfo.nodeView.y;
         }
         else
         {
            unLockWarFight();
         }
      }
      
      private function lockWarFight() : void
      {
         (_targetInfo.nodeView as NpcAvatarView).avatarView.addChildAt(_selectFlag,0);
         EnterFrameManager.instance.registeEnterFrame(this);
         _container.addEventListener("mouseDown",__onClickHandler);
      }
      
      private function unLockWarFight() : void
      {
         if(_selectFlag && _selectFlag.parent)
         {
            _selectFlag.parent.removeChild(_selectFlag);
         }
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         if(_container)
         {
            _container.removeEventListener("mouseDown",__onClickHandler);
         }
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         if(_targetInfo && param1.target == _targetInfo.nodeView)
         {
            return;
         }
         _targetInfo = null;
         unLockWarFight();
      }
      
      public function enterFrame() : void
      {
         var _loc7_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:BaseArmyAiInfo = null;
         var _loc2_:Boolean = false;
         var _loc6_:Array = null;
         if(!_selfInfo)
         {
            unLockWarFight();
            return;
         }
         if(_targetInfo && _targetInfo.nodeView)
         {
            if(_targetInfo.info.state == 1)
            {
               _targetPoint.x = _targetInfo.nodeView.x;
               _targetPoint.y = _targetInfo.nodeView.y;
            }
            _loc7_ = CampaignManager.instance.controller.getArmyView(_selfInfo);
            _loc3_ = _loc7_.x - _targetPoint.x;
            _loc4_ = _loc7_.y - _targetPoint.y;
            _loc1_ = _loc3_ * _loc3_ + _loc4_ * _loc4_;
            _loc5_ = (_loc7_ as CampaignArmyView).aiInfo;
            if(_loc5_ && _loc5_.pathInfo)
            {
               _loc2_ = _loc5_.walkIndex == _loc5_.pathInfo.length ? true : false;
            }
            _loc6_ = (_loc7_ as CampaignArmyView).aiInfo.pathInfo;
            if(_loc1_ < 10000 && _targetInfo.info.state == 1)
            {
               CampaignManager.instance.controller.sendCampaignArrive(_selfInfo.id,_targetInfo.nodeId);
               unLockWarFight();
            }
            else if(_targetInfo.info.state != 1)
            {
               unLockWarFight();
            }
            else if(_count % 70 == 0 || _loc2_)
            {
               searchPath(_loc7_.x,_loc7_.y,_targetPoint.x,_targetPoint.y);
            }
            _count = _count + 1;
         }
         else
         {
            unLockWarFight();
         }
      }
      
      private function searchPath(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc6_:Point = CampaignManager.instance.mapModel.getAroundWalkPoint(param1,param2);
         if(!_loc6_)
         {
            return;
         }
         var _loc8_:Point = CampaignManager.instance.mapModel.getAroundWalkPoint(param3,param4);
         if(!_loc8_)
         {
            return;
         }
         var _loc5_:Array = SearchPathHelper.searchPath(new Point(_loc6_.x * 20,_loc6_.y * 20),new Point(_loc8_.x * 20,_loc8_.y * 20));
         if(!_loc5_)
         {
            return;
         }
         var _loc7_:Object = CampaignManager.instance.controller.getArmyView(_selfInfo);
         _loc7_.aiInfo.pathInfo = _loc5_;
      }
   }
}

