package battle.view.roles
{
   import battle.view.GameView;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import yishi.datas.objects.GoddessRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.manager.SharedManager;
   
   public class GoddessRoleView extends RoleViewBase
   {
      
      private var gameView:GameView;
      
      private var goddessInfo:GoddessRoleInfo;
      
      public function GoddessRoleView(param1:RoleInfo)
      {
         goddessInfo = param1 as GoddessRoleInfo;
         super(param1);
      }
      
      override public function load() : void
      {
         _displayMode = 1;
         if(!goddessInfo.template || !_info)
         {
            return;
         }
         if(_movieContainer)
         {
            _movieContainer.addChild(_info.actionMovie);
         }
         _info.actionMovieClip = new MovieClip();
         _info.actionMovie.soundTransform = SharedManager.instance.getSkillSoundTransform();
         _info.isLoadComplete = true;
         if(_roleInfoView)
         {
            _roleInfoView.visible = false;
         }
         this.x = info.point.x;
         this.y = info.point.y;
         removeLoadingView();
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
            if(gameView)
            {
               gameView.dispose();
            }
            gameView = null;
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
         this.visible = false;
      }
      
      override public function setRoleInfoViewVisible(param1:Boolean) : void
      {
         super.setRoleInfoViewVisible(param1);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
      }
      
      override public function updateShadowPos() : void
      {
         super.updateShadowPos();
         if(!info)
         {
            return;
         }
         if(battleModel.isOver)
         {
            return;
         }
         this.x = info.point.x;
         this.y = info.point.y;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

