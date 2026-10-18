package nodes
{
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_180 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_180()
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
               cleanAll_2();
               break;
            case 6:
               showDialog();
         }
      }
      
      private function showMask_1() : void
      {
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
         if(NewbieBaseConditionMediator.checkCastleBuild(901))
         {
            actionType = "mediators.NewbieBaseActionMediator|moveFocusToCastleBuild";
            actionParams = "901";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function drawTargetOnMask_1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
         actionParams = "3_901,0";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function castleBuildShine() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|castleBuildShine";
         actionParams = "901";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function createGuildFrame4() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|createGuildFrame4";
         actionParams = "-350,-150,toCastle_1130";
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
      
      private function showDialog() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|showDialog";
         actionParams = "10";
         needWaitForComplete = true;
         actionComplete = true;
         excuteAction();
      }
   }
}

