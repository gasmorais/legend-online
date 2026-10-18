package nodes
{
   import dialog.utils.NewbieNodeBase;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceNode_80 extends NewbieNodeBase
   {
      
      public function NoviceNode_80()
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
               newModuleOpen1();
               break;
            case 2:
               newModuleOpen2();
               break;
            case 3:
               cleanAll_1();
         }
      }
      
      private function showMask() : void
      {
         if(NewbieBaseConditionMediator.checkTaskIsCompleteOrCompleted(1912))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function newModuleOpen1() : void
      {
         if(NewbieBaseConditionMediator.checkTaskIsCompleteOrCompleted(1912))
         {
            actionType = "mediators.NewbieBaseActionMediator|newModuleOpen";
            actionParams = "pethallows,5722,1,2_14,0,0,14";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function newModuleOpen2() : void
      {
         if(NewbieBaseConditionMediator.checkTaskIsCompleteOrCompleted(1912))
         {
            actionType = "mediators.NewbieBaseActionMediator|newModuleOpen";
            actionParams = "childnursingspirit,5723,1,2_6,0,0,6";
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

