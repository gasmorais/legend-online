package map.internals.mediator.team
{
   import chat.datas.ChatData;
   import com.pickgliss.utils.ObjectPool;
   import events.FreedomTeamEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.view.physics.CampaignArmyView;
   import map.internals.data.CampaignNode;
   import map.internals.data.SpaceNode;
   import map.space.SpaceManager;
   import map.space.data.SpaceArmy;
   import map.space.view.physics.SpaceArmyView;
   import mvc.module.armyII.BaseArmy;
   import stage3drender.avatar.SpaceAvatar;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class FreedomTeamFollowMediator implements IMediator
   {
      
      private var _selfInfo:BaseArmy;
      
      private var _targetInfo:BaseArmy;
      
      private var _targetPoint:Point;
      
      private var _count:int;
      
      private var _selfMapId:int = -1;
      
      private var _lock:Boolean = false;
      
      public function FreedomTeamFollowMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _selfInfo = getSelfInfo();
         _targetPoint = new Point();
         if(FreedomTeamManager.instance.model != null && FreedomTeamManager.instance.model.followId != 0)
         {
            if(_targetInfo == null)
            {
               _targetInfo = FreedomTeamManager.instance.model.getMemberByUserId(FreedomTeamManager.instance.model.followId);
            }
         }
         NotificationManager.instance.addEventListener("LOCK_TEAM_FOLLOW_TARGET",__lockFollowtTargetHandler);
         NotificationManager.instance.addEventListener("TEAM_INFO_UPDATE",__teamInfoUpdateHandler);
         NotificationManager.instance.addEventListener("TEAM_INFO_SYNC",__teamInfoSyncHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         NotificationManager.instance.removeEventListener("LOCK_TEAM_FOLLOW_TARGET",__lockFollowtTargetHandler);
         NotificationManager.instance.removeEventListener("TEAM_INFO_UPDATE",__teamInfoUpdateHandler);
         NotificationManager.instance.removeEventListener("TEAM_INFO_SYNC",__teamInfoSyncHandler);
         _targetInfo = null;
      }
      
      private function __teamInfoSyncHandler(param1:FreedomTeamEvent) : void
      {
         var _loc6_:Point = null;
         var _loc2_:Point = null;
         var _loc4_:int = 0;
         var _loc3_:CampaignNode = null;
         var _loc7_:CampaignNode = null;
         var _loc8_:String = "";
         var _loc5_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         if(FreedomTeamManager.instance.model == null || FreedomTeamManager.instance.model != null && !FreedomTeamManager.instance.model.followFlag)
         {
            return;
         }
         if(!FreedomTeamManager.instance.hasTeam)
         {
            _loc8_ = LanguageMgr.GetTranslation("map.internals.mediator.team.FreedomTeamFollowMediator.Tips03");
            if(_loc5_)
            {
               _loc5_.channel = 3;
               _loc5_.msg = _loc8_;
               _loc5_.commit();
               NotificationManager.instance.sendNotification("ADD_CHAT",_loc5_);
               MessageTipManager.instance().show(_loc8_);
            }
            if(FreedomTeamManager.instance.model != null)
            {
               FreedomTeamManager.instance.model.followFlag = false;
            }
            return;
         }
         if(_targetInfo == null && FreedomTeamManager.instance.model.followId != 0)
         {
            _targetInfo = FreedomTeamManager.instance.model.getMemberByUserId(FreedomTeamManager.instance.model.followId);
         }
         if(!FreedomTeamManager.instance.inMyTeam(_targetInfo.userId))
         {
            _loc8_ = LanguageMgr.GetTranslation("map.internals.mediator.team.FreedomTeamFollowMediator.Tips03");
            if(_loc5_)
            {
               _loc5_.channel = 3;
               _loc5_.msg = _loc8_;
               _loc5_.commit();
               NotificationManager.instance.sendNotification("ADD_CHAT",_loc5_);
               MessageTipManager.instance().show(_loc8_);
            }
            FreedomTeamManager.instance.model.followFlag = false;
            return;
         }
         if(inTheSameMap)
         {
            if(_targetInfo == null)
            {
               _targetInfo = FreedomTeamManager.instance.model.getMemberByUserId(_targetInfo.userId);
            }
            _loc6_ = new Point(selfPoint.x * 20,selfPoint.y * 20);
            _loc2_ = new Point(_targetInfo.curPosX * 20,_targetInfo.curPosY * 20);
            _loc4_ = getSquareDistance(_loc6_,_loc2_);
            if(_loc4_ > 4000000)
            {
               return;
            }
            if(_loc4_ < 10000)
            {
               return;
            }
            if(_targetPoint == null)
            {
               _targetPoint = new Point();
               return;
            }
            _targetPoint.x = _targetInfo.curPosX;
            _targetPoint.y = _targetInfo.curPosY;
            if(_count % 4 == 0 || walkOver)
            {
               if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
               {
                  _loc3_ = CampaignManager.instance.mapModel.getMapNodesByPoint(_targetPoint);
                  if(_loc3_ != null)
                  {
                     CampaignManager.instance.mapModel.selectNode = _loc3_;
                  }
               }
               searchPath(selfPoint.x,selfPoint.y,_targetPoint.x,_targetPoint.y);
            }
            _count = _count + 1;
         }
         else
         {
            _targetPoint = getTransfer();
            if(_targetPoint)
            {
               if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
               {
                  _loc7_ = CampaignManager.instance.mapModel.getMapNodesByPoint(_targetPoint);
                  if(_loc7_ != null)
                  {
                     CampaignManager.instance.mapModel.selectNode = _loc7_;
                  }
               }
               searchPath(selfPoint.x,selfPoint.y,_targetPoint.x,_targetPoint.y);
            }
            else
            {
               _targetPoint = new Point();
               _loc8_ = LanguageMgr.GetTranslation("map.internals.mediator.team.FreedomTeamFollowMediator.Tips03");
               if(_loc5_)
               {
                  _loc5_.channel = 3;
                  _loc5_.msg = _loc8_;
                  _loc5_.commit();
                  NotificationManager.instance.sendNotification("ADD_CHAT",_loc5_);
                  MessageTipManager.instance().show(_loc8_);
               }
               FreedomTeamManager.instance.model.followFlag = false;
            }
         }
      }
      
      private function __teamInfoUpdateHandler(param1:FreedomTeamEvent) : void
      {
         var _loc3_:String = "";
         var _loc2_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         if(FreedomTeamManager.instance.model == null || FreedomTeamManager.instance.model != null && !FreedomTeamManager.instance.model.followFlag)
         {
            return;
         }
         if(!FreedomTeamManager.instance.hasTeam)
         {
            _loc3_ = LanguageMgr.GetTranslation("map.internals.mediator.team.FreedomTeamFollowMediator.Tips03");
            if(_loc2_)
            {
               _loc2_.channel = 3;
               _loc2_.msg = _loc3_;
               _loc2_.commit();
               NotificationManager.instance.sendNotification("ADD_CHAT",_loc2_);
               MessageTipManager.instance().show(_loc3_);
            }
            if(FreedomTeamManager.instance.model != null)
            {
               FreedomTeamManager.instance.model.followFlag = false;
            }
            return;
         }
         if(!FreedomTeamManager.instance.inMyTeam(_targetInfo.userId))
         {
            _loc3_ = LanguageMgr.GetTranslation("map.internals.mediator.team.FreedomTeamFollowMediator.Tips03");
            if(_loc2_)
            {
               _loc2_.channel = 3;
               _loc2_.msg = _loc3_;
               _loc2_.commit();
               NotificationManager.instance.sendNotification("ADD_CHAT",_loc2_);
               MessageTipManager.instance().show(_loc3_);
            }
            if(FreedomTeamManager.instance.model != null)
            {
               FreedomTeamManager.instance.model.followFlag = false;
            }
            return;
         }
      }
      
      private function __lockFollowtTargetHandler(param1:NotificationEvent) : void
      {
         var _loc4_:Point = null;
         var _loc2_:Point = null;
         var _loc3_:int = 0;
         var _loc5_:int = int(param1.data);
         var _loc6_:String = "";
         if(_loc5_ == 0)
         {
            if(FreedomTeamManager.instance.model != null && Boolean(FreedomTeamManager.instance.model.followFlag))
            {
               FreedomTeamManager.instance.model.followId = 0;
               _loc6_ = LanguageMgr.GetTranslation("map.internals.mediator.team.FreedomTeamFollowMediator.Tips02");
               MessageTipManager.instance().show(_loc6_);
               FreedomTeamManager.instance.model.followFlag = false;
               return;
            }
         }
         if(!FreedomTeamManager.instance.hasTeam)
         {
            return;
         }
         if(!FreedomTeamManager.instance.inMyTeam(_loc5_))
         {
            return;
         }
         if(!checkScene())
         {
            _loc6_ = LanguageMgr.GetTranslation("map.internals.mediator.team.FreedomTeamFollowMediator.Tips04");
            MessageTipManager.instance().show(_loc6_);
            if(FreedomTeamManager.instance.model != null)
            {
               FreedomTeamManager.instance.model.followFlag = false;
            }
            return;
         }
         if(FreedomTeamManager.instance.model != null)
         {
            _targetInfo = FreedomTeamManager.instance.model.getMemberByUserId(_loc5_);
         }
         if(_targetInfo && FreedomTeamManager.instance.memberIsOnline(_loc5_))
         {
            _loc4_ = new Point(selfPoint.x * 20,selfPoint.y * 20);
            _loc2_ = new Point(_targetInfo.curPosX * 20,_targetInfo.curPosY * 20);
            _loc3_ = getSquareDistance(_loc4_,_loc2_);
            if(!inTheSameMap)
            {
               _loc6_ = LanguageMgr.GetTranslation("map.internals.mediator.team.FreedomTeamFollowMediator.Tips06");
               MessageTipManager.instance().show(_loc6_);
               if(FreedomTeamManager.instance.model != null)
               {
                  FreedomTeamManager.instance.model.followFlag = false;
               }
               return;
            }
            if(_loc3_ > 4000000)
            {
               _loc6_ = LanguageMgr.GetTranslation("map.internals.mediator.team.FreedomTeamFollowMediator.Tips06");
               MessageTipManager.instance().show(_loc6_);
               if(FreedomTeamManager.instance.model != null)
               {
                  FreedomTeamManager.instance.model.followFlag = false;
               }
               return;
            }
            _targetPoint.x = _targetInfo.curPosX;
            _targetPoint.y = _targetInfo.curPosY;
            _loc6_ = LanguageMgr.GetTranslation("map.internals.mediator.team.FreedomTeamFollowMediator.Tips01");
            MessageTipManager.instance().show(_loc6_);
            if(FreedomTeamManager.instance.model != null)
            {
               FreedomTeamManager.instance.model.followFlag = true;
            }
            searchPath(selfPoint.x,selfPoint.y,_targetPoint.x,_targetPoint.y);
         }
         else
         {
            _loc6_ = LanguageMgr.GetTranslation("map.internals.mediator.team.FreedomTeamFollowMediator.Tips04");
            MessageTipManager.instance().show(_loc6_);
            if(FreedomTeamManager.instance.model != null)
            {
               FreedomTeamManager.instance.model.followFlag = false;
            }
         }
      }
      
      private function checkScene() : Boolean
      {
         var _loc1_:int = 0;
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            return true;
         }
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            if(CampaignManager.instance.mapModel)
            {
               _loc1_ = int(CampaignManager.instance.mapModel.mapId);
               if(WorldBossHelper.checkPetLand(_loc1_) || Boolean(WorldBossHelper.checkMineral(_loc1_)))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function get selfPoint() : Point
      {
         var _loc1_:Object = null;
         if(_selfInfo is SpaceArmy)
         {
            _loc1_ = SpaceManager.instance.controller.getArmyView(_selfInfo);
         }
         else if(_selfInfo is CampaignArmy)
         {
            _loc1_ = CampaignManager.instance.controller.getArmyView(_selfInfo);
         }
         if(_loc1_ is SpaceArmyView)
         {
            return new Point((_loc1_ as SpaceArmyView).x / 20,(_loc1_ as SpaceArmyView).y / 20);
         }
         if(_loc1_ is SpaceAvatar)
         {
            return new Point((_loc1_ as SpaceAvatar).x / 20,(_loc1_ as SpaceAvatar).y / 20);
         }
         if(_loc1_ is CampaignArmyView)
         {
            return new Point((_loc1_ as CampaignArmyView).x / 20,(_loc1_ as CampaignArmyView).y / 20);
         }
         return new Point();
      }
      
      private function get selfMapId() : int
      {
         var _loc1_:BaseArmy = FreedomTeamManager.instance.model.getMemberByUserId(_selfInfo.userId);
         return _loc1_.mapId;
      }
      
      private function getSquareDistance(param1:Point, param2:Point) : Number
      {
         var _loc3_:int = param2.x - param1.x;
         var _loc4_:int = param2.y - param1.y;
         return int(_loc3_ * _loc3_ + _loc4_ * _loc4_);
      }
      
      private function get walkOver() : Boolean
      {
         var _loc1_:Object = null;
         if(_selfInfo is SpaceArmy)
         {
            _loc1_ = SpaceManager.instance.controller.getArmyView(_selfInfo);
         }
         else if(_selfInfo is CampaignArmy)
         {
            _loc1_ = CampaignManager.instance.controller.getArmyView(_selfInfo);
         }
         if(_loc1_ is SpaceArmyView)
         {
            if((_loc1_ as SpaceArmyView).aiInfo && (_loc1_ as SpaceArmyView).aiInfo.pathInfo)
            {
               if((_loc1_ as SpaceArmyView).aiInfo.walkIndex == (_loc1_ as SpaceArmyView).aiInfo.pathInfo.length)
               {
                  return true;
               }
            }
         }
         else if(_loc1_ is SpaceAvatar)
         {
            if((_loc1_ as SpaceAvatar).aiInfo && (_loc1_ as SpaceAvatar).aiInfo.pathInfo)
            {
               if((_loc1_ as SpaceAvatar).aiInfo.walkIndex == (_loc1_ as SpaceAvatar).aiInfo.pathInfo.length)
               {
                  return true;
               }
            }
         }
         else if(_loc1_ is CampaignArmyView)
         {
            if((_loc1_ as CampaignArmyView).aiInfo && (_loc1_ as CampaignArmyView).aiInfo.pathInfo)
            {
               if((_loc1_ as CampaignArmyView).aiInfo.walkIndex == (_loc1_ as CampaignArmyView).aiInfo.pathInfo.length)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function get inTheSameMap() : Boolean
      {
         if(_targetInfo && selfMapId == _targetInfo.mapId)
         {
            return true;
         }
         return false;
      }
      
      private function getTransfer() : Point
      {
         var _loc1_:Point = null;
         var _loc5_:String = null;
         var _loc3_:int = 0;
         var _loc4_:SpaceNode = null;
         var _loc2_:CampaignNode = null;
         if(_targetInfo)
         {
            _loc5_ = selfMapId + "-" + _targetInfo.mapId;
            _loc3_ = int(FreedomTeamManager.instance.getTransferMapping(_loc5_));
            if(SceneManager.instance.currentType == "SPACE_SCENE")
            {
               _loc4_ = SpaceManager.instance.model.getMapNodeById(_loc3_);
               if(_loc4_)
               {
                  _loc1_ = new Point(_loc4_.curPosX,_loc4_.curPosY);
               }
            }
            else if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
            {
               _loc2_ = CampaignManager.instance.mapModel.getMapNodeByNodeId(_loc3_);
               if(_loc2_)
               {
                  _loc1_ = new Point(_loc2_.curPosX,_loc2_.curPosY);
               }
            }
         }
         return _loc1_;
      }
      
      private function searchPath(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         var _loc5_:Array = null;
         _loc6_ = getAroundWalkPoint(param1 * 20,param2 * 20);
         if(!_loc6_)
         {
            return;
         }
         _loc7_ = getAroundWalkPoint(param3 * 20,param4 * 20);
         if(!_loc7_)
         {
            return;
         }
         _loc5_ = getPath(_loc6_,_loc7_);
         if(!_loc5_)
         {
            return;
         }
         setPath(_loc5_);
      }
      
      private function setPath(param1:Array) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Point = param1[param1.length - 1] as Point;
         if(_selfInfo is SpaceArmy)
         {
            _loc2_ = SpaceManager.instance.controller.getArmyView(_selfInfo);
         }
         else if(_selfInfo is CampaignArmy)
         {
            _loc2_ = CampaignManager.instance.controller.getArmyView(_selfInfo);
         }
         if(_loc2_ is SpaceArmyView)
         {
            (_loc2_ as SpaceArmyView).aiInfo.pathInfo = param1;
         }
         else if(_loc2_ is SpaceAvatar)
         {
            (_loc2_ as SpaceAvatar).aiInfo.pathInfo = param1;
         }
         else if(_loc2_ is CampaignArmyView)
         {
            (_loc2_ as CampaignArmyView).aiInfo.pathInfo = param1;
         }
         updateWalkTarget(_loc3_);
      }
      
      private function getSelfInfo() : BaseArmy
      {
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            return SpaceManager.instance.model.selfArmy as BaseArmy;
         }
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            return CampaignManager.instance.mapModel.selfMemberData as BaseArmy;
         }
         return null;
      }
      
      private function getAroundWalkPoint(param1:int, param2:int) : Point
      {
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            return SpaceManager.instance.model.getAroundWalkPoint(param1,param2);
         }
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            return CampaignManager.instance.mapModel.getAroundWalkPoint(param1,param2);
         }
         return null;
      }
      
      private function getPath(param1:Point, param2:Point) : Array
      {
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            return SpaceManager.instance.controller.searchPath(param1,param2);
         }
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            return CampaignManager.instance.controller.searchPath(param1,param2);
         }
         return null;
      }
      
      private function updateWalkTarget(param1:Point) : void
      {
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            SpaceManager.instance.model.updateWalkTarget(param1);
         }
         else if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            CampaignManager.instance.mapModel.updateWalkTarget(param1);
         }
      }
   }
}

