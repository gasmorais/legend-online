package nodes
{
   import dialog.utils.NewbieNodeBase;
   import mediators.NewbieBaseConditionMediator;
   import yishi.scene.SceneManager;
   
   public class NoviceNode_30 extends NewbieNodeBase
   {
      
      public function NoviceNode_30()
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
               showMask_2();
               break;
            case 6:
               createGuildFrame1_1();
               break;
            case 7:
               drawTargetOnMask_2();
               break;
            case 8:
               cleanDrawContainer();
               break;
            case 9:
               cleanGuildFrame();
               break;
            case 10:
               emptyAction();
               break;
            case 11:
               createGuildFrame1_2();
               break;
            case 12:
               drawTargetOnMask_3();
               break;
            case 13:
               cleanAll();
         }
      }
      
      private function showMask_1() : void
      {
         if(NewbieBaseConditionMediator.checkPlayerGrade(15) && !NewbieBaseConditionMediator.checkConditionCommon(6) && NewbieBaseConditionMediator.checkInScene(1))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0.5";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function moveFocusToCastleBuild() : void
      {
         if(NewbieBaseConditionMediator.checkCastleBuild(1511))
         {
            actionType = "mediators.NewbieBaseActionMediator|moveFocusToCastleBuild";
            actionParams = "1511";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function drawTargetOnMask_1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "3_1511,0";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function castleBuildShine() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|castleBuildShine";
         actionParams = "1511";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function createGuildFrame4() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|createGuildFrame4";
         actionParams = "-250,50,toCastle_3800";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function showMask_2() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("buildingController","TransferBuildFrame"))
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
         if(NewbieBaseConditionMediator.checkFrame("buildingController","TransferBuildFrame"))
         {
            completeNode();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         actionParams = "29_1511,-200,0,1419,1,4";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function drawTargetOnMask_2() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("buildingController","TransferBuildFrame"))
         {
            completeNode();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "3_1511,1";
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
      
      private function emptyAction() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("buildingController","TransferBuildFrame"))
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
         actionParams = "81,-300,-50,1420,1,1";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function drawTargetOnMask_3() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "81,1";
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
      
      override public function get canDisplay() : Boolean
      {
         if(SceneManager.instance.currentType == "CASTLE_SCENE")
         {
            return true;
         }
         return false;
      }
   }
}

