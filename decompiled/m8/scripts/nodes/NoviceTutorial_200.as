package nodes
{
   import dialog.utils.NewbieSocketOutManager;
   import dialog.utils.NewbieTutorialBase;
   import managers.TaskSocketManager;
   import mediators.NewbieBaseConditionMediator;
   import ui.maintoolbar.MainToolBar;
   import yishi.scene.SceneManager;
   
   public class NoviceTutorial_200 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_200()
      {
         super();
      }
      
      override protected function next() : void
      {
         switch(int(_step) - 1)
         {
            case 0:
               showDialog();
               break;
            case 1:
               setKeyboardState_1();
               break;
            case 2:
               setTaskArrowGuild();
               break;
            case 3:
               showMask_1();
               break;
            case 4:
               createGuildFrame1_1();
               break;
            case 5:
               drawTargetOnMask_1();
               break;
            case 6:
               cleanAll_1();
               break;
            case 7:
               showMask_2();
               break;
            case 8:
               createGuildFrame1_2();
               break;
            case 9:
               drawTargetOnMask_2();
               break;
            case 10:
               cleanAll_2();
               break;
            case 11:
               setKeyboardState_2();
               break;
            case 12:
               cleanGameLayer_1();
         }
      }
      
      private function showDialog() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|showDialog";
         actionParams = "11";
         needWaitForComplete = true;
         NewbieSocketOutManager.sendSaveProcess(25000);
         excuteAction();
      }
      
      private function setKeyboardState_1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|setKeyboardState";
         actionParams = "0,1";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function setTaskArrowGuild() : void
      {
         MainToolBar.instance.buttonsStageByScene(SceneManager.instance.currentType);
         if(NewbieBaseConditionMediator.checkTaskIsComplete(1834) && NewbieBaseConditionMediator.checkConditionCommon(3,"1834"))
         {
            TaskSocketManager.sendGetTaskReward(1834,0,true);
         }
         actionType = "mediators.NewbieBaseActionMediator|setTaskArrowGuild";
         actionParams = "0";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function showMask_1() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("selectCampaignControler","SelectCampaignFrame"))
         {
            completeNode();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(1))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0.1";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function createGuildFrame1_1() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("selectCampaignControler","SelectCampaignFrame"))
         {
            completeNode();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         actionParams = "2_10,-510,-240,1411,1,1,0,-80";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function drawTargetOnMask_1() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("selectCampaignControler","SelectCampaignFrame"))
         {
            completeNode();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "2_10,1";
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
      
      private function showMask_2() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("selectCampaignControler","SelectCampaignFrame") && NewbieBaseConditionMediator.checkConditionCommon(13,"startBtn"))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0.1";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function createGuildFrame1_2() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|createGuildFrame1";
         actionParams = "28_startBtn,-160,0,1412,1,4";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function drawTargetOnMask_2() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "28_startBtn,1";
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
      
      private function setKeyboardState_2() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|setKeyboardState";
         actionParams = "1,2";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function cleanGameLayer_1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|cleanGameLayer";
         actionParams = "";
         needWaitForComplete = false;
         actionComplete = true;
         excuteAction();
      }
   }
}

