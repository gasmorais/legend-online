package map.outercity
{
   import bag.helper.BagHelper;
   import chat.datas.ChatData;
   import chat.view.ChatTopBugleView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.pb.helper.army.ThaneInfoHelper;
   import com.road.yishi.proto.army.ArmyMsg;
   import com.road.yishi.proto.army.ArmyPawnInfoMsg;
   import com.road.yishi.proto.army.ArmyPositionMsg;
   import com.road.yishi.proto.army.ArmyRemoveMsg;
   import com.road.yishi.proto.army.BaseCastleMsg;
   import com.road.yishi.proto.army.PhysicListUpdateMsg;
   import com.road.yishi.proto.army.WildLandMsg;
   import com.road.yishi.proto.outercity.ArmyUpdatedGridMsg;
   import com.road.yishi.proto.outercity.CastleDefenseRspMsg;
   import com.road.yishi.proto.outercity.OutercityRspMsg;
   import com.road.yishi.proto.worldmap.PosMoveMsg;
   import com.road.yishi.proto.worldmap.RouteMsg;
   import events.BuildingEvent;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   import mainBar.ChatBar;
   import mainBar.FullBar;
   import mainBar.SmallMapBar;
   import mainBar.TipsBar;
   import manager.LanguageMgr;
   import managers.BuildingSocketOutManager;
   import managers.FreedomTeamManager;
   import map.campaign.view.FootprintItems;
   import map.internals.data.BaseCastle;
   import map.internals.data.MapInitData;
   import map.internals.data.MapPhysics;
   import map.internals.data.OuterCityNode;
   import map.internals.data.PhysicInfo;
   import map.internals.data.WildLand;
   import map.internals.event.OuterCityEvent;
   import map.internals.library.MapElmsLibrary;
   import map.internals.utils.MapDataUtils;
   import map.internals.utils.Utils;
   import map.internals.view.displaye.MapNameMovie;
   import map.outercity.helper.mapview.CopyNodeDataHelper;
   import map.outercity.helper.mapview.GetWalkStartPointHelper;
   import map.outercity.helper.mapview.OuterCityArmyViewHelper;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.manager.OuterCitySocketOutManager;
   import map.outercity.manager.OuterFrameManager;
   import map.outercity.preload.PreLoadOuterCityData;
   import map.outercity.view.OuterCityMap;
   import map.outercity.view.archaeology.OuterCityArchaeologyView;
   import map.outercity.view.bossinfo.OuterCityBossInfoView;
   import map.outercity.view.mapphysics.ArmyView;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.armyII.SystemArmy;
   import mvc.module.armyII.UserArmy;
   import mvc.module.buildings.BuildInfo;
   import ui.maintoolbar.MainToolBar;
   import ui.resourcebar.ResourcesBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.PlayerEffectInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.events.SceneViewEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.BaseSceneView;
   import yishi.service.managers.OuterCityServiceManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.LoadingSceneView;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.SimpleMovie;
   import yzhkof.debug.log;
   
   public class OuterCityController extends BaseSceneView
   {
      
      private var _model:OuterCityModel;
      
      private var _view:OuterCityMap;
      
      private var _bossInfoView:OuterCityBossInfoView;
      
      private var _archaeologyView:OuterCityArchaeologyView;
      
      private var _parms:Object;
      
      private var _preLoadingOver:Boolean;
      
      private var _showLoadingTimeId:int;
      
      private var _updateNodeVisibleUint:uint;
      
      public const CAN_SEE_LONG:uint = 660;
      
      private var _attacking:MovieClip;
      
      private var timeid:int;
      
      private var _alert:BaseAlerFrame;
      
      public function OuterCityController()
      {
         super();
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         _parms = param1;
         FootprintItems.setup();
         _model = new OuterCityModel();
         OuterCityManager.instance.steup(this,_model);
         initData(param1);
         MapElmsLibrary.instance.lock();
         if(param1 && param1.isDealyShowSmallLoading)
         {
            _preLoadingOver = false;
            _showLoadingTimeId = setInterval(showLoading,1500);
         }
         new PreLoadOuterCityData(_model).syncBackCall(preLoadingOver);
      }
      
      private function initData(param1:Object) : void
      {
         var _loc2_:MapInitData = null;
         var _loc3_:int = 0;
         if(param1 is MapInitData)
         {
            _loc2_ = param1 as MapInitData;
            _model.targetPoint = _loc2_.targetPoint;
            _loc3_ = int(_loc2_.mapTempInfo.Id == 100 ? mapNodeInfo.info.mapId : int(_loc2_.mapTempInfo.Id));
            _model.mapId = _loc3_;
         }
         else
         {
            _model.targetPoint = new Point(mapNodeInfo.x,mapNodeInfo.y);
            _model.mapId = mapNodeInfo.info.mapId;
         }
      }
      
      private function showLoading() : void
      {
         if(_showLoadingTimeId > 0)
         {
            clearInterval(_showLoadingTimeId);
         }
         _showLoadingTimeId = 0;
         if(!_preLoadingOver)
         {
            LoadingSceneView.instance.show();
         }
      }
      
      override protected function preLoadingOver() : void
      {
         _preLoadingOver = true;
         super.preLoadingOver();
         _updateNodeVisibleUint = setInterval(updateNodeVisible,200);
      }
      
      private function updateNodeVisible() : void
      {
         updateCastlesVisible();
         updateWildLandVisible();
         updateArmyVisible();
      }
      
      private function updateCastlesVisible() : void
      {
         var _loc1_:Boolean = false;
         var _loc4_:Dictionary = _model.allCastles;
         if(_loc4_ == null)
         {
            return;
         }
         for each(var _loc3_:Dictionary in _loc4_)
         {
            for each(var _loc2_:BaseCastle in _loc3_)
            {
               if(_loc2_.nodeView != null)
               {
                  if(_loc2_.info.occupyPlayerId != playerInfo.userId)
                  {
                     if(_model.bossInfo.leftFogTime > 0)
                     {
                        _loc2_.nodeView.visible = true;
                        _loc2_.nodeView.mouseEnabled = true;
                     }
                     else
                     {
                        _loc2_.nodeView.visible = false;
                        _loc2_.nodeView.mouseEnabled = false;
                        if(checkTeamMember(_loc2_.x,_loc2_.y))
                        {
                           _loc2_.nodeView.visible = true;
                           _loc2_.nodeView.mouseEnabled = true;
                        }
                        else
                        {
                           _loc2_.nodeView.visible = false;
                           _loc2_.nodeView.mouseEnabled = false;
                           if(selfArmy.armyView != null)
                           {
                              _loc2_.nodeView.visible = true;
                              _loc2_.nodeView.mouseEnabled = true;
                              if(Math.abs(_loc2_.x - selfArmy.armyView.x) > 660 || Math.abs(_loc2_.y - selfArmy.armyView.y) > 660)
                              {
                                 _loc2_.nodeView.visible = false;
                                 _loc2_.nodeView.mouseEnabled = false;
                              }
                           }
                           if(!_loc2_.nodeView.visible)
                           {
                              if(_model.selfCastles != null)
                              {
                                 if(_model.mySelfCastles != null)
                                 {
                                    if(Math.abs(_loc2_.x - _model.mySelfCastles.x) > 660 || Math.abs(_loc2_.y - _model.mySelfCastles.y) > 660)
                                    {
                                       _loc2_.nodeView.visible = false;
                                       _loc2_.nodeView.mouseEnabled = false;
                                    }
                                    else
                                    {
                                       _loc2_.nodeView.visible = true;
                                       _loc2_.nodeView.mouseEnabled = true;
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      private function updateWildLandVisible() : void
      {
         var _loc1_:Dictionary = _model.allWildLand;
         if(_loc1_ == null)
         {
            return;
         }
         for each(var _loc3_:Dictionary in _loc1_)
         {
            for each(var _loc2_:MapPhysics in _loc3_)
            {
               if(_loc2_.nodeView != null)
               {
                  if(_loc2_.info.occupyPlayerId != playerInfo.userId)
                  {
                     if(_model.bossInfo.leftFogTime > 0)
                     {
                        _loc2_.nodeViewVisible = true;
                     }
                     else
                     {
                        _loc2_.nodeViewVisible = false;
                        if(checkTeamMember(_loc2_.x,_loc2_.y))
                        {
                           _loc2_.nodeViewVisible = true;
                        }
                        else
                        {
                           _loc2_.nodeViewVisible = false;
                           if(selfArmy.armyView != null)
                           {
                              if(Math.abs(_loc2_.x - selfArmy.armyView.x) > 660 || Math.abs(_loc2_.y - selfArmy.armyView.y) > 660)
                              {
                                 _loc2_.nodeViewVisible = false;
                              }
                              else
                              {
                                 _loc2_.nodeViewVisible = true;
                              }
                           }
                           if(!_loc2_.nodeViewVisible)
                           {
                              if(_model.selfCastles != null)
                              {
                                 if(_model.mySelfCastles != null)
                                 {
                                    if(Math.abs(_loc2_.x - _model.mySelfCastles.x) > 660 || Math.abs(_loc2_.y - _model.mySelfCastles.y) > 660)
                                    {
                                       _loc2_.nodeViewVisible = false;
                                    }
                                    else
                                    {
                                       _loc2_.nodeViewVisible = true;
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      private function updateArmyVisible() : void
      {
         var _loc2_:BaseArmy = null;
         var _loc3_:Dictionary = _model.allArmyDict;
         if(_loc3_ == null)
         {
            return;
         }
         for each(var _loc1_:UserArmy in _loc3_)
         {
            if(_loc1_.armyView != null)
            {
               if(_loc1_.userId != playerInfo.userId)
               {
                  if(FreedomTeamManager.instance.model != null)
                  {
                     _loc2_ = FreedomTeamManager.instance.model.getMemberByUserId(_loc1_.userId);
                     if(_loc2_ != null)
                     {
                        _loc1_.armyView.visible = true;
                        _loc1_.armyView["setAllVisible"](true);
                        _view.denseFogLayer.addArmyHole(_loc2_.userId,_loc2_.curPosX * 20,_loc2_.curPosY * 20);
                        continue;
                     }
                  }
                  if(_model.bossInfo.leftFogTime > 0)
                  {
                     _loc1_.armyView.visible = true;
                     _loc1_.armyView["setAllVisible"](true);
                  }
                  else
                  {
                     _loc1_.armyView.visible = false;
                     _loc1_.armyView["setAllVisible"](false);
                     if(checkTeamMember(_loc1_.armyView.x,_loc1_.armyView.y))
                     {
                        _loc1_.armyView.visible = true;
                        _loc1_.armyView["setAllVisible"](true);
                     }
                     else
                     {
                        _loc1_.armyView.visible = false;
                        _loc1_.armyView["setAllVisible"](false);
                        if(selfArmy.armyView != null)
                        {
                           _loc1_.armyView.visible = true;
                           _loc1_.armyView["setAllVisible"](true);
                           if(Math.abs(_loc1_.armyView.x - selfArmy.armyView.x) > 660 || Math.abs(_loc1_.armyView.y - selfArmy.armyView.y) > 660)
                           {
                              _loc1_.armyView.visible = false;
                              _loc1_.armyView["setAllVisible"](false);
                           }
                        }
                        if(!_loc1_.armyView.visible)
                        {
                           if(_model.selfCastles != null)
                           {
                              if(_model.mySelfCastles != null)
                              {
                                 if(Math.abs(_loc1_.armyView.x - _model.mySelfCastles.x) > 660 || Math.abs(_loc1_.armyView.y - _model.mySelfCastles.y) > 660)
                                 {
                                    _loc1_.armyView.visible = false;
                                    _loc1_.armyView["setAllVisible"](false);
                                 }
                                 else
                                 {
                                    _loc1_.armyView.visible = true;
                                    _loc1_.armyView["setAllVisible"](true);
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      private function checkTeamMember(param1:int, param2:int) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:BaseArmy = null;
         var _loc4_:Boolean = false;
         if(FreedomTeamManager.instance.model == null)
         {
            return _loc4_;
         }
         var _loc3_:Array = FreedomTeamManager.instance.model.allMembers;
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = _model.getWorldArmyById(_loc3_[_loc5_].id);
            if(!FreedomTeamManager.instance.memberIsOnline(_loc3_[_loc5_].id))
            {
               if(_loc6_ != null)
               {
                  if(_loc6_.armyView != null)
                  {
                     if(!(Math.abs(param1 - _loc6_.armyView.x) > 660 || Math.abs(param2 - _loc6_.armyView.y) > 660))
                     {
                        return true;
                     }
                     _loc4_ = false;
                  }
               }
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         var _loc3_:String = LanguageMgr.GetTranslation("map.outercity.OuterCityController.logTip");
         log({},_loc3_ + getTimer());
         SmallMapBar.instance.switchSmallMapState(6);
         OuterCityServiceManager.getInstance().setup(thane.userId,userKey,_model.mapId);
         _model.addEventListener("nineSliceScaling",__nineSliceScalingHandler);
         addSocketEvent();
         _view = new OuterCityMap(this,_model);
         SoundManager.instance.playMusic("outercity",-1,true,true);
         this.addChild(_view);
         ChatBar.instance.show();
         attackBuild();
         NotificationManager.instance.addEventListener("START_MOVE",__startMoveHandler);
         NotificationManager.instance.addEventListener("MOVE_OVER",__moveOverHandler);
         NotificationManager.instance.addEventListener("ARMY_SYSC_CALL",__syscArmyHandler);
         NotificationManager.instance.addEventListener("OPEN_CAMPAIGN_FRAME",__armyStopHanlder);
         _bossInfoView = ComponentFactory.Instance.creatCustomObject("outercity.bossinfo.OuterCityBossInfoView");
         addChild(_bossInfoView);
         if(_model.mapId < 100 && thane.grades >= 15)
         {
            _archaeologyView = ComponentFactory.Instance.creatCustomObject("outercity.archaeologyView");
            addChild(_archaeologyView);
         }
         OuterCityManager.instance.getBossInfo(_model.mapId);
      }
      
      private function attackBuild() : void
      {
         if(!_attacking)
         {
            _attacking = ComponentFactory.Instance.creatCustomObject("asset.outercity.AttackingAsset2");
         }
         _attacking.x = -55;
         _attacking.y = -155;
         _attacking.mouseChildren = _attacking.mouseEnabled = false;
         _attacking.scrollRect = null;
      }
      
      override public function enterOver() : void
      {
         TopToolsBar.instance.show();
         ChatTopBugleView.instance.setPos();
         MainToolBar.instance.show();
         ResourcesBar.instance.show();
         TaskTraceBar.instance.show();
         if(TaskTraceBar.instance.openTipView)
         {
            TaskTraceBar.instance.openTipView.visible = false;
         }
         TipsBar.instance.show();
         FullBar.instance.show();
         SmallMapBar.instance.show();
         if(_parms && _parms is MapInitData && !_parms.showMapName)
         {
            return;
         }
         if(_parms && _parms.hasOwnProperty("showMapName") && !_parms.showMapName)
         {
            return;
         }
         new MapNameMovie(sendComplete).loadIcon(_model.mapId);
      }
      
      private function sendComplete() : void
      {
         NotificationManager.instance.dispatchEvent(new SceneViewEvent("addToStage","OUTER_CITY_SCENE"));
      }
      
      public function get outerFrameManager() : OuterFrameManager
      {
         return OuterFrameManager.getInstance();
      }
      
      override public function leaving() : void
      {
         removeEvent();
         clearInterval(timeid);
         OuterFrameManager.getInstance().dispose();
         FullBar.instance.hide();
         MainToolBar.instance.hide();
         TipsBar.instance.hide();
         ResourcesBar.instance.hide();
         SmallMapBar.instance.hide();
         ChatBar.instance.hide();
         TopToolsBar.instance.hide();
         BagHelper.instance.stopSelling();
         TaskTraceBar.instance.hide();
         if(TaskTraceBar.instance.openTipView)
         {
            TaskTraceBar.instance.openTipView.visible = true;
         }
         if(_view)
         {
            if(_view.parent)
            {
               _view.parent.removeChild(_view);
            }
            _view.dispose();
         }
         _view = null;
         ObjectUtils.disposeObject(_archaeologyView);
         _archaeologyView = null;
         if(_model)
         {
            MapElmsLibrary.instance.unLock();
            _model.removeEventListener("nineSliceScaling",__nineSliceScalingHandler);
            _model.dispose();
         }
         _model = null;
         ShowTipManager.Instance.removeCurrentTip();
         OuterCityManager.instance.dispose();
         if(_attacking)
         {
            if(_attacking.parent)
            {
               _attacking.parent.removeChild(_attacking);
            }
            _attacking.stop();
            _attacking = null;
         }
         NotificationManager.instance.removeEventListener("START_MOVE",__startMoveHandler);
         NotificationManager.instance.removeEventListener("MOVE_OVER",__moveOverHandler);
         NotificationManager.instance.removeEventListener("ARMY_SYSC_CALL",__syscArmyHandler);
         NotificationManager.instance.removeEventListener("OPEN_CAMPAIGN_FRAME",__armyStopHanlder);
         FootprintItems.dispose();
         clearInterval(_updateNodeVisibleUint);
         _bossInfoView.dispose();
         this.removeChild(_bossInfoView);
         _bossInfoView = null;
      }
      
      private function __syscArmyHandler(param1:NotificationEvent) : void
      {
         OuterCitySocketOutManager.sendArmyPosRequest();
      }
      
      override public function get SceneName() : String
      {
         return "OUTER_CITY_SCENE";
      }
      
      public function get mapView() : OuterCityMap
      {
         return _view;
      }
      
      private function __moveOverHandler(param1:OuterCityEvent) : void
      {
         var _loc3_:Point = null;
         var _loc6_:ArmyView = null;
         var _loc4_:OuterCityNode = null;
         var _loc2_:Point = null;
         param1.stopPropagation();
         var _loc5_:Point = param1.data as Point;
         _view.worldWalkLayer.walkTarget.visible = false;
         if(_attacking)
         {
            if(_attacking.parent)
            {
               _attacking.parent.removeChild(_attacking);
            }
            _attacking.stop();
         }
         if(_model.walkTargerData)
         {
            _loc3_ = new Point(_model.walkTargerData.x,_model.walkTargerData.y);
            if(Point.distance(_loc3_,_loc5_) < 100)
            {
               if(_model.walkTargerData is BaseCastle)
               {
                  OuterFrameManager.getInstance().open(1,_model.walkTargerData);
               }
               else if(_model.walkTargerData is WildLand)
               {
                  switch(int(_model.walkTargerData.info.types) - 20)
                  {
                     case 0:
                        OuterFrameManager.getInstance().open(2,_model.walkTargerData);
                        break;
                     case 1:
                     case 2:
                        OuterFrameManager.getInstance().open(4,_model.walkTargerData);
                  }
               }
               else
               {
                  _model.walkTargerData = null;
               }
            }
            else
            {
               _model.walkTargerData = null;
            }
         }
         else
         {
            if(!_model.selfArmy() || !_model.selfArmy().armyView)
            {
               return;
            }
            _loc6_ = _model.selfArmy().armyView as ArmyView;
            _loc4_ = _model.getHandlerNode(_loc6_.x / 20,_loc6_.y / 20);
            if(!_loc4_)
            {
               return;
            }
            _loc2_ = OuterCityArmyViewHelper.getResetPoint(_loc4_,_loc6_,new Point(int(_loc6_.x / 20),int(_loc6_.y / 20)));
            if(_loc4_.info.types == 92)
            {
               _loc4_.info.state = 9;
               _loc4_.commit();
               return;
            }
            OuterCityArmyViewHelper.sendMessage(_loc2_,_loc4_);
         }
      }
      
      public function sendAttack(param1:int, param2:int) : void
      {
         var _loc3_:ArmyView = selfAvatarView;
         if(!_loc3_)
         {
            return;
         }
         sendWalkPath([new Point(_loc3_.x,_loc3_.y),new Point(_loc3_.x,_loc3_.y)]);
         OuterCitySocketOutManager.sendAttack(_model.mapId,param1,param2);
      }
      
      private function get serverTime() : Date
      {
         return PlayerManager.instance.currentPlayerModel.sysCurtime;
      }
      
      private function __armyStopHanlder(param1:NotificationEvent) : void
      {
         if(selfAvatarView)
         {
            selfAvatarView.info.pathInfo = [];
         }
      }
      
      private function __startMoveHandler(param1:OuterCityEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Point = null;
         var _loc4_:MapPhysics = null;
         if(!_model)
         {
            return;
         }
         if(!selfArmy && selfArmy.mapId != _model.mapId)
         {
            _loc2_ = LanguageMgr.GetTranslation("map.outercity.mediator.mapview.OuterCitySmallMapMediator.command01");
            MessageTipManager.instance().show(_loc2_);
            NotificationManager.instance.dispatchEvent(new NotificationEvent("ARMY_SYSC_CALL",null));
            return;
         }
         var _loc5_:MovieClip = _view.worldWalkLayer.walkTarget;
         if(param1.data is Point)
         {
            _model.walkTargerData = null;
            _loc3_ = param1.data as Point;
            if(_attacking)
            {
               if(_attacking.parent)
               {
                  _attacking.parent.removeChild(_attacking);
               }
               _attacking.stop();
            }
            _loc5_.visible = true;
         }
         else if(param1.data is MapPhysics)
         {
            _loc4_ = param1.data as MapPhysics;
            _model.walkTargerData = CopyNodeDataHelper.cloneMapPhysics(_loc4_);
            _loc3_ = new Point(_model.walkTargerData.x,_model.walkTargerData.y + 40);
            _attacking.x = _model.walkTargerData.x - 55;
            _attacking.y = _model.walkTargerData.y - 155;
            _attacking.play();
            _loc5_.visible = false;
         }
         if(!selfAvatarView)
         {
            if(_model)
            {
               _model.layMapArmy([selfArmy]);
            }
            return;
         }
         var _loc7_:Point = new Point(int(selfAvatarView.x),int(selfAvatarView.y));
         _loc7_ = GetWalkStartPointHelper.getStartPoint(_loc7_.x,_loc7_.y,_model);
         var _loc6_:Array = _view.worldWalkLayer.pathScene.searchPath(_loc7_,_loc3_);
         if(_loc6_ && _loc6_.length > 0)
         {
            _loc5_.x = _loc6_[_loc6_.length - 1].x;
            _loc5_.y = _loc6_[_loc6_.length - 1].y;
         }
         selfAvatarView.info.pathInfo = _loc6_;
      }
      
      public function get selfAvatarView() : ArmyView
      {
         var _loc1_:BaseArmy = _model.getWorldArmyByUserId(playerInfo.userId);
         if(_loc1_)
         {
            return _loc1_.armyView as ArmyView;
         }
         return null;
      }
      
      private function __nineSliceScalingHandler(param1:OuterCityEvent) : void
      {
         var _loc2_:Array = _model.checkConfigNoExites();
         if(_loc2_.length > 0 && _model.floorData)
         {
            _model.currentFloorData = _loc2_;
         }
      }
      
      public function moveMapCallBack(param1:Rectangle) : void
      {
         _model.targetPoint = new Point(param1.x,param1.y);
         _model.nineSliceScaling = Utils.getNineSliceScaling(param1);
         var _loc2_:Array = _model.checkUpdateConfig();
         if(_loc2_.length == 0)
         {
            return;
         }
         sendRefreshScreen(Utils.getFilesIds(_loc2_));
      }
      
      public function sendRefreshScreen(param1:String) : void
      {
         if(param1 == "")
         {
            return;
         }
         OuterCitySocketOutManager.sendCurrentScreen(getCurrent9Screens(),_model.mapId);
         OuterCitySocketOutManager.sendGetArmyByGrid(_model.mapId,param1);
         OuterCitySocketOutManager.sendGetWildLandByGrid(_model.mapId,param1);
      }
      
      private function getCurrent9Screens() : String
      {
         return Utils.getFilesIds(_model.nineSliceScaling);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get mapNodeInfo() : BaseCastle
      {
         return PlayerManager.instance.currentPlayerModel.mapNodeInfo;
      }
      
      public function get selfArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get userKey() : String
      {
         return PlayerManager.instance.currentPlayerModel.userInfo.key;
      }
      
      private function get playerEffect() : PlayerEffectInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerEffect;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function addSocketEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4167,__broadPosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 169,__updateScreenArmysHandler);
         SocketManager.instance.addEventListener("UPDATE_CASTLE",__updateCastleHandler);
         SocketManager.instance.addEventListener("UPDATE_WILDLAND",__updateWildLandHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 98,__returnHomeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 118,__updateStatusHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4129,__physicListByBridHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4168,__armyExitOuterCityHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4241,__syncArmyPosHandler);
         NotificationManager.instance.addEventListener("$UPDTAE_ARMY",__updateArmyHandler);
         NotificationManager.instance.addEventListener("UPDATE_CHAT_VIEW",__playerChatHandler);
         BuildingManager.instance.addEventListener("U_UNOCCPWILDLAND",__unoccupyHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4237,__transferPosationHandler);
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4167,__broadPosHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 169,__updateScreenArmysHandler);
         SocketManager.instance.removeEventListener("UPDATE_CASTLE",__updateCastleHandler);
         SocketManager.instance.removeEventListener("UPDATE_WILDLAND",__updateWildLandHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 98,__returnHomeHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 118,__updateStatusHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4129,__physicListByBridHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4168,__armyExitOuterCityHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4241,__syncArmyPosHandler);
         NotificationManager.instance.removeEventListener("$UPDTAE_ARMY",__updateArmyHandler);
         NotificationManager.instance.removeEventListener("UPDATE_CHAT_VIEW",__playerChatHandler);
         BuildingManager.instance.removeEventListener("U_UNOCCPWILDLAND",__unoccupyHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4237,__transferPosationHandler);
      }
      
      private function __syncArmyPosHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArmyPositionMsg = new ArmyPositionMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ArmyPositionMsg;
         selfArmy.mapId = _loc2_.mapId;
         selfArmy.curPosX = _loc2_.posX;
         selfArmy.curPosY = _loc2_.posY;
         selfArmy.commit();
      }
      
      private function __armyExitOuterCityHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArmyRemoveMsg = new ArmyRemoveMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ArmyRemoveMsg;
         _model.removeWorldArmyById(_loc2_.armyId);
      }
      
      private function __broadPosHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:RouteMsg = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:PosMoveMsg = new PosMoveMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as PosMoveMsg;
         var _loc4_:BaseArmy = _model.getWorldArmyById(_loc2_.armyId);
         if(!_loc4_)
         {
            return;
         }
         var _loc6_:ArmyView = _loc4_.armyView as ArmyView;
         if(!_loc6_)
         {
            return;
         }
         var _loc7_:Point = new Point(_loc6_.x,_loc6_.y);
         var _loc5_:Array = [];
         _loc5_.push(_loc7_);
         while(_loc2_.routes.length > 0)
         {
            _loc3_ = _loc2_.routes.shift();
            _loc5_.push(new Point(_loc3_.x,_loc3_.y));
         }
         _loc6_.info.pathInfo = _loc5_;
      }
      
      private function __physicListByBridHandler(param1:SLGSocketEvent) : void
      {
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:PhysicListUpdateMsg = new PhysicListUpdateMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as PhysicListUpdateMsg;
         var _loc7_:Array = [];
         for each(var _loc6_:WildLandMsg in _loc2_.wildLand)
         {
            _loc7_.push(readWildLand(_loc6_));
         }
         var _loc4_:Array = [];
         for each(var _loc3_:BaseCastleMsg in _loc2_.baseCastle)
         {
            _loc4_.push(readBaseCastle(_loc3_));
         }
         var _loc5_:String = _loc2_.reqGrid;
         _model.currentWildLand = _loc7_;
         _model.currentCastles = _loc4_;
      }
      
      private function readBaseCastle(param1:BaseCastleMsg) : BaseCastle
      {
         var _loc3_:BaseCastle = null;
         var _loc2_:PhysicInfo = null;
         _loc3_ = _model.getCastleById(param1.id,param1.posX * 20,param1.posY * 20);
         if(!_loc3_)
         {
            _loc3_ = _model.popCastleInfo();
         }
         if(!_loc3_)
         {
            _loc3_ = new BaseCastle();
            _loc2_ = new PhysicInfo();
         }
         else
         {
            _loc2_ = _loc3_.info;
         }
         _loc3_.defenceLeftTime = param1.defenceLefttime;
         _loc2_.id = param1.id;
         _loc2_.mapId = param1.mapId;
         _loc2_.occupyLeagueName = param1.occupyLeagueName;
         _loc2_.occupyPlayerId = param1.occupyPlayerId;
         if(_loc2_.occupyPlayerId == playerInfo.userId)
         {
            mapNodeInfo.defenceLeftTime = _loc3_.defenceLeftTime;
         }
         _loc2_.occupyPlayerName = param1.occupyPlayerName;
         _loc2_.posX = param1.posX;
         _loc2_.posY = param1.posY;
         _loc2_.state = param1.state;
         _loc2_.names = param1.castleName;
         _loc2_.types = param1.type;
         _loc2_.grade = param1.grade;
         _loc2_.vipCastleView = param1.vipCastleView;
         _loc2_.vipType = param1.vipType;
         _loc3_.info = _loc2_;
         return _loc3_;
      }
      
      private function readWildLand(param1:WildLandMsg) : WildLand
      {
         var _loc5_:WildLand = null;
         var _loc8_:PhysicInfo = null;
         var _loc2_:SystemArmy = null;
         var _loc4_:int = 0;
         var _loc3_:ArmyPawn = null;
         var _loc7_:ArmyPawnInfoMsg = null;
         var _loc6_:int = int(param1.id);
         _loc5_ = _model.getWildLandByXY(param1.posX * 20 + "," + param1.posY * 20);
         if(!_loc5_)
         {
            _loc5_ = new WildLand();
            _loc8_ = new PhysicInfo();
            _loc2_ = new SystemArmy();
         }
         else
         {
            _loc8_ = _loc5_.info;
            _loc2_ = _loc5_.ownSysArmy;
         }
         _loc8_.id = _loc6_;
         _loc8_.posX = param1.posX;
         _loc8_.posY = param1.posY;
         _loc8_.types = param1.type;
         _loc8_.mapId = param1.mapId;
         _loc8_.grade = param1.level;
         _loc8_.state = param1.state;
         _loc5_.fightCapaity = param1.fightCapaity;
         _loc5_.templateId = param1.templateId;
         _loc5_.refreshTime = param1.refreshTime;
         _loc8_.occupyPlayerId = param1.occupyPlayerId;
         _loc8_.occupyPlayerName = param1.occupyPlayerName;
         _loc8_.occupyLeagueName = param1.occupyLeagueName;
         _loc5_.createDate = DateFormatter.parse(param1.createDate,"YYYY-MM-DD hh:mm:ss");
         _loc5_.curArmyId = param1.curArmyId;
         _loc5_.info = _loc8_;
         if(param1.hasBossType)
         {
            _loc8_.bossType = param1.bossType;
         }
         if(param1.hasSize)
         {
            _loc8_.size = param1.size;
         }
         if(param1.hasSimpleHeroInfo)
         {
            ThaneInfoHelper.readHeroInfo(_loc2_.baseHero,param1.simpleHeroInfo);
         }
         _loc4_ = 0;
         while(_loc4_ < 2)
         {
            _loc3_ = _loc2_.getPawnByIndex(_loc4_);
            if(_loc4_ < param1.armyPawn.length)
            {
               _loc7_ = param1.armyPawn[_loc4_] as ArmyPawnInfoMsg;
               _loc3_.id = _loc7_.id;
               _loc3_.armyId = _loc7_.armyId;
               _loc3_.templateId = _loc7_.tempateId;
               _loc3_.ownPawns = _loc7_.ownPawns;
            }
            else if(_loc3_)
            {
               _loc2_.removeArmyPawnCountByIndex(_loc4_,_loc3_.ownPawns);
            }
            _loc4_++;
         }
         _loc5_.ownSysArmy = _loc2_;
         _loc5_.commit();
         return _loc5_;
      }
      
      private function __updateScreenArmysHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:BaseArmy = null;
         var _loc4_:ThaneInfo = null;
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc11_:ArmyMsg = null;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArmyUpdatedGridMsg = new ArmyUpdatedGridMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as ArmyUpdatedGridMsg;
         var _loc10_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _loc2_.updatedArmy.length)
         {
            _loc11_ = _loc2_.updatedArmy[_loc7_] as ArmyMsg;
            _loc6_ = int(_loc11_.armyId);
            _loc9_ = int(_loc11_.playerId);
            if(_loc9_ == thane.userId)
            {
               _loc3_ = selfArmy;
               _loc4_ = _loc3_.baseHero;
            }
            else
            {
               _loc3_ = _model.getWorldArmyById(_loc6_);
               if(!_loc3_)
               {
                  _loc3_ = new UserArmy();
                  _loc4_ = new ThaneInfo();
               }
               else
               {
                  _loc4_ = _loc3_.baseHero;
               }
               _loc3_.baseHero = _loc4_;
               _loc3_.id = _loc11_.armyId;
               _loc3_.userId = _loc9_;
               _loc4_.userId = _loc9_;
            }
            if(_loc11_.hasIsVip)
            {
               _loc3_.baseHero.IsVipAndNoExpirt = _loc11_.isVip;
            }
            if(_loc3_.baseHero)
            {
               _loc3_.baseHero.beginChanges();
            }
            _loc3_ = ThaneInfoHelper.readOuterCityArmyInfo(_loc3_,_loc11_);
            if(_loc3_.baseHero)
            {
               _loc3_.baseHero.commit();
            }
            _loc3_.commit();
            _loc3_.petInfo.commit();
            _model.addArmyToWorldDict(_loc3_);
            _loc10_.push(_loc3_);
            _loc7_++;
         }
         if(_model)
         {
            _model.layMapArmy(_loc10_);
         }
      }
      
      private function __updateStatusHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:CastleDefenseRspMsg = new CastleDefenseRspMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as CastleDefenseRspMsg;
         mapNodeInfo.defenceLeftTime = _loc2_.leftTime;
         var _loc3_:int = _loc2_.posX * 20;
         var _loc4_:int = _loc2_.posY * 20;
         var _loc5_:BaseCastle = _model.getCastleByXY(_loc3_,_loc4_);
         if(_loc5_)
         {
            _loc5_.defenceLeftTime = _loc2_.leftTime;
            _loc5_.commit();
         }
      }
      
      private function __updateCastleHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:BaseCastleMsg = param1.data as BaseCastleMsg;
         var _loc3_:BaseCastle = readBaseCastle(_loc2_);
         _loc3_.commit();
         _loc2_ = null;
      }
      
      private function __updateWildLandHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:WildLandMsg = param1.data as WildLandMsg;
         var _loc3_:WildLand = readWildLand(_loc2_);
         _model.updateWildLand(_loc3_);
      }
      
      private function __updateArmyHandler(param1:NotificationEvent) : void
      {
         var _loc2_:BaseArmy = param1.data as BaseArmy;
         var _loc3_:BaseArmy = _model.getWorldArmyByUserId(_loc2_.userId);
         if(_loc3_)
         {
            ThaneInfoHelper.cloneArmyInfo(_loc3_,_loc2_);
            _model.addArmyToWorldDict(_loc3_);
            _model.layMapArmy([_loc3_]);
         }
         else
         {
            _model.addArmyToWorldDict(_loc2_);
            _model.layMapArmy([_loc2_]);
         }
      }
      
      private function __returnHomeHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:BaseArmy = null;
         var _loc5_:ArmyView = null;
         var _loc4_:Point = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:OutercityRspMsg = new OutercityRspMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as OutercityRspMsg;
         var _loc7_:int = _loc2_.result;
         var _loc3_:UserArmy = selfArmy;
         if(_loc3_ && _loc3_.id == _loc7_)
         {
            _loc3_.curPosX = _loc2_.curPosX;
            _loc3_.curPosY = _loc2_.curPosY;
            _loc6_ = _model.getWorldArmyById(_loc3_.id);
            if(!_loc6_)
            {
               return;
            }
            _loc5_ = _loc6_.armyView as ArmyView;
            if(_loc5_)
            {
               _loc5_.info.pathInfo = [];
               _loc5_.x = _loc3_.curPosX * 20;
               _loc5_.y = _loc3_.curPosY * 20;
            }
            _loc4_ = new Point(_loc3_.curPosX * 20 - StageReferance.stageWidth / 2,_loc3_.curPosY * 20 - StageReferance.stageHeight / 2);
            _view.motionTo(_loc4_);
            _view.worldWalkLayer.outSceneMovies();
            _model.returnHome(_loc7_);
         }
      }
      
      private function __transferPosationHandler(param1:SLGSocketEvent) : void
      {
         var buildInfoi:BuildInfo;
         var aInfo:BaseArmy;
         var av:ArmyView;
         var containter:MovieClip;
         var move:SimpleMovie;
         var point:Point;
         var setArmyPoint:*;
         var event:SLGSocketEvent = param1;
         var pkg:PackageIn = event.data as PackageIn;
         var msg:ArmyPositionMsg = new ArmyPositionMsg();
         msg = pkg.readBody(msg) as ArmyPositionMsg;
         var army:UserArmy = selfArmy;
         army.curPosX = msg.posX;
         army.curPosY = msg.posY;
         buildInfoi = BuildingManager.instance.model.buildingListByID[-11];
         buildInfoi.property1 = msg.leftEnergy;
         aInfo = _model.getWorldArmyById(army.id);
         if(!aInfo)
         {
            return;
         }
         av = aInfo.armyView as ArmyView;
         if(av)
         {
            setArmyPoint = function():void
            {
               clearInterval(timeid);
               av.isPlaying = true;
            };
            av.info.pathInfo = [];
            av.x = army.curPosX * 20;
            av.y = army.curPosY * 20;
            containter = ComponentFactory.Instance.creatCustomObject("asset.outercity.transmit");
            move = new SimpleMovie(containter);
            point = _view.worldWalkLayer.localToGlobal(new Point(av.x,av.y));
            move.x = av.x;
            move.y = av.y;
            _view.addChild(move);
            timeid = setTimeout(setArmyPoint,700);
         }
         else if(_model)
         {
            _model.layMapArmy([selfArmy]);
         }
         _model.posationHandler(army.id);
      }
      
      private function __playerChatHandler(param1:NotificationEvent) : void
      {
         var _loc3_:ChatData = param1.data as ChatData;
         if(_loc3_.channel != 8)
         {
            return;
         }
         var _loc2_:BaseArmy = _model.getWorldArmyByUserId(_loc3_.uid);
         if(_loc2_)
         {
            _loc2_.chatData = _loc3_;
         }
      }
      
      public function sendReturnHomeArmy() : Boolean
      {
         var _loc1_:String = null;
         var _loc2_:Point = null;
         var _loc5_:Point = null;
         if(selfArmy.mapId != _model.mapId)
         {
            _loc1_ = LanguageMgr.GetTranslation("map.outercity.mediator.mapview.OuterCitySmallMapMediator.command01");
            MessageTipManager.instance().show(_loc1_);
            NotificationManager.instance.dispatchEvent(new NotificationEvent("ARMY_SYSC_CALL",null));
            return false;
         }
         var _loc3_:BaseArmy = _model.getWorldArmyById(selfArmy.id);
         if(!_loc3_)
         {
            return false;
         }
         var _loc4_:ArmyView = _loc3_.armyView as ArmyView;
         if(_loc4_)
         {
            _loc2_ = new Point(int(_loc4_.x / 20),int(_loc4_.y / 20));
            _loc5_ = new Point(mapNodeInfo.info.posX,mapNodeInfo.info.posY);
            if(Point.distance(_loc2_,_loc5_) < 12)
            {
               _loc1_ = LanguageMgr.GetTranslation("map.outercity.mediator.mapview.OuterCitySmallMapMediator.command03");
               MessageTipManager.instance().show(_loc1_);
               return false;
            }
         }
         OuterCitySocketOutManager.sendArmyBack(1);
         return true;
      }
      
      private function portal() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc2_:String = LanguageMgr.GetTranslation("map.campaign.view.ui.RiverView.txt.TransmitHandler.content");
         _alert = AlertManager.Instance.simpleAlert(_loc1_,_loc2_);
         _alert.addEventListener("response",__transferHandler);
      }
      
      private function __transferHandler(param1:FrameEvent) : void
      {
         var _loc6_:BuildInfo = null;
         var _loc8_:ConfigInfosTempInfo = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc10_:String = null;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc6_ = BuildingManager.instance.model.buildingListByID[-11];
            _loc8_ = TempleteManager.instance.getConfigInfoByConfigName("transport_charge_cost");
            _loc7_ = int(playerEffect.getTransferPowerLimitAddition(_loc6_.templeteInfo.Property2));
            _loc5_ = int(_loc6_.property1);
            _loc9_ = _loc7_ - _loc5_;
            if(100 <= _loc5_)
            {
               OuterFrameManager.getInstance().closeAll();
               OuterCitySocketOutManager.sendArmyBack(1);
               _view.motionTo(new Point(mapNodeInfo.x - StageReferance.stageWidth / 2,mapNodeInfo.y - StageReferance.stageHeight / 2));
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("map.outercity.mediator.mapview.TransmitHandler.command02",_loc8_.ConfigValue);
               _loc3_ = LanguageMgr.GetTranslation("public.confirm");
               _loc4_ = LanguageMgr.GetTranslation("public.cancel");
               _loc10_ = LanguageMgr.GetTranslation("map.internals.view.displaye.PhysicsMenu.PORTAL");
               SimpleAlertHelper.instance.data = [transferBack];
               SimpleAlertHelper.instance.popAlerFrame(_loc10_,_loc2_,_loc3_,_loc4_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc8_.ConfigValue);
            }
         }
         _alert.removeEventListener("response",__transferHandler);
         _alert.dispose();
         _alert = null;
      }
      
      private function transferBack(param1:Boolean, param2:Boolean, param3:int = 0, param4:int = 2) : void
      {
         if(param1)
         {
            if(!param2)
            {
               param4 = 1;
            }
            OuterFrameManager.getInstance().closeAll();
            OuterCitySocketOutManager.sendArmyBack(param4);
            _view.motionTo(new Point(mapNodeInfo.x - StageReferance.stageWidth / 2,mapNodeInfo.y - StageReferance.stageHeight / 2));
         }
      }
      
      public function sendGiveUp(param1:MapPhysics) : Boolean
      {
         if(param1.info.occupyPlayerId == thane.userId)
         {
            BuildingSocketOutManager.unoccupy(param1.posX + "," + param1.posY);
            return true;
         }
         return false;
      }
      
      private function __unoccupyHandler(param1:BuildingEvent) : void
      {
         var _loc2_:WildLand = _model.getWildLandByXY(param1.data as String);
         if(_loc2_)
         {
            _loc2_.info.occupyPlayerId = 0;
            _loc2_.commit();
         }
      }
      
      public function sendWalkPath(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
      }
      
      public function sendWalkPathII(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:RouteMsg = null;
         if(!param1 || param1.length < 1)
         {
            return;
         }
         var _loc2_:PosMoveMsg = new PosMoveMsg();
         var _loc5_:RouteMsg = new RouteMsg();
         _loc5_.x = selfAvatarView.x;
         _loc5_.y = selfAvatarView.y;
         param1.unshift(_loc5_);
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = new RouteMsg();
            _loc3_.x = param1[_loc4_].x;
            _loc3_.y = param1[_loc4_].y;
            param1[_loc4_] = _loc3_;
            _loc4_++;
         }
         _loc2_.routes = param1;
         _loc2_.armyId = ArmyManager.instance.army.id;
         _loc2_.gridStr = MapDataUtils.getTitleFileName(selfAvatarView.x,selfAvatarView.y);
         _loc2_.mapId = _model.mapId;
         OuterCitySocketOutManager.sendMovePaths(_loc2_);
      }
   }
}

