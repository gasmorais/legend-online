package nodes
{
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   import yishi.keyboard.KeyBoardRegister;
   
   public class NoviceTutorial_170 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_170()
      {
         super();
      }
      
      override protected function next() : void
      {
         switch(int(_step) - 1)
         {
            case 0:
               sendInitBuildAndQueue();
               break;
            case 1:
               showMask();
               break;
            case 2:
               taskTraceItemShine();
               break;
            case 3:
               setTaskArrowGuild();
               break;
            case 4:
               drawTargetOnMask();
               break;
            case 5:
               cleanAll();
               break;
            case 6:
               showDialog();
         }
      }
      
      private function sendInitBuildAndQueue() : void
      {
         if(NewbieBaseConditionMediator.checkInScene(1))
         {
            actionType = "mediators.NewbieBaseActionMediator|sendInitBuildAndQueue";
            actionParams = "";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function showMask() : void
      {
         if(NewbieBaseConditionMediator.checkTaskHasCompleted(1832))
         {
            completeNode();
            return;
         }
         if(NewbieBaseConditionMediator.checkTaskIsComplete(1832) && NewbieBaseConditionMediator.checkConditionCommon(3,"1832"))
         {
            KeyBoardRegister.instance.keyEnable = false;
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function taskTraceItemShine() : void
      {
         if(NewbieBaseConditionMediator.checkTaskHasCompleted(1832))
         {
            completeNode();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|taskTraceItemShine";
         actionParams = "";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function setTaskArrowGuild() : void
      {
         if(NewbieBaseConditionMediator.checkTaskHasCompleted(1832))
         {
            completeNode();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|setTaskArrowGuild";
         actionParams = "1,1101,1832";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function drawTargetOnMask() : void
      {
         if(NewbieBaseConditionMediator.checkTaskHasCompleted(1832))
         {
            completeNode();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "31_1832,1";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function cleanAll() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         actionParams = "";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function showDialog() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|showDialog";
         actionParams = "9";
         needWaitForComplete = true;
         actionComplete = true;
         excuteAction();
      }
   }
}

