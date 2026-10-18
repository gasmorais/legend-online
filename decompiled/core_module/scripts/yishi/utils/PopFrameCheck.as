package yishi.utils
{
   import managers.MarryManager;
   import map.campaign.CampaignManager;
   import yishi.actions.map.MapBaseAction;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.GameBaseQueueManager;
   import yishi.scene.SceneManager;
   
   public class PopFrameCheck implements IEnterFrame
   {
      
      private static var _instance:PopFrameCheck;
      
      private var _actions:Array = [];
      
      public function PopFrameCheck()
      {
         super();
      }
      
      public static function get instance() : PopFrameCheck
      {
         if(!_instance)
         {
            _instance = new PopFrameCheck();
         }
         return _instance;
      }
      
      public function enterFrame() : void
      {
         if(_actions.length == 0)
         {
            EnterFrameManager.instance.unRegisteEnterFrame(this);
         }
         else if(stateCheck())
         {
            executeAction(_actions.shift());
         }
      }
      
      public function addAction(param1:MapBaseAction) : void
      {
         if(_actions.length == 0)
         {
            EnterFrameManager.instance.registeEnterFrame(this);
            _actions.push(param1);
         }
      }
      
      private function executeAction(param1:MapBaseAction) : void
      {
         GameBaseQueueManager.instance.addAction(param1);
      }
      
      private function stateCheck() : Boolean
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
         if(MarryManager.instance.model.lockScreen)
         {
            return false;
         }
         return true;
      }
   }
}

