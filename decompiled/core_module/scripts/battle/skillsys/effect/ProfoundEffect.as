package battle.skillsys.effect
{
   import battle.BattleManager;
   import battle.view.roles.RoleViewBase;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.datas.objects.HeroRoleInfo;
   
   public class ProfoundEffect
   {
      
      private var _executer:RoleViewBase;
      
      private var _callback:Function;
      
      private var _bodyEffectMc:MovieClip;
      
      private var _bodyEffect:MovieClipEffect;
      
      private var _timeId:int;
      
      private var _isSelf:Boolean;
      
      public function ProfoundEffect(param1:RoleViewBase, param2:Function, param3:Boolean)
      {
         super();
         _executer = param1;
         _callback = param2;
         _isSelf = param3;
         play();
      }
      
      private function play() : void
      {
         if(!_isSelf)
         {
            _timeId = setTimeout(completeFun,800);
            return;
         }
         var _loc1_:int = int(HeroRoleInfo(_executer.info).heroInfo.templateInfo.Sexs);
         var _loc2_:int = int(HeroRoleInfo(_executer.info).heroInfo.templateInfo.Job);
         if(HeroRoleInfo(_executer.info).heroInfo.dragonTalkerInfo.isDragonTalker)
         {
            _loc2_ = 4;
         }
         var _loc4_:String = "profound.RoleBodyEffect" + _loc1_ + "_" + _loc2_;
         _bodyEffectMc = createMovie(_loc4_);
         if(_bodyEffectMc != null)
         {
            _bodyEffect = new MovieClipEffect(_bodyEffectMc);
         }
         updateBgPosition();
         if(_isSelf && _bodyEffect != null)
         {
            _executer.info.map.effectContainer.addEffect(_bodyEffect);
         }
         _executer.scaleX = _executer.scaleY = 1.5;
         BattleManager.getInstance().battleUIView.hideTopView();
         if(!BattleManager.getInstance().battleModel.isHideOtherInBattle(_executer.info))
         {
            _executer.info.map.backGroundToColor(16777215,0.1,0.7,false,true);
            _executer.info.map.shakeScreen(1,7);
         }
         _executer.info.action("Ready");
         var _loc3_:int = (_bodyEffectMc.totalFrames - 1) * 40;
         _timeId = setTimeout(completeFun,_loc3_);
      }
      
      private function completeFun() : void
      {
         if(_timeId > 0)
         {
            clearTimeout(_timeId);
            _timeId = 0;
         }
         if(_callback != null)
         {
            _callback();
         }
         if(_executer)
         {
            _executer.scaleX = _executer.scaleY = 1;
         }
         if(_bodyEffectMc && _bodyEffectMc.parent)
         {
            _bodyEffectMc.parent.removeChild(_bodyEffectMc);
            _bodyEffectMc.stop();
         }
         if(BattleManager.getInstance().battleUIView)
         {
            BattleManager.getInstance().battleUIView.showTopView();
         }
         _bodyEffectMc = null;
         _bodyEffect = null;
         _executer = null;
         _callback = null;
      }
      
      private function updateBgPosition() : void
      {
         var _loc1_:Point = new Point();
         _loc1_.x = BattleManager.getInstance().mainViewContainer.view.x;
         _loc1_.y = BattleManager.getInstance().mainViewContainer.view.y;
         _loc1_ = _executer.info.map.effectContainer.globalToLocal(_loc1_);
         var _loc3_:Number = BattleManager.getInstance().mainViewContainer.view.sceneWidth * 0.5;
         var _loc2_:Number = BattleManager.getInstance().mainViewContainer.view.sceneHeight * 0.5;
         _bodyEffect.getDisplayObject().x = _loc1_.x + _loc3_ - 500;
         _bodyEffect.getDisplayObject().y = _loc1_.y + _loc2_ - 300;
      }
      
      private function createMovie(param1:String) : MovieClip
      {
         return BattleManager.getInstance().resourceModel.getOrCreateInstanse(param1) as MovieClip;
      }
   }
}

