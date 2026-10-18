package map.campaign.view.layer
{
   import com.road.yishi.proto.army.ArmyPosUpdatedMsg;
   import com.road.yishi.proto.campaign.StandPosMsg;
   import com.road.yishi.proto.vehicle.VehicleMoveMsg;
   import com.road.yishi.proto.worldmap.PosMoveListMsg;
   import com.road.yishi.proto.worldmap.PosMoveMsg;
   import com.road.yishi.proto.worldmap.SynPlayerViewMsg;
   import com.road.yishi.proto.worldmap.ViewPlayerMsg;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignEvent;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.helper.SearchPathHelper;
   import map.campaign.view.CampaignMapView;
   import map.campaign.view.physics.ActiveVehicleArmyView;
   import map.campaign.view.physics.CampaignArmyView;
   import map.campaign.view.physics.UnrealShootingArmyView;
   import map.campaign.view.physics.physicsview.CampaignNpcView;
   import map.internals.constant.ArmyState;
   import map.internals.constant.MapGlobal;
   import map.internals.event.OuterCityEvent;
   import map.internals.utils.PathPointUtils;
   import map.internals.utils.QTree;
   import map.internals.view.hero.AvatarBaseView;
   import map.internals.view.physics.MapPhysicsAttackingBase;
   import yishi.manager.PlayerManager;
   import yishi.utils.WorldBossHelper;
   
   public class CampaignWalkLayer extends CampaignWalkView
   {
      
      private var _mapController:CampaignMapController;
      
      public function CampaignWalkLayer()
      {
         super();
         _mapController = CampaignManager.instance.controller as CampaignMapController;
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         mapModel.addEventListener("addGarrison",__addUserArmyHandler);
         mapModel.addEventListener("STANDPOS",__standPosHandler);
         mapModel.addEventListener("REMOVE_ARMY",__removeUserArmyHandler);
         mapModel.addEventListener("MOVE_ARMY_TO_RANGE",__moveArmyToRangeHandler);
         mapModel.addEventListener("GO_TO_POS",__updateArmyPosHandler);
         mapModel.addEventListener("MOVE_PATHS_ARMY",__armyPosBroadHandler);
         mapModel.addEventListener("MOVE_TO_VISIBLE",__armyMoveToVisibleHandler);
         mapModel.addEventListener("MOVE_TO_UNVISIBLE",__armyMoveToUnVisibleHandler);
         mapModel.addEventListener("ACTIVEVEHICLE_MOVE_PATH",__activeArmyPosBroadHandler);
         mapModel.addEventListener("SYN_CAMPAIGN_VIEW",__synCampaignViewHandler);
         mapModel.addEventListener("MOVE_PATHS_ARMY_LIST",__armyPosListBroadHandler);
      }
      
      private function __synCampaignViewHandler(param1:CampaignMapEvent) : void
      {
         if(CampaignManager.instance.exit)
         {
            return;
         }
         var _loc2_:SynPlayerViewMsg = param1.data as SynPlayerViewMsg;
         var _loc5_:Boolean = false;
         for each(var _loc4_:CampaignArmyView in _armys)
         {
            if(!(_loc4_.data.userId == mapModel.selfMemberData.userId && _loc4_.data.baseHero.serviceName == mapModel.selfMemberData.baseHero.serviceName))
            {
               _loc5_ = false;
               for each(var _loc3_:ViewPlayerMsg in _loc2_.viewPlayer)
               {
                  if(_loc4_.data.key == _loc3_.serverName + "_" + _loc3_.armyId)
                  {
                     _loc5_ = true;
                     break;
                  }
               }
               if(_loc5_)
               {
                  _loc4_.isPlaying = true;
                  if(!_loc4_.parent)
                  {
                     addChild(_loc4_);
                  }
               }
               else
               {
                  _loc4_.isPlaying = false;
                  if(_loc4_.parent)
                  {
                     removeChild(_loc4_);
                  }
               }
            }
         }
      }
      
      private function __standPosHandler(param1:CampaignEvent) : void
      {
         var _loc2_:StandPosMsg = param1.data as StandPosMsg;
         var _loc3_:String = _loc2_.hasServerName ? _loc2_.serverName : "";
         var _loc4_:CampaignArmyView = _armys[_loc3_ + "_" + _loc2_.id] as CampaignArmyView;
         _loc4_.x = _loc2_.posX * 20;
         _loc4_.y = _loc2_.posY * 20;
         _loc4_.info.pathInfo = [];
      }
      
      public function addToStage(param1:Event) : void
      {
         initSelfArmy();
         initArmyList(mapModel.allUserArmy);
         initHighPriorityArmy(mapModel.allUserArmy);
      }
      
      private function __armyPosListBroadHandler(param1:CampaignMapEvent) : void
      {
         var _loc8_:String = null;
         var _loc7_:CampaignArmyView = null;
         var _loc4_:Point = null;
         var _loc3_:int = 0;
         var _loc6_:Array = null;
         var _loc11_:int = 0;
         var _loc13_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:Point = null;
         var _loc12_:CampaignArmy = null;
         if(CampaignManager.instance.exit)
         {
            return;
         }
         var _loc2_:PosMoveListMsg = param1.data as PosMoveListMsg;
         for each(var _loc5_:PosMoveMsg in _loc2_.list)
         {
            _loc8_ = _loc5_.hasServerName ? _loc5_.serverName : "";
            _loc7_ = _armys[_loc8_ + "_" + _loc5_.armyId] as CampaignArmyView;
            if(_loc7_ && _loc7_.info)
            {
               _loc7_.info.moveOverState = _loc5_.armyState;
               if(_loc5_.routes.length > 0)
               {
                  _loc4_ = new Point(_loc5_.routes[0].x,_loc5_.routes[0].y);
                  _loc3_ = Point.distance(_loc4_,new Point(_loc7_.x,_loc7_.y));
                  if(_loc3_ > 250)
                  {
                     _loc7_.x = _loc4_.x;
                     _loc7_.y = _loc4_.y;
                  }
                  else
                  {
                     _loc11_ = int(_loc7_.info.nextIndex);
                     if(_loc7_.info.pathInfo && _loc7_.info.pathInfo.length >= _loc11_)
                     {
                        _loc6_ = _loc7_.info.pathInfo.slice(_loc11_);
                     }
                  }
                  _loc13_ = [];
                  _loc9_ = 0;
                  while(_loc9_ < _loc5_.routes.length)
                  {
                     _loc13_.push(new Point(int(_loc5_.routes[_loc9_].x / 20),int(_loc5_.routes[_loc9_].y / 20)));
                     _loc9_++;
                  }
                  if(_loc6_)
                  {
                     _loc13_ = _loc6_.concat(_loc13_);
                  }
                  _loc10_ = _loc7_.getTilePos();
                  if(!_loc10_.equals(_loc13_[0]))
                  {
                     _loc13_.unshift(_loc10_);
                  }
                  _loc13_ = PathPointUtils.optimizePath(_loc13_);
                  _loc7_.info.pathInfo = _loc13_;
               }
            }
            else
            {
               _loc12_ = mapModel.getUserArmyByArmyId(_loc5_.armyId,_loc8_);
               if(_loc12_)
               {
                  _loc12_.needInit = true;
                  _loc12_.curPosX = int(_loc5_.routes[0].x / 20);
                  _loc12_.curPosY = int(_loc5_.routes[0].y / 20);
                  addAmryView(_loc12_,_loc5_.armyState);
               }
            }
         }
      }
      
      private function __armyPosBroadHandler(param1:CampaignMapEvent) : void
      {
         var _loc4_:Point = null;
         var _loc3_:int = 0;
         var _loc6_:Array = null;
         var _loc11_:int = 0;
         var _loc5_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:Point = null;
         var _loc12_:CampaignArmy = null;
         if(CampaignManager.instance.exit)
         {
            return;
         }
         var _loc2_:PosMoveMsg = param1.data as PosMoveMsg;
         var _loc8_:String = _loc2_.hasServerName ? _loc2_.serverName : "";
         var _loc7_:CampaignArmyView = _armys[_loc8_ + "_" + _loc2_.armyId] as CampaignArmyView;
         if(_loc7_)
         {
            _loc7_.info.moveOverState = _loc2_.armyState;
            if(_loc2_.routes.length > 0)
            {
               _loc4_ = new Point(_loc2_.routes[0].x,_loc2_.routes[0].y);
               _loc3_ = Point.distance(_loc4_,new Point(_loc7_.x,_loc7_.y));
               if(_loc3_ > 250)
               {
                  _loc7_.x = _loc4_.x;
                  _loc7_.y = _loc4_.y;
               }
               else
               {
                  _loc11_ = int(_loc7_.info.nextIndex);
                  if(_loc7_.info.pathInfo && _loc7_.info.pathInfo.length >= _loc11_)
                  {
                     _loc6_ = _loc7_.info.pathInfo.slice(_loc11_);
                  }
               }
               _loc5_ = [];
               _loc9_ = 0;
               while(_loc9_ < _loc2_.routes.length)
               {
                  _loc5_.push(new Point(int(_loc2_.routes[_loc9_].x / 20),int(_loc2_.routes[_loc9_].y / 20)));
                  _loc9_++;
               }
               if(_loc6_)
               {
                  _loc5_ = _loc6_.concat(_loc5_);
               }
               _loc10_ = _loc7_.getTilePos();
               if(!_loc10_.equals(_loc5_[0]))
               {
                  _loc5_.unshift(_loc10_);
               }
               _loc5_ = PathPointUtils.optimizePath(_loc5_);
               _loc7_.info.pathInfo = _loc5_;
            }
         }
         else
         {
            _loc12_ = mapModel.getUserArmyByArmyId(_loc2_.armyId,_loc8_);
            if(_loc12_)
            {
               _loc12_.needInit = true;
               _loc12_.curPosX = int(_loc2_.routes[0].x / 20);
               _loc12_.curPosY = int(_loc2_.routes[0].y / 20);
               addAmryView(_loc12_,_loc2_.armyState);
            }
         }
         _loc2_ = null;
      }
      
      private function __activeArmyPosBroadHandler(param1:CampaignMapEvent) : void
      {
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc8_:CampaignArmy = null;
         if(CampaignManager.instance.exit)
         {
            return;
         }
         var _loc2_:VehicleMoveMsg = param1.data as VehicleMoveMsg;
         var _loc5_:String = _loc2_.hasServerName ? _loc2_.serverName : "";
         if(!mapModel)
         {
            return;
         }
         var _loc7_:CampaignArmy = mapModel.getUserArmyByUserId(_loc2_.playerId);
         if(!_loc7_)
         {
            return;
         }
         var _loc4_:CampaignArmyView = _armys[_loc5_ + "_" + _loc7_.id] as CampaignArmyView;
         if(_loc4_)
         {
            if(_loc2_.path.length > 0)
            {
               _loc3_ = [];
               _loc6_ = 0;
               while(_loc6_ < _loc2_.path.length)
               {
                  _loc3_.push(new Point(int(_loc2_.path[_loc6_].x),int(_loc2_.path[_loc6_].y)));
                  _loc6_++;
               }
               _loc3_ = PathPointUtils.optimizePath(_loc3_);
               _loc4_.info.pathInfo = _loc3_;
            }
         }
         else
         {
            _loc8_ = mapModel.getUserArmyByUserId(_loc2_.playerId);
            if(_loc8_)
            {
               _loc8_.needInit = true;
               _loc8_.curPosX = int(_loc2_.path[0].x);
               _loc8_.curPosY = int(_loc2_.path[0].y);
               addAmryView(_loc8_);
            }
         }
         _loc2_ = null;
      }
      
      private function __armyMoveToVisibleHandler(param1:CampaignMapEvent) : void
      {
         addAmryView(param1.data as CampaignArmy);
      }
      
      private function __armyMoveToUnVisibleHandler(param1:CampaignMapEvent) : void
      {
         removeArmyView(param1.data as CampaignArmy);
      }
      
      private function __updateArmyPosHandler(param1:CampaignMapEvent) : void
      {
         var _loc4_:Point = null;
         var _loc3_:int = 0;
         var _loc5_:CampaignMapView = null;
         var _loc6_:Point = null;
         var _loc2_:ArmyPosUpdatedMsg = param1.data as ArmyPosUpdatedMsg;
         var _loc8_:String = _loc2_.hasServerName ? _loc2_.serverName : "";
         var _loc7_:CampaignArmyView = _armys[_loc8_ + "_" + _loc2_.armyId] as CampaignArmyView;
         if(_loc7_)
         {
            _loc4_ = new Point(_loc2_.curPosX * 20,_loc2_.curPosY * 20);
            _loc3_ = Point.distance(_loc4_,new Point(_loc7_.x,_loc7_.y));
            if(_loc3_ > 150)
            {
               if(_loc7_.data)
               {
                  _loc7_.data.curPosX = _loc2_.curPosX;
                  _loc7_.data.curPosY = _loc2_.curPosY;
               }
               _loc7_.x = _loc4_.x;
               _loc7_.y = _loc4_.y;
               _loc7_.info.pathInfo = SearchPathHelper.astartFindPath(_loc4_,new Point(_loc2_.endPosX * 20,_loc2_.endPosY * 20));
            }
            if(_loc7_.data == _model.selfMemberData)
            {
               _loc5_ = CampaignManager.instance.mapView as CampaignMapView;
               if(_loc5_)
               {
                  _loc6_ = new Point(_loc7_.x,_loc7_.y);
                  _loc5_.moveCenterPoint(_loc6_,0,false);
               }
            }
            _loc7_.initPetPos();
         }
         _loc2_ = null;
      }
      
      protected function get mapModel() : CampaignMapModel
      {
         return _model;
      }
      
      private function sortFun(param1:Sprite, param2:Sprite) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(param1.parent)
         {
            _loc4_ = param1.parent.getChildIndex(param1);
         }
         if(param2.parent)
         {
            _loc3_ = param2.parent.getChildIndex(param2);
         }
         if(_loc4_ > _loc3_)
         {
            return -1;
         }
         if(_loc4_ < _loc3_)
         {
            return 1;
         }
         return 0;
      }
      
      override public function onClickHandler(param1:MouseEvent) : Boolean
      {
         var _loc13_:int = 0;
         var _loc14_:Rectangle = null;
         var _loc2_:QTree = null;
         var _loc8_:Array = null;
         var _loc3_:Array = null;
         var _loc7_:Array = null;
         var _loc6_:AvatarBaseView = null;
         var _loc11_:MapPhysicsAttackingBase = null;
         var _loc9_:CampaignArmy = null;
         var _loc4_:UnrealShootingArmyView = null;
         var _loc10_:ActiveVehicleArmyView = null;
         if(param1)
         {
            _loc13_ = 250;
            _loc14_ = new Rectangle(this.mouseX - _loc13_,this.mouseY - _loc13_,_loc13_ * 2,_loc13_ * 2);
            _loc2_ = MapGlobal.qtree;
            _loc8_ = _loc2_.find(_loc14_);
            _loc3_ = [];
            _loc7_ = [];
            for each(var _loc12_:Object in _loc8_)
            {
               if(_loc12_ is AvatarBaseView)
               {
                  _loc6_ = _loc12_ as AvatarBaseView;
                  if(_loc6_.mouseHitTest())
                  {
                     _loc3_.push(_loc6_);
                  }
               }
               else if(_loc12_ is MapPhysicsAttackingBase)
               {
                  _loc11_ = _loc12_ as CampaignNpcView;
                  if(_loc11_.mouseHitTest())
                  {
                     _loc7_.push(_loc11_);
                  }
               }
            }
            if(_loc3_.length > 0)
            {
               _loc3_.sort(sortFun);
               _loc6_ = _loc3_[0];
               if(_loc6_.hasOwnProperty("mouseClickHandler"))
               {
                  if(_loc6_["mouseClickHandler"](param1))
                  {
                     return true;
                  }
               }
            }
            else if(_loc7_.length > 0)
            {
               _loc7_.sort(sortFun);
               _loc11_ = _loc7_[0] as MapPhysicsAttackingBase;
               if(_loc11_.mouseClickHandler(param1))
               {
                  return true;
               }
            }
         }
         if(WorldBossHelper.checkUnrealShooting(mapModel.mapId))
         {
            _loc9_ = mapModel.selfMemberData;
            _loc4_ = CampaignManager.instance.controller.getArmyView(_loc9_) as UnrealShootingArmyView;
            if(_loc4_)
            {
               if(_loc4_.isJump)
               {
                  return false;
               }
               _loc4_.cancelCastAction();
            }
         }
         if(WorldBossHelper.checkActiveVehicle(mapModel.mapId))
         {
            _loc9_ = mapModel.selfMemberData;
            _loc10_ = CampaignManager.instance.controller.getArmyView(_loc9_) as ActiveVehicleArmyView;
            if(_loc10_)
            {
               if(_loc10_.isJump)
               {
                  return false;
               }
               _loc10_.cancelCastAction();
            }
         }
         PlayerManager.instance.currentPlayerModel.reinforce = null;
         if(PlayerManager.instance.newbieProcess > 10000 && PlayerManager.instance.newbieProcess < 15000)
         {
            return false;
         }
         return Boolean(CampaignManager.instance.controller.moveArmyByPos(this.mouseX,this.mouseY,true));
      }
      
      private function __addUserArmyHandler(param1:OuterCityEvent) : void
      {
         var _loc2_:CampaignArmy = null;
         if(!checkMapNeededInit())
         {
            _loc2_ = param1.data as CampaignArmy;
            if(_loc2_.mapId != CampaignManager.instance.mapModel.mapId)
            {
               return;
            }
            if(checkDistance(_loc2_) && canRenderArmyView(_loc2_.userId))
            {
               addAmryView(_loc2_);
            }
         }
      }
      
      private function addAmryView(param1:CampaignArmy, param2:int = 0) : CampaignArmyView
      {
         if(_armys[param1.key])
         {
            return _armys[param1.key];
         }
         var _loc3_:CampaignArmyView = createArmy(param1,param2);
         addItem(_loc3_);
         _loc3_.x = param1.curPosX * 20;
         _loc3_.y = param1.curPosY * 20;
         return _loc3_;
      }
      
      private function removeArmyView(param1:CampaignArmy) : void
      {
         param1.needInit = false;
         var _loc2_:CampaignArmyView = _armys[param1.key] as CampaignArmyView;
         if(_loc2_)
         {
            removeItem(_loc2_);
            _loc2_.dispose();
         }
         delete _armys[param1.key];
         _loc2_ = null;
      }
      
      private function __removeUserArmyHandler(param1:OuterCityEvent) : void
      {
         var _loc2_:CampaignArmy = param1.data as CampaignArmy;
         removeArmyView(_loc2_);
      }
      
      private function __moveArmyToRangeHandler(param1:CampaignEvent) : void
      {
         var _loc6_:String = null;
         var _loc10_:CampaignArmy = null;
         var _loc8_:int = 0;
         var _loc5_:Point = null;
         var _loc7_:Point = null;
         var _loc3_:Array = null;
         var _loc2_:Object = param1.data;
         var _loc4_:CampaignArmyView = _armys[_loc2_.key] as CampaignArmyView;
         if(!_loc4_)
         {
            _loc6_ = "";
            if(_loc2_.baseHero)
            {
               _loc6_ = _loc2_.baseHero.serverName;
            }
            _loc10_ = mapModel.getSysArmyByArmyId(_loc2_.id,_loc6_);
            if(_loc10_)
            {
               _loc4_ = addAmryView(_loc10_);
            }
         }
         if(_loc4_)
         {
            _loc8_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.userId);
            if(_loc4_.data.userId != _loc8_)
            {
               if(!ArmyState.checkCampaignAttack(_loc4_.data.state))
               {
                  return;
               }
               _loc5_ = new Point(_loc4_.x,_loc4_.y);
               for each(var _loc9_:Point in _loc2_.range)
               {
                  _loc7_ = _loc9_;
                  _loc3_ = SearchPathHelper.astartFindPath(_loc5_,_loc7_);
                  if(_loc3_)
                  {
                     break;
                  }
               }
               if(_loc3_)
               {
                  _loc4_.info.pathInfo = _loc3_;
               }
            }
         }
      }
      
      override public function dispose() : void
      {
         mapModel.removeEventListener("addGarrison",__addUserArmyHandler);
         mapModel.removeEventListener("STANDPOS",__standPosHandler);
         mapModel.removeEventListener("REMOVE_ARMY",__removeUserArmyHandler);
         mapModel.removeEventListener("MOVE_ARMY_TO_RANGE",__moveArmyToRangeHandler);
         mapModel.removeEventListener("GO_TO_POS",__updateArmyPosHandler);
         mapModel.removeEventListener("MOVE_PATHS_ARMY",__armyPosBroadHandler);
         mapModel.removeEventListener("MOVE_TO_VISIBLE",__armyMoveToVisibleHandler);
         mapModel.removeEventListener("MOVE_TO_UNVISIBLE",__armyMoveToUnVisibleHandler);
         mapModel.removeEventListener("SYN_CAMPAIGN_VIEW",__synCampaignViewHandler);
         mapModel.removeEventListener("MOVE_PATHS_ARMY_LIST",__armyPosListBroadHandler);
         mapModel.removeEventListener("ACTIVEVEHICLE_MOVE_PATH",__activeArmyPosBroadHandler);
         super.dispose();
         _mapController = null;
      }
   }
}

