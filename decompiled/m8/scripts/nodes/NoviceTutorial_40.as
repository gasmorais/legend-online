package nodes
{
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseActionMediator;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_40 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_40()
      {
         super();
      }
      
      override protected function next() : void
      {
         switch(int(_step) - 1)
         {
            case 0:
               showMask1();
               break;
            case 1:
               moveNPCByTween1();
               break;
            case 2:
               setNPC();
               break;
            case 3:
               sendNodeArrive();
               break;
            case 4:
               cleanAll1();
               break;
            case 5:
               showNewSkillInBattle();
               break;
            case 6:
               controlBattleState1();
               break;
            case 7:
               showMask2();
               break;
            case 8:
               createGuildFrame2();
               break;
            case 9:
               setKeyboardState();
               break;
            case 10:
               drawTargetOnMask();
               break;
            case 11:
               controlBattleState2();
               break;
            case 12:
               cleanAll2();
               break;
            case 13:
               emptyAction();
         }
      }
      
      private function showMask1() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000206,4) && NewbieBaseConditionMediator.checkCampaignNodeState(1000206,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(3))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function moveNPCByTween1() : void
      {
         actionType = "mediators.NewbieBaseActionMediator|moveNPCByTween";
         actionParams = "1000206,1350,1270,1340,940,260,1,1";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function setNPC() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000206,4) || NewbieBaseConditionMediator.checkCampaignNodeState(1000206,8))
         {
            complete();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|setNPC";
         actionParams = "0,-1,-1,90";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function sendNodeArrive() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000206,4) || NewbieBaseConditionMediator.checkCampaignNodeState(1000206,8))
         {
            complete();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|sendNodeArrive";
         actionParams = "1000206";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function cleanAll1() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000206,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|cleanAll";
            actionParams = "";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function showNewSkillInBattle() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000206,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4) && NewbieBaseConditionMediator.checkCampaignNodeState(1000206,4))
         {
            actionType = "mediators.NewbieBaseActionMediator|showNewSkillInBattle";
            actionParams = "1,-1";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function controlBattleState1() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000206,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|controlBattleState";
            actionParams = "1";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function showMask2() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000206,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function createGuildFrame2() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000206,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|createGuildFrame2";
            actionParams = "5_0_icon,-177,-152,1501,1,2";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function setKeyboardState() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000206,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            NewbieBaseActionMediator.canEnableKeyboard = true;
            actionType = "mediators.NewbieBaseActionMediator|setKeyboardState";
            actionParams = "1";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function drawTargetOnMask() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000206,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
            actionParams = "5_0,1,-1,0,0,5_0_icon";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function controlBattleState2() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000206,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|controlBattleState";
            actionParams = "0";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function cleanAll2() : void
      {
         NewbieBaseActionMediator.canEnableKeyboard = false;
         actionType = "mediators.NewbieBaseActionMediator|cleanAll";
         actionParams = "";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function emptyAction() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000206,8))
         {
            actionType = "mediators.NewbieBaseActionMediator|emptyAction";
            actionParams = "";
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

