package battle.actions
{
   import battle.BattleManager;
   import battle.data.AttackData;
   import battle.skillsys.effect.SkillEffect;
   import battle.skillsys.mode.framedata.DisplacementFrameData;
   import battle.skillsys.skills.BaseSkill;
   import battle.utils.BattleUtils;
   import flash.geom.Point;
   import yishi.datas.objects.RoleInfo;
   
   public class DisplacementAction extends GameBaseAction
   {
      
      private var _frameData:DisplacementFrameData;
      
      private var _count:int;
      
      private var _skill:BaseSkill;
      
      public function DisplacementAction(param1:RoleInfo, param2:DisplacementFrameData, param3:BaseSkill)
      {
         super();
         _currentRole = param1;
         _frameData = param2;
         _skill = param3;
         _currentRole.addConcurrentAction(this);
         if(!_currentRole)
         {
            _finished = true;
            return;
         }
         _currentRole.hideBody();
         if(_frameData.disappearEffect && _frameData.disappearEffect != "")
         {
            addEffect(_frameData.disappearEffect);
         }
      }
      
      override public function update() : void
      {
         _count = _count + 1;
         if(_count >= _frameData.persistentFrames)
         {
            showBody();
         }
      }
      
      private function showBody() : void
      {
         _finished = true;
         if(_currentRole)
         {
            if(_frameData.isForward)
            {
               _currentRole.point = getAppearPointForward();
               _currentRole.setAttactDirection();
            }
            else
            {
               _currentRole.point = getAppearPointBack();
               _currentRole.point = _currentRole.point;
            }
            _currentRole.showBody();
            if(_frameData.appearEffect && _frameData.appearEffect != "")
            {
               addEffect(_frameData.appearEffect);
            }
         }
      }
      
      private function addEffect(param1:String) : void
      {
         if(battleModel.isHideOtherInBattle(_currentRole))
         {
            return;
         }
         var _loc2_:SkillEffect = new SkillEffect(param1);
         _loc2_.getDisplayObject().x = _currentRole.point.x;
         _loc2_.getDisplayObject().y = _currentRole.point.y;
         if(_currentRole.map)
         {
            _currentRole.map.addEffect(_loc2_);
         }
      }
      
      private function getAppearPointForward() : Point
      {
         var _loc2_:Point = null;
         var _loc3_:RoleInfo = null;
         var _loc1_:AttackData = null;
         var _loc5_:int = 0;
         var _loc4_:int = _currentRole.face == 1 ? 2 : 1;
         if(_frameData.target == 0)
         {
            _loc1_ = AttackData(_skill.getSkillData().data[0][0]);
            _loc3_ = BattleManager.getInstance().battleModel.getRoleById(_loc1_.roleId);
            _loc2_ = BattleUtils.rolePointByPos(_loc3_.pos,_loc4_).clone();
            if(_loc4_ == 2)
            {
               _loc2_.x -= _frameData.offsetX;
            }
            else
            {
               _loc2_.x += _frameData.offsetX;
            }
         }
         else
         {
            _loc5_ = _frameData.target;
            _loc2_ = BattleUtils.rolePointByPos(_loc5_,_loc4_);
         }
         _loc2_.y += _frameData.offsetY;
         return _loc2_;
      }
      
      private function getAppearPointBack() : Point
      {
         return BattleUtils.rolePointByPos(_currentRole.pos,_currentRole.face);
      }
      
      override public function dispose() : void
      {
         _finished = true;
      }
   }
}

