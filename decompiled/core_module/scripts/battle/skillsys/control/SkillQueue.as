package battle.skillsys.control
{
   import battle.BattleManager;
   import battle.queue.BattleActionQueue;
   import battle.skillsys.skills.BaseSkill;
   import flash.utils.Dictionary;
   import yishi.datas.objects.RoleInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class SkillQueue extends BattleActionQueue implements IEnterFrame
   {
      
      private var _running:Boolean;
      
      private var _downDic:Dictionary;
      
      public function SkillQueue()
      {
         super();
      }
      
      public function enterFrame() : void
      {
         var _loc1_:BaseSkill = null;
         if(_actions.length > 0)
         {
            _loc1_ = _actions[0] as BaseSkill;
            if(!_loc1_.ready(BattleManager.getInstance().BattleFrameCount))
            {
               return;
            }
            _actions.shift();
            if(!_loc1_.getCurrentRole())
            {
               _loc1_.skipFun();
               return;
            }
            _loc1_.getCurrentRole().addSkill(_loc1_);
         }
      }
      
      public function start() : void
      {
         if(!_running)
         {
            _downDic = new Dictionary();
            EnterFrameManager.instance.registeEnterFrame(this);
            _running = true;
         }
      }
      
      public function stop() : void
      {
         if(_running)
         {
            EnterFrameManager.instance.unRegisteEnterFrame(this);
         }
         _running = false;
         _downDic = null;
      }
      
      public function get running() : Boolean
      {
         return _running;
      }
      
      private function isKillableSkill(param1:BaseSkill) : Boolean
      {
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:RoleInfo = null;
         if(param1.getSkillData().willKillSomeBody)
         {
            return true;
         }
         var _loc5_:Array = param1.getSkillData().getHurtRoles();
         var _loc4_:Array = BattleManager.getInstance().battleModel.getUnstartSkills();
         for each(var _loc9_:int in _loc5_)
         {
            _loc3_ = BattleManager.getInstance().battleModel.getRoleById(_loc9_);
            if(_loc3_)
            {
               _loc2_ = _loc3_.bloodA;
               if(_loc3_.readyFlag)
               {
                  return true;
               }
               _loc7_ = param1.getSkillData().getHurtValue(_loc9_);
               _loc10_ = 0;
               _loc11_ = 0;
               for each(var _loc6_:BaseSkill in _loc4_)
               {
                  _loc8_ = _loc6_.getSkillData().getHurtValue(_loc9_);
                  if(_loc8_ < 0)
                  {
                     _loc11_ -= _loc8_;
                  }
                  else
                  {
                     _loc10_ += _loc8_;
                  }
               }
               if(_loc11_ > 0 && _loc2_ - _loc7_ - _loc10_ < 1000)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function isPreviousSkillsStarded(param1:BaseSkill) : Boolean
      {
         return BattleManager.getInstance().battleModel.isAllSkillStarted();
      }
      
      public function clear() : void
      {
         cleanActions();
      }
   }
}

