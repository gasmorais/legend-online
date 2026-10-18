package task.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.RewardEvent;
   import events.RingTaskEvent;
   import events.TaskEvent;
   import events.TaskSelectEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import managers.OfferRewardManager;
   import managers.RingTaskManager;
   import managers.VIPManager;
   import mvc.module.marry.MarryTask;
   import mvc.module.offerreward.BaseOfferReward;
   import mvc.module.task.TaskCategory;
   import mvc.module.task.TaskTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TaskManage;
   import yishi.utils.MsgMan;
   import yishi.view.guild.NoviceArrowView;
   
   public class TaskMenuII extends Sprite implements Disposeable
   {
      
      private var _vBox:Sprite;
      
      private var _mainButton:SelectedButton;
      
      private var _commonButton:SelectedButton;
      
      private var _actButton:SelectedButton;
      
      private var _vipButton:SelectedButton;
      
      private var _rewardBtn:SelectedButton;
      
      private var _ringtasksBtn:SelectedButton;
      
      private var _marryTaskBtn:SelectedButton;
      
      private var _buttongroup:SelectedButtonGroup;
      
      private var _taskViewList:TaskListView;
      
      private var _taskInfoList:Array;
      
      private var _taskTypeList:Array;
      
      private var _currentSelected:SelectedButton;
      
      private var _noviceArrow:NoviceArrowView;
      
      public function TaskMenuII()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _buttongroup = new SelectedButtonGroup();
         _vBox = new Sprite();
         addChild(_vBox);
         _mainButton = ComponentFactory.Instance.creatComponentByStylename("task.TaskMainButton");
         _commonButton = ComponentFactory.Instance.creatComponentByStylename("task.TaskCommonButton");
         _actButton = ComponentFactory.Instance.creatComponentByStylename("task.TaskActButton");
         _vipButton = ComponentFactory.Instance.creatComponentByStylename("task.TaskVipButton");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("task.TaskOfferButton");
         _ringtasksBtn = ComponentFactory.Instance.creatComponentByStylename("task.RingTaskButton");
         _marryTaskBtn = ComponentFactory.Instance.creatComponentByStylename("task.MmarryTaskBtn");
         _vBox.addChild(_mainButton);
         _vBox.addChild(_commonButton);
         _vBox.addChild(_marryTaskBtn);
         _vBox.addChild(_actButton);
         _vBox.addChild(_vipButton);
         _vBox.addChild(_rewardBtn);
         _vBox.addChild(_ringtasksBtn);
         _taskViewList = new TaskListView(275,240);
      }
      
      public function defaultSelected() : void
      {
         if(!_vBox)
         {
            return;
         }
         ObjectUtils.removeChildAllChildrenFromStage(_vBox);
         refreshTaskType();
         refreshMenu();
         refreshSelectedMenuByType();
      }
      
      private function refreshTaskType() : void
      {
         _taskTypeList = TaskManage.instance.existTaskType;
         if(rewardManager.model.baseRewardDic.getList().length > 0)
         {
            _taskTypeList.push(100);
         }
         _taskTypeList.sort(16);
         _taskTypeList.push(-2);
         if(MarryManager.instance.model.hasAccessList.getList().length > 0)
         {
            _taskTypeList.push(-3);
         }
      }
      
      private function refreshMenu() : void
      {
         var _loc1_:int = 0;
         _buttongroup.removeEventListener("change",__menuSelectedHandler);
         _buttongroup.removeAllItem();
         _buttongroup.selectIndex = -1;
         _loc1_ = 0;
         while(_loc1_ < _taskTypeList.length)
         {
            switch(_taskTypeList[_loc1_])
            {
               case 2:
               case 4:
                  if(!_actButton.parent)
                  {
                     _vBox.addChild(_actButton);
                  }
                  if(_buttongroup.getSelectIndexByItem(_actButton) < 0)
                  {
                     _buttongroup.addSelectItem(_actButton);
                  }
                  break;
               case 1:
                  _buttongroup.addSelectItem(_commonButton);
                  _vBox.addChild(_commonButton);
                  break;
               case 0:
                  _buttongroup.addSelectItem(_mainButton);
                  _vBox.addChild(_mainButton);
                  break;
               case 3:
                  _buttongroup.addSelectItem(_vipButton);
                  _vBox.addChild(_vipButton);
                  break;
               case 100:
                  _buttongroup.addSelectItem(_rewardBtn);
                  _vBox.addChild(_rewardBtn);
            }
            _loc1_++;
         }
         if(ArmyManager.instance.thane.grades >= 35)
         {
            _buttongroup.addSelectItem(_ringtasksBtn);
            _vBox.addChild(_ringtasksBtn);
         }
         if(MarryManager.instance.model.hasAccessList.getList().length > 0)
         {
            _buttongroup.addSelectItem(_marryTaskBtn);
            _vBox.addChildAt(_marryTaskBtn,2);
         }
         _buttongroup.addEventListener("change",__menuSelectedHandler);
      }
      
      private function checkShowVip() : void
      {
         var _loc1_:Boolean = Boolean(VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt);
         if(!_loc1_)
         {
            FrameControllerManager.instance.openControllerByInfo("vip");
         }
      }
      
      private function getMenuType(param1:SelectedButton) : int
      {
         ringTaskManager._isRingTask = false;
         switch(param1)
         {
            case _mainButton:
               return 0;
            case _commonButton:
               return 1;
            case _actButton:
               return 2;
            case _vipButton:
               checkShowVip();
               return 3;
            case _rewardBtn:
               return 100;
            case _ringtasksBtn:
               ringTaskManager._isRingTask = true;
               return -2;
            case _marryTaskBtn:
               return -3;
            default:
               return -2147483648;
         }
      }
      
      public function getButtonByType(param1:int) : SelectedButton
      {
         switch(param1)
         {
            case 0:
               return _mainButton;
            case 1:
               return _commonButton;
            case 2:
            case 4:
               break;
            case 3:
               return _vipButton;
            case -2:
               return _ringtasksBtn;
            case -3:
               return _marryTaskBtn;
            case 100:
               return _rewardBtn;
            default:
               return null;
         }
         return _actButton;
      }
      
      private function refreshSelectedMenuByType(param1:int = -1) : void
      {
         var _loc2_:SelectedButton = null;
         var _loc3_:int = 0;
         var _loc7_:Array = null;
         var _loc4_:Boolean = false;
         var _loc8_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         if(param1 == -1)
         {
            _loc7_ = TaskManage.instance.getCompletedList();
            if(rewardManager.completedRewardList.length > 0)
            {
               _loc7_ = _loc7_.concat(rewardManager.completedRewardList);
            }
            _loc7_.sortOn(["isCompleted","Sort"],[2,16]);
            _loc4_ = Boolean(VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt);
            _loc5_ = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc7_.length)
            {
               _loc8_ = _loc7_[0];
               if(!(_loc8_ is TaskTemplate && _loc8_["TemplateType"] == 3 && !_loc4_))
               {
                  if(_loc8_ is BaseOfferReward)
                  {
                     _loc3_ = 100;
                  }
                  else
                  {
                     _loc3_ = int((_loc8_ as TaskTemplate).TemplateType);
                  }
                  _buttongroup.selectIndex = _buttongroup.getIndexByItem(getButtonByType(_loc3_));
                  _loc6_ = true;
               }
               _loc5_++;
            }
         }
         else
         {
            _buttongroup.selectIndex = _buttongroup.getIndexByItem(getButtonByType(param1));
            _loc6_ = true;
         }
         _loc5_ = 0;
         while(_loc5_ < _taskTypeList.length)
         {
            _loc2_ = getButtonByType(int(_taskTypeList[_loc5_]));
            _loc2_.enable = true;
            if(!_loc6_)
            {
               _buttongroup.selectIndex = _buttongroup.getIndexByItem(_loc2_);
               _loc6_ = true;
            }
            _loc5_++;
         }
         refreshMenuPos();
         if(!_loc6_)
         {
            dispatchEvent(new TaskSelectEvent("task_item_selected",null));
         }
      }
      
      private function __menuSelectedHandler(param1:Event) : void
      {
         _currentSelected = _buttongroup.getSelectedItem() as SelectedButton;
         if(!_currentSelected)
         {
            return;
         }
         ObjectUtils.removeChildAllChildrenFromStage(_vBox);
         refreshMenu();
         SoundManager.instance.play("022",true);
         if(_taskTypeList.indexOf(2) >= 0 && _taskTypeList.indexOf(4) >= 0)
         {
            _taskViewList.menuCount = _taskTypeList.length - 1;
         }
         else
         {
            _taskViewList.menuCount = _taskTypeList.length;
         }
         _taskViewList.type = getMenuType(_currentSelected);
         _vBox.addChildAt(_taskViewList,_vBox.getChildIndex(_currentSelected));
         _vBox.removeChild(_currentSelected);
         refreshMenuPos();
      }
      
      public function set selectedByInfo(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            refreshMenu();
            _loc2_ = 100;
            if(param1 is TaskTemplate || param1 is MarryTask)
            {
               _loc2_ = int(param1.TemplateType);
            }
            refreshSelectedMenuByType(_loc2_);
            _taskViewList.selectedByInfo = param1;
         }
      }
      
      public function get taskViewList() : TaskListView
      {
         return _taskViewList;
      }
      
      private function get rewardManager() : OfferRewardManager
      {
         return OfferRewardManager.instance;
      }
      
      private function get ringTaskManager() : RingTaskManager
      {
         return RingTaskManager.instance;
      }
      
      private function get cate() : TaskCategory
      {
         return TaskManage.instance.cate;
      }
      
      private function initEvent() : void
      {
         _taskViewList.addEventListener("task_item_selected",__itemSelectedHandler);
         cate.addEventListener("task_added",__addHandler);
         cate.addEventListener("task_remove",__removeHandler);
         OfferRewardManager.instance.addEventListener("REWARD_TASK_ADD",__addRewardTaskHandler);
         OfferRewardManager.instance.addEventListener("REWARD_TASK_FINISH",__removeRewardTaskHandler);
         ringTaskManager.addEventListener("REFRESHTING",refreshRing);
         MsgMan.addObserver("MarryEventType.TASK_UPDATE",this,__marryTaskUpdateHandler);
      }
      
      private function __marryTaskUpdateHandler(param1:String, param2:Object) : void
      {
         defaultSelected();
      }
      
      private function __addHandler(param1:TaskEvent) : void
      {
         defaultSelected();
      }
      
      private function __removeHandler(param1:TaskEvent) : void
      {
         defaultSelected();
         if(param1.data && (param1.data.TemplateId == 80 || param1.data.TemplateId == 90 || param1.data.TemplateId == 81))
         {
            if(!_noviceArrow)
            {
               _noviceArrow = new NoviceArrowView(4,LanguageMgr.GetTranslation("yishi.utils.MaskUtils.arrowTipCloseTask"),false);
            }
            _noviceArrow.x = 780;
            _noviceArrow.y = 54;
            addChild(_noviceArrow);
         }
      }
      
      private function __addRewardTaskHandler(param1:RewardEvent) : void
      {
         defaultSelected();
      }
      
      private function __removeRewardTaskHandler(param1:RewardEvent) : void
      {
         defaultSelected();
      }
      
      private function removeEvent() : void
      {
         _taskViewList.removeEventListener("task_item_selected",__itemSelectedHandler);
         cate.removeEventListener("task_added",__addHandler);
         cate.removeEventListener("task_remove",__removeHandler);
         OfferRewardManager.instance.removeEventListener("REWARD_TASK_ADD",__addRewardTaskHandler);
         OfferRewardManager.instance.removeEventListener("REWARD_TASK_FINISH",__removeRewardTaskHandler);
         ringTaskManager.removeEventListener("REFRESHTING",refreshRing);
         MsgMan.removeObserver("MarryEventType.TASK_UPDATE",this,__marryTaskUpdateHandler);
      }
      
      private function refreshRing(param1:RingTaskEvent) : void
      {
         defaultSelected();
      }
      
      public function __itemSelectedHandler(param1:TaskSelectEvent) : void
      {
         var _loc2_:Object = param1.info;
         if(!_loc2_)
         {
            defaultSelected();
         }
         else
         {
            refreshMenuPos();
            dispatchEvent(new TaskSelectEvent("task_item_selected",_loc2_));
         }
      }
      
      private function refreshMenuPos() : void
      {
         var _loc2_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc1_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < _vBox.numChildren)
         {
            _loc3_ = _vBox.getChildAt(_loc2_);
            _loc3_.y = _loc1_;
            if(_loc3_ is TaskListView)
            {
               _loc1_ += (_loc3_ as TaskListView).viewHeight + 9;
            }
            else
            {
               _loc1_ += _loc3_.height + 9;
            }
            _loc2_++;
         }
      }
      
      public function get currentSelected() : SelectedButton
      {
         return _currentSelected;
      }
      
      public function get rewardBtn() : SelectedButton
      {
         return _rewardBtn;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_mainButton);
         _mainButton = null;
         ObjectUtils.disposeObject(_commonButton);
         _commonButton = null;
         ObjectUtils.disposeObject(_actButton);
         _actButton = null;
         ObjectUtils.disposeObject(_vipButton);
         _vipButton = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_buttongroup);
         _buttongroup = null;
         ObjectUtils.disposeObject(_taskViewList);
         _taskViewList = null;
         ObjectUtils.disposeObject(_noviceArrow);
         _noviceArrow = null;
      }
   }
}

