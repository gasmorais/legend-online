package mvc.module.task
{
   import events.TaskEvent;
   import flash.events.EventDispatcher;
   import yishi.manager.ConfigManager;
   import yishi.manager.TaskManage;
   import yishi.utils.SimpleDictionary;
   
   public class TaskCategory extends EventDispatcher
   {
      
      private static const ADD_TASK:String = "ADD_TASK";
      
      private static const REMOVE_TASK:String = "REMOVE_TASK";
      
      private static const MANUAL_TASK_ADDED:String = "MANUAL_TASK_ADDED";
      
      private static const MANUAL_TASK_REMOVE:String = "MANUAL_TASK_REMOVE";
      
      protected var _changeObj:SimpleDictionary;
      
      private var _acceptedTaskList:Array;
      
      private var _mainTaskList:Array;
      
      private var _branchTaskList:Array;
      
      private var _commonTaskList:Array;
      
      private var _actTaskList:Array;
      
      private var _backplayerTaskList:Array;
      
      private var _vipTaskList:Array;
      
      private var _manualTaskList:Array;
      
      private var _mobileTemp:TaskTemplate;
      
      private var _clientDownTemp:TaskTemplate;
      
      public function TaskCategory()
      {
         super();
         _acceptedTaskList = [];
         _mainTaskList = [];
         _branchTaskList = [];
         _commonTaskList = [];
         _actTaskList = [];
         _backplayerTaskList = [];
         _vipTaskList = [];
         _manualTaskList = [];
         _changeObj = new SimpleDictionary(true);
      }
      
      public function addManualTask(param1:TaskTemplate) : void
      {
         if(_manualTaskList.indexOf(param1) < 0)
         {
            _manualTaskList.push(param1);
            _changeObj["MANUAL_TASK_ADDED"] = param1;
         }
      }
      
      public function removeManualTask(param1:TaskTemplate) : void
      {
         _manualTaskList.splice(_manualTaskList.indexOf(param1),1);
         _changeObj["MANUAL_TASK_REMOVE"] = param1;
      }
      
      public function addAccepted(param1:TaskTemplate) : void
      {
         var _loc2_:* = null;
         var _loc3_:Boolean = ConfigManager.info.CLIENT_DOWNLAND;
         if(!_loc3_)
         {
            for each(_loc2_ in param1.conditionList)
            {
               if(_loc2_.CondictionType == 33)
               {
                  _clientDownTemp = param1;
                  return;
               }
            }
         }
         if(!ConfigManager.info.MOBILE_TASK)
         {
            for each(_loc2_ in param1.conditionList)
            {
               if(_loc2_.CondictionType == 48)
               {
                  _mobileTemp = param1;
                  return;
               }
            }
         }
         addByType(param1);
         if(_manualTaskList.indexOf(param1) >= 0)
         {
            removeManualTask(param1);
         }
         if(_acceptedTaskList.indexOf(param1) < 0)
         {
            _acceptedTaskList.push(param1);
            _changeObj["ADD_TASK"] = param1;
         }
      }
      
      private function addByType(param1:TaskTemplate) : void
      {
         switch(param1.TemplateType)
         {
            case 0:
               if(_mainTaskList.indexOf(param1) < 0)
               {
                  _mainTaskList.push(param1);
               }
               break;
            case 1:
               if(_commonTaskList.indexOf(param1) < 0)
               {
                  _commonTaskList.push(param1);
               }
               break;
            case 2:
               if(_actTaskList.indexOf(param1) < 0)
               {
                  _actTaskList.push(param1);
               }
               break;
            case 3:
               if(_vipTaskList.indexOf(param1) < 0)
               {
                  _vipTaskList.push(param1);
               }
               break;
            case 4:
               if(_backplayerTaskList.indexOf(param1) < 0)
               {
                  _backplayerTaskList.push(param1);
               }
         }
      }
      
      public function removeTask(param1:TaskTemplate) : void
      {
         removeByType(param1);
         var _loc2_:int = _acceptedTaskList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _acceptedTaskList.splice(_loc2_,1);
            if(TaskManage.instance.isManualAvaliable(param1))
            {
               addManualTask(param1);
            }
            _changeObj["REMOVE_TASK"] = param1;
         }
         param1 = null;
      }
      
      public function addMobileTaskBySwitch() : void
      {
         if(_mobileTemp == null)
         {
            return;
         }
         for each(var _loc1_:TaskTemplate in _acceptedTaskList)
         {
            if(_loc1_.conditionList[0].CondictionType == 48)
            {
               return;
            }
         }
         _acceptedTaskList.push(_mobileTemp);
         addByType(_mobileTemp);
      }
      
      public function addClientDownTaskBySwitch() : void
      {
         if(_clientDownTemp == null)
         {
            return;
         }
         for each(var _loc1_:TaskTemplate in _acceptedTaskList)
         {
            if(_loc1_.conditionList[0].CondictionType == 33)
            {
               return;
            }
         }
         _acceptedTaskList.push(_clientDownTemp);
         addByType(_clientDownTemp);
      }
      
      private function removeByType(param1:TaskTemplate) : void
      {
         if(_mainTaskList.indexOf(param1) >= 0)
         {
            _mainTaskList.splice(_mainTaskList.indexOf(param1),1);
         }
         else if(_branchTaskList.indexOf(param1) >= 0)
         {
            _branchTaskList.splice(_branchTaskList.indexOf(param1),1);
         }
         else if(_commonTaskList.indexOf(param1) >= 0)
         {
            _commonTaskList.splice(_commonTaskList.indexOf(param1),1);
         }
         else if(_actTaskList.indexOf(param1) >= 0)
         {
            _actTaskList.splice(_actTaskList.indexOf(param1),1);
         }
         else if(_backplayerTaskList.indexOf(param1) >= 0)
         {
            _backplayerTaskList.splice(_backplayerTaskList.indexOf(param1),1);
         }
         else if(_vipTaskList.indexOf(param1) >= 0)
         {
            _vipTaskList.splice(_vipTaskList.indexOf(param1),1);
         }
      }
      
      public function beginChanges() : void
      {
         _changeObj.clear();
      }
      
      public function commit() : void
      {
         if(_changeObj["MANUAL_TASK_ADDED"])
         {
            dispatchEvent(new TaskEvent("manual_task_added",_changeObj["MANUAL_TASK_ADDED"]));
         }
         if(_changeObj["MANUAL_TASK_REMOVE"])
         {
            dispatchEvent(new TaskEvent("manual_task_remove",_changeObj["MANUAL_TASK_REMOVE"]));
         }
         if(_changeObj["ADD_TASK"])
         {
            dispatchEvent(new TaskEvent("task_added",_changeObj["ADD_TASK"]));
         }
         if(_changeObj["REMOVE_TASK"])
         {
            dispatchEvent(new TaskEvent("task_remove",_changeObj["REMOVE_TASK"]));
         }
      }
      
      public function get acceptedList() : Array
      {
         return _acceptedTaskList;
      }
      
      public function get traceList() : Vector.<TaskTemplate>
      {
         var _loc2_:Vector.<TaskTemplate> = new Vector.<TaskTemplate>();
         for each(var _loc1_:TaskTemplate in acceptedList)
         {
            _loc2_.push(_loc1_);
         }
         return _loc2_;
      }
      
      public function hasCompletedTask() : Boolean
      {
         for each(var _loc1_:TaskTemplate in _acceptedTaskList)
         {
            if(_loc1_.isCompleted)
            {
               return true;
            }
         }
         return false;
      }
      
      public function hasNewCompletedTask() : Boolean
      {
         for each(var _loc1_:TaskTemplate in _acceptedTaskList)
         {
            if(_loc1_.isCompleted && !_loc1_.hasCompleted)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get completedList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:TaskTemplate in _acceptedTaskList)
         {
            if(_loc2_.isCompleted)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function hasTask(param1:TaskTemplate) : Boolean
      {
         for each(var _loc2_:TaskTemplate in _acceptedTaskList)
         {
            if(param1.TemplateId == _loc2_.TemplateId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function hasTaskAndNotCompleted(param1:int) : Boolean
      {
         for each(var _loc2_:TaskTemplate in _acceptedTaskList)
         {
            if(param1 == _loc2_.TemplateId && !_loc2_.isCompleted)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getTaskById(param1:int) : TaskTemplate
      {
         var _loc3_:TaskTemplate = null;
         for each(var _loc2_:TaskTemplate in _acceptedTaskList)
         {
            if(param1 == _loc2_.TemplateId)
            {
               _loc3_ = _loc2_;
            }
         }
         return _loc3_;
      }
      
      public function get mainTaskList() : Array
      {
         return _mainTaskList;
      }
      
      public function get branchTaskList() : Array
      {
         return _branchTaskList;
      }
      
      public function get commonTaskList() : Array
      {
         return _commonTaskList;
      }
      
      public function get actTaskList() : Array
      {
         return _actTaskList;
      }
      
      public function get backplayerTaskList() : Array
      {
         return _backplayerTaskList;
      }
      
      public function get vipTaskList() : Array
      {
         return _vipTaskList;
      }
      
      public function get manualTaskList() : Array
      {
         return _manualTaskList;
      }
      
      public function set manualTaskList(param1:Array) : void
      {
         _manualTaskList = param1;
      }
   }
}

