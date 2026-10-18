package bag.datas
{
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.FrameControllerManager;
   
   public class GoodsSonType
   {
      
      public static const SONTYPE_WEAPON:int = 101;
      
      public static const FASHION_WEAPON:int = 111;
      
      public static const SONTYPE_ASSISTANT:int = 102;
      
      public static const SONTYPE_HEADDRESS:int = 103;
      
      public static const FASHION_HEADDRESS:int = 110;
      
      public static const SONTYPE_CLOTHES:int = 104;
      
      public static const FASHION_CLOTHES:int = 112;
      
      public static const SONTYPE_MANTEAU:int = 105;
      
      public static const SONTYPE_NECKLACE:int = 106;
      
      public static const SONTYPE_RING:int = 107;
      
      public static const SONTYPE_TRINKET:int = 108;
      
      public static const SONTYPE_WING:int = 109;
      
      public static const SONTYPE_HERALDRY:int = 117;
      
      public static const SONTYPE_RELIC:int = 118;
      
      public static const SONTYPE_BUFFER:int = 201;
      
      public static const SONTYPE_SPEED:int = 202;
      
      public static const SONTYPE_USEABLE:int = 203;
      
      public static const SONTYPE_INTENSIFY:int = 204;
      
      public static const SONTYPE_MOUNT:int = 205;
      
      public static const SONTYPE_MOUNT2:int = 228;
      
      public static const SONTYPE_OPENBOX:int = 206;
      
      public static const SONTYPE_USELESS:int = 207;
      
      public static const SONTYPE_MEDAL:int = 208;
      
      public static const SONTYPE_BLOOD:int = 209;
      
      public static const SONTYPE_TASK:int = 210;
      
      public static const SONTYPE_COMPOSE:int = 211;
      
      public static const SONTYPE_COMPOSE_MATERIAL:int = 212;
      
      public static const SONTYPE_REWARD_CARD:int = 213;
      
      public static const SONTYPE_RUNNES:int = 214;
      
      public static const SONTYPE_REFRESH:int = 215;
      
      public static const SONTYPE_SEED:int = 216;
      
      public static const SONTYPE_FARMANIMAL:int = 1500;
      
      public static const SONTYPE_ROSE:int = 217;
      
      public static const SONTYPE_APPELL:int = 221;
      
      public static const NEW_YEAR_CARD:int = 222;
      
      public static const CHILD_FOSTER:int = 223;
      
      public static const CHILD_JEWEL:int = 224;
      
      public static const SONTYPE_CHILD_GROWTH_ITEM:int = 225;
      
      public static const CHILD_SKILL_BOOK:int = 226;
      
      public static const CHILD_PROP:int = 227;
      
      public static const TRIAL_HAERT:int = 288;
      
      public static const SONTYPE_SOUL_CRYSTAL:int = 293;
      
      public static const SONTYPE_MAZE_GOLD:int = 296;
      
      public static const SONTYPE_MAZE:int = 297;
      
      public static const SONTYPE_CONSORTIATIME_CARD:int = 294;
      
      public static const SONTYPE_CONSORTIA_CARD:int = 295;
      
      public static const SONTYPE_MOUNT_PORP:int = 299;
      
      public static const SONTYPE_NOVICE_BOX:int = 298;
      
      public static const SONTYPE_VIP_BOX:int = 292;
      
      public static const SONTYPE_HONER:int = 301;
      
      public static const SONTYPE_PASSIVE_SKILL:int = 302;
      
      public static const SONTYPE_MOUNT_CARD:int = 218;
      
      public static const SONTYPE_PET_CARD:int = 306;
      
      public static const SONTYPE_PET_EXP_BOOK:int = 308;
      
      public static const SONTYPE_RENAME_CARD:int = 289;
      
      public static const SONTYPE_SEX_CHANGE_CARD:int = 340;
      
      public static const SONTYPE_GET_CHILD_CARD:int = 607;
      
      public static const SONTYPE_GET_TITAN_CARD:int = 282;
      
      public static const SONTYPE_EXCHANGE_CHILD_CARD:int = 277;
      
      public static const SONTYPE_MOUNT_FOOD:int = 290;
      
      public static const SONTYPE_FASHION_STONE:int = 278;
      
      public static const SONTYPE_BOSS_STONE:int = 622;
      
      public static const SONTYPE_TALENT_STONE:int = 279;
      
      public static const SONTYPE_KINGCONTRACT_CARD:int = 203;
      
      public static const SONTYPE_PET_SKILL_BOOK:int = 303;
      
      public static const SONTYPE_FATE_STONE:int = 307;
      
      public static const SONTYPE_PET_APT:int = 304;
      
      public static const SONTYPE_PET_ESSENCE:int = 310;
      
      public static const SONTYPE_BOX:int = 311;
      
      public static const RESIST_GEM:int = 312;
      
      public static const SONTYPE_PET_LAND_TRANSFER:int = 313;
      
      public static const SONTYPE_FIREWORK:int = 316;
      
      public static const SONTYPE_PUMPING_COUPON:int = 219;
      
      public static const SONTYPE_SINGLE_PASS_PROP:int = 314;
      
      public static const SONTYPE_SINGLE_PASS_BUGLE:int = 315;
      
      public static const QUAN_DISCOUNT:int = 317;
      
      public static const SONTYPE_HIGH_LEVEL_SOUL:int = 318;
      
      public static const SONTYPE_DRAGON_SOUL:int = 319;
      
      public static const SONTYPE_MARRY_TASK:int = 320;
      
      public static const SONTYPE_HAPPY_ADD:int = 322;
      
      public static const SONTYPE_NEW_MEDAL:int = 321;
      
      public static const SONTYPE_GEMMAZE_TREASURE_MAP:int = 331;
      
      public static const SONTYPE_MAGIC_CARD:int = 600;
      
      public static const SONTYPE_DUNGEON_ADD_STEP:int = 601;
      
      public static const SONTYPE_PET_EARRING:int = 113;
      
      public static const SONTYPE_PET_BELT:int = 114;
      
      public static const SONTYPE_PET_ACCESSORIES:int = 115;
      
      public static const SONTYPE_PET_ARTIFACT:int = 116;
      
      public static const SONTYPE_PET_COMPOSITE:int = 323;
      
      public static const SONTYPE_PET_UPGRADEITEM:int = 324;
      
      public static const SONTYPE_PET_STRENGITEMA:int = 325;
      
      public static const SONTYPE_PET_STRENGITEMB:int = 326;
      
      public static const SONTYPE_PET_REFINERYITEM:int = 327;
      
      public static const SONTYPE_PET_MOUNT:int = 328;
      
      public static const SONTYPE_PET_GEM:int = 329;
      
      public static const SONTYPE_PET_GEM2:int = 343;
      
      public static const SONTYPE_PET_GEM3:int = 344;
      
      public static const SONTYPE_SNOWROSE:int = 399;
      
      public static const OUTER_CITY_MAP_GOODS:uint = 602;
      
      public static const PLANES_LIGHT_GOODS:uint = 603;
      
      public static const PLANES_REVIVE_GOODS:uint = 604;
      
      public static const PLANES_CREAM_GOODS:uint = 605;
      
      public static const PLANES_POINT_GOODS:uint = 606;
      
      public static const MAGIC_TASK_ITEM:uint = 608;
      
      public static const TIMES_PROP:uint = 609;
      
      public static const SONTYPE_CHILD_WEAPON:int = 611;
      
      public static const SONTYPE_CHILD_HEADDRESS:int = 613;
      
      public static const SONTYPE_CHILD_CLOTHES:int = 614;
      
      public static const SONTYPE_CHILD_NECKLACE:int = 616;
      
      public static const SONTYPE_CHILD_RING:int = 617;
      
      public static const SONTYPE_CHILD_TRINKET:int = 618;
      
      public static const SONTYPE_LIFESKILL_ENCHANT:int = 236;
      
      public static const SONTYPE_LIFESKILL_LONGZHU:int = 234;
      
      public static const SONTYPE_LIFESKILL_ALCHEMY:int = 201;
      
      public static const SONTYPE_LIFESKILL_GONGSHI:int = 237;
      
      public static const SONTYPE_LIFESKILL_ZHONGJIAN:int = 238;
      
      public static const SONTYPE_MULTI_MOUNT_CARD:int = 2180;
      
      public static const SONTYPE_CROSS_BUGLE:int = 280;
      
      public static const SONTYPE_SOUL_CONCISE:int = 276;
      
      public static const SONTYPE_CHILD_CALL:int = 619;
      
      public static const SONTYPE_CHILD_AWAKESTONE:int = 620;
      
      public static const SONTYPE_TATTOO_PRINT:int = 283;
      
      public static const SONTYPE_TITAN_STONE:int = 281;
      
      public static const SONTYPE_RAVE_SCOREITEM:int = 621;
      
      public static const CHILD_NS_SKILL_BOOK:int = 624;
      
      public static const ANCIENT_ARTIFACT_STONE:int = 625;
      
      public static const ANCIENT_ARMORY_STONE:int = 626;
      
      public static const WARSOUL_SONTYPE:int = 760;
      
      public static const STAR_GAZING_ITEM_SONTYPE:int = 800;
      
      public static const STAR_GAZING_CHART_SONTYPE:int = 801;
      
      public static const BAGSHOWTYPE_ALL:int = 0;
      
      public static const BAGSHOWTYPE_JOB:int = 1;
      
      public static const BAGSHOWTYPE_SEX:int = 2;
      
      public static const BAGSHOWTYPE_GRADE:int = 3;
      
      public static const TALISMAN_EXP_SONTYPE:int = 407;
      
      public static const MONSTER_TRAIN_MATERIAL:int = 230;
      
      public static const MONSTER_CALL_MATERIAL:int = 231;
      
      public static const MONSTER_ACCESSORIES:int = 232;
      
      public static const MONSTER_STRENGETHEN:int = 233;
      
      public static const MONSTER_BREAKTHOUGH:int = 234;
      
      public static const PROFICIENCY_PILL:int = 627;
      
      public static const SEVEN_YEAR_TREASUREBOX:int = 666;
      
      public static const SEVEN_YEAR_TREASUREBOX_NOTBUY:int = 667;
      
      public static const DEVIL_ARMOR_SONTYPE:int = 670;
      
      public static const DEVIL_ARMOR_PIECE_SONTYPE:int = 680;
      
      public static const POLISH_STONE_SONTYPE:int = 681;
      
      public static const CARVE_STONE_SONTYPE:int = 682;
      
      public static const DEMOROAD_SHOP_RESOLVE_SONTYPE:int = 693;
      
      public static const Legion_command:int = 510;
      
      public static const STELA_SONTYPE:int = 710;
      
      public static const THESEUS_EQUIP:int = 720;
      
      public static const TREASURE_OUTER:int = 750;
      
      public static const TREASURE_INNER:int = 751;
      
      public static const TALENT_STONE:int = 623;
      
      public static const SONTYPE_MAGICSPRING:int = 398;
      
      public static const THESEUS_WAR_PROP_0:int = 760;
      
      public static const THESEUS_WAR_PROP_1:int = 761;
      
      public static const THESEUS_WAR_PROP_2:int = 762;
      
      public static const THESEUS_WAR_PROP_3:int = 763;
      
      public static const RUNE_STONE_1:int = 1000;
      
      public static const RUNE_STONE_2:int = 1001;
      
      public static const EQUIP_SONTYPE_LIST:Array = [101,102,103,104,105,106,107,108,109];
      
      public static const TALISMAN_SONTYPE_LIST:Array = [401,402,403,404,405,406];
      
      public function GoodsSonType()
      {
         super();
      }
      
      public static function getSonTypeName(param1:int) : String
      {
         switch(param1)
         {
            case 101:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.WEAPON");
            case 102:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.ASSISTANT");
            case 103:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.HEADDRESS");
            case 104:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.CLOTHES");
            case 105:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.MANTEAU");
            case 106:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.NECKLACE");
            case 107:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.RING");
            case 108:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.TRINKET");
            case 301:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.HONOR");
            case 214:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.RUNNES");
            case 109:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.WING");
            case 112:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.FashionClothes");
            case 110:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.FahsionHat");
            case 111:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.FashionWeapon");
            case 113:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.PetEquip01");
            case 114:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.PetEquip02");
            case 115:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.PetEquip03");
            case 116:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.PetEquip04");
            case 117:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.Heraldry");
            case 118:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.Relic");
            case 611:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.WEAPON");
            case 613:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.HEADDRESS");
            case 614:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.CLOTHES");
            case 616:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.NECKLACE");
            case 617:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.RING");
            case 618:
               return LanguageMgr.GetTranslation("bag.datas.GoodsSonType.TRINKET");
            default:
               return "";
         }
      }
      
      public static function getSonTypePos(param1:int) : Array
      {
         switch(param1)
         {
            case 101:
               return [0];
            case 103:
               return [1];
            case 104:
               return [2];
            case 106:
               return [3];
            case 107:
               return [4,5];
            case 108:
               return [6,7];
            case 214:
               return [0,1,2];
            case 301:
               return [0];
            case 109:
               return [8];
            case 110:
               return [9];
            case 112:
               return [10];
            case 111:
               return [11];
            case 113:
               return [0,1];
            case 114:
               return [2];
            case 115:
               return [3,4];
            case 116:
               return [5];
            case 117:
               return [12];
            case 118:
               return [13];
            default:
               return [-1];
         }
      }
      
      public static function isJobFix(param1:ThaneInfo, param2:GoodsTemplateInfo) : Boolean
      {
         var _loc3_:Array = param2.Job.split(",");
         for each(var _loc4_:int in _loc3_)
         {
            if(param1 && param2 && (_loc4_ == 0 || _loc4_ == param1.templateInfo.Job))
            {
               return true;
            }
         }
         return false;
      }
      
      public static function isSexFix(param1:ThaneInfo, param2:GoodsTemplateInfo) : Boolean
      {
         if(param1 && param2 && (param2.Sexs == 2 || param1.templateInfo.Sexs == param2.Sexs))
         {
            return true;
         }
         return false;
      }
      
      public static function isGradeFix(param1:ThaneInfo, param2:GoodsTemplateInfo) : Boolean
      {
         if(param1 && param2 && (param2.NeedGrades == 0 || param1.grades >= param2.NeedGrades))
         {
            return true;
         }
         return false;
      }
      
      public static function getColorByProfile(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return "#ffffff";
            case 1:
               return "#59cd41";
            case 2:
               return "#32a2f8";
            case 3:
               return "#a838f7";
            case 4:
               return "#ff8000";
            case 5:
               return "#ce0f0f";
            default:
               return "";
         }
      }
      
      public static function isPreciousGoods(param1:GoodsInfo) : Boolean
      {
         if(FrameControllerManager.instance.fashionCodeController.model.isFashion(param1))
         {
            return true;
         }
         if(param1.templateInfo.SonType == 205)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 228)
         {
            return true;
         }
         if(param1.templateInfo.MasterType == 4 && param1.templateInfo.Profile >= 4)
         {
            return true;
         }
         if(param1.templateInfo.MasterType == 2 && param1.templateInfo.Profile >= 4)
         {
            return true;
         }
         if(param1.templateInfo.MasterType == 3 && param1.templateInfo.Profile >= 4)
         {
            return true;
         }
         if(param1.templateInfo.MasterType == 1 && param1.templateInfo.SuiteId != 0)
         {
            return true;
         }
         if(param1.templateInfo.MasterType == 6 && param1.templateInfo.Profile >= 4)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 312)
         {
            return true;
         }
         if(param1.templateInfo.MasterType == 5)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 329)
         {
            return true;
         }
         if((param1.templateInfo.SonType == 117 || param1.templateInfo.SonType == 118) && param1.templateInfo.Profile >= 4)
         {
            return true;
         }
         return false;
      }
      
      public static function checkNewEquip(param1:GoodsTemplateInfo) : Boolean
      {
         if(param1.SonType == 117 || param1.SonType == 118)
         {
            return true;
         }
         return false;
      }
   }
}

