package battle.skillsys.skills.move
{
   import battle.actions.JumpMoveAction;
   import battle.data.SkillData;
   import battle.skillsys.mode.framedata.MoveFrameData;
   import battle.skillsys.skills.BaseSkill;
   import flash.geom.Point;
   
   public class JumpMBStrategy extends BaseMoveStrategy
   {
      
      public function JumpMBStrategy(param1:BaseSkill, param2:Function, param3:Function)
      {
         super(param1,param2,param3);
      }
      
      override public function execute() : void
      {
         var _loc2_:MoveFrameData = getMoveBackFrameData();
         var _loc3_:SkillData = _skill.getSkillData();
         var _loc1_:Point = getMoveBackPoint();
         new JumpMoveAction(_loc3_.fId,_loc1_,0,_loc3_.liftTime + 5,false,false,true,false,_endMoveFun,null,true,_loc2_.dustRes,_loc2_.dustGap);
      }
   }
}

