package battle.skillsys.skills.move
{
   import battle.actions.MovePointAction;
   import battle.data.SkillData;
   import battle.skillsys.mode.framedata.MoveFrameData;
   import battle.skillsys.skills.BaseSkill;
   
   public class RunMBStrategy extends BaseMoveStrategy
   {
      
      public function RunMBStrategy(param1:BaseSkill, param2:Function, param3:Function)
      {
         super(param1,param2,param3);
      }
      
      override public function execute() : void
      {
         var _loc1_:MoveFrameData = getMoveBackFrameData();
         var _loc2_:SkillData = _skill.getSkillData();
         new MovePointAction(_loc2_.fId,getMoveBackPoint(),_loc1_.speed,_loc2_.liftTime + 5,false,false,true,false,_endMoveFun,null,true,_loc1_.dustRes,_loc1_.dustGap);
      }
   }
}

