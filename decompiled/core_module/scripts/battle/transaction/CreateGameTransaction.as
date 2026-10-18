package battle.transaction
{
   import battle.BattleManager;
   import battle.control.EnterBattleController;
   import battle.data.SkillData;
   import battle.events.BattleEvent;
   import battle.logsys.BattleLogSystem;
   import battle.skillsys.loader.SkillResLoaderVO;
   import battle.skillsys.loader.SkillResourceLoader;
   import battle.utils.BattleFunctionHelper;
   import battle.view.skillname.SkillNameLoader;
   import com.pickgliss.ui.LayerManager;
   import com.road.yishi.proto.battle.BattlePrepareMsg;
   import com.road.yishi.proto.battle.CoolDownMsg;
   import com.road.yishi.proto.battle.HeroMsg;
   import com.road.yishi.proto.battle.SoldierMsg;
   import flash.utils.getTimer;
   import logging.LoggerSys;
   import manager.LanguageMgr;
   import managers.RemotePetManager;
   import map.campaign.data.TrailPropInfo;
   import map.internals.utils.SocketGameReader;
   import mvc.module.children.ChildPveModel;
   import mvc.module.remotepet.RemotePetModel;
   import yishi.datas.BattleModel;
   import yishi.datas.BattlePropItem;
   import yishi.datas.battle.BattleCooldownModel;
   import yishi.datas.battle.ResourceModel;
   import yishi.datas.objects.GoddessRoleInfo;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.MonsterRoleInfo;
   import yishi.datas.objects.PawnRoleInfo;
   import yishi.datas.objects.PetRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.datas.templates.HeroAisTemplate;
   import yishi.datas.templates.PawnTemplate;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class CreateGameTransaction extends TransactionBase
   {
      
      private var _battlePkgs:Array = [];
      
      private var _userId:int;
      
      public function CreateGameTransaction()
      {
         addHandler();
         super();
      }
      
      private function addHandler() : void
      {
         NotificationManager.instance.addEventListener("battleComplete",onBattleComplete,false,0,true);
      }
      
      private function onBattleComplete(param1:BattleEvent) : void
      {
         _battlePkgs.shift();
         if(_battlePkgs.length > 0)
         {
            _pkg = _battlePkgs[0];
            startBattle();
         }
      }
      
      override public function handlePackage() : void
      {
         var _loc1_:String = null;
         BattleManager.selfDie = false;
         BattleManager.isExitingBattle = false;
         _battlePkgs.push(_pkg);
         if(_battlePkgs.length > 1)
         {
            _loc1_ = LanguageMgr.GetTranslation("battle.transaction.CreateGameTransaction.desc");
            LoggerSys.info(_loc1_);
            return;
         }
         startBattle();
      }
      
      private function startBattle() : void
      {
         NotificationManager.instance.addEventListener("enterbattlescene",__enterBattleSceneHandler);
         SkillData.resetIndexId();
         BattleModel.battleUILoaded = false;
         initBattleInfo();
         initBattleManager();
      }
      
      private function initBattleInfo() : void
      {
         var _loc2_:BattleCooldownModel = null;
         var _loc3_:CoolDownMsg = null;
         var _loc7_:int = 0;
         var _loc6_:BattleModel = new BattleModel();
         BattleManager.getInstance().model = _loc6_;
         var _loc5_:ResourceModel = new ResourceModel();
         BattleManager.getInstance().resourceModel = _loc5_;
         var _loc1_:BattlePrepareMsg = _msgPkg as BattlePrepareMsg;
         _loc6_.battleId = _loc1_.battleId;
         _loc6_.mapId = _loc1_.mapTempId;
         _loc6_.useWay = _loc1_.useWay;
         _loc6_.battleType = _loc1_.battleType;
         _loc6_.reinforceWave = _loc1_.reinforceCount;
         _loc6_.currentReinforceWave = _loc1_.currentReinforce;
         _loc6_.battleCapity = _loc1_.battleCapity;
         _loc6_.hurtUpStart(_loc1_.countDown,_loc1_.damageImprove);
         _loc6_.mapResId = TempleteManager.instance.mapTemplateCate.getTemplateByID(_loc1_.mapTempId).BattleGround;
         _loc6_.isSelfCharge = _loc1_.needAnimation;
         _loc6_.isNoCharge = !_loc1_.hasAssault;
         _loc6_.selfSide = _loc1_.side;
         _loc6_.trialLayer = _loc1_.currentWave;
         _loc6_.initAutoFight(_loc1_.attackModel);
         _loc6_._heroTempId = _loc1_.heroTempId;
         _loc6_._life = _loc1_.life;
         switch(_loc6_.battleType)
         {
            case 35:
               _loc6_ = createPetRoleInfo(_loc6_,_loc1_);
               break;
            case 307:
               _loc6_ = createPawnRoleInfo(_loc6_,_loc1_);
               _loc6_ = createHeroAndPetRoleInfo(_loc6_,_loc1_,true);
               BattleManager.getInstance().battleModel.isFinishNow = false;
               break;
            case 349:
               _loc6_ = createPawnRoleInfo(_loc6_,_loc1_);
               _loc6_ = createSelfChessRoleInfo(_loc6_,_loc1_);
               break;
            default:
               _loc6_ = createPawnRoleInfo(_loc6_,_loc1_);
               _loc6_ = createHeroAndPetRoleInfo(_loc6_,_loc1_);
         }
         if(_loc6_.battleType == 295)
         {
            BattleModel.battleStartTimePoint = getTimer();
         }
         if(_loc6_.battleType == 3845)
         {
            BattleManager.preScene = "SPACE_SCENE";
         }
         var _loc4_:Boolean = false;
         var _loc8_:uint = uint(_loc1_.battleFrom);
         BattleManager.getInstance()._curJoinType = _loc8_;
         if(_loc8_ == 0)
         {
            if(!_loc6_.selfHero)
            {
               return;
            }
         }
         _loc6_.armyInfoLeft.face = _loc6_.armyInfoLeft.face;
         _loc6_.armyInfoRight.face = _loc6_.armyInfoRight.face;
         _loc6_.soldierTemplates = _loc1_.soldierTemplated;
         if(_loc1_.coolDown.length > 0)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc1_.coolDown.length)
            {
               _loc3_ = _loc1_.coolDown[_loc7_];
               _loc2_ = new BattleCooldownModel();
               _loc2_.templateId = _loc3_.templatedId;
               _loc2_.cooldown = _loc3_.coolDown / 1000;
               _loc2_.appearCoolDown = _loc3_.appearCoolDown / 1000;
               _loc2_.coolType = _loc3_.coolType;
               _loc2_.start();
               _loc6_.cooldownInfo.push(_loc2_);
               _loc7_++;
            }
         }
         if(BattleManager.loginToBattleFlag)
         {
            _loc6_.isNoCharge = true;
         }
         _userId = _loc6_.selfHero.userId;
         checkFace(_loc6_,_loc4_);
         _loc6_.initAfterRolesAdded();
         _loc1_ = null;
      }
      
      private function initBattleManager() : void
      {
         BattleTransactionManager.getInstance().setup();
         BattleManager.getInstance().initSkillSystem();
         BattleManager.getInstance().started = true;
         BattleManager.getInstance().setup();
         BattleLogSystem.clear();
         KeyBoardRegister.instance.battleFlag = true;
         LayerManager.Instance.clearnGameDynamic();
         BattleManager.getInstance().resourceModel.startLoad();
         EnterBattleController.getInstance().handler(null);
      }
      
      private function initResLoad() : void
      {
         loadRoleView();
         loadBattleSkill();
      }
      
      private function loadRoleView() : void
      {
         for each(var _loc1_:RoleInfo in battleModel.roleList)
         {
            if(!battleModel.isHideOtherInBattle(_loc1_))
            {
               _loc1_.load();
            }
         }
      }
      
      private function loadBattleSkill() : void
      {
         var _loc1_:Array = [];
         SkillResourceLoader.clear();
         initPawnSkill(_loc1_);
         initHeroSkill(_loc1_);
         initPetSkill(_loc1_);
         initGoddessSkill(_loc1_);
         initAvengerSkill(_loc1_);
         initMonsterSkill(_loc1_);
         initChildrenSkill(_loc1_);
         initRemotePetSkill(_loc1_);
         initChildPveSkill(_loc1_);
         initChildCommonSkill(_loc1_);
         BattleManager.getInstance().battleModel.skillIds = _loc1_;
      }
      
      private function initPawnSkill(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc7_:PawnTemplate = null;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:Array = [];
         var _loc5_:BattleModel = BattleManager.getInstance().battleModel;
         if(_loc5_.soldierTemplates)
         {
            for each(_loc6_ in _loc5_.soldierTemplates)
            {
               _loc7_ = TempleteManager.instance.pawnTemplateCate.getTemplateByID(_loc6_);
               _loc4_ = _loc4_.concat(getAwakenSkillByAi(_loc7_.AI));
            }
         }
         for each(var _loc2_:RoleInfo in _loc5_.roleList)
         {
            if(_loc2_ is PawnRoleInfo)
            {
               _loc3_ = int(_loc2_.skillIds.length);
               _loc8_ = 0;
               while(_loc8_ < _loc3_)
               {
                  if(_loc4_.indexOf(_loc2_.skillIds[_loc8_]) == -1)
                  {
                     _loc4_.push(_loc2_.skillIds[_loc8_]);
                  }
                  _loc8_++;
               }
            }
         }
         for each(_loc6_ in _loc4_)
         {
            if(_loc6_ != 0 && param1.indexOf(_loc6_) == -1)
            {
               param1.push(_loc6_);
               SkillResourceLoader.addSkillVOs([new SkillResLoaderVO(_loc6_,2)]);
            }
         }
      }
      
      private function initHeroSkill(param1:Array) : void
      {
         var _loc8_:HeroRoleInfo = null;
         var _loc23_:int = 0;
         var _loc10_:Array = null;
         var _loc2_:int = 0;
         var _loc25_:GameHeroTempInfo = null;
         var _loc22_:Array = null;
         var _loc21_:int = 0;
         var _loc3_:TrailPropInfo = null;
         var _loc20_:int = 0;
         var _loc17_:* = undefined;
         var _loc24_:* = undefined;
         var _loc19_:int = 0;
         var _loc7_:Array = [];
         var _loc5_:Array = [];
         var _loc18_:ResourceModel = BattleManager.getInstance().resourceModel;
         var _loc12_:BattleModel = BattleManager.getInstance().battleModel;
         var _loc14_:Array = [700001,700002];
         var _loc16_:Array = [700003,700004];
         for each(var _loc4_:RoleInfo in _loc12_.roleList)
         {
            if(_loc4_ is HeroRoleInfo)
            {
               _loc10_ = [];
               _loc8_ = _loc4_ as HeroRoleInfo;
               for each(var _loc11_:BattlePropItem in _loc8_.props)
               {
                  if(_loc11_.skillTempId != 0 && param1.indexOf(_loc11_.skillTempId) == -1)
                  {
                     param1.push(_loc11_.skillTempId);
                     SkillResourceLoader.addSkillVOs([new SkillResLoaderVO(_loc11_.skillTempId,2)]);
                  }
               }
               _loc25_ = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc8_.templateId);
               if(_loc25_)
               {
                  _loc2_ = _loc25_.DefaultSkill;
               }
               if(param1.indexOf(_loc2_) == -1)
               {
                  param1.push(_loc2_);
                  _loc10_.push(_loc2_);
                  if(_loc8_ == _loc12_.selfHero)
                  {
                     _loc5_.push(_loc2_);
                  }
               }
               if(_loc8_.petRoleInfo && _loc8_.petRoleInfo.template)
               {
                  _loc22_ = _loc8_.petRoleInfo.template.DefaultSkills.split(",");
                  for each(var _loc13_:String in _loc22_)
                  {
                     _loc2_ = parseInt(_loc13_);
                     if(param1.indexOf(_loc2_) == -1)
                     {
                        param1.push(_loc2_);
                        SkillResourceLoader.addSkillVOs([new SkillResLoaderVO(_loc2_,2)]);
                     }
                  }
               }
               _loc21_ = 0;
               while(_loc21_ < _loc8_.skillIds.length)
               {
                  if(param1.indexOf(_loc8_.skillIds[_loc21_]) == -1)
                  {
                     param1.push(_loc8_.skillIds[_loc21_]);
                     _loc10_.push(_loc8_.skillIds[_loc21_]);
                  }
                  if(_loc8_ == _loc12_.selfHero)
                  {
                     _loc5_.push(_loc8_.skillIds[_loc21_]);
                  }
                  if(_loc8_.side == _loc12_.selfSide && _loc7_.indexOf(_loc8_.skillIds[_loc21_]) == -1)
                  {
                     _loc7_.push(_loc8_.skillIds[_loc21_]);
                  }
                  _loc21_++;
               }
               _loc20_ = 0;
               while(_loc20_ < _loc8_.trialProps.length)
               {
                  _loc3_ = _loc8_.trialProps[_loc20_];
                  if(param1.indexOf(_loc3_.id) == -1)
                  {
                     param1.push(_loc3_.id);
                     _loc10_.push(_loc3_.id);
                  }
                  if(_loc8_ == _loc12_.selfHero)
                  {
                     _loc5_.push(_loc3_.id);
                  }
                  _loc20_++;
               }
               _loc20_ = 0;
               while(_loc20_ < _loc8_.marrSkills.length)
               {
                  _loc3_ = _loc8_.marrSkills[_loc20_] as TrailPropInfo;
                  if(param1.indexOf(_loc3_.id) == -1)
                  {
                     param1.push(_loc3_.id);
                     _loc10_.push(_loc3_.id);
                  }
                  if(_loc8_ == _loc12_.selfHero)
                  {
                     _loc5_.push(_loc3_.id);
                  }
                  if(param1.indexOf(103) == -1)
                  {
                     param1.push(103);
                     _loc10_.push(103);
                  }
                  _loc20_++;
               }
               _loc21_ = 0;
               while(_loc21_ < _loc8_.petSkillIds.length)
               {
                  _loc23_ = int(_loc8_.petSkillIds[_loc21_]);
                  if(param1.indexOf(_loc23_) == -1)
                  {
                     param1.push(_loc23_);
                     _loc10_.push(_loc23_);
                  }
                  if(_loc8_ == _loc12_.selfHero)
                  {
                     _loc5_.push(_loc23_);
                  }
                  _loc21_++;
               }
               if(_loc8_.petRoleInfo)
               {
                  _loc21_ = 0;
                  while(_loc21_ < _loc14_.length)
                  {
                     _loc23_ = int(_loc14_[_loc21_]);
                     if(param1.indexOf(_loc23_) == -1)
                     {
                        param1.push(_loc23_);
                        _loc10_.push(_loc23_);
                     }
                     if(_loc8_ == _loc12_.selfHero)
                     {
                        _loc5_.push(_loc23_);
                     }
                     _loc21_++;
                  }
               }
               if(_loc8_.isChildFake)
               {
                  _loc21_ = 0;
                  while(_loc21_ < _loc16_.length)
                  {
                     _loc23_ = int(_loc16_[_loc21_]);
                     if(param1.indexOf(_loc23_) == -1)
                     {
                        param1.push(_loc23_);
                        _loc10_.push(_loc23_);
                     }
                     if(_loc12_.selfChildHeroInfo && _loc8_ == _loc12_.selfChildHeroInfo)
                     {
                        _loc5_.push(_loc23_);
                     }
                     _loc21_++;
                  }
               }
               if(_loc8_.templateId == 1008 || _loc8_.templateId == 1009)
               {
                  param1.push(700001,40214,40215);
                  _loc10_.push(700001,40214,40215);
                  param1.push(60457,60458);
                  _loc10_.push(60457,60458);
               }
               _loc10_ = SkillResourceLoader.getHeroFullSkillIds(_loc10_);
               _loc17_ = new <uint>[229101,229102];
               if(_loc17_.indexOf(_loc8_.templateId) >= 0)
               {
                  _loc24_ = new <uint>[31231,60529,60530];
                  for each(var _loc9_:uint in _loc24_)
                  {
                     if(_loc10_.indexOf(_loc9_) == -1)
                     {
                        _loc10_.push(_loc9_);
                     }
                  }
               }
               if(_loc8_.type == 3)
               {
                  _loc19_ = 2;
               }
               else
               {
                  _loc19_ = _loc8_.heroInfo.sexs;
               }
               for each(var _loc6_:int in _loc10_)
               {
                  SkillResourceLoader.addSkillVOs([new SkillResLoaderVO(_loc6_,_loc19_)]);
               }
               for each(_loc23_ in _loc8_.petSkillIds)
               {
                  SkillResourceLoader.addSkillVOs([new SkillResLoaderVO(_loc23_,2)]);
               }
            }
         }
         var _loc15_:Array = _loc5_ = _loc5_.concat(SkillResourceLoader.getHeroFullSkillIds(_loc5_));
         if(_loc12_.battleType == 35 || _loc12_.battleType == 3844)
         {
            _loc15_ = _loc7_.concat(SkillResourceLoader.getHeroFullSkillIds(_loc7_));
         }
         _loc15_ = SkillNameLoader.getSkillNameIds(_loc15_);
         _loc18_.addSkillNameIds(_loc15_);
      }
      
      private function initPetSkill(param1:Array) : void
      {
         var _loc6_:PetRoleInfo = null;
         var _loc2_:Array = null;
         var _loc5_:ResourceModel = BattleManager.getInstance().resourceModel;
         var _loc7_:BattleModel = BattleManager.getInstance().battleModel;
         for each(var _loc4_:RoleInfo in _loc7_.roleList)
         {
            if(_loc4_ is PetRoleInfo)
            {
               _loc6_ = _loc4_ as PetRoleInfo;
               for each(var _loc3_:int in _loc6_.skillIds)
               {
                  if(param1.indexOf(_loc3_) == -1)
                  {
                     param1.push(_loc3_);
                     SkillResourceLoader.addSkillVOs([new SkillResLoaderVO(_loc3_,2)]);
                  }
               }
               _loc2_ = _loc6_.template.DefaultSkills.split(",");
               for each(var _loc8_:String in _loc2_)
               {
                  _loc3_ = parseInt(_loc8_);
                  if(param1.indexOf(_loc3_) == -1)
                  {
                     param1.push(_loc3_);
                     SkillResourceLoader.addSkillVOs([new SkillResLoaderVO(_loc3_,2)]);
                  }
               }
            }
         }
      }
      
      private function initMonsterSkill(param1:Array) : void
      {
         var _loc4_:ResourceModel = BattleManager.getInstance().resourceModel;
         var _loc5_:BattleModel = BattleManager.getInstance().battleModel;
         for each(var _loc3_:RoleInfo in _loc5_.roleList)
         {
            if(_loc3_ is MonsterRoleInfo)
            {
               for each(var _loc2_:int in _loc3_.skillIds)
               {
                  if(param1.indexOf(_loc2_) == -1)
                  {
                     param1.push(_loc2_);
                     SkillResourceLoader.addSkillVOs([new SkillResLoaderVO(_loc2_,2)]);
                  }
               }
            }
         }
      }
      
      private function initGoddessSkill(param1:Array) : void
      {
         var _loc6_:* = null;
         var _loc4_:ResourceModel = BattleManager.getInstance().resourceModel;
         var _loc5_:BattleModel = BattleManager.getInstance().battleModel;
         for each(var _loc3_:RoleInfo in _loc5_.roleList)
         {
            if(_loc3_ is GoddessRoleInfo)
            {
               for each(var _loc2_:int in _loc3_.skillIds)
               {
                  if(param1.indexOf(_loc2_) == -1)
                  {
                     param1.push(_loc2_);
                     SkillResourceLoader.addSkillVOs([new SkillResLoaderVO(_loc2_,2)]);
                  }
               }
            }
         }
      }
      
      private function initAvengerSkill(param1:Array) : void
      {
         var _loc6_:HeroRoleInfo = null;
         var _loc3_:ResourceModel = BattleManager.getInstance().resourceModel;
         var _loc5_:BattleModel = BattleManager.getInstance().battleModel;
         for each(var _loc2_:RoleInfo in _loc5_.roleList)
         {
            if(_loc2_ is HeroRoleInfo)
            {
               _loc6_ = _loc2_ as HeroRoleInfo;
               if(_loc6_.heroInfo.isAvenger)
               {
                  for each(var _loc4_:int in _loc6_.avengerAllSkills)
                  {
                     if(param1.indexOf(_loc4_) == -1)
                     {
                        param1.push(_loc4_);
                        SkillResourceLoader.addSkillVOs([new SkillResLoaderVO(_loc4_,2)]);
                     }
                  }
               }
            }
         }
      }
      
      private function initChildrenSkill(param1:Array) : void
      {
         var _loc6_:HeroRoleInfo = null;
         var _loc2_:int = 0;
         var _loc4_:ResourceModel = BattleManager.getInstance().resourceModel;
         var _loc5_:BattleModel = BattleManager.getInstance().battleModel;
         for each(var _loc3_:RoleInfo in _loc5_.roleList)
         {
            if(_loc3_ is HeroRoleInfo && (_loc3_ as HeroRoleInfo).isChildFake)
            {
               _loc6_ = _loc3_ as HeroRoleInfo;
               if(_loc6_.heroInfo.childrenJob == 1)
               {
                  _loc2_ = 41001;
                  if(param1.indexOf(_loc2_) == -1)
                  {
                     param1.push(_loc2_);
                     SkillResourceLoader.addSkillVOs([new SkillResLoaderVO(_loc2_,2)]);
                  }
               }
               else if(_loc6_.heroInfo.childrenJob == 2)
               {
                  _loc2_ = 42001;
                  if(param1.indexOf(_loc2_) == -1)
                  {
                     param1.push(_loc2_);
                     SkillResourceLoader.addSkillVOs([new SkillResLoaderVO(_loc2_,2)]);
                  }
               }
               else if(_loc6_.heroInfo.childrenJob == 3)
               {
                  _loc2_ = 43001;
                  if(param1.indexOf(_loc2_) == -1)
                  {
                     param1.push(_loc2_);
                     SkillResourceLoader.addSkillVOs([new SkillResLoaderVO(_loc2_,2)]);
                  }
               }
            }
         }
      }
      
      private function initRemotePetSkill(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:RemotePetModel = RemotePetManager.instance.model;
         var _loc4_:Array = _loc3_.remotePetSkill;
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            param1.push(_loc4_[_loc2_]);
            SkillResourceLoader.addSkillVOs([new SkillResLoaderVO(_loc4_[_loc2_],2)]);
            _loc2_++;
         }
      }
      
      private function initChildPveSkill(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ChildPveModel = FrameControllerManager.instance.childPveController.pveModel;
         var _loc4_:Array = _loc2_.skillInfo;
         if(!_loc4_)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            param1.push(_loc4_[_loc3_]);
            SkillResourceLoader.addSkillVOs([new SkillResLoaderVO(_loc4_[_loc3_],2)]);
            _loc3_++;
         }
      }
      
      private function initChildCommonSkill(param1:Array) : void
      {
         var _loc4_:HeroRoleInfo = null;
         if(!battleModel.isChildBattle)
         {
            return;
         }
         var _loc5_:ResourceModel = BattleManager.getInstance().resourceModel;
         var _loc6_:BattleModel = BattleManager.getInstance().battleModel;
         for each(var _loc3_:RoleInfo in _loc6_.roleList)
         {
            if(_loc3_ is HeroRoleInfo)
            {
               _loc4_ = _loc3_ as HeroRoleInfo;
               for each(var _loc2_:int in _loc4_.skillIds)
               {
                  if(param1.indexOf(_loc2_) == -1)
                  {
                     param1.push(_loc2_);
                     SkillResourceLoader.addSkillVOs([new SkillResLoaderVO(_loc2_,2)]);
                  }
               }
            }
         }
      }
      
      private function getAwakenSkillByAi(param1:int) : Array
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc8_:int = 0;
         var _loc9_:PawnTemplate = null;
         var _loc6_:HeroAisTemplate = TempleteManager.instance.heroAISTemplateCate.getTemplateByID(param1);
         var _loc11_:Array = [];
         var _loc2_:Array = [];
         if(_loc6_)
         {
            if(_loc6_.Soldiers != null && _loc6_.Soldiers != "")
            {
               _loc4_ = _loc6_.Soldiers.split("|");
               for each(var _loc7_:String in _loc4_)
               {
                  _loc8_ = int(_loc7_.split(",")[0]);
                  if(_loc11_.indexOf(_loc8_) == -1)
                  {
                     _loc11_.push(_loc8_);
                  }
               }
               for each(var _loc10_:int in _loc11_)
               {
                  _loc9_ = TempleteManager.instance.pawnTemplateCate.getTemplateByID(_loc10_);
                  if(_loc9_)
                  {
                     _loc6_ = TempleteManager.instance.heroAISTemplateCate.getTemplateByID(_loc9_.AI);
                     if(_loc6_)
                     {
                        _loc2_ = _loc2_.concat(_loc6_.getSkills());
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      private function createPawnRoleInfo(param1:BattleModel, param2:BattlePrepareMsg) : BattleModel
      {
         var _loc4_:PawnRoleInfo = null;
         var _loc5_:SoldierMsg = null;
         var _loc6_:int = 0;
         var _loc3_:int = int(param2.soldiers.length);
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = param2.soldiers[_loc6_];
            _loc4_ = SocketGameReader.readPawnRoleInfo(_loc5_);
            param1.addRole(_loc4_);
            _loc4_.totalBlood = _loc4_.bloodA;
            _loc4_.initBloodA = _loc4_.bloodA;
            _loc6_++;
         }
         return param1;
      }
      
      private function createChildRoleInfo(param1:BattleModel, param2:BattlePrepareMsg) : BattleModel
      {
         var _loc5_:HeroRoleInfo = null;
         var _loc7_:HeroMsg = null;
         var _loc4_:HeroMsg = null;
         var _loc6_:int = 0;
         if(param1.battleType != 290)
         {
            return param1;
         }
         var _loc3_:int = int(param2.children.length);
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc7_ = param2.children[_loc6_];
            _loc4_ = BattleFunctionHelper.instance.findBattleRoleMsgForHero(param2.pets,_loc7_.livingId);
            _loc5_ = SocketGameReader.readHeroRoleInfo(_loc7_,_loc4_,null,true);
            param1.addRole(_loc5_);
            if(_loc5_.petRoleInfo)
            {
               param1.addRole(_loc5_.petRoleInfo);
            }
            _loc7_ = null;
            _loc6_++;
         }
         return param1;
      }
      
      private function createSelfChessRoleInfo(param1:BattleModel, param2:BattlePrepareMsg) : BattleModel
      {
         var _loc5_:HeroRoleInfo = null;
         var _loc7_:HeroMsg = null;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc3_:int = int(param2.chessList.length);
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc7_ = param2.chessList[_loc6_];
            _loc5_ = SocketGameReader.readSelfChessRoleInfo(_loc7_);
            trace("收到战斗英雄列表：：：" + _loc5_.heroInfo.nickName);
            param1.addRole(_loc5_);
            _loc7_ = null;
            _loc6_++;
         }
         return param1;
      }
      
      private function createPetRoleInfo(param1:BattleModel, param2:BattlePrepareMsg) : BattleModel
      {
         var _loc4_:HeroRoleInfo = null;
         var _loc6_:HeroMsg = null;
         var _loc5_:int = 0;
         if(param1.battleType != 35)
         {
            return param1;
         }
         var _loc3_:int = int(param2.pets.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = param2.pets[_loc5_];
            _loc4_ = SocketGameReader.readHeroRoleInfo(_loc6_,null,null);
            _loc4_.petRoleInfo = SocketGameReader.readPetRoleInfo(_loc6_);
            _loc4_.heroInfo.petTemplateId = _loc6_.tempId;
            _loc4_.heroInfo.sexs = 2;
            _loc4_.isPetState = true;
            param1.addRole(_loc4_);
            _loc6_ = null;
            _loc5_++;
         }
         return param1;
      }
      
      private function createHeroAndPetRoleInfo(param1:BattleModel, param2:BattlePrepareMsg, param3:Boolean = false) : BattleModel
      {
         var _loc6_:HeroRoleInfo = null;
         var _loc10_:MonsterRoleInfo = null;
         var _loc14_:HeroMsg = null;
         var _loc5_:HeroMsg = null;
         var _loc9_:* = null;
         var _loc7_:HeroMsg = null;
         var _loc12_:HeroMsg = null;
         var _loc8_:int = 0;
         var _loc11_:int = 0;
         var _loc13_:int = 0;
         if(param1.battleType == 35)
         {
            return param1;
         }
         var _loc4_:int = int(param2.heros.length);
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc14_ = param2.heros[_loc8_];
            _loc5_ = BattleFunctionHelper.instance.findBattleRoleMsgForHero(param2.pets,_loc14_.livingId);
            _loc7_ = BattleFunctionHelper.instance.findBattleRoleMsgForHero(param2.goddesses,_loc14_.livingId);
            if(!(param3 && _loc14_.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId))
            {
               _loc11_ = param2.pets.indexOf(_loc5_);
               if(_loc5_ && _loc11_ != -1)
               {
                  param2.pets.splice(_loc11_,1);
               }
               _loc13_ = param2.goddesses.indexOf(_loc7_);
               if(_loc7_ && _loc13_ != -1)
               {
                  param2.goddesses.splice(_loc13_,1);
               }
               _loc6_ = SocketGameReader.readHeroRoleInfo(_loc14_,_loc5_,_loc7_);
               param1.addRole(_loc6_);
               if(_loc6_.petRoleInfo)
               {
                  param1.addRole(_loc6_.petRoleInfo);
               }
               if(_loc6_.goddessRoleInfo)
               {
                  param1.addRole(_loc6_.goddessRoleInfo);
               }
               _loc14_ = null;
               _loc5_ = null;
            }
            _loc8_++;
         }
         _loc4_ = int(param2.pets.length);
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc5_ = param2.pets[_loc8_];
            _loc6_ = SocketGameReader.readHeroRoleInfo(_loc5_,null,null);
            _loc6_.petRoleInfo = SocketGameReader.readPetRoleInfo(_loc5_);
            _loc6_.petRoleInfo.heroRoleInfo = _loc6_;
            _loc6_.heroInfo.petTemplateId = _loc5_.tempId;
            if(param1.battleType == 3844 || param1.battleType == 3866 || param1.battleType == 3864)
            {
               _loc6_.isPetState = true;
               _loc6_.heroInfo.sexs = 2;
            }
            else
            {
               _loc6_.isPetFake = true;
            }
            param1.addRole(_loc6_);
            _loc5_ = null;
            _loc8_++;
         }
         _loc4_ = int(param2.goddesses.length);
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc7_ = param2.goddesses[_loc8_];
            _loc6_ = SocketGameReader.readHeroRoleInfo(_loc7_,null,null);
            _loc6_.goddessRoleInfo = SocketGameReader.readGoddessRoleInfo(_loc7_);
            _loc6_.goddessRoleInfo.heroRoleInfo = _loc6_;
            _loc6_.goddessRoleInfo.templateId = _loc7_.tempId;
            _loc6_.isGoddess = true;
            param1.addRole(_loc6_);
            _loc7_ = null;
            _loc8_++;
         }
         _loc4_ = int(param2.children.length);
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc14_ = param2.children[_loc8_];
            if(param1.battleType == 3845 || param1.battleType == 3847 || param1.battleType == 3867 || param1.battleType == 3868 || param1.battleType == 3889)
            {
               _loc5_ = BattleFunctionHelper.instance.findBattleRoleMsgForHero(param2.pets,_loc14_.livingId);
               _loc6_ = SocketGameReader.readHeroRoleInfo(_loc14_,_loc5_,null,true);
               _loc6_.isFollowChild = false;
            }
            else
            {
               _loc5_ = BattleFunctionHelper.instance.findBattleRoleMsgForHero(param2.pets,_loc14_.livingId);
               _loc6_ = SocketGameReader.readHeroRoleInfo(_loc14_,_loc5_,null,true);
               _loc6_.isFollowChild = true;
            }
            param1.addRole(_loc6_);
            if(_loc6_.petRoleInfo)
            {
               param1.addRole(_loc6_.petRoleInfo);
            }
            _loc14_ = null;
            _loc8_++;
         }
         _loc4_ = int(param2.monsters.length);
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc12_ = param2.monsters[_loc8_];
            _loc10_ = SocketGameReader.readMonsterRoleInfo(_loc12_);
            if(param1.battleType == 3884)
            {
               _loc10_.isFollowHero = false;
            }
            else
            {
               _loc10_.isFollowHero = true;
            }
            param1.addRole(_loc10_);
            _loc12_ = null;
            _loc8_++;
         }
         return param1;
      }
      
      private function checkFace(param1:BattleModel, param2:Boolean = false) : void
      {
         param1.armyInfoLeft.site = param1.selfSide;
         param1.armyInfoLeft.face = param2 ? 2 : 1;
         param1.armyInfoRight.face = param2 ? 1 : 2;
         param1.armyInfoRight.site = 3 - param1.selfSide;
      }
      
      private function __enterBattleSceneHandler(param1:BattleEvent) : void
      {
         NotificationManager.instance.removeEventListener("enterbattlescene",__enterBattleSceneHandler);
         NotificationManager.instance.removeEventListener("BATTLE_READ_GO",__enterBattleSceneHandler);
         initResLoad();
      }
      
      private function get resourcePath() : String
      {
         return PathManager.info.ResourcePath;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      override public function getCode() : int
      {
         return 157;
      }
   }
}

