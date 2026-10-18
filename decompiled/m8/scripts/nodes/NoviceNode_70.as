package nodes
{
   import dialog.utils.NewbieNodeBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceNode_70 extends NewbieNodeBase
   {
      
      public function NoviceNode_70()
      {
         super();
      }
      
      override protected function next() : void
      {
         switch(int(_step) - 1)
         {
            case 0:
               setMainToolBarBtn();
               break;
            case 1:
               cleanAll_1();
         }
      }
      
      private function setMainToolBarBtn() : void
      {
         if(NewbieBaseConditionMediator.checkPlayerGrade(70) && NewbieBaseConditionMediator.checkNotInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|setMainToolBarBtn";
            actionParams = "6,1";
            needWaitForComplete = true;
            excuteAction();
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

