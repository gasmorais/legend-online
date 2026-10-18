package yishi.datas.playerinfo
{
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import mvc.module.armyII.RuneInfo;
   import mvc.module.armyII.SkillInfo;
   import mvc.module.avenger.AvengerModel;
   import mvc.module.dragonTitan.DragonTitanData;
   import mvc.module.faterotary.FateRotarySkillInfo;
   import mvc.module.goddess.GoddessInfo;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.pet.pethallows.PetHallowsInfo;
   import mvc.module.sns.BaseSnsInfo;
   import mvc.module.star.StarTroughInfo;
   import mvc.module.theseus.TheseussoulModel;
   import mvc.module.theseus.WarSoulModel;
   import ui.toptoolbar.TopToolsBar;
   import yishi.datas.UserInfo;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.datas.templates.AvengerBodyTempInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.datas.templates.PetTemplate;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TaskManage;
   import yishi.manager.TempleteManager;
   import yishi.utils.CallInterfaceUtil;
   import yishi.utils.SimpleDictionary;
   
   public class ThaneInfo extends SimplePlayerInfo
   {
      
      protected static const TEMPLATEID:String = "TEMPLATEID";
      
      protected static const GRADE:String = "GRADE";
      
      protected static const GP:String = "GP";
      
      private static const HIDE_FASHION:String = "HIDE_FASHION";
      
      private static const BODY_AVATAR:String = "BODY_AVATAR";
      
      private static const ARMS_AVATAR:String = "ARMS_AVATAR";
      
      private static const HAIR_AVATAR:String = "BODY_AVATAR";
      
      private static const CLOAK_AVATAR:String = "BODY_AVATAR";
      
      private static const WING_AVATAR:String = "WING_AVATAR";
      
      private static const MOUNT_AVATR:String = "MOUNT_AVATR";
      
      private static const PET_AVATAR:String = "PET_AVATAR";
      
      private static const BLOOD:String = "BLOOD";
      
      private static const BLOOD_VISIBLE_UPDATE:String = "BLOOD_VISIBLE_UPDATE";
      
      private static const JEWELGP:String = "JEWELGP";
      
      private static const JEWELGRADES:String = "JEWELGRADES";
      
      private static const CHANGE_SHAPE_ID:String = "changeShapeId";
      
      private static const APPELL_CHANGE:String = "APPELL_CHANGE";
      
      private static const SMALL_BUGLE_FREE_COUNT:String = "SMALL_BUGLE_FREE_COUNT";
      
      public static const SENIORSTOREGRADE:String = "SENIORSTOREGRADE";
      
      public static const SENIORSTOREGP:String = "SENIORSTOREGP";
      
      private static const MEDALGRADES:String = "MEDALGRADES";
      
      private static const MEDALGP:String = "MEDALGP";
      
      private static const MEDALINVALIDTIME:String = "MEDALINVALIDTIME";
      
      private static const CONCISE_GP:String = "CONCISE_GP";
      
      private static const CONCISE_GRADES:String = "CONCISE_GRADES";
      
      private static const IS_VICE_HERO:String = "IS_VICE_HERO";
      
      public var theseusMultiPvpRankName:String;
      
      public var theseusMultiPvpIntegral:int;
      
      public var received:Boolean;
      
      public var receivedCount:int;
      
      public var inviteContent:String;
      
      public var runeInfo:RuneInfo;
      
      public var isRobot:Boolean;
      
      public var leagueRankGroup:int;
      
      public var leagueRankIndex:int;
      
      private var _smallBugleFreeCount:int = 1;
      
      private var _crossBugleFreeCount:int = 1;
      
      private var _baseTemplateId:int;
      
      public var holes:Array;
      
      public var tattooPrintHoles:Array;
      
      public var titanInfo:DragonTitanData;
      
      public var artifactInfo:ArtifactThaneInfo;
      
      public var dragonTalkerInfo:DragonTalkerPlayerInfo;
      
      public var isOpenDragonTalker:Boolean;
      
      public var petHallowsArr:Array;
      
      public var isSlavedChild:Boolean;
      
      public var goddessInfo:GoddessInfo;
      
      public var monsterInfo:MonsterInfo;
      
      public var avengerInfo:AvengerModel;
      
      public var theseusInfo:TheseussoulModel;
      
      public var warSoulInfo:WarSoulModel;
      
      private var _avengerGrade:int;
      
      private var _baseTemplateInfo:GameHeroTempInfo;
      
      private var _templateInfo:GameHeroTempInfo;
      
      private var _first:Boolean;
      
      public var relation:int;
      
      public var friendGp:int = 0;
      
      private var _friendGrade:int = 1;
      
      public var id:int;
      
      private var _templateId:int = 100;
      
      private var _canChangeHeadId:Boolean = true;
      
      private var _headId:int;
      
      public var hp:int;
      
      public var fightPos:int;
      
      public var isTeamPlayer:Boolean;
      
      public var role:int;
      
      public var isInwar:int;
      
      public var fateSkill:String;
      
      private var _snsInfo:BaseSnsInfo;
      
      public var equipDic:SimpleDictionary;
      
      public var fashionMsg:FashionInfoMsg;
      
      public var baseProperty:BasePropertyInfo;
      
      public var attackProrerty:AttackProrertyInfo;
      
      public var skillCate:SkillCategory;
      
      public var talentData:TalentData;
      
      public var runeCate:RuneCategory;
      
      private var _runeStoneOpen:Boolean;
      
      public var fateRotarySkillList:Vector.<FateRotarySkillInfo>;
      
      public var fateTotalGp:uint;
      
      public var fateGrades:String;
      
      private var _changeShapeId:int;
      
      private var _preGrade:int;
      
      private var _grades:int;
      
      private var _gp:Number;
      
      private var _offlineGp:int;
      
      private var _jewelGrades:int;
      
      private var _jewelGp:int;
      
      private var _seniorStoreGrade:int;
      
      private var _seniorStoreGp:int;
      
      private var _medalGrades:int;
      
      private var _medalGp:Number;
      
      private var _medalInvalidTime:Number;
      
      private var _bodyEquipAvata:String = "";
      
      private var _bodyFashionAvata:String = "";
      
      private var _hideFashion:Boolean;
      
      private var _armsEquipAvata:String = "";
      
      private var _armsFashionAvata:String = "";
      
      private var _hairEquipAvata:String = "";
      
      private var _hairFashionAvata:String = "";
      
      private var _cloakAvata:String = "";
      
      private var _wingAvata:String = "";
      
      private var _mountAvata:String = null;
      
      public var petTemplate:PetTemplate;
      
      private var _petTemplateId:int = 0;
      
      public var temQuality:int = 1;
      
      public var petName:String = "";
      
      public var petQuaity:int = 1;
      
      private var _blood:int;
      
      public var nickNameB:String;
      
      public var marryRingGrade:int;
      
      public var bloodId:int;
      
      private var _appellId:int;
      
      private var _starTroughs:Vector.<StarTroughInfo>;
      
      private var _conciseGp:int;
      
      private var _conciseGrades:int;
      
      private var _isViceHero:Boolean;
      
      public function ThaneInfo()
      {
         var _loc2_:int = 0;
         var _loc1_:StarTroughInfo = null;
         super();
         baseProperty = new BasePropertyInfo();
         attackProrerty = new AttackProrertyInfo();
         skillCate = new SkillCategory();
         runeCate = new RuneCategory();
         talentData = new TalentData();
         equipDic = new SimpleDictionary();
         fashionMsg = new FashionInfoMsg();
         fateRotarySkillList = new Vector.<FateRotarySkillInfo>();
         _starTroughs = new Vector.<StarTroughInfo>();
         dragonTalkerInfo = new DragonTalkerPlayerInfo();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new StarTroughInfo();
            _loc1_.pos = _loc2_;
            _loc1_.grade = 0;
            _starTroughs.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function get avengerGrade() : int
      {
         return _avengerGrade;
      }
      
      public function set avengerGrade(param1:int) : void
      {
         if(_avengerGrade != param1)
         {
            _changeObj["AVENGER_DEGREE"] = true;
            _avengerGrade = param1;
         }
      }
      
      public function get avengerDegree() : int
      {
         var _loc1_:AvengerBodyTempInfo = TempleteManager.instance.avengerBodyTempCate.getTemplateByGrade(avengerGrade);
         return _loc1_ ? _loc1_.BodyType : 0;
      }
      
      public function get baseTemplateId() : int
      {
         return _baseTemplateId;
      }
      
      public function set baseTemplateId(param1:int) : void
      {
         _baseTemplateInfo = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(param1);
         if(_baseTemplateId == param1)
         {
            return;
         }
         _baseTemplateId = param1;
         if(!_baseTemplateInfo)
         {
            _baseTemplateInfo = new GameHeroTempInfo();
         }
      }
      
      public function get baseTemplateInfo() : GameHeroTempInfo
      {
         if(_baseTemplateInfo == null)
         {
            baseTemplateId = _baseTemplateId;
         }
         return _baseTemplateInfo;
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(param1:int) : void
      {
         _templateInfo = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(param1);
         if(_templateId == param1)
         {
            return;
         }
         _first = false;
         if(snsInfo.headId == _templateId && _canChangeHeadId)
         {
            snsInfo.headId = param1;
         }
         _templateId = param1;
         _changeObj["TEMPLATEID"] = true;
         if(!_templateInfo)
         {
            _templateInfo = new GameHeroTempInfo();
         }
      }
      
      public function get smallBugleFreeCount() : int
      {
         return _smallBugleFreeCount;
      }
      
      public function set smallBugleFreeCount(param1:int) : void
      {
         _smallBugleFreeCount = param1;
         _changeObj["SMALL_BUGLE_FREE_COUNT"] = true;
      }
      
      public function get crossBugleFreeCount() : int
      {
         return _crossBugleFreeCount;
      }
      
      public function set crossBugleFreeCount(param1:int) : void
      {
         _crossBugleFreeCount = param1;
      }
      
      public function checkFirst() : void
      {
         if(_first)
         {
            return;
         }
         _first = true;
         skillCate.initAllSkill(templateInfo.Job);
         runeCate.initAllRune(templateInfo.Job);
         talentData.initAllSkill(templateInfo.Job);
      }
      
      public function get friendGrade() : int
      {
         return _friendGrade;
      }
      
      public function set friendGrade(param1:int) : void
      {
         _friendGrade = param1;
      }
      
      public function get headId() : int
      {
         if(_headId == 0)
         {
            return _templateId;
         }
         return _headId;
      }
      
      public function set headId(param1:int) : void
      {
         _headId = param1;
      }
      
      public function get snsInfo() : BaseSnsInfo
      {
         if(!_snsInfo)
         {
            _snsInfo = new BaseSnsInfo();
            _snsInfo.userId = userId;
            _snsInfo.nickName = nickName;
            _snsInfo.headId = _templateId;
            _snsInfo.sign = "";
            _snsInfo.sex = 0;
            _snsInfo.birthdayType = 0;
            _snsInfo.birthYear = 0;
            _snsInfo.birthMonth = 0;
            _snsInfo.birthDay = 0;
            _snsInfo.horoscope = 0;
            _snsInfo.bloodType = 0;
            _snsInfo.country = 0;
            _snsInfo.province = 0;
            _snsInfo.city = 0;
         }
         return _snsInfo;
      }
      
      public function set snsInfo(param1:BaseSnsInfo) : void
      {
         if(_snsInfo == param1)
         {
            return;
         }
         _snsInfo = param1;
      }
      
      public function get runeStoneOpen() : Boolean
      {
         return _runeStoneOpen;
      }
      
      public function set runeStoneOpen(param1:Boolean) : void
      {
         if(_runeStoneOpen == param1)
         {
            return;
         }
         _runeStoneOpen = param1;
         if(_runeStoneOpen)
         {
            NotificationManager.instance.sendNotification("OPEN_RUNESTONE");
         }
      }
      
      public function get changeShapeId() : int
      {
         return _changeShapeId;
      }
      
      public function set changeShapeId(param1:int) : void
      {
         if(_changeShapeId == param1)
         {
            return;
         }
         _changeShapeId = param1;
         _changeObj["changeShapeId"] = true;
      }
      
      public function get preGrade() : int
      {
         return _preGrade;
      }
      
      public function get grades() : int
      {
         return _grades;
      }
      
      public function set grades(param1:int) : void
      {
         if(_grades != param1)
         {
            _changeObj["GRADE"] = true;
            _preGrade = _grades;
            _grades = param1;
         }
      }
      
      public function get totalGrade() : int
      {
         var _loc1_:int = 0;
         if(vocationIndex == 0)
         {
            _loc1_ = _grades + vocationGrades;
         }
         else if(vocationIndex < 3)
         {
            _loc1_ = 160 + vocationGrades;
         }
         else if(vocationIndex < 4)
         {
            _loc1_ = 240 + vocationGrades;
         }
         else
         {
            _loc1_ = 270 + vocationGrades;
         }
         return _loc1_;
      }
      
      public function get gp() : Number
      {
         return _gp;
      }
      
      public function set gp(param1:Number) : void
      {
         if(_gp != param1)
         {
            _changeObj["GP"] = true;
            _gp = param1;
         }
      }
      
      public function get offlineGp() : int
      {
         return _offlineGp;
      }
      
      public function set offlineGp(param1:int) : void
      {
         if(_offlineGp == param1)
         {
            return;
         }
         _offlineGp = param1 < 0 ? 0 : param1;
      }
      
      public function get jewelGrades() : int
      {
         return _jewelGrades;
      }
      
      public function set jewelGrades(param1:int) : void
      {
         if(_jewelGrades != param1)
         {
            _changeObj["JEWELGRADES"] = true;
            _jewelGrades = param1;
         }
      }
      
      public function get jewelGp() : int
      {
         return _jewelGp;
      }
      
      public function set jewelGp(param1:int) : void
      {
         if(_jewelGp != param1)
         {
            _changeObj["JEWELGP"] = true;
            _jewelGp = param1;
         }
      }
      
      public function get seniorStoreGrade() : int
      {
         return _seniorStoreGrade;
      }
      
      public function set seniorStoreGrade(param1:int) : void
      {
         if(_seniorStoreGrade != param1)
         {
            _changeObj["SENIORSTOREGRADE"] = true;
            _seniorStoreGrade = param1;
         }
      }
      
      public function get seniorStoreGp() : int
      {
         return _seniorStoreGp;
      }
      
      public function set seniorStoreGp(param1:int) : void
      {
         if(_seniorStoreGp != param1)
         {
            _changeObj["SENIORSTOREGP"] = true;
            _seniorStoreGp = param1;
         }
      }
      
      public function get medalGrades() : int
      {
         return _medalGrades;
      }
      
      public function set medalGrades(param1:int) : void
      {
         if(_medalGrades != param1)
         {
            _changeObj["MEDALGRADES"] = true;
            _medalGrades = param1;
         }
      }
      
      public function get medalGp() : Number
      {
         return _medalGp;
      }
      
      public function set medalGp(param1:Number) : void
      {
         if(_medalGp != param1)
         {
            _changeObj["MEDALGP"] = true;
            _medalGp = param1;
         }
      }
      
      public function get medalInvalidTime() : Number
      {
         if(_medalInvalidTime - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond > 0)
         {
            return _medalInvalidTime;
         }
         return 0;
      }
      
      public function set medalInvalidTime(param1:Number) : void
      {
         if(_medalInvalidTime != param1)
         {
            _changeObj["MEDALINVALIDTIME"] = true;
            _medalInvalidTime = param1;
         }
      }
      
      public function get hideFashion() : Boolean
      {
         return _hideFashion;
      }
      
      public function set hideFashion(param1:Boolean) : void
      {
         if(_hideFashion != param1)
         {
            _hideFashion = param1;
            _changeObj["HIDE_FASHION"] = true;
         }
      }
      
      public function get bodyAvata() : String
      {
         if(!_hideFashion && _bodyFashionAvata != "")
         {
            return _bodyFashionAvata;
         }
         return _bodyEquipAvata;
      }
      
      public function set bodyEquipAvata(param1:String) : void
      {
         if(_bodyEquipAvata != param1)
         {
            _changeObj["BODY_AVATAR"] = true;
            _bodyEquipAvata = param1;
         }
      }
      
      public function get bodyFashionAvata() : String
      {
         return _bodyFashionAvata;
      }
      
      public function get bodyEquipAvata() : String
      {
         return _bodyEquipAvata;
      }
      
      public function set bodyFashionAvata(param1:String) : void
      {
         if(_bodyFashionAvata != param1)
         {
            _changeObj["BODY_AVATAR"] = true;
            _bodyFashionAvata = param1;
         }
      }
      
      public function get armsAvata() : String
      {
         if(!_hideFashion && _armsFashionAvata != "")
         {
            return _armsFashionAvata;
         }
         return _armsEquipAvata;
      }
      
      public function set armsEquipAvata(param1:String) : void
      {
         if(_armsEquipAvata != param1)
         {
            _changeObj["ARMS_AVATAR"] = true;
            _armsEquipAvata = param1;
         }
      }
      
      public function get armsFashionAvata() : String
      {
         return _armsFashionAvata;
      }
      
      public function get armsEquipAvata() : String
      {
         return _armsEquipAvata;
      }
      
      public function set armsFashionAvata(param1:String) : void
      {
         if(_armsFashionAvata != param1)
         {
            _changeObj["ARMS_AVATAR"] = true;
            _armsFashionAvata = param1;
         }
      }
      
      public function get hairAvata() : String
      {
         if(!_hideFashion && _hairFashionAvata != "")
         {
            return _hairFashionAvata;
         }
         return _hairEquipAvata;
      }
      
      public function set hairEquipAvata(param1:String) : void
      {
         if(_hairEquipAvata != param1)
         {
            _changeObj["BODY_AVATAR"] = true;
            _hairEquipAvata = param1;
         }
      }
      
      public function get hairFashionAvata() : String
      {
         return _hairFashionAvata;
      }
      
      public function get hairEquipAvata() : String
      {
         return _hairEquipAvata;
      }
      
      public function set hairFashionAvata(param1:String) : void
      {
         if(_hairFashionAvata != param1)
         {
            _changeObj["BODY_AVATAR"] = true;
            _hairFashionAvata = param1;
         }
      }
      
      public function get cloakAvata() : String
      {
         return _cloakAvata;
      }
      
      public function set cloakAvata(param1:String) : void
      {
         if(_cloakAvata != param1)
         {
            _changeObj["BODY_AVATAR"] = true;
            _cloakAvata = param1;
         }
      }
      
      public function get wingAvata() : String
      {
         if(_hideFashion)
         {
            return "";
         }
         return _wingAvata;
      }
      
      public function set wingAvata(param1:String) : void
      {
         if(_wingAvata != param1 && !_hideFashion || _hideFashion && param1 != "")
         {
            _changeObj["WING_AVATAR"] = true;
            _wingAvata = param1;
         }
      }
      
      public function get wingEquipAvata() : String
      {
         return _wingAvata;
      }
      
      public function get mountAvata() : String
      {
         return _mountAvata;
      }
      
      public function set mountAvata(param1:String) : void
      {
         if(_mountAvata != param1)
         {
            _changeObj["MOUNT_AVATR"] = true;
            _mountAvata = param1;
         }
      }
      
      public function get petTemplateId() : int
      {
         return _petTemplateId;
      }
      
      public function set petTemplateId(param1:int) : void
      {
         if(param1 == _petTemplateId)
         {
            return;
         }
         _petTemplateId = param1;
         petTemplate = TempleteManager.instance.petTemplateCate.getTemplateById(param1);
         _changeObj["PET_AVATAR"] = true;
      }
      
      public function get blood() : int
      {
         return _blood;
      }
      
      public function set blood(param1:int) : void
      {
         if(_blood == 0 && param1 > 0 || _blood > 0 && param1 == 0)
         {
            _changeObj["BLOOD_VISIBLE_UPDATE"] = true;
         }
         if(_blood != param1)
         {
            _changeObj["BLOOD"] = true;
            _blood = param1;
         }
      }
      
      public function get appellId() : int
      {
         return _appellId;
      }
      
      public function set appellId(param1:int) : void
      {
         if(_appellId != param1)
         {
            _appellId = param1;
            _changeObj["APPELL_CHANGE"] = true;
         }
      }
      
      public function get appellInfo() : AppellInfoTemplate
      {
         return FrameControllerManager.instance.appellControler.model.getAppellInfo(appellId);
      }
      
      public function get templateInfo() : GameHeroTempInfo
      {
         if(_templateInfo == null)
         {
            templateId = _templateId;
         }
         return _templateInfo;
      }
      
      public function set starTroughs(param1:Vector.<StarTroughInfo>) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:StarTroughInfo = null;
         if(param1 && param1.length > 0)
         {
            _loc2_ = int(param1.length);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc3_ = param1[_loc4_] as StarTroughInfo;
               _starTroughs[_loc3_.pos] = _loc3_;
               _loc4_++;
            }
         }
      }
      
      public function get starTroughs() : Vector.<StarTroughInfo>
      {
         return _starTroughs;
      }
      
      public function existSkill(param1:SkillTempInfo) : int
      {
         return skillCate.existSkill(param1);
      }
      
      public function existTalent(param1:SkillTempInfo) : int
      {
         return talentData.existSkill(param1);
      }
      
      public function getSkillTemps() : Vector.<SkillTempInfo>
      {
         return skillCate.getSkillTemps();
      }
      
      public function getSkillBySontype(param1:int) : SkillInfo
      {
         return skillCate.getSkillBySontype(param1);
      }
      
      public function get fastKeyLength() : int
      {
         return skillCate.fastKeyLength;
      }
      
      public function getFateGuardSkill(param1:int) : FateRotarySkillInfo
      {
         for each(var _loc2_:FateRotarySkillInfo in fateRotarySkillList)
         {
            if(_loc2_.fateTypes == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function hasEffectBaseProperty(param1:String) : int
      {
         return baseProperty.hasEffect(param1);
      }
      
      public function hasEffectAttackProperty(param1:String) : int
      {
         return attackProrerty.hasEffect(param1);
      }
      
      public function getEquipList() : SimpleDictionary
      {
         if(id != ArmyManager.instance.thane.id)
         {
            return equipDic;
         }
         return GoodsManager.instance.getHeroEquipListById(id);
      }
      
      private function get userInfo() : UserInfo
      {
         return PlayerManager.instance.currentPlayerModel.userInfo;
      }
      
      private function checkAvatarChange() : void
      {
         avatarChange.clear();
         if(_changeObj["changeShapeId"])
         {
            avatarChange["hairUp"] = true;
            avatarChange["hairDown"] = true;
            avatarChange["body"] = true;
            avatarChange["army"] = true;
            avatarChange["cloak"] = true;
            avatarChange["wing"] = true;
            avatarChange["mount"] = true;
         }
         if(_changeObj["HIDE_FASHION"])
         {
            avatarChange["hairUp"] = true;
            avatarChange["hairDown"] = true;
            avatarChange["body"] = true;
            avatarChange["army"] = true;
            avatarChange["cloak"] = true;
            avatarChange["wing"] = true;
         }
         if(_changeObj["BODY_AVATAR"])
         {
            avatarChange["hairUp"] = true;
            avatarChange["hairDown"] = true;
         }
         if(_changeObj["BODY_AVATAR"])
         {
            avatarChange["body"] = true;
         }
         if(_changeObj["ARMS_AVATAR"])
         {
            avatarChange["army"] = true;
         }
         if(_changeObj["BODY_AVATAR"])
         {
            avatarChange["cloak"] = true;
         }
         if(_changeObj["WING_AVATAR"])
         {
            avatarChange["wing"] = true;
         }
         if(_changeObj["MOUNT_AVATR"])
         {
            avatarChange["hairUp"] = true;
            avatarChange["hairDown"] = true;
            avatarChange["body"] = true;
            avatarChange["army"] = true;
            avatarChange["cloak"] = true;
            avatarChange["wing"] = true;
            avatarChange["mount"] = true;
         }
         if(_changeObj["PET_AVATAR"])
         {
            avatarChange["pet"] = true;
         }
      }
      
      override public function commit() : void
      {
         var _loc1_:Array = null;
         if(_changeObj["GRADE"] && _preGrade != 0)
         {
            _loc1_ = userInfo.site.split("_");
            if(_loc1_[0] == "duowan")
            {
               CallInterfaceUtil.cannDuowanPlayerNotify(userInfo.user,userInfo.site,1,int(_loc1_[1]));
               CallInterfaceUtil.reportGameProfile(userInfo.site,parseInt(userInfo.user),this.nickName,this.grades);
            }
            TaskManage.instance.requestCanAcceptTask();
            if(_preGrade != 30 && _grades == 30)
            {
               NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_FIGHT"));
            }
            if(_preGrade < 13 && _grades >= 13 && PlayerManager.instance.currentPlayerModel.isOpenCrossGvg && !PlayerManager.instance.currentPlayerModel.isCrossGvgExpired)
            {
               TopToolsBar.instance.show();
            }
            if(_preGrade != 55 && _grades >= 55)
            {
               ArmyManager.instance.getFateRotarySkillList();
            }
            dispatchEvent(new PlayerEvent("THANE_LEVEL_UPDATE",this));
         }
         if(_changeObj["GP"])
         {
            dispatchEvent(new PlayerEvent("THANE_EXP_UPDATE",this));
         }
         if(_changeObj["BLOOD"])
         {
            dispatchEvent(new PlayerEvent("BLOOD_UPDATE",this));
         }
         if(_changeObj["BLOOD_VISIBLE_UPDATE"])
         {
            dispatchEvent(new PlayerEvent("BLOOD_VISIBLE_UPDATE",this));
         }
         if(_changeObj["JEWELGP"])
         {
            dispatchEvent(new PlayerEvent("JEWELGP_UPDATE",this));
         }
         if(_changeObj["JEWELGRADES"])
         {
            dispatchEvent(new PlayerEvent("JEWELGRADES_UPDATE",this));
         }
         if(_changeObj["SENIORSTOREGRADE"])
         {
            dispatchEvent(new PlayerEvent("SENIORSTOREGRADE_UPDATE",this));
         }
         if(_changeObj["SENIORSTOREGP"])
         {
            dispatchEvent(new PlayerEvent("SENIORSTOREGP_UPDATE",this));
         }
         if(_changeObj["MEDALGRADES"])
         {
            dispatchEvent(new PlayerEvent("MEDALGRADE_UPDATE",this));
         }
         if(_changeObj["MEDALGP"])
         {
            dispatchEvent(new PlayerEvent("MEDALGP_UPDATE",this));
         }
         if(_changeObj["MEDALINVALIDTIME"])
         {
            dispatchEvent(new PlayerEvent("MEDALINVALIDTIME_UPDATE",this));
         }
         if(_changeObj["BODY_AVATAR"] || _changeObj["ARMS_AVATAR"] || _changeObj["BODY_AVATAR"] || _changeObj["BODY_AVATAR"] || _changeObj["changeShapeId"] || _changeObj["WING_AVATAR"] || _changeObj["MOUNT_AVATR"] || _changeObj["HIDE_FASHION"] || _changeObj["PET_AVATAR"] || _changeObj["TEMPLATEID"])
         {
            checkAvatarChange();
            dispatchEvent(new PlayerEvent("PLAYER_AVATA_CHANGE",this));
         }
         if(_changeObj["APPELL_CHANGE"])
         {
            dispatchEvent(new PlayerEvent("APPELL_CHANGE",this));
         }
         if(_changeObj["SMALL_BUGLE_FREE_COUNT"])
         {
            dispatchEvent(new PlayerEvent("SMALL_BUGLE_FREE_COUNT",this));
         }
         if(_changeObj["CONCISE_GP"])
         {
            dispatchEvent(new PlayerEvent("CONCISE_GP_CHANGE",this));
         }
         if(_changeObj["CONCISE_GRADES"])
         {
            dispatchEvent(new PlayerEvent("CONCISE_GRADES_CHANGE",this));
         }
         if(_changeObj["AVENGER_DEGREE"])
         {
            dispatchEvent(new PlayerEvent("AVENGER_DEGREE_CHANGE",this));
         }
         dispatchEvent(new PlayerEvent("THANE_INFO_UPDATE",this));
         super.commit();
      }
      
      public function set canChangeHeadId(param1:Boolean) : void
      {
         _canChangeHeadId = param1;
      }
      
      public function get conciseGp() : int
      {
         return _conciseGp;
      }
      
      public function set conciseGp(param1:int) : void
      {
         if(_conciseGp != param1)
         {
            _changeObj["CONCISE_GP"] = true;
            _conciseGp = param1;
         }
      }
      
      public function get conciseGrades() : int
      {
         return _conciseGrades;
      }
      
      public function set conciseGrades(param1:int) : void
      {
         if(_conciseGrades != param1)
         {
            _changeObj["CONCISE_GRADES"] = true;
            _conciseGrades = param1;
         }
      }
      
      public function getLookPetHallowByType(param1:int) : PetHallowsInfo
      {
         for each(var _loc2_:PetHallowsInfo in petHallowsArr)
         {
            if(_loc2_.hallowType == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get isViceHero() : Boolean
      {
         return _isViceHero;
      }
      
      public function set isViceHero(param1:Boolean) : void
      {
         if(_isViceHero == param1)
         {
            return;
         }
         _isViceHero = param1;
         _changeObj["IS_VICE_HERO"] = true;
      }
   }
}

