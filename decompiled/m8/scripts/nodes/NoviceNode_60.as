package nodes
{
   import dialog.utils.NewbieNodeBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceNode_60 extends NewbieNodeBase
   {
      
      public function NoviceNode_60()
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
         if(NewbieBaseConditionMediator.checkPlayerGrade(50) && !NewbieBaseConditionMediator.checkConditionCommon(6))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function newModuleOpen() : void
      {
         if(NewbieBaseConditionMediator.checkPlayerGrade(50) && !NewbieBaseConditionMediator.checkConditionCommon(6))
         {
            actionType = "mediators.NewbieBaseActionMediator|newModuleOpen";
            actionParams = "pet,5719,1,2_14,0,0,14";
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

