package battle.view.roles
{
   import battle.data.GameLoadNeedData;
   import battle.events.BattleEvent;
   import battle.utils.BattleUtils;
   import battle.utils.Helpers;
   import battle.view.GameView;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.PawnRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.events.RoleEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   
   public class PawnRoleView extends RoleViewBase
   {
      
      private var _gameView:GameView;
      
      public function PawnRoleView(param1:RoleInfo)
      {
         super(param1);
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         _info.addEventListener("count",__count);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         if(_info)
         {
            _info.removeEventListener("count",__count);
         }
      }
      
      private function __count(param1:RoleEvent) : void
      {
      }
      
      private function __onLoadConplete() : void
      {
         if(BattleModel.battleUILoaded)
         {
            onBattleUILoaded2(null);
         }
         else
         {
            NotificationManager.instance.addEventListener("battleUILoaded",onBattleUILoaded2,false,0,true);
         }
      }
      
      private function onBattleUILoaded2(param1:BattleEvent) : void
      {
         NotificationManager.instance.removeEventListener("battleUILoaded",onBattleUILoaded2);
         if(!_info)
         {
            return;
         }
         if(_gameView)
         {
            _info.actionMovieClip = MovieClip(_gameView.content);
         }
         _loadingState = 1;
         _info.isLoadComplete = true;
         removeLoadingView();
         if(_gameView)
         {
            MovieClip(_gameView.content).soundTransform = SharedManager.instance.getSkillSoundTransform();
            if(MovieClip(_gameView.content).shadow != undefined)
            {
               initShadeScale(MovieClip(_gameView.content).shadow);
            }
         }
      }
      
      override public function load() : void
      {
         _displayMode = 1;
         var _loc2_:GameLoadNeedData = new GameLoadNeedData(PathManager.solveRolePath(_info.effectId),PathManager.solveRoleClassPath(_info.effectId));
         _gameView = new GameView();
         _gameView.onComplete = __onLoadConplete;
         _gameView.data = _loc2_;
         _movieContainer.addChild(_info.actionMovie);
         var _loc1_:Point = BattleUtils.rolePointByPos(_info.pos,_info.face);
         if(_info.face == 2)
         {
            _movieContainer.scaleX = -1;
         }
         else
         {
            _movieContainer.scaleX = 1;
         }
      }
      
      override public function displayMode(param1:int) : void
      {
         var _loc2_:MovieClip = null;
         if(param1 == -1)
         {
            if(!battleModel.isHideOtherInBattle(info))
            {
               return;
            }
            if(_gameView)
            {
               _gameView.dispose();
            }
            _gameView = null;
            _displayMode = -1;
            if(_info && _info.actionMovie && _info.actionMovie.movie)
            {
               _loc2_ = _info.actionMovie.movie;
               ObjectUtils.disposeViolentMc(_loc2_);
               _info.actionMovie.movie = null;
            }
         }
         else if(_info.startload && _displayMode == -1)
         {
            if(battleModel.isHideOtherInBattle(info))
            {
               return;
            }
            load();
            _displayMode = 1;
         }
         else if(!_info.startload)
         {
            if(battleModel.isHideOtherInBattle(info))
            {
               return;
            }
            _info.load();
            _displayMode = 1;
         }
      }
      
      override protected function delayInitView() : void
      {
         if(_disposed)
         {
            return;
         }
         super.delayInitView();
         var _loc1_:int = TempleteManager.instance.pawnTemplateCate.getTemplateByID(_info.templateId).Level;
         if(roleInfoView)
         {
            heroNameTxt.text = PawnRoleInfo(_info).tempInfo.Name + " " + LanguageMgr.GetTranslation("public.level2",_loc1_);
         }
      }
      
      override public function updateShadowPos() : void
      {
         if(_disposed)
         {
            return;
         }
         if(!_info.actionMovie.movie || !_shade)
         {
            return;
         }
         var _loc1_:DisplayObject = _info.actionMovie.movie.pos_leg;
         if(_loc1_)
         {
            _shade.x = _loc1_.x;
            _shade.y = _loc1_.y;
            _shade.x = 0;
            _shade.y = 0;
         }
      }
      
      private function get pawnInfo() : PawnRoleInfo
      {
         return _info as PawnRoleInfo;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_gameView);
         _gameView = null;
         Helpers.removeAllChildren(this);
         super.dispose();
      }
   }
}

