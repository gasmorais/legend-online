package finaldefense.view
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import managers.FinalDefenseManager;
   import mvc.module.finaldefense.info.DitchNpcInfoData;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class FinalDefenseShowSkill
   {
      
      private var _skillParent:DisplayObjectContainer;
      
      public var roleList:Dictionary;
      
      public function FinalDefenseShowSkill(param1:DisplayObjectContainer)
      {
         super();
         _skillParent = param1;
         addEvent();
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_ATTACK_MONSTER",onShowSkill);
      }
      
      private function onShowSkill(param1:NotificationEvent) : void
      {
         var _loc2_:DitchNpcInfoData = param1.data as DitchNpcInfoData;
         showAttackSkill(_loc2_);
         showDefenseSkill(_loc2_);
      }
      
      private function showAttackSkill(param1:DitchNpcInfoData) : void
      {
         var AttackSkillClass:Class;
         var attackSkillMc:MovieClip;
         var finalDefenseRoleView:FinalDefenseRoleView;
         var ditchNpcInfoData:DitchNpcInfoData = param1;
         var attackClassName:String = "finaldefenceskill0" + TempleteManager.instance.dichTemplateCate.getTemplateById(ditchNpcInfoData.templateId).AttackType + "0";
         if(!ApplicationDomain.currentDomain.hasDefinition(attackClassName))
         {
            return;
         }
         AttackSkillClass = ApplicationDomain.currentDomain.getDefinition(attackClassName) as Class;
         attackSkillMc = new AttackSkillClass() as MovieClip;
         attackSkillMc.mouseChildren = attackSkillMc.mouseEnabled = false;
         _skillParent.addChild(attackSkillMc);
         attackSkillMc.addFrameScript(attackSkillMc.totalFrames - 1,function():void
         {
            attackSkillMc.stop();
            if(attackSkillMc.parent != null)
            {
               attackSkillMc.parent.removeChild(attackSkillMc);
            }
            ObjectUtils.disposeViolentMc(attackSkillMc);
         });
         if(roleList == null && _skillParent != null)
         {
            roleList = _skillParent["_skillParent"];
         }
         if(roleList == null)
         {
            return;
         }
         finalDefenseRoleView = roleList[ditchNpcInfoData.id];
         if(finalDefenseRoleView != null)
         {
            attackSkillMc.x = finalDefenseRoleView.x;
            attackSkillMc.y = finalDefenseRoleView.y - 100;
         }
         attackSkillMc.gotoAndPlay(1);
      }
      
      private function showDefenseSkill(param1:DitchNpcInfoData) : void
      {
         var DefenseSkillClass:Class;
         var defenseSkillMc:MovieClip;
         var defenseId:int;
         var finalDefenseRoleView:FinalDefenseRoleView;
         var ditchNpcInfoData:DitchNpcInfoData = param1;
         var defenseClassName:String = "finaldefenceskill0" + TempleteManager.instance.dichTemplateCate.getTemplateById(ditchNpcInfoData.templateId).AttackType + "1";
         if(!ApplicationDomain.currentDomain.hasDefinition(defenseClassName))
         {
            return;
         }
         DefenseSkillClass = ApplicationDomain.currentDomain.getDefinition(defenseClassName) as Class;
         defenseSkillMc = new DefenseSkillClass() as MovieClip;
         defenseSkillMc.addFrameScript(defenseSkillMc.totalFrames - 1,function():void
         {
            defenseSkillMc.stop();
            if(defenseSkillMc.parent != null)
            {
               defenseSkillMc.parent.removeChild(defenseSkillMc);
            }
            ObjectUtils.disposeViolentMc(defenseSkillMc);
         });
         _skillParent.addChild(defenseSkillMc);
         defenseSkillMc.gotoAndPlay(1);
         defenseId = int(FinalDefenseManager.ins.model.getMonsterIdByRow(ditchNpcInfoData.rowIndex));
         finalDefenseRoleView = roleList[defenseId];
         if(finalDefenseRoleView != null)
         {
            defenseSkillMc.x = finalDefenseRoleView.x;
            defenseSkillMc.y = finalDefenseRoleView.y;
         }
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_ATTACK_MONSTER",onShowSkill);
      }
      
      public function dispose() : void
      {
         removeEvent();
      }
   }
}

