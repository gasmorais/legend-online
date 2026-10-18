package yishi.actions.task
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.events.Event;
   import managers.MopupManager;
   import managers.OfferRewardManager;
   import managers.RingTaskManager;
   import mvc.module.task.TaskTemplate;
   import yishi.actions.castle.NewBuildAction;
   import yishi.actions.map.MapBaseAction;
   import yishi.actions.map.collection.CollectionAction;
   import yishi.interfaces.IAction;
   import yishi.manager.PlayerManager;
   import yishi.manager.TaskManage;
   import yishi.scene.SceneManager;
   import yishi.utils.DelayActionsUtils;
   import yishi.view.community.CompleteTaskTip;
   
   public class CompleteTaskAction extends MapBaseAction
   {
      
      private var _count:int;
      
      private var _taskTip:CompleteTaskTip;
      
      private var _taskInfo:Object;
      
      public function CompleteTaskAction(param1:Object)
      {
         level = -1;
         _taskInfo = param1;
         super();
         addEvent();
      }
      
      private function addEvent() : void
      {
         TaskManage.instance.cate.addEventListener("task_remove",__taskFinishHandler);
         OfferRewardManager.instance.addEventListener("REWARD_TASK_FINISH",__taskFinishHandler);
         RingTaskManager.instance.addEventListener("COMPLETETASK",__taskFinishHandler);
      }
      
      private function removeEvent() : void
      {
         TaskManage.instance.cate.removeEventListener("task_remove",__taskFinishHandler);
         OfferRewardManager.instance.removeEventListener("REWARD_TASK_FINISH",__taskFinishHandler);
         RingTaskManager.instance.removeEventListener("COMPLETETASK",__taskFinishHandler);
      }
      
      private function __taskFinishHandler(param1:Event) : void
      {
         if(!_taskInfo || param1["data"] == _taskInfo)
         {
            dispose();
         }
      }
      
      override public function prepare() : void
      {
         SceneManager.instance.lockScene = false;
      }
      
      override public function update() : void
      {
         if(SceneManager.instance.currentType == "BATTLE_SCENE" || PlayerManager.instance.isExistNewbieMask)
         {
            dispose();
            return;
         }
         if(MopupManager.instance.model.isMopup)
         {
            DelayActionsUtils.instance.addAction(new CompleteTaskAction(_taskInfo));
            dispose();
            return;
         }
         if(_count == 0)
         {
            dispose();
            return;
         }
         if(_count > 250 && !_taskTip.isMouseOver)
         {
            dispose();
         }
         else if(_count > 300)
         {
            dispose();
         }
         _count = _count + 1;
      }
      
      private function __removedFromStageHandler(param1:Event) : void
      {
         if(_taskTip)
         {
            _taskTip.removeEventListener("removedFromStage",__removedFromStageHandler);
            _taskTip = null;
         }
         dispose();
      }
      
      public function get taskTip() : CompleteTaskTip
      {
         return _taskTip;
      }
      
      override public function filter(param1:IAction) : Boolean
      {
         if(param1 is CompleteTaskAction)
         {
            return true;
         }
         return false;
      }
      
      override public function replace(param1:IAction) : Boolean
      {
         if(param1 is CollectionAction || param1 is NewBuildAction)
         {
            return true;
         }
         return false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_taskTip)
         {
            _taskTip.removeEventListener("removedFromStage",__removedFromStageHandler);
            _taskTip.dispose();
            _taskTip = null;
         }
         _taskInfo = null;
         super.dispose();
      }
   }
}

