package nodes
{
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_20 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_20()
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
               lockCampaignScene1();
               break;
            case 2:
               moveNPCByTween1();
               break;
            case 3:
               moveNPCByTween2();
               break;
            case 4:
               lockCampaignScene2();
               break;
            case 5:
               setNPC();
               break;
            case 6:
               showDialog();
               break;
            case 7:
               cleanAll();
         }
      }
      
      private function showMask() : void
      {
         if(NewbieBaseConditionMediator.checkInScene(3))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function lockCampaignScene1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|lockCampaignScene";
         actionParams = "1";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function moveNPCByTween1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|moveNPCByTween";
         actionParams = "0,1600,1600,1285,1045,240,2,0,1";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function moveNPCByTween2() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|moveNPCByTween";
         actionParams = "1000206,1700,1700,1350,1270,260,2,1";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function lockCampaignScene2() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|lockCampaignScene";
         actionParams = "0";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function setNPC() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|setNPC";
         actionParams = "0,-1,-1,20";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function showDialog() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|showDialog";
         actionParams = "1";
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
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

