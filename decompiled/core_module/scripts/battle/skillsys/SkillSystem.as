package battle.skillsys
{
   import battle.BattleManager;
   import battle.logsys.BattleLogSystem;
   import battle.skillsys.control.SkillQueue;
   import battle.skillsys.mode.SkillWaitInfo;
   import battle.skillsys.skills.BaseSkill;
   import battle.skillsys.skills.CommonActionSkill;
   import flash.utils.Dictionary;
   import yishi.datas.objects.RoleInfo;
   
   public class SkillSystem
   {
      
      private var _skillQueue:SkillQueue;
      
      private var _waitSkillDic:Dictionary;
      
      public function SkillSystem()
      {
         super();
         _skillQueue = new SkillQueue();
         _waitSkillDic = new Dictionary();
         _skillQueue.start();
      }
      
      public function addSkill(param1:BaseSkill) : void
      {
         var _loc2_:SkillWaitInfo = null;
         var _loc3_:RoleInfo = getSingleAttackSkillTarget(param1);
         if(_loc3_)
         {
            _loc2_ = _waitSkillDic[_loc3_.livingId];
            if(_loc2_)
            {
               BattleLogSystem.realExecuteTime(param1,param1.liftTime);
            }
         }
         _skillQueue.addAction(param1);
      }
      
      public function getSkillQueue() : SkillQueue
      {
         return _skillQueue;
      }
      
      public function isNeedWait(param1:RoleInfo) : Boolean
      {
         var _loc5_:RoleInfo = null;
         var _loc2_:int = 0;
         var _loc4_:SkillWaitInfo = null;
         var _loc3_:BaseSkill = param1.getSkillQueue().getActions()[0];
         if(isSingleAttackSkill(_loc3_))
         {
            _loc2_ = int(_loc3_.getSkillData().data[0][0].roleId);
            _loc5_ = BattleManager.getInstance().battleModel.getRoleById(_loc2_);
            if(_loc5_)
            {
               if(_loc5_.getSkillQueue() != null && _loc5_.getSkillQueue().current is CommonActionSkill)
               {
                  resetWaitSkill(_loc5_);
                  if(_waitSkillDic[_loc5_.livingId] == null)
                  {
                     _waitSkillDic[_loc5_.livingId] = new SkillWaitInfo();
                  }
                  _loc4_ = _waitSkillDic[_loc5_.livingId];
                  _loc4_.roleId = _loc5_.livingId;
                  _loc4_.count++;
                  _loc4_.countDown(waitCountDownComplete);
                  return true;
               }
            }
         }
         return false;
      }
      
      private function getSingleAttackSkillTarget(param1:BaseSkill) : RoleInfo
      {
         var _loc3_:RoleInfo = null;
         var _loc2_:int = 0;
         if(param1.getSkillData().data && param1.getSkillData().data.length > 0)
         {
            if(param1.getSkillData().data[0].length == 1)
            {
               _loc2_ = int(param1.getSkillData().data[0][0].roleId);
               _loc3_ = BattleManager.getInstance().battleModel.getRoleById(_loc2_);
            }
         }
         return _loc3_;
      }
      
      private function isSingleAttackSkill(param1:BaseSkill) : Boolean
      {
         if(param1.getSkillData().data && param1.getSkillData().data.length > 0)
         {
            if(param1.getSkillData().data[0].length == 1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function resetWaitSkill(param1:RoleInfo) : void
      {
         var _loc2_:* = null;
         var _loc4_:BaseSkill = null;
         var _loc5_:RoleInfo = null;
         var _loc6_:int = 0;
         var _loc3_:Dictionary = BattleManager.getInstance().battleModel.roleList;
         for each(_loc2_ in _loc3_)
         {
            if(_loc2_.getSkillQueue() != null)
            {
               if(_loc2_.getSkillQueue().getActions().length > 0)
               {
                  _loc4_ = _loc2_.getSkillQueue().getActions()[0] as BaseSkill;
                  if(isSingleAttackSkill(_loc4_))
                  {
                     _loc6_ = int(_loc4_.getSkillData().data[0][0].roleId);
                     _loc5_ = BattleManager.getInstance().battleModel.getRoleById(_loc6_);
                     if(_loc5_ == param1)
                     {
                        _loc4_.liftTime++;
                        BattleLogSystem.realExecuteTime(_loc4_,_loc4_.liftTime);
                     }
                  }
               }
            }
         }
         for each(_loc4_ in _skillQueue.getActions())
         {
            if(isSingleAttackSkill(_loc4_))
            {
               _loc6_ = int(_loc4_.getSkillData().data[0][0].roleId);
               _loc5_ = BattleManager.getInstance().battleModel.getRoleById(_loc6_);
               if(_loc5_ == param1)
               {
                  _loc4_.liftTime++;
                  BattleLogSystem.realExecuteTime(_loc4_,_loc4_.liftTime);
               }
            }
         }
      }
      
      private function waitCountDownComplete(param1:SkillWaitInfo) : void
      {
         delete _waitSkillDic[param1.roleId];
      }
      
      public function dispose() : void
      {
         if(_skillQueue)
         {
            _skillQueue.cleanActions();
            _skillQueue.stop();
         }
         _skillQueue = null;
      }
   }
}

