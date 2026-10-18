package nodes
{
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_50500 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_50500()
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
               createGuildFrame2_1();
               break;
            case 2:
               drawTargetOnMask_2_1();
               break;
            case 3:
               cleanAll_1();
               break;
            case 4:
               showMask_2();
               break;
            case 5:
               createGuildFrame2_2();
               break;
            case 6:
               drawTargetOnMask_2_2();
               break;
            case 7:
               cleanAll_1();
         }
      }
      
      private function showMask_1() : void
      {
         if(NewbieBaseConditionMediator.checkConditionCommon(11) && NewbieBaseConditionMediator.checkInCastleOrSpace())
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0.5";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function showMask_2() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("armyController","ArmyFrameII") && NewbieBaseConditionMediator.checkConditionCommon(84))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0.5";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function createGuildFrame2_1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|createGuildFrame2";
         actionParams = "2_2,-177,-152,50501,1,2";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function createGuildFrame2_2() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|createGuildFrame2";
         actionParams = "84,-187,-152,50502,1,2";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function drawTargetOnMask_2_1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "2_2,1";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function drawTargetOnMask_2_2() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "84,1";
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
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

