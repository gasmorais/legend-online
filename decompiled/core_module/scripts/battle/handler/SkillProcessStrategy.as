package battle.handler
{
   import battle.BattleManager;
   import battle.skillsys.skills.BaseSkill;
   
   public class SkillProcessStrategy
   {
      
      public static const SKIP:int = 0;
      
      public static const NORMAL:int = 1;
      
      public function SkillProcessStrategy()
      {
         super();
      }
      
      public static function processSynchronization(param1:int, param2:BaseSkill) : int
      {
         var _loc3_:int = 1;
         var _loc4_:int = BattleManager.getInstance().BattleFrameCount;
         var _loc5_:int = param1 - _loc4_;
         if(_loc5_ < -20)
         {
            BattleManager.getInstance().synchronization = param1;
         }
         else if(_loc5_ > 5)
         {
            _loc3_ = processWhenClientSlower(_loc5_,param2);
            BattleManager.getInstance().synchronization = param1;
         }
         else
         {
            BattleManager.getInstance().synchronization = _loc4_ + (param1 - _loc4_) * 0.2;
         }
         return _loc3_;
      }
      
      private static function processWhenClientSlower(param1:int, param2:BaseSkill) : int
      {
         var _loc3_:BaseSkill = null;
         var _loc5_:int = 0;
         var _loc4_:Array = BattleManager.getInstance().getWaitSkillList();
         if(_loc4_ != null)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc3_ = _loc4_[_loc5_] as BaseSkill;
               if(checkIsCanSkip(_loc3_.getSkillData().skillId))
               {
                  if(_loc3_.getCurrentRole() == BattleManager.getInstance().battleModel.selfHero)
                  {
                     if(_loc3_.isDefaultSkill())
                     {
                        _loc3_.setProcessStrategy(0);
                     }
                  }
                  else
                  {
                     _loc3_.setProcessStrategy(0);
                  }
               }
               _loc5_++;
            }
         }
         return 1;
      }
      
      private static function checkIsCanSkip(param1:int) : Boolean
      {
         switch(param1 - 1)
         {
            case 0:
            case 1:
            case 2:
            case 3:
               return false;
            default:
               return true;
         }
      }
   }
}

