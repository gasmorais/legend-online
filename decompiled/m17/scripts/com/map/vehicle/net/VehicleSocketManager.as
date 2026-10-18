package com.map.vehicle.net
{
   import chat.datas.ChatData;
   import com.map.vehicle.VehicleModel;
   import com.map.vehicle.VehicleSceneController;
   import com.map.vehicle.action.AccountAction;
   import com.map.vehicle.data.HurtData;
   import com.map.vehicle.data.PlayerVehicleInfo;
   import com.map.vehicle.data.UseSkillInfo;
   import com.map.vehicle.data.VGlobal;
   import com.map.vehicle.data.VehicleAccountInfo;
   import com.map.vehicle.data.VehicleBufferDamageInfo;
   import com.map.vehicle.data.VehicleNode;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.objects.TankAvatarView;
   import com.pickgliss.ui.core.Disposeable;
   import com.road.mapengine.ai.astar.AIManager;
   import com.road.yishi.proto.room.RoomCreatedMsg;
   import com.road.yishi.proto.room.VehicleBuffListMsg;
   import com.road.yishi.proto.room.VehicleBuffStateMsg;
   import com.road.yishi.proto.room.VehicleSkillListMsg;
   import com.road.yishi.proto.vehicle.HurtDataMsg;
   import com.road.yishi.proto.vehicle.PlayerVehicleListMsg;
   import com.road.yishi.proto.vehicle.PlayerVehicleMsg;
   import com.road.yishi.proto.vehicle.VehicleAttackRspMsg;
   import com.road.yishi.proto.vehicle.VehicleCampaignDetailMsg;
   import com.road.yishi.proto.vehicle.VehicleExitMsg;
   import com.road.yishi.proto.vehicle.VehicleMoveMsg;
   import com.road.yishi.proto.vehicle.VehicleNpcNodeListMsg;
   import com.road.yishi.proto.vehicle.VehicleNpcNodeMsg;
   import com.road.yishi.proto.vehicle.VehicleScroeListMsg;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import managers.RoomManager;
   import proxy.SocketDataProxyEventEvent;
   import proxy.SocketDataProxyManager;
   import yishi.SwitchPageHelp;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SocketSceneBufferManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yzhkof.debug.log;
   
   public class VehicleSocketManager implements Disposeable
   {
      
      private static var _instance:VehicleSocketManager;
      
      private var _model:VehicleModel;
      
      private var _isUse:Boolean = false;
      
      public var controller:VehicleSceneController;
      
      public function VehicleSocketManager()
      {
         super();
      }
      
      public static function get instance() : VehicleSocketManager
      {
         if(!_instance)
         {
            _instance = new VehicleSocketManager();
         }
         return _instance;
      }
      
      public function setup(param1:Boolean = false, param2:PackageIn = null) : void
      {
         if(_isUse)
         {
            return;
         }
         _isUse = true;
         if(param2)
         {
            createMapModel(param2);
         }
         if(param1)
         {
            removeSocketEvent(SocketManager.instance);
            addSocketEvent(SocketDataProxyManager.instance.model);
            SocketDataProxyManager.instance.model.addEventListener("READ_SOCKET_DATA_OVEW",__readOverHandler);
            SocketDataProxyManager.instance.readSocketDataByType("VEHICLE");
         }
         else
         {
            addSocketEvent(SocketManager.instance);
            removeSocketEvent(SocketDataProxyManager.instance.model);
         }
         addEvent();
      }
      
      private function __readOverHandler(param1:SocketDataProxyEventEvent) : void
      {
         if(param1.sceneType != "VEHICLE")
         {
            return;
         }
         addSocketEvent(SocketManager.instance);
         removeSocketEvent(SocketDataProxyManager.instance.model);
         SocketDataProxyManager.instance.model.removeEventListener("READ_SOCKET_DATA_OVEW",__readOverHandler);
      }
      
      private function addSocketEvent(param1:EventDispatcher) : void
      {
         param1.addEventListener("SLGSocketEvent" + 4517,__initPlayerListHandler);
         param1.addEventListener("SLGSocketEvent" + 4513,__playerJoinHandler);
         param1.addEventListener("SLGSocketEvent" + 4523,__playerExitHandler);
         param1.addEventListener("SLGSocketEvent" + 4519,__playerMoveHandler);
         param1.addEventListener("SLGSocketEvent" + 4522,__playerBuffHandler);
         param1.addEventListener("SLGSocketEvent" + 4521,__playerSkillHandler);
         param1.addEventListener("SLGSocketEvent" + 4520,__playerAttackHandler);
         param1.addEventListener("SLGSocketEvent" + 4474,__nodeListHandler);
         param1.addEventListener("SLGSocketEvent" + 4518,__campaignInfoHandler);
         param1.addEventListener("SLGSocketEvent" + 125,__createVehicleHandler);
         param1.addEventListener("SLGSocketEvent" + 4514,__campaignEndHandler);
         param1.addEventListener("SLGSocketEvent" + 4524,__bossAttackNoticeHandler);
      }
      
      private function removeSocketEvent(param1:EventDispatcher) : void
      {
         param1.removeEventListener("SLGSocketEvent" + 4517,__initPlayerListHandler);
         param1.removeEventListener("SLGSocketEvent" + 4513,__playerJoinHandler);
         param1.removeEventListener("SLGSocketEvent" + 4523,__playerExitHandler);
         param1.removeEventListener("SLGSocketEvent" + 4519,__playerMoveHandler);
         param1.removeEventListener("SLGSocketEvent" + 4522,__playerBuffHandler);
         param1.removeEventListener("SLGSocketEvent" + 4521,__playerSkillHandler);
         param1.removeEventListener("SLGSocketEvent" + 4520,__playerAttackHandler);
         param1.removeEventListener("SLGSocketEvent" + 4474,__nodeListHandler);
         param1.removeEventListener("SLGSocketEvent" + 4518,__campaignInfoHandler);
         param1.removeEventListener("SLGSocketEvent" + 125,__createVehicleHandler);
         param1.removeEventListener("SLGSocketEvent" + 4514,__campaignEndHandler);
         param1.removeEventListener("SLGSocketEvent" + 4524,__bossAttackNoticeHandler);
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("UPDATE_CHAT_VIEW",__playerChatHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("UPDATE_CHAT_VIEW",__playerChatHandler);
      }
      
      private function __createVehicleHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         createMapModel(_loc2_);
      }
      
      private function __initPlayerListHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PlayerVehicleInfo = null;
         var _loc3_:VehicleNode = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerVehicleListMsg = new PlayerVehicleListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as PlayerVehicleListMsg;
         for each(var _loc5_:PlayerVehicleMsg in _loc2_.vehicles)
         {
            if(!_loc5_.hasPlayerId)
            {
               _loc3_ = _model.getBoss();
               if(_loc3_)
               {
                  _loc3_.hp = _loc5_.hp;
                  _loc3_.commit();
               }
            }
            else
            {
               _loc4_ = _model.getPlayerInfo(_loc5_.playerId);
               if(!_loc4_)
               {
                  _loc4_ = new PlayerVehicleInfo();
                  _loc4_.playerId = _loc5_.playerId;
               }
               if(_loc5_.hasTemplateId)
               {
                  _loc4_.templateId = _loc5_.templateId;
               }
               if(_loc5_.hasTeam)
               {
                  _loc4_.team = _loc5_.team;
               }
               if(_loc5_.hasGrade)
               {
                  _loc4_.grade = _loc5_.grade;
               }
               if(_loc5_.hasTransGrade)
               {
                  _loc4_.vocationGrades = _loc5_.transGrade;
               }
               if(_loc5_.hasChangeBranch)
               {
                  _loc4_.vocationIndex = _loc5_.changeBranch;
               }
               if(_loc5_.hasHead)
               {
                  _loc4_.headId = _loc5_.head;
               }
               if(_loc5_.hasHp)
               {
                  _loc4_.hp = _loc5_.hp;
               }
               if(_loc5_.hasId)
               {
                  _loc4_.id = _loc5_.id;
               }
               if(_loc5_.hasName)
               {
                  _loc4_.name = _loc5_.name;
               }
               if(_loc5_.hasConsortia)
               {
                  _loc4_.consortiaName = _loc5_.consortia;
               }
               if(_loc5_.buffState)
               {
                  _loc4_.bufferIds = _loc5_.buffState.concat();
               }
               if(_loc5_.hasX)
               {
                  _loc4_.x = _loc5_.x;
               }
               if(_loc5_.hasY)
               {
                  _loc4_.y = _loc5_.y;
               }
               if(_loc5_.hasAppellId)
               {
                  _loc4_.appellId = _loc5_.appellId;
               }
               if(_loc5_.hasVip)
               {
                  _loc4_.isVip = _loc5_.vip != 0;
               }
               if(_loc5_.hasVipType)
               {
                  _loc4_.vipType = _loc5_.vipType;
               }
               if(_loc5_.hasRebornTime)
               {
                  _loc4_.rebornTime = _loc5_.rebornTime;
               }
               _loc4_.commit();
               _model.addPlayer(_loc4_);
            }
         }
         _model.syncPlayerInfo();
      }
      
      private function __playerJoinHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PlayerVehicleInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerVehicleListMsg = new PlayerVehicleListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PlayerVehicleListMsg;
         for each(var _loc4_:PlayerVehicleMsg in _loc2_.vehicles)
         {
            if(_loc4_.hasPlayerId)
            {
               _loc3_ = _model.getPlayerInfo(_loc4_.playerId);
               if(!_loc3_)
               {
                  _loc3_ = new PlayerVehicleInfo();
                  _loc3_.playerId = _loc4_.playerId;
               }
               if(_loc4_.hasTeam)
               {
                  _loc3_.team = _loc4_.team;
               }
               if(_loc4_.hasGrade)
               {
                  _loc3_.grade = _loc4_.grade;
               }
               if(_loc4_.hasHead)
               {
                  _loc3_.headId = _loc4_.head;
               }
               if(_loc4_.hasHp)
               {
                  _loc3_.hp = _loc4_.hp;
               }
               if(_loc4_.hasId)
               {
                  _loc3_.id = _loc4_.id;
               }
               if(_loc4_.hasName)
               {
                  _loc3_.name = _loc4_.name;
               }
               if(_loc4_.hasConsortia)
               {
                  _loc3_.consortiaName = _loc4_.consortia;
               }
               if(_loc4_.buffState)
               {
                  _loc3_.bufferIds = _loc4_.buffState.concat();
               }
               if(_loc4_.hasTemplateId)
               {
                  _loc3_.templateId = _loc4_.templateId;
               }
               if(_loc4_.hasX)
               {
                  _loc3_.x = _loc4_.x;
               }
               if(_loc4_.hasY)
               {
                  _loc3_.y = _loc4_.y;
               }
               if(_loc4_.hasAppellId)
               {
                  _loc3_.appellId = _loc4_.appellId;
               }
               if(_loc4_.hasVip)
               {
                  _loc3_.isVip = _loc4_.vip != 0;
               }
               if(_loc4_.hasVipType)
               {
                  _loc3_.vipType = _loc4_.vipType;
               }
               if(_loc4_.hasRebornTime)
               {
                  _loc3_.rebornTime = _loc4_.rebornTime;
               }
               _loc3_.commit();
               _model.addPlayer(_loc3_);
            }
         }
         _model.syncPlayerInfo();
      }
      
      private function __playerExitHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:VehicleExitMsg = new VehicleExitMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as VehicleExitMsg;
         if(playerInfo.userId == _loc2_.playerId)
         {
            _model.exit = true;
            SwitchPageHelp.returnToSpace();
         }
         else
         {
            _model.removePlayer(_loc2_.playerId);
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __playerMoveHandler(param1:SLGSocketEvent) : void
      {
         if(!_model)
         {
            return;
         }
         if(_model.exit)
         {
            return;
         }
         var _loc2_:PackageIn = param1.data as PackageIn;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,"VEHICLE",__playerMoveImp);
      }
      
      private function __playerMoveImp(param1:PackageIn) : void
      {
         var _loc9_:int = 0;
         if(SceneManager.instance.currentType != "VEHICLE")
         {
            return;
         }
         var _loc2_:VehicleMoveMsg = new VehicleMoveMsg();
         _loc2_ = param1.readBody(_loc2_) as VehicleMoveMsg;
         if(!_model)
         {
            return;
         }
         if(_model.exit)
         {
            return;
         }
         var _loc6_:PlayerVehicleInfo = _model.getPlayerInfo(_loc2_.playerId);
         if(!_loc6_)
         {
            return;
         }
         if(_loc6_ == _model.selfVehicleInfo)
         {
            return;
         }
         if(!_loc6_.logicView)
         {
            _loc6_.x = _loc2_.path[0].x * 20;
            _loc6_.y = _loc2_.path[0].y * 20;
            return;
         }
         var _loc4_:Point = new Point(_loc2_.path[0].x,_loc2_.path[0].y);
         var _loc5_:Point = _loc6_.logicView.getTilePoint();
         var _loc3_:int = Point.distance(_loc4_,_loc5_);
         var _loc8_:Array = AIManager.instance.find(_loc5_,_loc4_);
         var _loc7_:Array = [];
         _loc9_ = 0;
         while(_loc9_ < _loc2_.path.length)
         {
            _loc7_.push(new Point(int(_loc2_.path[_loc9_].x),int(_loc2_.path[_loc9_].y)));
            _loc9_++;
         }
         if(_loc8_)
         {
            _loc8_.shift();
            _loc7_.shift();
            _loc7_ = _loc8_.concat(_loc7_);
         }
         (_loc6_.logicView as TankAvatarView).path = _loc7_;
      }
      
      private function __playerBuffHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:VehicleBufferDamageInfo = null;
         var _loc2_:* = null;
         var _loc7_:PlayerVehicleInfo = null;
         var _loc3_:VehicleNode = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc4_:VehicleBuffListMsg = new VehicleBuffListMsg();
         _loc4_ = _loc5_.readBody(_loc4_) as VehicleBuffListMsg;
         for each(_loc2_ in _loc4_.playerBuffStates)
         {
            _loc7_ = _model.getPlayerInfo(_loc2_.playerId);
            if(_loc7_)
            {
               _loc6_ = new VehicleBufferDamageInfo();
               _loc6_.id = _loc2_.id;
               _loc6_.buffId = _loc2_.buffId;
               _loc6_.defanceId = _loc2_.playerId;
               _loc6_.damage = _loc2_.effectValue;
               _loc6_.state = _loc2_.state;
               _loc7_.addBuffDamage(_loc6_);
               log({},"playerId:" + _loc2_.playerId + ", " + _loc2_.buffId + ", " + _loc2_.effectValue + ", " + _loc2_.state + ", " + getTimer());
            }
         }
         for each(_loc2_ in _loc4_.npcBuffStates)
         {
            _loc3_ = _model.getNodeByNodeId(_loc2_.playerId);
            if(_loc3_)
            {
               _loc6_ = new VehicleBufferDamageInfo();
               _loc6_.id = _loc2_.id;
               _loc6_.buffId = _loc2_.buffId;
               _loc6_.defanceId = _loc2_.playerId;
               _loc6_.damage = _loc2_.effectValue;
               _loc6_.state = _loc2_.state;
               _loc3_.addBuffDamage(_loc6_);
               log({},"npc:" + _loc2_.playerId + ", " + _loc2_.buffId + ", " + _loc2_.effectValue + ", " + _loc2_.state + ", " + getTimer());
            }
         }
      }
      
      private function __playerSkillHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:VehicleSkillListMsg = new VehicleSkillListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as VehicleSkillListMsg;
         var _loc4_:PlayerVehicleInfo = _model.selfVehicleInfo;
         if(_loc4_)
         {
            _model.skillBag.updateSkill(_loc2_.skillId,_loc2_.state,_loc2_.curSum);
         }
      }
      
      private function __playerAttackHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:HurtDataMsg = null;
         var _loc6_:HurtData = null;
         var _loc10_:HurtData = null;
         var _loc4_:PlayerVehicleInfo = null;
         var _loc11_:PlayerVehicleInfo = null;
         var _loc3_:VehicleNode = null;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:VehicleAttackRspMsg = new VehicleAttackRspMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as VehicleAttackRspMsg;
         if(!_loc2_.hasSkillId)
         {
            _loc7_ = _loc2_.playerHurtDataList[0];
            if(!_loc7_)
            {
               return;
            }
            _loc10_ = new HurtData();
            _loc10_.shootId = _loc2_.attackerId;
            _loc10_.effectType = 0;
            _loc10_.effectId = _loc7_.affecteId;
            _loc10_.effectValue = _loc7_.value;
            _loc4_ = _model.getPlayerInfo(_loc10_.effectId);
            if(_loc4_)
            {
               _loc4_.beAtk(_loc10_);
            }
            return;
         }
         var _loc8_:UseSkillInfo = new UseSkillInfo();
         _loc8_.casterId = _loc2_.attackerId;
         _loc8_.skillId = _loc2_.skillId;
         _loc8_.effectX = _loc2_.effectX * 20;
         _loc8_.effectY = _loc2_.effectY * 20;
         var _loc5_:int = 1;
         if(_loc2_.attackTyep == 1)
         {
            _loc5_ = 0;
         }
         for each(_loc7_ in _loc2_.npcHurtDataList)
         {
            _loc6_ = new HurtData(_loc2_.skillId);
            _loc6_.shootId = _loc2_.attackerId;
            _loc6_.effectType = 0;
            _loc6_.effectId = _loc7_.affecteId;
            _loc6_.effectValue = _loc7_.value;
            _loc6_.attackType = _loc5_;
            _loc8_.npcHurt.push(_loc6_);
         }
         for each(_loc7_ in _loc2_.playerHurtDataList)
         {
            _loc6_ = new HurtData(_loc2_.skillId);
            _loc6_.shootId = _loc2_.attackerId;
            _loc6_.effectType = 0;
            _loc6_.effectId = _loc7_.affecteId;
            _loc6_.effectValue = _loc7_.value;
            _loc6_.attackType = _loc5_;
            _loc8_.playerHurt.push(_loc6_);
         }
         if(_loc2_.attackTyep == 1)
         {
            _loc11_ = _model.getPlayerInfo(_loc8_.casterId);
            if(_loc11_)
            {
               _loc11_.shoot(_loc8_);
            }
            else
            {
               NotificationManager.instance.dispatchEvent(new VehicleEvent("play_skill",_loc8_));
            }
         }
         else
         {
            _loc3_ = _model.getNodeByNodeId(_loc8_.casterId);
            if(_loc3_)
            {
               _loc3_.shoot(_loc8_);
            }
            else
            {
               NotificationManager.instance.dispatchEvent(new VehicleEvent("play_skill",_loc8_));
            }
         }
      }
      
      private function __nodeListHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:VehicleNpcNodeListMsg = new VehicleNpcNodeListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as VehicleNpcNodeListMsg;
         for each(var _loc3_:VehicleNpcNodeMsg in _loc2_.vehicleNpcNode)
         {
            model.addNode(readNodeInfo(_loc3_));
         }
         _loc2_ = null;
         _loc4_ = null;
      }
      
      private function readNodeInfo(param1:VehicleNpcNodeMsg) : VehicleNode
      {
         var _loc2_:VehicleNode = _model.getNodeByNodeId(param1.nodeId);
         if(!_loc2_)
         {
            _loc2_ = new VehicleNode();
         }
         if(param1.hasNodeId)
         {
            _loc2_.nodeId = param1.nodeId;
         }
         if(param1.hasType)
         {
            _loc2_.type = param1.type;
         }
         if(param1.hasCurX)
         {
            _loc2_.posX = param1.curX;
         }
         if(param1.hasCurY)
         {
            _loc2_.posY = param1.curY;
         }
         if(param1.hasState)
         {
            _loc2_.state = param1.state;
         }
         if(param1.hasHp)
         {
            _loc2_.hp = param1.hp;
         }
         if(param1.hasName)
         {
            _loc2_.name = param1.name;
         }
         if(param1.hasSonType)
         {
            _loc2_.sonType = param1.sonType;
         }
         if(param1.hasHeroTempId)
         {
            _loc2_.heroTempId = param1.heroTempId;
         }
         if(param1.hasResource)
         {
            _loc2_.resource = param1.resource;
         }
         if(param1.hasNameColor)
         {
            _loc2_.nameColor = param1.nameColor;
         }
         if(param1.hasRestX)
         {
            _loc2_.resetPosX = param1.restX;
         }
         if(param1.hasRestY)
         {
            _loc2_.resetPosY = param1.restY;
         }
         _loc2_.commit();
         if(param1.hasType && _loc2_.type == 0)
         {
            model.bossRefreshed = true;
         }
         return _loc2_;
      }
      
      private function __campaignInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PlayerVehicleInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:VehicleCampaignDetailMsg = new VehicleCampaignDetailMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as VehicleCampaignDetailMsg;
         if(_loc2_.hasRedTeamScroe)
         {
            _model.redScore = _loc2_.redTeamScroe;
         }
         if(_loc2_.hasBlueTeamScroe)
         {
            _model.blueScore = _loc2_.blueTeamScroe;
         }
         if(_loc2_.hasMyScroe)
         {
            _model.myScore = _loc2_.myScroe;
         }
         if(_loc2_.hasRemainsTiem)
         {
            _model.remainsTime = _loc2_.remainsTiem;
         }
         for each(var _loc3_:VehicleScroeListMsg in _loc2_.scroeList)
         {
            _loc5_ = _model.getPlayerInfo(_loc3_.playerId);
            if(_loc5_)
            {
               _loc5_.score = _loc3_.playerScroe;
            }
         }
         _model.syncScore();
         _model.startCountTime();
      }
      
      private function __campaignEndHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:PlayerVehicleInfo = null;
         removeSocketEvent(SocketManager.instance);
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:VehicleCampaignDetailMsg = new VehicleCampaignDetailMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as VehicleCampaignDetailMsg;
         _model.exit = true;
         var _loc3_:VehicleAccountInfo = new VehicleAccountInfo();
         if(_loc2_.hasRedTeamScroe)
         {
            _model.redScore = _loc2_.redTeamScroe;
         }
         if(_loc2_.hasBlueTeamScroe)
         {
            _model.blueScore = _loc2_.blueTeamScroe;
         }
         if(_loc2_.hasMyScroe)
         {
            _model.myScore = _loc2_.myScroe;
         }
         if(_loc2_.hasRemainsTiem)
         {
            _model.remainsTime = _loc2_.remainsTiem;
         }
         for each(var _loc5_:VehicleScroeListMsg in _loc2_.scroeList)
         {
            _loc7_ = _model.getPlayerInfo(_loc5_.playerId);
            if(_loc7_)
            {
               _loc7_.score = _loc5_.playerScroe;
               if(_loc7_ == _model.selfVehicleInfo)
               {
                  _loc3_.reward1 = _model.reward1 = _loc5_.awardSum;
                  _loc3_.reward2 = _model.rewardExp = _loc5_.playerExp;
                  _loc3_.reward3 = _model.reward2 = _loc5_.ladderSum;
               }
            }
         }
         if(_model.selfVehicleInfo.team == _loc2_.winner || _loc2_.winner == 3)
         {
            _model.isWin = true;
         }
         else
         {
            _model.isWin = false;
         }
         _loc3_.isWin = _model.isWin;
         _loc3_.myTeamId = _model.selfVehicleInfo.team;
         _loc3_.playerList = [];
         for each(_loc7_ in _model.playerList)
         {
            _loc3_.playerList.push(_loc7_);
         }
         var _loc4_:AccountAction = new AccountAction(_loc3_);
      }
      
      private function __bossAttackNoticeHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:VehicleAttackRspMsg = new VehicleAttackRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as VehicleAttackRspMsg;
         var _loc3_:Point = new Point(_loc2_.effectX,_loc2_.effectY);
         _loc3_.x *= 20;
         _loc3_.y *= 20;
         _model.bossAttackNotice(_loc3_);
      }
      
      private function __playerChatHandler(param1:NotificationEvent) : void
      {
         if(SceneManager.instance.currentType != "VEHICLE")
         {
            return;
         }
         var _loc3_:ChatData = param1.data as ChatData;
         if(!model || !_loc3_)
         {
            return;
         }
         if(_loc3_.channel != 6 && _loc3_.channel != 8)
         {
            return;
         }
         var _loc2_:PlayerVehicleInfo = model.getPlayerInfo(_loc3_.uid);
         if(_loc2_)
         {
            _loc2_.chatData = _loc3_;
         }
      }
      
      private function createMapModel(param1:PackageIn) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:RoomCreatedMsg = new RoomCreatedMsg();
         _loc2_ = param1.readBody(_loc2_) as RoomCreatedMsg;
         _model = new VehicleModel(3001);
         _model.createType = _loc2_.createdType;
         _loc2_ = null;
         param1 = null;
         VGlobal.model = _model;
      }
      
      public function get model() : VehicleModel
      {
         return _model;
      }
      
      public function dispose() : void
      {
         if(!_isUse)
         {
            return;
         }
         _isUse = false;
         removeSocketEvent(SocketDataProxyManager.instance);
         removeSocketEvent(SocketManager.instance);
         removeEvent();
         _instance = null;
         controller = null;
         _model = null;
         RoomManager.instance.dispose();
      }
   }
}

