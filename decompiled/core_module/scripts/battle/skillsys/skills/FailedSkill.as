package battle.skillsys.skills
{
   import battle.actions.common.SimpleScriptAction;
   import yishi.datas.objects.HeroRoleInfo;
   
   public class FailedSkill extends BaseSkill
   {
      
      public function FailedSkill()
      {
         super();
      }
      
      override protected function startRun() : void
      {
         started = true;
         var action:SimpleScriptAction = new SimpleScriptAction();
         action.onPrepare = function():void
         {
            var _loc1_:HeroRoleInfo = null;
            if(_currentRole is HeroRoleInfo)
            {
               _loc1_ = _currentRole as HeroRoleInfo;
               _loc1_.isPetState = false;
               if(_loc1_.petRoleInfo)
               {
                  _loc1_.petRoleInfo.action("Failed","STOP");
               }
            }
            _currentRole.action("Failed","STOP");
         };
         action.onUpdate = function():void
         {
            if(action.frameCount == 20)
            {
               action.finish();
            }
         };
         updataSp();
         _currentRole.addAction(action);
         _finished = true;
      }
   }
}

