package map.outercity.helper.mapview
{
   import map.internals.data.BaseCastle;
   import map.internals.data.MapPhysics;
   import map.internals.data.PhysicInfo;
   import map.internals.data.WildLand;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.armyII.SystemArmy;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class CopyNodeDataHelper
   {
      
      public function CopyNodeDataHelper()
      {
         super();
      }
      
      public static function cloneMapPhysics(param1:MapPhysics) : MapPhysics
      {
         if(param1 is WildLand)
         {
            return cloneWildLandData(param1 as WildLand);
         }
         if(param1 is BaseCastle)
         {
            return cloneCastleInfo(param1 as BaseCastle);
         }
         return null;
      }
      
      public static function cloneWildLandData(param1:WildLand) : WildLand
      {
         var _loc5_:int = 0;
         var _loc4_:ArmyPawn = null;
         var _loc7_:ArmyPawn = null;
         var _loc6_:WildLand = new WildLand();
         var _loc3_:PhysicInfo = new PhysicInfo();
         var _loc2_:SystemArmy = new SystemArmy();
         _loc3_.id = param1.info.id;
         _loc3_.posX = param1.info.posX;
         _loc3_.posY = param1.info.posY;
         _loc3_.types = param1.info.types;
         _loc3_.mapId = param1.info.mapId;
         _loc3_.grade = param1.info.grade;
         _loc3_.state = param1.info.state;
         _loc6_.templateId = param1.templateId;
         _loc6_.refreshTime = param1.refreshTime;
         _loc3_.occupyPlayerId = param1.info.occupyPlayerId;
         _loc3_.occupyPlayerName = param1.info.occupyPlayerName;
         _loc3_.occupyLeagueName = param1.info.occupyLeagueName;
         _loc6_.createDate = param1.createDate;
         _loc6_.curArmyId = param1.curArmyId;
         _loc6_.info = _loc3_;
         if(param1.ownSysArmy)
         {
            cloneHeroInfo(_loc2_.baseHero,param1.ownSysArmy.baseHero);
         }
         _loc5_ = 0;
         while(_loc5_ < 2)
         {
            _loc4_ = _loc2_.getPawnByIndex(_loc5_);
            _loc7_ = param1.ownSysArmy.getPawnByIndex(_loc5_);
            if(_loc7_)
            {
               _loc4_.id = _loc7_.id;
               _loc4_.armyId = _loc7_.armyId;
               _loc4_.templateId = _loc7_.templateId;
               _loc4_.ownPawns = _loc7_.ownPawns;
            }
            else if(_loc4_)
            {
               _loc2_.removeArmyPawnCountByIndex(_loc5_,_loc4_.ownPawns);
            }
            _loc5_++;
         }
         _loc6_.ownSysArmy = _loc2_;
         _loc6_.commit();
         return _loc6_;
      }
      
      private static function cloneHeroInfo(param1:ThaneInfo, param2:ThaneInfo) : ThaneInfo
      {
         param1.beginChanges();
         param1.id = param2.id;
         param1.nickName = param2.nickName;
         param1.templateId = param2.templateId;
         param1.userId = param2.userId;
         param1.hp = param2.hp;
         param1.blood = param2.blood;
         param1.bloodId = param2.bloodId;
         param1.baseProperty.remainPoint = param2.baseProperty.remainPoint;
         param1.baseProperty.basePowerPoint = param2.baseProperty.basePowerPoint;
         param1.baseProperty.baseAgilityPoint = param2.baseProperty.baseAgilityPoint;
         param1.baseProperty.baseIntellectPoint = param2.baseProperty.baseIntellectPoint;
         param1.baseProperty.baseCaptainPoint = param2.baseProperty.baseCaptainPoint;
         param1.baseProperty.basePhysiquePoint = param2.baseProperty.basePhysiquePoint;
         param1.baseProperty.addPowerPoint = param2.baseProperty.addPowerPoint;
         param1.baseProperty.addAgilityPoint = param2.baseProperty.addAgilityPoint;
         param1.baseProperty.addIntellectPoint = param2.baseProperty.addIntellectPoint;
         param1.baseProperty.addPhysiquePoint = param2.baseProperty.addPhysiquePoint;
         param1.baseProperty.addCaptainPoint = param2.baseProperty.addCaptainPoint;
         param1.baseProperty.totalPower = param2.baseProperty.totalPower;
         param1.baseProperty.totalAgility = param2.baseProperty.totalAgility;
         param1.baseProperty.totalIntellect = param2.baseProperty.totalIntellect;
         param1.baseProperty.totalCaptain = param2.baseProperty.totalCaptain;
         param1.baseProperty.totalPhysique = param2.baseProperty.totalPhysique;
         param1.attackProrerty.basePhyAttack = param2.attackProrerty.basePhyAttack;
         param1.attackProrerty.basePhyDefence = param2.attackProrerty.basePhyDefence;
         param1.attackProrerty.baseMagicAttack = param2.attackProrerty.baseMagicAttack;
         param1.attackProrerty.baseMagicDefence = param2.attackProrerty.baseMagicDefence;
         param1.attackProrerty.baseForceHit = param2.attackProrerty.baseForceHit;
         param1.attackProrerty.baseLive = param2.attackProrerty.baseLive;
         param1.attackProrerty.baseConatArmy = param2.attackProrerty.baseConatArmy;
         param1.attackProrerty.baseIntensity = param2.attackProrerty.baseIntensity;
         param1.attackProrerty.baseTenacity = param2.attackProrerty.baseTenacity;
         param1.attackProrerty.baseDingli = param2.attackProrerty.baseDingli;
         param1.attackProrerty.totalPhyAttack = param2.attackProrerty.totalPhyAttack;
         param1.attackProrerty.totalPhyDefence = param2.attackProrerty.totalPhyDefence;
         param1.attackProrerty.totalMagicAttack = param2.attackProrerty.totalMagicAttack;
         param1.attackProrerty.totalMagicDefence = param2.attackProrerty.totalMagicDefence;
         param1.attackProrerty.totalForceHit = param2.attackProrerty.totalForceHit;
         param1.attackProrerty.totalLive = param2.attackProrerty.totalLive;
         param1.attackProrerty.totalConatArmy = param2.attackProrerty.totalConatArmy;
         param1.attackProrerty.totalIntensity = param2.attackProrerty.totalIntensity;
         param1.attackProrerty.totalTenacity = param2.attackProrerty.totalTenacity;
         param1.attackProrerty.totalDingli = param2.attackProrerty.totalDingli;
         param1.skillCate.beginChange();
         param1.skillCate.skillPoint = param2.skillCate.skillPoint;
         param1.skillCate.skillScript = param2.skillCate.skillScript;
         param1.skillCate.fastKey = param2.skillCate.fastKey;
         param1.fightPos = param2.fightPos;
         param1.baseProperty.commit();
         param1.attackProrerty.commit();
         param1.skillCate.commit();
         param1.commit();
         return param1;
      }
      
      public static function cloneCastleInfo(param1:BaseCastle) : BaseCastle
      {
         var _loc3_:BaseCastle = new BaseCastle();
         var _loc2_:PhysicInfo = new PhysicInfo();
         _loc3_.defenceLeftTime = param1.defenceLeftTime;
         _loc2_.id = param1.info.id;
         _loc2_.mapId = param1.info.mapId;
         _loc2_.occupyLeagueName = param1.info.occupyLeagueName;
         _loc2_.occupyPlayerId = param1.info.occupyPlayerId;
         _loc2_.occupyPlayerName = param1.info.occupyPlayerName;
         _loc2_.posX = param1.info.posX;
         _loc2_.posY = param1.info.posY;
         _loc2_.state = param1.info.state;
         _loc2_.names = param1.info.names;
         _loc2_.types = param1.info.types;
         _loc3_.info = _loc2_;
         return _loc3_;
      }
   }
}

