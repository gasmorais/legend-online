package battle.skillsys.skills
{
   import battle.BattleManager;
   import battle.actions.DannyAction;
   import battle.actions.GameBaseAction;
   import battle.actions.common.SimpleScriptAction;
   import battle.data.AttackData;
   import battle.data.BufferDamageData;
   import battle.data.SkillData;
   import battle.handler.AwakenHandler;
   import battle.handler.BufferHandler;
   import battle.logsys.BattleLogSystem;
   import battle.skillsys.effect.BattleEffect;
   import battle.skillsys.effect.EffectContainer;
   import battle.skillsys.effect.ProfoundEffect;
   import battle.skillsys.effect.ProfoundEffectII;
   import battle.skillsys.effect.SkillEffect;
   import battle.skillsys.mode.ActionTemplateData;
   import battle.skillsys.mode.framedata.SkillFrameData;
   import battle.utils.BattleFunctionHelper;
   import battle.utils.BattleUtils;
   import battle.view.roles.RoleViewBase;
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   import yishi.datas.battle.ResistModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.view.shadow.ShadowEffectMaker;
   import yishi.view.shadow.ShadowTypeEnum;
   
   public class BaseSkill extends GameBaseAction
   {
      
      protected var _skillData:SkillData;
      
      public var actionId:int;
      
      protected var _actionTemplate:ActionTemplateData;
      
      protected var _thisProxy:BaseSkill;
      
      protected var _addBufferFrame:int = -1;
      
      protected var _bufferAdded:Boolean;
      
      protected var _isPlayer:Boolean;
      
      private var _started:Boolean;
      
      protected var _dannyReleased:Boolean;
      
      public function BaseSkill()
      {
         super();
         _thisProxy = this;
      }
      
      public function get started() : Boolean
      {
         return _started;
      }
      
      public function set started(param1:Boolean) : void
      {
         _started = param1;
      }
      
      public function setData(param1:SkillData) : void
      {
         _skillData = param1;
         _liftTime = _skillData.liftTime;
         var _loc3_:Dictionary = BattleManager.getInstance().battleModel.roleList;
         _currentRole = BattleManager.getInstance().battleModel.getRoleById(_skillData.fId);
         var _loc2_:RoleInfo = getCurrentRole();
         if(_loc2_)
         {
         }
         if(_loc2_ && _loc2_ is HeroRoleInfo && HeroRoleInfo(_loc2_).type != 3)
         {
            _isPlayer = true;
         }
      }
      
      public function setTemplate(param1:ActionTemplateData) : void
      {
         _actionTemplate = param1;
         for each(var _loc2_:SkillFrameData in _actionTemplate.frames)
         {
            if(_loc2_.ActionType == 3)
            {
               _addBufferFrame = _loc2_.Frame;
               break;
            }
         }
      }
      
      public function setProcessStrategy(param1:int) : void
      {
         _skillData.processStrategy = param1;
      }
      
      override public function prepare() : void
      {
         BattleLogSystem.skillProgress(this,1);
         var _loc1_:RoleInfo = getCurrentRole();
         if(_loc1_ && BattleFunctionHelper.instance.isLoadComplete(_loc1_) && (_skillData.processStrategy == 1 || BattleFunctionHelper.instance.isGoddessSkill(_skillData.skillTemp) || _skillData.skillId == 1 || _skillData.skillId == 2 || _skillData.skillId == 3 || _skillData.skillId == 4))
         {
            if(BattleManager.loginToBattleFlag && (_skillData.skillId == 1 || _skillData.skillId == 2))
            {
               skipFun();
            }
            else
            {
               beforeRun();
               startRun();
               bufferProcess();
            }
         }
         else
         {
            skipFun();
         }
         _loc1_.refreshBufferTurn();
         _loc1_.addAction(new SimpleScriptAction(0,awakenSoldiers,1));
      }
      
      public function skipFun() : void
      {
         beforeRun();
         skip();
         bufferProcess(true);
         _started = true;
      }
      
      private function checkNeedPlayAddBufferEffect() : Boolean
      {
         var _loc2_:BufferTemplateInfo = null;
         var _loc1_:Vector.<BufferDamageData> = _skillData.buffers;
         for each(var _loc3_:BufferDamageData in _loc1_)
         {
            if(_loc3_.AttackType == 28 || _loc3_.AttackType == 29)
            {
               if(_skillData.fId == _loc3_.bufferUser && _skillData.fId == _loc3_.target)
               {
                  _loc2_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc3_.templateId);
                  if(_loc2_.Random < 100)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      protected function addPassiveEffectAction() : void
      {
         var leftHeroId:int;
         var needFlash:Boolean;
         var isSelf:Boolean;
         var playAddBufferEffedt:Boolean;
         var roleInfo:RoleInfo;
         var role_f:RoleInfo;
         var action:SimpleScriptAction;
         if(_skillData.skillId == 700002)
         {
            return;
         }
         leftHeroId = selfHero.livingId;
         isSelf = _skillData.fId == leftHeroId;
         playAddBufferEffedt = checkNeedPlayAddBufferEffect();
         roleInfo = getCurrentRole();
         needFlash = !(roleInfo && roleInfo is HeroRoleInfo && HeroRoleInfo(roleInfo).type != 3);
         if(battleModel.battleType == 35)
         {
            needFlash = true;
         }
         if(needFlash || isSelf)
         {
            needFlash = !isDefaultSkill();
         }
         if(needFlash || playAddBufferEffedt)
         {
            role_f = battleModel.getRoleById(_skillData.fId);
            action = new SimpleScriptAction(_skillData.liftTime,null,8);
            action.onPrepare = function():void
            {
               var _loc2_:Object = null;
               var _loc1_:EffectContainer = null;
               var _loc3_:BattleEffect = new SkillEffect("battle.resource.PassiveEffectAsset");
               var _loc4_:DisplayObject = _loc3_.getDisplayObject();
               if(_loc4_)
               {
                  _loc4_.x = role_f.getSpecialPos(2).x;
                  _loc4_.y = role_f.getSpecialPos(2).y;
                  if(_loc4_["getMC"])
                  {
                     _loc2_ = _loc4_["getMC"]();
                  }
                  if(_loc2_ && _loc2_["fateEffect"])
                  {
                     _loc2_["fateEffect"].visible = playAddBufferEffedt;
                  }
               }
               if(BattleManager.getInstance().battleMap.rolesDict[_skillData.fId])
               {
                  if(!battleModel.isHideOtherInBattle(role_f))
                  {
                     _loc1_ = RoleViewBase(BattleManager.getInstance().battleMap.rolesDict[_skillData.fId]).effectContainer;
                     _loc1_.addEffect(_loc3_);
                  }
               }
               if(isSelf)
               {
                  role_f.map.backGroundToColor2(0.2,500);
               }
            };
            role_f.addAction(action);
         }
      }
      
      private function beforeRun() : void
      {
         var _loc1_:RoleViewBase = null;
         var _loc2_:RoleInfo = null;
         var _loc3_:int = selfHero.livingId;
         if(_skillData.fId == _loc3_)
         {
            NotificationManager.instance.sendNotification("RESET_ACTION_TIME_BattleNotic");
            if(isDefaultSkill())
            {
            }
            if(_skillData.skillId == 700002)
            {
               NotificationManager.instance.sendNotification("SKILL_ENABLE",false);
            }
         }
         else
         {
            _loc1_ = BattleManager.getInstance().battleMap.rolesDict[_skillData.fId];
            if(_loc1_)
            {
               _loc1_.removeCollectionEffect();
               _loc1_.removeSkillFlag();
            }
         }
         if(_skillData.skillId != 1 && _skillData.skillId != 2)
         {
            setAimRoleWait();
         }
         chkShadowSkill();
         if(checkIsHero(_skillData.fId))
         {
            switch(_skillData.skillId - 1)
            {
               case 0:
               case 1:
               case 2:
               case 3:
                  break;
               default:
                  _loc2_ = battleModel.getRoleById(_skillData.fId);
                  if(!isDefaultSkill() && (battleModel.battleType != 35 && battleModel.battleType != 3844 && _loc2_ == selfHero || battleModel.battleType == 3844 && _loc2_.side == selfHero.side || battleModel.battleType == 35 && _loc2_.side == selfHero.side))
                  {
                     NotificationManager.instance.sendNotification("SHOW_SKILL_NAME_BattleNotic",_skillData.skillId);
                  }
            }
         }
      }
      
      protected function startRun() : void
      {
      }
      
      protected function skip() : void
      {
         var _loc4_:Boolean = false;
         var _loc2_:Array = _skillData.data;
         var _loc1_:RoleInfo = getCurrentRole();
         if(_loc1_ && _loc1_ == selfHero)
         {
            _loc4_ = true;
         }
         for each(var _loc3_:Array in _loc2_)
         {
            BattleUtils.addSingleDanny(_loc3_,12,true,0,0,0,true,6710886,_loc4_);
         }
         updataSp();
         onSkip();
         skillComplete();
         BattleLogSystem.skillDannyFlag(this);
      }
      
      protected function onSkip() : void
      {
      }
      
      protected function setAimRoleWait() : void
      {
         var _loc4_:int = 0;
         var _loc1_:RoleInfo = null;
         var _loc3_:Array = _skillData.data;
         for each(var _loc2_:Array in _loc3_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc1_ = battleModel.getRoleById(_loc2_[_loc4_].roleId);
               if(_loc1_ && !_loc1_.readyFlag)
               {
                  _loc1_.affectedSkill = this;
               }
               _loc4_++;
            }
         }
      }
      
      private function cancelAimRoleWait() : void
      {
         var _loc4_:int = 0;
         var _loc1_:RoleInfo = null;
         var _loc3_:Array = _skillData.data;
         for each(var _loc2_:Array in _loc3_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc1_ = battleModel.getRoleById(_loc2_[_loc4_].roleId);
               if(_loc1_ && _loc1_.affectedSkill == this)
               {
                  _loc1_.affectedSkill = null;
               }
               _loc4_++;
            }
         }
      }
      
      protected function updataSp() : void
      {
         _bufferAdded = true;
         var _loc1_:RoleInfo = getCurrentRole();
         if(_loc1_)
         {
            BattleUtils.skillUpdateSp(_skillData,_loc1_);
            BattleUtils.skillUpdateHitPoint(_skillData,_loc1_);
         }
      }
      
      public function chkShadowSkill() : Boolean
      {
         var _loc1_:Array = null;
         var _loc3_:* = 0;
         var _loc5_:* = 0;
         var _loc2_:RoleInfo = getCurrentRole();
         if(!_loc2_)
         {
            return false;
         }
         if(!SharedManager.instance.shadowEffect)
         {
            ShadowEffectMaker.stopPhantom(_loc2_.view.body);
            return false;
         }
         var _loc4_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_skillData.skillId);
         if(_loc4_ && _loc4_.OwnRequirements != "" && _loc2_.showShadow)
         {
            _loc1_ = _loc4_.OwnRequirements.split(",");
            _loc3_ = uint(_loc1_[0]);
            _loc5_ = uint(_loc1_[1]);
            if(ShadowEffectMaker.chkEffctObj(_loc2_.view.body))
            {
               ShadowEffectMaker.stopPhantom(_loc2_.view.body);
            }
            ShadowEffectMaker.startPhantom(_loc2_.view.body,_loc5_,0,ShadowTypeEnum.HashMap[_loc3_],_loc2_.view);
            return true;
         }
         return false;
      }
      
      protected function startMoveFun() : void
      {
         var _loc1_:RoleInfo = getCurrentRole();
         if(_loc1_ && _loc1_.view)
         {
            _loc1_.view.setBloodStripVisible(false);
         }
      }
      
      protected function endMoveFun() : void
      {
         var _loc1_:RoleInfo = getCurrentRole();
         if(_loc1_ && _loc1_.view)
         {
            _loc1_.view.setBloodStripVisible(true);
         }
      }
      
      private function checkIsHero(param1:int) : Boolean
      {
         var _loc2_:HeroRoleInfo = BattleManager.getInstance().battleModel.getRoleById(param1) as HeroRoleInfo;
         return _loc2_ == null ? false : true;
      }
      
      private function get selfHero() : HeroRoleInfo
      {
         return BattleManager.getInstance().battleModel.selfHero;
      }
      
      protected function skillComplete() : void
      {
         var _loc6_:SkillTempInfo = null;
         var _loc3_:SkillTempInfo = null;
         var _loc5_:Array = null;
         var _loc1_:SkillTempInfo = null;
         var _loc2_:HeroRoleInfo = null;
         var _loc9_:Boolean = false;
         var _loc10_:SkillTempInfo = null;
         var _loc7_:int = 0;
         var _loc8_:HeroRoleInfo = null;
         _dannyReleased = true;
         if(battleModel.battleType == 3844)
         {
            _loc6_ = TempleteManager.instance.getSkillTemplateInfoById(_skillData.skillId);
            if(_loc6_ && _loc6_.MasterType == 200)
            {
               NotificationManager.instance.sendNotification("SKILL_ENABLE",true);
               sendCDEvent();
            }
         }
         else if(battleModel.battleType == 3845)
         {
            _loc3_ = TempleteManager.instance.getSkillTemplateInfoById(_skillData.skillId);
            _loc5_ = TempleteManager.instance.childPveBossTemplateCate.getAllSkillId();
            if(_loc3_ && _loc5_ && _loc5_.indexOf(_loc3_.TemplateId) > -1)
            {
               NotificationManager.instance.sendNotification("SKILL_ENABLE",true);
               sendCDEvent();
            }
         }
         else if(battleModel.isChildBattle)
         {
            _loc1_ = TempleteManager.instance.getSkillTemplateInfoById(_skillData.skillId);
            if(_loc1_)
            {
               _loc2_ = battleModel.selfChildHeroInfo;
               _loc9_ = _loc2_ && _loc2_.livingId == _skillData.fId;
               if(_loc9_)
               {
                  NotificationManager.instance.sendNotification("SKILL_ENABLE",true);
                  sendCDEvent();
               }
            }
         }
         else if(_skillData.skillId != 1 && _skillData.skillId != 2 && selfHero.livingId == _skillData.fId)
         {
            _loc10_ = TempleteManager.instance.getSkillTemplateInfoById(battleModel.currentReadySkillId);
            if(battleModel.currentReadySkillId == _skillData.skillId || _loc10_ && _skillData.skillId == _loc10_.Parameter3)
            {
               battleModel.currentReadySkillId = -1;
            }
            if(!isDefaultSkill())
            {
               if(!isTitanSkill(_skillData))
               {
                  NotificationManager.instance.sendNotification("SKILL_ENABLE",true);
                  sendCDEvent();
               }
            }
            else
            {
               BattleManager.getInstance().battleModel.defaultSkillCount++;
               _loc7_ = BattleManager.getInstance().battleModel.defaultSkillCount;
               if(_loc7_ > 1)
               {
                  if(!isTitanSkill(_skillData))
                  {
                     NotificationManager.instance.sendNotification("SKILL_ENABLE",true);
                  }
               }
            }
         }
         var _loc4_:RoleInfo = getCurrentRole();
         if(_loc4_ && _loc4_ is HeroRoleInfo)
         {
            _loc8_ = _loc4_ as HeroRoleInfo;
            if(_skillData.skillId == 700002)
            {
               _loc8_.isPetState = false;
            }
            else if(_skillData.skillId == 700001)
            {
               _loc8_.isPetState = true;
            }
            else if(_skillData.skillId == 650493)
            {
               _loc8_.effectId = _loc8_.resPath = "boss032a";
               _loc8_.reload();
            }
            else if(_skillData.skillId == 700003)
            {
               _loc8_.isPetState = true;
            }
            else if(_skillData.skillId == 700004)
            {
               _loc8_.isPetState = false;
            }
         }
         if(_loc4_ && !_loc4_.isGoddess)
         {
            ShadowEffectMaker.stopPhantom(_loc4_.view.body);
         }
         cancelAimRoleWait();
         setArrangePriority(false);
         _finished = true;
      }
      
      private function isTitanSkill(param1:SkillData) : Boolean
      {
         return param1.coexistType == 1;
      }
      
      private function sendCDEvent() : void
      {
         if(!_actionTemplate)
         {
            return;
         }
         var _loc2_:int = 0;
         if(_skillData.processStrategy != 1)
         {
            _loc2_ = _actionTemplate.getCompleteFrameIndex();
            _loc2_ *= 40;
         }
         var _loc1_:Object = {};
         _loc1_.skillId = _skillData.skillId;
         _loc1_.waitTime = _loc2_;
         NotificationManager.instance.sendNotification("skillCd",_loc1_);
      }
      
      public function isDefaultSkill() : Boolean
      {
         var _loc1_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_skillData.skillId);
         if(_skillData.skillId == -1 || _loc1_ && _loc1_.UseWay == 3)
         {
            return true;
         }
         return false;
      }
      
      protected function bufferProcess(param1:Boolean = false) : void
      {
         var _loc2_:* = undefined;
         var _loc5_:BufferDamageData = null;
         var _loc3_:int = 0;
         var _loc4_:BufferTemplateInfo = null;
         if(_skillData.skillId == 3 || _skillData.skillId == 4)
         {
            return;
         }
         if(_skillData.buffers && _skillData.buffers.length > 0)
         {
            _loc2_ = new Vector.<BufferDamageData>();
            _loc3_ = 0;
            while(_loc3_ < _skillData.buffers.length)
            {
               _loc5_ = _skillData.buffers[_loc3_];
               if(_loc5_.processType == 0)
               {
                  _loc4_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc5_.templateId);
                  _loc5_.effectiveType = _loc4_.AddWay;
               }
               if(_loc5_.effectiveType == 1)
               {
                  executeBufferAffectives(_loc5_);
               }
               else
               {
                  _loc2_.push(_loc5_);
               }
               _loc3_++;
            }
            if(_loc2_.length > 0)
            {
               if(_skillData.data && _skillData.data.length > 0 && !param1)
               {
                  _skillData.skillBuffers = _loc2_;
               }
               else
               {
                  for each(_loc5_ in _loc2_)
                  {
                     executeBufferAffectives(_loc5_);
                  }
               }
            }
         }
      }
      
      protected function executeBufferAffectives(param1:BufferDamageData) : void
      {
         var _loc2_:int = 0;
         if(param1.damages.length == 0)
         {
            BufferHandler.processBuffer(param1,_skillData.fId,0);
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < param1.damages.length)
            {
               BufferHandler.processBuffer(param1,_skillData.fId,_loc2_);
               _loc2_++;
            }
         }
      }
      
      protected function addBuffer(param1:int) : void
      {
         if(_skillData.skillBuffers && _skillData.skillBuffers.length > 0)
         {
            for each(var _loc2_:BufferDamageData in _skillData.skillBuffers)
            {
               if(_loc2_.effectiveType != 4)
               {
                  BufferHandler.processBuffer(_loc2_,_skillData.fId,param1);
               }
            }
         }
      }
      
      protected function addParryBuffer(param1:int) : void
      {
      }
      
      protected function addProfoundEffect() : void
      {
         var roleInfo:RoleInfo;
         var waitAction:SimpleScriptAction;
         var profound:ProfoundEffect;
         var roleView:RoleViewBase;
         var isSelf:Boolean;
         var profoundCallback:* = function():void
         {
            waitAction.finished = true;
         };
         var skillPriority:int = TempleteManager.instance.getSkillTemplateInfoById(_skillData.skillId).Priority;
         if(skillPriority != 3)
         {
            return;
         }
         roleInfo = BattleManager.getInstance().battleModel.getRoleById(_skillData.fId);
         isSelf = roleInfo == BattleManager.getInstance().battleModel.selfHero;
         waitAction = new SimpleScriptAction();
         waitAction.onPrepare = function():void
         {
            roleView = BattleManager.getInstance().battleMap.rolesDict[roleInfo.livingId] as RoleViewBase;
            if(roleView)
            {
               profound = new ProfoundEffect(roleView,profoundCallback,isSelf);
            }
            else
            {
               profoundCallback();
            }
         };
         roleInfo.addAction(waitAction);
      }
      
      protected function addProfoundEffect2() : void
      {
         var profound:ProfoundEffectII;
         var roleView:RoleViewBase;
         var profoundCallback:* = function():void
         {
            waitAction.finished = true;
         };
         var roleInfo:RoleInfo = BattleManager.getInstance().battleModel.getRoleById(_skillData.fId);
         var waitAction:SimpleScriptAction = new SimpleScriptAction();
         waitAction.onPrepare = function():void
         {
            roleView = BattleManager.getInstance().battleMap.rolesDict[roleInfo.livingId] as RoleViewBase;
            if(roleView)
            {
               profound = new ProfoundEffectII(roleView,profoundCallback);
            }
            else
            {
               profoundCallback();
            }
         };
         roleInfo.addAction(waitAction);
      }
      
      private function awakenSoldiers() : void
      {
         var _loc1_:RoleInfo = null;
         var _loc2_:int = 0;
         if(_skillData.awakens)
         {
            _loc2_ = 0;
            while(_loc2_ < _skillData.awakens.length)
            {
               _loc1_ = _skillData.awakens[_loc2_];
               AwakenHandler.addRole(_loc1_);
               _loc2_++;
            }
         }
      }
      
      protected function setArrangePriority(param1:Boolean) : void
      {
         var _loc4_:Object = BattleManager.getInstance().battleMap;
         if(!_loc4_)
         {
            return;
         }
         var _loc3_:RoleInfo = getCurrentRole();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:RoleViewBase = BattleManager.getInstance().battleMap.rolesDict[_loc3_.livingId] as RoleViewBase;
         if(_loc2_)
         {
            _loc2_.setArrangePriority(param1);
         }
      }
      
      protected function isFrameSexFit(param1:SkillFrameData) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:RoleInfo = null;
         if(_isPlayer)
         {
            _loc2_ = getCurrentRole();
            if(!_loc2_)
            {
               return false;
            }
            _loc3_ = int(HeroRoleInfo(_loc2_).heroInfo.sexs);
            if(param1.Sex != 2 && param1.Sex != _loc3_)
            {
               return false;
            }
         }
         return true;
      }
      
      protected function actionAttackLeft(param1:int) : void
      {
         var _loc5_:Boolean = false;
         var _loc4_:int = 0;
         var _loc6_:Array = null;
         var _loc3_:ResistModel = null;
         if(_dannyReleased)
         {
            return;
         }
         var _loc2_:RoleInfo = getCurrentRole();
         if(_loc2_ && _loc2_ == selfHero)
         {
            _loc5_ = true;
         }
         if(getSkillData().data)
         {
            _loc4_ = param1;
            while(_loc4_ < getSkillData().data.length)
            {
               _loc6_ = getSkillData().data[_loc4_];
               _loc3_ = BattleManager.getInstance().resistModel;
               _loc3_.attackOver = false;
               for each(var _loc7_:AttackData in _loc6_)
               {
                  new DannyAction(_loc7_.roleInfo,_loc7_,12,true,50,0,4,true,6710886,true,_loc5_,getSkillData().skillId);
                  _loc3_.currentResistSide = _loc2_.side == battleModel.selfSide ? 1 : 2;
                  _loc3_.resistTotal = _loc7_.resiPercent;
                  if(battleModel.selfHero.livingId != _loc7_.fId && battleModel.selfHero.livingId != _loc7_.roleId)
                  {
                     _loc3_.resistTotal = 0;
                  }
               }
               if(_loc3_.resistTotal != 0)
               {
                  _loc3_.attackOver = true;
               }
               else
               {
                  _loc3_.attackOver = false;
               }
               addBuffer(_loc4_);
               _loc4_++;
            }
         }
         _dannyReleased = true;
         if(!_bufferAdded)
         {
            updataSp();
         }
         skillComplete();
      }
      
      public function getRoleSex() : int
      {
         if(!_isPlayer)
         {
            return 2;
         }
         var _loc1_:RoleInfo = getCurrentRole();
         if(!_loc1_)
         {
            return 2;
         }
         return HeroRoleInfo(_loc1_).heroInfo.sexs;
      }
      
      public function getCurrentRole() : RoleInfo
      {
         return _currentRole;
      }
      
      public function getSkillData() : SkillData
      {
         return _skillData;
      }
      
      public function getActionTemplate() : ActionTemplateData
      {
         return _actionTemplate;
      }
   }
}

