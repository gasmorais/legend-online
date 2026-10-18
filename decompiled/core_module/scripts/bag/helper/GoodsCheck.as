package bag.helper
{
   import bag.datas.GoodsSonType;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.view.tips.MessageTipManager;
   
   public class GoodsCheck
   {
      
      public static const PET_EXP:int = -1200;
      
      public static const PET_GROWTH_STONE:int = 208023;
      
      public static const PET_ADV_GROWTH_STONE:int = 208045;
      
      public static const PET_COE_STONE:int = 3040001;
      
      public static const PET_ADV_COE_STONE:int = 3040002;
      
      public static const PET_CARD:int = 3060011;
      
      public static const CRYSTAL_FRAGMENT:int = 208028;
      
      public static const RESOLVE_MOUNTCARD:int = 2120044;
      
      public static const RESOLVE_FASHIONCARD:int = 2120043;
      
      public static const RESOLVE_ANCIENT_ARMORYCARD:int = 6260001;
      
      public static const RUNE_PROMOT_GOODS:int = 3021001;
      
      public static const LIANYU_KEY:int = 208037;
      
      public static const MINGONG_KEY:int = 208008;
      
      public static const FONT_BASE:int = 2131120;
      
      public static const ARTIFACT_STONE:int = 212018;
      
      public function GoodsCheck()
      {
         super();
      }
      
      public static function checkGoodsByHero(param1:GoodsInfo, param2:ThaneInfo, param3:Boolean = true) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(!isJobFix(param2,param1.templateInfo,param3))
         {
            return false;
         }
         if(!isSexFix(param2,param1.templateInfo,param3))
         {
            return false;
         }
         if(!isVocationFix(param2,param1.templateInfo,param3))
         {
            return false;
         }
         return true;
      }
      
      public static function checkGoodsCanEquip(param1:GoodsInfo, param2:ThaneInfo, param3:Boolean = false) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.templateInfo.MasterType != 1 && param1.templateInfo.SonType != 214 && param1.templateInfo.MasterType != 3)
         {
            return false;
         }
         if(!isJobFix(param2,param1.templateInfo,param3))
         {
            return false;
         }
         if(!isSexFix(param2,param1.templateInfo,param3))
         {
            return false;
         }
         if(!isVocationFix(param2,param1.templateInfo,param3))
         {
            return false;
         }
         return true;
      }
      
      public static function isVocationFix(param1:ThaneInfo, param2:GoodsTemplateInfo, param3:Boolean) : Boolean
      {
         if(!GoodsSonType.checkNewEquip(param2) || GoodsSonType.checkNewEquip(param2) && param1.vocationGrades > 0)
         {
            return true;
         }
         if(param3)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("bag.helper.GoodsCheck.command04"));
         }
         return false;
      }
      
      public static function isEquip(param1:GoodsTemplateInfo) : Boolean
      {
         if(param1 && param1.MasterType == 1)
         {
            return true;
         }
         return false;
      }
      
      public static function isUpdateEquip(param1:GoodsTemplateInfo) : Boolean
      {
         if(param1.MasterType == 1 && param1.SuiteId != 0 && param1.NeedGrades >= 40)
         {
            return true;
         }
         return false;
      }
      
      public static function isBasicEquip(param1:GoodsTemplateInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.MasterType != 1)
         {
            return false;
         }
         if(param1.SonType == 101)
         {
            return true;
         }
         if(param1.SonType == 103)
         {
            return true;
         }
         if(param1.SonType == 104)
         {
            return true;
         }
         if(param1.SonType == 106)
         {
            return true;
         }
         if(param1.SonType == 107)
         {
            return true;
         }
         if(param1.SonType == 108)
         {
            return true;
         }
         return false;
      }
      
      public static function isJobFix(param1:ThaneInfo, param2:GoodsTemplateInfo, param3:Boolean) : Boolean
      {
         if(GoodsCheck.isFashion(param2))
         {
            return true;
         }
         var _loc4_:Array = param2.Job.split(",");
         for each(var _loc5_:int in _loc4_)
         {
            if(_loc5_ == 0 || _loc5_ == param1.templateInfo.Job)
            {
               return true;
            }
         }
         if(param3)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("bag.helper.GoodsCheck.command01"));
         }
         return false;
      }
      
      public static function isSexFix(param1:ThaneInfo, param2:GoodsTemplateInfo, param3:Boolean) : Boolean
      {
         if(param2.Sexs == 2 || param1.templateInfo.Sexs == param2.Sexs)
         {
            return true;
         }
         if(param3)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("bag.helper.GoodsCheck.command02"));
         }
         return false;
      }
      
      public static function isGradeFix(param1:ThaneInfo, param2:GoodsTemplateInfo, param3:Boolean) : Boolean
      {
         if(GoodsSonType.checkNewEquip(param2) && param3)
         {
            if(param1.vocationGrades <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.equipCanJoin"));
               return false;
            }
         }
         if(param2.NeedGrades == 0 || param1.grades >= param2.NeedGrades)
         {
            return true;
         }
         if(param3)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("bag.helper.GoodsCheck.command03",param2.NeedGrades));
         }
         return false;
      }
      
      public static function checkGoodsBetterThanHero(param1:GoodsInfo) : Boolean
      {
         var _loc11_:GoodsTemplateInfo = null;
         var _loc6_:GoodsTemplateInfo = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(!checkGoodsCanEquip(param1,thane) || param1.templateInfo.SonType == 214)
         {
            return false;
         }
         if(!isGradeFix(thane,param1.templateInfo,false))
         {
            return false;
         }
         var _loc10_:Array = GoodsManager.instance.getHeroGoodsListBySonTypeAndId(param1.templateInfo.SonType,thane.id).getList();
         var _loc2_:Array = GoodsSonType.getSonTypePos(param1.templateInfo.SonType);
         var _loc3_:Array = _loc10_.filter(GoodsCheck.filterGoodsForVice);
         _loc3_.sortOn("pos");
         var _loc5_:int = -1;
         var _loc7_:int = 0;
         if(_loc2_.length > _loc3_.length)
         {
            return true;
         }
         for each(var _loc4_:GoodsInfo in _loc3_)
         {
            _loc11_ = _loc4_.templateInfo;
            _loc6_ = param1.templateInfo;
            _loc8_ = _loc4_.getEquipBaseScore();
            _loc9_ = param1.getEquipBaseScore();
            if(_loc9_ > _loc8_)
            {
               return true;
            }
            if(_loc9_ == _loc8_ && _loc6_.Profile > _loc11_.Profile)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function getBetterGoodsInList(param1:Array) : GoodsInfo
      {
         return param1.sort(sortOnScore)[0];
      }
      
      public static function sortOnScore(param1:GoodsInfo, param2:GoodsInfo) : int
      {
         var _loc3_:Number = param1.totalAttribute;
         var _loc4_:Number = param2.totalAttribute;
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(param1.templateInfo.Profile > param2.templateInfo.Profile)
         {
            return 1;
         }
         if(param1.templateInfo.Profile < param2.templateInfo.Profile)
         {
            return -1;
         }
         return 0;
      }
      
      public static function getIntensifuGold(param1:GoodsInfo) : int
      {
         var _loc4_:int = param1.templateInfo.NeedGrades;
         var _loc2_:int = param1.templateInfo.Profile;
         var _loc3_:int = param1.strengthenGrade;
         return strengthEquipGold(_loc4_,_loc2_,_loc3_);
      }
      
      public static function getEndIntensifyGold(param1:GoodsInfo) : int
      {
         var _loc5_:int = 0;
         var _loc4_:int = param1.templateInfo.NeedGrades;
         var _loc2_:int = param1.templateInfo.Profile;
         var _loc3_:int = param1.strengthenGrade;
         var _loc7_:int = param1.templateInfo.StrengthenMax;
         var _loc6_:int = 0;
         _loc5_ = _loc3_;
         while(_loc5_ < _loc7_)
         {
            _loc6_ += strengthEquipGold(_loc4_,_loc2_,_loc5_) * 4;
            _loc5_++;
         }
         return _loc6_;
      }
      
      public static function getIntensifyChildGold(param1:GoodsInfo) : int
      {
         var _loc2_:int = param1.templateInfo.Profile;
         var _loc3_:int = param1.strengthenGrade + 1;
         return int(2000 * _loc2_ * Math.pow(_loc3_ + 2,2.2));
      }
      
      private static function strengthEquipGold(param1:int, param2:int, param3:int) : int
      {
         if(param1 >= 80)
         {
            if(param2 >= 6)
            {
               return Math.pow(Math.floor(param1 / 10) + 1,2) * (param2 + 2) * Math.pow(param3 + 1,2.1) * 10;
            }
            return Math.pow(Math.floor(param1 / 10) + 1,2) * param2 * Math.pow(param3 + 1,2.1) * 10;
         }
         return Math.pow(1.5,int(param1 / 10) + 1) * (param2 + 1) * Math.pow(param3 + 1,2.2) * 5 + 500;
      }
      
      public static function getMouldGold(param1:GoodsInfo) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            if(param1.mouldStar == 10)
            {
               _loc3_ = 1;
            }
            else
            {
               _loc3_ = param1.mouldStar + 1;
            }
            if(param1.mouldGrade > 160)
            {
               _loc2_ = 2000 * Math.pow(8 + _loc3_,3);
            }
            else if(param1.mouldGrade > 80)
            {
               _loc2_ = 1000 * Math.pow(8 + _loc3_,3);
            }
            else
            {
               _loc2_ = 500 * Math.pow(8 + _loc3_,3);
            }
         }
         return _loc2_;
      }
      
      public static function getSellGold(param1:GoodsInfo) : int
      {
         return param1.templateInfo.SellGold;
      }
      
      public static function getChildSellGold(param1:GoodsInfo) : int
      {
         return param1.templateInfo.SellGold;
      }
      
      public static function getPetEquipSellGold(param1:GoodsInfo) : int
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = param1.mouldGrade;
         var _loc2_:int = param1.templateInfo.Profile;
         _loc5_ = 1;
         while(_loc5_ <= _loc3_)
         {
            _loc4_ += Math.pow(_loc5_,2) * 100 * _loc2_;
            _loc5_++;
         }
         return param1.templateInfo.SellGold;
      }
      
      public static function isAddToChecker(param1:GoodsInfo, param2:GoodsInfo) : Boolean
      {
         if((param1.isBinds == false && param2.isBinds == true || param1.isBinds == true && param2.isBinds == false) && param1.templateInfo.SonType == param2.templateInfo.SonType && param1.templateId == param2.templateId && param2.count < param2.templateInfo.MaxCount)
         {
            return true;
         }
         return false;
      }
      
      public static function isVipExperienceCard(param1:GoodsInfo) : Boolean
      {
         return param1.templateId == 2031201;
      }
      
      public static function isKingCard(param1:GoodsInfo) : Boolean
      {
         return param1.templateInfo.SonType == 203 && param1.templateInfo.Property1 == 13;
      }
      
      public static function isGoldInCampaign(param1:GoodsInfo) : Boolean
      {
         return param1.templateId == -100;
      }
      
      public static function isFashion(param1:GoodsTemplateInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.MasterType != 1)
         {
            return false;
         }
         if(param1.SonType == 112)
         {
            return true;
         }
         if(param1.SonType == 110)
         {
            return true;
         }
         if(param1.SonType == 111)
         {
            return true;
         }
         if(param1.SonType == 109)
         {
            return true;
         }
         return false;
      }
      
      public static function isMount(param1:GoodsTemplateInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.SonType == 218)
         {
            return true;
         }
         return false;
      }
      
      public static function isPet(param1:GoodsTemplateInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.MasterType == 4)
         {
            return true;
         }
         return false;
      }
      
      public static function getEquipFighting(param1:GoodsInfo, param2:GoodsTemplateInfo) : int
      {
         var _loc14_:int = 0;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc6_:int = 0;
         var _loc15_:int = 0;
         var _loc8_:SkillPropertyTempInfo = null;
         var _loc7_:int = 0;
         if(!param1)
         {
            return 0;
         }
         var _loc13_:int = param2.Attack;
         var _loc11_:int = param2.MagicAttack;
         var _loc4_:int = param2.Defence;
         var _loc5_:int = param2.MagicDefence;
         var _loc17_:int = param2.ForceHit;
         var _loc12_:int = param2.Conat;
         var _loc18_:int = param2.Live;
         var _loc9_:int = 0;
         var _loc10_:int = param2.Parry;
         var _loc16_:int = param2.Agility;
         if(param2.StrengthenMax > 0 && param2.Profile >= 5 && param2.NeedGrades >= 50 && param1.mouldGrade > 0)
         {
            _loc13_ += _loc13_ + getAdd(param2.Attack,param1) + getNewAdd(param2.Attack,param1.mouldGrade);
            _loc11_ += _loc11_ + getAdd(param2.MagicAttack,param1) + getNewAdd(param2.MagicAttack,param1.mouldGrade);
            _loc4_ += _loc4_ + getAdd(param2.Defence,param1) + getNewAdd(param2.Defence,param1.mouldGrade);
            _loc5_ += _loc5_ + getAdd(param2.MagicDefence,param1) + getNewAdd(param2.MagicDefence,param1.mouldGrade);
            _loc17_ += _loc17_ + getAdd(param2.ForceHit,param1) + getNewAdd(param2.ForceHit,param1.mouldGrade);
            _loc12_ += _loc12_ + getAdd(param2.Conat,param1) + getNewAdd(param2.Conat,param1.mouldGrade);
            _loc18_ += _loc18_ + getAdd(param2.Live,param1) + getNewAdd(param2.Live,param1.mouldGrade);
            _loc10_ += _loc10_ + getAdd(param2.Parry,param1) + getNewAdd(param2.Parry,param1.mouldGrade);
            _loc16_ += _loc16_ + getAdd(param2.Agility,param1) + getNewAdd(param2.Agility,param1.mouldGrade);
         }
         else if(TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.templateId).MasterType != 5)
         {
            _loc13_ += _loc13_ + getAdd(param2.Attack,param1);
            _loc11_ += _loc11_ + getAdd(param2.MagicAttack,param1);
            _loc4_ += _loc4_ + getAdd(param2.Defence,param1);
            _loc5_ += _loc5_ + getAdd(param2.MagicDefence,param1);
            _loc17_ += _loc17_ + getAdd(param2.ForceHit,param1);
            _loc12_ += _loc12_ + getAdd(param2.Conat,param1);
            _loc18_ += _loc18_ + getAdd(param2.Live,param1);
            _loc10_ += _loc10_ + getAdd(param2.Parry,param1);
            _loc16_ += _loc16_ + getAdd(param2.Agility,param1);
         }
         else
         {
            _loc13_ += _loc13_ + getPetAttAdd(param2.Attack,param1);
            _loc11_ += _loc11_ + getPetAttAdd(param2.MagicAttack,param1);
            _loc4_ += _loc4_ + getPetAttAdd(param2.Defence,param1);
            _loc5_ += _loc5_ + getPetAttAdd(param2.MagicDefence,param1);
            _loc17_ += _loc17_ + getPetAttAdd(param2.ForceHit,param1);
            _loc12_ += _loc12_ + getPetAttAdd(param2.Conat,param1);
            _loc18_ += _loc18_ + getPetAttAdd(param2.Live,param1);
            _loc10_ += _loc10_ + getPetAttAdd(param2.Parry,param1);
            _loc16_ += _loc16_ + getPetAttAdd(param2.Agility,param1);
         }
         _loc6_ = 1;
         while(_loc6_ < 5)
         {
            _loc14_ = int(param1["join" + _loc6_]);
            if(_loc14_ > 0)
            {
               _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc14_);
               if(_loc3_)
               {
                  if(_loc3_.Attack > 0)
                  {
                     _loc13_ += _loc3_.Attack;
                     _loc13_ = _loc13_ + getGemAdd(_loc3_,param1.userId,_loc3_.Attack);
                  }
                  if(_loc3_.MagicAttack > 0)
                  {
                     _loc11_ += _loc3_.MagicAttack;
                     _loc11_ = _loc11_ + getGemAdd(_loc3_,param1.userId,_loc3_.MagicAttack);
                  }
                  if(_loc3_.Defence > 0)
                  {
                     _loc4_ += _loc3_.Defence;
                     _loc4_ = _loc4_ + getGemAdd(_loc3_,param1.userId,_loc3_.Defence);
                  }
                  if(_loc3_.MagicDefence)
                  {
                     _loc5_ += _loc3_.MagicDefence;
                     _loc5_ = _loc5_ + getGemAdd(_loc3_,param1.userId,_loc3_.MagicDefence);
                  }
                  if(_loc3_.ForceHit)
                  {
                     _loc17_ += _loc3_.ForceHit;
                     _loc17_ = _loc17_ + getGemAdd(_loc3_,param1.userId,_loc3_.ForceHit);
                  }
                  if(_loc3_.Conat)
                  {
                     _loc12_ += _loc3_.Conat;
                     _loc12_ = _loc12_ + getGemAdd(_loc3_,param1.userId,_loc3_.Conat);
                  }
                  if(_loc3_.Live)
                  {
                     _loc18_ += _loc3_.Live;
                     _loc18_ = _loc18_ + getGemAdd(_loc3_,param1.userId,_loc3_.Live);
                  }
                  if(_loc3_.Parry)
                  {
                     _loc10_ += _loc3_.Parry;
                     _loc10_ = _loc10_ + getGemAdd(_loc3_,param1.userId,_loc3_.Parry);
                  }
               }
            }
            _loc6_++;
         }
         _loc7_ = 1;
         while(_loc7_ < 6)
         {
            _loc15_ = int(param1["randomSkill" + _loc7_]);
            if(_loc15_ > 0)
            {
               _loc8_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc15_);
               if(_loc8_)
               {
                  if(_loc8_.Attack > 0)
                  {
                     _loc13_ += _loc8_.Attack;
                  }
                  if(_loc8_.MagicAttack > 0)
                  {
                     _loc11_ += _loc8_.MagicAttack;
                  }
                  if(_loc8_.Defence > 0)
                  {
                     _loc4_ += _loc8_.Defence;
                  }
                  if(_loc8_.MagicDefence > 0)
                  {
                     _loc5_ += _loc8_.MagicDefence;
                  }
                  if(_loc8_.ForceHit > 0)
                  {
                     _loc17_ += _loc8_.ForceHit;
                  }
                  if(_loc8_.Conat > 0)
                  {
                     _loc12_ += _loc8_.Conat;
                  }
                  if(_loc8_.Live > 0)
                  {
                     _loc18_ += _loc8_.Live;
                  }
                  if(_loc8_.Parry > 0)
                  {
                     _loc10_ += _loc8_.Parry;
                  }
                  if(_loc8_.Agility)
                  {
                     _loc16_ += _loc8_.Agility;
                  }
               }
            }
            _loc7_++;
         }
         return _loc13_ + _loc11_ * 1.05 + _loc4_ + _loc5_ + _loc10_ + _loc17_ + _loc9_ + _loc12_ + _loc18_ / 5 + _loc16_ * 8;
      }
      
      public static function getAdd(param1:int, param2:GoodsInfo) : int
      {
         return GoodsHelp.getStrengthenAddition(param1,param2.strengthenGrade);
      }
      
      public static function getPetAttAdd(param1:int, param2:GoodsInfo) : int
      {
         return GoodsHelp.getPetEquipStrengAddition(param1,param2.mouldGrade);
      }
      
      public static function getNewAdd(param1:int, param2:int) : int
      {
         return GoodsHelp.getMouldAddition(param1,param2);
      }
      
      public static function getGemAdd(param1:GoodsTemplateInfo, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         if(param2 == thane.id)
         {
            _loc4_ = param3 * GoodsHelp.getJewelEffecyByGrade(thane.jewelGrades) / 100;
            if(thane.jewelGrades >= 80 && playerinfo.vocationGrades > 0)
            {
               _loc4_ = param3 * GoodsHelp.getSeniorJewelEffecyByGrade(thane.seniorStoreGrade) / 100;
            }
            return _loc4_;
         }
         return _loc4_;
      }
      
      public static function filterGoodsForVice(param1:*, param2:int, param3:Array) : Boolean
      {
         if(param1.pos < 8 && param1.bagType == 4)
         {
            if(param1.isViceEquip)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function get playerinfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private static function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

