package battle.view.roles
{
   import battle.data.GameLoadNeedData;
   import battle.events.BattleEvent;
   import battle.utils.BattleUtils;
   import battle.view.GameView;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.datas.objects.SelfChessRoleInfo;
   import yishi.datas.templates.SelfChessTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.SharedManager;
   
   public class SelfChessRoleView extends HeroRoleView
   {
      
      public function SelfChessRoleView(param1:RoleInfo)
      {
         super(param1);
      }
      
      override public function load() : void
      {
         var _loc10_:String = null;
         var _loc4_:String = null;
         var _loc6_:int = 0;
         var _loc8_:GameLoadNeedData = null;
         var _loc1_:GameLoadNeedData = null;
         var _loc2_:GameLoadNeedData = null;
         var _loc12_:String = null;
         var _loc11_:* = null;
         var _loc7_:* = null;
         var _loc9_:GameLoadNeedData = null;
         _displayMode = 1;
         var _loc5_:SelfChessTempInfo = (_info as SelfChessRoleInfo).tempInfo;
         if((_info as HeroRoleInfo).type != 3)
         {
            _loc6_ = _loc5_.ResType;
            if(_loc6_ == 1)
            {
               _loc10_ = PathManager.solveRolePath(_loc5_.ResPath);
               _loc4_ = PathManager.solveRoleClassPath(_loc5_.ResPath);
               _loc8_ = new GameLoadNeedData(_loc10_,_loc4_);
               gameView = new GameView();
               gameView.onComplete = __onLoadConplete;
               gameView.data = _loc8_;
            }
            else if(_loc6_ == 2)
            {
               _loc10_ = PathManager.solveHeroAvatarPath(_loc5_.ResPath,2);
               _loc1_ = new GameLoadNeedData(_loc10_);
               gameView = new GameView(false);
               gameView.onComplete = onPetPartComplete2;
               gameView.data = _loc1_;
            }
            else if(_loc6_ == 3)
            {
               _loc10_ = PathManager.solveCampaignMovieByUrl(_loc5_.ResPath);
               _loc2_ = new GameLoadNeedData(_loc10_);
               gameView = new GameView(false);
               gameView.onComplete = onPetPartComplete2;
               gameView.data = _loc2_;
            }
         }
         else
         {
            _loc12_ = HeroRoleInfo(_info).resPath;
            _loc10_ = PathManager.solveRolePath(_loc12_);
            _loc4_ = PathManager.solveRoleClassPath(_loc12_);
            _loc9_ = new GameLoadNeedData(_loc10_,_loc4_);
            gameView = new GameView();
            gameView.onComplete = heroMcLoadComplete;
            gameView.data = _loc9_;
         }
         _movieContainer.addChild(_info.actionMovie);
         var _loc3_:Point = BattleUtils.rolePointByPos(_info.pos,_info.face);
         if(_info.face == 2)
         {
            _movieContainer.scaleX = -1;
         }
         else
         {
            _movieContainer.scaleX = 1;
         }
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
         if(gameView)
         {
            _info.actionMovieClip = MovieClip(gameView.content);
         }
         _loadingState = 1;
         _info.isLoadComplete = true;
         removeLoadingView();
         if(gameView)
         {
            MovieClip(gameView.content).soundTransform = SharedManager.instance.getSkillSoundTransform();
            if(MovieClip(gameView.content).shadow != undefined)
            {
               initShadeScale(MovieClip(gameView.content).shadow);
            }
         }
      }
      
      override protected function delayInitView() : void
      {
         var _loc2_:int = 0;
         if(_disposed)
         {
            return;
         }
         super.delayInitView();
         if(!roleInfoView)
         {
            return;
         }
         var _loc1_:HeroRoleInfo = _info as HeroRoleInfo;
         if(_loc1_)
         {
            if(!_awakenShineMc)
            {
               _awakenShineMc = ComponentFactory.Instance.creatCustomObject("battle.BottomAwakenMc");
            }
            _awakenMc = _awakenShineMc["progressMc"] as MovieClip;
            _awakenShineMc.gotoAndStop(1);
            _loc2_ = Math.floor(_loc1_.awaken * 100 / awakenFullValue);
            _awakenMc.gotoAndStop(_loc2_);
            if(_stripView)
            {
               (_stripView.getView() as Sprite).addChild(_awakenShineMc);
            }
         }
      }
      
      override public function dispose() : void
      {
         NotificationManager.instance.removeEventListener("battleUILoaded",onBattleUILoaded2);
         super.dispose();
      }
   }
}

