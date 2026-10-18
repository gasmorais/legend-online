package map.campaign.mediator.mapview
{
   import avatar.view.HeroAvatar;
   import avatar.view.SharedAvatar;
   import bag.helper.BagHelper;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import managers.FreedomTeamManager;
   import managers.HomeManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.helper.hero.CampaignArmyViewHelper;
   import map.campaign.view.CampaignMapView;
   import map.campaign.view.physics.CampaignNpcPhysics;
   import map.campaign.view.physics.GodsEveningArmyView;
   import map.campaign.view.physics.MineralArmyView;
   import map.campaign.view.physics.MineralCarView;
   import map.campaign.view.physics.NpcAvatarView;
   import map.campaign.view.physics.PetLandArmyView;
   import map.internals.data.CampaignNode;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   
   public class CampaignMapCursorMediator implements IMediator
   {
      
      private var _timeId:int;
      
      private var _mouseDownPoint:Point;
      
      private var _mouseDown:Boolean;
      
      private var _target:Object;
      
      public function CampaignMapCursorMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1;
         param1.addEventListener("mouseMove",__mouseMoveHandler);
         param1.addEventListener("rollOut",__mouseOutHandler);
         param1.addEventListener("mouseDown",__mouseDownHandler);
         param1.addEventListener("mouseUp",__mouseUpHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         param1.removeEventListener("mouseMove",__mouseMoveHandler);
         param1.removeEventListener("rollOut",__mouseOutHandler);
         param1.removeEventListener("mouseDown",__mouseDownHandler);
         param1.removeEventListener("mouseUp",__mouseUpHandler);
         CursorManagerII.instance.resetCursor();
         _target = null;
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         if(BagHelper.instance.isSelling)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         if(BagHelper.instance.isVpLock)
         {
            return;
         }
         if(HomeManager.instance.model.isSelf && Boolean(HomeManager.instance.model.inFixUp))
         {
            return;
         }
         _mouseDown = true;
         _mouseDownPoint = new Point(param1.stageX,param1.stageY);
         if(_timeId != 0)
         {
            clearInterval(_timeId);
         }
         _timeId = setTimeout(startDragCall,300);
      }
      
      private function __mouseUpHandler(param1:MouseEvent) : void
      {
         if(BagHelper.instance.isSelling)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         if(BagHelper.instance.isVpLock)
         {
            return;
         }
         if(HomeManager.instance.model.isSelf && Boolean(HomeManager.instance.model.inFixUp))
         {
            return;
         }
         _mouseDown = false;
         _mouseDownPoint = null;
         startDragCall();
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(BagHelper.instance.isSelling)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         if(BagHelper.instance.isVpLock)
         {
            return;
         }
         if(HomeManager.instance.model.isSelf && Boolean(HomeManager.instance.model.inFixUp))
         {
            return;
         }
         _mouseDown = false;
         _mouseDownPoint = null;
         if(CursorManagerII.instance.currentState != "SELL_CIRSOR")
         {
            CursorManagerII.instance.resetCursor();
         }
         startDragCall();
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         if(BagHelper.instance.isSelling)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         if(BagHelper.instance.isVpLock)
         {
            return;
         }
         if(HomeManager.instance.model.isSelf && Boolean(HomeManager.instance.model.inFixUp))
         {
            return;
         }
         refreshCursor(param1,_target);
      }
      
      private function startDragCall() : void
      {
         clearInterval(_timeId);
         _timeId = 0;
      }
      
      private function refreshCursor(param1:MouseEvent, param2:Object) : void
      {
         var _loc16_:* = 0;
         var _loc15_:CampaignNode = null;
         var _loc3_:DisplayObjectContainer = null;
         var _loc9_:CampaignNpcPhysics = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:NpcAvatarView = null;
         var _loc12_:MineralCarView = null;
         var _loc8_:PetLandArmyView = null;
         var _loc11_:MineralArmyView = null;
         var _loc10_:GodsEveningArmyView = null;
         if(CursorManagerII.instance.currentState == "DRAG_CURSOR")
         {
            return;
         }
         var _loc5_:CampaignMapView = CampaignManager.instance.mapView;
         if(!mapModel.mapTielsData)
         {
            return;
         }
         var _loc13_:Boolean = _loc5_.npcLayer.mouseMoveHandler(param1);
         var _loc17_:Boolean = Boolean(BagHelper.instance.isSelling);
         if(_loc17_)
         {
            return;
         }
         if(_loc13_)
         {
            if(CursorManagerII.instance.currentState != "ATTACK_CURSOR")
            {
               CursorManagerII.instance.showCursorByType("ATTACK_CURSOR");
            }
            return;
         }
         var _loc14_:int = int(mapModel.mapId);
         if(WorldBossHelper.checkFarm(_loc14_) && isFarmLayerChild(param1.target as DisplayObject))
         {
            return;
         }
         if(isFarmLayerChild(param1.target as DisplayObject))
         {
            return;
         }
         if(param1.target is DisplayObjectContainer)
         {
            _loc3_ = param1.target as DisplayObjectContainer;
            while(_loc3_ && _loc3_.parent)
            {
               if(_loc3_ is CampaignNpcPhysics || _loc3_ is Stage)
               {
                  break;
               }
               _loc3_ = _loc3_.parent;
            }
         }
         if(param1.target is CampaignNpcPhysics || _loc3_ is CampaignNpcPhysics)
         {
            _loc9_ = param1.target as CampaignNpcPhysics;
            if(_loc9_ == null)
            {
               _loc9_ = _loc3_ as CampaignNpcPhysics;
            }
            _loc15_ = _loc9_.info as CampaignNode;
            if(CampaignArmyViewHelper.checkCollectionNode(_loc15_))
            {
               if(WorldBossHelper.checkGodsEvening(CampaignManager.instance.mapModel.mapId))
               {
                  if(_loc15_.param1 != GodsEveningManager.instance.model.teamId)
                  {
                     if(CursorManagerII.instance.currentState != "COLLECT_CURSOR")
                     {
                        CursorManagerII.instance.showCursorByType("COLLECT_CURSOR");
                     }
                     return;
                  }
                  if(CursorManagerII.instance.currentState != "SPACE_PLAYER_CURSOR")
                  {
                     CursorManagerII.instance.showCursorByType("SPACE_PLAYER_CURSOR");
                  }
                  return;
               }
               if(CursorManagerII.instance.currentState != "COLLECT_CURSOR")
               {
                  CursorManagerII.instance.showCursorByType("COLLECT_CURSOR");
               }
               return;
            }
            if(CampaignArmyViewHelper.checkBonFire(_loc15_))
            {
               if(_loc15_.info.state == 19)
               {
                  CursorManagerII.instance.showCursorByType("FARM_BONFIRE");
               }
               return;
            }
            if(CampaignArmyViewHelper.checkRapidThroughNode(_loc15_))
            {
               if(CursorManagerII.instance.currentState != "COLLECT_CURSOR")
               {
                  CursorManagerII.instance.showCursorByType("COLLECT_CURSOR");
               }
               return;
            }
            if(CampaignArmyViewHelper.checkTreeNode(_loc15_))
            {
               switch(int(ConsortiaManager.instance.model.secretInfo.treeState) - 1)
               {
                  case 0:
                     if(CursorManagerII.instance.currentState != "WATER_CURSOR")
                     {
                        CursorManagerII.instance.showCursorByType("WATER_CURSOR");
                     }
                     return;
               }
            }
            if(CampaignArmyViewHelper.checkAttackNode(_loc15_))
            {
               if(WorldBossHelper.checkDuskArea(CampaignManager.instance.mapModel.mapId) && CampaignManager.instance.mapModel.selfMemberData.teamId != _loc15_.param1)
               {
                  if(CursorManagerII.instance.currentState != "ATTACK_CURSOR")
                  {
                     CursorManagerII.instance.showCursorByType("ATTACK_CURSOR");
                  }
                  return;
               }
            }
            if(_loc15_.param2 == 5)
            {
               _loc7_ = int(CampaignManager.instance.mapModel.mapId);
               _loc6_ = int(CampaignManager.instance.mapModel.selfMemberData.teamId);
               if(WorldBossHelper.checkDuskArea(_loc7_) && _loc6_ != _loc15_.param1)
               {
                  CursorManagerII.instance.showCursorByType("DEFAULT_CURSOR");
               }
               else if(WorldBossHelper.checkDuskArea(_loc7_) && _loc6_ == _loc15_.param1)
               {
                  CursorManagerII.instance.resetCursor();
               }
               return;
            }
         }
         else if(param1.target is NpcAvatarView)
         {
            _loc4_ = param1.target as NpcAvatarView;
            if(_loc4_.avatarView is HeroAvatar)
            {
               _loc16_ = (_loc4_.avatarView as HeroAvatar).getCurrentPixels();
               if(_loc16_ > 50)
               {
                  _loc15_ = _loc4_.nodeInfo as CampaignNode;
                  if(CampaignArmyViewHelper.checkCollectionNode(_loc15_))
                  {
                     if(CursorManagerII.instance.currentState != "COLLECT_CURSOR")
                     {
                        CursorManagerII.instance.showCursorByType("COLLECT_CURSOR");
                     }
                     return;
                  }
                  if(_loc15_.param4 == "3" && _loc15_.info.state != 9 && _loc15_.info.state != 8)
                  {
                     if(CursorManagerII.instance.currentState != "ATTACK_CURSOR")
                     {
                        CursorManagerII.instance.showCursorByType("ATTACK_CURSOR");
                     }
                     return;
                  }
                  if(_loc15_.info.types == 61 || _loc15_.info.types == 67)
                  {
                     if(CursorManagerII.instance.currentState != "SPACE_NPC_CURSOR")
                     {
                        CursorManagerII.instance.showCursorByType("SPACE_NPC_CURSOR");
                     }
                     return;
                  }
                  if(WorldBossHelper.checkGodsEvening(CampaignManager.instance.mapModel.mapId))
                  {
                     if(_loc15_.armyId != GodsEveningManager.instance.model.teamId)
                     {
                        if(_loc15_.param2 == 1 || _loc15_.param2 == 2)
                        {
                           if(CursorManagerII.instance.currentState != "ATTACK_CURSOR")
                           {
                              CursorManagerII.instance.showCursorByType("ATTACK_CURSOR");
                           }
                           return;
                        }
                        if(_loc15_.param2 == 3)
                        {
                           if(CursorManagerII.instance.currentState != "COLLECT_CURSOR")
                           {
                              CursorManagerII.instance.showCursorByType("COLLECT_CURSOR");
                           }
                           return;
                        }
                     }
                  }
               }
            }
            else if(_loc4_.avatarView is SharedAvatar)
            {
               _loc16_ = (_loc4_.avatarView as SharedAvatar).getCurrentPixels();
               _loc12_ = _loc4_ as MineralCarView;
               if(_loc16_ > 50 && _loc12_ && !isSelfConsortia(_loc12_.armyInfo))
               {
                  if(CursorManagerII.instance.currentState != "ATTACK_CURSOR")
                  {
                     CursorManagerII.instance.showCursorByType("ATTACK_CURSOR");
                  }
                  return;
               }
            }
         }
         else if(param1.target is PetLandArmyView)
         {
            _loc8_ = param1.target as PetLandArmyView;
            if(_loc8_.avatarView is HeroAvatar)
            {
               _loc16_ = (_loc8_.avatarView as HeroAvatar).getCurrentPixels();
               if(_loc16_ > 50)
               {
                  if(CursorManagerII.instance.currentState != "SPACE_PLAYER_CURSOR")
                  {
                     CursorManagerII.instance.showCursorByType("SPACE_PLAYER_CURSOR");
                  }
                  return;
               }
            }
         }
         else if(param1.target is MineralArmyView)
         {
            _loc11_ = param1.target as MineralArmyView;
            if(_loc11_.avatarView is HeroAvatar)
            {
               _loc16_ = (_loc11_.avatarView as HeroAvatar).getCurrentPixels();
               if(_loc16_ > 50)
               {
                  if(!CampaignArmyState.checkDied(_loc11_.data.isDie) && _loc11_.data.state != 2)
                  {
                     if(isSelfConsortia(_loc11_.data) || isSelfTeam(_loc11_.data) || !isInMineralPVP())
                     {
                        CursorManagerII.instance.showCursorByType("SPACE_PLAYER_CURSOR");
                     }
                     else
                     {
                        CursorManagerII.instance.showCursorByType("ATTACK_CURSOR");
                     }
                  }
                  return;
               }
            }
         }
         else if(param1.target is GodsEveningArmyView)
         {
            _loc10_ = param1.target as GodsEveningArmyView;
            if(_loc10_.avatarView is HeroAvatar)
            {
               _loc16_ = (_loc10_.avatarView as HeroAvatar).getCurrentPixels();
               if(_loc16_ > 50)
               {
                  if(_loc10_.data.teamId != GodsEveningManager.instance.model.teamId)
                  {
                     if(CursorManagerII.instance.currentState != "ATTACK_CURSOR")
                     {
                        CursorManagerII.instance.showCursorByType("ATTACK_CURSOR");
                     }
                     return;
                  }
               }
            }
         }
         CursorManagerII.instance.showCursorByType("DEFAULT_CURSOR");
      }
      
      private function isFarmLayerChild(param1:DisplayObject) : Boolean
      {
         if(param1 && param1.parent)
         {
            if(param1.parent == _target)
            {
               return false;
            }
            if(_target.hasOwnProperty("farmLayer") && param1.parent == _target["farmLayer"])
            {
               return true;
            }
            return isFarmLayerChild(param1.parent as DisplayObject);
         }
         return false;
      }
      
      private function isSelfConsortia(param1:CampaignArmy) : Boolean
      {
         var _loc2_:int = 0;
         if(param1 && param1.baseHero)
         {
            if(StringHelper.isNullOrEmpty(param1.baseHero.consortiaName))
            {
               return false;
            }
            if(StringHelper.isNullOrEmpty(playerInfo.consortiaName))
            {
               return false;
            }
            if(mapModel.isCross)
            {
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID);
               return param1.baseHero.consortiaName == playerInfo.consortiaName && param1.baseHero.consortiaID == _loc2_;
            }
            return param1.baseHero.consortiaName == playerInfo.consortiaName;
         }
         return false;
      }
      
      private function isSelfTeam(param1:CampaignArmy) : Boolean
      {
         if(param1 && param1.baseHero)
         {
            if(FreedomTeamManager.instance.inMyTeam(param1.userId))
            {
               return true;
            }
         }
         return false;
      }
      
      private function isInMineralPVP() : Boolean
      {
         return WorldBossHelper.checkMineralPVP(CampaignManager.instance.mapModel.mapId);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
   }
}

