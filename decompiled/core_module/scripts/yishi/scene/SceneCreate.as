package yishi.scene
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentSetting;
   import flash.utils.Dictionary;
   import map.campaign.CampaignManager;
   import mvc.controler.PvpRoomControl;
   import mvc.controler.RoomControl;
   import sandbox.SandboxManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.LoadingSceneView;
   
   public class SceneCreate implements ISceneCreate
   {
      
      public static var createSceneImp:Function;
      
      public static var getProjectUrlByStateImp:Function;
      
      private var _sceneUiProgress:int = 20;
      
      private var _codeProgerss:int = 20;
      
      private var _progressDic:Dictionary = new Dictionary(true);
      
      private var _currentType:String;
      
      private var _state:Dictionary = new Dictionary();
      
      public function SceneCreate()
      {
         super();
      }
      
      public static function getClassByType(param1:String) : String
      {
         switch(param1)
         {
            case "OUTER_CITY_SCENE":
               return "map.outercity.OuterCityController";
            case "VEHICLE":
               return "com.map.vehicle.VehicleSceneController";
            case "CAMPAIGN_MAP_SCENE":
               return "map.campaign.CampaignMapController";
            case "CASTLE_SCENE":
               return "castle.CastleSceneView";
            case "BATTLE_SCENE":
               return "battle.BattleSceneView";
            case "FARM":
               return "farm.FarmSceneView";
            case "VEHICLE":
               return "com.map.vehicle.VehicleSceneController";
            case "MULTILORDS_ROOM":
               return "mvc.controler.MultilordsRoomController";
            case "MATELORDS_ROOM":
               return "mvc.controler.MatelordsRoomController";
            case "THESE_Double_PVP_SCENE":
               return "theseusDoublepvpscene.TheseusDoublePvpScene";
            case "SPACE_SCENE":
               return "map.space.SpaceSceneController";
            case "CHANLLENGE_ROOM_SCENE":
               return "colosseum.ChallengeSceneControl";
            case "PLANES_WAR_SCENE":
               return "planeswar.PlanesWarSceneView";
            case "SKYBOX_ROAD_SCENE":
               return "skyboxroad.SkyBoxRoadFrame";
            case "FINAL_DEFENSE_SCENE":
               return "finaldefense.FinalDefenseScene";
            case "ARESLORDS_ROOM":
               return "mvc.controler.AresLordsRoomController";
            case "UNREAL_SHOOTING_ROOM":
               return "mvc.controler.UnrealShootingRoomController";
            case "SANDBOX_SCENE":
               return "sandbox.SandboxSceneController";
            case "PLANE_CRISRIS":
               return "crisis.PlaneCrisisSecenView";
            case "GAME_HALL_SCENE":
               return "gamehall.GameHallSceneController";
            case "APEX_ROOM":
               return "mvc.controler.ApexRoomController";
            case "CROSS_GUILD_SCENE":
               return "consortia.view.crossguild.CrossGuildWarSceneView";
            case "STARAREA_SCENE":
               return "stararea.StarareaController";
            case "SELF_CHESS_SCENE":
               return "chess.SelfChessSceneController";
            case "GLORY_GAME_SCENE":
               return "mvc.controler.GloryGameRoomController";
            case "INCREASINGLY_ROAD_SCENE":
               return "increasinglyroad.IncreasinglyRoadFrame";
            case "DARK_MAZE_SCENE":
               return "darkmaze.DarkMazeMainFrame";
            case "SECRET_ADVENTURE_SCENE":
               return "secretadventure.SecretAdventureScene";
            case "THESE_PVP_SCENE":
               return "theseuspvpscene.TheseusPvpScene";
            case "SECRET_WAR_SCENE":
               return "war2023.view.SecretWarSecen";
            case "CHILD_NS_WAR_SCENE":
               return "childnswar.ChildNswarScene";
            default:
               return "";
         }
      }
      
      public function create(param1:String) : BaseSceneView
      {
         var _loc2_:* = undefined;
         var _loc3_:String = getClassByType(param1);
         if(_loc3_ != "")
         {
            _loc2_ = DisplayLoader.Context.applicationDomain.getDefinition(getClassByType(param1));
            return new _loc2_() as BaseSceneView;
         }
         switch(param1)
         {
            case "EMPTY_SCENE":
               return new EmptyScene();
            case "PVE_ROOM_SCENE":
               return new RoomControl();
            case "PVP_ROOM_SCENE":
               return new PvpRoomControl();
            default:
               return null;
         }
      }
      
      private function getProjectUrlByState(param1:String) : String
      {
         if(getProjectUrlByStateImp != null)
         {
            return getProjectUrlByStateImp(param1) as String;
         }
         switch(param1)
         {
            case "BATTLE_SCENE":
               return ComponentSetting.getProjectSourcePath("10.png");
            case "FARM":
               return ComponentSetting.getProjectSourcePath("7.png");
            case "CAMPAIGN_MAP_SCENE":
            case "SPACE_SCENE":
            case "OUTER_CITY_SCENE":
            case "PLANES_WAR_SCENE":
            case "SANDBOX_SCENE":
            case "PLANE_CRISRIS":
            case "GAME_HALL_SCENE":
            case "STARAREA_SCENE":
            case "SECRET_ADVENTURE_SCENE":
            case "THESE_PVP_SCENE":
            case "THESE_Double_PVP_SCENE":
            case "SELF_CHESS_SCENE":
            case "SECRET_WAR_SCENE":
            case "CHILD_NS_WAR_SCENE":
               break;
            case "CASTLE_SCENE":
               return ComponentSetting.getProjectSourcePath("4.png");
            case "PVE_ROOM_SCENE":
            case "PVP_ROOM_SCENE":
            case "MULTILORDS_ROOM":
            case "MATELORDS_ROOM":
            case "ARESLORDS_ROOM":
            case "UNREAL_SHOOTING_ROOM":
            case "APEX_ROOM":
            case "GLORY_GAME_SCENE":
               return ComponentSetting.getProjectSourcePath("9.png");
            case "VEHICLE":
               return ComponentSetting.getProjectSourcePath("17.png");
            case "CHANLLENGE_ROOM_SCENE":
               return ComponentSetting.getProjectSourcePath("13.png");
            case "SKYBOX_ROAD_SCENE":
            case "INCREASINGLY_ROAD_SCENE":
            case "DARK_MAZE_SCENE":
               return ComponentSetting.getProjectSourcePath("11.png");
            case "CROSS_GUILD_SCENE":
               return ComponentSetting.getProjectSourcePath("6.png");
            default:
               return "";
         }
         return ComponentSetting.getProjectSourcePath("3.png");
      }
      
      public function createAsync(param1:String, param2:Function) : void
      {
         var _loc6_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         _progressDic = new Dictionary();
         _currentType = param1;
         var _loc5_:SceneLoaderInfo = getSceneLoadInfo(param1,param2);
         if(getProjectUrlByState(param1) != "")
         {
            _loc5_.neededUIModule.push(getProjectUrlByState(param1));
         }
         if(_loc5_.neededUIModule.length == 0)
         {
            _loc5_.isComplete = true;
            loadCompleteImp();
            return;
         }
         if(!_loc5_.isComplete)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_.neededUIModule.length)
            {
               _loc3_ = _loc5_.neededUIModule[_loc6_];
               _loc4_ = ComponentSetting.getMD5FileNameByFilePath(_loc3_);
               _progressDic[_loc4_] = 0;
               LoaderManagerII.instance.load(_loc3_,3,0,onloadComplete,onloadProgress,null,_loc5_);
               _loc6_++;
            }
         }
      }
      
      private function onloadComplete(param1:LoaderInfo, param2:Object) : void
      {
         param1.args.currentLoaded++;
         param1.args.isComplete = param1.args.currentLoaded >= param1.args.neededUIModule.length;
         loadCompleteImp();
      }
      
      private function loadCompleteImp() : void
      {
         var _loc3_:BaseSceneView = null;
         var _loc2_:Function = null;
         var _loc1_:SceneLoaderInfo = getLoadInfoByType(_currentType);
         if(_loc1_.isComplete && _loc1_.state == _currentType)
         {
            _loc3_ = create(_currentType);
            if(_loc3_)
            {
               _loc2_ = _loc1_.callBack;
               _loc2_(_loc3_);
               _loc1_.isComplete = false;
               _loc1_.currentLoaded = 0;
            }
         }
      }
      
      private function onloadProgress(param1:LoaderInfo) : void
      {
         if(!param1.args)
         {
            return;
         }
         if(!param1.args.neededUIModule)
         {
            return;
         }
         var _loc5_:Number = param1.bytesLoaded / param1.bytesTotal;
         var _loc3_:String = ComponentSetting.getMD5FileNameByFilePath(param1.url);
         _progressDic[_loc3_] = _loc5_;
         var _loc4_:Number = 0;
         for each(var _loc2_:Number in _progressDic)
         {
            _loc4_ += _loc2_;
         }
         LoadingSceneView.instance.update(int(_loc4_ / param1.args.neededUIModule.length * 100));
      }
      
      private function getSceneLoadInfo(param1:String, param2:Function) : SceneLoaderInfo
      {
         var _loc3_:* = undefined;
         var _loc4_:SceneLoaderInfo = getLoadInfoByType(param1);
         if(_loc4_ == null)
         {
            _loc4_ = new SceneLoaderInfo();
            _loc3_ = getSceneResources(param1);
            _loc4_.callBack = param2;
            _loc4_.neededUIModule = _loc3_;
            _loc4_.isComplete = false;
            _loc4_.state = param1;
            _state[param1] = _loc4_;
         }
         if(!_loc4_.isComplete)
         {
            _loc4_.neededUIModule = getSceneResources(param1);
         }
         return _loc4_;
      }
      
      private function getLoadInfoByType(param1:String) : SceneLoaderInfo
      {
         return _state[param1];
      }
      
      private function getSceneResources(param1:String) : Vector.<String>
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<String> = new Vector.<String>();
         switch(param1)
         {
            case "CASTLE_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("castlemap1"));
               _loc2_.push(ComponentSetting.getUISourcePath("core"));
               _loc2_.push(ComponentSetting.getUISourcePath("common"));
               _loc2_.push(ComponentSetting.getUISourcePath("castle"));
               _loc2_.push(ComponentSetting.getUISourcePath("queuebar"));
               if(PlayerManager.instance.newbieProcess == 19000)
               {
                  _loc2_.push(PathManager.getNewbieMovieByJob("flytocastle",thane.job));
               }
               break;
            case "CAMPAIGN_MAP_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("map"));
               _loc3_ = CampaignManager.instance.mapModel.mapId;
               if(!WorldBossHelper.checkIsNoviceMap(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("campaign"));
               }
               if(thane.grades >= 12)
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("maze"));
               }
               if(WorldBossHelper.checkPvp(_loc3_) || WorldBossHelper.checkFlameTemple(_loc3_) || WorldBossHelper.checkSvs(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("pvpmap"));
               }
               if(WorldBossHelper.checkSvs(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("svsmap"));
               }
               if(WorldBossHelper.checkBloody(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("molong"));
               }
               if(WorldBossHelper.checkMolong(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("molong"));
               }
               if(WorldBossHelper.checkBloody(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("molong"));
               }
               if(WorldBossHelper.checkInQuizActivity(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("quiz"));
               }
               if(WorldBossHelper.checkMonopoly(_loc3_) || WorldBossHelper.checkConsortiaEmeDream(_loc3_) || WorldBossHelper.checkFlameTemple(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("monopoly"));
               }
               if(WorldBossHelper.checkInHouse(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("farmmap"));
                  _loc2_.push(ComponentSetting.getUISourcePath("farm"));
                  _loc2_.push(ComponentSetting.getUISourcePath("water"));
               }
               if(WorldBossHelper.checkGroupfb(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("groupfbmovie"));
               }
               if(WorldBossHelper.checkDuskArea(_loc3_) || WorldBossHelper.checkIceFireTemple(_loc3_) || WorldBossHelper.checkFlameTemple(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("duskarea"));
               }
               if(WorldBossHelper.checkWorldBoss(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("worldboss"));
               }
               if(WorldBossHelper.checkActiveVehicle(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("vehicle"));
                  _loc2_.push(ComponentSetting.getUISourcePath("snowball"));
                  _loc2_.push(ComponentSetting.getUISourcePath("steelmap"));
               }
               if(WorldBossHelper.checkUnrealShooting(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("vehicle"));
                  _loc2_.push(ComponentSetting.getUISourcePath("steelmap"));
                  _loc2_.push(ComponentSetting.getUISourcePath("unrealshooting"));
               }
               if(WorldBossHelper.checkAirGarden(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("airgarden"));
               }
               if(WorldBossHelper.checkThessBox(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("thessbox"));
               }
               break;
            case "BATTLE_SCENE":
               if(!WorldBossHelper.checkIsNoviceMap(_loc3_))
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("qte"));
               }
               break;
            case "TRAINER_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("novice"));
               break;
            case "PVE_ROOM_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("baseroom"));
               _loc2_.push(ComponentSetting.getUISourcePath("room"));
               break;
            case "PVP_ROOM_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("baseroom"));
               _loc2_.push(ComponentSetting.getUISourcePath("pvproomlist"));
               _loc2_.push(ComponentSetting.getUISourcePath("roompvp"));
               break;
            case "FARM":
               _loc2_.push(ComponentSetting.getUISourcePath("farmmap"));
               _loc2_.push(ComponentSetting.getUISourcePath("farm"));
               _loc2_.push(ComponentSetting.getUISourcePath("water"));
               break;
            case "VEHICLE":
               _loc2_.push(ComponentSetting.getUISourcePath("map"));
               _loc2_.push(ComponentSetting.getUISourcePath("vehicle"));
               _loc2_.push(ComponentSetting.getUISourcePath("vehicleroomlist"));
               _loc2_.push(ComponentSetting.getUISourcePath("campaign"));
               break;
            case "MULTILORDS_ROOM":
               _loc2_.push(ComponentSetting.getUISourcePath("baseroom"));
               _loc2_.push(ComponentSetting.getUISourcePath("warlordsroom"));
               _loc2_.push(ComponentSetting.getUISourcePath("multilordsroom"));
               break;
            case "THESE_Double_PVP_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("baseroom"));
               _loc2_.push(ComponentSetting.getUISourcePath("roompvp"));
               _loc2_.push(ComponentSetting.getUISourcePath("theseuspvp"));
               _loc2_.push(ComponentSetting.getUISourcePath("christmas"));
               _loc2_.push(ComponentSetting.getUISourcePath("campaign"));
               break;
            case "MATELORDS_ROOM":
               _loc2_.push(ComponentSetting.getUISourcePath("baseroom"));
               _loc2_.push(ComponentSetting.getUISourcePath("warlordsroom"));
               _loc2_.push(ComponentSetting.getUISourcePath("matelordsroom"));
               break;
            case "SPACE_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("queuebar"));
               _loc2_.push(ComponentSetting.getUISourcePath("map"));
               _loc2_.push(ComponentSetting.getUISourcePath("campaign"));
               break;
            case "CHANLLENGE_ROOM_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("colosseum"));
               break;
            case "OUTER_CITY_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("map"));
               _loc2_.push(ComponentSetting.getUISourcePath("outercity"));
               _loc2_.push(ComponentSetting.getUISourcePath("maphorse"));
               _loc2_.push(ComponentSetting.getUISourcePath("tips"));
               _loc2_.push(ComponentSetting.getUISourcePath("framebg"));
               break;
            case "PLANES_WAR_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("map"));
               _loc2_.push(ComponentSetting.getUISourcePath("planes"));
               break;
            case "SKYBOX_ROAD_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("skyboxroad"));
               break;
            case "FINAL_DEFENSE_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("finaldefense"));
               break;
            case "ARESLORDS_ROOM":
               _loc2_.push(ComponentSetting.getUISourcePath("baseroom"));
               _loc2_.push(ComponentSetting.getUISourcePath("warlordsroom"));
               _loc2_.push(ComponentSetting.getUISourcePath("areslordsroom"));
               break;
            case "UNREAL_SHOOTING_ROOM":
               _loc2_.push(ComponentSetting.getUISourcePath("map"));
               _loc2_.push(ComponentSetting.getUISourcePath("baseroom"));
               _loc2_.push(ComponentSetting.getUISourcePath("warlordsroom"));
               _loc2_.push(ComponentSetting.getUISourcePath("unrealshootingroom"));
               _loc2_.push(ComponentSetting.getUISourcePath("vehicle"));
               break;
            case "SANDBOX_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("queuebar"));
               _loc2_.push(ComponentSetting.getUISourcePath("map"));
               _loc2_.push(ComponentSetting.getUISourcePath("campaign"));
               if(SandboxManager.instance.isDayLight)
               {
                  _loc2_.push(ComponentSetting.getUISourcePath("daylight"));
               }
               break;
            case "PLANE_CRISRIS":
               _loc2_.push(ComponentSetting.getUISourcePath("map"));
               _loc2_.push(ComponentSetting.getUISourcePath("planecrisis"));
               break;
            case "GAME_HALL_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("map"));
               _loc2_.push(ComponentSetting.getUISourcePath("gamehall"));
               break;
            case "APEX_ROOM":
               _loc2_.push(ComponentSetting.getUISourcePath("baseroom"));
               _loc2_.push(ComponentSetting.getUISourcePath("apexroom"));
               break;
            case "CROSS_GUILD_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("map"));
               _loc2_.push(ComponentSetting.getUISourcePath("crossguild"));
               break;
            case "STARAREA_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("stararea"));
               _loc2_.push(ComponentSetting.getUISourcePath("map"));
               break;
            case "GLORY_GAME_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("baseroom"));
               _loc2_.push(ComponentSetting.getUISourcePath("glorygameroom"));
               break;
            case "INCREASINGLY_ROAD_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("increasinglyroad"));
               break;
            case "SELF_CHESS_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("selfchess"));
               break;
            case "DARK_MAZE_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("darkmaze"));
               break;
            case "SECRET_ADVENTURE_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("map"));
               _loc2_.push(ComponentSetting.getUISourcePath("secretadventure"));
               break;
            case "THESE_PVP_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("theseuspvp"));
               break;
            case "SECRET_WAR_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("secretwar"));
               break;
            case "CHILD_NS_WAR_SCENE":
               _loc2_.push(ComponentSetting.getUISourcePath("theseuspvp"));
               _loc2_.push(ComponentSetting.getUISourcePath("childnswar"));
         }
         return _loc2_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

