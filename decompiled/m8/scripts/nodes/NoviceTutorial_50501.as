package nodes
{
   import dialog.utils.NewbieManager;
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_50501 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_50501()
      {
         super();
      }
      
      override protected function clearDynamic() : void
      {
      }
      
      override protected function next() : void
      {
         switch(int(_step) - -1)
         {
            case 0:
               cleanAll_1();
               break;
            case 2:
               createGuildFrame2_2();
         }
         if(!NewbieManager.instance.isPlayingLockWeek)
         {
            _step = -1;
            actionComplete = true;
         }
      }
      
      private function createGuildFrame2_2() : void
      {
         if(NewbieBaseConditionMediator.checkFrame("armyController","ArmyFrameII") && NewbieBaseConditionMediator.checkConditionCommon(84))
         {
            actionType = "mediators.NewbieBaseActionMediator|createGuildFrame2";
            actionParams = "84,-187,-152,50502,1,2";
            needWaitForComplete = false;
            excuteAction();
            _step = Number(_step) + 1;
         }
      }
      
      private function cleanAll_1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         actionParams = "";
         needWaitForComplete = false;
         excuteAction();
      }
      
      override protected function addStep() : void
      {
      }
      
      override public function complete() : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

