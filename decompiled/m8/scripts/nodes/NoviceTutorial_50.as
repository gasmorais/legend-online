package nodes
{
   import com.pickgliss.toplevel.StageReferance;
   import dialog.utils.NewbieTutorialBase;
   import mediators.NewbieBaseActionMediator;
   import mediators.NewbieBaseConditionMediator;
   
   public class NoviceTutorial_50 extends NewbieTutorialBase
   {
      
      public function NoviceTutorial_50()
      {
         super();
      }
      
      override protected function next() : void
      {
         switch(_step)
         {
            case 1:
               showMask_1();
               break;
            case 2:
               setNPC();
               break;
            case 3:
               moveNPCByTween();
               break;
            case 4:
               showDialog_1();
               break;
            case 5:
               moveNPC();
               break;
            case 6:
               showDialog_2();
               break;
            case 7:
               sendNodeArrive();
               break;
            case 8:
               cleanAll_1();
               break;
            case 9:
               showNewSkillInBattle_1();
               break;
            case 10:
               controlBattleState_1();
               break;
            case 11:
               showMask_2();
               break;
            case 12:
               showDialog_3();
               break;
            case 13:
               createGuildTarget();
               break;
            case 14:
               setTargetPosAndScale();
               break;
            case 15:
               tweenTarget_1();
               break;
            case 16:
               createGuildFrame2_1();
               break;
            case 17:
               setTargetDisplayIndex();
               break;
            case 18:
               createGuildArrow();
               break;
            case 19:
               drawTargetOnMask_1();
               break;
            case 20:
               cleanDrawContainer();
               break;
            case 21:
               cleanGuildArrow();
               break;
            case 22:
               cleanGuildFrame();
               break;
            case 23:
               tweenTarget_2();
               break;
            case 24:
               cleanCreateTarget();
               break;
            case 25:
               showNewSkillInBattle();
               break;
            case 26:
               createGuildFrame2_2();
               break;
            case 27:
               setKeyboardState();
               break;
            case 28:
               drawTargetOnMask_2();
               break;
            case 29:
               controlBattleState_2();
               break;
            case 30:
               cleanAll_2();
               break;
            case 31:
               emptyAction();
         }
      }
      
      private function showMask_1() : void
      {
         if(NewbieBaseConditionMediator.checkInScene(3))
         {
            actionType = "mediators.NewbieBaseActionMediator|showMask";
            actionParams = "0";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function setNPC() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,4) || NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|setNPC";
         actionParams = "1000202,1485,1365,260";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function moveNPCByTween() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,4) || NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|moveNPCByTween";
         actionParams = "1000202,-1,-1,1290,1120,260,1,1";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function showDialog_1() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,4) || NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|showDialog";
         actionParams = "17";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function moveNPC() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,4) || NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|moveNPC";
         actionParams = "0,-1,-1,67,35,1";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function showDialog_2() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,4) || NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|showDialog";
         actionParams = "4";
         needWaitForComplete = true;
         excuteAction();
      }
      
      private function sendNodeArrive() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,4) || NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         actionType = "mediators.NewbieBaseActionMediator|sendNodeArrive";
         actionParams = "1000208";
         needWaitForComplete = false;
         excuteAction();
      }
      
      private function cleanAll_1() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
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
      
      private function showNewSkillInBattle_1() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4) && NewbieBaseConditionMediator.checkCampaignNodeState(1000208,4))
         {
            actionType = "mediators.NewbieBaseActionMediator|showNewSkillInBattle";
            actionParams = "1,-1";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function controlBattleState_1() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4) && NewbieBaseConditionMediator.checkCampaignNodeState(1000208,4) && !NewbieBaseConditionMediator.checkRolesNumInBattle(2,1))
         {
            NewbieBaseActionMediator.canEnableKeyboard = true;
            actionType = "mediators.NewbieBaseActionMediator|controlBattleState";
            actionParams = "1";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function showMask_2() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
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
      
      private function showDialog_3() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|showDialog";
            actionParams = "6";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function createGuildTarget() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|createGuildTarget";
            actionParams = "1_9";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function setTargetPosAndScale() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|setTargetPosAndScale";
            actionParams = "32,middle,middle";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function tweenTarget_1() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|tweenTarget";
            actionParams = "32,0.5,{scaleX:1.5_scaleY:1.5_yoyo:true_repeat:2},1";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function createGuildFrame2_1() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|createGuildFrame2";
            actionParams = "32,-226,-11,1502,1";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function setTargetDisplayIndex() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|setTargetDisplayIndex";
            actionParams = "32,3";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function createGuildArrow() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|createGuildArrow";
            actionParams = "32,-38,-128,2,2001";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function drawTargetOnMask_1() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
            actionParams = "32,1,0";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function cleanDrawContainer() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|cleanDrawContainer";
            actionParams = "";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function cleanGuildArrow() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|cleanGuildArrow";
            actionParams = "";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function cleanGuildFrame() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|cleanGuildFrame";
            actionParams = "";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function tweenTarget_2() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|tweenTarget";
            actionParams = "32,1,{x:\'reference\'_y:\'reference\'_scaleX:0.8_scaleY:0.8},0,5_1,-5,0";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function cleanCreateTarget() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|cleanCreateTarget";
            actionParams = "";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function showNewSkillInBattle() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|showNewSkillInBattle";
            actionParams = "1,9";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function createGuildFrame2_2() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|createGuildFrame2";
            actionParams = "5_1_icon,-177,-153,1503,1,2";
            needWaitForComplete = false;
            excuteAction();
         }
      }
      
      private function setKeyboardState() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|setKeyboardState";
            actionParams = "1";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function drawTargetOnMask_2() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
         {
            complete();
            return;
         }
         if(NewbieBaseConditionMediator.checkInScene(4))
         {
            actionType = "mediators.NewbieBaseActionMediator|drawTargetOnMask";
            actionParams = "5_1,1,-1,0,0,5_1_icon";
            needWaitForComplete = true;
            excuteAction();
         }
      }
      
      private function controlBattleState_2() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
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
      
      private function cleanAll_2() : void
      {
         NewbieBaseActionMediator.canEnableKeyboard = false;
         StageReferance.stage.focus = StageReferance.stage;
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
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
      
      private function emptyAction() : void
      {
         if(NewbieBaseConditionMediator.checkCampaignNodeState(1000208,8))
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

