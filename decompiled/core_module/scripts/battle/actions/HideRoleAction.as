package battle.actions
{
   import battle.skillsys.effect.SkillEffect;
   import battle.skillsys.mode.framedata.HideFrameData;
   import yishi.datas.objects.RoleInfo;
   
   public class HideRoleAction extends GameBaseAction
   {
      
      private var _frameData:HideFrameData;
      
      private var _count:int;
      
      public function HideRoleAction(param1:RoleInfo, param2:HideFrameData)
      {
         super();
         _currentRole = param1;
         _frameData = param2;
         _currentRole.addConcurrentAction(this);
         prepare();
      }
      
      override public function prepare() : void
      {
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
         if(_count >= _frameData.persistentFrame)
         {
            showBody();
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
      
      private function showBody() : void
      {
         _finished = true;
         if(_currentRole)
         {
            _currentRole.showBody();
         }
      }
      
      override public function dispose() : void
      {
         _finished = true;
      }
   }
}

