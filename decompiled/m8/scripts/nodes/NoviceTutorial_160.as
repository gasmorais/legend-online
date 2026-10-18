package nodes
{
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_160 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_160()
      {
         super();
      }
      
      override protected function next() : void
      {
         switch(int(_step) - 1)
         {
            case 0:
               enterSceneAfterPlayMovie();
               break;
            case 1:
               cleanAll();
         }
      }
      
      private function enterSceneAfterPlayMovie() : void
      {
         actionType = "mediators.NewbieSpecialActionMediator|enterSceneAfterPlayMovie";
         actionParams = "flytocastle,0";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function cleanAll() : void
      {
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|cleanAll";
            actionParams = "";
            needWaitForComplete = false;
            actionComplete = true;
            excuteAction();
         }
      }
   }
}

