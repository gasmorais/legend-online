package yishi.manager
{
   import battle.events.BattleEvent;
   import battle.utils.Int64Utils;
   import com.road.pb.helper.army.ThaneInfoHelper;
   import com.road.yishi.proto.army.ArmyEditRspMsg;
   import com.road.yishi.proto.army.ArmyMsg;
   import com.road.yishi.proto.army.ArmyPawnInfoMsg;
   import com.road.yishi.proto.army.ArmyPawnUpdatedMsg;
   import com.road.yishi.proto.army.HeroFastKeyMsg;
   import com.road.yishi.proto.army.HeroRuneInfoMsg;
   import com.road.yishi.proto.army.HeroRuneMsg;
   import com.road.yishi.proto.army.HeroRuneOpMsg;
   import com.road.yishi.proto.army.HeroTalentMsg;
   import com.road.yishi.proto.army.LotteryRuneRspMsg;
   import com.road.yishi.proto.army.SimpleHeroInfoMsg;
   import com.road.yishi.proto.army.TalentUpGradeMsg;
   import com.road.yishi.proto.army.UpdatedSkillMsg;
   import com.road.yishi.proto.battle.TriggerSkillListMsg;
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import com.road.yishi.proto.fate.FateInfoMsg;
   import com.road.yishi.proto.fate.FateListMsg;
   import com.road.yishi.proto.tattoo.TattooEnhanceListMsg;
   import com.road.yishi.proto.tattoo.TattooEnhanceMsg;
   import com.road.yishi.proto.tattoo.TattooHoleMsg;
   import com.road.yishi.proto.tattoo.TattooHoleRspMsg;
   import events.ArmyEvent;
   import events.TalentEvent;
   import flash.events.EventDispatcher;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import map.internals.utils.SocketGameReader;
   import map.space.SpaceManager;
   import map.space.SpaceModel;
   import map.space.data.SpaceArmy;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.armyII.RuneInfo;
   import mvc.module.armyII.SkillInfo;
   import mvc.module.armyII.StoneLotterInfo;
   import mvc.module.armyII.UserArmy;
   import mvc.module.faterotary.FateRotarySkillInfo;
   import mvc.module.tattoo.TattooHole;
   import mvc.module.tattoo.TattooHoleInfoII;
   import mvc.module.tattoo.TattooModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.TalentData;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.RuneTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.events.ServiceReceiveEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.MessageTipManager;
   
   public class ArmyManager extends EventDispatcher
   {
      
      private static var _instance:ArmyManager;
      
      private var _openCurrPage:int = 1;
      
      public var army:UserArmy;
      
      public var castlePawnList:SimpleDictionary;
      
      public var casernPawnList:SimpleDictionary;
      
      public var fashionList:SimpleDictionary;
      
      public var dragonFashionList:SimpleDictionary;
      
      public var fashionInfoMsg:FashionInfoMsg;
      
      public var stoneTriggerSkill:Array = [];
      
      private var _isSorted:Boolean;
      
      private const pawnCount:int = 11;
      
      public function ArmyManager()
      {
         super();
         army = new UserArmy();
         castlePawnList = new SimpleDictionary(true);
         casernPawnList = new SimpleDictionary(true);
         fashionList = new SimpleDictionary(true);
         dragonFashionList = new SimpleDictionary(true);
      }
      
      public static function get instance() : ArmyManager
      {
         if(!_instance)
         {
            _instance = new ArmyManager();
         }
         return _instance;
      }
      
      public function get openCurrPage() : int
      {
         return _openCurrPage;
      }
      
      public function set openCurrPage(param1:int) : void
      {
         _openCurrPage = param1;
      }
      
      public function get isSorted() : Boolean
      {
         return _isSorted;
      }
      
      public function set isSorted(param1:Boolean) : void
      {
         if(_isSorted == param1)
         {
            return;
         }
         _isSorted = param1;
         dispatchEvent(new ArmyEvent("SORT_PAWN",null));
      }
      
      private function initPawnList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ArmyPawn = null;
         _loc1_ = 1;
         while(_loc1_ <= 11)
         {
            _loc2_ = new ArmyPawn();
            if(_loc1_ < 10)
            {
               _loc2_.templateId = int("10" + _loc1_ + "01");
            }
            else
            {
               _loc2_.templateId = int("1" + _loc1_ + "01");
            }
            casernPawnList.add(_loc2_.templateInfo.SonType,_loc2_);
            castlePawnList.add(_loc2_.templateInfo.SonType,_loc2_);
            _loc1_++;
         }
      }
      
      public function setup() : void
      {
         initPawnList();
         SocketManager.instance.addEventListener("SLGSocketEvent" + 150,__getArmyListHandler);
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 100,__recievePawnListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 92,__recievePawnListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 93,__armypawnUpdateHander);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 116,__pawnLeveupHandler);
         SocketManager.instance.addEventListener("UPDTAE_ARMY",__updateArmyHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 113,__uHeroInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 64,__fastKeySetHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 60,__skillUpgradeHandlker);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 61,__skillResetHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4430,__talentGradeUpHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4431,__changeTalentInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4495,__runeOperateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4527,__runeResetHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4544,__fateGuardListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 274,__tattooHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 301,__fashionHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 346,__tattooEnhanceDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 539,_runeGetStoneHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 541,_stoneTriggerSkill);
      }
      
      private function _stoneTriggerSkill(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TriggerSkillListMsg = new TriggerSkillListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TriggerSkillListMsg;
         stoneTriggerSkill = _loc2_.skills;
         NotificationManager.instance.dispatchEvent(new BattleEvent("BATTLE_STONETRIGGER",stoneTriggerSkill));
      }
      
      private function _runeGetStoneHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:LotteryRuneRspMsg = new LotteryRuneRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as LotteryRuneRspMsg;
         var _loc4_:StoneLotterInfo = thane.runeCate.stoneLotterInfo;
         _loc4_.powerPointNum = _loc2_.powerPointNum;
         _loc4_.runeChipNum = _loc2_.runeChipNum;
         _loc4_.runePointNum = _loc2_.runePointNum;
         _loc4_.leftTime = _loc2_.leftTime;
         if(_loc2_.hasTenSpotCount)
         {
            _loc4_.tenSpotCount = _loc2_.tenSpotCount;
         }
         if(_loc2_.hasItems)
         {
            _loc4_.items = _loc2_.items;
         }
         dispatchEvent(new ArmyEvent("STONE_GET_CHANGE",null));
      }
      
      private function __getArmyListHandler(param1:SLGSocketEvent) : void
      {
         __recieveArmyHandler(param1);
         initEvent();
         dispatchEvent(new ArmyEvent("RECIEVED_ARMY",null));
      }
      
      private function __recieveArmyHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:ArmyPawn = null;
         var _loc5_:ThaneInfo = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArmyMsg = new ArmyMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as ArmyMsg;
         SocketGameReader.readArmyInfo(army,_loc2_);
         _loc6_ = 0;
         while(_loc6_ < _loc2_.armyPawn.length)
         {
            _loc4_ = (_loc2_.armyPawn[_loc6_] as ArmyPawnInfoMsg).sites;
            _loc3_ = (_loc2_.armyPawn[_loc6_] as ArmyPawnInfoMsg).sonType;
            _loc8_ = army.getPawnByIndex(_loc4_);
            if(getCasernPawn(_loc3_))
            {
               _loc8_.canRecruit = true;
            }
            SocketGameReader.readArmyPawnInfo(army,_loc2_.armyPawn[_loc6_] as ArmyPawnInfoMsg);
            _loc6_++;
         }
         if(_loc2_.hasSimpleHeroInfo)
         {
            _loc5_ = army.baseHero;
            _loc5_.consortiaID = _loc2_.consortiaId;
            _loc5_.consortiaName = _loc2_.consortiaName;
            if(_loc2_.hasFightingCapacity)
            {
               _loc5_.fightingCapacity = _loc2_.fightingCapacity;
               PlayerManager.instance.currentPlayerModel.playerInfo.fightingCapacity = _loc2_.fightingCapacity;
            }
            ThaneInfoHelper.readHeroInfo(_loc5_,_loc2_.simpleHeroInfo,_loc2_);
         }
         army.commit();
      }
      
      private function __recievePawnListHandler(param1:SLGSocketEvent) : void
      {
         var _loc10_:Boolean = false;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc11_:ArmyPawn = null;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArmyPawnUpdatedMsg = new ArmyPawnUpdatedMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as ArmyPawnUpdatedMsg;
         var _loc6_:int = int(_loc2_.armyPawn.length);
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc7_ = int(ArmyPawnInfoMsg(_loc2_.armyPawn[_loc8_]).armyId);
            _loc4_ = int(ArmyPawnInfoMsg(_loc2_.armyPawn[_loc8_]).sites);
            _loc3_ = int(ArmyPawnInfoMsg(_loc2_.armyPawn[_loc8_]).sonType);
            _loc5_ = int(ArmyPawnInfoMsg(_loc2_.armyPawn[_loc8_]).tempateId);
            _loc11_ = getCasernPawn(_loc3_);
            if(!_loc11_)
            {
               _loc11_ = getCastlePawn(_loc5_,_loc3_);
            }
            _loc11_.templateId = _loc5_;
            SocketGameReader.readPawnInfo(_loc11_,ArmyPawnInfoMsg(_loc2_.armyPawn[_loc8_]));
            if(_loc11_.ownPawns <= 0)
            {
               _loc10_ = true;
            }
            _loc8_++;
         }
         if(_loc10_)
         {
            dispatchEvent(new ArmyEvent("ARMY_PAWN_CHANGE",null));
         }
      }
      
      private function __armypawnUpdateHander(param1:SLGSocketEvent) : void
      {
         var _loc5_:ArmyPawn = null;
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArmyEditRspMsg = new ArmyEditRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ArmyEditRspMsg;
         if(_loc2_.armyPawn.length == 0)
         {
            _loc5_ = army.getPawnByIndex(0);
            if(_loc5_)
            {
               army.removeArmyPawnCountByIndex(0,_loc5_.ownPawns);
            }
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.armyPawn.length)
         {
            SocketGameReader.readArmyPawnInfo(army,_loc2_.armyPawn[_loc3_] as ArmyPawnInfoMsg);
            _loc3_++;
         }
         army.commit();
      }
      
      private function __pawnLeveupHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:ArmyPawn = new ArmyPawn();
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArmyPawnInfoMsg = new ArmyPawnInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ArmyPawnInfoMsg;
         _loc5_.templateId = _loc2_.tempateId;
         _loc5_.tempSpecial = _loc2_.comprehednTempIds;
         _loc5_.specialAbility = _loc2_.specialTempIds;
         _loc5_.blessNum = _loc2_.blessNum;
         var _loc3_:int = _loc2_.sonType;
         synchronizationAllArmyPawns(_loc5_);
         dispatchEvent(new ServiceReceiveEvent("upgrade_pawn_success",true,_loc3_));
      }
      
      private function __updateArmyHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:BaseArmy = null;
         var _loc7_:SpaceArmy = null;
         var _loc5_:ArmyMsg = param1.data as ArmyMsg;
         var _loc4_:int = _loc5_.armyId;
         var _loc6_:int = _loc5_.playerId;
         if(_loc6_ == thane.userId && (army.id == 0 || _loc4_ == army.id))
         {
            _loc3_ = army;
            if(!_loc3_)
            {
               return;
            }
         }
         else
         {
            _loc3_ = new UserArmy();
            _loc3_.id = _loc4_;
            _loc3_.userId = _loc6_;
         }
         _loc3_ = ThaneInfoHelper.readOuterCityArmyInfo(_loc3_,_loc5_);
         var _loc2_:SpaceModel = SpaceManager.instance.model;
         if(_loc2_)
         {
            _loc7_ = _loc2_.getUserArmyByUserId(_loc3_.userId);
            if(_loc7_)
            {
               _loc7_.state = _loc5_.state;
            }
         }
         if(_loc3_.type == 4 || _loc3_.type == 5 || _loc3_.type == 2)
         {
            NotificationManager.instance.sendNotification("$UPDTAE_ARMY",_loc3_);
         }
      }
      
      private function __uHeroInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc3_:SimpleHeroInfoMsg = new SimpleHeroInfoMsg();
         _loc3_ = _loc4_.readBody(_loc3_) as SimpleHeroInfoMsg;
         var _loc2_:Boolean = false;
         if(_loc3_.hasTempateId && thane.templateId != _loc3_.tempateId)
         {
            _loc2_ = true;
            thane.canChangeHeadId = false;
         }
         ThaneInfoHelper.readHeroInfo(thane,_loc3_);
         thane.canChangeHeadId = true;
      }
      
      private function __skillUpgradeHandlker(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:SkillInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:UpdatedSkillMsg = new UpdatedSkillMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as UpdatedSkillMsg;
         var _loc5_:int = _loc2_.type;
         if(_loc5_ == 0)
         {
            _loc4_ = _loc2_.templateId;
            _loc3_ = _loc2_.index;
            _loc7_ = thane.skillCate.allSkillList[_loc3_];
            if(_loc4_ != 0)
            {
               _loc7_.templateId = _loc4_;
               _loc7_.grade = _loc7_.templateInfo.Grades;
               _loc7_.commit();
            }
            else if(_loc7_)
            {
               _loc7_.reset();
            }
            NotificationManager.instance.sendNotification("SKILL_UPGRADE",_loc7_);
         }
         else if(_loc5_ == 1)
         {
            _loc4_ = _loc2_.templateId;
            _loc3_ = _loc2_.index;
            _loc7_ = thane.talentData.allTalentList[_loc3_];
            if(_loc4_ != 0)
            {
               _loc7_.templateId = _loc4_;
               _loc7_.grade = _loc7_.templateInfo.Grades;
               _loc7_.commit(1);
            }
            else if(_loc7_)
            {
               _loc7_.reset();
            }
            NotificationManager.instance.sendNotification("TALENT_UPGRADE",_loc7_);
         }
      }
      
      private function __skillResetHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:UpdatedSkillMsg = new UpdatedSkillMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as UpdatedSkillMsg;
         var _loc4_:int = _loc2_.type;
         if(_loc4_ == 0)
         {
            if(_loc2_.resetResult)
            {
               for each(_loc7_ in thane.skillCate.allSkillList)
               {
                  _loc7_.reset();
               }
               if(thane.isChangeJob)
               {
                  if(thane.skillCate.allSkillList[1] as SkillInfo)
                  {
                     (thane.skillCate.allSkillList[1] as SkillInfo).grade = 1;
                  }
                  if(thane.skillCate.allSkillList[2] as SkillInfo)
                  {
                     (thane.skillCate.allSkillList[2] as SkillInfo).grade = 1;
                  }
               }
               NotificationManager.instance.sendNotification("SKILL_RESET",null);
            }
         }
         else if(_loc4_ == 1)
         {
            if(_loc2_.resetResult)
            {
               thane.talentData.talentScript = "";
               if(thane.isChangeJob)
               {
                  thane.talentData.talentScript = thane.templateInfo.Job + "00199,";
               }
               for each(_loc6_ in thane.talentData.allTalentList)
               {
                  if(!TalentData.isAdvTalent(_loc6_.templateInfo.MasterType))
                  {
                     _loc6_.reset();
                  }
               }
               NotificationManager.instance.sendNotification("TALENT_RESET",null);
            }
         }
         else if(_loc4_ == 2)
         {
            if(_loc2_.resetResult)
            {
               thane.talentData.advTalentScript = "";
               for each(_loc3_ in thane.talentData.allTalentList)
               {
                  if(TalentData.isAdvTalent(_loc3_.templateInfo.MasterType))
                  {
                     _loc3_.reset();
                  }
               }
               NotificationManager.instance.sendNotification("TALENT_RESET",null);
            }
         }
      }
      
      private function __fastKeySetHandler(param1:SLGSocketEvent) : void
      {
         var e:SLGSocketEvent = param1;
         var pkg:PackageIn = e.data as PackageIn;
         var msg:HeroFastKeyMsg = new HeroFastKeyMsg();
         msg = pkg.readBody(msg) as HeroFastKeyMsg;
         var thaneInfo:ThaneInfo = thane;
         thaneInfo.skillCate.fastKey = msg.fastKey;
         setTimeout(function():void
         {
            NotificationManager.instance.sendNotification("SKILL_UPGRADE");
         },900);
         if(thane.grades <= 10)
         {
            thane.skillCate.refreshAllSkill();
         }
      }
      
      protected function __changeTalentInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:ThaneInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:HeroTalentMsg = new HeroTalentMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as HeroTalentMsg;
         _loc3_ = thane;
         if(_loc3_.userId == _loc2_.userId)
         {
            _loc3_.talentData.talentPoint = _loc2_.talentPoint;
            _loc3_.talentData.talentGrade = _loc2_.talentGrade;
            _loc3_.talentData.advTalentPoint = _loc2_.advancedTalentPoint;
            _loc3_.talentData.advTalentGrade = _loc2_.advancedTalentGrade;
            InfoTipsManager.instance.dealData(14);
         }
      }
      
      protected function __talentGradeUpHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TalentUpGradeMsg = new TalentUpGradeMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TalentUpGradeMsg;
         if(_loc2_.upresult)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("army.talent.TalentGradeUpSucc"));
            dispatchEvent(new TalentEvent("TALENT_GRADUP_SUCC",null));
         }
      }
      
      protected function __runeOperateHandler(param1:SLGSocketEvent) : void
      {
         var _loc8_:HeroRuneMsg = null;
         var _loc3_:String = null;
         var _loc5_:int = 0;
         var _loc10_:HeroRuneInfoMsg = null;
         var _loc11_:RuneInfo = null;
         var _loc4_:RuneTemplateInfo = null;
         var _loc6_:RuneInfo = null;
         var _loc7_:int = 0;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:HeroRuneOpMsg = new HeroRuneOpMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as HeroRuneOpMsg;
         if(_loc2_.count)
         {
            PlayerManager.instance.currentPlayerModel.playerInfo.diamondIndex = _loc2_.count;
         }
         if(_loc2_.opResult)
         {
            _loc8_ = _loc2_.runeInfo as HeroRuneMsg;
            if(_loc2_.opType == 3)
            {
               thane.runeCate.runeScript = _loc8_.runeKey;
               NotificationManager.instance.sendNotification("DOUBLE_KEY_CHANGE");
            }
            else
            {
               if(_loc2_.opType == 1)
               {
                  _loc3_ = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneStudyTipTxt");
                  MessageTipManager.instance().show(_loc3_);
               }
               else if(_loc2_.opType == 4)
               {
                  if(_loc8_.hasRuneKey)
                  {
                     thane.runeCate.runeScript = _loc8_.runeKey;
                  }
               }
               _loc5_ = int(_loc8_.runeinfo.length);
               _loc7_ = 0;
               while(_loc7_ < _loc5_)
               {
                  _loc10_ = _loc8_.runeinfo[_loc7_] as HeroRuneInfoMsg;
                  _loc4_ = TempleteManager.instance.getRuneTemplateByTid(_loc10_.runeId);
                  _loc11_ = thane.runeCate.getInfoByIndex(_loc4_.RuneIndex);
                  if(_loc11_)
                  {
                     if(_loc10_.hasBaseProperties)
                     {
                        _loc11_.baseProperties.readData(_loc10_.baseProperties);
                     }
                     if(_loc11_.templateInfo != _loc4_ || _loc11_.grade != _loc4_.RuneGrade || _loc11_.runeCurGp != _loc10_.runeGp || _loc11_.runeHole != _loc10_.runeHole || _loc11_.runeTempHole != _loc10_.tempHole || _loc11_.newSkillTempId != _loc10_.newSkillTempId || _loc11_.baseProperties.isChange)
                     {
                        _loc11_.grade = _loc4_.RuneGrade;
                        _loc11_.runeId = _loc10_.runeId;
                        _loc11_.runeCurGp = _loc10_.runeGp;
                        _loc11_.swallowCount = _loc10_.swallowCount;
                        _loc11_.runeHole = _loc10_.runeHole;
                        if(_loc11_.runeHole != null && _loc11_.runeHole != "")
                        {
                           thane.runeStoneOpen = true;
                        }
                        _loc11_.runeTempHole = _loc10_.tempHole;
                        _loc11_.newSkillTempId = _loc10_.newSkillTempId;
                        _loc11_.commit();
                        _loc6_ = _loc11_;
                     }
                     else
                     {
                        NotificationManager.instance.sendNotification("RUNE_NO_CHANGE",null);
                     }
                  }
                  _loc7_++;
               }
               NotificationManager.instance.sendNotification("RUNE_UPGRADE",_loc6_);
            }
         }
      }
      
      protected function __runeResetHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:RuneInfo = null;
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc3_:Array = thane.runeCate.allRuneList.getList();
         var _loc2_:int = int(_loc3_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc6_ = _loc3_[_loc4_] as RuneInfo;
            if(_loc6_)
            {
               _loc6_.swallowCount = 0;
               _loc6_.commit();
            }
            _loc4_++;
         }
         NotificationManager.instance.sendNotification("RUNE_UPGRADE",null);
      }
      
      protected function __fateGuardListHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:FateRotarySkillInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:FateListMsg = new FateListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as FateListMsg;
         for each(var _loc3_:FateInfoMsg in _loc2_.fateInfo)
         {
            _loc5_ = thane.getFateGuardSkill(_loc3_.fateTypes);
            if(!_loc5_)
            {
               _loc5_ = new FateRotarySkillInfo();
               thane.fateRotarySkillList.push(_loc5_);
            }
            _loc5_.fateTypes = _loc3_.fateTypes;
            _loc5_.templateId = _loc3_.templateId;
            _loc5_.grades = _loc3_.grades;
            _loc5_.totalGp = Int64Utils.int64ToNumber(_loc3_.totalGp);
            _loc5_.property1 = _loc3_.property1;
            _loc5_.property2 = _loc3_.property2;
            if(_loc3_.fateTypes == 2000)
            {
               PlayerManager.instance.currentPlayerModel.faterotaryCount = _loc3_.turnCount;
            }
            else if(_loc3_.fateTypes == 2200)
            {
               PlayerManager.instance.currentPlayerModel.faterotaryCount1 = _loc3_.turnCount;
            }
            else if(_loc3_.fateTypes == 2100)
            {
               PlayerManager.instance.currentPlayerModel.faterotaryCount2 = _loc3_.turnCount;
            }
         }
      }
      
      public function get thane() : ThaneInfo
      {
         return army.baseHero;
      }
      
      public function get vice() : ThaneInfo
      {
         return army.viceHero;
      }
      
      public function getTotalPawnsNumberBySonType(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:ArmyPawn = army.armyPawns[0];
         var _loc4_:ArmyPawn = castlePawnList[param1];
         if(_loc3_ && _loc3_.templateId > 0)
         {
            if(_loc3_.templateInfo.SonType == param1)
            {
               _loc2_ += _loc3_.ownPawns;
            }
         }
         if(_loc4_)
         {
            _loc2_ += _loc4_.ownPawns;
         }
         return _loc2_;
      }
      
      public function getCasernPawn(param1:int) : ArmyPawn
      {
         var _loc2_:ArmyPawn = casernPawnList[param1];
         if(_loc2_)
         {
            _loc2_.canRecruit = true;
         }
         return _loc2_;
      }
      
      public function getCasernPawnByMastertype(param1:int) : ArmyPawn
      {
         for each(var _loc2_:ArmyPawn in casernPawnList)
         {
            if(_loc2_.templateInfo.MasterType == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getCastlePawn(param1:int, param2:int) : ArmyPawn
      {
         var _loc3_:ArmyPawn = castlePawnList[param2];
         if(!_loc3_)
         {
            _loc3_ = new ArmyPawn();
            _loc3_.templateId = param1;
            castlePawnList.add(_loc3_.templateInfo.SonType,_loc3_);
         }
         return _loc3_;
      }
      
      public function getPawnById(param1:int) : ArmyPawn
      {
         for each(var _loc2_:ArmyPawn in castlePawnList)
         {
            if(_loc2_.templateId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function addPawnCountById(param1:int, param2:int) : void
      {
         for each(var _loc3_:ArmyPawn in castlePawnList)
         {
            if(_loc3_.templateId == param1)
            {
               _loc3_.ownPawns += param2;
               _loc3_.commit();
            }
         }
         dispatchEvent(new ArmyEvent("ARMY_PAWN_CHANGE",null));
      }
      
      public function removePawnCountById(param1:int, param2:int) : void
      {
         for each(var _loc3_:ArmyPawn in castlePawnList)
         {
            if(_loc3_.templateId == param1)
            {
               _loc3_.ownPawns -= param2;
               _loc3_.commit();
            }
         }
         dispatchEvent(new ArmyEvent("ARMY_PAWN_CHANGE",null));
      }
      
      public function checkCanUpgraeSeriaPawn() : Boolean
      {
         if(army.getPawnByIndex(0).templateId == 0)
         {
            return false;
         }
         if(army.getPawnByIndex(0).templateInfo.NextLevelTemplateId == 0)
         {
            return false;
         }
         return army.getPawnByIndex(0).templateInfo.Level < thane.grades - 3;
      }
      
      public function checkCanUpgraeMaxLevelPawn() : Boolean
      {
         var _loc1_:ArmyPawn = null;
         for each(var _loc2_:ArmyPawn in casernPawnList)
         {
            if(!_loc1_)
            {
               _loc1_ = _loc2_;
            }
            if(_loc1_.templateInfo.Level < _loc2_.templateInfo.Level)
            {
               _loc1_ = _loc2_;
            }
         }
         return _loc1_.templateInfo.Level < thane.grades - 3 && _loc1_.templateInfo.NextLevelTemplateId > 0;
      }
      
      public function canUpgradePawn(param1:ArmyPawn) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.templateInfo.NextLevelTemplateId != 0)
         {
            return true;
         }
         return false;
      }
      
      public function synchronizationAllArmyPawns(param1:ArmyPawn) : void
      {
         var _loc2_:ArmyPawn = getCastlePawn(param1.templateId,param1.templateInfo.SonType);
         if(_loc2_)
         {
            _loc2_.synchronization(param1);
            _loc2_.commit();
         }
         army.synchronizationAllPawn(param1);
      }
      
      public function getFateRotarySkillList() : void
      {
         var _loc1_:PackageOut = new PackageOut(8628);
         SocketSendManager.instance.send(_loc1_);
      }
      
      protected function __tattooHandler(param1:SLGSocketEvent) : void
      {
         var _loc9_:* = null;
         var _loc8_:Array = null;
         var _loc3_:TattooHole = null;
         var _loc5_:TattooHoleMsg = null;
         var _loc10_:TattooHole = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:TattooHoleRspMsg = new TattooHoleRspMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as TattooHoleRspMsg;
         var _loc6_:int = 0;
         FrameControllerManager.instance.tattooController.tattooModel.lastOpType = _loc2_.opType;
         if(_loc2_.opType == 1 || FrameControllerManager.instance.tattooController.tattooModel.holes == null)
         {
            _loc8_ = [];
            for each(var _loc4_:TattooHoleMsg in _loc2_.holeInfo)
            {
               _loc3_ = new TattooHole();
               _loc3_.index = _loc6_++;
               _loc3_.oldTattooType = _loc4_.oldTattooType;
               _loc3_.oldAddProperty = _loc4_.oldAddProperty;
               _loc3_.oldAddingValue = _loc4_.oldAddingValue;
               _loc3_.oldReduceProperty = _loc4_.oldReduceProperty;
               _loc3_.oldReduceValue = _loc4_.oldReduceValue;
               _loc3_.newTattooType = _loc4_.newTattooType;
               _loc3_.newAddProperty = _loc4_.newAddProperty;
               _loc3_.newAddingValue = _loc4_.newAddingValue;
               _loc3_.newReduceProperty = _loc4_.newReduceProperty;
               _loc3_.newReduceValue = _loc4_.newReduceValue;
               _loc8_.push(_loc3_);
            }
            FrameControllerManager.instance.tattooController.tattooModel.holes = _loc8_;
         }
         else
         {
            _loc5_ = _loc2_.holeInfo[0];
            _loc10_ = FrameControllerManager.instance.tattooController.tattooModel.holes[_loc5_.hole - 1];
            _loc10_.oldTattooType = _loc5_.oldTattooType;
            _loc10_.oldAddProperty = _loc5_.oldAddProperty;
            _loc10_.oldAddingValue = _loc5_.oldAddingValue;
            _loc10_.oldReduceProperty = _loc5_.oldReduceProperty;
            _loc10_.oldReduceValue = _loc5_.oldReduceValue;
            _loc10_.newTattooType = _loc5_.newTattooType;
            _loc10_.newAddProperty = _loc5_.newAddProperty;
            _loc10_.newAddingValue = _loc5_.newAddingValue;
            _loc10_.newReduceProperty = _loc5_.newReduceProperty;
            _loc10_.newReduceValue = _loc5_.newReduceValue;
         }
         MsgMan.notifyObserver("TATTOO_INFO");
      }
      
      public function sendFashionChange(param1:FashionInfoMsg) : void
      {
         var _loc2_:PackageOut = new PackageOut(9582);
         SocketManager.instance.socket.sendProtobuffer(_loc2_,param1);
      }
      
      protected function __fashionHandler(param1:SLGSocketEvent) : void
      {
         var _loc9_:GoodsInfo = null;
         var _loc7_:GoodsInfo = null;
         var _loc8_:GoodsInfo = null;
         var _loc10_:GoodsInfo = null;
         var _loc5_:GoodsInfo = null;
         var _loc3_:GoodsInfo = null;
         var _loc4_:GoodsInfo = null;
         var _loc6_:GoodsInfo = null;
         var _loc11_:PackageIn = param1.data as PackageIn;
         var _loc2_:FashionInfoMsg = new FashionInfoMsg();
         _loc2_ = _loc11_.readBody(_loc2_) as FashionInfoMsg;
         fashionInfoMsg = _loc2_;
         fashionList.clear();
         dragonFashionList.clear();
         if(_loc2_.hatAvata)
         {
            _loc9_ = new GoodsInfo();
            _loc9_.pos = 9;
            _loc9_.bagType = 4;
            _loc9_.templateId = _loc2_.hatAvata;
            fashionList.add(_loc9_.pos,_loc9_);
         }
         if(_loc2_.clothAvata)
         {
            _loc7_ = new GoodsInfo();
            _loc7_.pos = 10;
            _loc7_.bagType = 4;
            _loc7_.templateId = _loc2_.clothAvata;
            fashionList.add(_loc7_.pos,_loc7_);
         }
         if(_loc2_.armAvata)
         {
            _loc8_ = new GoodsInfo();
            _loc8_.pos = 11;
            _loc8_.bagType = 4;
            _loc8_.templateId = _loc2_.armAvata;
            fashionList.add(_loc8_.pos,_loc8_);
         }
         if(_loc2_.wingAvata)
         {
            _loc10_ = new GoodsInfo();
            _loc10_.pos = 8;
            _loc10_.bagType = 4;
            _loc10_.templateId = _loc2_.wingAvata;
            fashionList.add(_loc10_.pos,_loc10_);
         }
         if(_loc2_.dragonHatAvata)
         {
            _loc5_ = new GoodsInfo();
            _loc5_.pos = 9;
            _loc5_.bagType = 4;
            _loc5_.templateId = _loc2_.dragonHatAvata;
            dragonFashionList.add(_loc5_.pos,_loc5_);
         }
         if(_loc2_.dragonClothAvata)
         {
            _loc3_ = new GoodsInfo();
            _loc3_.pos = 10;
            _loc3_.bagType = 4;
            _loc3_.templateId = _loc2_.dragonClothAvata;
            dragonFashionList.add(_loc3_.pos,_loc3_);
         }
         if(_loc2_.dragonArmAvata)
         {
            _loc4_ = new GoodsInfo();
            _loc4_.pos = 11;
            _loc4_.bagType = 4;
            _loc4_.templateId = _loc2_.dragonArmAvata;
            dragonFashionList.add(_loc4_.pos,_loc4_);
         }
         if(_loc2_.dragonWingAvata)
         {
            _loc6_ = new GoodsInfo();
            _loc6_.pos = 8;
            _loc6_.bagType = 4;
            _loc6_.templateId = _loc2_.dragonWingAvata;
            dragonFashionList.add(_loc6_.pos,_loc6_);
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("FASHION_SHOW_CHANGE"));
      }
      
      protected function __tattooEnhanceDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:TattooHoleInfoII = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:TattooEnhanceListMsg = new TattooEnhanceListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as TattooEnhanceListMsg;
         tattooModel.holeInfoIIs = [];
         for each(var _loc3_:TattooEnhanceMsg in _loc2_.tattooEnhance)
         {
            _loc5_ = new TattooHoleInfoII();
            _loc5_.holeId = _loc3_.holdId;
            _loc5_.property = _loc3_.property;
            _loc5_.level = _loc3_.level;
            _loc5_.enable = _loc3_.enable;
            tattooModel.holeInfoIIs.push(_loc5_);
         }
         tattooModel.holeInfoIIs.sortOn("holeId",16);
         MsgMan.notifyObserver("TATTOO_NEWHOLE_INFO");
      }
      
      private function get tattooModel() : TattooModel
      {
         return FrameControllerManager.instance.tattooController.tattooModel;
      }
   }
}

