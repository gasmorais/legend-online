package battle.skillsys.skills.move
{
   import battle.actions.JumpMoveAction;
   import battle.data.SkillData;
   import battle.skillsys.mode.framedata.MoveFrameData;
   import battle.skillsys.skills.BaseSkill;
   import flash.geom.Point;
   import yishi.datas.objects.RoleInfo;
   
   public class JumpMFStrategy extends BaseMoveStrategy
   {
      
      public function JumpMFStrategy(param1:BaseSkill, param2:Function, param3:Function)
      {
         super(param1,param2,param3);
      }
      
      override public function execute() : void
      {
         var _loc1_:RoleInfo = getToRole();
         if(!_loc1_)
         {
            return;
         }
         var _loc3_:MoveFrameData = getMoveForwardFrameData();
         var _loc4_:SkillData = getSkillData();
         var _loc2_:Point = getMoveForwardPoint(_loc1_);
         new JumpMoveAction(_loc4_.fId,_loc2_,0,_loc4_.liftTime,false,false,true,false,null,_startMoveFun,true,_loc3_.dustRes,_loc3_.dustGap);
         super.execute();
      }
   }
}

