package battle.handler
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import battle.skillsys.helper.BloodHelper;
   import battle.view.battleresult.BaseBattleResultView;
   import battle.view.battleresult.FailedBattleResultView;
   import battle.view.battleresult.FailedBattleResultViewSimple;
   import battle.view.battleresult.FailedOutyardBattleResultView;
   import battle.view.battleresult.VicotyBattleResultView;
   import battle.view.battleresult.VicotyBattleResultViewSimple;
   import battle.view.battleresult.VicotyOutyardBattleResultView;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.battle.BaseItemMsg;
   import com.road.yishi.proto.battle.BattleReportMsg;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.ChallengeManager;
   import managers.DarkMazeManager;
   import managers.GameHallManager;
   import managers.IncreasinglyRoadManager;
   import managers.SkyboxRoadManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.internals.MapData;
   import map.internals.data.MapInitData;
   import map.space.SpaceManager;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.maze.MazeModel;
   import mvc.module.stararea.StarareaManager;
   import mvc.module.war2023.info.SecretwarResultInfo;
   import sandbox.SandboxManager;
   import yishi.SwitchPageHelp;
   import yishi.actions.consortia.GuildFBBattleAction;
   import yishi.actions.consortia.GuildWantedBattleAction;
   import yishi.actions.map.MultiFailedAlertAction;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.datas.battle.BatterModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.BaseManager;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlaneCrisisManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.SecretWarManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DelayActionsUtils;
   import yishi.utils.TimerUtils;
   import yishi.utils.WorldBossHelper;
   
   public class BattleResultHandler
   {
      
      private var combat:int;
      
      private var _battlePkg:PackageIn;
      
      private var _battleMsg:BattleReportMsg;
      
      private var _resultView:BaseBattleResultView;
      
      private var _resultViewData:Array;
      
      private var goods:Array;
      
      private var _signId:String;
      
      private var _pos:Point;
      
      private var _waitCount:int;
      
      private var _preScent:String;
      
      private var _tme:Number = 0;
      
      public function BattleResultHandler()
      {
         super();
      }
      
      public static function exitBattle(param1:String = "default", param2:int = 1, param3:Object = null) : String
      {
         var _loc4_:Date = null;
         var _loc8_:Date = null;
         var _loc6_:* = null;
         var _loc5_:SecretwarResultInfo = null;
         var _loc11_:MapInitData = null;
         var _loc9_:BaseArmy = null;
         var _loc14_:int = 0;
         BloodHelper.setup();
         if(param1 == "default")
         {
            param1 = BattleManager.preScene;
         }
         var _loc10_:String = param1 != "" ? param1 : SwitchPageHelp.returnScene;
         var _loc7_:BattleModel = BattleManager.getInstance().battleModel;
         var _loc12_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc12_ && WorldBossHelper.checkInAnyMaze(_loc12_.mapId) && param3.battleResult == 2)
         {
            MazeModel.instance.isAuto = false;
         }
         BattleManager.getInstance().plotHandler.inactive();
         if(BattleManager.getInstance().battleScene)
         {
            NotificationManager.instance.addEventListener("SCENE_SWITCH_CALL",sceneSwitchCallHandler);
         }
         else
         {
            exitBattleComplete();
         }
         if(_loc7_ == null)
         {
            return "";
         }
         if(_loc7_.battleType == 293)
         {
            SkyboxRoadManager.instance.getData();
            return "SKYBOX_ROAD_SCENE";
         }
         if(_loc7_.battleType == 3893)
         {
            IncreasinglyRoadManager.instance.getData();
            return "INCREASINGLY_ROAD_SCENE";
         }
         if(_loc7_.battleType == 3878)
         {
         }
         if(_loc7_.battleType == 3898)
         {
            if(DarkMazeManager.instance.model.passDarkMaze || DarkMazeManager.instance.model.isOver())
            {
               SceneManager.instance.setScene("SPACE_SCENE");
            }
            else
            {
               _loc4_ = DarkMazeManager.instance.model.findNearResetTime();
               _loc8_ = PlayerManager.instance.currentPlayerModel.sysCurtime;
               if(DarkMazeManager.instance.model.isCanRefresh())
               {
                  if(_loc4_ && _loc8_ && _loc4_.time - _loc8_.time < 1800000)
                  {
                     SceneManager.instance.setScene("SPACE_SCENE");
                  }
                  else
                  {
                     DarkMazeManager.instance.enterScene();
                  }
               }
               else
               {
                  DarkMazeManager.instance.enterScene();
               }
            }
            return "DARK_MAZE_SCENE";
         }
         if(_loc7_)
         {
            switch(_loc7_.battleType)
            {
               case 1:
               case 2:
               case 3:
               case 4:
               case 5:
                  _loc10_ = "OUTER_CITY_SCENE";
                  break;
               case 16:
               case 35:
               case 3844:
                  _loc10_ = SwitchPageHelp.returnScene;
                  break;
               case 293:
                  _loc10_ = "SKYBOX_ROAD_SCENE";
                  break;
               case 3893:
                  _loc10_ = "INCREASINGLY_ROAD_SCENE";
                  break;
               case 3898:
                  _loc10_ = "DARK_MAZE_SCENE";
                  break;
               case 291:
                  if(param1 == "CAMPAIGN_MAP_SCENE")
                  {
                     _loc10_ = "CAMPAIGN_MAP_SCENE";
                  }
                  else
                  {
                     _loc10_ = SwitchPageHelp.returnScene;
                  }
               case 17:
               case 19:
               case 22:
               case 23:
               case 20:
               case 306:
               case 307:
                  _loc10_ = "CAMPAIGN_MAP_SCENE";
                  break;
               case 3841:
                  _loc10_ = "OUTER_CITY_SCENE";
                  break;
               case 3843:
                  if(PlanesWarManager.instance.model.isInPlanesWar == false)
                  {
                     _loc10_ = "CASTLE_SCENE";
                  }
                  else
                  {
                     _loc10_ = "PLANES_WAR_SCENE";
                  }
                  break;
               case 3876:
                  if(SandboxManager.instance.exit)
                  {
                     _loc10_ = "SPACE_SCENE";
                  }
                  else
                  {
                     _loc10_ = "SANDBOX_SCENE";
                  }
                  break;
               case 3877:
                  if(PlaneCrisisManager.Instance.exit)
                  {
                     if(GameHallManager.instance.model.selfTeam)
                     {
                        _loc10_ = "GAME_HALL_SCENE";
                     }
                     else
                     {
                        _loc10_ = "SPACE_SCENE";
                     }
                  }
                  else
                  {
                     _loc10_ = "PLANE_CRISRIS";
                  }
                  break;
               case 3886:
                  if(GameHallManager.instance.model.selfTeam)
                  {
                     _loc10_ = "GAME_HALL_SCENE";
                  }
                  else
                  {
                     _loc10_ = "SPACE_SCENE";
                  }
                  break;
               case 296:
                  if(CrossGuildManager.instance.model.isInCrossGuildWar && PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID != 0)
                  {
                     _loc10_ = "CROSS_GUILD_SCENE";
                  }
                  else
                  {
                     _loc10_ = SwitchPageHelp.returnScene;
                  }
                  break;
               case 3881:
                  DelayActionsUtils.instance.addAction(new GuildFBBattleAction());
                  break;
               case 3890:
                  DelayActionsUtils.instance.addAction(new GuildWantedBattleAction());
                  break;
               case 3892:
                  if(StarareaManager.instance.isExit)
                  {
                     _loc10_ = "SPACE_SCENE";
                  }
                  else
                  {
                     _loc10_ = "STARAREA_SCENE";
                  }
                  break;
               case 3886:
                  if(GameHallManager.instance.model.selfTeam == null)
                  {
                     _loc10_ = "SPACE_SCENE";
                  }
                  break;
               case 349:
                  _loc10_ = "SELF_CHESS_SCENE";
                  break;
               case 3904:
                  if(SecretAdventerManager.Instance.gotoSpace)
                  {
                     _loc10_ = "SPACE_SCENE";
                  }
                  else
                  {
                     _loc10_ = "SECRET_ADVENTURE_SCENE";
                  }
                  break;
               case 3907:
                  _loc10_ = "THESE_PVP_SCENE";
                  break;
               case 3912:
                  _loc10_ = "THESE_Double_PVP_SCENE";
                  break;
               case 3908:
                  _loc5_ = SecretWarManager.Instance.model.resultInfo;
                  if(_loc5_ && !_loc5_.isOver)
                  {
                     _loc10_ = "SECRET_WAR_SCENE";
                  }
                  else
                  {
                     _loc10_ = SwitchPageHelp.returnScene;
                  }
                  break;
               case 3911:
                  _loc10_ = "CHILD_NS_WAR_SCENE";
               case 3915:
               case 3913:
                  _loc10_ = "SPACE_SCENE";
            }
         }
         var _loc13_:Object = {};
         _loc13_.isShowLoading = false;
         if(_loc7_.battleType == 16)
         {
            if(ChallengeManager.instance.isLogin)
            {
               SceneManager.instance.setScene("CHANLLENGE_ROOM_SCENE");
            }
            else
            {
               SceneManager.instance.setScene("SPACE_SCENE");
            }
            return "";
         }
         if((_loc10_ == "CAMPAIGN_MAP_SCENE" || SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE") && CampaignManager.instance.mapModel == null)
         {
            _loc10_ = SwitchPageHelp.returnScene;
         }
         if(!_loc7_ && PlayerManager.instance.newbieProcess < 19000)
         {
            return _loc10_;
         }
         if(_loc10_ == "SPACE_SCENE" && SpaceManager.instance.exit)
         {
            return "";
         }
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            if(_loc7_.battleType == 16)
            {
               _loc13_.isOpenColosseum = true;
            }
            else if(_loc7_.battleType == 35)
            {
               _loc13_.isOpenPetChallenge = true;
            }
            else if(_loc7_.battleType == 3844)
            {
               _loc13_.isOpenRemotePet = true;
            }
            else if(_loc7_.battleType == 3845)
            {
               _loc13_.isOpenChildPve = true;
            }
            else if(_loc7_.battleType == 3847)
            {
               _loc13_.isOpenChildArena = true;
            }
            else if(_loc7_.battleType == 3851)
            {
               _loc13_.isOpenPerkinLab = true;
            }
            else if(_loc7_.battleType == 3855)
            {
               _loc13_.isOutyardBattle = true;
            }
            else if(_loc7_.battleType == 3858)
            {
               _loc13_.isOutyardExploreBattle = true;
            }
            else if(_loc7_.battleType == 3857)
            {
               _loc13_.isOutyardExploreBattle = true;
            }
            else if(_loc7_.battleType == 3860)
            {
               _loc13_.isTitanTempleBattle = true;
            }
            else if(_loc7_.battleType == 3864)
            {
               _loc13_.isShuttleBattle = true;
            }
            else if(_loc7_.battleType == 3865)
            {
               _loc13_.isShuttleBattle = true;
            }
            else if(_loc7_.battleType == 296)
            {
               _loc13_.isCrossGuildBattle = true;
            }
            else if(_loc7_.battleType == 3861)
            {
               _loc13_.isCrossBraveBattle = true;
            }
            else if(_loc7_.battleType == 3863)
            {
               _loc13_.isGloryRoadBattle = true;
            }
            else if(_loc7_.battleType == 3867)
            {
               _loc13_.isAbysmBattle = true;
            }
            else if(_loc7_.battleType == 3869)
            {
               _loc13_.isLordTrial = true;
            }
            else if(_loc7_.battleType == 3875)
            {
               _loc13_.isDragonTalker = true;
            }
            else if(_loc7_.battleType == 3873 || _loc7_.battleType == 3874)
            {
               _loc13_.isOpenTimeVortex = true;
            }
            else if(_loc7_.battleType == 3872)
            {
               if(FrameControllerManager.instance.timeVortexController.isOpenMainFrame)
               {
                  _loc13_.isOpenTimeVortex = true;
               }
            }
            else if(_loc7_.battleType == 3879)
            {
               _loc13_.isOpenEclipticPalace = true;
            }
            else if(_loc7_.battleType == 3880)
            {
               _loc13_.isOpenDemonLand = true;
            }
            else if(_loc7_.battleType == 3884)
            {
               _loc13_.isMonsterExplore = true;
            }
            else if(_loc7_.battleType == 3885)
            {
               _loc13_.isOpenDreamArena = true;
            }
            else if(_loc7_.battleType == 3887)
            {
               _loc13_.isOpenRevengeRoad = true;
            }
            else if(_loc7_.battleType == 3888)
            {
               _loc13_.isOpenRedemptionRoad = true;
            }
            else if(_loc7_.battleType == 3889)
            {
               _loc13_.isHellAbysmBattle = true;
            }
            else if(_loc7_.battleType == 3895)
            {
               _loc13_.isExpeditionBattle = true;
            }
            else if(_loc7_.battleType == 3896)
            {
               _loc13_.isYLExpidtionBattle = true;
            }
            else if(_loc7_.battleType == 3897)
            {
               _loc13_.isShadowLandBattle = true;
            }
            else if(_loc7_.battleType == 3899 || _loc7_.battleType == 3900)
            {
               _loc13_.isRemainsExploreBattle = true;
            }
            else if(_loc7_.battleType == 3901)
            {
               _loc13_.isConsortiaNewBossBattle = true;
            }
            else if(_loc7_.battleType == 3902)
            {
               _loc13_.isRoyaltyBossBattle = true;
            }
            else if(_loc7_.battleType == 3905)
            {
               _loc13_.isWarSoulTowerBattle = true;
            }
            else if(_loc7_.battleType == 3906)
            {
               _loc13_.isFinalRoadBattle = true;
            }
            else if(_loc7_.battleType == 3908)
            {
               _loc13_.isSecretwarResult = true;
               _loc13_.isOpenNode = true;
            }
            else if(_loc7_.battleType == 3909)
            {
               _loc13_.isMinosMap = true;
            }
            else if(_loc7_.battleType == 3910)
            {
               _loc13_.chesspvp = true;
            }
            else if(_loc7_.battleType == 3913)
            {
               _loc13_.thesetower = true;
            }
            else if(_loc7_.battleType == 3914)
            {
               _loc13_.thessbox = true;
            }
            else if(_loc7_.battleType == 3915)
            {
               _loc13_.dungeonexplo = true;
            }
         }
         SceneManager.instance.lock = false;
         if(_loc10_ == "OUTER_CITY_SCENE")
         {
            _loc11_ = new MapInitData();
            _loc9_ = ArmyManager.instance.army;
            if(MapData.movePos)
            {
               _loc11_.targetPoint = MapData.movePos;
            }
            else
            {
               _loc11_.targetPoint = new Point(_loc9_.curPosX * 20,_loc9_.curPosY * 20);
            }
            _loc14_ = PlayerManager.instance.currentPlayerModel.mapNodeInfo.info.mapId;
            _loc11_.mapTempInfo = TempleteManager.instance.mapTemplateCate.getTemplateByID(_loc14_);
            _loc11_.showMapName = false;
            _loc11_.isShowLoading = false;
            SceneManager.instance.setScene(_loc10_,_loc11_,false,true);
         }
         else
         {
            SceneManager.instance.setScene(_loc10_,_loc13_,false,true);
         }
         return _loc10_;
      }
      
      private static function sceneSwitchCallHandler(param1:Event) : void
      {
         KeyBoardRegister.instance.battleFlag = false;
         exitBattleComplete();
         NotificationManager.instance.removeEventListener("SCENE_SWITCH_CALL",sceneSwitchCallHandler);
      }
      
      private static function exitBattleComplete() : void
      {
         NotificationManager.instance.dispatchEvent(new BattleEvent("battleComplete",null));
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      private function get battlerModel() : BatterModel
      {
         return BattleManager.getInstance().batterModel;
      }
      
      public function handler(param1:PackageIn) : void
      {
         var _loc3_:int = 0;
         if(BattleManager.selfDie)
         {
            return;
         }
         if(battleModel)
         {
            if(battleModel.battleId == BaseManager.instance.preBattleId)
            {
               return;
            }
            BaseManager.instance.preBattleId = battleModel.battleId;
         }
         BattleManager.isExitingBattle = true;
         if(PlayerManager.instance.loginState < 0)
         {
            return;
         }
         if(battleModel)
         {
            if(battleModel.battleType == 6 || battleModel.battleCapity == 4)
            {
               if(battlerModel)
               {
                  _loc3_ = battlerModel.maxBatterCount;
                  if(_loc3_ > 2)
                  {
                     SocketSendManager.instance.sendBattleCount(_loc3_);
                  }
               }
            }
         }
         _battlePkg = param1;
         _battleMsg = new BattleReportMsg();
         _battleMsg = _battlePkg.readBody(_battleMsg) as BattleReportMsg;
         readPkg();
         var _loc2_:String = LanguageMgr.GetTranslation("battle.handler.BattleResultHandler.debug01");
         if(!battleModel)
         {
            _loc2_ = LanguageMgr.GetTranslation("battle.handler.BattleResultHandler.debug02");
            return;
         }
         checkExecuteAbled();
      }
      
      private function checkExecuteAbled() : void
      {
         if(_waitCount > 100 || BattleManager.getInstance().isAllSkillExecuted())
         {
            execute();
         }
         else
         {
            TimerUtils.setTimeout(checkExecuteAbled,30);
            _waitCount = _waitCount + 1;
         }
      }
      
      private function execute() : void
      {
         var _loc2_:int = 1;
         var _loc1_:int = 1;
         if(battleModel)
         {
            _loc2_ = battleModel.selfHero.side;
            if(combat != 1)
            {
               if(_loc2_ == 1)
               {
                  _loc2_ = 2;
               }
               else
               {
                  _loc2_ = 1;
               }
            }
            if(battleModel.isAllDead())
            {
               battleModel.playVictoryAction(_loc2_);
            }
            if(_loc2_ == 1)
            {
               _loc1_ = 2;
            }
            if(battleModel.battleType == 35)
            {
               battleModel.playDefeatedAction(_loc1_);
            }
            else if(battleModel.battleType == 307)
            {
               battleModel.monopolyPlayDefeatedAction(_loc1_);
            }
            else if(battleModel.battleType == 313)
            {
               battleModel.monopolyPlayDefeatedAction(_loc1_);
            }
         }
         showNewVersionPane();
         if(battleModel)
         {
            battleModel.isOver = true;
            NotificationManager.instance.sendNotification("SKILL_ENABLE",false);
         }
      }
      
      private function showNewVersionPane() : void
      {
         _tme = getTimer();
         _preScent = BattleManager.preScene;
         clearView();
         SoundManager.instance.stopMusic();
         var _loc1_:Boolean = BattleManager.getInstance().battleScene ? true : false;
         if(combat == 1 && _loc1_)
         {
            SoundManager.instance.play("033");
            NotificationManager.instance.dispatchEvent(new NotificationEvent("BATTLE_RESULT",true));
            try
            {
               if(battleModel.battleType == 3855)
               {
                  _resultView = new VicotyOutyardBattleResultView();
               }
               else if(needDetailInfo())
               {
                  _resultView = new VicotyBattleResultView();
               }
               else
               {
                  _resultView = new VicotyBattleResultViewSimple();
               }
            }
            catch(e:Error)
            {
               exitDirect();
               return;
            }
         }
         else
         {
            if(!(combat == 2 && _loc1_))
            {
               exitDirect();
               return;
            }
            NotificationManager.instance.dispatchEvent(new NotificationEvent("BATTLE_RESULT",false));
            try
            {
               if(battleModel.battleType == 3855)
               {
                  _resultView = new FailedOutyardBattleResultView();
               }
               else if(needDetailInfo())
               {
                  _resultView = new FailedBattleResultView();
               }
               else
               {
                  _resultView = new FailedBattleResultViewSimple();
               }
            }
            catch(e:Error)
            {
               exitDirect();
               return;
            }
         }
         _tme = getTimer();
         _resultView.setData(_resultViewData);
         _resultView.autoCloseFun = resultViewCloseFun;
         _resultView.show();
      }
      
      private function needDetailInfo() : Boolean
      {
         if(battleModel)
         {
            if(battleModel.battleType == 16 || battleModel.battleType == 10)
            {
               return true;
            }
         }
         return false;
      }
      
      private function exitDirect() : void
      {
         resultViewCloseFun();
         NotificationManager.instance.dispatchEvent(new BattleEvent("battleCancel",null));
      }
      
      private function resultViewCloseFun() : void
      {
         var _loc2_:String = _preScent != "" ? _preScent : SwitchPageHelp.returnScene;
         var _loc1_:BattleModel = BattleManager.getInstance().battleModel;
         exitBattle(_loc2_,combat,_battleMsg);
         clearView();
         BattleManager.exitFlag = true;
         BattleManager.loginToBattleFlag = false;
         if(!SharedManager.instance.multiFailded)
         {
            if(_battleMsg && _battleMsg.battleResult == 2 && _battleMsg.failCount > 4)
            {
               DelayActionsUtils.instance.addAction(new MultiFailedAlertAction());
            }
         }
      }
      
      private function clearView() : void
      {
         if(_resultView)
         {
            if(!_resultView.disposed)
            {
               _resultView.dispose();
            }
         }
         _resultView = null;
      }
      
      private function readPkg() : void
      {
         var _loc5_:BaseItemMsg = null;
         var _loc4_:int = 0;
         var _loc2_:GoodsInfo = null;
         _resultViewData = [];
         combat = _battleMsg.battleResult;
         _resultViewData.push(_battleMsg.gpBonus);
         var _loc1_:int = int(_battleMsg.petGpBonus > 0 ? _battleMsg.petGpBonus : 0);
         _resultViewData.push(_loc1_);
         _resultViewData.push(_battleMsg.param1);
         _resultViewData.push(_battleMsg.param2);
         goods = [];
         var _loc3_:int = int(_battleMsg.baseItem.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _battleMsg.baseItem[_loc4_] as BaseItemMsg;
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _loc5_.templateId;
            _loc2_.count = _loc5_.count;
            goods.push(_loc2_);
            _loc4_++;
         }
         if(_loc3_ > 0)
         {
            _signId = _battleMsg.signId;
            _pos = new Point(_battleMsg.posX,_battleMsg.posY);
         }
      }
   }
}

