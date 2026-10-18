package yishi.utils
{
   import managers.MopupManager;
   import map.campaign.CampaignManager;
   import yishi.actions.base.AlertTipAction;
   import yishi.actions.map.MapBaseAction;
   import yishi.actions.task.CompleteTaskAction;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.GameBaseQueueManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   
   public class DelayActionsUtils implements IEnterFrame
   {
      
      private static var _instance:DelayActionsUtils;
      
      private var _actions:Array = [];
      
      private var _levelQueue:Array = [];
      
      private var _frame:int;
      
      public function DelayActionsUtils()
      {
         super();
      }
      
      public static function get instance() : DelayActionsUtils
      {
         if(!_instance)
         {
            _instance = new DelayActionsUtils();
         }
         return _instance;
      }
      
      public function addAction(param1:MapBaseAction) : void
      {
         if(_actions.length == 0)
         {
            startDealy();
         }
         _actions.push(param1);
      }
      
      private function startDealy() : void
      {
         _frame = 0;
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function stopDealy() : void
      {
         var _loc1_:MapBaseAction = null;
         _actions.sortOn("level",2 | 0x10);
         while(_actions.length > 0)
         {
            _loc1_ = _actions.shift();
            if((SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE") && !checkCompleteTaskDelay(_loc1_) && !checkTraceTipDelay(_loc1_))
            {
               GameBaseQueueManager.instance.addAction(_loc1_);
            }
            else
            {
               _levelQueue.push(_loc1_);
            }
         }
      }
      
      private function checkState(param1:MapBaseAction) : Boolean
      {
         if(CampaignManager.CampaignOverState)
         {
            return false;
         }
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            return false;
         }
         if(SceneManager.instance.lock)
         {
            return false;
         }
         if(GameBaseQueueManager.instance.actionsLength > 0)
         {
            return false;
         }
         if(checkCompleteTaskDelay(param1))
         {
            return false;
         }
         if(checkTraceTipDelay(param1))
         {
            return false;
         }
         return true;
      }
      
      private function checkCompleteTaskDelay(param1:MapBaseAction) : Boolean
      {
         if(!(param1 is CompleteTaskAction))
         {
            return false;
         }
         if(MopupManager.instance.model.isMopup)
         {
            return true;
         }
         return false;
      }
      
      private function checkTraceTipDelay(param1:MapBaseAction) : Boolean
      {
         if(!(param1 is AlertTipAction))
         {
            return false;
         }
         if(PlayerManager.instance.isExistNewbieMask)
         {
            return true;
         }
         return false;
      }
      
      private function get curScene() : String
      {
         return SceneManager.instance.currentType;
      }
      
      public function enterFrame() : void
      {
         _frame = _frame + 1;
         if(_frame == 13)
         {
            stopDealy();
         }
         else if(_frame > 13 && _levelQueue.length > 0)
         {
            if(checkState(_levelQueue[0]))
            {
               GameBaseQueueManager.instance.addAction(_levelQueue.shift());
            }
         }
         else if(_frame > 13 && _levelQueue.length == 0)
         {
            _frame = 0;
            EnterFrameManager.instance.unRegisteEnterFrame(this);
         }
      }
   }
}

