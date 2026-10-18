package task.view
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleUpDownImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.TaskSelectEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import managers.MarryManager;
   import managers.OfferRewardManager;
   import managers.RingTaskManager;
   import mvc.module.task.TaskCategory;
   import mvc.module.task.TaskCondictionTemplate;
   import mvc.module.task.TaskTemplate;
   import yishi.manager.TaskManage;
   import yishi.utils.MsgMan;
   
   public class TaskListView extends Sprite implements Disposeable
   {
      
      private var _back:ScaleUpDownImage;
      
      private var _back2:ScaleUpDownImage;
      
      private var _icon:ScaleFrameImage;
      
      private var _txt:ScaleFrameImage;
      
      private var _listPanel:ListPanel;
      
      private var _taskList:Array;
      
      private var _type:int;
      
      private var _listMode:VectorListModel;
      
      private var _listHeight:int;
      
      private var _listWidth:int;
      
      private var _cate:TaskCategory;
      
      public var menuCount:int;
      
      public function TaskListView(param1:int, param2:int)
      {
         super();
         _listHeight = param2;
         _listWidth = param1;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("task.TaskListBack");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("task.TaskListBack2");
         _icon = ComponentFactory.Instance.creatComponentByStylename("task.TaskTypeIcon");
         _txt = ComponentFactory.Instance.creatComponentByStylename("task.TaskTypeTxt");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("task.ListPanel");
         _listPanel.vUnitIncrement = 56;
         _listPanel.beginChanges();
         _listMode = _listPanel.vectorListModel;
         _listPanel.width = _listWidth;
         _listPanel.commitChanges();
         addChild(_back);
         addChild(_back2);
         addChild(_listPanel);
         addChild(_icon);
         addChild(_txt);
         _cate = TaskManage.instance.cate;
      }
      
      private function uninit() : void
      {
         _taskList = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function initEvent() : void
      {
         _listPanel.list.addEventListener("listItemClick",__itemSelectedHadler);
         OfferRewardManager.instance.addEventListener("REWARD_TASK_UPDATE",__updateRewardTaskHandler);
         TaskManage.instance.addEventListener("task_detail_change",__updateRewardTaskHandler);
         MsgMan.addObserver("MarryEventType.TASK_UPDATE",this,__marryTaskUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         _listPanel.list.removeEventListener("listItemClick",__itemSelectedHadler);
         OfferRewardManager.instance.removeEventListener("REWARD_TASK_UPDATE",__updateRewardTaskHandler);
         TaskManage.instance.removeEventListener("task_detail_change",__updateRewardTaskHandler);
         MsgMan.removeObserver("MarryEventType.TASK_UPDATE",this,__marryTaskUpdateHandler);
      }
      
      private function __itemSelectedHadler(param1:ListItemEvent) : void
      {
         SoundManager.instance.play("022",true);
         var _loc2_:Object = param1.cellValue;
         dispatchEvent(new TaskSelectEvent("task_item_selected",_loc2_));
      }
      
      private function __marryTaskUpdateHandler(param1:String, param2:Object) : void
      {
      }
      
      private function __updateRewardTaskHandler(param1:Event) : void
      {
         if(param1["data"])
         {
            if(param1["data"]["isCompleted"])
            {
               _listPanel.list.defaultSelectItemByCellValue = param1["data"];
            }
         }
      }
      
      public function refreshList() : void
      {
         var _loc2_:int = 0;
         _listMode.clear();
         if(_taskList.length == 0)
         {
            return;
         }
         _listPanel.beginChanges();
         _taskList.sortOn(["isCompleted","Sort"],[2,16]);
         _loc2_ = 0;
         while(_loc2_ < _taskList.length)
         {
            if(_taskList[_loc2_].conditionList[0] is TaskCondictionTemplate != false)
            {
               for each(var _loc1_:TaskCondictionTemplate in _taskList[_loc2_].conditionList)
               {
                  if(_loc1_.CondictionType == 48)
                  {
                     setMobileToTop(_taskList,_loc2_);
                  }
               }
            }
            _loc2_++;
         }
         _listMode.appendAll(_taskList);
         _listPanel.height = getListHeightByMenu();
         _back.beginChanges();
         _back.height = _listPanel.height + 60;
         _back.commitChanges();
         _back2.beginChanges();
         _back2.height = _listPanel.height + 60;
         _back2.commitChanges();
         _listPanel.invalidateViewport();
         _listPanel.commitChanges();
         if(_listPanel.vScrollbar.visible)
         {
            _listPanel.x = 0;
         }
         else
         {
            _listPanel.x = 10;
         }
         setDefaultSelected();
      }
      
      private function getListHeightByMenu() : Number
      {
         var _loc2_:Number = 440;
         var _loc3_:Number = menuCount * 62;
         var _loc1_:Number = Number(_listPanel.vectorListModel.getAllCellHeight());
         if(_loc1_ > _loc2_ - _loc3_)
         {
            return _loc2_ - _loc3_;
         }
         return _loc1_;
      }
      
      public function removeList() : void
      {
         while(_listMode.getSize() > 0)
         {
            _listMode.removeAt(0);
         }
      }
      
      public function getItemByValue(param1:Object) : IListCell
      {
         return _listPanel.list.getItemByValue(param1);
      }
      
      public function set selectedByInfo(param1:Object) : void
      {
         _listPanel.list.defaultSelectItemByCellValue = param1;
      }
      
      private function setDefaultSelected() : void
      {
         if(_taskList[0])
         {
            _listPanel.list.defaultSelectItemByCellValue = _taskList[0];
         }
         else
         {
            dispatchEvent(new TaskSelectEvent("task_item_selected",null));
         }
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         _back.visible = true;
         _back2.visible = false;
         switch(_type)
         {
            case 0:
               _icon.setFrame(1);
               _txt.setFrame(1);
               _taskList = _cate.mainTaskList;
               break;
            case 1:
               _icon.setFrame(2);
               _txt.setFrame(2);
               _taskList = _cate.commonTaskList;
               break;
            case 2:
               _icon.setFrame(3);
               _txt.setFrame(3);
               _taskList = _cate.actTaskList.concat(_cate.backplayerTaskList);
               break;
            case 3:
               _icon.setFrame(4);
               _txt.setFrame(4);
               _taskList = _cate.vipTaskList;
               break;
            case 100:
               _icon.setFrame(5);
               _txt.setFrame(5);
               _taskList = OfferRewardManager.instance.model.baseRewardDic.getList();
               break;
            case -2:
               _icon.setFrame(6);
               _txt.setFrame(6);
               _back.visible = false;
               _back2.visible = true;
               if(RingTaskManager.instance.getRingTask())
               {
                  _taskList = RingTaskManager.instance.model.hasAccessList.getList();
               }
               else
               {
                  _taskList = [RingTaskManager.instance.getOfferTemplete()];
               }
               break;
            case -3:
               _icon.setFrame(7);
               _txt.setFrame(7);
               _back.visible = false;
               _back2.visible = true;
               _taskList = MarryManager.instance.model.hasAccessList.getList();
               break;
            default:
               _taskList = _cate.manualTaskList;
         }
         if(_taskList)
         {
            if(_type != 100)
            {
               _taskList.sort(sortOnIsFInish);
            }
            refreshList();
         }
      }
      
      private function setMobileToTop(param1:Array, param2:int) : void
      {
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_].isCompleted == false)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         var _loc5_:TaskTemplate = param1[param2] as TaskTemplate;
         param1.splice(param2,1);
         if(_loc5_.isCompleted == false)
         {
            param1.splice(_loc3_,0,_loc5_);
         }
         else
         {
            param1.splice(0,0,_loc5_);
         }
      }
      
      private function sortOnIsFInish(param1:Object, param2:Object) : int
      {
         if(param1.isCompleted && !param2.isCompleted)
         {
            return -1;
         }
         if(!param1.isCompleted && param2.isCompleted)
         {
            return 1;
         }
         return 0;
      }
      
      public function get viewHeight() : Number
      {
         return _back.displayHeight;
      }
      
      public function dispose() : void
      {
         removeList();
         removeEvent();
         uninit();
      }
   }
}

