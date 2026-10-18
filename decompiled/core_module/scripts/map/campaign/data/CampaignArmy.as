package map.campaign.data
{
   import com.road.yishi.proto.room.SnowVehicleSkillListMsg;
   import events.ArmyEvent;
   import events.RoomEvent;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.skill.MapBuffHurtData;
   import map.campaign.data.skill.MapSkillHurtData;
   import map.campaign.data.skill.MapSkillResultInfo;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.data.CampaignNode;
   import map.internals.data.PhysicsEvent;
   import map.internals.data.template.MapTemplate;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.armyII.SystemArmy;
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.datas.templates.VehicleSkillBuffTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class CampaignArmy extends SystemArmy
   {
      
      private var _online:Boolean = true;
      
      public var level:int;
      
      public var roomId:int;
      
      private var _combatPower:int;
      
      private var _pos:int;
      
      private var _isDie:int;
      
      private var _curHp:int;
      
      public var totalHp:int;
      
      public var riverStartTime:int;
      
      public var riverTime:int;
      
      private var _hangupState:int;
      
      private var _transeferWaitState:Boolean;
      
      private var _teamId:int;
      
      private var _bufferTempId:int;
      
      public var preParent:Sprite;
      
      public var angle:Number = -1;
      
      private var _score:int;
      
      private var _geste:int;
      
      private var _sellState:int;
      
      private var _stallName:String;
      
      public var needInit:Boolean;
      
      public var isNoGet:Boolean;
      
      public var isSitDown:Boolean = false;
      
      public var buffList:Vector.<MapBuffHurtData> = new Vector.<MapBuffHurtData>();
      
      public var isStun:Boolean;
      
      public var isCasting:Boolean;
      
      public var isJumping:Boolean;
      
      private var _oreNum:int;
      
      public var vehicleTempId:int;
      
      public var vehicleTempInfo:VehicleObjectTempInfo;
      
      public var mountNodeId:int = 0;
      
      public var nodeHp:int = 0;
      
      public var nodeTotalHp:int = 0;
      
      public var steelBuffList:Vector.<MapBuffHurtData> = new Vector.<MapBuffHurtData>();
      
      public var steelVehicleTempId:int;
      
      public var steelVehicleTempInfo:VehicleObjectTempInfo;
      
      public var steelVehicleSkillId:int;
      
      public var steelVehicleBossSkillId:int;
      
      public var steelVehicleBossSkillCount:int;
      
      public var isPickup:Boolean;
      
      public var activeBuffList:Vector.<MapBuffHurtData> = new Vector.<MapBuffHurtData>();
      
      public var activeVehicleTempId:int;
      
      public var activeVehicleTempInfo:VehicleObjectTempInfo;
      
      public var activeLastTempId:int;
      
      public var activeVehicleSkillId:int;
      
      public var activeVehicleSkillIdQ:int;
      
      public var activeVehicleSkillIdW:int;
      
      public var activeVehicleSkillIdWCount:int;
      
      public var activeVehicleSkillIdE:int;
      
      public var activeVehicleSkillIdECount:int;
      
      public var activeVehicleSkillIdSpace:int;
      
      public var acctiveVehicleIsHoldKey:Boolean;
      
      public var activeTeamId:int;
      
      public var activeScore:int;
      
      public var rebornTime:int = 0;
      
      public var activeGrade:int = 1;
      
      public var activeTotalHp:int;
      
      private var _activeCurHp:int;
      
      public var unrealShootingBuffList:Vector.<MapBuffHurtData> = new Vector.<MapBuffHurtData>();
      
      public var unrealShootingBuffIdDic:Dictionary = new Dictionary(true);
      
      public var unrealShootingVehicleTempId:int;
      
      public var unrealShootingVehicleTempInfo:VehicleObjectTempInfo;
      
      public var unrealShootingVehicleSkillIdQ:int;
      
      public var unrealShootingVehicleSkillIdW:int;
      
      public var unrealShootingVehicleSkillIdE:int;
      
      public var unrealShootingVehicleSkillIdSpace:int;
      
      public var unrealShootingVehicleDefaultSkills:Array;
      
      public var unrealShootingVehicleBossSkillId:int;
      
      public var unrealShootingVehicleBossSkillCount:int;
      
      public var unrealShootingIsHoldKey:Boolean;
      
      public var unrealShootingEnergy:int;
      
      public var emeDreamBuffList:Vector.<MapBuffHurtData> = new Vector.<MapBuffHurtData>();
      
      private var _goddessTeamId:int;
      
      private var _goddessId:int;
      
      public function CampaignArmy()
      {
         super();
      }
      
      public function update() : void
      {
      }
      
      public function get teamId() : int
      {
         return _teamId;
      }
      
      public function set teamId(param1:int) : void
      {
         if(param1 != _teamId)
         {
            _teamId = param1;
            this.dispatchEvent(new CampaignMapEvent("UPDATE_TEAM_ID",this));
         }
      }
      
      public function get geste() : int
      {
         return _geste;
      }
      
      public function set geste(param1:int) : void
      {
         _geste = param1;
         this.dispatchEvent(new CampaignMapEvent("UPDATE_PVP_GESTE",param1));
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function set score(param1:int) : void
      {
         _score = param1;
         this.dispatchEvent(new CampaignMapEvent("UPDATE_PVP_SCORE",param1));
      }
      
      public function get bufferTempId() : int
      {
         return _bufferTempId;
      }
      
      public function set bufferTempId(param1:int) : void
      {
         _bufferTempId = param1;
         this.dispatchEvent(new CampaignMapEvent("BUFFER_TEMP_ID",param1));
      }
      
      public function get transeferWaitState() : Boolean
      {
         return _transeferWaitState;
      }
      
      public function setTranseferWait(param1:Boolean, param2:int, param3:int) : void
      {
         _transeferWaitState = param1;
         if(param2 != 0)
         {
            this.dispatchEvent(new CampaignMapEvent("transeferWaitState",{
               "state":param1,
               "nodeId":param2,
               "mapId":param3
            }));
         }
      }
      
      public function get hangupState() : int
      {
         return _hangupState;
      }
      
      public function set hangupState(param1:int) : void
      {
         if(param1 != _hangupState)
         {
            _hangupState = param1;
            this.dispatchEvent(new CampaignMapEvent("hangupState",param1));
         }
      }
      
      public function checkSnowBallArmyPos() : void
      {
         this.dispatchEvent(new ArmyEvent("CHECK_SNOW_BALL_POS",null));
      }
      
      public function set huangupAdd(param1:int) : void
      {
         if(param1 > 0)
         {
            this.dispatchEvent(new CampaignMapEvent("hangupadd",param1));
         }
      }
      
      public function get curHp() : int
      {
         return _curHp;
      }
      
      public function set curHp(param1:int) : void
      {
         _curHp = param1;
         this.dispatchEvent(new PhysicsEvent("UPDATE_CUR_HP",param1));
      }
      
      public function get isDie() : int
      {
         return _isDie;
      }
      
      public function set isDie(param1:int) : void
      {
         _isDie = param1;
         if(CampaignArmyState.checkDied(param1))
         {
            cleanBuff();
            cleanBuffSteel();
            cleanBuffUnrealShooting();
            cleanBuffEmeDream();
         }
         CampaignManager.instance.pvpWarFightModel.isFlag = CampaignArmyState.checkisFlag(param1);
         this.dispatchEvent(new CampaignMapEvent("IS_DIE",param1));
      }
      
      public function get sellState() : int
      {
         return _sellState;
      }
      
      public function set sellState(param1:int) : void
      {
         if(_sellState == param1)
         {
            return;
         }
         _sellState = param1;
      }
      
      public function get stallName() : String
      {
         if(!_stallName)
         {
            _stallName = LanguageMgr.GetTranslation("CampaignArmy.stallName",nickName);
         }
         return _stallName;
      }
      
      public function set stallName(param1:String) : void
      {
         _stallName = param1;
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      public function set pos(param1:int) : void
      {
         _pos = param1;
      }
      
      public function get online() : Boolean
      {
         return _online;
      }
      
      public function get mapTempInfo() : MapTemplate
      {
         return TempleteManager.instance.mapTemplateCate.getTemplateByID(mapId);
      }
      
      public function set online(param1:Boolean) : void
      {
         if(_online == param1)
         {
            return;
         }
         _online = param1;
         this.dispatchEvent(new CampaignMapEvent("ONLINE_STATE",this));
      }
      
      override public function get combatPower() : int
      {
         return _combatPower;
      }
      
      public function set combatPower(param1:int) : void
      {
         _combatPower = param1;
      }
      
      public function syncArmyInfo() : void
      {
         var _loc1_:BaseArmy = null;
         var _loc2_:int = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         if(_loc2_ == userId)
         {
            _loc1_ = ArmyManager.instance.army;
            if(baseHero)
            {
               if(StringHelper.isNullOrEmpty(baseHero.serviceName))
               {
                  if(_loc1_)
                  {
                     _loc1_.state = state;
                  }
               }
               else if(baseHero.serviceName == PlayerManager.instance.currentPlayerModel.playerInfo.serviceName)
               {
                  if(_loc1_)
                  {
                     _loc1_.state = state;
                  }
               }
            }
            else if(_loc1_)
            {
               _loc1_.state = state;
            }
         }
         this.dispatchEvent(new CampaignMapEvent("UPDATE_CAMPAIGN_ARMY",this));
      }
      
      override public function commit() : void
      {
         this.dispatchEvent(new RoomEvent("UPDATE_ROOM_PLAYER_DATA",this));
      }
      
      public function beHurt(param1:MapSkillHurtData) : void
      {
         if(param1.effectType == 0 && param1.effectValue > 0)
         {
            breakup();
         }
         dispatchEvent(new ArmyEvent("DANNAY",param1));
      }
      
      public function removeBuff(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < buffList.length)
         {
            if(buffList[_loc2_].id == param1)
            {
               buffList[_loc2_].state = 1;
               break;
            }
            _loc2_++;
         }
         buffList.splice(_loc2_,1);
      }
      
      public function addBuff(param1:MapBuffHurtData) : void
      {
         buffList.push(param1);
         this.dispatchEvent(new ArmyEvent("ADD_BUFF",param1));
      }
      
      public function updateBuff(param1:MapBuffHurtData) : void
      {
         var _loc2_:MapBuffHurtData = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < buffList.length)
         {
            if(buffList[_loc3_].id == param1.id)
            {
               _loc2_ = buffList[_loc3_];
               break;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            _loc2_.updateWith(param1);
         }
         if(param1.state == 1)
         {
            removeBuff(param1.id);
         }
         else if(param1.state == 0)
         {
            addBuff(param1);
         }
      }
      
      public function cleanBuff() : void
      {
         var _loc1_:MapBuffHurtData = null;
         while(buffList.length != 0)
         {
            _loc1_ = buffList[0];
            removeBuff(_loc1_.id);
         }
         isStun = false;
      }
      
      public function useJumpSkill(param1:MapSkillResultInfo) : void
      {
         dispatchEvent(new ArmyEvent("USE_JUMP_SKILL",param1));
      }
      
      public function useSkill(param1:MapSkillResultInfo) : void
      {
         riverStartTime = 0;
         dispatchEvent(new ArmyEvent("USE_SKILL",param1));
      }
      
      public function breakup() : void
      {
         dispatchEvent(new ArmyEvent("BREAK_ACTION",this));
      }
      
      public function get oreNum() : int
      {
         return _oreNum;
      }
      
      public function set oreNum(param1:int) : void
      {
         if(_oreNum == param1)
         {
            return;
         }
         _oreNum = param1;
         dispatchEvent(new ArmyEvent("ORENUM_CHANGE",param1));
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function enterNode(param1:int, param2:int) : void
      {
         if(mountNodeId == param1 && vehicleTempId == param2)
         {
            return;
         }
         mountNodeId = param1;
         vehicleTempId = param2;
         vehicleTempInfo = TempleteManager.instance.vehicleObjectTempInfoCate.getTemplateByIndex(vehicleTempId);
         dispatchEvent(new ArmyEvent("ENTER_NODE",this));
      }
      
      public function exitNode() : void
      {
         if(mountNodeId == 0 && vehicleTempId == 0)
         {
            return;
         }
         var _loc1_:Object = {
            "mountNodeId":mountNodeId,
            "vehicleTempId":vehicleTempId
         };
         mountNodeId = 0;
         vehicleTempId = 0;
         vehicleTempInfo = null;
         dispatchEvent(new ArmyEvent("EXIT_NODE",_loc1_));
      }
      
      public function get inNode() : Boolean
      {
         return mountNodeId > 0;
      }
      
      public function isTankState() : Boolean
      {
         return vehicleTempId == 3000;
      }
      
      public function isTowerState() : Boolean
      {
         return vehicleTempId == 3001 || vehicleTempId == 3002 || vehicleTempId == 3003 || vehicleTempId == 3004;
      }
      
      public function getTotalHp() : int
      {
         if(inNode)
         {
            return nodeTotalHp;
         }
         return totalHp;
      }
      
      public function getCurrentHp() : int
      {
         if(inNode)
         {
            return nodeHp;
         }
         return curHp;
      }
      
      public function updateNodeHpInfo(param1:int, param2:int) : void
      {
         nodeTotalHp = param2;
         nodeHp = param1;
         this.dispatchEvent(new PhysicsEvent("UPDATE_CUR_HP",nodeHp));
      }
      
      public function updateArmyHpInfo(param1:int, param2:int) : void
      {
         totalHp = param2;
         curHp = param1;
      }
      
      public function inProtectTime(param1:int = 15000) : Boolean
      {
         var _loc2_:int = getTimer();
         return _loc2_ - riverStartTime - riverTime < param1;
      }
      
      public function updateBuffSteel(param1:MapBuffHurtData) : void
      {
         var _loc2_:MapBuffHurtData = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < steelBuffList.length)
         {
            if(steelBuffList[_loc3_].buffId == param1.buffId)
            {
               _loc2_ = steelBuffList[_loc3_];
               break;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            _loc2_.updateWith(param1);
         }
         if(param1.state == 0)
         {
            if(_loc2_)
            {
               this.dispatchEvent(new ArmyEvent("UPDATE_BUFF",param1));
            }
            else
            {
               addBuffSteel(param1);
            }
         }
         else if(param1.state == 1)
         {
            removeBuffSteel(param1.buffId);
            this.dispatchEvent(new ArmyEvent("REMOVE_BUFF",param1));
         }
      }
      
      public function addBuffSteel(param1:MapBuffHurtData) : void
      {
         steelBuffList.push(param1);
         this.dispatchEvent(new ArmyEvent("ADD_BUFF",param1));
      }
      
      public function removeBuffSteel(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < steelBuffList.length)
         {
            if(steelBuffList[_loc2_].buffId == param1)
            {
               steelBuffList[_loc2_].state = 1;
               break;
            }
            _loc2_++;
         }
         steelBuffList.splice(_loc2_,1);
      }
      
      public function cleanBuffSteel() : void
      {
         var _loc1_:MapBuffHurtData = null;
         while(steelBuffList.length != 0)
         {
            _loc1_ = steelBuffList[0];
            removeBuffSteel(_loc1_.buffId);
         }
         isStun = false;
      }
      
      public function updateSteelInfo(param1:int, param2:int) : void
      {
         steelVehicleTempId = param1;
         steelVehicleSkillId = param2;
         steelVehicleTempInfo = TempleteManager.instance.vehicleObjectTempInfoCate.getTemplateByIndex(steelVehicleTempId);
         this.dispatchEvent(new ArmyEvent("STEEL_INFO_CHANGE",this));
      }
      
      public function updateSteelSkillInfo(param1:int, param2:int, param3:int) : void
      {
         if(param2 == 1)
         {
            steelVehicleBossSkillId = 0;
            steelVehicleBossSkillCount = 0;
         }
         else
         {
            steelVehicleBossSkillId = param1;
            steelVehicleBossSkillCount = param3;
         }
         this.dispatchEvent(new ArmyEvent("STEEL_SKILL_CHANGE",this));
      }
      
      public function reduceSkillCount(param1:int) : void
      {
         if(steelVehicleBossSkillId != 0 && steelVehicleBossSkillId == param1 && steelVehicleBossSkillCount > 0)
         {
            steelVehicleBossSkillCount = steelVehicleBossSkillCount - 1;
            this.dispatchEvent(new ArmyEvent("STEEL_SKILL_COUNT_CHANGE",this));
         }
      }
      
      public function pickup(param1:CampaignNode) : void
      {
         if(isCasting)
         {
            return;
         }
         if(isStun)
         {
            return;
         }
         this.dispatchEvent(new ArmyEvent("PICK_UP",param1));
      }
      
      public function updateBuffActive(param1:MapBuffHurtData) : void
      {
         var _loc2_:MapBuffHurtData = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < activeBuffList.length)
         {
            if(activeBuffList[_loc3_].buffId == param1.buffId)
            {
               _loc2_ = activeBuffList[_loc3_];
               break;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            _loc2_.updateWith(param1);
         }
         if(param1.state == 0)
         {
            if(_loc2_)
            {
               this.dispatchEvent(new ArmyEvent("UPDATE_BUFF",param1));
            }
            else
            {
               addBuffActive(param1);
            }
         }
         else if(param1.state == 1)
         {
            removeBuffActive(param1.buffId);
            this.dispatchEvent(new ArmyEvent("REMOVE_BUFF",param1));
            if(param1.buffTemplate && param1.buffTemplate.EffectType == 19)
            {
               updateActiveInfo(activeLastTempId,null);
            }
         }
      }
      
      public function addBuffActive(param1:MapBuffHurtData) : void
      {
         activeBuffList.push(param1);
         this.dispatchEvent(new ArmyEvent("ADD_BUFF",param1));
      }
      
      public function removeBuffActive(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < activeBuffList.length)
         {
            if(activeBuffList[_loc2_].buffId == param1)
            {
               activeBuffList[_loc2_].state = 1;
               break;
            }
            _loc2_++;
         }
         activeBuffList.splice(_loc2_,1);
      }
      
      public function cleanBuffActive() : void
      {
         var _loc1_:MapBuffHurtData = null;
         while(activeBuffList.length != 0)
         {
            _loc1_ = activeBuffList[0];
            removeBuffActive(_loc1_.buffId);
         }
         isStun = false;
      }
      
      public function updateActiveInfo(param1:int, param2:String) : void
      {
         var _loc3_:Array = null;
         if(param2 == null)
         {
            if(activeVehicleTempId == param1)
            {
               return;
            }
            trace("snowball--变身buff生效--",param1);
         }
         activeVehicleTempId = param1;
         if(param2 != null)
         {
            _loc3_ = param2.split(",");
            activeVehicleSkillIdQ = int(_loc3_[0]);
            activeVehicleSkillIdSpace = int(_loc3_[1]);
         }
         activeVehicleTempInfo = TempleteManager.instance.vehicleObjectTempInfoCate.getTemplateByIndex(activeVehicleTempId);
         activeTotalHp = activeVehicleTempInfo.Hp;
         this.dispatchEvent(new ArmyEvent("ACTIVEVEHICLE_INFO_CHANGE",this));
      }
      
      public function get activeCurHp() : int
      {
         return _activeCurHp;
      }
      
      public function set activeCurHp(param1:int) : void
      {
         _activeCurHp = param1;
         this.dispatchEvent(new ArmyEvent("ACTIVEVEHICLE_HP_CHANGE",this));
      }
      
      public function updateActiveSkillInfo(param1:SnowVehicleSkillListMsg) : void
      {
         if(!activeVehicleTempInfo)
         {
            return;
         }
         if(param1.stateW == 1)
         {
            activeVehicleSkillIdW = 0;
            activeVehicleSkillIdWCount = 0;
         }
         else
         {
            activeVehicleSkillIdW = param1.skillIdW;
            activeVehicleSkillIdWCount = param1.curSumW;
         }
         if(param1.stateE == 1)
         {
            activeVehicleSkillIdE = 0;
            activeVehicleSkillIdECount = 0;
         }
         else
         {
            activeVehicleSkillIdE = param1.skillIdE;
            activeVehicleSkillIdECount = param1.curSumE;
         }
         this.dispatchEvent(new ArmyEvent("ACTIVEVEHICLE_SKILL_CHANGE",this));
      }
      
      public function reduceActiveSkillCount(param1:int) : void
      {
         if(activeVehicleSkillIdW != 0 && activeVehicleSkillIdW == param1 && activeVehicleSkillIdWCount > 0)
         {
            activeVehicleSkillIdWCount = activeVehicleSkillIdWCount - 1;
            this.dispatchEvent(new ArmyEvent("ACTIVEVEHICLE_SKILL_COUNT_CHANGE",this));
         }
         else if(activeVehicleSkillIdE != 0 && activeVehicleSkillIdE == param1 && activeVehicleSkillIdECount > 0)
         {
            activeVehicleSkillIdECount = activeVehicleSkillIdECount - 1;
            this.dispatchEvent(new ArmyEvent("ACTIVEVEHICLE_SKILL_COUNT_CHANGE",this));
         }
      }
      
      public function updateBuffUnrealShooting(param1:MapBuffHurtData) : void
      {
         var _loc2_:MapBuffHurtData = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < unrealShootingBuffList.length)
         {
            if(unrealShootingBuffList[_loc3_].buffId == param1.buffId)
            {
               _loc2_ = unrealShootingBuffList[_loc3_];
               break;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            _loc2_.updateWith(param1);
         }
         if(param1.state == 0)
         {
            if(_loc2_)
            {
               this.dispatchEvent(new ArmyEvent("UPDATE_BUFF",param1));
            }
            else
            {
               addBuffUnrealShooting(param1);
            }
         }
         else if(param1.state == 1)
         {
            removeBuffUnrealShooting(param1.buffId);
            this.dispatchEvent(new ArmyEvent("REMOVE_BUFF",param1));
         }
      }
      
      public function addBuffUnrealShooting(param1:MapBuffHurtData) : void
      {
         unrealShootingBuffList.push(param1);
         unrealShootingBuffIdDic[param1.buffId] = true;
         this.dispatchEvent(new ArmyEvent("ADD_BUFF",param1));
      }
      
      public function removeBuffUnrealShooting(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < unrealShootingBuffList.length)
         {
            if(unrealShootingBuffList[_loc2_].buffId == param1)
            {
               unrealShootingBuffList[_loc2_].state = 1;
               break;
            }
            _loc2_++;
         }
         unrealShootingBuffList.splice(_loc2_,1);
         unrealShootingBuffIdDic[param1] = null;
         delete unrealShootingBuffIdDic[param1];
      }
      
      public function cleanBuffUnrealShooting() : void
      {
         var _loc1_:MapBuffHurtData = null;
         var _loc5_:MapBuffHurtData = null;
         var _loc2_:VehicleSkillBuffTemplate = null;
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         while(unrealShootingBuffList.length != 0)
         {
            _loc5_ = unrealShootingBuffList[0];
            _loc2_ = TempleteManager.instance.vehicleSkillBuffTemplateCate.getTemplateByIndex(_loc5_.buffId);
            if(_loc2_ && _loc2_.Duration == -1)
            {
               _loc3_.push(_loc5_);
            }
            removeBuffUnrealShooting(_loc5_.buffId);
         }
         if(_loc3_.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc1_ = _loc3_[_loc4_] as MapBuffHurtData;
               _loc1_.state = 0;
               unrealShootingBuffList.push(_loc1_);
               unrealShootingBuffIdDic[_loc1_.buffId] = true;
               this.dispatchEvent(new ArmyEvent("ADD_BUFF",_loc1_));
               _loc4_++;
            }
         }
         isStun = false;
      }
      
      public function updateUnrealShootingInfo(param1:int, param2:String) : void
      {
         unrealShootingVehicleTempId = param1;
         unrealShootingVehicleDefaultSkills = param2.split(",");
         unrealShootingVehicleSkillIdQ = int(unrealShootingVehicleDefaultSkills[0]);
         unrealShootingVehicleSkillIdW = int(unrealShootingVehicleDefaultSkills[1]);
         unrealShootingVehicleSkillIdE = int(unrealShootingVehicleDefaultSkills[2]);
         unrealShootingVehicleSkillIdSpace = int(unrealShootingVehicleDefaultSkills[3]);
         unrealShootingVehicleTempInfo = TempleteManager.instance.vehicleObjectTempInfoCate.getTemplateByIndex(unrealShootingVehicleTempId);
         this.dispatchEvent(new ArmyEvent("UNREAL_MAZE_INFO_CHANGE",this));
      }
      
      public function updateUnrealShootingSkillInfo(param1:int, param2:int, param3:int) : void
      {
         if(param2 == 1)
         {
            unrealShootingVehicleBossSkillId = 0;
            unrealShootingVehicleBossSkillCount = 0;
         }
         else
         {
            unrealShootingVehicleBossSkillId = param1;
            unrealShootingVehicleBossSkillCount = param3;
         }
         this.dispatchEvent(new ArmyEvent("UNREAL_MAZE_SKILL_CHANGE",this));
      }
      
      public function reduceSkillCountUnrealShooting(param1:int) : void
      {
         if(unrealShootingVehicleBossSkillId != 0 && unrealShootingVehicleBossSkillId == param1 && unrealShootingVehicleBossSkillCount > 0)
         {
            unrealShootingVehicleBossSkillCount = unrealShootingVehicleBossSkillCount - 1;
            this.dispatchEvent(new ArmyEvent("UNREAL_MAZE_SKILL_COUNT_CHANGE",this));
         }
      }
      
      public function pickupUnrealShooting(param1:CampaignNode) : void
      {
         if(isCasting)
         {
            return;
         }
         if(isStun)
         {
            return;
         }
         this.dispatchEvent(new ArmyEvent("PICK_UP",param1));
      }
      
      public function updateUnrealShootingHoldKeyState(param1:Boolean) : void
      {
         unrealShootingIsHoldKey = param1;
         this.dispatchEvent(new ArmyEvent("UNREAL_MAZE_HOLD_KEY_STATE_CHANGE",this));
      }
      
      public function updateActiveVehicleHoldKeyState(param1:Boolean) : void
      {
         acctiveVehicleIsHoldKey = param1;
         this.dispatchEvent(new ArmyEvent("ACTIVEVEHICLE_HOLD_KEY_STATE_CHANGE",this));
      }
      
      public function updateUnrealShootingEnergy(param1:int) : void
      {
         unrealShootingEnergy = param1;
         this.dispatchEvent(new ArmyEvent("UNREAL_MAZE_ENERGY_CHANGE",this));
      }
      
      public function updateBuffEmeDream(param1:MapBuffHurtData) : void
      {
         var _loc2_:MapBuffHurtData = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < emeDreamBuffList.length)
         {
            if(emeDreamBuffList[_loc3_].buffId == param1.buffId)
            {
               _loc2_ = emeDreamBuffList[_loc3_];
               break;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            _loc2_.updateWith(param1);
         }
         if(param1.state == 0)
         {
            if(_loc2_)
            {
               this.dispatchEvent(new ArmyEvent("UPDATE_BUFF",param1));
            }
            else
            {
               addBuffEmeDream(param1);
            }
         }
         else if(param1.state == 1)
         {
            removeBuffEmeDream(param1.buffId);
            this.dispatchEvent(new ArmyEvent("REMOVE_BUFF",param1));
         }
      }
      
      public function addBuffEmeDream(param1:MapBuffHurtData) : void
      {
         emeDreamBuffList.push(param1);
         this.dispatchEvent(new ArmyEvent("ADD_BUFF",param1));
      }
      
      public function removeBuffEmeDream(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < emeDreamBuffList.length)
         {
            if(emeDreamBuffList[_loc2_].buffId == param1)
            {
               emeDreamBuffList[_loc2_].state = 1;
               break;
            }
            _loc2_++;
         }
         emeDreamBuffList.splice(_loc2_,1);
      }
      
      public function cleanBuffEmeDream() : void
      {
         var _loc1_:MapBuffHurtData = null;
         while(steelBuffList.length != 0)
         {
            _loc1_ = steelBuffList[0];
            removeBuffEmeDream(_loc1_.buffId);
         }
         isStun = false;
      }
      
      public function get goddessTeamId() : int
      {
         return _goddessTeamId;
      }
      
      public function set goddessTeamId(param1:int) : void
      {
         _goddessTeamId = param1;
      }
      
      public function get goddessId() : int
      {
         return _goddessId;
      }
      
      public function set goddessId(param1:int) : void
      {
         _goddessId = param1;
      }
   }
}

