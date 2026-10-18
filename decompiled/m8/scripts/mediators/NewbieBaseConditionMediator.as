package mediators
{
   import battle.BattleManager;
   import battle.view.ui.BattleSkillItemII;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.internals.data.BaseCastle;
   import map.internals.data.CampaignNode;
   import map.outercity.manager.OuterCityManager;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.task.TaskTemplate;
   import ui.maintoolbar.MainToolBar;
   import ui.tasktracebar.TaskTraceBar;
   import yishi.actions.hero.HeroLeveUpdateAction;
   import yishi.actions.task.CompleteTaskAction;
   import yishi.datas.BattleModel;
   import yishi.datas.SwitchInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.interfaces.IAction;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   import yishi.manager.GameBaseQueueManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TaskManage;
   import yishi.scene.SceneManager;
   import yishi.scene.SceneType;
   import yishi.view.community.BaseItemView;
   
   public class NewbieBaseConditionMediator
   {
      
      public function NewbieBaseConditionMediator()
      {
         super();
      }
      
      public static function checkPlayerGrade(param1:int) : Boolean
      {
         return ArmyManager.instance.thane.grades >= param1;
      }
      
      public static function checkInScene(param1:int, param2:int = 0) : Boolean
      {
         var _loc3_:CampaignMapModel = null;
         var _loc4_:String = SceneManager.instance.currentType;
         if(_loc4_ == SceneType.getSceneTypeById(param1))
         {
            if(param2 > 0 && _loc4_ == "CAMPAIGN_MAP_SCENE")
            {
               _loc3_ = CampaignManager.instance.mapModel;
               return _loc3_ && _loc3_.mapId == param2;
            }
            return true;
         }
         return false;
      }
      
      public static function checkNotInScene(param1:int, param2:int = 0) : Boolean
      {
         var _loc3_:CampaignMapModel = null;
         var _loc4_:String = SceneManager.instance.currentType;
         if(_loc4_ != SceneType.getSceneTypeById(param1))
         {
            return true;
         }
         if(param2 > 0 && _loc4_ == "CAMPAIGN_MAP_SCENE")
         {
            _loc3_ = CampaignManager.instance.mapModel;
            return !_loc3_ || _loc3_.mapId != param2;
         }
         return false;
      }
      
      public static function checkCastleBuild(param1:int) : Boolean
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(param1);
         var _loc4_:DisplayObject = BuildingManager.instance.castleMap;
         if(_loc2_ && _loc4_)
         {
            _loc3_ = _loc4_["buildingsDic"][_loc2_.buildingId];
            return _loc3_ && _loc3_["curView"] && _loc3_["curView"]["effect_area"];
         }
         return false;
      }
      
      public static function checkTaskIsComplete(param1:int) : Boolean
      {
         var _loc2_:TaskTemplate = TaskManage.instance.getTaskByID(param1);
         return _loc2_ && _loc2_.isCompleted;
      }
      
      public static function checkSkillInfo(param1:int) : Boolean
      {
         return Boolean(ArmyManager.instance.thane.getSkillBySontype(param1));
      }
      
      public static function checkTaskHasCompleted(param1:int) : Boolean
      {
         return TaskManage.instance.IsTaskFinish(param1);
      }
      
      public static function checkFrame(param1:String, param2:String) : Boolean
      {
         var _loc4_:Frame = FrameControllerManager.instance[param1]["frame"];
         var _loc3_:String = "[object " + param2 + "]";
         return _loc4_ && _loc4_.toString() == _loc3_ && _loc4_.stage && _loc4_.visible;
      }
      
      public static function checkCampaignNodeState(param1:int, param2:int) : Boolean
      {
         var _loc4_:CampaignNode = null;
         var _loc3_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc3_)
         {
            _loc4_ = _loc3_.getMapNodeByNodeId(param1);
            return _loc4_ && _loc4_.info.state == param2;
         }
         return false;
      }
      
      public static function checkCampaignNodeView(param1:int, param2:int = -1, param3:int = -1) : Boolean
      {
         var _loc5_:DisplayObject = null;
         var _loc4_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc4_)
         {
            _loc5_ = _loc4_.getNodeByNodeId(param1);
            return _loc5_ && _loc5_.stage && _loc5_.visible && _loc5_["displayWidth"] >= param2 && _loc5_["displayHeight"] >= param3;
         }
         return false;
      }
      
      public static function checkGoodsNum(param1:int, param2:int = 0) : Boolean
      {
         return GoodsManager.instance.getGoodsNumByTempId(param1) >= param2;
      }
      
      public static function checkPlayerBagItemIsExistData(param1:int) : Boolean
      {
         var _loc2_:BaseItemView = FrameControllerManager.instance.armyController.frame["equipBag"].getBaseBagItemByPos(param1);
         return _loc2_ && _loc2_.data;
      }
      
      public static function checkEquipBagItemIsExistData(param1:int) : Boolean
      {
         var _loc2_:BaseItemView = FrameControllerManager.instance.armyController.frame["equipView"].getItemViewByPos(param1);
         return _loc2_ && _loc2_.data;
      }
      
      public static function checkHavePawn(param1:int, param2:int) : Boolean
      {
         return ArmyManager.instance.getTotalPawnsNumberBySonType(param1) >= param2;
      }
      
      public static function checkInCastleOrSpace() : Boolean
      {
         return checkInScene(1) || checkInScene(10);
      }
      
      public static function checkRolesNumInBattle(param1:int, param2:int = 0) : Boolean
      {
         var _loc4_:BattleModel = BattleManager.getInstance().battleModel;
         if(!_loc4_)
         {
            return false;
         }
         var _loc5_:int = 0;
         for each(var _loc3_:RoleInfo in _loc4_.roleList)
         {
            if(param2 == 0 || param2 == _loc3_.side)
            {
               _loc5_++;
            }
         }
         return _loc5_ < param1;
      }
      
      public static function checkNodeIsOccupy(param1:int, param2:int) : Boolean
      {
         var _loc3_:* = OuterCityManager.instance.model.getPhysicsByXY(param1,param2);
         if(_loc3_.info.info.occupyPlayerId == ArmyManager.instance.thane.userId)
         {
            return true;
         }
         return false;
      }
      
      public static function checkTaskProcess(param1:int, param2:int) : Boolean
      {
         for each(var _loc3_:TaskTemplate in TaskManage.instance.cate.acceptedList)
         {
            if(_loc3_.TemplateId == 60)
            {
               if(param2 == 1 && _loc3_.getProgress()[0] == "(1 / 2)")
               {
                  return true;
               }
               return false;
            }
         }
         return false;
      }
      
      public static function checkOuterFrameExist(param1:int) : Boolean
      {
         if(param1 == 1 && OuterCityManager.instance.controler.outerFrameManager.getFrameById(2).parent)
         {
            return true;
         }
         return false;
      }
      
      public static function checkIsInNewbieMap() : Boolean
      {
         var _loc1_:BaseCastle = PlayerManager.instance.currentPlayerModel.mapNodeInfo;
         if(_loc1_ && _loc1_.info.mapId >= 100000000)
         {
            return false;
         }
         return true;
      }
      
      public static function checkCampaignNodeAvatarState(param1:int, param2:int) : Boolean
      {
         var _loc4_:Object = null;
         var _loc3_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc3_)
         {
            _loc4_ = param1 == -1 ? CampaignManager.instance.controller.getArmyVIew(_loc3_.selfMemberData) : _loc3_.getNodeByNodeId(param1);
            return _loc4_ && _loc4_["avatarView"] && _loc4_["avatarView"]["state"] == param2;
         }
         return false;
      }
      
      public static function checkTaskIsCompleteOrCompleted(param1:int) : Boolean
      {
         return checkTaskIsComplete(param1) || checkTaskHasCompleted(param1);
      }
      
      public static function checkSkillInBattle(param1:int) : Boolean
      {
         var _loc4_:BattleSkillItemII = null;
         var _loc2_:* = BattleManager.getInstance().battleUIView;
         var _loc3_:Boolean = _loc2_ && _loc2_.getBottomBar() && _loc2_.getBottomBar().getSkillList() && _loc2_.getBottomBar().getSkillList().skillItemViews;
         if(_loc3_)
         {
            _loc4_ = _loc2_.getBottomBar().getSkillList().skillItemViews[param1];
            return _loc4_ && _loc4_.data;
         }
         return false;
      }
      
      public static function checkConditionCommon(param1:int, param2:String = null, param3:String = null, param4:String = null) : Boolean
      {
         var _loc19_:Frame = null;
         var _loc12_:IAction = null;
         var _loc7_:TaskTraceBar = null;
         var _loc5_:Boolean = false;
         var _loc8_:int = 0;
         var _loc10_:Frame = null;
         var _loc14_:IAction = null;
         var _loc11_:BattleModel = null;
         var _loc15_:String = null;
         var _loc9_:Frame = null;
         var _loc13_:Sprite = null;
         var _loc17_:BaseButton = null;
         var _loc18_:PlayerModel = null;
         var _loc6_:SelectedButton = null;
         var _loc20_:SwitchInfo = null;
         var _loc16_:Frame = null;
         switch(param1)
         {
            case 1:
               _loc19_ = RoomManager.instance.controller ? RoomManager.instance.controller.multiCampaignSelectFrame : null;
               return _loc19_ && _loc19_.stage && _loc19_.visible;
            case 2:
               _loc12_ = GameBaseQueueManager.instance.current;
               return _loc12_ && _loc12_ is CompleteTaskAction && _loc12_["taskTip"] && _loc12_["taskTip"].stage && _loc12_["taskTip"].visible;
            case 3:
               _loc7_ = TaskTraceBar.instance;
               _loc5_ = _loc7_.stage && _loc7_.visible;
               _loc8_ = int(param2);
               if(_loc8_ > 0)
               {
                  return _loc5_ && _loc7_.taskTraceView && _loc7_.taskTraceView["getTraceItemByTaskTempId"](_loc8_);
               }
               return _loc5_;
               break;
            case 4:
               _loc10_ = FrameControllerManager.instance.armyController.casernRecruitFrame;
               return _loc10_ && _loc10_.stage && _loc10_.visible;
            case 5:
               return MainToolBar.instance.recommendBtnIsExist();
            case 6:
               _loc14_ = GameBaseQueueManager.instance.current;
               return _loc14_ && _loc14_ is HeroLeveUpdateAction && !_loc14_.finished && _loc14_["view"] && _loc14_["view"].stage && _loc14_["view"].visible;
            case 7:
               return GoodsManager.instance.getCountBySontypeAndBagType(int(param2),int(param3)) >= int(param4);
            case 8:
               return ArmyManager.instance.thane.templateId == 100;
            case 9:
               return ArmyManager.instance.army.countAllArmyPawnNmber() >= int(param2);
            case 10:
               _loc11_ = BattleManager.getInstance().battleModel;
               return _loc11_ && _loc11_.selfHero && _loc11_.selfHero.canMorph();
            case 11:
               return MainToolBar.ISINIT;
            case 12:
               _loc15_ = SceneManager.instance.currentType;
               return _loc15_ && _loc15_ != "" && _loc15_ != "EMPTY_SCENE";
            case 13:
               _loc9_ = FrameControllerManager.instance.selectCampaignControler.frame;
               if(_loc9_ && _loc9_["areaView"] && _loc9_["areaView"]["cpInfoView"])
               {
                  _loc13_ = _loc9_["areaView"]["cpInfoView"];
                  _loc17_ = _loc13_[param2];
                  return _loc13_.parent && _loc13_.visible && _loc17_ && _loc17_.parent && _loc17_.visible && _loc17_.enable;
               }
               return false;
               break;
            case 14:
               return FriendManager.getInstance().countFriend >= int(param2);
            case 15:
               _loc18_ = PlayerManager.instance.currentPlayerModel;
               return _loc18_ && _loc18_.towerInfo && _loc18_.towerInfo.towerIndex > 0;
            case 16:
               _loc6_ = BattleManager.getInstance().battleUIView ? BattleManager.getInstance().battleUIView.autoFightBtn : null;
               return _loc6_ && _loc6_.parent && _loc6_.visible && _loc6_.enable && _loc6_.selected;
            case 70:
               _loc20_ = ConfigManager.info;
               return _loc20_ && _loc20_[param2];
            case 80:
               return Frame.hasOpenFrame;
            case 84:
               _loc16_ = FrameControllerManager.instance.armyController.frame;
               return _loc16_["vpLockBtn"] != null;
            default:
               return false;
         }
      }
   }
}

