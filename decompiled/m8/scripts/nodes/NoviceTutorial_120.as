package nodes
{
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_120 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_120()
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
               showMask_1();
               break;
            case 3:
               newModuleOpen();
               break;
            case 4:
               cleanAll_1();
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
      
      private function showMask_1() : void
      {
         if(NewbieBaseConditionMediator.checkPlayerGrade(7) && NewbieBaseConditionMediator.checkInScene(3,10003) && NewbieBaseConditionMediator.checkTaskHasCompleted(1827))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function newModuleOpen() : void
      {
         if(NewbieBaseConditionMediator.checkPlayerGrade(7) && NewbieBaseConditionMediator.checkInScene(3,10003) && NewbieBaseConditionMediator.checkTaskHasCompleted(1827))
         {
            actionType = "mediators.NewbieBaseActionMediator|newModuleOpen";
            actionParams = "smith,5704,1,2_3,0,0,3";
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
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

