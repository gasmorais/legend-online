package nodes
{
   import dialog.utils.NewbieSocketOutManager;
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_60 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_60()
      {
         super();
      }
      
      override protected function next() : void
      {
         switch(int(_step) - 1)
         {
            case 0:
               showMask_1();
               break;
            case 1:
               showDialog_1();
               break;
            case 2:
               moveNPC();
               break;
            case 3:
               enterSceneAfterPlayMovie();
               break;
            case 4:
               cleanAll_1();
         }
      }
      
      private function showMask_1() : void
      {
         if(NewbieBaseConditionMediator.checkInScene(3) && NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function showDialog_1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|showDialog";
         actionParams = "7";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function moveNPC() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|moveNPC";
         actionParams = "0,-1,-1,65,17,1";
         needWaitForComplete = true;
         NewbieSocketOutManager.sendSaveProcess(19000);
         excuteAction();
      }
      
      private function enterSceneAfterPlayMovie() : void
      {
         actionType = "mediators.NewbieSpecialActionMediator|enterSceneAfterPlayMovie";
         actionParams = "leavecampaign,2,103";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function cleanAll_1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         actionParams = "";
         needWaitForComplete = false;
         actionComplete = true;
         excuteAction();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

