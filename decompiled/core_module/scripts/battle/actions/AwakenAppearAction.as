package battle.actions
{
   import battle.BattleManager;
   import battle.skillsys.effect.BattleEffect;
   import battle.skillsys.effect.SkillEffect;
   import battle.view.roles.RoleViewBase;
   import yishi.datas.objects.RoleInfo;
   
   public class AwakenAppearAction extends GameBaseAction
   {
      
      private var _appearEffect:BattleEffect;
      
      private var _count:int;
      
      public function AwakenAppearAction(param1:RoleInfo)
      {
         _currentRole = param1;
         super(false);
         _currentRole.addAction(this);
         var _loc2_:RoleViewBase = BattleManager.getInstance().battleMap.rolesDict[param1.livingId] as RoleViewBase;
         _loc2_.visible = false;
         if(_currentRole.face == 2)
         {
            _currentRole.direction = "left";
         }
         else
         {
            _currentRole.direction = "right";
         }
      }
      
      override public function prepare() : void
      {
         super.prepare();
         if(battleModel.isHideOtherInBattle(_currentRole))
         {
            return;
         }
         _appearEffect = new SkillEffect("awaken.AwakenAppearEffect");
         _appearEffect.getDisplayObject().x = _currentRole.point.x;
         _appearEffect.getDisplayObject().y = _currentRole.point.y;
         BattleManager.getInstance().battleMap.addEffect(_appearEffect);
      }
      
      override public function update() : void
      {
         var _loc1_:RoleViewBase = null;
         _count = _count + 1;
         if(_count >= 12)
         {
            _loc1_ = BattleManager.getInstance().battleMap.rolesDict[_currentRole.livingId] as RoleViewBase;
            _loc1_.visible = true;
            _finished = true;
         }
      }
   }
}

