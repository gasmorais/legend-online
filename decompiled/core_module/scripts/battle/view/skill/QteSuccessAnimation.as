package battle.view.skill
{
   import battle.BattleManager;
   import battle.view.animation.AddSpAnimation;
   import battle.view.roles.RoleViewBase;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class QteSuccessAnimation
   {
      
      private var _iconContainer:Sprite;
      
      private var _iconAppearMc:MovieClip;
      
      private var _icon:DisplayObject;
      
      private var _flyEffect:AddSpAnimation;
      
      private var _startPt:Point;
      
      private var _endPt:Point;
      
      private var _playTimeUint:uint;
      
      public function QteSuccessAnimation(param1:Sprite, param2:Point, param3:Point)
      {
         super();
         _iconContainer = param1;
         _startPt = _iconContainer.globalToLocal(param2);
         _endPt = _iconContainer.globalToLocal(param3);
      }
      
      public function play() : void
      {
         playFlyAnimation();
      }
      
      private function playFlyAnimation() : void
      {
         _playTimeUint = setInterval(setRoleToQteCollectionState,800);
      }
      
      private function setRoleToQteCollectionState() : void
      {
         clearInterval(_playTimeUint);
         var _loc1_:RoleViewBase = BattleManager.getInstance().getSelfRoleView();
         _loc1_.updateQteCollectionEffect();
      }
      
      public function dispose() : void
      {
         if(_iconAppearMc)
         {
            if(_iconContainer.contains(_iconAppearMc))
            {
               _iconContainer.removeChild(_iconAppearMc);
            }
            _iconAppearMc.stop();
            _iconAppearMc = null;
         }
         if(_flyEffect)
         {
            _flyEffect.dispose();
            _flyEffect = null;
         }
         _icon = null;
         clearInterval(_playTimeUint);
         _iconContainer = null;
      }
   }
}

