package nodes
{
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_140 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_140()
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
               emptyAction_1();
               break;
            case 2:
               showMask();
               break;
            case 3:
               createGuildFrame1_1();
               break;
            case 4:
               drawTargetOnMask_1();
               break;
            case 5:
               cleanDrawContainer();
               break;
            case 6:
               cleanGuildFrame();
               break;
            case 7:
               emptyAction_2();
               break;
            case 8:
               createGuildFrame1_2();
               break;
            case 9:
               drawTargetOnMask_2();
               break;
            case 10:
               cleanAll();
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
      
      private function emptyAction_1() : void
      {
         if(NewbieBaseConditionMediator.checkPlayerGrade(10) && NewbieBaseConditionMediator.checkInScene(3,10003))
         {
            actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            actionParams = "";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function showMask() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("armyController","SkillFrame"))
         {
            complete();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|showMask";
         actionParams = "0.5";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function createGuildFrame1_1() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("armyController","SkillFrame"))
         {
            complete();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         actionParams = "2_4,-550,-120,1413,1,1";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function drawTargetOnMask_1() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("armyController","SkillFrame"))
         {
            complete();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "2_4,1";
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
      
      private function emptyAction_2() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("armyController","SkillFrame"))
         {
            actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            actionParams = "";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function createGuildFrame1_2() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         actionParams = "10_10,-153,-225,1414,1,2";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function drawTargetOnMask_2() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "10_10,1";
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

