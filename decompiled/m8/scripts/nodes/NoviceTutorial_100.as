package nodes
{
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_100 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_100()
      {
         super();
      }
      
      override protected function next() : void
      {
         switch(int(_step) - 1)
         {
            case 0:
               setTaskArrowGuild();
         }
      }
      
      private function setTaskArrowGuild() : void
      {
         if(NewbieBaseConditionMediator.checkTaskHasCompleted(1826))
         {
            skipNode();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(3,10003) && NewbieBaseConditionMediator.checkTaskHasCompleted(1826))
         {
            actionType = "mediators.NewbieBaseActionMediator|setTaskArrowGuild";
            actionParams = "1,1106";
            needWaitForComplete = false;
            actionComplete = true;
            excuteAction();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

