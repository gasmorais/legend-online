package nodes
{
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_110 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_110()
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
               emptyAction();
               break;
            case 2:
               showMask_2();
               break;
            case 3:
               newModuleOpen();
               break;
            case 4:
               cleanAll_1();
         }
      }
      
      private function moveNPC() : void
      {
         if(NewbieBaseConditionMediator.checkPlayerGrade(7) && NewbieBaseConditionMediator.checkInScene(3,10003) && NewbieBaseConditionMediator.checkTaskHasCompleted(1826))
         {
            actionType = "mediators.NewbieBaseActionMediator|moveNPC";
            actionParams = "0,-1,-1,-1,-1,0";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function emptyAction() : void
      {
         if(NewbieBaseConditionMediator.checkPlayerGrade(7) && NewbieBaseConditionMediator.checkInScene(3,10003) && NewbieBaseConditionMediator.checkTaskHasCompleted(1826))
         {
            actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            actionParams = "";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function showMask_2() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("armyController","SkillFrame"))
         {
            complete();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|showMask";
         actionParams = "";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function newModuleOpen() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("armyController","SkillFrame"))
         {
            complete();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|newModuleOpen";
         actionParams = "skill,5703,1,2_4,0,0,4";
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

