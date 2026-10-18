package nodes
{
   import dialog.utils.NewbieSocketOutManager;
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_150 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_150()
      {
         super();
      }
      
      override protected function next() : void
      {
         switch(int(_step) - 1)
         {
            case 0:
               emptyAction();
               break;
            case 1:
               doTask();
               break;
            case 2:
               showMask();
               break;
            case 3:
               moveNPC();
               break;
            case 4:
               enterSceneAfterPlayMovie();
               break;
            case 5:
               cleanAll();
         }
      }
      
      private function emptyAction() : void
      {
         if(!NewbieBaseConditionMediator.checkFrame("armyController","SkillFrame"))
         {
            actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            actionParams = "";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function doTask() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|doTask";
         actionParams = "";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function showMask() : void
      {
         if(NewbieBaseConditionMediator.checkInScene(3,10003) && NewbieBaseConditionMediator.checkTaskHasCompleted(1831))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function moveNPC() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|moveNPC";
         actionParams = "0,-1,-1,50,41,1";
         needWaitForComplete = true;
         NewbieSocketOutManager.sendSaveProcess(19000);
         excuteAction();
      }
      
      private function enterSceneAfterPlayMovie() : void
      {
         actionType = "mediators.NewbieSpecialActionMediator|enterSceneAfterPlayMovie";
         actionParams = "leavevillage,2,103";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function cleanAll() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         actionParams = "";
         needWaitForComplete = false;
         actionComplete = true;
         excuteAction();
      }
   }
}

