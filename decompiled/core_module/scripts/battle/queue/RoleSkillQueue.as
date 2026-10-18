package battle.queue
{
   import battle.BattleManager;
   import battle.handler.BufferHandler;
   import battle.skillsys.skills.BaseSkill;
   import yishi.datas.objects.RoleInfo;
   import yishi.interfaces.IAction;
   
   public class RoleSkillQueue extends BattleActionQueue
   {
      
      private var _roleInfo:RoleInfo;
      
      public function RoleSkillQueue(param1:RoleInfo)
      {
         _roleInfo = param1;
         super();
      }
      
      override protected function shiftAction() : void
      {
         var _loc1_:IAction = null;
         if(_actions.length > 0)
         {
            _loc1_ = _actions[0];
            if(_loc1_ is BaseSkill)
            {
               if(!_loc1_.ready(BattleManager.getInstance().BattleFrameCount))
               {
                  return;
               }
            }
            _roleInfo.readyFlag = true;
            if(_roleInfo.waitBool)
            {
               return;
            }
            if(BattleManager.getInstance().getSkillSystem().isNeedWait(_roleInfo))
            {
               return;
            }
            _current = _actions.shift();
            _current.prepare();
            BufferHandler.excuteCount = 0;
            _roleInfo.readyFlag = false;
         }
      }
   }
}

