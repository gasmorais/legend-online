package battle.view.roles
{
   import battle.BattleManager;
   import battle.data.GameLoadNeedData;
   import battle.events.BattleEvent;
   import battle.utils.BattleUtils;
   import battle.view.GameView;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.MonsterRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.SharedManager;
   
   public class MonsterRoleView extends RoleViewBase
   {
      
      private var _gameView:GameView;
      
      private var _monsterRoleInfo:MonsterRoleInfo;
      
      public function MonsterRoleView(param1:RoleInfo)
      {
         _monsterRoleInfo = param1 as MonsterRoleInfo;
         super(param1);
      }
      
      private function get monsterRoleInfo() : MonsterRoleInfo
      {
         return _monsterRoleInfo;
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
      
      override public function load() : void
      {
         _displayMode = 1;
         var _loc2_:GameLoadNeedData = new GameLoadNeedData(PathManager.solveRolePath(monsterRoleInfo.tempInfo.ResPath),PathManager.solveRoleClassPath(monsterRoleInfo.tempInfo.ResPath));
         _gameView = new GameView();
         _gameView.onComplete = __onLoadCompleteHandler;
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
      
      private function __onLoadCompleteHandler() : void
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
      
      override protected function delayInitView() : void
      {
         if(_disposed)
         {
            return;
         }
         super.delayInitView();
         if(roleInfoView)
         {
            heroNameTxt.text = monsterRoleInfo.tempInfo.Name;
         }
      }
      
      override public function setRoleInfoViewVisible(param1:Boolean) : void
      {
         super.setRoleInfoViewVisible(param1);
         var _loc2_:BattleModel = BattleManager.getInstance().battleModel;
         if(_loc2_.battleType != 3884)
         {
            setBloodStripVisible(false,true);
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
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_gameView);
         _gameView = null;
         super.dispose();
      }
   }
}

