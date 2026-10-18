package mvc.module.childpatrol
{
   import flash.utils.Dictionary;
   import managers.ChildManager;
   import managers.ChildPatrolManager;
   import mvc.module.children.ChildData;
   import yishi.datas.templates.ChildPatrolMissionTemplateInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class ChildPatrolModel
   {
      
      public var idleTowerCount:int;
      
      public var totalTowerCount:int;
      
      public var hasHelpCount:int;
      
      public var curUserId:int;
      
      public var headQuartersInfo:ChildPatrolTowerInfo;
      
      public var towerInfoList:Array;
      
      public var freeCount:int;
      
      public var friendsStateList:Array;
      
      private var _refreshTime:Number = -1;
      
      private var _childIdList:Array;
      
      private var _childList:Array;
      
      public var selfIdDic:Dictionary;
      
      private var headUpgradeTempArr:Array;
      
      private var towerUpgradeTempArr:Array;
      
      private var taskTimeConfigInfo:ConfigInfosTempInfo;
      
      public var openTaskLevelArr:Array = [0,0,0,0];
      
      public var isAlertReward:Boolean = false;
      
      public var curSelectTowerInfo:ChildPatrolTowerInfo;
      
      private var _changeList:Array;
      
      private var _hulinTypeList:Array;
      
      public function ChildPatrolModel()
      {
         super();
         friendsStateList = [];
         towerInfoList = [];
         headQuartersInfo = new ChildPatrolTowerInfo();
         headUpgradeTempArr = TempleteManager.instance.getTemplatesByType(114);
         towerUpgradeTempArr = TempleteManager.instance.getTemplatesByType(115);
         headUpgradeTempArr.sortOn("Grades",16);
         towerUpgradeTempArr.sortOn("Grades",16);
         taskTimeConfigInfo = TempleteManager.instance.getConfigInfoByConfigName("child_patrol_mission_time");
         getOpenTaskLevel();
      }
      
      public function getChildPatrolFriendStateInfoByUserId(param1:int) : ChildPatrolFriendStateInfo
      {
         for each(var _loc2_:ChildPatrolFriendStateInfo in friendsStateList)
         {
            if(_loc2_.userId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getChildPatrolTowerInfoByTowerId(param1:int) : ChildPatrolTowerInfo
      {
         for each(var _loc2_:ChildPatrolTowerInfo in towerInfoList)
         {
            if(_loc2_.towerId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function findUpgradeTempInfoByTypeAndGrade(param1:int, param2:int) : UpgradeTemplateInfo
      {
         var _loc4_:Array = null;
         if(param1 == 114)
         {
            _loc4_ = headUpgradeTempArr;
         }
         if(param1 == 115)
         {
            _loc4_ = towerUpgradeTempArr;
         }
         for each(var _loc3_:UpgradeTemplateInfo in _loc4_)
         {
            if(_loc3_.Grades == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function beginChange() : void
      {
         _changeList = [];
         _hulinTypeList = [];
      }
      
      public function commitChange() : void
      {
         _changeList = null;
         _hulinTypeList = null;
      }
      
      private function getHulingChildList(param1:Array) : Array
      {
         var _loc3_:ChildTempInfo = null;
         var _loc2_:Array = [];
         for each(var _loc4_:ChildData in param1)
         {
            _loc3_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc4_.job,_loc4_.growthGrade);
            if(_loc3_ && _loc3_.MasterType == 1)
            {
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_;
      }
      
      private function getNomalChildList(param1:Array) : Array
      {
         var _loc3_:ChildTempInfo = null;
         var _loc2_:Array = [];
         for each(var _loc4_:ChildData in param1)
         {
            _loc3_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc4_.job,_loc4_.growthGrade);
            if(_loc3_ && _loc3_.MasterType == 0)
            {
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_;
      }
      
      private function matchHuLing(param1:Array, param2:int) : Boolean
      {
         if(_hulinTypeList && _hulinTypeList[param2] == 1)
         {
            return true;
         }
         for each(var _loc3_:ChildData in param1)
         {
            if(_hulinTypeList && _hulinTypeList[param2] != 1 && _changeList && _changeList.indexOf(_loc3_) == -1)
            {
               _hulinTypeList[param2] = 1;
               _changeList.push(_loc3_);
               return true;
            }
         }
         return false;
      }
      
      public function getTaskNameFrameByData(param1:int, param2:ChildPatrolTowerInfo, param3:Array) : int
      {
         var _loc6_:Array = null;
         var _loc5_:int = 0;
         var _loc7_:int = 1;
         var _loc4_:UpgradeTemplateInfo = findUpgradeTempInfoByTypeAndGrade(115,param2.level);
         if(!_loc4_)
         {
            return _loc7_;
         }
         _loc6_ = _loc4_.TemplateName.split(",");
         _loc5_ = int(_loc6_[0]);
         if(!isOpenByTypeAndOpenMaxLevel(param1,_loc5_))
         {
            _loc7_ = 1;
         }
         else if(param3.length <= 0)
         {
            _loc7_ = 2;
         }
         else if(!checkIsReached(param1,param2,param3))
         {
            _loc7_ = 3;
         }
         else
         {
            _loc7_ = 4;
         }
         return _loc7_;
      }
      
      public function isOpenByTypeAndOpenMaxLevel(param1:int, param2:int) : Boolean
      {
         return param2 >= param1;
      }
      
      public function checkIsReached(param1:int, param2:ChildPatrolTowerInfo, param3:Array) : Boolean
      {
         var _loc4_:ChildPatrolMissionTemplateInfo = null;
         var _loc5_:ChildPatrolMissionTemplateInfo = null;
         var _loc6_:ChildPatrolMissionTemplateInfo = null;
         if(param1 == 1)
         {
            _loc4_ = TempleteManager.instance.childPatrolMissionTemplateCate.getTemplateByID(param2.normalMissionId);
            if(param2.state != 0)
            {
               return param2.normalMissionReached;
            }
         }
         if(param1 == 2)
         {
            _loc4_ = TempleteManager.instance.childPatrolMissionTemplateCate.getTemplateByID(param2.hardMissionId);
            if(param2.state != 0)
            {
               return param2.hardMissionReached;
            }
         }
         if(param1 == 3)
         {
            _loc4_ = TempleteManager.instance.childPatrolMissionTemplateCate.getTemplateByID(param2.nightmareMissionId);
            if(param2.state != 0)
            {
               return param2.nightmareMissionReached;
            }
         }
         if(!_loc4_)
         {
            return false;
         }
         if(!param3 || param3.length <= 0)
         {
            return false;
         }
         if(checkTaskCondition(_loc4_,param3,param1))
         {
            return false;
         }
         if(param1 == 2)
         {
            _loc5_ = TempleteManager.instance.childPatrolMissionTemplateCate.getTemplateByID(param2.normalMissionId);
            if(!_loc5_)
            {
               return false;
            }
            if(checkTaskCondition(_loc5_,param3,1))
            {
               return false;
            }
         }
         else if(param1 == 3)
         {
            _loc5_ = TempleteManager.instance.childPatrolMissionTemplateCate.getTemplateByID(param2.normalMissionId);
            _loc6_ = TempleteManager.instance.childPatrolMissionTemplateCate.getTemplateByID(param2.hardMissionId);
            if(!_loc5_ || !_loc6_)
            {
               return false;
            }
            if(checkTaskCondition(_loc5_,param3,1) || checkTaskCondition(_loc6_,param3,2))
            {
               return false;
            }
         }
         return true;
      }
      
      private function checkTaskCondition(param1:ChildPatrolMissionTemplateInfo, param2:Array, param3:int) : Boolean
      {
         var _loc4_:Boolean = false;
         var _loc5_:Array = null;
         if(_changeList == null)
         {
            _loc5_ = param2;
         }
         else
         {
            _loc5_ = getNomalChildList(param2);
         }
         _loc4_ = !ChildPatrolCheckCondictionHelper.checkCondictionIsReached(param1,_loc5_);
         if(_changeList != null)
         {
            _loc4_ &&= !matchHuLing(getHulingChildList(param2),param3);
         }
         return _loc4_;
      }
      
      public function getOpenTaskLevel() : void
      {
         var _loc7_:Array = null;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = [];
         var _loc2_:Array = [];
         for each(var _loc6_:UpgradeTemplateInfo in towerUpgradeTempArr)
         {
            _loc7_ = _loc6_.TemplateName.split(",");
            _loc1_ = _loc6_.Grades;
            _loc3_ = int(_loc7_[0]);
            _loc5_.push(_loc1_);
            _loc2_.push(_loc3_);
         }
         _loc4_ = _loc5_.length - 1;
         while(_loc4_ >= 0)
         {
            openTaskLevelArr[_loc2_[_loc4_]] = _loc4_ + 1;
            _loc4_--;
         }
         openTaskLevelArr.sort(16);
      }
      
      public function get refreshTime() : Number
      {
         return _refreshTime;
      }
      
      public function set refreshTime(param1:Number) : void
      {
         _refreshTime = param1;
         PlayerManager.instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateChildPatrolTowerCountHandler);
         if(_refreshTime > 0)
         {
            PlayerManager.instance.currentPlayerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__updateChildPatrolTowerCountHandler);
         }
      }
      
      private function __updateChildPatrolTowerCountHandler(param1:PlayerEvent) : void
      {
         _refreshTime = _refreshTime - 1;
         if(_refreshTime <= 0)
         {
            ChildPatrolManager.instance.sendChildPatrolOperate(9);
            PlayerManager.instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateChildPatrolTowerCountHandler);
         }
      }
      
      public function getIsInBottomByChildId(param1:int) : Boolean
      {
         if(getIsInPatrolByChildId(param1))
         {
            return true;
         }
         for each(var _loc2_:int in childIdList)
         {
            if(_loc2_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getIsInPatrolByChildId(param1:int) : Boolean
      {
         if(headQuartersInfo.garrisonChildIdList.indexOf(param1) != -1)
         {
            return true;
         }
         for each(var _loc2_:ChildPatrolTowerInfo in towerInfoList)
         {
            if(_loc2_.garrisonChildIdList.indexOf(param1) != -1)
            {
               return true;
            }
            if(_loc2_.patrolChildIdList.indexOf(param1) != -1)
            {
               return true;
            }
            if(_loc2_.exploreChildId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getInPatrolByChildId(param1:int) : ChildPatrolTowerInfo
      {
         if(headQuartersInfo.garrisonChildIdList.indexOf(param1) != -1)
         {
            return headQuartersInfo;
         }
         for each(var _loc2_:ChildPatrolTowerInfo in towerInfoList)
         {
            if(_loc2_.garrisonChildIdList.indexOf(param1) != -1)
            {
               return _loc2_;
            }
            if(_loc2_.patrolChildIdList.indexOf(param1) != -1)
            {
               return _loc2_;
            }
            if(_loc2_.exploreChildId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getInPatrolIndexByChildId(param1:int) : int
      {
         if(headQuartersInfo.garrisonChildIdList.indexOf(param1) != -1)
         {
            return 1;
         }
         for each(var _loc2_:ChildPatrolTowerInfo in towerInfoList)
         {
            if(_loc2_.garrisonChildIdList.indexOf(param1) != -1)
            {
               return 2;
            }
            if(_loc2_.patrolChildIdList.indexOf(param1) != -1)
            {
               return 3;
            }
            if(_loc2_.exploreChildId == param1)
            {
               return 5;
            }
         }
         return 0;
      }
      
      public function getCanPatrolChildCount(param1:int, param2:int) : int
      {
         var _loc3_:UpgradeTemplateInfo = null;
         var _loc4_:Array = null;
         if(param1 == 2)
         {
            return 1;
         }
         if(param1 == 3)
         {
            return 4;
         }
         if(param1 == 4)
         {
            return 1;
         }
         if(param1 == 5)
         {
            return 1;
         }
         _loc3_ = findUpgradeTempInfoByTypeAndGrade(114,param2);
         _loc4_ = _loc3_.TemplateName.split(",");
         return parseInt(_loc4_[0]);
      }
      
      public function getNoFreeChildCount() : int
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<ChildData> = ChildManager.instance.model.childList;
         for each(var _loc3_:ChildData in _loc1_)
         {
            if(getIsInPatrolByChildId(_loc3_.childId))
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function get childIdList() : Array
      {
         return _childIdList;
      }
      
      public function set childIdList(param1:Array) : void
      {
         _childIdList = param1;
      }
      
      public function get childList() : Array
      {
         return _childList;
      }
      
      public function set childList(param1:Array) : void
      {
         _childList = param1;
      }
      
      public function getTaskNeedTimeByChildList(param1:ChildPatrolTowerInfo, param2:Array) : int
      {
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc6_:UpgradeTemplateInfo = findUpgradeTempInfoByTypeAndGrade(114,headQuartersInfo.level);
         var _loc5_:UpgradeTemplateInfo = findUpgradeTempInfoByTypeAndGrade(115,param1.level);
         if(taskTimeConfigInfo)
         {
            _loc9_ = taskTimeConfigInfo.ConfigValue.split(",");
         }
         if(_loc6_)
         {
            _loc3_ = _loc6_.TemplateName.split(",");
         }
         if(_loc5_)
         {
            _loc4_ = _loc5_.TemplateName.split(",");
         }
         beginChange();
         if(getTaskNameFrameByData(1,param1,param2) == 4)
         {
            _loc8_ += parseInt(_loc9_[0]);
            _loc7_ += parseInt(_loc3_[1]);
            _loc7_ = _loc7_ + parseInt(_loc4_[1]);
         }
         if(getTaskNameFrameByData(2,param1,param2) == 4)
         {
            _loc8_ += parseInt(_loc9_[1]);
            _loc7_ += parseInt(_loc3_[2]);
            _loc7_ = _loc7_ + parseInt(_loc4_[2]);
         }
         if(getTaskNameFrameByData(3,param1,param2) == 4)
         {
            _loc8_ += parseInt(_loc9_[2]);
            _loc7_ += parseInt(_loc3_[3]);
            _loc7_ = _loc7_ + parseInt(_loc4_[3]);
         }
         commitChange();
         if(_loc8_ > _loc7_)
         {
            return (_loc8_ - _loc7_) * 60;
         }
         return 0;
      }
      
      public function setSelfDic() : void
      {
         selfIdDic = new Dictionary(true);
         for each(var _loc3_:int in headQuartersInfo.garrisonChildIdList)
         {
            if(headQuartersInfo.onGarrison)
            {
               selfIdDic[_loc3_] = true;
            }
         }
         for each(var _loc4_:ChildPatrolTowerInfo in towerInfoList)
         {
            for each(var _loc1_:int in _loc4_.garrisonChildIdList)
            {
               if(_loc4_.onGarrison)
               {
                  selfIdDic[_loc1_] = true;
               }
            }
            for each(var _loc2_:int in _loc4_.patrolChildIdList)
            {
               if(_loc4_.state != 0)
               {
                  selfIdDic[_loc2_] = true;
               }
            }
         }
      }
   }
}

