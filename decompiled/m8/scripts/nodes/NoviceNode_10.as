package nodes
{
   import dialog.utils.NewbieNodeBase;
   import farm.FarmManager;
   import mediators.NewbieBaseConditionMediator;
   import yishi.scene.SceneManager;
   
   public class NoviceNode_10 extends NewbieNodeBase
   {
      
      public function NoviceNode_10()
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
               cleanDrawContainer();
               break;
            case 6:
               cleanGuildFrame();
               break;
            case 7:
               showMask_2();
               break;
            case 8:
               createGuildFrame1();
               break;
            case 9:
               drawTargetOnMask_2();
               break;
            case 10:
               cleanAll();
         }
      }
      
      private function showMask_1() : void
      {
         if(NewbieBaseConditionMediator.checkPlayerGrade(12) && !NewbieBaseConditionMediator.checkConditionCommon(6) && NewbieBaseConditionMediator.checkInScene(1))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0.5";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function moveFocusToCastleBuild() : void
      {
         if(NewbieBaseConditionMediator.checkCastleBuild(1509))
         {
            actionType = "mediators.NewbieBaseActionMediator|moveFocusToCastleBuild";
            actionParams = "1509";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function drawTargetOnMask_1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "3_1509,0";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function castleBuildShine() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|castleBuildShine";
         actionParams = "1509";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function createGuildFrame4() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|createGuildFrame4";
         actionParams = "50,-150,toCastle_4000";
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
      
      private function showMask_2() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|showMask";
         actionParams = "0.5";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function createGuildFrame1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         actionParams = "29_1509,-400,90,1423,1,1";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function drawTargetOnMask_2() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "3_1509,1";
         needWaitForComplete = true;
         FarmManager.instance.model.showHomeFarmValue = 1;
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

