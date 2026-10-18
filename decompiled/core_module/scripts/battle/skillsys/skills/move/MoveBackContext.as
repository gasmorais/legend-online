package battle.skillsys.skills.move
{
   import battle.skillsys.mode.framedata.SkillFrameData;
   import battle.skillsys.skills.BaseSkill;
   
   public class MoveBackContext
   {
      
      private var _strategy:IMoveStrategy;
      
      public function MoveBackContext(param1:BaseSkill, param2:Function, param3:Function)
      {
         super();
         _strategy = createStrategy(param1,param2,param3);
      }
      
      private function createStrategy(param1:BaseSkill, param2:Function, param3:Function) : IMoveStrategy
      {
         var _loc5_:IMoveStrategy = null;
         var _loc6_:int = -1;
         var _loc4_:SkillFrameData = param1.getActionTemplate().getMoveBackData(param1.getRoleSex());
         if(_loc4_)
         {
            _loc6_ = _loc4_.ActionType;
         }
         switch(_loc6_)
         {
            case 100:
               _loc5_ = new RunMBStrategy(param1,param2,param3);
               break;
            case 22:
               _loc5_ = new JumpMBStrategy(param1,param2,param3);
               break;
            case 24:
               _loc5_ = new StraightMBStrategy(param1,param2,param3);
         }
         return _loc5_;
      }
      
      public function execute() : void
      {
         if(_strategy)
         {
            _strategy.execute();
         }
      }
   }
}

