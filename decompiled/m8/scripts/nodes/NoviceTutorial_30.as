package nodes
{
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_30 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_30()
      {
         super();
      }
      
      override protected function next() : void
      {
         switch(int(_step) - 1)
         {
            case 0:
               showMask();
               break;
            case 1:
               moveNPCByTween();
               break;
            case 2:
               showDialog();
         }
      }
      
      private function showMask() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000206,4) || NewbieBaseConditionMediator.checkCampaignNodeState(1000206,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(3))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function moveNPCByTween() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000206,4) || NewbieBaseConditionMediator.checkCampaignNodeState(1000206,8))
         {
            complete();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|moveNPCByTween";
         actionParams = "0,-1,-1,1320,860,260,1,1,2";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function showDialog() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000206,4) || NewbieBaseConditionMediator.checkCampaignNodeState(1000206,8))
         {
            skipNode();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|showDialog";
         actionParams = "2";
         needWaitForComplete = true;
         actionComplete = true;
         excuteAction();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

