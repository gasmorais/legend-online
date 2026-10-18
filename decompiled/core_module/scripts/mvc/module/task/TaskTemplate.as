package mvc.module.task
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   import events.TaskEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import manager.DesktopManager;
   import manager.LanguageMgr;
   import managers.DragonTitanManager;
   import managers.MarryManager;
   import managers.MountsManager;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.avenger.AvengerDevilArmorHoleInfo;
   import mvc.module.avenger.AvengerModel;
   import mvc.module.avenger.AvengerSkillInfo;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.mounts.MountKingInfo;
   import org.events.DictionaryEvent;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.AvengerManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FinalRoadManager;
   import yishi.manager.FriendManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RevengeRoadManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.TaskManage;
   import yishi.manager.TempleteManager;
   import yishi.manager.WarSoulTowerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   
   public class TaskTemplate extends EventDispatcher implements INotSameHeightListCellData
   {
      
      public var TemplateId:int;
      
      public var TemplateType:int;
      
      public var Title:String;
      
      public var Detail:String;
      
      public var Objective:String;
      
      public var NeedFightId:int;
      
      public var NeedBuildingTemp:int;
      
      public var NeedItemTemp:int;
      
      public var NeedPos:int;
      
      public var NeedMinLevel:int;
      
      public var NeedMaxLevel:int;
      
      public var PreQuestId:String;
      
      public var IsLeague:Boolean;
      
      public var IsAuto:Boolean;
      
      public var IsRepeat:Boolean;
      
      public var IsLost:Boolean;
      
      public var RepeatInterval:int;
      
      public var RepeatMax:int;
      
      public var RewardPlayGP:int;
      
      public var RewardHeroGP:int;
      
      public var RewardGold:int;
      
      public var RewardCrystal:int;
      
      public var RewardDower:int;
      
      public var RewardMoney:int;
      
      public var RewardStrategy:int;
      
      public var RewardConsortiaOffer:int;
      
      public var RewardPlayerOffer:int;
      
      public var StartDate:String;
      
      public var EndDate:String;
      
      public var WeekSpace:String;
      
      public var HourSpace:String;
      
      public var Sort:Number;
      
      public var changeDate:Number;
      
      public var ShowType:int;
      
      public var finishStory:Boolean;
      
      private var _rewardItemList:Array;
      
      private var _conditionList:Array;
      
      public var isRequired:Boolean = false;
      
      public var isNew:Boolean = false;
      
      public var hasCompleted:Boolean = false;
      
      public var taskInfo:TaskInfo;
      
      public var sortFlag:Boolean;
      
      public function TaskTemplate()
      {
         super();
      }
      
      public function initTask() : void
      {
         addGoodList();
         addConditionList();
      }
      
      private function addGoodList() : void
      {
         var _loc1_:Array = TempleteManager.instance.taskGoodTemplateList;
         for each(var _loc2_:TaskGoodsTemplate in _loc1_)
         {
            if(_loc2_.TemplateId == TemplateId)
            {
               addRewardItem(_loc2_);
            }
         }
      }
      
      private function addConditionList() : void
      {
         var _loc1_:Array = TempleteManager.instance.taskCondictionInfoList;
         for each(var _loc2_:TaskCondictionTemplate in _loc1_)
         {
            if(_loc2_.TemplateId == TemplateId)
            {
               addCondition(_loc2_);
            }
         }
      }
      
      private function addRewardItem(param1:TaskGoodsTemplate) : void
      {
         if(!_rewardItemList)
         {
            _rewardItemList = [];
         }
         _rewardItemList.push(param1);
      }
      
      private function addCondition(param1:TaskCondictionTemplate) : void
      {
         if(!_conditionList)
         {
            _conditionList = [];
         }
         _conditionList.push(param1);
      }
      
      public function addConditionListener() : void
      {
         for each(var _loc1_:TaskCondictionTemplate in _conditionList)
         {
            addListenerTo(_loc1_);
         }
      }
      
      public function removeEvent() : void
      {
         thane.removeEventListener("THANE_LEVEL_UPDATE",__taskChangeHandler);
         consortiaInfo.removeEventListener("CONSORTIA_OFFER_CHANGE",__taskChangeHandler);
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__taskChangeHandler);
         BuildingManager.instance.removeEventListener("BUILDING_UPGRADE_RECEIVE",__taskChangeHandler);
         ArmyManager.instance.removeEventListener("upgrade_pawn_success",__taskChangeHandler);
         FriendManager.getInstance().removeEventListener("ADD_FRIEND",__taskChangeHandler);
         FriendManager.getInstance().removeEventListener("REMOVE_FRIEND",__taskChangeHandler);
         goodsCountByTempId.removeEventListener("addDictionary",__goodsCountChangeEvent);
         goodsCountByTempId.removeEventListener("deleteDictionary",__goodsCountChangeEvent);
         goodsCountByTempId.removeEventListener("updateDictionary",__goodsCountChangeEvent);
         NotificationManager.instance.removeEventListener("NEWBIE_PROCESS_UPDATE",__taskChangeHandler);
         ArmyManager.instance.removeEventListener("SORT_PAWN",__taskChangeHandler);
         PlayerManager.instance.removeEventListener("TRANSEFER_CASTLE_SUCCESS",__taskChangeHandler);
         playerModel.towerInfo1.removeEventListener("UPDATE_TOWER_INFO",__taskChangeHandler);
         playerModel.removeEventListener("SYSTIME_UPGRADE_DATE",__taskChangeHandler);
         consortiaModel.removeEventListener("UPDA_CONSORTIA_INFO",__taskChangeHandler);
         NotificationManager.instance.removeEventListener("TALENT_UPGRADE",__taskChangeHandler);
         NotificationManager.instance.removeEventListener("TALENT_RESET",__taskChangeHandler);
         NotificationManager.instance.removeEventListener("DragonTitanEvent.TITAN_DATA",__taskChangeHandler);
         NotificationManager.instance.removeEventListener("TASK_UPDATE",__taskChangeHandler);
         NotificationManager.instance.removeEventListener("REVENGE_ROAD_DATA",__taskChangeHandler);
         MsgMan.removeObserver("BODY_INFO_UPDATE",this,__onBodyInfoChangeHandler);
         thane.removeEventListener("AVENGER_DEGREE_CHANGE",__taskChangeHandler);
      }
      
      private function addListenerTo(param1:TaskCondictionTemplate) : void
      {
         switch(param1.CondictionType)
         {
            case 1:
               thane.addEventListener("THANE_LEVEL_UPDATE",__taskChangeHandler);
               break;
            case 2:
               BuildingManager.instance.addEventListener("BUILDING_UPGRADE_RECEIVE",__taskChangeHandler);
               break;
            case 10:
               ArmyManager.instance.addEventListener("upgrade_pawn_success",__taskChangeHandler);
               break;
            case 21:
               FriendManager.getInstance().addEventListener("ADD_FRIEND",__taskChangeHandler);
               FriendManager.getInstance().addEventListener("REMOVE_FRIEND",__taskChangeHandler);
               break;
            case 22:
               playerInfo.addEventListener("PLAYER_INFO_UPDATE",__taskChangeHandler);
               break;
            case 23:
               NotificationManager.instance.addEventListener("NEWBIE_PROCESS_UPDATE",__taskChangeHandler);
               break;
            case 27:
               goodsCountByTempId.addEventListener("addDictionary",__goodsCountChangeEvent);
               goodsCountByTempId.addEventListener("deleteDictionary",__goodsCountChangeEvent);
               goodsCountByTempId.addEventListener("updateDictionary",__goodsCountChangeEvent);
               break;
            case 28:
               goodsCountByTempId.addEventListener("addDictionary",__goodsCountChangeEvent);
               goodsCountByTempId.addEventListener("deleteDictionary",__goodsCountChangeEvent);
               goodsCountByTempId.addEventListener("updateDictionary",__goodsCountChangeEvent);
               break;
            case 29:
               consortiaInfo.addEventListener("CONSORTIA_OFFER_CHANGE",__taskChangeHandler);
               break;
            case 32:
               goodsCountByTempId.addEventListener("addDictionary",__goodsCountChangeEvent);
               goodsCountByTempId.addEventListener("deleteDictionary",__goodsCountChangeEvent);
               goodsCountByTempId.addEventListener("updateDictionary",__goodsCountChangeEvent);
               break;
            case 34:
               ArmyManager.instance.addEventListener("SORT_PAWN",__taskChangeHandler);
               break;
            case 37:
               PlayerManager.instance.addEventListener("TRANSEFER_CASTLE_SUCCESS",__taskChangeHandler);
            case 38:
               playerModel.towerInfo1.addEventListener("UPDATE_TOWER_INFO",__taskChangeHandler);
               break;
            case 39:
               playerModel.addEventListener("SYSTIME_UPGRADE_DATE",__taskChangeHandler);
               break;
            case 49:
               goodsCountByTempId.addEventListener("addDictionary",__goodsCountChangeEvent);
               goodsCountByTempId.addEventListener("deleteDictionary",__goodsCountChangeEvent);
               goodsCountByTempId.addEventListener("updateDictionary",__goodsCountChangeEvent);
               break;
            case 51:
               consortiaModel.addEventListener("UPDA_CONSORTIA_INFO",__taskChangeHandler);
               break;
            case 76:
               NotificationManager.instance.addEventListener("RUNE_UPGRADE",__taskChangeHandler);
               break;
            case 78:
               NotificationManager.instance.addEventListener("RUNE_UPGRADE",__taskChangeHandler);
               break;
            case 94:
               goodsCountByTempId.addEventListener("addDictionary",__goodsCountChangeEvent);
               goodsCountByTempId.addEventListener("deleteDictionary",__goodsCountChangeEvent);
               goodsCountByTempId.addEventListener("updateDictionary",__goodsCountChangeEvent);
               break;
            case 95:
               playerInfo.addEventListener("DRAGON_SOUL_GRADE",__taskChangeHandler);
               break;
            case 203:
               MountsManager.instance.mountInfo.addEventListener("mountInfoChange",__taskChangeHandler);
               break;
            case 211:
            case 236:
               thane.addEventListener("VOCATION_GRADES",__taskChangeHandler);
               break;
            case 212:
            case 237:
               ArmyManager.instance.addEventListener("TALENT_GRADUP_SUCC",__taskChangeHandler);
               break;
            case 213:
            case 238:
            case 260:
               thane.addEventListener("VOCATION_GRADES",__taskChangeHandler);
               thane.addEventListener("VOCATION_INDEX",__taskChangeHandler);
               break;
            case 215:
               NotificationManager.instance.addEventListener("DragonTitanEvent.TITAN_DATA",__taskChangeHandler);
               break;
            case 217:
               NotificationManager.instance.addEventListener("TASK_UPDATE",__taskChangeHandler);
               break;
            case 239:
               NotificationManager.instance.addEventListener("REVENGE_ROAD_DATA",__taskChangeHandler);
               break;
            case 246:
               MsgMan.addObserver("BODY_INFO_UPDATE",this,__onBodyInfoChangeHandler);
               thane.addEventListener("AVENGER_DEGREE_CHANGE",__taskChangeHandler);
               break;
            case 255:
            case 256:
            case 257:
            case 258:
            case 259:
               thane.addEventListener("VOCATION_GRADES",__taskChangeHandler);
               MsgMan.addObserver("BODY_INFO_UPDATE",this,__onBodyInfoChangeHandler);
               MsgMan.addObserver("SKILL_INFO_UPDATE",this,__onBodyInfoChangeHandler);
               MsgMan.addObserver("DEVIL_ARMOR_INFO_UPDATE",this,__onBodyInfoChangeHandler);
         }
      }
      
      private function get consortiaModel() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return consortiaModel.consortiaInfo;
      }
      
      private function __goodsCountChangeEvent(param1:DictionaryEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TaskCondictionTemplate = null;
         var _loc2_:* = null;
         var _loc3_:int = int(_conditionList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            switch((_loc5_ = _conditionList[_loc4_]).CondictionType)
            {
               case 27:
               case 28:
               case 32:
               case 49:
               case 94:
                  if(_loc5_.Para1 == int(param1.key))
                  {
                     commit();
                     return;
                  }
            }
            _loc4_++;
         }
      }
      
      private function __onBodyInfoChangeHandler(param1:String, param2:Object) : void
      {
         commit();
      }
      
      private function __taskChangeHandler(param1:Event) : void
      {
         commit();
      }
      
      public function commit() : void
      {
         changeDate = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         if(!taskInfo.isComplete && !hasCompleted)
         {
            hasCompleted = isCompleted;
            TaskManage.instance.dispatchEvent(new TaskEvent("task_detail_change",this));
         }
         if(!isCompleted && hasCompleted)
         {
            hasCompleted = false;
            TaskManage.instance.dispatchEvent(new TaskEvent("task_detail_change",this));
         }
         dispatchEvent(new TaskEvent("task_detail_change",this));
      }
      
      public function get taskId() : int
      {
         return taskInfo ? taskInfo.taskId : -1;
      }
      
      public function get isCompleted() : Boolean
      {
         var _loc2_:int = 0;
         if(isAchieved)
         {
            return false;
         }
         var _loc1_:Array = getProgress();
         _loc2_ = 0;
         while(_conditionList[_loc2_] != null)
         {
            if(_loc1_[_loc2_] != LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress"))
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function get isAchieved() : Boolean
      {
         if(!taskInfo || !taskInfo.isAchieved)
         {
            return false;
         }
         return true;
      }
      
      public function get isAvailable() : Boolean
      {
         if(!isAchieved)
         {
            return true;
         }
         if(!IsRepeat)
         {
            return false;
         }
         return true;
      }
      
      public function getProgress() : Array
      {
         var _loc3_:int = 0;
         var _loc4_:TaskCondictionTemplate = null;
         var _loc1_:String = null;
         var _loc5_:Array = [];
         var _loc2_:int = int(_conditionList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            switch((_loc4_ = _conditionList[_loc3_]).CondictionType)
            {
               case 1:
                  _loc1_ = checkPlayerGrades(_loc4_);
                  break;
               case 2:
                  _loc1_ = checkBuildingOrTecGrades(_loc4_);
                  break;
               case 3:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 4:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 5:
                  _loc1_ = checkHeroGrades(_loc4_);
                  break;
               case 6:
                  break;
               case 7:
                  _loc1_ = checkWilanCount(_loc4_,_loc3_);
                  break;
               case 8:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 9:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 10:
                  _loc1_ = checkPawnGrades(_loc4_);
                  break;
               case 11:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 12:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 13:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 14:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 15:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 16:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 17:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 18:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 19:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 20:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 21:
                  _loc1_ = checkFriendsCount(_loc4_);
                  break;
               case 22:
                  _loc1_ = checkJoinConsortia(_loc4_);
                  break;
               case 23:
                  _loc1_ = checkAttack(_loc4_);
                  break;
               case 24:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 25:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 26:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 27:
                  _loc1_ = checkGoodsCount(_loc4_);
                  break;
               case 28:
                  _loc1_ = checkGoodsCount(_loc4_);
                  break;
               case 29:
                  _loc1_ = checkConsortiaOffer(_loc4_);
                  break;
               case 30:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 31:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 32:
                  _loc1_ = checkGoodsCount(_loc4_);
                  break;
               case 33:
                  _loc1_ = checkClientLogin();
                  break;
               case 34:
                  _loc1_ = checkSortPawn();
                  break;
               case 35:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 36:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 37:
                  _loc1_ = checkMapId(_loc4_);
                  break;
               case 38:
                  _loc1_ = checkMazeRecord(_loc4_);
                  break;
               case 39:
                  _loc1_ = checkSencondLogin(_loc4_);
                  break;
               case 40:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 41:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 42:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 43:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 44:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 45:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 46:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 47:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 48:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 49:
                  _loc1_ = checkGoodsCount(_loc4_);
                  break;
               case 50:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 51:
                  _loc1_ = checkConsortuaGrade(_loc4_);
                  break;
               case 52:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 53:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 54:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 55:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 56:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 57:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 58:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 59:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 60:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 61:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 62:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 63:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 64:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 65:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 66:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 67:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 68:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 69:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 70:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 71:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 72:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 74:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 75:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 76:
                  _loc1_ = checkRuneStudy(_loc4_,_loc3_);
                  break;
               case 77:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 78:
                  _loc1_ = checkRuneGrade(_loc4_,_loc3_);
                  break;
               case 79:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 80:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 81:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 82:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 85:
                  _loc1_ = checkFinishPetStory();
                  break;
               case 86:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 87:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 88:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 89:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 90:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 91:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 92:
                  _loc1_ = checkChallengeSelf(_loc4_,_loc3_);
                  break;
               case 93:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 94:
                  _loc1_ = checkGoodsCount(_loc4_);
                  break;
               case 95:
                  _loc1_ = checkDragonSoulGrade(_loc4_);
                  break;
               case 96:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 98:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 97:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 99:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 201:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 202:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 203:
                  _loc1_ = checkMountSoulGrades(_loc4_);
                  break;
               case 204:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 205:
                  _loc1_ = checkMountKingGrade(_loc4_);
                  break;
               case 206:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 207:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 208:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 209:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 210:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 211:
                  _loc1_ = checkVocationGrade(_loc4_,_loc3_);
                  break;
               case 212:
                  _loc1_ = checkTalentLvl(_loc4_,_loc3_);
                  break;
               case 213:
                  _loc1_ = checkChooseBranch(_loc4_,_loc3_);
                  break;
               case 214:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 215:
                  _loc1_ = checkTitanLevel(_loc4_);
                  break;
               case 216:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 217:
                  _loc1_ = checkWhetherMarry();
                  break;
               case 218:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 219:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 220:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 221:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 222:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 223:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 224:
                  _loc1_ = checkCount(_loc4_,_loc3_);
               case 225:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 226:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 227:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 228:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 229:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 230:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 231:
               case 232:
               case 233:
               case 234:
               case 235:
               case 240:
               case 241:
               case 242:
               case 243:
               case 244:
               case 245:
               case 247:
               case 248:
               case 249:
               case 250:
               case 251:
               case 252:
               case 253:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 236:
                  _loc1_ = checkAvengerGrade(_loc4_,_loc3_);
                  break;
               case 237:
                  _loc1_ = checkAvengerTalentLvl(_loc4_,_loc3_);
                  break;
               case 238:
                  _loc1_ = checkAvengerComplete(_loc4_,_loc3_);
                  break;
               case 239:
                  _loc1_ = checkRevengeCurrentId(_loc4_,_loc3_);
                  break;
               case 246:
                  _loc1_ = checkRevengeSoul(_loc4_,_loc3_);
                  break;
               case 254:
                  _loc1_ = checkShadowLand(_loc4_,_loc3_);
                  break;
               case 255:
                  _loc1_ = checkHolyGrade(_loc4_,_loc3_);
                  break;
               case 256:
                  _loc1_ = checkAvengerAllSkill(_loc4_,_loc3_);
                  break;
               case 257:
                  _loc1_ = checkAvengerSoulDegree(_loc4_,_loc3_);
                  break;
               case 258:
                  _loc1_ = checkDevilArmorGrade(_loc4_,_loc3_);
                  break;
               case 259:
                  _loc1_ = checkDevilArmorHole(_loc4_,_loc3_);
                  break;
               case 260:
                  _loc1_ = checkHolyComplete(_loc4_,_loc3_);
                  break;
               case 261:
                  _loc1_ = checkTheseusLv(_loc4_,_loc3_);
                  break;
               case 262:
               case 263:
               case 266:
                  _loc1_ = checkCount(_loc4_,_loc3_);
                  break;
               case 265:
                  _loc1_ = checkSuitN(_loc4_,_loc3_);
                  break;
               case 264:
                  _loc1_ = checkTheseusOne(_loc4_,_loc3_);
                  break;
               case 267:
                  _loc1_ = checkSecretCount(_loc4_,_loc3_);
                  break;
               case 268:
                  _loc1_ = checkWarSoulTowerLevel(_loc4_,_loc3_);
                  break;
               case 269:
                  _loc1_ = checkFinalRoadChapter(_loc4_,_loc3_);
                  break;
               case 270:
               case 271:
               case 272:
               case 273:
                  _loc1_ = checkCount2(_loc4_,_loc3_);
                  break;
               default:
                  _loc1_ = LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
            _loc5_[_loc3_] = _loc1_;
            _loc3_++;
         }
         return _loc5_;
      }
      
      private function checkCount2(param1:TaskCondictionTemplate, param2:int) : String
      {
         if(taskInfo)
         {
            if(taskInfo["condition" + (param2 + 1)] >= param1.Para1)
            {
               return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
            return "(" + taskInfo["condition" + (param2 + 1)] + " / " + param1.Para1 + ")";
         }
         return "";
      }
      
      private function checkWarSoulTowerLevel(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc3_:int = WarSoulTowerManager.instance.model.highestLevel;
         if(_loc3_ >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkFinalRoadChapter(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc3_:int = FinalRoadManager.instance.model.passChapterRecord;
         if(_loc3_ >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkTheseusLv(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc3_:int = RoyaltyBossManager.instance.model.royaltyLevel;
         if(_loc3_ >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkWhetherMarry() : String
      {
         var _loc1_:int = MarryManager.instance.model.marriangeState;
         if(_loc1_ == 3)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkChallengeSelf(param1:TaskCondictionTemplate, param2:int) : String
      {
         if(taskInfo)
         {
            if(taskInfo["condition" + (param2 + 1)] >= param1.Para2)
            {
               return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
         }
         return "";
      }
      
      private function checkFinishPetStory() : String
      {
         if(finishStory)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkPoint(param1:TaskCondictionTemplate) : String
      {
         if(playerInfo.point >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkSencondLogin(param1:TaskCondictionTemplate) : String
      {
         var _loc2_:int = new Date(playerModel.sysCurTimeBySecond * 1000).getDate();
         var _loc3_:int = taskInfo.acceptDate.getDate();
         if(_loc3_ != _loc2_)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkConsortuaGrade(param1:TaskCondictionTemplate) : String
      {
         if(playerInfo.consortiaID <= 0)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
         }
         switch(param1.Para1 - 1)
         {
            case 0:
               if(param1.Para2 <= consortiaInfo.levels)
               {
                  return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
               }
               break;
            case 1:
               if(param1.Para2 <= consortiaInfo.shopLevel)
               {
                  return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
               }
               break;
            case 2:
               if(param1.Para2 <= consortiaInfo.altarLevel)
               {
                  return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
               }
               break;
            case 3:
               if(param1.Para2 <= consortiaInfo.schoolLevel)
               {
                  return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
               }
               break;
            case 4:
               if(param1.Para2 <= consortiaInfo.storeLevel)
               {
                  return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
               }
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkMazeRecord(param1:TaskCondictionTemplate) : String
      {
         if(playerModel.towerInfo1.maxIndex >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkMapId(param1:TaskCondictionTemplate) : String
      {
         if(playerModel.mapNodeInfo.info.mapId == param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkSortPawn() : String
      {
         if(ArmyManager.instance.isSorted)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkAttack(param1:TaskCondictionTemplate) : String
      {
         if(PlayerManager.instance.newbieProcess >= param1.Para1)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkGoodsCount(param1:TaskCondictionTemplate) : String
      {
         var _loc2_:int = int(GoodsManager.instance.goodsCountByTempId[param1.Para1]);
         if(_loc2_ >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + _loc2_ + " / " + param1.Para2 + ")";
      }
      
      private function checkConsortiaOffer(param1:TaskCondictionTemplate) : String
      {
         if(playerInfo.consortiaID <= 0)
         {
            return "(0 / " + param1.Para2 + ")";
         }
         if(playerInfo.consortiaTotalOffer >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + playerInfo.consortiaTotalOffer + " / " + param1.Para2 + ")";
      }
      
      private function checkCampaignProgress(param1:TaskCondictionTemplate) : String
      {
         if(playerInfo.isCompleteCampaign(param1.Para2))
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkClientLogin() : String
      {
         if(DesktopManager.Instance.isDesktop)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return playerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get goodsCountByTempId() : SimpleDictionary
      {
         return GoodsManager.instance.goodsCountByTempId;
      }
      
      private function checkJoinConsortia(param1:TaskCondictionTemplate) : String
      {
         if(playerInfo.consortiaID > 0)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkFriendsCount(param1:TaskCondictionTemplate) : String
      {
         var _loc2_:int = int(FriendManager.getInstance().friendList.getList().length);
         if(_loc2_ >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + _loc2_ + " / " + param1.Para2 + ")";
      }
      
      private function checkPlayerGrades(param1:TaskCondictionTemplate) : String
      {
         if(thane.grades >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + thane.grades + " / " + param1.Para2 + ")";
      }
      
      private function checkBuildingOrTecGrades(param1:TaskCondictionTemplate) : String
      {
         var _loc2_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(param1.Para1);
         if(_loc2_ && _loc2_.templeteInfo.BuildingGrade >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         if(!_loc2_)
         {
            return "(0 / " + param1.Para2 + ")";
         }
         return "(" + _loc2_.templeteInfo.BuildingGrade + " / " + param1.Para2 + ")";
      }
      
      private function checkHeroGrades(param1:TaskCondictionTemplate) : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = param1.Para2;
         if(param1.Para1 == 0 || thane.templateInfo.Job == param1.Para1)
         {
            if(thane.grades >= _loc3_)
            {
               return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
            if(thane.grades > _loc2_)
            {
               _loc2_ = thane.grades;
            }
         }
         return "(" + _loc2_ + " / " + _loc3_ + ")";
      }
      
      private function checkWilanCount(param1:TaskCondictionTemplate, param2:int) : String
      {
         if(int(taskInfo["condition" + (param2 + 1)]) >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + taskInfo["condition" + (param2 + 1)] + " / " + param1.Para2 + ")";
      }
      
      private function checkPawnGrades(param1:TaskCondictionTemplate) : String
      {
         var _loc2_:int = 0;
         var _loc4_:Array = ArmyManager.instance.casernPawnList.getList();
         for each(var _loc3_:ArmyPawn in _loc4_)
         {
            if(_loc3_.templateInfo.MasterType == param1.Para1)
            {
               if(_loc3_.templateInfo.Level >= param1.Para2)
               {
                  return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
               }
               if(_loc3_.templateInfo.Level > _loc2_)
               {
                  _loc2_ = _loc3_.templateInfo.Level;
               }
            }
         }
         return "(" + _loc2_ + " / " + param1.Para2 + ")";
      }
      
      private function checkCount(param1:TaskCondictionTemplate, param2:int) : String
      {
         if(taskInfo)
         {
            if(taskInfo["condition" + (param2 + 1)] >= param1.Para2)
            {
               return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
            return "(" + taskInfo["condition" + (param2 + 1)] + " / " + param1.Para2 + ")";
         }
         return "";
      }
      
      private function checkSecretCount(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc3_:int = SecretAdventerManager.Instance.model.frameInfo.passMapId;
         if(_loc3_ >= param1.Para1)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkTheseusSuit(param1:TaskCondictionTemplate, param2:int) : String
      {
         if(taskInfo)
         {
            if(taskInfo["condition" + (param2 + 1)] >= param1.Para3)
            {
               return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
            return "(" + taskInfo["condition" + (param2 + 1)] + " / " + param1.Para3 + ")";
         }
         return "";
      }
      
      private function checkSuitN(param1:TaskCondictionTemplate, param2:int) : String
      {
         if(taskInfo)
         {
            if(taskInfo["condition" + (param2 + 1)] >= param1.Para2)
            {
               return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
         }
         return " ";
      }
      
      private function checkTheseusOne(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc3_:int = 0;
         if(taskInfo)
         {
            _loc3_ = 1;
            if(taskInfo["condition" + (param2 + 1)] >= _loc3_)
            {
               return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
            return "(" + taskInfo["condition" + (param2 + 1)] + " / " + _loc3_ + ")";
         }
         return "";
      }
      
      private function checkVocationGrade(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc3_:int = playerInfo.vocationGrades;
         if(_loc3_ == 80 || playerInfo.vocationIndex > 0)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + _loc3_ + " / " + 80 + ")";
      }
      
      private function checkAvengerGrade(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc3_:int = playerInfo.vocationGrades;
         if(_loc3_ == 80 && playerInfo.vocationIndex > 0)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + _loc3_ + " / " + 80 + ")";
      }
      
      private function checkRevengeCurrentId(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc3_:int = RevengeRoadManager.Ins.model.nodeId;
         if(_loc3_ >= 10)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(0 / " + param1.Para2 + ")";
      }
      
      private function checkRevengeSoul(param1:TaskCondictionTemplate, param2:int) : String
      {
         if(thane.avengerDegree >= 1)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(0 / " + param1.Para2 + ")";
      }
      
      private function checkAvengerTalentLvl(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc3_:int = thane.talentData.talentGrade;
         if(_loc3_ >= param1.Para2 && playerInfo.vocationIndex > 0)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + _loc3_ + " / " + param1.Para2 + ")";
      }
      
      private function checkTalentLvl(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc4_:int = thane.talentData.talentGrade;
         var _loc3_:int = thane.talentData.advTalentGrade;
         if(_loc4_ == 179 && _loc3_ == 50)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + _loc4_ + " / " + 179 + "," + _loc3_ + " / " + 50 + ")";
      }
      
      private function checkChooseBranch(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc3_:int = playerInfo.vocationIndex;
         if(_loc3_ > 0)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkAvengerComplete(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc3_:int = playerInfo.vocationIndex;
         if(_loc3_ >= 3)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkRuneStudy(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc3_:int = 0;
         if(taskInfo)
         {
            if(param1.Para1 == 0)
            {
               _loc3_ = thane.runeCate.getCurrentStudyCount();
            }
            else
            {
               _loc3_ = thane.runeCate.getRuneInfoByRuneType(param1.Para1).grade;
            }
            if(_loc3_ >= param1.Para2)
            {
               return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
            return "(" + _loc3_ + " / " + param1.Para2 + ")";
         }
         return "";
      }
      
      private function checkRuneGrade(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc3_:int = 0;
         if(taskInfo)
         {
            if(param1.Para1 == 0)
            {
               _loc3_ = thane.runeCate.getMaxGradeRuneInfo().grade;
            }
            else
            {
               _loc3_ = thane.runeCate.getRuneInfoByRuneType(param1.Para1).grade;
            }
            if(_loc3_ >= param1.Para2)
            {
               return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
            return "(" + _loc3_ + " / " + param1.Para2 + ")";
         }
         return "";
      }
      
      private function checkDragonSoulGrade(param1:TaskCondictionTemplate) : String
      {
         var _loc2_:int = 0;
         if(playerInfo.dragonSoulType == 102)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         _loc2_ = playerInfo.dragonSoulGrade;
         if(_loc2_ >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + _loc2_ + " / " + param1.Para2 + ")";
      }
      
      private function checkMountSoulGrades(param1:TaskCondictionTemplate) : String
      {
         if(MountsManager.instance.mountInfo.grade >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkMountKingGrade(param1:TaskCondictionTemplate) : String
      {
         var _loc2_:Dictionary = MountsManager.instance.avatarList.kingMountDic;
         for each(var _loc3_:MountKingInfo in _loc2_)
         {
            if(_loc3_ && _loc3_.grade >= param1.Para2)
            {
               return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      private function checkTitanLevel(param1:TaskCondictionTemplate) : String
      {
         var _loc2_:int = DragonTitanManager.instance.model.starLevel;
         if(_loc2_ >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + _loc2_ + " / " + param1.Para2 + ")";
      }
      
      private function checkShadowLand(param1:TaskCondictionTemplate, param2:int) : String
      {
         if(taskInfo)
         {
            if(taskInfo["condition" + (param2 + 1)] >= param1.Para3)
            {
               return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            }
            return "(" + taskInfo["condition" + (param2 + 1)] + " / " + param1.Para3 + ")";
         }
         return "";
      }
      
      private function checkHolyGrade(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc3_:int = playerInfo.vocationGrades;
         if(_loc3_ == 30 && playerInfo.isAvenger)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + _loc3_ + " / " + param1.Para2 + ")";
      }
      
      private function checkAvengerAllSkill(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc3_:int = 0;
         for each(var _loc4_:AvengerSkillInfo in avengerModel.skillDic)
         {
            if(_loc4_.skillTemp && _loc4_.skillTemp.Grades >= param1.Para2)
            {
               _loc3_++;
            }
         }
         if(_loc3_ >= 6)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + _loc3_ + " / " + 6 + ")";
      }
      
      private function checkAvengerSoulDegree(param1:TaskCondictionTemplate, param2:int) : String
      {
         if(avengerModel.bodyInfo.degree >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + avengerModel.bodyInfo.degree + " / " + param1.Para2 + ")";
      }
      
      private function checkDevilArmorGrade(param1:TaskCondictionTemplate, param2:int) : String
      {
         if(avengerModel.devilArmorInfo.grade >= param1.Para2)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + avengerModel.devilArmorInfo.grade + " / " + param1.Para2 + ")";
      }
      
      private function checkDevilArmorHole(param1:TaskCondictionTemplate, param2:int) : String
      {
         var _loc3_:int = 0;
         for each(var _loc4_:AvengerDevilArmorHoleInfo in avengerModel.devilArmorInfo.holeDic)
         {
            if(_loc4_.grade >= param1.Para2)
            {
               _loc3_++;
            }
         }
         if(_loc3_ >= 6)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return "(" + _loc3_ + " / " + 6 + ")";
      }
      
      private function checkHolyComplete(param1:TaskCondictionTemplate, param2:int) : String
      {
         if(playerInfo.isHoly)
         {
            return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         }
         return LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress01");
      }
      
      public function get rewardItemList() : Array
      {
         return _rewardItemList;
      }
      
      public function get conditionList() : Array
      {
         return _conditionList;
      }
      
      private function get avengerModel() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      public function getCellHeight() : Number
      {
         if(isCompleted)
         {
            return 43;
         }
         return 36;
      }
   }
}

