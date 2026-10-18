package battle.skillsys.skills.move
{
   import battle.BattleManager;
   import battle.data.AttackData;
   import battle.data.SkillData;
   import battle.logsys.BattleLogSystem;
   import battle.skillsys.mode.framedata.MoveFrameData;
   import battle.skillsys.skills.BaseSkill;
   import battle.utils.BattleUtils;
   import flash.geom.Point;
   import yishi.datas.objects.RoleInfo;
   
   public class BaseMoveStrategy implements IMoveStrategy
   {
      
      protected var _skill:BaseSkill;
      
      protected var _startMoveFun:Function;
      
      protected var _endMoveFun:Function;
      
      public function BaseMoveStrategy(param1:BaseSkill, param2:Function, param3:Function)
      {
         super();
         _skill = param1;
         _startMoveFun = param2;
         _endMoveFun = param3;
      }
      
      public function execute() : void
      {
         BattleLogSystem.skillProgress(_skill,2);
      }
      
      protected function getToRole() : RoleInfo
      {
         var _loc2_:* = null;
         if(getSkillData().data.length < 1 || getSkillData().data[0].length < 1)
         {
            return null;
         }
         var _loc1_:AttackData = AttackData(getSkillData().data[0][0]);
         return BattleManager.getInstance().battleModel.getRoleById(_loc1_.roleId);
      }
      
      protected function getMoveForwardPoint(param1:RoleInfo) : Point
      {
         var _loc2_:Point = null;
         var _loc3_:int = 0;
         var _loc4_:MoveFrameData = getMoveForwardFrameData();
         if(_loc4_.target)
         {
            _loc3_ = _loc4_.target;
         }
         else
         {
            _loc3_ = param1.pos;
         }
         _loc2_ = BattleUtils.rolePointByPos(_loc3_,param1.face).clone();
         if(_skill.getCurrentRole().face == 1)
         {
            _loc2_.x -= _loc4_.distance;
         }
         else
         {
            _loc2_.x += _loc4_.distance;
         }
         return _loc2_;
      }
      
      protected function getMoveBackPoint() : Point
      {
         return BattleUtils.rolePointByPos(_skill.getCurrentRole().pos,_skill.getCurrentRole().face);
      }
      
      protected function getSkillData() : SkillData
      {
         return _skill.getSkillData();
      }
      
      protected function getMoveForwardFrameData() : MoveFrameData
      {
         return _skill.getActionTemplate().getMoveForwardData(_skill.getRoleSex()).moveForwardData;
      }
      
      protected function getMoveBackFrameData() : MoveFrameData
      {
         return _skill.getActionTemplate().getMoveBackData(_skill.getRoleSex()).moveBackData;
      }
   }
}

