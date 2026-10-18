package battle.view.skillname
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class SkillNameContainer extends Sprite
   {
      
      private var _currentView:SkillNameView;
      
      private var _removeId:uint;
      
      public function SkillNameContainer()
      {
         super();
         NotificationManager.instance.addEventListener("SHOW_SKILL_NAME_BattleNotic",showSkill);
      }
      
      private function showSkill(param1:NotificationEvent) : void
      {
         if(_currentView)
         {
            removeView();
         }
         var _loc2_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(param1.data);
         if(_loc2_)
         {
            _currentView = new SkillNameView(_loc2_.SonType);
            _currentView.x = -_currentView.width * 0.5;
            addChild(_currentView);
         }
      }
      
      private function removeView() : void
      {
         ObjectUtils.disposeObject(_currentView);
         _currentView = null;
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("SHOW_SKILL_NAME_BattleNotic",showSkill);
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

