package nodes
{
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_80 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_80()
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
               moveNPC();
               break;
            case 2:
               newModuleOpen();
               break;
            case 3:
               createGuildFrame1();
               break;
            case 4:
               drawTargetOnMask_2();
               break;
            case 5:
               cleanDrawContainer();
               break;
            case 6:
               cleanGuildFrame();
               break;
            case 7:
               weaponEquipGuild();
               break;
            case 8:
               cleanAll_1();
               break;
            case 9:
               doTask();
         }
      }
      
      private function showMask_1() : void
      {
         if(NewbieBaseConditionMediator.checkInScene(3,10003) && NewbieBaseConditionMediator.checkTaskHasCompleted(1823))
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
         actionParams = "0,-1,-1,-1,-1,0";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function newModuleOpen() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|newModuleOpen";
         actionParams = "bag,5701,1,2_2,0,0,2";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function createGuildFrame1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         actionParams = "2_2,-510,-130,1402,1,1";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function drawTargetOnMask_2() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "2_2,1";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function cleanDrawContainer() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|cleanDrawContainer";
         actionParams = "";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function cleanGuildFrame() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|cleanGuildFrame";
         actionParams = "";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function weaponEquipGuild() : void
      {
         if(!NewbieBaseConditionMediator.checkConditionCommon(7,"101","1","1"))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkFrame("armyController","ArmyFrameII"))
         {
            actionType = "mediators.NewbieSpecialActionMediator|weaponEquipGuild";
            actionParams = "";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function cleanAll_1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         actionParams = "";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function doTask() : void
      {
         if(!NewbieBaseConditionMediator.checkFrame("armyController","ArmyFrameII"))
         {
            actionType = "mediators.NewbieBaseActionMediator|doTask";
            actionParams = "";
            needWaitForComplete = false;
            actionComplete = true;
            excuteAction();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

