package nodes
{
   import dialog.utils.NewbieTutorialBase;
   
   public class NoviceTutorial_90 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_90()
      {
         super();
      }
      
      override protected function next() : void
      {
         switch(int(_step) - 1)
         {
            case 0:
               cleanAll_1();
         }
      }
      
      private function cleanAll_1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         actionParams = "";
         needWaitForComplete = false;
         actionComplete = true;
         excuteAction();
      }
   }
}

