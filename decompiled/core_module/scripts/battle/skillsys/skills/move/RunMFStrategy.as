package battle.skillsys.skills.move
{
   import battle.actions.MovePointAction;
   import battle.data.SkillData;
   import battle.skillsys.mode.framedata.MoveFrameData;
   import battle.skillsys.skills.BaseSkill;
   import yishi.datas.objects.RoleInfo;
   
   public class RunMFStrategy extends BaseMoveStrategy
   {
      
      public function RunMFStrategy(param1:BaseSkill, param2:Function, param3:Function)
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
         var _loc2_:MoveFrameData = getMoveForwardFrameData();
         var _loc3_:SkillData = getSkillData();
         new MovePointAction(_loc3_.fId,getMoveForwardPoint(_loc1_),_loc2_.speed,_loc3_.liftTime,false,false,true,false,null,_startMoveFun,true,_loc2_.dustRes,_loc2_.dustGap,true);
         super.execute();
      }
   }
}

