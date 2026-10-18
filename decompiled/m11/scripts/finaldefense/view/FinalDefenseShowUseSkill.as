package finaldefense.view
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class FinalDefenseShowUseSkill
   {
      
      private var _skillParent:DisplayObjectContainer;
      
      public var roleList:Dictionary;
      
      public function FinalDefenseShowUseSkill(param1:DisplayObjectContainer)
      {
         super();
         _skillParent = param1;
         addEvent();
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_USE_SKILL",onUseSkill);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_USE_SKILL",onUseSkill);
      }
      
      private function onUseSkill(param1:NotificationEvent) : void
      {
         var _loc6_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc7_:int = int(param1.data);
         var _loc4_:String = "finaldefenceskill1" + _loc7_ + "0";
         if(!ApplicationDomain.currentDomain.hasDefinition(_loc4_))
         {
            return;
         }
         switch(_loc7_ - 1)
         {
            case 0:
            case 2:
               _loc6_ = createSkillMc(_loc4_);
               _skillParent.addChild(_loc6_);
               _loc6_.x = _skillParent.width / 2;
               _loc6_.y = _skillParent.height / 2;
               break;
            case 1:
               if(roleList != null)
               {
                  var _loc9_:int = 0;
                  var _loc8_:Dictionary = roleList;
                  while(§§hasnext(_loc8_,_loc9_))
                  {
                     var _loc3_:String = §§nextname(_loc9_,_loc8_);
                     if(roleList[_loc3_] is FinalDefenseMonsterView)
                     {
                        _loc5_ = createSkillMc(_loc4_);
                        _loc5_.x = roleList[_loc3_].x;
                        _loc5_.y = roleList[_loc3_].y;
                        _skillParent.addChild(_loc5_);
                        roleList[_loc3_].stopByTime(10);
                     }
                  }
               }
         }
         if(_loc7_ == 3)
         {
            for(var _loc2_:String in roleList)
            {
               if(roleList[_loc2_] is FinalDefenseMonsterView)
               {
                  roleList[_loc2_].blackToBornPoint();
               }
            }
         }
      }
      
      private function createSkillMc(param1:String) : MovieClip
      {
         var className:String = param1;
         var SkillClass:Class = ApplicationDomain.currentDomain.getDefinition(className) as Class;
         var attackSkillMc:MovieClip = new SkillClass() as MovieClip;
         attackSkillMc.mouseChildren = attackSkillMc.mouseEnabled = false;
         attackSkillMc.addFrameScript(attackSkillMc.totalFrames - 1,function():void
         {
            attackSkillMc.stop();
            if(attackSkillMc.parent != null)
            {
               attackSkillMc.parent.removeChild(attackSkillMc);
            }
            ObjectUtils.disposeViolentMc(attackSkillMc);
         });
         attackSkillMc.gotoAndPlay(1);
         return attackSkillMc;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _skillParent = null;
         roleList = null;
      }
   }
}

