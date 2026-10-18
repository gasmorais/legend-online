package nodes
{
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_190 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_190()
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
               moveFocusToCastleBuild();
               break;
            case 2:
               drawTargetOnMask_1();
               break;
            case 3:
               castleBuildShine();
               break;
            case 4:
               createGuildFrame4();
               break;
            case 5:
               setKeyboardState_1();
               break;
            case 6:
               showMask_2();
               break;
            case 7:
               createGuildFrame1_1();
               break;
            case 8:
               drawTargetOnMask_2();
               break;
            case 9:
               cleanAll_1();
               break;
            case 10:
               showMask_3();
               break;
            case 11:
               createGuildFrame1_2();
               break;
            case 12:
               drawTargetOnMask_3();
               break;
            case 13:
               cleanAll_2();
               break;
            case 14:
               emptyAction_1();
               break;
            case 15:
               emptyAction_2();
               break;
            case 16:
               setKeyboardState_2();
               break;
            case 17:
               cleanGameLayer();
               break;
            case 18:
               cleanAll_3();
         }
      }
      
      private function showMask_1() : void
      {
         if(NewbieBaseConditionMediator.checkTaskHasCompleted(1834))
         {
            completeNode();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(1))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0.5";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function moveFocusToCastleBuild() : void
      {
         if(NewbieBaseConditionMediator.checkTaskHasCompleted(1834))
         {
            completeNode();
            return;
         }
         if(NewbieBaseConditionMediator.checkCastleBuild(402))
         {
            actionType = "mediators.NewbieBaseActionMediator|moveFocusToCastleBuild";
            actionParams = "402";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function drawTargetOnMask_1() : void
      {
         if(NewbieBaseConditionMediator.checkTaskHasCompleted(1834))
         {
            completeNode();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "3_402,0";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function castleBuildShine() : void
      {
         if(NewbieBaseConditionMediator.checkTaskHasCompleted(1834))
         {
            completeNode();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|castleBuildShine";
         actionParams = "402";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function createGuildFrame4() : void
      {
         if(NewbieBaseConditionMediator.checkTaskHasCompleted(1834))
         {
            completeNode();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|createGuildFrame4";
         actionParams = "-300,-130,toCastle_1160";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function setKeyboardState_1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|setKeyboardState";
         actionParams = "0,1";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function showMask_2() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("buildingController","CasernFrame") || NewbieBaseConditionMediator.checkTaskHasCompleted(1834))
         {
            completeNode();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|showMask";
         actionParams = "0.5";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function createGuildFrame1_1() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("buildingController","CasernFrame") || NewbieBaseConditionMediator.checkTaskHasCompleted(1834))
         {
            completeNode();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         actionParams = "29_402,-100,-190,1405,1,2";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function drawTargetOnMask_2() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("buildingController","CasernFrame") || NewbieBaseConditionMediator.checkTaskHasCompleted(1834))
         {
            completeNode();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "3_402,1";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function cleanAll_1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         actionParams = "";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function showMask_3() : void
      {
         if(NewbieBaseConditionMediator.checkTaskHasCompleted(1834))
         {
            completeNode();
            return;
         }
         if(NewbieBaseConditionMediator.checkFrame("buildingController","CasernFrame"))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0.5";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function createGuildFrame1_2() : void
      {
         if(NewbieBaseConditionMediator.checkTaskHasCompleted(1834))
         {
            completeNode();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         actionParams = "9_101,-182,-230,1406,1,2";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function drawTargetOnMask_3() : void
      {
         if(NewbieBaseConditionMediator.checkTaskHasCompleted(1834))
         {
            completeNode();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "9_101,1";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function cleanAll_2() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         actionParams = "";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function emptyAction_1() : void
      {
         if(!NewbieBaseConditionMediator.checkFrame("buildingController","CasernFrame") || NewbieBaseConditionMediator.checkTaskHasCompleted(1834))
         {
            completeNode();
            return;
         }
         if(NewbieBaseConditionMediator.checkConditionCommon(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            actionParams = "";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function emptyAction_2() : void
      {
         if(NewbieBaseConditionMediator.checkTaskHasCompleted(1834))
         {
            completeNode();
            return;
         }
         if(!NewbieBaseConditionMediator.checkConditionCommon(4))
         {
            if(!NewbieBaseConditionMediator.checkHavePawn(101,200))
            {
               _step = 11;
               showMask_3();
               return;
            }
            actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            actionParams = "";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function setKeyboardState_2() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|setKeyboardState";
         actionParams = "1,2";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function cleanGameLayer() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|cleanGameLayer";
         actionParams = "";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function cleanAll_3() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         actionParams = "";
         needWaitForComplete = false;
         actionComplete = true;
         excuteAction();
      }
   }
}

