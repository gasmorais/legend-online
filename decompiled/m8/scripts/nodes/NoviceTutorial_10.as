package nodes
{
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_10 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_10()
      {
         super();
      }
      
      override protected function next() : void
      {
         switch(int(_step) - 1)
         {
            case 0:
               showStartPlayView();
         }
      }
      
      private function showStartPlayView() : void
      {
         if(NewbieBaseConditionMediator.checkInScene(3))
         {
            actionType = "mediators.NewbieBaseActionMediator|showStartPlayView";
            actionParams = "";
            needWaitForComplete = true;
            actionComplete = true;
            excuteAction();
         }
      }
   }
}

