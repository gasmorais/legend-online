package yishi.manager
{
   import com.pickgliss.loader.DisplayLoader;
   import yishi.datas.PathInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.PlanesEventsTemplateInfo;
   import yishi.datas.templates.PlanesFuncTemplateInfo;
   import yishi.datas.templates.PlanesLayerTemplateInfo;
   
   public class PathManager
   {
      
      private static var _info:PathInfo;
      
      public static var SITE_MAIN:String = "";
      
      public static var DRAGONIC:String = "dragonic/";
      
      public function PathManager()
      {
         super();
      }
      
      public static function get info() : PathInfo
      {
         return _info;
      }
      
      public static function setup(param1:PathInfo) : void
      {
         _info = param1;
      }
      
      public static function get nickNamePath() : String
      {
         return _info.NICK_NAME_PATH;
      }
      
      public static function get forwardSite() : String
      {
         return _info.FOWARDSITE;
      }
      
      public static function get forwardName() : String
      {
         return _info.FOWARDNAME;
      }
      
      public static function solveResourceClassPath(param1:String, param2:String) : String
      {
         return "slg.resource.effect." + param2 + "Asset" + param1;
      }
      
      public static function solveHeroAvatarPath(param1:String, param2:int) : String
      {
         var _loc3_:String = param2 + ".swf";
         return resourcePath + "equip" + param1 + "/" + _loc3_;
      }
      
      public static function solveChildAvatarPath(param1:int, param2:int) : String
      {
         var _loc3_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(param1,param2);
         return resourcePath + "equip/hychild" + _loc3_.ResPath + "/2.swf";
      }
      
      public static function solveWingAvatarPath(param1:String, param2:int, param3:int) : String
      {
         return _info.ResourcePath + "equip" + param1 + "/" + param2 + "_" + param3 + ".swf";
      }
      
      public static function getDefaultJobBattleAvatar() : String
      {
         return _info.ResourcePath + "equip/mystery_default_body/2.swf";
      }
      
      public static function solveShowPawnAvatarPath(param1:int) : String
      {
         return resourcePath + "show_pawn/" + param1 + ".swf";
      }
      
      public static function solveShowHeroAvatarPath(param1:String, param2:String, param3:String, param4:String, param5:int) : String
      {
         var _loc6_:String = param5 + ".swf";
         if(!param2)
         {
            return resourcePath + param1 + param4 + "/" + _loc6_;
         }
         return resourcePath + param1 + param4 + "/" + param2 + "/" + param3 + "/" + _loc6_;
      }
      
      public static function get solveEffectConfig() : String
      {
         return resourcePath + "commandEffectConfig.xml";
      }
      
      public static function solveRoleClassPath(param1:String, param2:String = "") : String
      {
         return "slg.resource.movie.MovieAsset" + param2 + param1;
      }
      
      public static function get LanguagePath() : String
      {
         if(DisplayLoader.isDebug)
         {
            return "ui/" + PathInfo.LANGUAGE + "/" + "language.txt";
         }
         return resourcePath + "ui/" + PathInfo.LANGUAGE + "/" + "language.txt";
      }
      
      public static function get NamesLibPath() : String
      {
         if(DisplayLoader.isDebug)
         {
            return "ui/" + PathInfo.LANGUAGE + "/" + "nameslib.txt";
         }
         return resourcePath + "ui/" + PathInfo.LANGUAGE + "/" + "nameslib.txt";
      }
      
      public static function libEffectResourceClassPath(param1:String) : String
      {
         return "slg.resource.effect.effect" + param1;
      }
      
      public static function get ZhanPath() : String
      {
         return _info.TEMPLATE_PATH + "zip_dirty.txt";
      }
      
      public static function get AgentZhanPath() : String
      {
         return _info.TEMPLATE_PATH + "proxy_dirty.txt";
      }
      
      public static function solveRolePath(param1:String, param2:String = "") : String
      {
         return resourcePath + "swf/" + param1 + "/" + param2 + param1 + ".swf";
      }
      
      public static function solveSkillResPath(param1:String) : String
      {
         return resourcePath + "skillEffect/" + param1 + ".swf";
      }
      
      public static function solveRoleDefaultPath(param1:int, param2:String, param3:int, param4:String = "") : String
      {
         var _loc5_:String = null;
         switch(param1 - 1)
         {
            case 0:
               _loc5_ = "warrior";
               break;
            case 1:
               _loc5_ = "hunter";
               break;
            case 2:
               _loc5_ = "wizard";
               break;
            case 3:
               _loc5_ = "dragonic/dragonman";
               break;
            default:
               _loc5_ = "wizard";
         }
         return resourcePath + "equip/" + _loc5_ + "_default_" + param2 + param4 + "/" + param3 + ".swf";
      }
      
      public static function getBattleMapPath(param1:int) : String
      {
         return resourcePath + "sceneIma/" + param1 + "/map" + param1 + ".swf";
      }
      
      public static function getTimeStoryResPath(param1:String) : String
      {
         return resourcePath + "timestory/" + param1;
      }
      
      public static function get resourcePath() : String
      {
         return _info.ResourcePath;
      }
      
      public static function get CastleServicePath() : String
      {
         return _info.CastleServicePath;
      }
      
      public static function get SocktPath() : String
      {
         return _info.SocktPath;
      }
      
      public static function get SocketPort() : int
      {
         return _info.CharPort;
      }
      
      public static function showHeroEquipPath() : String
      {
         return _info.ResourcePath + "equip_show/male.swf";
      }
      
      public static function solveEffectPath(param1:String, param2:String) : String
      {
         return _info.ResourcePath + "swf/" + param1 + "/" + param2 + param1 + ".swf";
      }
      
      public static function getOuterCityMapsData(param1:int) : String
      {
         return _info.ResourcePath + "maps/" + param1 + "/" + param1 + ".maps";
      }
      
      public static function getOuterCityTilesData(param1:int) : String
      {
         return _info.ResourcePath + "maps/" + param1 + "/" + param1 + ".titles";
      }
      
      public static function getOuterCityNoteData(param1:int) : String
      {
         return _info.ResourcePath + "maps/" + param1 + "/" + param1 + ".rd";
      }
      
      public static function getOuterCityNotePaths(param1:int) : String
      {
         return _info.ResourcePath + "maps/" + param1 + "/" + param1 + ".path";
      }
      
      public static function getMapBackPaths(param1:int) : String
      {
         return _info.ResourcePath + "mapmaterial/land/" + param1 + "/";
      }
      
      public static function solveMapPhysicsBySonType(param1:int) : String
      {
         return _info.ResourcePath + "mapmaterial/build/" + param1 + ".swf";
      }
      
      public static function solveLiftCollectMapPhysics(param1:int, param2:int) : String
      {
         var _loc3_:String = "";
         if(param1 == 1)
         {
            _loc3_ = _info.ResourcePath + "images/mineral/" + param2 + ".swf";
         }
         else if(param1 == 2)
         {
            _loc3_ = _info.ResourcePath + "images/herbs/" + param2 + ".swf";
         }
         return _loc3_;
      }
      
      public static function solveCampaignMovieByUrl(param1:String) : String
      {
         return _info.ResourcePath + param1;
      }
      
      public static function solveHeadPath(param1:int) : String
      {
         return _info.ResourcePath + "images/head/" + param1 + ".swf";
      }
      
      public static function mapNameMoviePath(param1:int) : String
      {
         return _info.ResourcePath + "images/mapName/" + param1 + ".png";
      }
      
      public static function eastSmallCampaignByUrl(param1:String) : String
      {
         return _info.ResourcePath + "icon/easter/" + param1 + ".png";
      }
      
      public static function mapInstanceRoomName(param1:int) : String
      {
         return _info.ResourcePath + "images/InstanceImg/" + param1 + "/name.png";
      }
      
      public static function mapInstanceRoomIcon(param1:int) : String
      {
         return _info.ResourcePath + "images/InstanceImg/" + param1 + "/icon.jpg";
      }
      
      public static function mapInstanceSmallIconPath(param1:int) : String
      {
         return _info.ResourcePath + "images/InstanceImg/" + param1 + "/small.jpg";
      }
      
      public static function mapInstanceBigIconPath(param1:int) : String
      {
         return _info.ResourcePath + "images/InstanceImg/" + param1 + "/big.jpg";
      }
      
      public static function theseusdungeonIconPath(param1:String) : String
      {
         return _info.ResourcePath + "icon/theseusdungeon" + param1;
      }
      
      public static function planesMapByLandTypeAndSize(param1:int, param2:String) : String
      {
         var _loc3_:PlanesLayerTemplateInfo = TempleteManager.instance.planesLayerTemplateCate.getTemplateByID(param1);
         if(_loc3_)
         {
            return _info.ResourcePath + "planeswar/map/" + _loc3_.LandType + "/" + param2 + ".jpg";
         }
         return "";
      }
      
      public static function getPlanesIconUrlByTempId(param1:int) : String
      {
         var _loc2_:PlanesEventsTemplateInfo = TempleteManager.instance.planesEventsTemplateCate.getTemplateByID(param1);
         if(_loc2_)
         {
            return _info.ResourcePath + "planeswar/icon/" + _loc2_.Icon;
         }
         return "";
      }
      
      public static function getPlanesFuncIconByTempId(param1:int) : String
      {
         var _loc2_:PlanesFuncTemplateInfo = TempleteManager.instance.planesFuncTemplateCate.getTemplateByID(param1);
         if(_loc2_)
         {
            return _info.ResourcePath + "planeswar/funcicon/" + _loc2_.Icon;
         }
         return "";
      }
      
      public static function getClientLoginPath() : String
      {
         return _info.CLIENT_LOGIN_PATH;
      }
      
      public static function getClientLoginName() : String
      {
         return _info.CLIENT_LOGIN_NAME;
      }
      
      public static function getVersion() : String
      {
         return _info.VERSION;
      }
      
      public static function getFaceNum() : int
      {
         return _info.FACE_NUM;
      }
      
      public static function mapInstanceNormalIconPath(param1:int) : String
      {
         return _info.ResourcePath + "images/InstanceImg/" + param1 + "/center.jpg";
      }
      
      public static function mapInstanceOpenIcon(param1:int) : String
      {
         return _info.ResourcePath + "images/InstanceImg/" + param1 + "/open.png";
      }
      
      public static function mapInstanceOverIcon(param1:int) : String
      {
         return _info.ResourcePath + "images/InstanceImg/" + param1 + "/over.png";
      }
      
      public static function mapPVProomIconPath() : String
      {
         return _info.ResourcePath + "images/PVProom/" + "PVP_1.jpg";
      }
      
      public static function avatarResourcePath(param1:String, param2:int, param3:int = -1) : String
      {
         return _info.ResourcePath + "swf/avatar" + param1 + "/" + param2 + ".bswf";
      }
      
      public static function wingAvatarResourcePath(param1:String, param2:int, param3:int) : String
      {
         return _info.ResourcePath + "swf/avatar" + param1 + "/" + param2 + "_" + param3 + ".bswf";
      }
      
      public static function getAvatarResourcePath(param1:String, param2:int, param3:int, param4:String, param5:int, param6:int, param7:String = ".bswf") : String
      {
         var _loc8_:String = "";
         if(param5 == 100)
         {
            return PathManager.resourcePath + param1;
         }
         if(param3 == 1)
         {
            if(param4 == "mount")
            {
               _loc8_ = _info.ResourcePath + "swf/avatar" + param1 + "/" + 2 + param7;
            }
            else if(param4 == "wing")
            {
               if(param1.indexOf(DRAGONIC) != -1)
               {
                  _loc8_ = _info.ResourcePath + "swf/avatar" + param1 + "/" + 4 + "_" + param2 + param7;
               }
               else
               {
                  _loc8_ = _info.ResourcePath + "swf/avatar" + param1 + "/" + param5 + "_" + param2 + param7;
               }
            }
            else if(param4 == "pet")
            {
               _loc8_ = _info.ResourcePath + "swf/avatar" + param1 + "/" + 2 + param7;
            }
            else if(param6 == 1)
            {
               _loc8_ = _info.ResourcePath + "swf/avatar" + param1 + "/" + param2 + param7;
            }
            else if(param6 == 2)
            {
               _loc8_ = _info.ResourcePath + "swf/npc/" + param1 + param7;
            }
            else if(param6 == 3)
            {
               if(param4 == "body")
               {
                  _loc8_ = _info.ResourcePath + "swf/avatar/mineral_body/" + param1 + param7;
               }
               else if(param4 == "hairUp")
               {
                  _loc8_ = _info.ResourcePath + "swf/avatar/mineral_hair/" + param1 + param7;
               }
            }
         }
         else
         {
            if(param3 != 2)
            {
               throw new Error("未知的类型");
            }
            if(param1.indexOf(DRAGONIC) != -1)
            {
               _loc8_ = _info.ResourcePath + "swf/avatar" + param1 + "/" + 4 + "_" + param2 + param7;
            }
            else
            {
               _loc8_ = _info.ResourcePath + "swf/avatar" + param1 + "/" + param5 + "_" + param2 + param7;
            }
         }
         return _loc8_;
      }
      
      public static function NpcAvatarResourcePath(param1:String) : String
      {
         return _info.ResourcePath + "swf/npc/" + param1 + ".swf";
      }
      
      public static function avatarStandResourceClassPath(param1:String) : String
      {
         return param1 + "Stand";
      }
      
      public static function avatarWalkResourceClassPath(param1:String) : String
      {
         return param1 + "Walk";
      }
      
      public static function avatarShowResourceClassPath(param1:String) : String
      {
         return param1 + "Show";
      }
      
      public static function get templatePath() : String
      {
         return _info.TEMPLATE_PATH + "tempinfos.xml";
      }
      
      public static function get timeStoryPath() : String
      {
         return _info.TEMPLATE_PATH + "gametimes.xml";
      }
      
      public static function get versionPath() : String
      {
         return _info.TEMPLATE_PATH + "version.xml";
      }
      
      public static function get backAvatarList() : String
      {
         return _info.TEMPLATE_PATH + "avata.xml";
      }
      
      public static function get backResourceList() : String
      {
         return _info.TEMPLATE_PATH + "resource.xml";
      }
      
      public static function get orderPath() : String
      {
         return _info.TEMPLATE_PATH;
      }
      
      public static function get challengPath() : String
      {
         return _info.TEMPLATE_PATH + "challengeorder.xml";
      }
      
      public static function getMazeOrderPath(param1:int) : String
      {
         if(param1 == 0)
         {
            return _info.TEMPLATE_PATH + "tower.xml";
         }
         if(param1 == 1)
         {
            return _info.TEMPLATE_PATH + "tower2.xml";
         }
         if(param1 == 2)
         {
            return _info.TEMPLATE_PATH + "tower3.xml";
         }
         return "";
      }
      
      public static function getSinglePassOrderPath() : String
      {
         return _info.TEMPLATE_PATH + "singlepass.xml";
      }
      
      public static function getHookStatePath(param1:int) : String
      {
         return _info.ResourcePath + "images/hook/" + param1 + ".png";
      }
      
      public static function get snsTempPath() : String
      {
         return _info.TEMPLATE_PATH + "sns_temp.xml";
      }
      
      public static function get fightStatePath() : String
      {
         return _info.ResourcePath + "images/avatar/fight.png";
      }
      
      public static function get warFightBuff() : String
      {
         return _info.ResourcePath + "images/buff/war.png";
      }
      
      public static function get gainBuff() : String
      {
         return _info.ResourcePath + "images/buff/gain.png";
      }
      
      public static function getMountAvatar(param1:int) : String
      {
         return "/mount_default";
      }
      
      public static function getGvgBufferIconPath(param1:int) : String
      {
         return _info.ResourcePath + "icon/gvgbuffer/" + param1 + ".png";
      }
      
      public static function getDemonBufferIconPath(param1:int) : String
      {
         return _info.ResourcePath + "icon/demonbuffer/" + param1 + ".png";
      }
      
      public static function getCardIconPath(param1:String) : String
      {
         return _info.ResourcePath + "icon/powcard" + param1 + ".png";
      }
      
      public static function getCardSwfPath(param1:String) : String
      {
         return _info.ResourcePath + "icon/powcard" + param1 + ".swf";
      }
      
      public static function getCardTabPath(param1:int) : String
      {
         return _info.ResourcePath + "icon/powcard/tab/" + param1 + ".png";
      }
      
      public static function getCardTabNamePath(param1:int) : String
      {
         return _info.ResourcePath + "icon/powcard/tabname/" + param1 + ".png";
      }
      
      public static function getCardTabDefaultPath() : String
      {
         return _info.ResourcePath + "icon/powcard/tab/default.jpg";
      }
      
      public static function getGoldRoadIconPath(param1:int) : String
      {
         return _info.ResourcePath + "icon/goldroad/" + param1 + ".png";
      }
      
      public static function getMagicPubIconPath(param1:String) : String
      {
         return _info.ResourcePath + "icon" + param1;
      }
      
      public static function getMagicPubResourcePath(param1:String) : String
      {
         return _info.ResourcePath + "images/head/space" + param1;
      }
      
      public static function get customerPath() : String
      {
         return _info.REQUEST_PATH + "complaintshandle";
      }
      
      public static function get customerReplyPath() : String
      {
         return _info.REQUEST_PATH + "questionreplaylist";
      }
      
      public static function get customerSubmitEvaluatePath() : String
      {
         return _info.REQUEST_PATH + "appraisereplayservlet";
      }
      
      public static function get customerSubmitImagePath() : String
      {
         return _info.UPLOAD_PATH + "fileupload/upload";
      }
      
      public static function getVehicleSkillPath(param1:String) : String
      {
         return _info.ResourcePath + "vehicle/skill/" + param1 + ".swf";
      }
      
      public static function getVehicleNPCPath(param1:String) : String
      {
         return _info.ResourcePath + "vehicle/NPC/" + param1 + ".bswf";
      }
      
      public static function getVehicleAvatarPath(param1:String) : String
      {
         return _info.ResourcePath + "vehicle/avatar" + param1 + "/2.swf";
      }
      
      public static function getVehicleShowAvatarPath(param1:String) : String
      {
         return PathManager.resourcePath + "equip_show" + param1 + "/2.png";
      }
      
      public static function getAppellImgPath(param1:int) : String
      {
         return _info.ResourcePath + "images/appell/" + param1 + ".png";
      }
      
      public static function getPetFollowShowPath(param1:String) : String
      {
         return _info.ResourcePath + "equip_show" + param1 + "_follow/2.swf";
      }
      
      public static function getPetMorphShowPath(param1:String) : String
      {
         return _info.ResourcePath + "equip_show" + param1 + "/2.swf";
      }
      
      public static function getPetBattleFollowShowPath(param1:String) : String
      {
         return _info.ResourcePath + "equip" + param1 + "_follow/2.swf";
      }
      
      public static function getPetBattleMorphShowPath(param1:String) : String
      {
         return _info.ResourcePath + "equip" + param1 + "/2.swf";
      }
      
      public static function getFateWalkPath(param1:int, param2:String = ".png") : String
      {
         return _info.ResourcePath + "swf/avatar/FateHalo_Attack/" + param1 + param2;
      }
      
      public static function getArtifactShowPath(param1:int) : String
      {
         return _info.ResourcePath + "swf/avatar/legend/" + param1 + ".swf";
      }
      
      public static function getTreasureMostShowPath(param1:String) : String
      {
         return _info.ResourcePath + "swf/avatar/hychild/weapon/" + param1 + ".swf";
      }
      
      public static function getFateBattlePath(param1:int) : String
      {
         return _info.ResourcePath + "equip/FateHalo_Attack/" + param1 + ".swf";
      }
      
      public static function getMarryCarPathByJob(param1:int, param2:int) : String
      {
         var _loc3_:String = null;
         if(sexNum(param1) != sexNum(param2))
         {
            _loc3_ = _info.ResourcePath + "swf/avatar/marriage/10.bswf";
         }
         else if(sexNum(param1) == 1)
         {
            _loc3_ = _info.ResourcePath + "swf/avatar/marriage/11.bswf";
         }
         else if(sexNum(param1) == 2)
         {
            _loc3_ = _info.ResourcePath + "swf/avatar/marriage/00.bswf";
         }
         return _loc3_;
      }
      
      public static function getNewbieMovieByJob(param1:String, param2:int) : String
      {
         return _info.ResourcePath + "images/animation/newcomers/" + param2 + "/" + param1 + ".swf";
      }
      
      private static function sexNum(param1:int) : int
      {
         var _loc2_:int = 1;
         if(param1 == 1 || param1 == 2 || param1 == 3)
         {
            _loc2_ = 1;
         }
         else if(param1 == 4 || param1 == 5 || param1 == 6)
         {
            _loc2_ = 2;
         }
         return _loc2_;
      }
      
      public static function getGemMazeOrderPath() : String
      {
         return _info.TEMPLATE_PATH + "gemmaze.xml";
      }
      
      public static function getFishOrderPath() : String
      {
         return _info.TEMPLATE_PATH + "fish.xml";
      }
      
      public static function getRemotePetOrderPath() : String
      {
         return _info.TEMPLATE_PATH + "remotepet.xml";
      }
      
      public static function getChildPveOrderPath() : String
      {
         return _info.TEMPLATE_PATH + "guardpverank.xml";
      }
      
      public static function getFishSwfPath(param1:String) : String
      {
         return _info.ResourcePath + "fish" + param1 + ".swf";
      }
      
      public static function getFarmAnimaSwfPath(param1:String) : String
      {
         return _info.ResourcePath + "icon/farm/animal/" + param1 + ".swf";
      }
      
      public static function getDungeonOrderPath() : String
      {
         return _info.TEMPLATE_PATH + "dungeon.xml";
      }
      
      public static function petChallengSortPath() : String
      {
         return _info.TEMPLATE_PATH + "crosspet.xml";
      }
      
      public static function getChildShowByJobAndSex1(param1:int) : String
      {
         return _info.ResourcePath + "equip_show/hychild/0/" + param1 + ".swf";
      }
      
      public static function getChildShowByJobAndGrade(param1:int, param2:int) : String
      {
         var _loc3_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(param1,param2);
         return _info.ResourcePath + "equip_show/hychild" + _loc3_.ResPath + "/2.swf";
      }
      
      public static function getFarmBonFire(param1:int) : String
      {
         return _info.ResourcePath + "mapmaterial/build/" + param1 + ".swf";
      }
      
      public static function getSkyTrialPortal(param1:String) : String
      {
         return _info.ResourcePath + "images/skytrail/portal" + param1;
      }
      
      public static function getSkyTrialPortalScene(param1:String) : String
      {
         return _info.ResourcePath + "images/skytrail/scene" + param1;
      }
      
      public static function getFinalDefenseRes(param1:String) : String
      {
         return _info.ResourcePath + "images/pvz/" + param1 + ".swf";
      }
      
      public static function getFurniturePath(param1:String) : String
      {
         return _info.ResourcePath + "images/furniture/" + param1 + ".swf";
      }
      
      public static function getArchaeologyDescPicPath(param1:String) : String
      {
         return _info.ResourcePath + "icon" + param1;
      }
      
      public static function getAppellPicPath(param1:String) : String
      {
         return _info.ResourcePath + "icon/appell/" + param1 + ".png";
      }
      
      public static function getcollectionPicPath(param1:String) : String
      {
         return _info.ResourcePath + "icon/collection/" + param1 + ".png";
      }
      
      public static function getRapidViewIcon(param1:int, param2:int) : String
      {
         var _loc4_:Array = ["","key","hammer","aperture"];
         var _loc3_:String = _loc4_[Math.ceil(param2 / 3)] + "/" + param1.toString();
         return _info.ResourcePath + "icon/through/" + _loc3_ + ".png";
      }
      
      public static function getIslandExploreSkillPath(param1:String) : String
      {
         return _info.ResourcePath + "icon/islandexplore/" + param1 + ".png";
      }
      
      public static function getAlchemicalMineIconPath(param1:String) : String
      {
         return _info.ResourcePath + "icon/alchemical/" + param1;
      }
      
      public static function getVehicleAvatarShowPath(param1:String) : String
      {
         return _info.ResourcePath + "vehicle/show" + param1 + "/2.swf";
      }
      
      public static function getStarGazingChartUrl(param1:int, param2:int) : String
      {
         return _info.ResourcePath + "icon/stargazing/" + param1 + "/" + param2 + ".jpg";
      }
      
      public static function getPlaneCrisisBackPath() : String
      {
         return _info.ResourcePath + "mapmaterial/land/planecrisis/land/";
      }
      
      public static function getPlaneCrisisSmallMap(param1:int) : String
      {
         return _info.ResourcePath + "mapmaterial/land/planecrisis/small/" + param1 + ".png";
      }
      
      public static function getPlaneCrisisBigMap(param1:int) : String
      {
         return _info.ResourcePath + "mapmaterial/land/planecrisis/line/" + param1 + ".png";
      }
      
      public static function getChildHeadIcon(param1:String) : String
      {
         return _info.ResourcePath + "icon" + param1;
      }
      
      public static function getSecretSource(param1:int, param2:String) : String
      {
         if(param1 > 0)
         {
            return _info.ResourcePath + "mapmaterial/land/secret/" + param1 + "/" + param2;
         }
         return _info.ResourcePath + "mapmaterial/land/secret/" + param2;
      }
      
      public static function getMonthCardIconPath(param1:String) : String
      {
         return _info.ResourcePath + "images/monthcard/" + param1;
      }
      
      public static function getGoddessHeadIcon(param1:String) : String
      {
         return _info.ResourcePath + "goddess/view" + param1 + ".png";
      }
      
      public static function getGoddessEquipIcon(param1:int) : String
      {
         return _info.ResourcePath + "goddess/equip/" + param1 + ".png";
      }
      
      public static function getGoddessSmallIcon(param1:int) : String
      {
         return _info.ResourcePath + "goddess/small" + param1 + ".png";
      }
      
      public static function getGoddessAvaterPath(param1:String) : String
      {
         return _info.ResourcePath + "goddess/view" + param1 + ".swf";
      }
      
      public static function getBattleGoddessHeadPath(param1:int) : String
      {
         return _info.ResourcePath + "goddess/battle/icon/" + param1 + ".png";
      }
      
      public static function getBattleGoddessAvatarPath(param1:int) : String
      {
         return _info.ResourcePath + "goddess/battle/swf/" + param1 + ".swf";
      }
      
      public static function getCrossGuildMapPath() : String
      {
         return _info.ResourcePath + "mapmaterial/land/crossguild/";
      }
      
      public static function getMonsterExploreMapPath(param1:int) : String
      {
         return _info.ResourcePath + "images/monsterexplore/" + param1 + ".jpg";
      }
      
      public static function getMonsterChapterMapPath(param1:int) : String
      {
         return _info.ResourcePath + "swf/singlecampaign1/" + param1 + "/map/" + param1 + ".swf";
      }
      
      public static function isShowDragon(param1:ThaneInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.bodyAvata && param1.bodyAvata.indexOf(DRAGONIC) != -1 || param1.bodyFashionAvata && param1.bodyFashionAvata.indexOf(DRAGONIC) != -1 || param1.armsFashionAvata && param1.armsFashionAvata.indexOf(DRAGONIC) != -1 || param1.armsAvata && param1.armsAvata.indexOf(DRAGONIC) != -1 || param1.hairFashionAvata && param1.hairFashionAvata.indexOf(DRAGONIC) != -1 || param1.hairAvata && param1.hairAvata.indexOf(DRAGONIC) != -1 || param1.wingAvata && param1.wingAvata.indexOf(DRAGONIC) != -1)
         {
            return true;
         }
         return false;
      }
      
      public static function getSelfChessKindIcon(param1:Boolean, param2:int) : String
      {
         var _loc3_:String = param1 ? "big/" : "small/";
         return _info.ResourcePath + "icon/autochess/" + _loc3_ + param2 + ".png";
      }
      
      public static function get royaltyRankPath() : String
      {
         return _info.TEMPLATE_PATH + "royalty.xml";
      }
      
      public static function getForbiddenBossPath(param1:String) : String
      {
         return _info.ResourcePath + "swf/npc/forbiddenboss/" + param1;
      }
      
      public static function getCarnivalRes(param1:int, param2:String) : String
      {
         return _info.ResourcePath + "images/carnival/" + param1 + "/" + param2 + ".png";
      }
   }
}

