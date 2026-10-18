package map.campaign.mediator.pvp
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.helper.SearchPathHelper;
   import map.net.MapSocketOuterManager;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class PvpWarFightMediator implements IMediator, IEnterFrame
   {
      
      protected var _selfInfo:CampaignArmy;
      
      protected var _targetInfo:CampaignArmy;
      
      protected var _selectFlag:MovieClip;
      
      protected var _container:Sprite;
      
      protected var _count:int;
      
      private var _mapId:int;
      
      private var _targetPoint:Point = new Point();
      
      public function PvpWarFightMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _container = param1 as Sprite;
         _mapId = CampaignManager.instance.mapId;
         _selectFlag = ComponentFactory.Instance.creatCustomObject("asset.map.SelectTargetAsset");
         _selfInfo = CampaignManager.instance.mapModel.selfMemberData;
         NotificationManager.instance.addEventListener("LOCK_PVP_WARFIGHT",__lockPvpWarFightHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         unLockWarFight();
         NotificationManager.instance.removeEventListener("LOCK_PVP_WARFIGHT",__lockPvpWarFightHandler);
         _container = null;
      }
      
      private function __lockPvpWarFightHandler(param1:NotificationEvent) : void
      {
         _targetInfo = param1.data as CampaignArmy;
         var _loc2_:Object = CampaignManager.instance.controller.getArmyView(_targetInfo);
         if(_targetInfo && _loc2_)
         {
            lockWarFight();
            _targetPoint.x = _loc2_.x;
            _targetPoint.y = _loc2_.y;
         }
         else
         {
            unLockWarFight();
         }
      }
      
      private function lockWarFight() : void
      {
         var _loc1_:Object = null;
         if(!WorldBossHelper.checkPetLand(_mapId))
         {
            _loc1_ = CampaignManager.instance.controller.getArmyView(_targetInfo);
            if(_loc1_ && _loc1_.avatarView)
            {
               _loc1_.avatarView.addChildAt(_selectFlag,0);
            }
         }
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
         var _loc2_:Object = CampaignManager.instance.controller.getArmyView(_targetInfo);
         if(_targetInfo && param1.target == _loc2_)
         {
            return;
         }
         _targetInfo = null;
         unLockWarFight();
      }
      
      public function enterFrame() : void
      {
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
         var _loc7_:Object = CampaignManager.instance.controller.getArmyView(_targetInfo);
         var _loc8_:Object = CampaignManager.instance.controller.getArmyView(_selfInfo);
         if(_targetInfo && _loc7_)
         {
            if(_targetInfo.online && _loc7_.x != _targetInfo.curPosX * 20 && _loc7_.y != _targetInfo.curPosY * 20)
            {
               _targetPoint.x = _loc7_.x;
               _targetPoint.y = _loc7_.y;
            }
            _loc3_ = _loc8_.x - _targetPoint.x;
            _loc4_ = _loc8_.y - _targetPoint.y;
            _loc1_ = _loc3_ * _loc3_ + _loc4_ * _loc4_;
            _loc5_ = _loc8_.aiInfo;
            if(_loc5_ && _loc5_.pathInfo)
            {
               _loc2_ = _loc5_.walkIndex == _loc5_.pathInfo.length ? true : false;
            }
            _loc6_ = _loc8_.aiInfo.pathInfo;
            if(_loc1_ < 10000 && Boolean(_targetInfo.online))
            {
               sendAttack();
               unLockWarFight();
            }
            else if(_loc2_ && !_targetInfo.online)
            {
               unLockWarFight();
            }
            else if(_count % 70 == 0 || _loc2_)
            {
               searchPath(_loc8_.x,_loc8_.y,_targetPoint.x,_targetPoint.y);
            }
            _count = _count + 1;
         }
         else
         {
            unLockWarFight();
         }
      }
      
      protected function sendAttack() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = int(CampaignManager.instance.mapModel.mapId);
         if(WorldBossHelper.checkPvp(_loc2_) || Boolean(WorldBossHelper.checkFlameTemple(_loc2_)) || Boolean(WorldBossHelper.checkDuskArea(_loc2_)) || Boolean(WorldBossHelper.checkIceFireTemple(_loc2_)))
         {
            MapSocketOuterManager.sendAttackInPvpMap(_targetInfo.userId,_targetInfo.baseHero.serviceName);
         }
         if(WorldBossHelper.checkPetLand(_loc2_) || Boolean(WorldBossHelper.checkMineral(_loc2_)))
         {
            if(_targetInfo.state == 2)
            {
               _loc1_ = LanguageMgr.GetTranslation("playermenu.command01");
               MessageTipManager.instance().show(_loc1_);
               return;
            }
            MapSocketOuterManager.sendAttackInPetLand(_targetInfo.userId);
         }
         if(WorldBossHelper.checkGodsEvening(_loc2_))
         {
            if(_targetInfo.teamId != _selfInfo.teamId)
            {
               MapSocketOuterManager.sendAttackInGodsEvening(_targetInfo.userId,_targetInfo.baseHero.serviceName);
            }
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

