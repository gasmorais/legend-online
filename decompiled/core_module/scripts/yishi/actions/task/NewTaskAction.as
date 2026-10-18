package yishi.actions.task
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import managers.OfferRewardManager;
   import yishi.actions.map.MapBaseAction;
   import yishi.actions.map.collection.CollectionAction;
   import yishi.interfaces.IAction;
   import yishi.manager.TaskManage;
   import yishi.scene.SceneManager;
   import yishi.view.tools.SimpleMovie;
   
   public class NewTaskAction extends MapBaseAction
   {
      
      private var _taskInfo:Object;
      
      private var _effect:MovieClip;
      
      private var _movie:SimpleMovie;
      
      public function NewTaskAction(param1:Object)
      {
         _taskInfo = param1;
         super();
      }
      
      override public function prepare() : void
      {
         SceneManager.instance.lockScene = false;
      }
      
      override public function update() : void
      {
         if(_taskInfo)
         {
            dispose();
            return;
         }
         ObjectUtils.disposeViolentMc(_effect);
         if(_movie)
         {
            _movie.dispose();
         }
         _movie = null;
         _taskInfo = null;
         _effect = null;
         dispose();
      }
      
      private function noTask(param1:Object) : Boolean
      {
         if(TaskManage.instance.cate.acceptedList.indexOf(_taskInfo) < 0 && OfferRewardManager.instance.model.baseRewardDic.getList().indexOf(_taskInfo) < 0)
         {
            return true;
         }
         return false;
      }
      
      override public function replace(param1:IAction) : Boolean
      {
         if(param1 is CollectionAction || param1 is CompleteTaskAction)
         {
            return true;
         }
         return false;
      }
   }
}

