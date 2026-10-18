package battle.view.ui
{
   import battle.BattleManager;
   import battle.data.SkillData;
   import battle.view.roles.RoleViewBase;
   import com.road.yishi.proto.battle.HeroOrderMsg;
   import com.road.yishi.proto.battle.ItemUseResultMsg;
   import dialog.utils.NewbieSocketOutManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.DragonTalkerManager;
   import managers.GloryroadManager;
   import managers.MarryManager;
   import map.campaign.data.TrailPropInfo;
   import mvc.module.armyII.SkillInfo;
   import mvc.module.children.ChildData;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerSkillInfo;
   import mvc.module.gloryroad.GloryRoadModel;
   import mvc.module.lordtrial.LordTrialModel;
   import mvc.module.marry.MarryInfo;
   import org.aswing.KeyboardManager;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.datas.BattlePropItem;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.MonsterRoleInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.RoleEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.LordTrialManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.TimerUtils;
   
   public class SkillItemListController
   {
      
      private static var emptySelectableOnOff:Boolean = true;
      
      private var view:SkillItemListView;
      
      private var skills:Array;
      
      private var petSkills:Array;
      
      private var _heroRoleInfo:HeroRoleInfo;
      
      private var _heroChildInfo:HeroRoleInfo;
      
      private var _heroMarrayInfo:HeroRoleInfo;
      
      private var _battleModel:BattleModel;
      
      private var skillSelectingTargets:Array;
      
      private var skillType:int;
      
      private var _selected:Boolean;
      
      private var _useSkillFailed:Boolean;
      
      private var awakenSkills:Array = [];
      
      private var _childSkillDark:Boolean = false;
      
      public function SkillItemListController(param1:SkillItemListView)
      {
         super();
         _battleModel = BattleManager.getInstance().battleModel;
         _heroRoleInfo = _battleModel.selfHero;
         _heroChildInfo = _battleModel.childHero;
         _heroMarrayInfo = _heroRoleInfo.getMarrObject();
         this.view = param1;
         init();
      }
      
      private function init() : void
      {
         var _loc3_:ConfigInfosTempInfo = null;
         var _loc16_:Array = null;
         var _loc11_:int = 0;
         var _loc9_:int = 0;
         var _loc15_:TrailPropInfo = null;
         var _loc10_:MarryInfo = null;
         var _loc7_:int = 0;
         var _loc14_:int = 0;
         var _loc13_:HeroRoleInfo = null;
         var _loc2_:BattlePropItem = null;
         var _loc5_:int = 0;
         var _loc8_:Array = null;
         var _loc17_:int = 0;
         var _loc12_:int = 0;
         skills = [];
         petSkills = [];
         var _loc1_:SimpleDictionary = getFastkey();
         var _loc18_:SkillTempInfo = null;
         var _loc6_:ChildData = getEnterWarChild();
         if(_battleModel && _battleModel.battleType == 3870)
         {
            _loc3_ = TempleteManager.instance.getConfigInfoByConfigName("TimeSpaceFaultSkill");
            if(_loc3_ != null)
            {
               _loc16_ = _loc3_.ConfigValue.split(",");
               _loc9_ = 0;
               while(_loc9_ < 5)
               {
                  _loc11_ = int(_loc16_[_loc9_]);
                  _loc18_ = TempleteManager.instance.getSkillTemplateInfoById(_loc11_);
                  skills.push(_loc18_);
                  _loc9_++;
               }
            }
         }
         var _loc4_:int = 1;
         _loc4_ = 1;
         while(_loc4_ <= 9)
         {
            _loc18_ = null;
            if(!(_loc4_ < 6 && _battleModel && _battleModel.battleType == 3870))
            {
               if(_loc1_.hasOwnProperty("fastkey_" + _loc4_))
               {
                  _loc18_ = TempleteManager.instance.getSkillTemplateInfoById(_loc1_["fastkey_" + _loc4_]);
               }
               else if(_loc4_ == 6)
               {
                  if(_battleModel.selfHero.replaceSkillInfo)
                  {
                     _loc18_ = TempleteManager.instance.getSkillTemplateInfoById(getTalentTempId(_battleModel.selfHero.replaceSkillInfo.talnetSkill));
                  }
                  else
                  {
                     _loc18_ = TempleteManager.instance.getSkillTemplateInfoById(getTalentTempId(thane.talentData.talentScript));
                  }
               }
               else if(_loc4_ == 7)
               {
                  _loc15_ = _heroRoleInfo.getActiveMarrSkillInfo();
                  if(_loc15_)
                  {
                     _loc18_ = _loc15_.skillTemp;
                  }
                  else if(_battleModel.selfHero.replaceSkillInfo == null)
                  {
                     _loc10_ = MarryManager.instance.model.selfMarryInfo;
                     if(_loc10_)
                     {
                        _loc18_ = _loc10_.getActiveMarrSkill();
                     }
                     if(!_loc18_)
                     {
                        _loc18_ = TempleteManager.instance.getSkillTemplateInfoById(9991);
                     }
                  }
               }
               else if(_loc4_ == 8)
               {
                  if(getChildFastSkillTemAry(_loc6_).length > 0)
                  {
                     _loc18_ = getChildFastSkillTemAry(_loc6_)[0];
                  }
               }
               else if(_loc4_ == 9)
               {
                  if(getChildFastSkillTemAry(_loc6_).length > 1)
                  {
                     _loc18_ = getChildFastSkillTemAry(_loc6_)[1];
                  }
               }
               skills.push(_loc18_);
            }
            _loc4_++;
         }
         if(_battleModel)
         {
            _loc7_ = 0;
            _loc14_ = 0;
            _loc13_ = _heroRoleInfo;
            if(_loc13_ && _loc13_.props)
            {
               _loc7_ = 0;
               _loc14_ = int(_loc13_.props.length);
               while(_loc7_ < _loc14_)
               {
                  _loc2_ = _loc13_.props[_loc7_];
                  _loc5_ = int(_loc13_.props[_loc7_].bagPos);
                  skills[9 + _loc5_] = _loc2_;
                  _loc7_++;
               }
            }
            _loc8_ = getPetSkillFastkey();
            _loc17_ = 0;
            if(_loc13_.petSkillIds)
            {
               _loc7_ = 0;
               while(_loc7_ < 5)
               {
                  _loc12_ = int(_loc13_.petSkillIds[_loc7_]);
                  if(_loc12_)
                  {
                     _loc18_ = TempleteManager.instance.getSkillTemplateInfoById(_loc12_);
                     _loc17_ = _loc8_.indexOf(_loc18_.SonType.toString());
                     if(_loc17_ != -1)
                     {
                        petSkills[_loc17_] = _loc18_;
                     }
                  }
                  _loc7_++;
               }
            }
            awakenSkills.push(TempleteManager.instance.getSkillTemplateInfoById(700001));
            awakenSkills.push(TempleteManager.instance.getSkillTemplateInfoById(700002));
         }
         if(view)
         {
            view.initView(skills);
            view.initPetSkills(petSkills);
            view.initCD();
         }
         NotificationManager.instance.addEventListener("ACTION_SKILL_BattleNotic",__skillUse);
         NotificationManager.instance.addEventListener("RESET_ACTION_TIME_BattleNotic",__cleanSkillSelect);
         NotificationManager.instance.addEventListener("SKILL_ENABLE",__skillEnable);
         NotificationManager.instance.addEventListener("FORCE_SKILL_ENABLE",__forceSkillEnable);
         NotificationManager.instance.addEventListener("restrictChanged",restrictChangedHandler);
         NotificationManager.instance.addEventListener("skillCd",onSkillCdHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 75,__skillUseServerBack);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 158,__useBattleItemServerBack);
         NotificationManager.instance.addEventListener("BattleModelNotic.ADD_ROLE",__updateMarrSkillItemHandler);
         NotificationManager.instance.addEventListener("BattleModelNotic.REMOVE_ROLE",__updateMarrSkillItemHandler);
         NotificationManager.instance.addEventListener("BUFFER_SKILL_ENABLE",__bufferEnabeleHandler);
         if(_heroRoleInfo)
         {
            _heroRoleInfo.addEventListener("sp",onHeroSpChanged);
            _heroRoleInfo.addEventListener("AWAKEN",__onAwkenValueChangeHandler);
            _heroRoleInfo.addEventListener("HIT_POINT",__onHeroHitPointChanged);
         }
         KeyboardManager.getInstance().addEventListener("keyUp",onKeyUp);
         __onAwkenValueChangeHandler();
         updateMarrSkillItem();
         if(_heroMarrayInfo)
         {
            _heroMarrayInfo.addEventListener("die",__heroMarrayInfoDieHandler);
            _heroMarrayInfo.addEventListener("isLiving",__heroMarrayInfoDieHandler);
         }
         updateChildSkillItem();
         if(_heroChildInfo)
         {
            _heroChildInfo.addEventListener("die",__heroChildInfoDieHandler);
            _heroChildInfo.addEventListener("AWAKEN",__heroChildInfoDieHandler);
            _heroChildInfo.addEventListener("isLiving",__heroChildInfoDieHandler);
         }
      }
      
      public function get gloryModel() : GloryRoadModel
      {
         return GloryroadManager.instance.model;
      }
      
      public function get lordTrialModel() : LordTrialModel
      {
         return LordTrialManager.instance.model;
      }
      
      private function getEnterWarChild() : ChildData
      {
         var _loc1_:ChildData = null;
         if(_battleModel.isGloryRoadBattle())
         {
            _loc1_ = gloryModel.getChildData();
         }
         else if(_battleModel.isLordtrial())
         {
            _loc1_ = lordTrialModel.getChildData();
         }
         else
         {
            _loc1_ = ChildManager.instance.model.getEnterWar();
         }
         return _loc1_;
      }
      
      private function getChildProfoundSkillId(param1:ChildData) : Array
      {
         var _loc5_:SkillTempInfo = null;
         var _loc3_:Array = null;
         var _loc6_:Array = null;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         if(param1)
         {
            _loc3_ = TempleteManager.instance.getSkillTemplateInfoByIds(param1.skill);
            _loc6_ = param1.fightSkill.split(",");
            if(_loc6_.length > 0)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc5_ = _loc3_[_loc4_] as SkillTempInfo;
                  if(_loc5_ && isChildProfoundSkill(_loc5_))
                  {
                     if(_loc6_.indexOf(_loc5_.SonType.toString()) != -1)
                     {
                        _loc2_.push(_loc5_);
                     }
                  }
                  _loc4_++;
               }
            }
         }
         return _loc2_;
      }
      
      public function isChildProfoundSkill(param1:SkillTempInfo) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:Dictionary = TempleteManager.instance.childTemplateCate.getTemplates();
         for each(var _loc2_:ChildTempInfo in _loc4_)
         {
            if(_loc2_.SkillMasterType == param1.MasterType)
            {
               _loc3_ = true;
               break;
            }
         }
         return param1.Priority == 3 && _loc3_;
      }
      
      public function isStoneTriggerSkill(param1:SkillTempInfo) : Boolean
      {
         if(param1.UseWay == 4)
         {
            return true;
         }
         return false;
      }
      
      private function onSkillCdHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data.skillId);
         var _loc3_:int = int(param1.data.waitTime);
         view.cdStart(_loc2_,_loc3_);
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.charCode == 32)
         {
            emptySelectableOnOff = !emptySelectableOnOff;
         }
      }
      
      private function getPetSkillFastkey() : Array
      {
         var _loc1_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc2_:Array = [];
         if(_battleModel.selfHero.replaceSkillInfo)
         {
            _loc2_ = _battleModel.selfHero.replaceSkillInfo.petFastKey.split(",");
         }
         else if(_loc1_.enterWarPet)
         {
            _loc2_ = _loc1_.enterWarPet.petFastKeyOfString.split(",");
         }
         return _loc2_;
      }
      
      private function getChildFastSkillTemAry(param1:ChildData) : Array
      {
         var _loc5_:SkillTempInfo = null;
         var _loc2_:Array = null;
         var _loc6_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         if(_battleModel.selfHero.replaceSkillInfo)
         {
            _loc2_ = _battleModel.selfHero.replaceSkillInfo.childSkills;
            _loc6_ = [];
            if(_battleModel.selfHero.replaceSkillInfo.childFastKey)
            {
               _loc6_ = _battleModel.selfHero.replaceSkillInfo.childFastKey.split(",");
            }
            if(_loc6_.length > 0)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc2_.length)
               {
                  _loc5_ = TempleteManager.instance.getSkillTemplateInfoById(_loc2_[_loc4_]);
                  if(_loc5_ && isChildProfoundSkill(_loc5_))
                  {
                     if(_loc6_.indexOf(_loc5_.SonType.toString()) != -1)
                     {
                        _loc3_.push(_loc5_);
                     }
                  }
                  _loc4_++;
               }
            }
         }
         else
         {
            _loc3_ = getChildProfoundSkillId(param1);
         }
         return _loc3_;
      }
      
      private function getFastkey() : SimpleDictionary
      {
         var _loc9_:Array = null;
         var _loc1_:Array = null;
         var _loc3_:DragonTalkerSkillInfo = null;
         var _loc6_:int = 0;
         var _loc10_:SkillInfo = null;
         var _loc2_:SkillTempInfo = null;
         var _loc5_:ThaneInfo = thane;
         var _loc8_:SimpleDictionary = new SimpleDictionary(true);
         if(dragonModel.isDragonTalker)
         {
            _loc3_ = dragonModel.getSkillInfoByIndex(dragonModel.skillActiveIndex);
            _loc9_ = _loc3_ ? _loc3_.fastKeySkills : [];
            _loc1_ = _loc3_ ? _loc3_.learnSkills : [];
         }
         else
         {
            _loc9_ = _loc5_.skillCate.fastKey.split(",");
            _loc1_ = _loc5_.skillCate.skillScript.split(",");
         }
         if(_battleModel.selfHero.replaceSkillInfo)
         {
            _loc9_ = _battleModel.selfHero.replaceSkillInfo.fastKey.split(",");
         }
         var _loc4_:int = 0;
         _loc6_ = 1;
         while(_loc6_ < _loc9_.length)
         {
            if(_loc9_[_loc6_ - 1] != -1)
            {
               if(_battleModel.selfHero.replaceSkillInfo)
               {
                  for each(var _loc7_:Number in _battleModel.selfHero.skillIds)
                  {
                     _loc2_ = TempleteManager.instance.getSkillById(_loc7_);
                     if(_battleModel.selfHero.heroInfo.dragonTalkerInfo.isDragonTalker)
                     {
                        if(_loc2_.TemplateId == _loc9_[_loc6_ - 1])
                        {
                           _loc8_.add("fastkey_" + _loc6_,_loc2_.TemplateId);
                           _loc8_.add("index_" + _loc2_.TemplateId,_loc6_);
                        }
                     }
                     else if(_loc2_.SonType == _loc9_[_loc6_ - 1])
                     {
                        _loc8_.add("fastkey_" + _loc6_,_loc2_.TemplateId);
                        _loc8_.add("index_" + _loc2_.TemplateId,_loc6_);
                     }
                  }
               }
               else
               {
                  if(dragonModel.isDragonTalker)
                  {
                     _loc10_ = dragonModel.allSkillInfoDic[_loc9_[_loc6_ - 1]];
                  }
                  else
                  {
                     _loc10_ = _loc5_.getSkillBySontype(_loc9_[_loc6_ - 1]);
                  }
                  if(_loc10_)
                  {
                     _loc8_.add("fastkey_" + _loc6_,_loc10_.templateInfo.TemplateId);
                     _loc8_.add("index_" + _loc10_.templateInfo.TemplateId,_loc6_);
                     _loc4_++;
                  }
               }
            }
            _loc6_++;
         }
         return _loc8_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __forceSkillEnable(param1:NotificationEvent) : void
      {
         var _loc2_:* = BattleManager.getInstance().getSelfRoleView();
         if(_loc2_)
         {
            if(view)
            {
               view.setEnableForce(false);
            }
         }
      }
      
      private function get isWatchOnly() : Boolean
      {
         if(BattleManager.getInstance().battleModel.battleType == 35)
         {
            return true;
         }
         if(BattleManager.getInstance().battleModel.battleType == 307)
         {
            return true;
         }
         return false;
      }
      
      private function __skillEnable(param1:NotificationEvent) : void
      {
         if(BattleManager.getInstance().battleModel && BattleManager.getInstance().battleModel.isControledByBoss())
         {
            view.setEnableForce(false);
            return;
         }
         var _loc3_:Boolean = _battleModel.isOver;
         var _loc2_:Boolean = _heroRoleInfo.restricted;
         var _loc4_:* = BattleManager.getInstance().getSelfRoleView();
         var _loc5_:Boolean = _heroRoleInfo.isPetState && _heroRoleInfo.awaken == 0;
         if(_loc3_ || _loc2_ || _loc5_ || isWatchOnly)
         {
            if(_loc4_)
            {
               _loc4_.cancelReadyState();
            }
            view.setEnable(false);
            _useSkillFailed = false;
         }
         else if(param1)
         {
            view.setEnable(param1.data);
            if(!param1.data)
            {
               _useSkillFailed = false;
            }
         }
         else
         {
            view.setEnable(true);
         }
      }
      
      private function restrictChangedHandler(param1:NotificationEvent) : void
      {
         __skillEnable(null);
      }
      
      private function onHeroSpChanged(param1:RoleEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SkillTempInfo = null;
         view.refreshForSpChanged();
         if(param1 && param1.data.buffCause)
         {
            _loc2_ = _battleModel.currentReadySkillId;
            if(_loc2_ != -1)
            {
               _loc3_ = getSkillTempInfoById(_loc2_);
               if(_loc3_ && _loc3_.Cost > _heroRoleInfo.sp && _loc3_.HitPointCost > _heroRoleInfo.hitPoint)
               {
                  view.setEnable(true);
               }
            }
         }
         __bufferEnabeleHandler(null);
      }
      
      private function __onAwkenValueChangeHandler(param1:RoleEvent = null) : void
      {
         if(view)
         {
            if(_heroRoleInfo.isWaitingChangeBody)
            {
               view.setEnable(false);
            }
            view.refreshForAwakenValueChanged();
         }
      }
      
      private function __onHeroHitPointChanged(param1:RoleEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SkillTempInfo = null;
         view.refreshForSpChanged();
         if(param1 && param1.data.buffCause)
         {
            _loc2_ = _battleModel.currentReadySkillId;
            if(_loc2_ != -1)
            {
               _loc3_ = getSkillTempInfoById(_loc2_);
               if(_loc3_ && _loc3_.Cost > _heroRoleInfo.sp && _loc3_.HitPointCost > _heroRoleInfo.hitPoint)
               {
                  view.setEnable(true);
               }
            }
         }
         __bufferEnabeleHandler(null);
      }
      
      public function isMarrSkill(param1:SkillTempInfo) : Boolean
      {
         var _loc3_:HeroRoleInfo = _heroRoleInfo;
         for each(var _loc2_:TrailPropInfo in _loc3_.marrSkills)
         {
            if(_loc2_.id == param1.TemplateId)
            {
               return true;
            }
         }
         return param1.SonType == 10000;
      }
      
      private function __skillUse(param1:NotificationEvent) : void
      {
         var str:String;
         var currentskillId:int;
         var battleId:String;
         var livingID:int;
         var skillInfo:SkillTempInfo;
         var childLivingID:int;
         var timeId:int;
         var item:BattlePropItem;
         var currentProp:TrailPropInfo;
         var event:NotificationEvent = param1;
         if(_heroRoleInfo.isWaitingChangeBody)
         {
            return;
         }
         if(_battleModel.battleType == 3844)
         {
            return;
         }
         if(_battleModel.battleType == 3845)
         {
            return;
         }
         if(_battleModel.battleType == 3847)
         {
            return;
         }
         if(_battleModel.battleType == 16)
         {
            return;
         }
         if(_battleModel.battleType == 3868)
         {
            return;
         }
         if(_battleModel.isChildBattle)
         {
            return;
         }
         str = LanguageMgr.GetTranslation("battle.view.ui.SkillItemListController.str");
         view.setEnable(false);
         battleId = _battleModel.battleId;
         livingID = _heroRoleInfo.livingId;
         if(event.data is SkillTempInfo)
         {
            skillInfo = event.data as SkillTempInfo;
            currentskillId = skillInfo.TemplateId;
            if(isMarrSkill(skillInfo))
            {
               SocketSendManager.instance.sendUseMarrSkill(battleId,livingID,currentskillId);
            }
            else
            {
               if(isChildProfoundSkill(skillInfo))
               {
                  if(_heroChildInfo)
                  {
                     childLivingID = _heroChildInfo.livingId;
                     SocketSendManager.instance.gameChildCommand(battleId,childLivingID,currentskillId);
                     _battleModel.defaultSkillCount = 0;
                  }
                  view.setEnable(true);
                  return;
               }
               if(isStoneTriggerSkill(skillInfo))
               {
                  SocketSendManager.instance.sendUseStoneSkill(battleId,livingID,currentskillId);
               }
               else if(PlayerManager.instance.newbieProcess < 19000)
               {
                  NewbieSocketOutManager.sendBattleContinue();
                  timeId = int(setTimeout(function():void
                  {
                     clearTimeout(timeId);
                     SocketSendManager.instance.gameCommand(battleId,livingID,currentskillId);
                  },400));
               }
               else
               {
                  SocketSendManager.instance.gameCommand(battleId,livingID,currentskillId);
               }
            }
            _battleModel.currentReadySkillId = currentskillId;
            addSkillUsedFlag(skillInfo);
         }
         else if(event.data is BattlePropItem)
         {
            item = BattlePropItem(event.data).clone();
            SocketSendManager.instance.sendUseItemInBattle(battleId,livingID,item.skillTempId);
            _battleModel.currentReadySkillId = item.skillTempId;
            addPropUsedFlag(item);
         }
         else if(event.data is TrailPropInfo)
         {
            currentProp = event.data as TrailPropInfo;
            _battleModel.currentReadySkillId = currentProp.skillTemp.TemplateId;
            addTrailPropUsedFlag(currentProp);
            SocketSendManager.instance.sendUseBattleTrialProp(battleId,currentProp.id,livingID);
         }
         _battleModel.defaultSkillCount = 0;
      }
      
      private function addTrailPropUsedFlag(param1:TrailPropInfo) : void
      {
         var _loc2_:RoleViewBase = BattleManager.getInstance().getSelfRoleView();
         if(_loc2_ && _loc2_.info && _loc2_.info.isLiving)
         {
            _loc2_.addSkillFlagByIconPath(IconFactory.getTecIconByIcon(param1.skillTemp.Icons));
         }
      }
      
      private function addSkillUsedFlag(param1:SkillTempInfo) : void
      {
         var _loc2_:RoleViewBase = BattleManager.getInstance().getSelfRoleView();
         if(_loc2_ && _loc2_.info && _loc2_.info.isLiving)
         {
            _loc2_.addSkillFlag(param1);
         }
      }
      
      private function addPropUsedFlag(param1:BattlePropItem) : void
      {
         var _loc2_:RoleViewBase = BattleManager.getInstance().getSelfRoleView();
         if(_loc2_ && _loc2_.info && _loc2_.info.isLiving)
         {
            _loc2_.addSkillFlagByIconPath(IconFactory.getTecIconByIcon(param1.getSkillTemplate().Icons));
         }
      }
      
      private function __useBattleItemServerBack(param1:SLGSocketEvent) : void
      {
         var _loc3_:RoleViewBase = null;
         var _loc6_:BattlePropItem = null;
         var _loc4_:TrailPropInfo = null;
         var _loc8_:PackageIn = PackageIn(param1.data);
         var _loc2_:ItemUseResultMsg = new ItemUseResultMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as ItemUseResultMsg;
         var _loc5_:int = _loc2_.livingId;
         var _loc7_:HeroRoleInfo = _heroRoleInfo;
         if(_loc2_.result == 0)
         {
            if(_loc5_ == _loc7_.livingId)
            {
               _loc3_ = RoleViewBase(BattleManager.getInstance().battleMap.rolesDict[_loc7_.livingId]);
               _loc6_ = _loc7_.getPropByID(_loc2_.tempId);
               if(_loc6_)
               {
                  _battleModel.currentReadySkillId = _loc6_.skillTempId;
                  _loc6_.useCount = _loc2_.count;
               }
               if(_loc3_.info && _loc3_.info.isLiving)
               {
                  _loc3_.addCollectionEffect();
               }
               if(_loc2_.type == 2)
               {
                  _loc4_ = _loc7_.getTrialPropInfoByIndex(_loc2_.uItemId);
                  _loc4_.useCount = _loc2_.count;
               }
               else if(_loc2_.type == 3)
               {
                  _loc4_ = _loc7_.getMarrSkillInfo(_loc2_.tempId);
                  if(_loc4_)
                  {
                     _loc4_.useCount = _loc2_.count;
                     view.marrSkillItem.setUseCount(_loc2_.count);
                  }
                  if(view.marrSkillItem)
                  {
                     view.marrSkillItem.buttonSkiner.enable = false;
                  }
               }
            }
            else
            {
               _loc3_ = RoleViewBase(BattleManager.getInstance().battleMap.rolesDict[_loc5_]);
               if(_loc3_)
               {
                  if(_loc3_.info && _loc3_.info.isLiving)
                  {
                     _loc3_.addCollectionEffect(false);
                     _loc3_.addSkillFlagByIconPath(IconFactory.getGoodsIconByTID(_loc2_.tempId));
                  }
               }
            }
         }
         else
         {
            if(_loc5_ == _loc7_.livingId)
            {
               _loc3_ = _loc7_.view;
               if(_loc3_)
               {
                  _loc3_.removeSkillFlag();
               }
            }
            view.setEnable(true);
         }
      }
      
      private function removeItem(param1:Object) : void
      {
         var _loc2_:int = skills.indexOf(param1);
         if(_loc2_ > -1)
         {
            skills.splice(_loc2_,1);
            view.removeItemByData(param1);
         }
      }
      
      private function __skillUseServerBack(param1:SLGSocketEvent) : void
      {
         var pkg:PackageIn;
         var msg:HeroOrderMsg;
         var mapRoleDic:Dictionary;
         var selfLivingId:int;
         var roleId:int;
         var skillId:int;
         var result:int;
         var castTime:int;
         var qteTime:int;
         var aims:Array;
         var aimLen:int;
         var i:int;
         var skillInfo:SkillTempInfo;
         var str2:String;
         var heroView:RoleViewBase;
         var flag:Boolean;
         var living:int;
         var delayOpenSkillEnable:*;
         var event:SLGSocketEvent = param1;
         if(BattleManager.getInstance().battleModel.battleType == 3844)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.battleType == 3845)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.battleType == 3847)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.battleType == 3867)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.battleType == 3868)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.battleType == 3866)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.battleType == 3864)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.battleType == 3889)
         {
            return;
         }
         pkg = PackageIn(event.data);
         msg = new HeroOrderMsg();
         msg = pkg.readBody(msg) as HeroOrderMsg;
         mapRoleDic = BattleManager.getInstance().battleMap.rolesDict;
         selfLivingId = _heroRoleInfo.livingId;
         roleId = msg.heroIndexId;
         skillId = msg.skillId;
         result = msg.result;
         castTime = msg.castTime;
         qteTime = 0;
         aims = [];
         aimLen = int(msg.targetIndexs.length);
         i = 0;
         while(i < aimLen)
         {
            aims.push(msg.targetIndexs[i]);
            i = i + 1;
         }
         if(result == 1 && roleId == _heroRoleInfo.livingId)
         {
            str2 = LanguageMgr.GetTranslation("battle.view.ui.SkillItemListController.str2");
         }
         flag = true;
         if(result == 0)
         {
            flag = true;
            skillInfo = getSkillTempInfoById(skillId);
            if(skillInfo && !_battleModel.isAutoFight)
            {
               qteTime = skillInfo.QTETime;
            }
            if(isSelfUseSkill(roleId,selfLivingId))
            {
               _battleModel.currentReadySkillId = skillId;
               heroView = RoleViewBase(mapRoleDic[selfLivingId]);
               if(heroView.info && heroView.info.isLiving)
               {
                  if(!(heroView.info is MonsterRoleInfo))
                  {
                     heroView.addCollectionEffect();
                  }
                  NotificationManager.instance.sendNotification("SHOW_SKILL_USE_SUCCESS_BattleNotic",[skillInfo,qteTime,castTime,aims]);
               }
            }
            else
            {
               heroView = RoleViewBase(mapRoleDic[roleId]);
               if(heroView)
               {
                  if(heroView.info && heroView.info.isLiving)
                  {
                     skillInfo = TempleteManager.instance.getSkillTemplateInfoById(skillId);
                     if(!(heroView.info is MonsterRoleInfo))
                     {
                        heroView.addCollectionEffect(false);
                     }
                     heroView.addSkillFlag(skillInfo);
                  }
               }
               if(_heroChildInfo && _heroChildInfo.livingId == roleId && skillInfo && isChildProfoundSkill(skillInfo))
               {
                  view.setChildDark(true);
               }
            }
            if(_battleModel.isAutoFight && skillInfo && isSelfUseSkill(roleId,selfLivingId))
            {
               addSkillUsedFlag(skillInfo);
            }
         }
         else
         {
            delayOpenSkillEnable = function():void
            {
               if(_useSkillFailed)
               {
                  _useSkillFailed = false;
                  if(view)
                  {
                     if(_heroRoleInfo && _heroRoleInfo.isLiving)
                     {
                        view.setEnable(true);
                     }
                     else if(_heroChildInfo && _heroChildInfo.isLiving)
                     {
                        view.setChildEnable(true);
                     }
                  }
               }
            };
            flag = false;
            _battleModel.currentReadySkillId = -1;
            if(isSelfUseSkill(roleId,selfLivingId))
            {
               _useSkillFailed = true;
               heroView = RoleViewBase(mapRoleDic[selfLivingId]);
               if(heroView)
               {
                  heroView.removeSkillFlag();
               }
               for each(living in aims)
               {
                  heroView = mapRoleDic[living] as RoleViewBase;
                  if(heroView)
                  {
                     heroView.removeSkillAimFlag();
                  }
               }
               TimerUtils.setTimeout(delayOpenSkillEnable,1000);
            }
         }
         if(isSelfUseSkill(roleId,selfLivingId))
         {
            NotificationManager.instance.sendNotification("USE_SKILL_RESULT",{
               "skillId":skillId,
               "result":flag
            });
         }
      }
      
      private function isSelfUseSkill(param1:int, param2:int) : Boolean
      {
         if(param1 == param2 && BattleManager.getInstance().battleModel.battleType != 307)
         {
            return true;
         }
         return false;
      }
      
      private function getSkillTempInfoById(param1:int) : SkillTempInfo
      {
         var _loc3_:* = null;
         var _loc2_:Array = skills.concat(petSkills);
         _loc2_.push.apply(null,awakenSkills);
         for each(var _loc4_:Object in _loc2_)
         {
            if(_loc4_)
            {
               if(_loc4_ is SkillTempInfo)
               {
                  if(_loc4_.TemplateId == param1 || _battleModel.isAutoFight && _loc4_.Parameter3 == param1)
                  {
                     return _loc4_ as SkillTempInfo;
                  }
               }
               else if(_loc4_ is BattlePropItem)
               {
                  if(_loc4_.skillTempId == param1)
                  {
                     return _loc4_.getSkillTemplate();
                  }
               }
            }
         }
         if(_heroRoleInfo && _heroRoleInfo.heroInfo && _heroRoleInfo.heroInfo.isAvenger)
         {
            if(_heroRoleInfo.avengerFightSkills.indexOf(param1) != -1)
            {
               return TempleteManager.instance.skillTemplateDic[param1];
            }
         }
         return _loc3_;
      }
      
      private function __cleanSkillSelect(param1:Event) : void
      {
         var _loc2_:RoleViewBase = _heroRoleInfo.view;
         if(_loc2_)
         {
            _loc2_.removeCollectionEffect();
            _loc2_.removeSkillFlag();
         }
         for each(var _loc3_:RoleViewBase in BattleManager.getInstance().battleMap.rolesDict)
         {
            _loc3_.removeSkillAimFlag();
         }
      }
      
      private function __updateMarrSkillItemHandler(param1:Event) : void
      {
         if(_heroMarrayInfo)
         {
            _heroMarrayInfo.removeEventListener("die",__heroMarrayInfoDieHandler);
            _heroMarrayInfo.removeEventListener("isLiving",__heroMarrayInfoDieHandler);
         }
         updateMarrSkillItem();
         if(_heroMarrayInfo)
         {
            _heroMarrayInfo = _heroRoleInfo.getMarrObject();
         }
         if(_heroMarrayInfo)
         {
            _heroMarrayInfo.addEventListener("die",__heroMarrayInfoDieHandler);
            _heroMarrayInfo.addEventListener("isLiving",__heroMarrayInfoDieHandler);
         }
      }
      
      private function __heroMarrayInfoDieHandler(param1:RoleEvent) : void
      {
         updateMarrSkillItem();
      }
      
      public function updateMarrSkillItem() : void
      {
         if(!MarryManager.instance.model.isMarry)
         {
            view.marrSkillItem.buttonSkiner.enable = false;
            view.marrSkillItem.setState(4);
            view.marrSkillItem.lock();
            return;
         }
         var _loc1_:HeroRoleInfo = _heroRoleInfo;
         if(!_loc1_)
         {
            return;
         }
         var _loc3_:HeroRoleInfo = _loc1_.getMarrObject();
         var _loc2_:TrailPropInfo = _loc1_.getActiveMarrSkillInfo();
         if(_loc2_ && _loc2_.useCount > 0 && _loc3_ != null && _loc3_.isLiving && !view.marrSkillItem.bufferUnEnable)
         {
            view.marrSkillItem.buttonSkiner.enable = view.enable;
            view.marrSkillItem.setState(0);
         }
         else
         {
            view.marrSkillItem.buttonSkiner.enable = false;
            view.marrSkillItem.setState(1);
         }
         if(_loc2_)
         {
            view.marrSkillItem.setUseCount(_loc2_.useCount);
         }
      }
      
      private function __heroChildInfoDieHandler(param1:RoleEvent) : void
      {
         updateChildSkillItem();
      }
      
      public function updateChildSkillItem() : void
      {
         if(_battleModel.selfHero.replaceSkillInfo == null && !getEnterWarChild())
         {
            view.childSkillItem.buttonSkiner.enable = false;
            view.childSkillItem.setState(4);
            view.childSkillItem.lock();
            view.childSkillItem2.buttonSkiner.enable = false;
            view.childSkillItem2.setState(4);
            view.childSkillItem2.lock();
            return;
         }
         var _loc1_:HeroRoleInfo = _heroRoleInfo;
         if(!_loc1_)
         {
            return;
         }
         if(_heroChildInfo != null && _heroChildInfo.isLiving && _heroChildInfo.awaken >= 100 && !view.childSkillItem.bufferUnEnable)
         {
            if(childSkillDark)
            {
               view.childSkillItem.buttonSkiner.enable = false;
               view.childSkillItem.setState(2);
               view.childSkillItem2.buttonSkiner.enable = false;
               view.childSkillItem2.setState(2);
            }
            else
            {
               view.childSkillItem.buttonSkiner.enable = true;
               view.childSkillItem.setState(0);
               view.childSkillItem2.buttonSkiner.enable = true;
               view.childSkillItem2.setState(0);
            }
         }
         else
         {
            childSkillDark = false;
            view.childSkillItem.buttonSkiner.enable = false;
            view.childSkillItem.setState(1);
            view.childSkillItem2.buttonSkiner.enable = false;
            view.childSkillItem2.setState(1);
         }
         if(_battleModel.battleType == 3880 || _battleModel.battleType == 3883 || _battleModel.battleType == 3887)
         {
            view.childSkillItem.visible = view.childSkillItem2.visible = false;
         }
      }
      
      private function __bufferEnabeleHandler(param1:NotificationEvent) : void
      {
         for each(var _loc2_:BattleSkillItemII in view.skillItemViews)
         {
            bufferEnabeleItemHandler(_loc2_);
         }
      }
      
      private function bufferEnabeleItemHandler(param1:BattleSkillItemII) : void
      {
         var _loc7_:SkillTempInfo = null;
         var _loc3_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc8_:Boolean = false;
         if(param1.isLock)
         {
            return;
         }
         var _loc5_:Object = param1.data;
         var _loc4_:HeroRoleInfo = _heroRoleInfo;
         if(_loc5_ is SkillTempInfo)
         {
            _loc7_ = _loc5_ as SkillTempInfo;
            param1.bufferUnEnable = _loc4_.existUnenableSkillBuffer(_loc7_.TemplateId);
            if(param1.bufferUnEnable)
            {
               param1.buttonSkiner.enable = false;
               param1.setState(1);
               param1.addChild(param1.banImg);
            }
            else
            {
               _loc3_ = _loc4_.sp + _loc7_.Cost >= 0 && _loc4_.hitPoint + _loc7_.HitPointCost >= 0;
               _loc6_ = _battleModel.currentReadySkillId != -1;
               _loc2_ = _battleModel.battleType == 25;
               _loc8_ = _loc4_.bloodA <= 0;
               if(param1.banImg.parent)
               {
                  param1.removeChild(param1.banImg);
               }
               if(_loc8_ || _loc6_ || !_loc3_ || _loc2_)
               {
                  return;
               }
               param1.buttonSkiner.enable = true;
               param1.setState(0);
               if(param1 == view.marrSkillItem)
               {
                  updateMarrSkillItem();
               }
               if(param1 == view.childSkillItem || param1 == view.childSkillItem2)
               {
                  updateChildSkillItem();
               }
            }
         }
      }
      
      public function dispose() : void
      {
         NotificationManager.instance.removeEventListener("SKILL_ENABLE",__skillEnable);
         NotificationManager.instance.removeEventListener("FORCE_SKILL_ENABLE",__forceSkillEnable);
         NotificationManager.instance.removeEventListener("ACTION_SKILL_BattleNotic",__skillUse);
         NotificationManager.instance.removeEventListener("RESET_ACTION_TIME_BattleNotic",__cleanSkillSelect);
         NotificationManager.instance.removeEventListener("restrictChanged",restrictChangedHandler);
         NotificationManager.instance.removeEventListener("skillCd",onSkillCdHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 75,__skillUseServerBack);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 158,__useBattleItemServerBack);
         NotificationManager.instance.removeEventListener("BattleModelNotic.ADD_ROLE",__updateMarrSkillItemHandler);
         NotificationManager.instance.removeEventListener("BattleModelNotic.REMOVE_ROLE",__updateMarrSkillItemHandler);
         NotificationManager.instance.removeEventListener("BUFFER_SKILL_ENABLE",__bufferEnabeleHandler);
         if(_heroRoleInfo)
         {
            _heroRoleInfo.removeEventListener("sp",onHeroSpChanged);
            _heroRoleInfo.removeEventListener("AWAKEN",__onAwkenValueChangeHandler);
            _heroRoleInfo.removeEventListener("HIT_POINT",__onHeroHitPointChanged);
         }
         if(_heroMarrayInfo)
         {
            _heroMarrayInfo.removeEventListener("die",__heroMarrayInfoDieHandler);
            _heroMarrayInfo.removeEventListener("isLiving",__heroMarrayInfoDieHandler);
         }
         if(_heroChildInfo)
         {
            _heroChildInfo.removeEventListener("die",__heroChildInfoDieHandler);
            _heroChildInfo.removeEventListener("AWAKEN",__heroChildInfoDieHandler);
            _heroChildInfo.removeEventListener("isLiving",__heroChildInfoDieHandler);
         }
         KeyboardManager.getInstance().removeEventListener("keyUp",onKeyUp);
         view = null;
         skills = null;
         _heroRoleInfo = null;
      }
      
      public function get childSkillDark() : Boolean
      {
         return _childSkillDark;
      }
      
      public function set childSkillDark(param1:Boolean) : void
      {
         _childSkillDark = param1;
      }
      
      private function getTalentTempId(param1:String) : int
      {
         var _loc2_:int = 0;
         var _loc5_:SkillTempInfo = null;
         var _loc4_:int = 0;
         if(param1 == null || param1 == "")
         {
            return 0;
         }
         var _loc3_:Array = param1.split(",");
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = TempleteManager.instance.getSkillTemplateInfoById(int(_loc3_[_loc4_]));
            if(!(!_loc5_ || SkillData.SKILL_SONTYPE_TALENT_ARR.indexOf(_loc5_.SonType) == -1))
            {
               _loc2_ = int(_loc3_[_loc4_]);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function get dragonModel() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
   }
}

