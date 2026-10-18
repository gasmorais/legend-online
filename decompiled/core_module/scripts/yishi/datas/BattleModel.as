package yishi.datas
{
   import battle.actions.DieAction;
   import battle.data.SkillData;
   import battle.events.BattleEvent;
   import battle.handler.SkillHandlerII;
   import battle.mode.HurtUpMode;
   import battle.skillsys.helper.BloodHelper;
   import battle.skillsys.skills.BaseSkill;
   import battle.utils.BattleFunctionHelper;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import map.campaign.data.CampaignMapModel;
   import yishi.datas.objects.BattleArmyInfo;
   import yishi.datas.objects.GoddessRoleInfo;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.MonsterRoleInfo;
   import yishi.datas.objects.PawnRoleInfo;
   import yishi.datas.objects.PetRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.datas.objects.SelfChessRoleInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   
   public class BattleModel extends EventDispatcher
   {
      
      public static const AWAKEN_FULL_VALUE:int = 3000;
      
      public static const CHILD_AWAKEN_FULL_VALUE:int = 100;
      
      public static const NORMAL:int = 0;
      
      public static const DEFENSE:int = 1;
      
      public static const ATTACK:int = 2;
      
      public static var battleUILoaded:Boolean;
      
      public static var allowAutoFight:Boolean = true;
      
      public static var battleStartTimePoint:int = 0;
      
      public static const AUTO_FIGHT:int = 1;
      
      public static const CANCEL_AUTO_FIGHT:int = 2;
      
      private var _battleId:String;
      
      public var isSelfCharge:Boolean = true;
      
      public var selfSide:int = 1;
      
      private var _roleList:Dictionary;
      
      private var _heroList:Dictionary;
      
      public var armyInfoLeft:BattleArmyInfo;
      
      public var armyInfoRight:BattleArmyInfo;
      
      public var mapId:int;
      
      public var mapResId:int;
      
      private var _battleType:int;
      
      private var _started:Boolean;
      
      private var _selfHero:HeroRoleInfo;
      
      public var childHero:HeroRoleInfo;
      
      public var isNoCharge:Boolean;
      
      public var isOver:Boolean;
      
      public var skillIds:Array;
      
      public var soldierTemplates:Array;
      
      private var _actionCount:int;
      
      public var attackModeStart:Boolean;
      
      public var reinforceWave:int;
      
      public var currentReinforceWave:int;
      
      public var useWay:int;
      
      public var defaultSkillCount:int;
      
      private var _awakenRoles:Array;
      
      public var battleCapity:int;
      
      public var cooldownInfo:Array;
      
      private var _isMultiPlayer:Boolean;
      
      private var _currentReadySkillId:int = -1;
      
      public var attackOrders:String = "";
      
      public var isFinishNow:Boolean = false;
      
      public var bossControlLivingId:int = 0;
      
      public var _heroTempId:Array;
      
      public var _life:Array;
      
      private var _otherLivingVisible:Boolean = false;
      
      private var _autoFightFlag:int = 2;
      
      private var _hurtUpMode:HurtUpMode;
      
      private var _trialLayer:int = 0;
      
      public var transSceneEffectComplete:Boolean = false;
      
      public function BattleModel()
      {
         super();
         armyInfoLeft = new BattleArmyInfo();
         armyInfoRight = new BattleArmyInfo();
         _awakenRoles = [];
         _roleList = new Dictionary();
         cooldownInfo = [];
         _heroList = new Dictionary();
      }
      
      public static function getBossHpStripNum(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:GameHeroTempInfo = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(param1);
         if(_loc2_)
         {
            _loc3_ = _loc2_.Captain;
         }
         return _loc3_ > 0 ? _loc3_ : 1;
      }
      
      public function set otherLivingVisible(param1:Boolean) : void
      {
         _otherLivingVisible = param1;
         this.dispatchEvent(new BattleEvent("BATTLE_OTHER_LIVING_VISIBLE",param1));
      }
      
      public function get currentReadySkillId() : int
      {
         return _currentReadySkillId;
      }
      
      public function set currentReadySkillId(param1:int) : void
      {
         _currentReadySkillId = param1;
      }
      
      public function addAttackOrder(param1:String) : void
      {
         attackOrders += "**********************************************************************/n";
         attackOrders += param1;
      }
      
      public function get started() : Boolean
      {
         return _started;
      }
      
      public function set started(param1:Boolean) : void
      {
         _started = param1;
      }
      
      public function initAfterRolesAdded() : void
      {
         var _loc2_:int = 0;
         var _loc3_:HeroRoleInfo = null;
         if(battleCapity > 1)
         {
            _isMultiPlayer = true;
         }
         else
         {
            _loc2_ = 0;
            for each(var _loc1_:RoleInfo in _roleList)
            {
               if(!(_loc1_ is MonsterRoleInfo))
               {
                  if(_loc1_ is HeroRoleInfo)
                  {
                     _loc3_ = _loc1_ as HeroRoleInfo;
                     if(_loc3_.heroInfo.templateInfo.Job != 10 && !_loc3_.isChildFake && !_loc3_.isPetFake && !_loc3_.isGoddess)
                     {
                        _loc2_++;
                     }
                  }
               }
            }
            if(_loc2_ > 1)
            {
               _isMultiPlayer = true;
            }
         }
         if(battleType == 3886)
         {
            _isMultiPlayer = true;
         }
         if(battleType == 306 || battleType == 3850 || battleType == 3900)
         {
            _isMultiPlayer = false;
         }
      }
      
      public function setAttackModelById(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc5_:Array = null;
         var _loc4_:RoleInfo = _roleList[param1];
         if(_loc4_)
         {
            _loc3_ = _loc4_.side;
            _loc4_.attackMode = param2;
            _loc5_ = getRoleBySide(_loc3_);
            for each(var _loc6_:RoleInfo in _loc5_)
            {
               if(_loc6_ is PawnRoleInfo)
               {
                  _loc6_.attackMode = param2;
               }
            }
         }
      }
      
      public function getAttackModeById(param1:int) : int
      {
         var _loc2_:RoleInfo = _roleList[param1];
         if(_loc2_)
         {
            return _loc2_.attackMode;
         }
         return 0;
      }
      
      public function getRoleInfoByUserId(param1:int) : HeroRoleInfo
      {
         for each(var _loc2_:Object in _roleList)
         {
            if(_loc2_ && _loc2_ is HeroRoleInfo && _loc2_.userId == param1)
            {
               return _loc2_ as HeroRoleInfo;
            }
         }
         return null;
      }
      
      public function getHeroRight() : HeroRoleInfo
      {
         var _loc3_:int = 0;
         var _loc2_:Dictionary = armyInfoRight.getHeros;
         for each(var _loc1_:HeroRoleInfo in _loc2_)
         {
            return _loc1_;
         }
         return null;
      }
      
      public function getHeroLeft() : HeroRoleInfo
      {
         var _loc3_:int = 0;
         var _loc2_:Dictionary = armyInfoLeft.getHeros;
         for each(var _loc1_:HeroRoleInfo in _loc2_)
         {
            return _loc1_;
         }
         return null;
      }
      
      public function get battleId() : String
      {
         return _battleId;
      }
      
      public function set battleId(param1:String) : void
      {
         _battleId = param1;
      }
      
      public function setAutoFight(param1:int) : void
      {
         if(_autoFightFlag == param1 || isOver)
         {
            return;
         }
         _autoFightFlag = param1;
         if(CampaignMapModel.inMazeFlag && CampaignMapModel.isHangUp && _autoFightFlag != 1)
         {
            CampaignMapModel.isHangUp = false;
         }
         SocketSendManager.instance.sendAutoAttack(battleId,_autoFightFlag);
         NotificationManager.instance.sendNotification("autoFightChanged");
      }
      
      public function initAutoFight(param1:int) : void
      {
         _autoFightFlag = param1;
         if(!allowAutoFight)
         {
            setAutoFight(2);
            return;
         }
         if(CampaignMapModel.inMazeFlag && CampaignMapModel.isHangUp && _autoFightFlag != 1)
         {
            setAutoFight(1);
         }
      }
      
      public function getAutoFightFlag() : int
      {
         return _autoFightFlag;
      }
      
      public function get isAutoFight() : Boolean
      {
         return _autoFightFlag == 1 ? true : false;
      }
      
      public function getHeros() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:Object in armyInfoLeft.getHeros)
         {
            _loc1_.push(_loc2_);
         }
         for each(_loc2_ in armyInfoRight.getHeros)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function removeRole(param1:RoleInfo) : void
      {
         var _loc2_:RoleInfo = _roleList[param1.livingId];
         if(_loc2_)
         {
            if(_loc2_ is PetRoleInfo)
            {
               return;
            }
            delete _roleList[param1.livingId];
            armyInfoRight.removeRole(param1);
         }
      }
      
      public function removeHeroAndPet(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:RoleInfo = _roleList[param1];
         if(_loc2_)
         {
            if(_loc2_ is HeroRoleInfo)
            {
               _loc3_ = int(HeroRoleInfo(_loc2_).petLivingId);
               delete _roleList[_loc3_];
               delete _roleList[param1];
               armyInfoLeft.removeRole(_loc2_);
            }
         }
      }
      
      public function getChildInfoByLivingId(param1:int) : HeroRoleInfo
      {
         var _loc3_:RoleInfo = null;
         for each(var _loc2_:RoleInfo in _roleList)
         {
            if(_loc2_ is HeroRoleInfo && Boolean(HeroRoleInfo(_loc2_).isChildFake) && HeroRoleInfo(_loc2_).petLivingId == param1)
            {
               _loc3_ = _loc2_;
               break;
            }
         }
         return _loc3_ as HeroRoleInfo;
      }
      
      public function getChildInfoByChildId(param1:int) : HeroRoleInfo
      {
         var _loc3_:RoleInfo = null;
         for each(var _loc2_:RoleInfo in _roleList)
         {
            if(_loc2_ is HeroRoleInfo && HeroRoleInfo(_loc2_).heroInfo.headId == param1)
            {
               _loc3_ = _loc2_;
               break;
            }
         }
         return _loc3_ as HeroRoleInfo;
      }
      
      public function addRole(param1:RoleInfo) : void
      {
         var _loc3_:int = 0;
         var _loc4_:SelfChessRoleInfo = null;
         var _loc2_:int = 0;
         _roleList[param1.livingId] = param1;
         if(BattleFunctionHelper.instance.isBattleHero(param1) && param1.pos >= 1)
         {
            _loc3_ = (param1.pos - 1) / 3;
            _heroList[_loc3_ + "_" + param1.side] = param1;
         }
         if(param1.side == selfSide)
         {
            if(param1 is PawnRoleInfo)
            {
               armyInfoLeft.addPawn(PawnRoleInfo(param1));
            }
            else if(param1 is HeroRoleInfo)
            {
               armyInfoLeft.addHero(HeroRoleInfo(param1));
               switch(battleType)
               {
                  case 307:
                     if(!HeroRoleInfo(param1).isPetFake)
                     {
                        if(HeroRoleInfo(param1).isFollowChild)
                        {
                           if(!HeroRoleInfo(param1).heroInfo.isSlavedChild)
                           {
                              childHero = HeroRoleInfo(param1);
                           }
                        }
                        else
                        {
                           selfHero = HeroRoleInfo(param1);
                        }
                     }
                     break;
                  case 349:
                     _loc4_ = param1 as SelfChessRoleInfo;
                     _loc2_ = PlayerManager.instance.currentPlayerModel.userInfo.userId;
                     if(_loc4_ && _loc4_.userId == _loc2_)
                     {
                        selfHero = _loc4_;
                     }
                     break;
                  default:
                     if(HeroRoleInfo(param1).userId == PlayerManager.instance.currentPlayerModel.userInfo.userId && !HeroRoleInfo(param1).isPetFake && !HeroRoleInfo(param1).isGoddess)
                     {
                        if(HeroRoleInfo(param1).isFollowChild)
                        {
                           if(!HeroRoleInfo(param1).heroInfo.isSlavedChild)
                           {
                              childHero = HeroRoleInfo(param1);
                           }
                        }
                        else
                        {
                           selfHero = HeroRoleInfo(param1);
                        }
                     }
               }
            }
            else if(param1 is PetRoleInfo)
            {
               armyInfoLeft.addPet(param1 as PetRoleInfo);
            }
            else if(param1 is GoddessRoleInfo)
            {
               armyInfoLeft.addGoddess(param1 as GoddessRoleInfo);
            }
         }
         else if(param1 is PawnRoleInfo)
         {
            armyInfoRight.addPawn(PawnRoleInfo(param1));
         }
         else if(param1 is HeroRoleInfo)
         {
            armyInfoRight.addHero(HeroRoleInfo(param1));
         }
         else if(param1 is PetRoleInfo)
         {
            armyInfoRight.addPet(param1 as PetRoleInfo);
         }
         else if(param1 is GoddessRoleInfo)
         {
            armyInfoRight.addGoddess(param1 as GoddessRoleInfo);
         }
      }
      
      private function getIsHero(param1:RoleInfo) : Boolean
      {
         if(param1 is HeroRoleInfo)
         {
            if(param1 is MonsterRoleInfo)
            {
               return false;
            }
            if(HeroRoleInfo(param1).isChildFake || Boolean(HeroRoleInfo(param1).isFollowChild) || Boolean(HeroRoleInfo(param1).isPetFake) || Boolean(HeroRoleInfo(param1).isGoddess))
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      public function get isChildBattle() : Boolean
      {
         if(battleType == 3867)
         {
            return true;
         }
         if(battleType == 3868)
         {
            return true;
         }
         if(battleType == 3847)
         {
            return true;
         }
         if(battleType == 3889)
         {
            return true;
         }
         if(battleType == 3895)
         {
            return true;
         }
         if(battleType == 3896)
         {
            return true;
         }
         if(battleType == 3898)
         {
            return true;
         }
         if(battleType == 3911)
         {
            return true;
         }
         return false;
      }
      
      public function get isMonsterBattle() : Boolean
      {
         if(battleType == 3884)
         {
            return true;
         }
         return false;
      }
      
      public function getArmyInfoBySite(param1:int) : BattleArmyInfo
      {
         if(armyInfoRight.site == param1)
         {
            return armyInfoRight;
         }
         return armyInfoLeft;
      }
      
      public function getRoleById(param1:int) : RoleInfo
      {
         var _loc2_:RoleInfo = null;
         _loc2_ = _roleList[param1];
         if(!_loc2_)
         {
            return getAwakenRole(param1);
         }
         return _loc2_;
      }
      
      private function getAwakenRole(param1:int) : RoleInfo
      {
         for each(var _loc2_:RoleInfo in _awakenRoles)
         {
            if(_loc2_.livingId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getRoleByUserId(param1:int) : HeroRoleInfo
      {
         for each(var _loc2_:HeroRoleInfo in _roleList)
         {
            if(_loc2_.userId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function cacheAwakenRoles(param1:Array) : void
      {
         _awakenRoles = _awakenRoles.concat(param1);
      }
      
      public function getRolesByIds(param1:Array) : Array
      {
         var _loc2_:RoleInfo = null;
         var _loc3_:Array = [];
         for each(var _loc4_:int in param1)
         {
            _loc2_ = _roleList[_loc4_];
            _loc2_ && _loc3_.push(_loc2_);
         }
         return _loc3_;
      }
      
      public function getRoleBySide(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:RoleInfo in _roleList)
         {
            if(_loc3_.side == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function get roleList() : Dictionary
      {
         return _roleList;
      }
      
      public function dispose() : void
      {
         _awakenRoles = null;
         if(_hurtUpMode)
         {
            _hurtUpMode.dispose();
            _hurtUpMode = null;
         }
         for each(var _loc1_:RoleInfo in _roleList)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
      }
      
      public function isAllSkillExecuted() : Boolean
      {
         for each(var _loc1_:RoleInfo in _roleList)
         {
            if(_loc1_.isLiving && _loc1_.actionManager && !_loc1_.actionManager.isOver)
            {
               if(_loc1_.actionMovie.currentLabels && _loc1_.actionMovie.currentLabels != "Victory")
               {
                  return false;
               }
            }
         }
         if((battleType == 35 || battleType == 307) && !isRolesStatic())
         {
            return false;
         }
         return true;
      }
      
      public function isRolesStatic() : Boolean
      {
         for each(var _loc1_:RoleInfo in _roleList)
         {
            if(_loc1_.isLiving && _loc1_.getSkillQueue() && !_loc1_.getSkillQueue().isOver)
            {
               return false;
            }
         }
         return true;
      }
      
      public function monopolyPlayDefeatedAction(param1:int) : void
      {
         var _loc3_:* = null;
         for each(var _loc2_:RoleInfo in _roleList)
         {
            if(_loc2_ is HeroRoleInfo && _loc2_.side == param1)
            {
               if(_loc2_.isLiving)
               {
                  if(HeroRoleInfo(_loc2_).isPetFake && !HeroRoleInfo(_loc2_).isPetState)
                  {
                     _loc2_.view.setBloodStripVisible(false,false);
                  }
                  else
                  {
                     _loc2_.view.setBloodStripVisible(false,true);
                  }
                  if(HeroRoleInfo(_loc2_).type == 3)
                  {
                     new DieAction(_loc2_);
                  }
                  else if(!HeroRoleInfo(_loc2_).isPetFake || HeroRoleInfo(_loc2_).isPetFake && Boolean(HeroRoleInfo(_loc2_).isPetState))
                  {
                     _loc2_.action("Failed","STOP");
                  }
               }
            }
            else if(_loc2_ is PawnRoleInfo && _loc2_.side == param1)
            {
               if(_loc2_.isLiving)
               {
                  _loc2_.view.setBloodStripVisible(false,true);
                  new DieAction(_loc2_);
               }
            }
         }
      }
      
      public function playVictoryAction(param1:int) : void
      {
         var _loc3_:SkillData = null;
         var _loc4_:SkillHandlerII = null;
         for each(var _loc2_:RoleInfo in _roleList)
         {
            if(_loc2_ is HeroRoleInfo && _loc2_.side == param1)
            {
               _loc3_ = new SkillData();
               _loc3_.liftTime = 0;
               _loc3_.fId = _loc2_.livingId;
               _loc3_.sp = HeroRoleInfo(_loc2_).sp;
               _loc3_.hitPoint = HeroRoleInfo(_loc2_).hitPoint;
               _loc4_ = new SkillHandlerII(_loc3_);
               _loc4_.handler();
            }
         }
      }
      
      public function playDefeatedAction(param1:int) : void
      {
         var _loc3_:* = null;
         for each(var _loc2_:RoleInfo in _roleList)
         {
            if(_loc2_ is HeroRoleInfo && _loc2_.side == param1)
            {
               if(_loc2_.isLiving)
               {
                  _loc2_.view.setBloodStripVisible(false,true);
                  _loc2_.action("Failed","STOP");
               }
            }
         }
      }
      
      public function isAllDead() : Boolean
      {
         for each(var _loc1_:RoleInfo in _roleList)
         {
            if(_loc1_.isLiving == true)
            {
               return false;
            }
         }
         return true;
      }
      
      public function getWaitSkillList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:RoleInfo in _roleList)
         {
            if(_loc2_.getSkillQueue() != null)
            {
               _loc1_ = _loc1_.concat(_loc2_.getSkillQueue().getActions());
            }
         }
         return _loc1_;
      }
      
      public function isAllSkillStarted() : Boolean
      {
         var _loc1_:Array = getUnstartSkills();
         if(_loc1_.length > 0)
         {
            return false;
         }
         return true;
      }
      
      public function getUnstartSkills() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:Array = [];
         for each(var _loc2_:RoleInfo in _roleList)
         {
            _loc4_ = _loc4_.concat(_loc2_.getSkillQueue().getActions());
            if(_loc2_.getSkillQueue().current && _loc2_.isLiving)
            {
               _loc4_ = _loc4_.concat(_loc2_.getSkillQueue().current);
            }
         }
         for each(var _loc3_:BaseSkill in _loc4_)
         {
            if(_loc3_ && !_loc3_.started)
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function get actionCount() : int
      {
         return _actionCount;
      }
      
      public function set actionCount(param1:int) : void
      {
         if(_actionCount == param1)
         {
            return;
         }
         _actionCount = param1;
         dispatchEvent(new BattleEvent("actionCountChange",param1));
      }
      
      public function getMyHeroLeftHp() : Number
      {
         return selfHero.bloodA;
      }
      
      public function updateWorldBossBlood(param1:Number, param2:Number) : void
      {
         delayWorldBossBloodSync(param1,param2);
      }
      
      private function delayWorldBossBloodSync(param1:Number, param2:Number) : void
      {
         var _loc4_:HeroRoleInfo = null;
         var _loc5_:Number = NaN;
         _loc4_ = getWorldBoss();
         var _loc3_:Number = 0;
         if(_loc4_)
         {
            _loc5_ = BloodHelper.worldBossBloodCached;
            if(param1 < _loc4_.bloodA - _loc5_)
            {
               _loc3_ = param1 - _loc4_.bloodA + _loc5_;
               _loc4_.updateBloodSecurity(_loc3_);
               BloodHelper.processWorldBossSyncBlood(param2);
            }
            dispatchEvent(new BattleEvent("reduceWorldBossBlood",_loc3_));
         }
      }
      
      public function getWorldBoss() : HeroRoleInfo
      {
         var _loc2_:HeroRoleInfo = null;
         if(battleType != 17 && battleType != 297 && battleType != 305 && battleType != 3865 && battleType != 313 && battleType != 3881 && battleType != 3903)
         {
            return null;
         }
         for each(var _loc1_:RoleInfo in _roleList)
         {
            if(_loc1_ is HeroRoleInfo)
            {
               _loc2_ = _loc1_ as HeroRoleInfo;
               if(_loc2_.type == 3)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function isMultiPlayer() : Boolean
      {
         if(!VersionSwitch.allAutoFight)
         {
            return _isMultiPlayer;
         }
         return false;
      }
      
      public function isBossBattle() : Boolean
      {
         for each(var _loc1_:RoleInfo in _roleList)
         {
            if(_loc1_ is HeroRoleInfo)
            {
               if(HeroRoleInfo(_loc1_).type == 3)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function getHeroRoleByUserId(param1:int) : HeroRoleInfo
      {
         for each(var _loc2_:RoleInfo in _roleList)
         {
            if(_loc2_ is HeroRoleInfo)
            {
               if(HeroRoleInfo(_loc2_).userId == param1)
               {
                  return HeroRoleInfo(_loc2_);
               }
            }
         }
         return null;
      }
      
      public function hurtUpStart(param1:int, param2:int = 0, param3:int = 0) : void
      {
         if(!_hurtUpMode)
         {
            _hurtUpMode = new HurtUpMode();
            _hurtUpMode.battleType = this.battleType;
         }
         if(battleType == 3847)
         {
            _hurtUpMode.resetChildArena(param1 / 1000,param2,param3);
         }
         else
         {
            _hurtUpMode.reset(param1 / 1000,param2);
         }
      }
      
      public function getHurtMode() : HurtUpMode
      {
         if(!_hurtUpMode)
         {
            _hurtUpMode = new HurtUpMode();
         }
         return _hurtUpMode;
      }
      
      public function isPvP() : Boolean
      {
         if(battleType == 291)
         {
            return false;
         }
         if(battleType == 39)
         {
            return false;
         }
         if(battleType == 35)
         {
            return true;
         }
         if(battleType == 3844)
         {
            return false;
         }
         if(battleType == 3847)
         {
            return false;
         }
         if(battleType == 3867)
         {
            return false;
         }
         if(battleType == 3868)
         {
            return false;
         }
         if(battleType == 3870)
         {
            return false;
         }
         if(battleType == 3872)
         {
            return false;
         }
         if(battleType == 3873)
         {
            return false;
         }
         if(battleType == 3875)
         {
            return false;
         }
         if(battleType == 3845)
         {
            return false;
         }
         if(battleType == 3889)
         {
            return false;
         }
         if(battleType == 349)
         {
            return true;
         }
         if(battleType == 3907)
         {
            return true;
         }
         for each(var _loc1_:RoleInfo in _roleList)
         {
            if(_loc1_ is HeroRoleInfo)
            {
               if(HeroRoleInfo(_loc1_).type != 3 && HeroRoleInfo(_loc1_).type != 2)
               {
                  if(selfHero && HeroRoleInfo(_loc1_).side != selfHero.side)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public function isOutyardTitan() : Boolean
      {
         return battleType == 3860;
      }
      
      public function isTrail() : Boolean
      {
         return battleType == 25;
      }
      
      public function isRandomBoss() : Boolean
      {
         return battleType == 3842;
      }
      
      public function isSkyboxRoad() : Boolean
      {
         return battleType == 293;
      }
      
      public function isMateLords() : Boolean
      {
         return battleType == 315;
      }
      
      public function isAresLords() : Boolean
      {
         return battleType == 3859;
      }
      
      public function isLordtrial() : Boolean
      {
         return battleType == 3869;
      }
      
      public function isCrossGuild() : Boolean
      {
         return battleType == 296;
      }
      
      public function isKingTower() : Boolean
      {
         return battleType == 290;
      }
      
      public function isRaceAgainstTime() : Boolean
      {
         return battleType == 3894;
      }
      
      public function isForbiddenBoss() : Boolean
      {
         return battleType == 3903;
      }
      
      public function isWarSoulTower() : Boolean
      {
         return battleType == 3905;
      }
      
      public function isFinalRoad() : Boolean
      {
         return battleType == 3906;
      }
      
      public function set trialLayer(param1:int) : void
      {
         if(_trialLayer != param1)
         {
            _trialLayer = param1;
            dispatchEvent(new BattleEvent("TRAIL_LAYER_CHANGE",_trialLayer));
         }
      }
      
      public function get trialLayer() : int
      {
         return _trialLayer;
      }
      
      public function isControledByBoss() : Boolean
      {
         if(!selfHero)
         {
            return false;
         }
         return bossControlLivingId == selfHero.livingId;
      }
      
      public function isHideOtherInBattle(param1:RoleInfo) : Boolean
      {
         var _loc3_:Boolean = SharedManager.instance.hideOthersInBattle;
         var _loc2_:int = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         if(!_loc3_)
         {
            return false;
         }
         if(param1)
         {
            if(param1 is HeroRoleInfo)
            {
               if(param1 is SelfChessRoleInfo)
               {
                  if((param1 as SelfChessRoleInfo).face == 2 && _loc2_ == (param1 as SelfChessRoleInfo).userId)
                  {
                     return true;
                  }
                  return _loc2_ != (param1 as SelfChessRoleInfo).userId;
               }
               if(param1 is MonsterRoleInfo)
               {
                  if((param1 as MonsterRoleInfo).face == 2 && _loc2_ == (param1 as MonsterRoleInfo).userId)
                  {
                     return true;
                  }
                  return _loc2_ != (param1 as MonsterRoleInfo).userId;
               }
               if((param1 as HeroRoleInfo).type == 3)
               {
                  return false;
               }
               if((param1 as HeroRoleInfo).face == 2 && _loc2_ == (param1 as HeroRoleInfo).heroInfo.userId)
               {
                  return true;
               }
               return _loc2_ != (param1 as HeroRoleInfo).heroInfo.userId;
            }
            if(param1 is PawnRoleInfo)
            {
               if((param1 as PawnRoleInfo).tempInfo.MasterType > 100)
               {
                  return false;
               }
               return 1 != (param1 as PawnRoleInfo).face;
            }
            if(param1 is PetRoleInfo)
            {
               if((param1 as PetRoleInfo).face == 2 && _loc2_ == (param1 as PetRoleInfo).userId)
               {
                  return true;
               }
               return _loc2_ != (param1 as PetRoleInfo).userId;
            }
            if(param1 is GoddessRoleInfo)
            {
               if((param1 as GoddessRoleInfo).face == 2 && _loc2_ == (param1 as GoddessRoleInfo).userId)
               {
                  return true;
               }
               return _loc2_ != (param1 as GoddessRoleInfo).userId;
            }
         }
         return false;
      }
      
      public function checkSelfTeam(param1:RoleInfo) : Boolean
      {
         var _loc2_:int = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         if(param1)
         {
            if(param1 is HeroRoleInfo)
            {
               if(param1 is SelfChessRoleInfo)
               {
                  return _loc2_ != (param1 as SelfChessRoleInfo).heroInfo.userId;
               }
               if(param1 is MonsterRoleInfo)
               {
                  return _loc2_ != (param1 as MonsterRoleInfo).userId;
               }
               return _loc2_ != (param1 as HeroRoleInfo).heroInfo.userId;
            }
            if(param1 is PawnRoleInfo)
            {
               return 1 != (param1 as PawnRoleInfo).face;
            }
            if(param1 is PetRoleInfo)
            {
               return _loc2_ != (param1 as PetRoleInfo).userId;
            }
            if(param1 is GoddessRoleInfo)
            {
               return _loc2_ != (param1 as GoddessRoleInfo).userId;
            }
         }
         return false;
      }
      
      public function get selfChildHeroInfo() : HeroRoleInfo
      {
         var _loc2_:HeroRoleInfo = null;
         if(!isChildBattle)
         {
            return null;
         }
         for each(var _loc1_:RoleInfo in _roleList)
         {
            _loc2_ = _loc1_ as HeroRoleInfo;
            if(_loc2_ && _loc2_.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId && _loc2_.isManualChild)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get selfMonsterRoleInfo() : MonsterRoleInfo
      {
         if(!isMonsterBattle)
         {
            return null;
         }
         for each(var _loc1_:RoleInfo in _roleList)
         {
            if(_loc1_ is MonsterRoleInfo && (_loc1_ as MonsterRoleInfo).isCaptain)
            {
               return _loc1_ as MonsterRoleInfo;
            }
         }
         return null;
      }
      
      public function isGloryRoadBattle() : Boolean
      {
         return battleType == 3863;
      }
      
      public function get battleType() : int
      {
         return _battleType;
      }
      
      public function set battleType(param1:int) : void
      {
         _battleType = param1;
      }
      
      public function get heroList() : Dictionary
      {
         return _heroList;
      }
      
      public function get selfHero() : HeroRoleInfo
      {
         if(isMonsterBattle)
         {
            return selfMonsterRoleInfo;
         }
         if(isChildBattle)
         {
            return selfChildHeroInfo;
         }
         if(_battleType == 349)
         {
            return _selfHero;
         }
         for each(var _loc1_:RoleInfo in _roleList)
         {
            if(getIsHero(_loc1_) && (_loc1_ as HeroRoleInfo).userId == PlayerManager.instance.currentPlayerModel.userInfo.userId)
            {
               return _loc1_ as HeroRoleInfo;
            }
         }
         return _selfHero;
      }
      
      public function set selfHero(param1:HeroRoleInfo) : void
      {
         _selfHero = param1;
      }
      
      public function getMonsterInfoByRole(param1:RoleInfo) : MonsterRoleInfo
      {
         for each(var _loc2_:RoleInfo in _roleList)
         {
            if(_loc2_ is MonsterRoleInfo && param1.side == _loc2_.side)
            {
               return _loc2_ as MonsterRoleInfo;
            }
         }
         return null;
      }
      
      public function checkAllDieByRole(param1:RoleInfo) : Boolean
      {
         var _loc3_:Boolean = true;
         for each(var _loc2_:RoleInfo in _roleList)
         {
            if(param1.side == _loc2_.side)
            {
               if(_loc2_ is HeroRoleInfo)
               {
                  if(!(_loc2_ is MonsterRoleInfo))
                  {
                     if(_loc2_.isLiving)
                     {
                        _loc3_ = false;
                        break;
                     }
                  }
               }
            }
         }
         return _loc3_;
      }
   }
}

