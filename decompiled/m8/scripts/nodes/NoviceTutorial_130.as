package nodes
{
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_130 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_130()
      {
         super();
      }
      
      override protected function next() : void
      {
         switch(int(_step) - 1)
         {
            case 0:
               moveNPC();
               break;
            case 1:
               setMainToolBarBtn();
               break;
            case 2:
               cleanAll_1();
         }
      }
      
      private function moveNPC() : void
      {
         if(NewbieBaseConditionMediator.checkPlayerGrade(10) && NewbieBaseConditionMediator.checkInScene(3,10003))
         {
            actionType = "mediators.NewbieBaseActionMediator|moveNPC";
            actionParams = "0,-1,-1,-1,-1,0";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function setMainToolBarBtn() : void
      {
         if(NewbieBaseConditionMediator.checkPlayerGrade(10) && NewbieBaseConditionMediator.checkInScene(3,10003))
         {
            actionType = "mediators.NewbieBaseActionMediator|setMainToolBarBtn";
            actionParams = "1,1";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function cleanAll_1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         actionParams = "";
         needWaitForComplete = false;
         actionComplete = true;
         excuteAction();
      }
   }
}

