package map.campaign.helper.hero
{
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.MarketModel;
   import map.campaign.data.StallInfo;
   import map.campaign.view.physics.CampaignArmyView;
   import map.internals.constant.PosType;
   import map.internals.data.CampaignNode;
   import map.internals.utils.AStarPathFinder;
   import map.internals.utils.PointDirectionHelper;
   import map.internals.utils.PointUtils;
   import mvc.module.armyII.BaseArmy;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   import yzhkof.debug.log;
   
   public class CampaignArmyViewHelper
   {
      
      private static var _preTime:int;
      
      private static var timeId:int = 0;
      
      public function CampaignArmyViewHelper()
      {
         super();
      }
      
      public static function selfArmyEvent(param1:int, param2:BaseArmyAiInfo, param3:Object, param4:Point, param5:Boolean = false, param6:int = 0) : Boolean
      {
         return launchFight(param2,param3,param4,param6);
      }
      
      public static function selfArmyToEnd(param1:BaseArmyAiInfo, param2:Object) : Boolean
      {
         var _loc6_:CampaignArmy = null;
         var _loc5_:CampaignArmyView = null;
         var _loc7_:StallInfo = null;
         var _loc8_:Number = NaN;
         if(WorldBossHelper.checkMarket(mapModel.mapId))
         {
            _loc6_ = PlayerManager.instance.currentPlayerModel.selectTarget as CampaignArmy;
            _loc5_ = param2 as CampaignArmyView;
            if(_loc6_ && _loc5_ && _loc5_.data)
            {
               _loc7_ = marketModel.stalls[_loc6_.userId] as StallInfo;
               if(_loc7_)
               {
                  _loc8_ = Point.distance(new Point(_loc5_.data.curPosX,_loc5_.data.curPosY),new Point(_loc6_.curPosX,_loc6_.curPosY));
                  if(_loc8_ <= 4)
                  {
                     marketModel.lookStall(_loc7_.userId);
                  }
               }
            }
         }
         var _loc4_:CampaignNode = mapModel.getHandlerNode(param2.x / 20,param2.y / 20);
         if(!_loc4_)
         {
            _loc4_ = goSelectPoint(param2);
         }
         if(!_loc4_)
         {
            return false;
         }
         var _loc3_:Point = getResetPoint(_loc4_,param2,new Point(int(param2.x / 20),int(param2.y / 20)));
         if(_loc4_.info.types == 92)
         {
            _loc4_.info.state = 9;
            _loc4_.commit();
            return true;
         }
         return sendMessage(_loc3_,_loc4_);
      }
      
      private static function launchFight(param1:BaseArmyAiInfo, param2:Object, param3:Point, param4:int = 0) : Boolean
      {
         var _loc6_:CampaignNode = null;
         var _loc5_:Point = null;
         var _loc7_:int = 0;
         if(selfarmy)
         {
            _loc6_ = mapModel.getNotHandlerNodeByXY(param3.x,param3.y);
            if(!_loc6_)
            {
               return false;
            }
            _loc5_ = getResetPoint(_loc6_,param2,param3);
            param1.road = null;
            param2.x = _loc5_.x * 20;
            param2.y = _loc5_.y * 20;
            param1.pathInfo = [];
            _loc7_ = getTimer();
            if(_loc7_ - _preTime < 700)
            {
               return true;
            }
            _preTime = _loc7_;
            return sendMessage(_loc5_,_loc6_);
         }
         return false;
      }
      
      private static function sendMessage(param1:Point, param2:CampaignNode) : Boolean
      {
         var _loc3_:String = null;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("sendCampaignArrive",null));
         log({},"node.info.state:" + param2.info.state);
         if(param2.info.state == 4)
         {
            if(WorldBossHelper.checkConsortiaSecretLand(mapModel.mapId))
            {
               return false;
            }
            if(WorldBossHelper.checkPvp(mapModel.mapId))
            {
               CampaignManager.instance.controller.sendCampaignArrive(selfarmy.id,param2.nodeId);
               return true;
            }
            if(WorldBossHelper.checkDuskArea(mapModel.mapId) || Boolean(WorldBossHelper.checkIceFireTemple(mapModel.mapId)))
            {
               CampaignManager.instance.controller.sendCampaignArrive(selfarmy.id,param2.nodeId);
               return true;
            }
            if(WorldBossHelper.checkInPetBossFloor(mapModel.mapId) && Boolean(FreedomTeamManager.instance.hasTeam))
            {
               CampaignManager.instance.controller.sendCampaignArrive(selfarmy.id,param2.nodeId);
               return true;
            }
            if(WorldBossHelper.checkPetLand(mapModel.mapId))
            {
               _loc3_ = LanguageMgr.GetTranslation("map.outercity.view.mapphysics.MapPhysicsCastle.command05");
               (CampaignManager.instance.controller as CampaignMapController).alertMsg(_loc3_);
               return true;
            }
            if(WorldBossHelper.checkConsortiaEmeDream(mapModel.mapId))
            {
               CampaignManager.instance.controller.sendCampaignArrive(selfarmy.id,param2.nodeId);
               return true;
            }
            if(WorldBossHelper.checkGodsEvening(mapModel.mapId))
            {
               if(param2.param2 == 2)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("godsEvening.campaign.npc.tip1"));
               }
               else
               {
                  CampaignManager.instance.controller.sendCampaignArrive(selfarmy.id,param2.nodeId);
               }
               return true;
            }
            if(CampaignManager.instance.mapModel.campaignTemplate.Capacity <= 1)
            {
               return true;
            }
            CampaignManager.instance.controller.sendReinforce(param2.nodeId);
         }
         else
         {
            if(timeId > 0)
            {
               clearTimeout(timeId);
            }
            timeId = 0;
            timeId = setTimeout(delayCall,50,param2);
         }
         return true;
      }
      
      private static function delayCall(param1:CampaignNode) : void
      {
         var _loc2_:String = null;
         if(timeId > 0)
         {
            clearTimeout(timeId);
         }
         timeId = 0;
         if(!param1)
         {
            return;
         }
         trace("拾取---",param1.info.types,"  name---",param1.info.names,param1.nodeId);
         if(param1.info && param1.info.types == 99999)
         {
            if(CampaignArmyState.checkDied(mapModel.selfMemberData.isDie))
            {
               _loc2_ = LanguageMgr.GetTranslation("vehicle.waitRiver");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(mapModel.selfMemberData)
            {
               mapModel.selfMemberData.pickup(param1);
            }
         }
         else if(param1.info.types == 207)
         {
            FrameControllerManager.instance.airGardenControl.showAirGardenBedSelect(param1);
         }
         else if(CampaignManager.instance.controller != null && selfarmy != null)
         {
            CampaignManager.instance.controller.sendCampaignArrive(selfarmy.id,param1.nodeId);
         }
      }
      
      private static function getResetPoint(param1:CampaignNode, param2:Object, param3:Point) : Point
      {
         var _loc4_:Point = null;
         if(param1.resetPosX > 0 && param1.resetPosY > 0)
         {
            _loc4_ = new Point(param1.resetPosX,param1.resetPosY);
         }
         else if(PosType.checkSendType(param1.info.types))
         {
            _loc4_ = new Point(param3.x,param3.y);
         }
         else
         {
            _loc4_ = new Point(int(param2.x / 20),int(param2.y / 20));
         }
         return _loc4_;
      }
      
      public static function getNodeStationPoint(param1:AIBaseInfo, param2:CampaignNode) : Point
      {
         var _loc3_:int = param1.walkIndex - 3 > 0 ? param1.walkIndex - 3 : 0;
         if(_loc3_ == 0)
         {
            return getNodeStationPointImp(param2);
         }
         return param1.pathInfo[_loc3_] as Point;
      }
      
      public static function getNodeStationPointImp(param1:CampaignNode) : Point
      {
         var _loc4_:* = null;
         var _loc2_:Point = new Point();
         var _loc3_:Array = PointDirectionHelper.getPointBy8Dier();
         _loc3_ = _loc3_.reverse();
         for each(var _loc5_:Point in _loc3_)
         {
            if(CampaignManager.instance.controller.getWalkable(param1.posX + _loc5_.x,param1.posY + _loc5_.y))
            {
               _loc2_.x = param1.posX + _loc5_.x;
               _loc2_.y = param1.posY + _loc5_.y;
               break;
            }
         }
         return _loc2_;
      }
      
      private static function goSelectPoint(param1:Object) : CampaignNode
      {
         var _loc2_:Point = null;
         var _loc4_:Point = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:CampaignNode = CampaignManager.instance.mapModel.selectNode;
         if(_loc5_)
         {
            if(CampaignManager.instance.mapModel.onCollectionId == _loc5_.nodeId)
            {
               return null;
            }
            if(_loc5_.info.state == 1 || _loc5_.info.state == 19 || _loc5_.info.state == 20)
            {
               _loc2_ = new Point(param1.x,param1.y);
               _loc4_ = new Point(_loc5_.x,_loc5_.y);
               if(_loc5_.nodeView)
               {
                  _loc4_.x = _loc5_.nodeView.x;
                  _loc4_.y = _loc5_.nodeView.y;
               }
               _loc6_ = Point.distance(_loc2_,_loc4_);
               _loc3_ = int(_loc5_.handlerRange);
               if(_loc3_ == 0)
               {
                  _loc3_ = 2;
               }
               if(_loc6_ < (_loc3_ + 1) * 20)
               {
                  return _loc5_;
               }
            }
            else if(WorldBossHelper.checkGodsEvening(mapModel.mapId))
            {
               if(_loc5_.info.state == 1 || _loc5_.info.state == 4)
               {
                  _loc2_ = new Point(param1.x,param1.y);
                  _loc4_ = new Point(_loc5_.x,_loc5_.y);
                  if(_loc5_.nodeView)
                  {
                     _loc4_.x = _loc5_.nodeView.x;
                     _loc4_.y = _loc5_.nodeView.y;
                  }
                  _loc6_ = Point.distance(_loc2_,_loc4_);
                  _loc3_ = int(_loc5_.handlerRange);
                  if(_loc3_ == 0)
                  {
                     _loc3_ = 2;
                  }
                  if(_loc6_ < (_loc3_ + 1) * 20)
                  {
                     return _loc5_;
                  }
               }
            }
            else if(_loc5_.info.state == 4)
            {
               if(CampaignManager.instance.mapModel.campaignTemplate.Types == 13)
               {
                  _loc2_ = new Point(param1.x,param1.y);
                  _loc4_ = new Point(_loc5_.x,_loc5_.y);
                  if(_loc5_.nodeView)
                  {
                     _loc4_.x = _loc5_.nodeView.x;
                     _loc4_.y = _loc5_.nodeView.y;
                  }
                  _loc6_ = Point.distance(_loc2_,_loc4_);
                  _loc3_ = int(_loc5_.handlerRange);
                  if(_loc3_ == 0)
                  {
                     _loc3_ = 2;
                  }
                  if(_loc6_ < (_loc3_ + 1) * 20)
                  {
                     return _loc5_;
                  }
               }
            }
            else if(WorldBossHelper.checkSteel(mapModel.mapId))
            {
               if(_loc5_.info.state == 16 || _loc5_.info.state == 17)
               {
                  _loc2_ = new Point(param1.x,param1.y);
                  _loc4_ = new Point(_loc5_.x,_loc5_.y);
                  if(_loc5_.nodeView)
                  {
                     _loc4_.x = _loc5_.nodeView.x;
                     _loc4_.y = _loc5_.nodeView.y;
                  }
                  _loc6_ = Point.distance(_loc2_,_loc4_);
                  _loc3_ = int(_loc5_.handlerRange);
                  if(_loc3_ == 0)
                  {
                     _loc3_ = 2;
                  }
                  if(_loc6_ < (_loc3_ + 1) * 20)
                  {
                     return _loc5_;
                  }
               }
            }
            else if(WorldBossHelper.checkActiveVehicle(mapModel.mapId))
            {
               if(_loc5_.info.state == 16 || _loc5_.info.state == 17)
               {
                  _loc2_ = new Point(param1.x,param1.y);
                  _loc4_ = new Point(_loc5_.x,_loc5_.y);
                  if(_loc5_.nodeView)
                  {
                     _loc4_.x = _loc5_.nodeView.x;
                     _loc4_.y = _loc5_.nodeView.y;
                  }
                  _loc6_ = Point.distance(_loc2_,_loc4_);
                  _loc3_ = int(_loc5_.handlerRange);
                  if(_loc3_ == 0)
                  {
                     _loc3_ = 2;
                  }
                  if(_loc6_ < (_loc3_ + 1) * 20)
                  {
                     return _loc5_;
                  }
               }
            }
            else if(WorldBossHelper.checkUnrealShooting(mapModel.mapId))
            {
               if(_loc5_.info.state == 16 || _loc5_.info.state == 17)
               {
                  _loc2_ = new Point(param1.x,param1.y);
                  _loc4_ = new Point(_loc5_.x,_loc5_.y);
                  if(_loc5_.nodeView)
                  {
                     _loc4_.x = _loc5_.nodeView.x;
                     _loc4_.y = _loc5_.nodeView.y;
                  }
                  _loc6_ = Point.distance(_loc2_,_loc4_);
                  _loc3_ = int(_loc5_.handlerRange);
                  if(_loc3_ == 0)
                  {
                     _loc3_ = 2;
                  }
                  if(_loc6_ < (_loc3_ + 1) * 20)
                  {
                     return _loc5_;
                  }
               }
            }
         }
         return null;
      }
      
      public static function searchPath(param1:Point, param2:Point, param3:int = 20, param4:int = 20) : Array
      {
         var _loc5_:Array = null;
         var _loc9_:Point = PointUtils.scaleTransform(param1,param3,param4);
         var _loc6_:Point = PointUtils.scaleTransform(param2,param3,param4);
         var _loc7_:Object = CampaignManager.instance.mapModel.mapTielsData;
         var _loc8_:AStarPathFinder = new AStarPathFinder(_loc7_);
         if(_loc9_.x < _loc6_.x)
         {
            _loc5_ = _loc8_.find(_loc6_,_loc9_);
            _loc5_ = _loc5_.reverse();
         }
         else
         {
            _loc5_ = _loc8_.find(_loc9_,_loc6_);
         }
         return _loc5_;
      }
      
      public static function checkCollection(param1:CampaignNode) : Boolean
      {
         if(param1)
         {
            if(mapModel.onCollectionId == param1.nodeId)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function checkCollectionNode(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.info)
         {
            return param1.info.types == 91;
         }
         switch(param1.nodeId)
         {
            case 600104:
            case 600105:
            case 600106:
            case 600107:
            case 600108:
            case 600109:
            case 600110:
            case 600111:
            case 600112:
            case 600113:
            case 600114:
            case 600115:
            case 600116:
            case 400105:
            case 400106:
            case 400107:
            case 400108:
            case 400109:
            case 400110:
            case 400205:
            case 400206:
            case 400207:
            case 400208:
            case 400209:
            case 400210:
               break;
            default:
               return false;
         }
         return true;
      }
      
      public static function checkGroupfbAttackNode(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.nodeId == 229102;
      }
      
      public static function checkTreeNode(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.nodeId == 750102;
      }
      
      public static function checkRapidThroughNode(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.sonType == 4801 || param1.sonType == 4802 || param1.sonType == 4803;
      }
      
      public static function checkSteelBirthNode(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.info.types == 40;
      }
      
      public static function checkSteelCityCenter(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.info.types == 194;
      }
      
      public static function checkSteelEnergyCrystal(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.info.types == 195;
      }
      
      public static function checkSteelDoor(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.info.types == 192;
      }
      
      public static function checkSteelTower(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.info.types == 193;
      }
      
      public static function checkSteelVice(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.info.types == 191;
      }
      
      public static function checkSteelMonster(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.info.types == 196;
      }
      
      public static function checkSteelDestnation(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.info.types == 197;
      }
      
      public static function checkSteelProps(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.info.types == 99999;
      }
      
      public static function checkFlameTempleEnergyGapNode(param1:CampaignNode) : Boolean
      {
         return param1.nodeId == 4101009 || param1.nodeId == 4101010 || param1.nodeId == 4101011;
      }
      
      public static function checkNewbieVillageTransNode(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.nodeId == 1000309 || param1.nodeId == 1000310;
      }
      
      public static function groupfbMonsterNode(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.nodeId == 229107 || param1.nodeId == 229108 || param1.nodeId >= 229202 && param1.nodeId <= 229204 || param1.nodeId >= 229302 && param1.nodeId <= 229304 || param1.nodeId >= 229403 && param1.nodeId <= 229420;
      }
      
      public static function groupfbBossNode(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.nodeId == 229107 || param1.nodeId == 229108 || param1.nodeId == 229204 || param1.nodeId == 229304 || param1.nodeId == 229407;
      }
      
      public static function groupfbFirstNode(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.nodeId == 229101 || param1.nodeId == 229201 || param1.nodeId == 229301 || param1.nodeId == 229401 || param1.nodeId == 229402;
      }
      
      private static function get selfarmy() : BaseArmy
      {
         return ArmyManager.instance.army;
      }
      
      private static function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      private static function get mapControler() : CampaignMapController
      {
         return CampaignManager.instance.controller;
      }
      
      public static function checkAttackNode(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.info.types == 141;
      }
      
      public static function checkSnowBallNode(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.info.types == 99998;
      }
      
      public static function checkSnowVehicleTowerNode(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.sonType == 10065;
      }
      
      public static function checkGvgArmy() : void
      {
         var _loc1_:BaseArmy = mapControler.getArmyGvgFight(mapModel.isCross);
         if(_loc1_)
         {
            CampaignManager.instance.controller.gvgPlayerFight(_loc1_.userId,_loc1_.baseHero.serviceName);
         }
      }
      
      public static function checkSvsArmy() : void
      {
         var _loc1_:BaseArmy = mapControler.getArmySvsFight(mapModel.isCross);
         if(_loc1_)
         {
            if(WorldBossHelper.checkSvs(mapModel.mapId))
            {
               if(!CampaignArmyState.checkDied((_loc1_ as CampaignArmy).isDie))
               {
                  CampaignManager.instance.controller.gvgPlayerFight(_loc1_.userId,_loc1_.baseHero.serviceName);
               }
            }
         }
      }
      
      public static function checkBonFire(param1:CampaignNode) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1.info.types == 1001 || param1.info.types == 1002)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      public static function checkUnrealShootingBoss(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.info.types == 202;
      }
      
      public static function checkUnrealShootingBuff(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.info.types == 203;
      }
      
      public static function checkUnrealShootingMonster(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.info.types == 204;
      }
      
      public static function checkUnrealShootingSoldier(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.info.types == 205;
      }
      
      public static function checkUnrealShootingTower(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return param1.info.types == 206;
      }
      
      private static function get marketModel() : MarketModel
      {
         return CampaignManager.instance.marketModel;
      }
      
      public static function calcFrameY(param1:Number) : int
      {
         var _loc2_:int = 1;
         if(param1 >= 270 && param1 < 280)
         {
            _loc2_ = 4;
         }
         else if(param1 >= 260 && param1 < 270)
         {
            _loc2_ = 4;
         }
         else if(param1 >= 280 && param1 < 350)
         {
            _loc2_ = 3;
         }
         else if(param1 >= 350 || param1 < 10)
         {
            _loc2_ = 2;
         }
         else if(param1 >= 10 && param1 < 80)
         {
            _loc2_ = 1;
         }
         else if(param1 >= 80 && param1 <= 90)
         {
            _loc2_ = 0;
         }
         else if(param1 > 90 && param1 < 100)
         {
            _loc2_ = 0;
         }
         else if(param1 < 170 && param1 >= 100)
         {
            _loc2_ = 1;
         }
         else if(param1 < 190 && param1 >= 170)
         {
            _loc2_ = 2;
         }
         else if(param1 < 260 && param1 >= 190)
         {
            _loc2_ = 3;
         }
         return _loc2_;
      }
      
      public static function calcMirror(param1:Number) : int
      {
         var _loc2_:int = 1;
         if(param1 >= 270 && param1 < 280)
         {
            _loc2_ = 1;
         }
         else if(param1 >= 260 && param1 < 270)
         {
            _loc2_ = -1;
         }
         else if(param1 >= 280 && param1 < 350)
         {
            _loc2_ = 1;
         }
         else if(param1 >= 350 || param1 < 10)
         {
            _loc2_ = 1;
         }
         else if(param1 >= 10 && param1 < 80)
         {
            _loc2_ = 1;
         }
         else if(param1 >= 80 && param1 <= 90)
         {
            _loc2_ = 1;
         }
         else if(param1 > 90 && param1 < 100)
         {
            _loc2_ = -1;
         }
         else if(param1 < 170 && param1 >= 100)
         {
            _loc2_ = -1;
         }
         else if(param1 < 190 && param1 >= 170)
         {
            _loc2_ = -1;
         }
         else if(param1 < 260 && param1 >= 190)
         {
            _loc2_ = -1;
         }
         return _loc2_;
      }
   }
}

