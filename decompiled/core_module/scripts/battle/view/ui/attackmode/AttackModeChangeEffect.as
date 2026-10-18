package battle.view.ui.attackmode
{
   import battle.BattleManager;
   import com.pickgliss.utils.ClassUtils;
   import flash.display.Sprite;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.view.tools.QuickenMovieClip;
   
   public class AttackModeChangeEffect
   {
      
      private var _container:Sprite;
      
      private var _effectMc:QuickenMovieClip;
      
      public function AttackModeChangeEffect(param1:Sprite)
      {
         super();
         _container = param1;
         NotificationManager.instance.addEventListener("battleModeChange",onBattleModeChange);
      }
      
      private function onBattleModeChange(param1:NotificationEvent) : void
      {
         var _loc2_:String = null;
         clear();
         _container = BattleManager.getInstance().getSelfRoleView().middleContainer;
         if(param1.data == 1)
         {
            _loc2_ = "asset.battle.AttackModeDefenseEffect";
         }
         else
         {
            _loc2_ = "asset.battle.AttackModeAttackEffect";
         }
         if(_loc2_)
         {
            _effectMc = new QuickenMovieClip(ClassUtils.CreatInstance(_loc2_));
            _container.addChild(_effectMc);
            _effectMc.y = -80;
            _effectMc.addFrameScript(_effectMc.totalFrames - 1,clear);
            updateEffectSpeed();
         }
         NotificationManager.instance.addEventListener("selfMoveStart",onSelfMoveStart);
      }
      
      private function updateEffectSpeed() : void
      {
         if(BattleManager.getInstance().battleModel.selfHero.moving)
         {
            _effectMc.step = 3;
         }
      }
      
      private function onSelfMoveStart(param1:NotificationEvent) : void
      {
         NotificationManager.instance.removeEventListener("selfMoveStart",onSelfMoveStart);
         if(_effectMc)
         {
            updateEffectSpeed();
         }
      }
      
      private function clear() : void
      {
         onSelfMoveStart(null);
         if(_effectMc)
         {
            _effectMc.dispose();
            if(_effectMc.parent)
            {
               _effectMc.parent.removeChild(_effectMc);
            }
            _effectMc = null;
         }
      }
      
      public function dispose() : void
      {
         clear();
         NotificationManager.instance.removeEventListener("battleModeChange",onBattleModeChange);
      }
   }
}

