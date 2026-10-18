package battle.skillsys.skills
{
   import battle.actions.common.SimpleScriptAction;
   import yishi.datas.objects.HeroRoleInfo;
   
   public class SuccessSkill extends BaseSkill
   {
      
      public function SuccessSkill()
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
               if(_loc1_.petRoleInfo)
               {
                  _loc1_.petRoleInfo.action("Stand","STOP");
               }
            }
            _currentRole.action("Victory","STOP");
            updataSp();
         };
         action.onUpdate = function():void
         {
            if(action.frameCount == 20)
            {
               action.finish();
            }
         };
         _currentRole.addAction(action);
         _finished = true;
      }
   }
}

