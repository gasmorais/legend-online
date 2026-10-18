package yishi.manager
{
   import com.road.yishi.proto.quest.FinishedTempId;
   import com.road.yishi.proto.quest.QuestFinishedRspMsg;
   import com.road.yishi.proto.quest.QuestInfo;
   import com.road.yishi.proto.quest.QuestUpdatedRspMsg;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.TaskSocketManager;
   import managers.TaskTraceTipManager;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.star.StarTroughInfo;
   import mvc.module.task.TaskCategory;
   import mvc.module.task.TaskInfo;
   import mvc.module.task.TaskTemplate;
   import tasktracetip.data.TipMessageData;
   import ui.gameroll.TaskGainMovie;
   import ui.maintoolbar.MainToolBar;
   import yishi.SwitchPageHelp;
   import yishi.actions.base.AlertTipAction;
   import yishi.actions.task.NewTaskAction;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.BitArray;
   import yishi.utils.DateFormatter;
   import yishi.utils.DelayActionsUtils;
   
   public class TaskManage extends EventDispatcher
   {
      
      public static var PET_SYSTEM_OPEN_TASK:int = 920;
      
      public static var PET_SYSTEM_OPEN_TASK02:int = 921;
      
      public static var SETARMY_TASK:int = 52;
      
      public static const TASK_COMPLETE_1802:String = "TASK_COMPLETE_1802";
      
      public static const APPELL_PROPERTY_OPEN_TASK:int = 936;
      
      public static var DRAGON_SOUL_OPEN_TASK:int = 754;
      
      public static var DRAGON_TRANSFER_TASK:int = 757;
      
      public static var SATR_MASTER_TASK:int = 1802;
      
      public static var ROYAL_THRONE_TASK:int = 1911;
      
      public static var AVENGER_TALENT_TASK:int = 1943;
      
      public static var MONSTER_EXPLORE_TASK:int = 1936;
      
      public static var ROYALTY_BOSS_TASK:int = 1100;
      
      public static var WARSOUL:int = 1389;
      
      public static var WARSOUL_TOWER:int = 1390;
      
      public static var FINAL_ROAD:int = 1391;
      
      private static var _instance:TaskManage;
      
      private var _allTasks:Dictionary;
      
      private var _taskLog:BitArray;
      
      private var _cate:TaskCategory;
      
      private var _isFirstLoad:Boolean = true;
      
      private var _newComplete:Boolean;
      
      public function TaskManage()
      {
         super();
      }
      
      public static function get instance() : TaskManage
      {
         if(!_instance)
         {
            _instance = new TaskManage();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _cate = new TaskCategory();
         _taskLog = new BitArray();
         _allTasks = TempleteManager.instance.taskTemplateDic;
         initEvent();
      }
      
      public function loadData() : void
      {
         loadTaskLog();
      }
      
      private function loadTaskLog() : void
      {
         var _loc2_:int = 0;
         var _loc3_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc1_:ByteArray = _loc3_.questSite;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _taskLog.writeByte(_loc1_.readByte());
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 112,__questUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 52,__questFinishHandler);
      }
      
      private function __questUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc9_:int = 0;
         var _loc4_:QuestInfo = null;
         var _loc6_:TaskTemplate = null;
         var _loc5_:Boolean = false;
         var _loc3_:Vector.<TaskTemplate> = new Vector.<TaskTemplate>();
         var _loc10_:PackageIn = param1.data as PackageIn;
         var _loc2_:QuestUpdatedRspMsg = new QuestUpdatedRspMsg();
         _loc2_ = _loc10_.readBody(_loc2_) as QuestUpdatedRspMsg;
         var _loc8_:int = int(_loc2_.quest.length);
         _loc9_ = 0;
         for(; _loc9_ < _loc8_; _loc9_++)
         {
            _loc4_ = _loc2_.quest[_loc9_] as QuestInfo;
            _loc6_ = getTaskByID(_loc4_.templateId);
            if(_loc6_)
            {
               if(!_loc6_.taskInfo)
               {
                  _loc6_.taskInfo = new TaskInfo();
                  readTaskInfo(_loc6_,_loc4_);
                  _loc5_ = true;
                  if(!isAvailableTask(_loc6_))
                  {
                     continue;
                  }
               }
               else if(!_cate.hasTask(_loc6_))
               {
                  if(isAvailableTask(_loc6_))
                  {
                     readTaskInfo(_loc6_,_loc4_);
                     _loc5_ = true;
                  }
               }
               else
               {
                  readTaskInfo(_loc6_,_loc4_);
               }
               if(_loc5_)
               {
                  if(_loc6_.isNew && checkShowNewTask(_loc6_))
                  {
                     _loc3_.push(_loc6_);
                  }
                  _loc6_.addConditionListener();
                  _cate.beginChanges();
                  _cate.addAccepted(_loc6_);
                  _cate.commit();
               }
            }
         }
         var _loc7_:int = _loc2_.statesLength;
         _loc2_.states.readBytes(_taskLog,0,_loc7_ - 1);
         if(_isFirstLoad)
         {
            requestCanAcceptTask();
            _isFirstLoad = false;
            return;
         }
         if(_cate.hasCompletedTask() && !_newComplete)
         {
            _newComplete = true;
         }
         if(_loc5_)
         {
            if(PlayerManager.instance.newbieProcess >= 19000)
            {
               newTaskHandler(_loc3_);
            }
            doNewbieTask(_loc3_);
         }
      }
      
      private function __questFinishHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:TaskTemplate = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:QuestFinishedRspMsg = new QuestFinishedRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as QuestFinishedRspMsg;
         if(_loc2_.isJump == 1)
         {
            _cate.beginChanges();
            for each(_loc4_ in _loc2_.finishedTemps)
            {
               _loc3_ = getTaskByID(_loc4_.templateId);
               if(_loc3_)
               {
                  _loc3_.taskInfo.condition1 = 0;
                  _loc3_.taskInfo.condition2 = 0;
                  _loc3_.taskInfo.condition3 = 0;
                  _loc3_.taskInfo.condition4 = 0;
                  _loc3_.taskInfo.isComplete = false;
                  _loc3_.removeEvent();
                  _cate.removeTask(_loc3_);
                  checkDragonTransferOpen(_loc3_);
                  checkPetSystemOpen(_loc3_);
                  checkDragonSoulOpen(_loc3_);
                  checkTransferSystem(_loc3_);
                  checkStarMasterTask(_loc3_);
               }
            }
            _cate.commit();
         }
         else
         {
            _loc3_ = getTaskByID(_loc2_.templateId);
            if(!_loc3_)
            {
               return;
            }
            TaskGainMovie.taskMovie(_loc3_);
            _loc3_.taskInfo.condition1 = 0;
            _loc3_.taskInfo.condition2 = 0;
            _loc3_.taskInfo.condition3 = 0;
            _loc3_.taskInfo.condition4 = 0;
            _loc3_.taskInfo.isComplete = false;
            _loc3_.removeEvent();
            _cate.beginChanges();
            _cate.removeTask(_loc3_);
            _cate.commit();
            checkDragonTransferOpen(_loc3_);
            checkPetSystemOpen(_loc3_);
            checkDragonSoulOpen(_loc3_);
            checkTransferSystem(_loc3_);
            checkStarMasterTask(_loc3_);
         }
         requestCanAcceptTask();
         NotificationManager.instance.sendNotification("TASK_COMMIT",_loc3_.TemplateId);
      }
      
      private function checkTransferSystem(param1:TaskTemplate) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [756,755,1800,1801];
         if(_loc2_.indexOf(param1.TemplateId) != -1)
         {
            _loc3_ = _loc2_.indexOf(param1.TemplateId) + 1;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("TASK_SHOWTRANSFER",_loc3_));
         }
      }
      
      private function checkStarMasterTask(param1:TaskTemplate) : void
      {
         var _loc2_:StarTroughInfo = null;
         if(param1.TemplateId == TaskManage.SATR_MASTER_TASK)
         {
            _loc2_ = StarManager.instance.getStarTroughInfoByPos(8);
            _loc2_.isFirstOpen = true;
            _instance.dispatchEvent(new Event("TASK_COMPLETE_1802"));
            NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_STARTROUGHINFO"));
         }
      }
      
      private function checkDragonTransferOpen(param1:TaskTemplate) : void
      {
         if(param1.TemplateId == TaskManage.DRAGON_TRANSFER_TASK)
         {
            PlayerManager.instance.sendDragonSoulTransfer();
         }
      }
      
      private function checkPetSystemOpen(param1:TaskTemplate) : void
      {
         if(param1.TemplateId == TaskManage.PET_SYSTEM_OPEN_TASK)
         {
            MainToolBar.instance.petButtonShine = true;
            MainToolBar.instance.setPetButtonVisible();
            MainToolBar.instance.doMove();
         }
      }
      
      private function checkDragonSoulOpen(param1:TaskTemplate) : void
      {
         if(param1.TemplateId == TaskManage.DRAGON_SOUL_OPEN_TASK)
         {
            PlayerManager.instance.currentPlayerModel.showDragonSoulBtnShine = true;
            showDragonSoulOpenTip();
         }
      }
      
      private function showDragonSoulOpenTip() : void
      {
         var _loc1_:TipMessageData = new TipMessageData();
         _loc1_.type = 40;
         _loc1_.title = LanguageMgr.GetTranslation("public.prompt");
         _loc1_.name = LanguageMgr.GetTranslation("tasktracetip.view.DragonSoulTipView.name");
         _loc1_.content = LanguageMgr.GetTranslation("tasktracetip.view.DragonSoulTipView.content");
         _loc1_.icon = "asset.taskTraceTips.DragonSoulIcon";
         _loc1_.btnTxt = LanguageMgr.GetTranslation("tasktracetip.view.DragonSoulTipView.btnText");
         DelayActionsUtils.instance.addAction(new AlertTipAction(_loc1_,dragonSoulTipCall));
      }
      
      private function dragonSoulTipCall(param1:Object) : void
      {
         TaskTraceTipManager.instance.showView(param1 as TipMessageData);
      }
      
      private function readTaskInfo(param1:TaskTemplate, param2:QuestInfo) : void
      {
         param1.taskInfo.taskId = param2.templateId;
         param1.taskInfo.isComplete = param2.isComplete;
         param1.taskInfo.condition1 = param2.condition_1;
         param1.taskInfo.condition2 = param2.condition_2;
         param1.taskInfo.condition3 = param2.condition_3;
         param1.taskInfo.condition4 = param2.condition_4;
         param1.taskInfo.isSelect = param2.isSelect;
         param1.taskInfo.completeDate = DateFormatter.parse(param2.completedDate,"YYYY-MM-DD hh:mm:ss");
         param1.taskInfo.acceptDate = DateFormatter.parse(param2.addDate,"YYYY-MM-DD hh:mm:ss");
         param1.taskInfo.repeatFinish = param2.repeatFinish;
         param1.commit();
      }
      
      public function mobileSwitchHandler() : void
      {
         _cate.addMobileTaskBySwitch();
      }
      
      public function clientDownSwitchHandler() : void
      {
         _cate.addClientDownTaskBySwitch();
      }
      
      public function requestCanAcceptTask() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Array = getAvailableTasks();
         if(_loc2_.length != 0)
         {
            _loc1_ = [];
            for each(var _loc3_:TaskTemplate in _loc2_)
            {
               _loc1_.push(_loc3_.TemplateId);
               _loc3_.isRequired = true;
               _loc3_.isNew = true;
            }
            socketSendTaskAdd(_loc1_);
         }
      }
      
      public function requestAcceptTask(param1:TaskTemplate) : void
      {
         if(isAvailableTask(param1))
         {
            param1.isRequired = true;
            param1.isNew = true;
            socketSendTaskAdd([param1.TemplateId]);
         }
      }
      
      private function socketSendTaskAdd(param1:Array) : void
      {
         TaskSocketManager.sendRequestTask(param1);
      }
      
      public function isAvailableTask(param1:TaskTemplate) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(checkIsAchieved(param1))
         {
            return false;
         }
         if(checkIsReceivedDate(param1))
         {
            return false;
         }
         if(checkPlayerGrades(param1))
         {
            return false;
         }
         if(checkPlayerOverGrades(param1))
         {
            return false;
         }
         if(checkInWeek(param1))
         {
            return false;
         }
         if(checkInHour(param1))
         {
            return false;
         }
         if(_cate.hasTask(param1))
         {
            return false;
         }
         if(IsTaskFinish(param1.TemplateId) && !param1.IsRepeat)
         {
            return false;
         }
         if(checkRepeatMax(param1) && checkInRepeatTime(param1))
         {
            return false;
         }
         if(!checkPreTask(param1))
         {
            return false;
         }
         if(!chechNeedBuilding(param1))
         {
            return false;
         }
         if(!checkConsortia(param1))
         {
            return false;
         }
         param1.isNew = true;
         return true;
      }
      
      private function checkIsAchieved(param1:TaskTemplate) : Boolean
      {
         var _loc2_:Number = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
         var _loc3_:Number = DateFormatter.parse(param1.EndDate,"YYYY-MM-DD hh:mm:ss").getTime();
         if(_loc2_ > _loc3_)
         {
            return true;
         }
         return false;
      }
      
      private function checkIsReceivedDate(param1:TaskTemplate) : Boolean
      {
         var _loc2_:Number = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
         var _loc3_:Number = DateFormatter.parse(param1.StartDate,"YYYY-MM-DD hh:mm:ss").getTime();
         if(_loc2_ < _loc3_)
         {
            return true;
         }
         return false;
      }
      
      private function checkPlayerGrades(param1:TaskTemplate) : Boolean
      {
         if(thane.grades < param1.NeedMinLevel)
         {
            return true;
         }
         return false;
      }
      
      private function checkPlayerOverGrades(param1:TaskTemplate) : Boolean
      {
         if(thane.grades > param1.NeedMaxLevel)
         {
            return true;
         }
         return false;
      }
      
      private function checkRepeatMax(param1:TaskTemplate) : Boolean
      {
         if(param1.taskInfo && param1.RepeatMax <= param1.taskInfo.repeatFinish)
         {
            return true;
         }
         return false;
      }
      
      private function checkInRepeatTime(param1:TaskTemplate) : Boolean
      {
         var _loc2_:Date = new Date();
         _loc2_.time = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
         var _loc4_:Date = new Date();
         _loc4_.time = _loc2_.time;
         var _loc5_:Date = new Date();
         _loc5_.time = param1.taskInfo.completeDate.time;
         var _loc3_:String = DateFormatter.format(_loc4_,"YY-MM-DD");
         var _loc6_:String = DateFormatter.format(_loc5_,"YY-MM-DD");
         if(_loc3_ != _loc6_)
         {
            return false;
         }
         return true;
      }
      
      private function checkPreTask(param1:TaskTemplate) : Boolean
      {
         var _loc3_:TaskTemplate = null;
         if(param1.PreQuestId == "")
         {
            return true;
         }
         var _loc2_:Array = param1.PreQuestId.split(",");
         for each(var _loc4_:int in _loc2_)
         {
            _loc3_ = getTaskByID(_loc4_);
            if(_loc3_ && !IsTaskFinish(_loc3_.TemplateId))
            {
               return false;
            }
         }
         return true;
      }
      
      private function chechNeedBuilding(param1:TaskTemplate) : Boolean
      {
         var _loc3_:BuildInfo = null;
         if(param1.NeedBuildingTemp == 0)
         {
            return true;
         }
         var _loc2_:BuildingTempInfo = TempleteManager.instance.buildTemplateCate.getTemplateByID(param1.NeedBuildingTemp);
         if(_loc2_)
         {
            _loc3_ = BuildingManager.instance.getBuildingInfoBySonType(_loc2_.SonType);
            if(_loc3_ && _loc2_.BuildingGrade > _loc3_.templeteInfo.BuildingGrade)
            {
               return true;
            }
         }
         return false;
      }
      
      private function checkNeedGoods(param1:TaskTemplate) : Boolean
      {
         if(param1.NeedItemTemp == 0)
         {
            return true;
         }
         var _loc2_:Array = GoodsManager.instance.getGoodsByGoodsTId(param1.NeedItemTemp);
         if(_loc2_.length == 0)
         {
            return true;
         }
         return false;
      }
      
      private function checkConsortia(param1:TaskTemplate) : Boolean
      {
         if(param1.IsLeague && thane.consortiaID == 0)
         {
            return false;
         }
         return true;
      }
      
      private function checkInHour(param1:TaskTemplate) : Boolean
      {
         return false;
      }
      
      private function checkInWeek(param1:TaskTemplate) : Boolean
      {
         return false;
      }
      
      public function IsTaskFinish(param1:int) : Boolean
      {
         if(!_taskLog)
         {
            return false;
         }
         if(param1 > _taskLog.length * 8 || param1 < 1)
         {
            return false;
         }
         var _loc4_:int = --param1 / 8;
         var _loc3_:int = param1 % 8;
         var _loc2_:int = _taskLog[_loc4_] & 1 << _loc3_;
         return _loc2_ != 0;
      }
      
      public function getAvailableTasks(param1:Boolean = true) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:TaskTemplate in _allTasks)
         {
            if(_loc3_.IsAuto == param1 && isAvailableTask(_loc3_))
            {
               _loc2_.push(_loc3_);
            }
            else if(isManualAvaliable(_loc3_))
            {
               cate.addManualTask(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function isManualAvaliable(param1:TaskTemplate) : Boolean
      {
         if(param1.IsAuto)
         {
            return false;
         }
         if(!isAvailableTask(param1))
         {
            return false;
         }
         if(!param1.taskInfo)
         {
            return true;
         }
         if(param1.taskInfo.isSelect)
         {
            return false;
         }
         var _loc3_:Date = param1.taskInfo.completeDate;
         var _loc2_:Date = new Date();
         _loc2_.time = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
         if(param1.taskInfo.repeatFinish < param1.RepeatMax)
         {
            return true;
         }
         if(!_loc3_)
         {
            return true;
         }
         if(DateFormatter.format(_loc3_,"YYYY-MM-DD") != DateFormatter.format(_loc2_,"YYYY-MM-DD"))
         {
            return true;
         }
         if(int(_loc3_.getHours() / param1.RepeatInterval) != int(_loc2_.getHours() / param1.RepeatInterval) && param1.taskInfo.repeatFinish <= param1.RepeatMax)
         {
            return true;
         }
         return false;
      }
      
      private function checkShowNewTask(param1:TaskTemplate) : Boolean
      {
         if(param1.TemplateType != 0)
         {
            return false;
         }
         if(param1.TemplateId == 10 || param1.TemplateId == 220)
         {
            return false;
         }
         return true;
      }
      
      private function newTaskHandler(param1:Vector.<TaskTemplate>) : void
      {
         if(param1.length == 0)
         {
            return;
         }
         DelayActionsUtils.instance.addAction(new NewTaskAction(param1[0]));
      }
      
      private function doNewbieTask(param1:Vector.<TaskTemplate>) : void
      {
         for each(var _loc2_:TaskTemplate in param1)
         {
            if(_loc2_.TemplateId >= 1825 && _loc2_.TemplateId <= 1831 && _loc2_.TemplateType == 0 && !PlayerManager.instance.isExistNewbieMask)
            {
               SwitchPageHelp.skipPageByTaskCondictionType(_loc2_,null);
               return;
            }
         }
      }
      
      public function getTaskByID(param1:int) : TaskTemplate
      {
         if(!_allTasks)
         {
            return null;
         }
         return _allTasks[param1];
      }
      
      public function get allTasks() : Dictionary
      {
         return _allTasks;
      }
      
      public function set allTasks(param1:Dictionary) : void
      {
         _allTasks = param1;
      }
      
      private function sortOnType(param1:TaskTemplate, param2:TaskTemplate) : int
      {
         if(param1.TemplateType < param2.TemplateType)
         {
            return -1;
         }
         if(param1.TemplateType > param2.TemplateType)
         {
            return 1;
         }
         return 0;
      }
      
      public function get existTaskType() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:TaskTemplate in _cate.acceptedList)
         {
            if(_loc1_.indexOf(_loc2_.TemplateType) <= -1)
            {
               _loc1_.push(_loc2_.TemplateType);
            }
         }
         return _loc1_;
      }
      
      public function getCompletedList() : Array
      {
         return _cate.completedList.sort(sortOnType);
      }
      
      public function get cate() : TaskCategory
      {
         return _cate;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function hasCompletedTask() : Boolean
      {
         return _cate && _cate.hasCompletedTask();
      }
   }
}

