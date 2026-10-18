package yishi.utils
{
   import yishi.datas.templates.CampaignBufferTemp;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.datas.templates.GodArriveData;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   
   public class IconFactory
   {
      
      public function IconFactory()
      {
         super();
      }
      
      public static function getStelaIcon(param1:String) : String
      {
         return PathManager.resourcePath + "icon/stela/" + param1;
      }
      
      public static function getBuidIconByIcon(param1:String) : String
      {
         return PathManager.resourcePath + param1;
      }
      
      public static function getTecIconByIcon(param1:String) : String
      {
         return PathManager.resourcePath + "icon" + param1;
      }
      
      public static function getSoldierIconByIcon(param1:String) : String
      {
         return PathManager.resourcePath + "icon" + param1;
      }
      
      public static function getCommonIconPath(param1:String) : String
      {
         return PathManager.resourcePath + "icon/" + param1;
      }
      
      public static function getDungeonExploreIconPath(param1:int) : String
      {
         return PathManager.resourcePath + "icon/dungeonevent/" + param1 + ".png";
      }
      
      public static function getGoodsIconByTID(param1:int) : String
      {
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
         return _loc2_ ? _loc2_.iconPath : "";
      }
      
      public static function getGoodsByTID(param1:int) : GoodsTemplateInfo
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
      }
      
      public static function getOuterCityShopIconPath(param1:int) : String
      {
         return PathManager.resourcePath + "icon/shop/" + param1 + ".png";
      }
      
      public static function getRemotePetIconPath(param1:String) : String
      {
         return PathManager.resourcePath + "icon/remotepet/" + param1;
      }
      
      public static function getChildPveBossIconPath(param1:String) : String
      {
         return PathManager.resourcePath + "icon" + param1;
      }
      
      public static function getNPCIcon(param1:int) : String
      {
         return PathManager.resourcePath + "images/head/space/" + param1 + ".swf";
      }
      
      public static function getHeroIconByPics(param1:String) : String
      {
         return PathManager.resourcePath + "icon" + param1;
      }
      
      public static function getComIconByPics(param1:String) : String
      {
         return PathManager.resourcePath + "icon/" + param1;
      }
      
      public static function getBossIcon(param1:int, param2:String = ".png") : String
      {
         return PathManager.resourcePath + "images/InstanceImg/" + param1 + "/icon" + param2;
      }
      
      public static function getPvpWarFight(param1:int, param2:String = ".png") : String
      {
         return PathManager.resourcePath + "images/InstanceImg/" + param1 + "/icon" + param2;
      }
      
      public static function getHeadIcon(param1:int, param2:String, param3:String = ".png") : String
      {
         return PathManager.resourcePath + "icon/player/" + param1 + "/" + param2 + param3;
      }
      
      public static function getPlayerIcon(param1:int, param2:String, param3:String = ".png") : String
      {
         return PathManager.resourcePath + "icon/player/" + param1 + "/" + param2 + param3;
      }
      
      public static function getWholeserverTrain(param1:int) : String
      {
         return PathManager.resourcePath + "icon/wholeserver_train/" + param1 + ".png";
      }
      
      public static function getHeroicon(param1:int) : String
      {
         var _loc2_:GameHeroTempInfo = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(param1);
         return _loc2_ ? PathManager.resourcePath + "icon" + _loc2_.Icon : "";
      }
      
      public static function getCropIcon(param1:GoodsTemplateInfo, param2:int) : String
      {
         if(!param1)
         {
            return "";
         }
         var _loc3_:String = PathManager.resourcePath + "icon";
         switch(param2 - 2)
         {
            case 0:
               return _loc3_ + param1.Avata + "/grow.png";
            case 1:
               return _loc3_ + param1.Avata + "/ripe.png";
            case 2:
               return _loc3_ + "/common" + "/die.png";
            default:
               return _loc3_ + "/common" + "/young.png";
         }
      }
      
      public static function getVehicleHeadIcon(param1:int) : String
      {
         return PathManager.resourcePath + "icon/vehicle_" + param1 + ".png";
      }
      
      public static function getPetHeadSmallIcon(param1:int) : String
      {
         if(param1 == 0)
         {
            return null;
         }
         return PathManager.resourcePath + "icon/pet/" + param1 + "/small.png";
      }
      
      public static function getPetHeadBigIcon(param1:int) : String
      {
         if(param1 == 0)
         {
            return null;
         }
         return PathManager.resourcePath + "icon/pet/" + param1 + "/big.png";
      }
      
      public static function getChildrenHeadSmallIcon(param1:int, param2:int) : String
      {
         var _loc3_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(param1,param2);
         return PathManager.resourcePath + "icon" + _loc3_.Icon;
      }
      
      public static function getModuleIcon(param1:String) : String
      {
         return PathManager.resourcePath + "icon/function/" + param1 + ".png";
      }
      
      public static function getPetHeadItemIcon(param1:int) : String
      {
         if(param1 == 0)
         {
            return null;
         }
         return PathManager.resourcePath + "icon/pet/" + param1 + "/item.png";
      }
      
      public static function getGodArriveBossIcon(param1:int, param2:int) : String
      {
         var _loc3_:GameHeroTempInfo = null;
         var _loc4_:GodArriveData = TempleteManager.instance.godArriveTemplateCate.getGodArriveData(param1,param2);
         if(_loc4_)
         {
            _loc3_ = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc4_.bossId);
         }
         if(!_loc3_)
         {
            return null;
         }
         return PathManager.resourcePath + "images/level/" + _loc3_.ResPath + ".png";
      }
      
      public static function getMarryRingIcon(param1:int) : String
      {
         return PathManager.resourcePath + "icon/marriage/" + param1 + ".png";
      }
      
      public static function getMarrySkillIcon(param1:String) : String
      {
         return PathManager.resourcePath + "icon/" + param1;
      }
      
      public static function getMarryHorseIcon() : String
      {
         return PathManager.resourcePath + "icon/marriage/horse.png";
      }
      
      public static function getMarryTreeIcon() : String
      {
         return PathManager.resourcePath + "icon/marriage/tree.png";
      }
      
      public static function getMarryBuffIconByHappies(param1:int) : String
      {
         var _loc4_:int = 0;
         var _loc2_:Array = TempleteManager.instance.getTemplatesByType(36);
         if(_loc2_ == null)
         {
            return "";
         }
         _loc2_.sortOn("TemplateId",16);
         var _loc3_:int = int(_loc2_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].TemplateId > param1)
            {
               if(_loc2_[_loc4_ - 1])
               {
                  _loc3_ = int(_loc2_[_loc4_ - 1].Grades);
               }
               break;
            }
            _loc4_++;
         }
         var _loc5_:CampaignBufferTemp = TempleteManager.instance.campaignBufferTemplate.getTemplateByTypeAndGrades(30,_loc3_);
         if(_loc5_ == null)
         {
            return "";
         }
         return getCommonIconPath(_loc5_.Icon);
      }
      
      public static function getMarrySkillByLevel(param1:int) : String
      {
         var _loc4_:int = 0;
         var _loc3_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(param1,36);
         if(_loc3_ == null)
         {
            return "";
         }
         var _loc2_:Array = TempleteManager.instance.getSkillTemplateInfoByIds(_loc3_.TemplateName);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc2_[_loc4_].UseWay == 1)
            {
               return getCommonIconPath(_loc2_[_loc4_].Icons);
            }
            _loc4_++;
         }
         return "";
      }
      
      public static function getFurnitureByType(param1:int) : String
      {
         return PathManager.resourcePath + "icon/furniture/" + param1 + ".png";
      }
      
      public static function getCatHouseIconPath(param1:String) : String
      {
         return PathManager.resourcePath + "icon" + param1;
      }
      
      public static function getArmoryIconPath(param1:int, param2:int) : String
      {
         return PathManager.resourcePath + "icon/armory_" + param1 + "_" + param2 + ".png";
      }
      
      public static function getMagicSpringPath(param1:String) : String
      {
         return PathManager.resourcePath + "icon/magicspring/" + param1;
      }
      
      public static function getSevenYearIconPath(param1:String) : String
      {
         return PathManager.resourcePath + "icon" + param1;
      }
      
      public static function getIncreasinglyBossIcon(param1:String) : String
      {
         return PathManager.resourcePath + "images/level/" + param1 + ".png";
      }
      
      public static function getTheseusWarSoulIcon(param1:String) : String
      {
         return PathManager.resourcePath + "icon/theseuswarsoul/" + param1;
      }
   }
}

