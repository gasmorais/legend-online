package nodes
{
   import dialog.utils.NewbieTutorialBase;
   
   public class NoviceTutorial_70 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_70()
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
         actionType = "mediators.NewbieBaseActionMediator|setTaskArrowGuild";
         actionParams = "1,1105";
         needWaitForComplete = false;
         actionComplete = true;
         excuteAction();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

