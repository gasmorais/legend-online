package battle.skillsys.effect
{
   import battle.BattleManager;
   import battle.view.roles.RoleViewBase;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import yishi.utils.TimerUtils;
   
   public class ProfoundEffectII
   {
      
      private var _executer:RoleViewBase;
      
      private var _callback:Function;
      
      private var _disperseEffect:MovieClipEffect;
      
      public function ProfoundEffectII(param1:RoleViewBase, param2:Function)
      {
         super();
         _executer = param1;
         _callback = param2;
         play();
      }
      
      private function play() : void
      {
         if(!BattleManager.getInstance().battleModel.isHideOtherInBattle(_executer.info))
         {
            _disperseEffect = new MovieClipEffect(createMovie("profound.DisperseAsset"));
            updateBgPosition();
            _executer.info.map.effectContainer.addEffect(_disperseEffect);
            _executer.info.map.backGroundToColor(16777215,0.4,0.7,false,true);
            _executer.info.map.shakeScreen(1,7);
         }
         BattleManager.getInstance().battleUIView.hideTopView();
         _executer.info.action("Ready");
         TimerUtils.setTimeout(completeFun,1000);
      }
      
      private function completeFun() : void
      {
         if(_callback != null)
         {
            _callback();
            _callback = null;
         }
         if(BattleManager.getInstance().battleUIView)
         {
            BattleManager.getInstance().battleUIView.showTopView();
         }
         _disperseEffect = null;
         _executer = null;
      }
      
      private function updateBgPosition() : void
      {
         var _loc1_:Point = new Point();
         _loc1_.x = BattleManager.getInstance().mainViewContainer.view.x;
         _loc1_.y = BattleManager.getInstance().mainViewContainer.view.y;
         _loc1_ = _executer.info.map.effectContainer.globalToLocal(_loc1_);
         _loc1_.x = _executer.x;
         _loc1_.y = _executer.y;
         _loc1_ = _executer.parent.localToGlobal(_loc1_);
         _loc1_ = _executer.info.map.effectContainer.globalToLocal(_loc1_);
         _disperseEffect.getDisplayObject().x = _loc1_.x;
         _disperseEffect.getDisplayObject().y = _loc1_.y;
      }
      
      private function createMovie(param1:String) : MovieClip
      {
         return BattleManager.getInstance().resourceModel.getOrCreateInstanse(param1) as MovieClip;
      }
   }
}

