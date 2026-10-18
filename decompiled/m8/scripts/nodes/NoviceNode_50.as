package nodes
{
   import dialog.utils.NewbieNodeBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceNode_50 extends NewbieNodeBase
   {
      
      public function NoviceNode_50()
      {
         super();
      }
      
      override protected function next() : void
      {
         switch(int(_step) - 1)
         {
            case 0:
               showMask();
               break;
            case 1:
               newModuleOpen();
               break;
            case 2:
               cleanAll();
         }
      }
      
      private function showMask() : void
      {
         if(NewbieBaseConditionMediator.checkPlayerGrade(18) && !NewbieBaseConditionMediator.checkConditionCommon(6))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function newModuleOpen() : void
      {
         if(NewbieBaseConditionMediator.checkPlayerGrade(18) && !NewbieBaseConditionMediator.checkConditionCommon(6))
         {
            actionType = "mediators.NewbieBaseActionMediator|newModuleOpen";
            actionParams = "star,5710,1,2_5,0,0,5";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function cleanAll() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         actionParams = "";
         needWaitForComplete = false;
         actionComplete = true;
         excuteAction();
      }
   }
}

