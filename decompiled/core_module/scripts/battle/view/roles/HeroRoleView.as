package battle.view.roles
{
   import battle.BattleManager;
   import battle.data.GameLoadNeedData;
   import battle.events.BattleEvent;
   import battle.utils.Helpers;
   import battle.view.GameView;
   import com.greensock.TweenLite;
   import com.pickgliss.effect.Color;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.PetRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.events.RoleEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.view.tools.HeroMovieClip;
   
   public class HeroRoleView extends RoleViewBase
   {
      
      private var _vocationEffect:MovieImage;
      
      private var _petMovie:MovieClip;
      
      private var _childChangeMovie:MovieClip;
      
      private var _avengerEffect:MovieImage;
      
      protected var _heroMovie:HeroMovieClip;
      
      protected var gameView:GameView;
      
      private var _delaySetStateId:uint;
      
      protected var _needLoad:int = 1;
      
      private var _loaded:int = 0;
      
      private var preEffectType:int;
      
      protected var _awakenShineMc:MovieClip;
      
      protected var _awakenMc:MovieClip;
      
      private var _awakenTween:TweenLite;
      
      public var isChangeBody:Boolean;
      
      public function HeroRoleView(param1:RoleInfo)
      {
         super(param1);
         if((param1 as HeroRoleInfo).heroInfo.avengerDegree > 0)
         {
            if(battleModel.isHideOtherInBattle(param1))
            {
               return;
            }
            loadAvengerEffect();
         }
      }
      
      private function loadAvengerEffect() : void
      {
         var _loc1_:String = ComponentSetting.getUISourcePath("avengereffect");
         LoaderManagerII.instance.load(_loc1_,3,0,completeHandler);
      }
      
      private function completeHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:int = Math.min(10,Math.ceil((info as HeroRoleInfo).heroInfo.avengerDegree / 2));
         if(_avengerEffect == null)
         {
            _avengerEffect = ComponentFactory.Instance.creatComponentByStylename("core.avengerEffectzd" + _loc3_);
            addChild(_avengerEffect);
         }
         _avengerEffect.movie.gotoAndPlay(1);
         preEffectType = _loc3_;
      }
      
      override public function load() : void
      {
         var _loc3_:PetRoleInfo = null;
         var _loc2_:GameLoadNeedData = null;
         if(!_info)
         {
            return;
         }
         var _loc1_:HeroRoleInfo = _info as HeroRoleInfo;
         if(!_loc1_)
         {
            return;
         }
         if(_loc1_.isChildFake)
         {
            _childChangeMovie = ComponentFactory.Instance.creatCustomObject("HeroRoleView.childChangeMovie");
         }
         _displayMode = 1;
         if(_loc1_.type != 3 && _loc1_.type != 7 && _loc1_.type != 8)
         {
            _loc3_ = _loc1_.petRoleInfo;
            if(_loc1_.isPetFake)
            {
               setBloodStripVisible(false);
               _roleInfoViewVisible = false;
            }
            if(_loc3_ && _loc3_.livingId != _info.livingId || _loc1_.isPetFake)
            {
               _needLoad = 2;
               gameView = new GameView(false);
               gameView.onComplete = onPetPartComplete;
               gameView.data = HeroLoadDataFactory.create(_loc1_.heroInfo,"pet_body",PathManager.isShowDragon(_loc1_.heroInfo));
            }
            if(_loc3_ && _loc3_.livingId == _info.livingId && !_loc1_.isPetFake)
            {
               gameView = new GameView(false);
               gameView.onComplete = onPetPartComplete2;
               gameView.data = HeroLoadDataFactory.create(_loc1_.heroInfo,"pet_body",PathManager.isShowDragon(_loc1_.heroInfo));
            }
            else if(_loc1_.isChildFake)
            {
               gameView = new GameView(false);
               gameView.onComplete = onPetPartComplete2;
               gameView.data = HeroLoadDataFactory.create(_loc1_.heroInfo,"children",PathManager.isShowDragon(_loc1_.heroInfo));
            }
            else
            {
               _heroMovie = new HeroMovieClip(_loc1_);
               _heroMovie.callBackComplete.addSingleListener(bossLoadComplete);
               _heroMovie.startLoad();
            }
         }
         else
         {
            _loc2_ = new GameLoadNeedData(PathManager.solveRolePath(_loc1_.resPath),PathManager.solveRoleClassPath(_loc1_.resPath));
            gameView = new GameView();
            gameView.onComplete = heroMcLoadComplete;
            gameView.data = _loc2_;
         }
         _movieContainer.addChild(_info.actionMovie);
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
         super.displayMode(param1);
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
            if(_heroMovie)
            {
               _heroMovie.dispose();
            }
            _heroMovie = null;
            if(_petMovie)
            {
               ObjectUtils.disposeViolentMc(_petMovie);
            }
            _petMovie = null;
            if(_vocationEffect)
            {
               ObjectUtils.disposeObject(_vocationEffect);
            }
            _vocationEffect = null;
            if(_avengerEffect)
            {
               ObjectUtils.disposeObject(_avengerEffect);
            }
            _avengerEffect = null;
            _displayMode = -1;
            _loaded = 0;
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
            if((info as HeroRoleInfo).heroInfo.avengerDegree > 0)
            {
               loadAvengerEffect();
            }
         }
         else if(!_info.startload)
         {
            if(battleModel.isHideOtherInBattle(info))
            {
               return;
            }
            _info.load();
            _displayMode = 1;
            if((info as HeroRoleInfo).heroInfo.avengerDegree > 0)
            {
               loadAvengerEffect();
            }
         }
      }
      
      protected function onPetPartComplete(param1:GameView) : void
      {
         if(_disposed)
         {
            return;
         }
         if(!_info)
         {
            return;
         }
         if(!param1.content)
         {
            return;
         }
         var _loc2_:GameLoadNeedData = param1.data as GameLoadNeedData;
         _petMovie = MovieClip(param1.content);
         _petMovie.soundTransform = SharedManager.instance.getSkillSoundTransform();
         checkCanShowBody();
      }
      
      protected function onPetPartComplete2(param1:GameView) : void
      {
         if(_disposed)
         {
            return;
         }
         if(!_info)
         {
            return;
         }
         if(!param1.content)
         {
            return;
         }
         _loadingState = 1;
         _info.isLoadComplete = true;
         removeLoadingView();
         _delaySetStateId = setTimeout(delayInitState,200);
         var _loc2_:GameLoadNeedData = param1.data as GameLoadNeedData;
         _petMovie = MovieClip(param1.content);
         _petMovie.soundTransform = SharedManager.instance.getSkillSoundTransform();
         if(_petMovie)
         {
            _petMovie.gotoAndStop(1);
            _info.actionMovieClip = _petMovie;
         }
         if(_movieContainer.numChildren > 0)
         {
            _movieContainer.removeChildAt(0);
         }
         if(_info.actionMovieClip)
         {
            _movieContainer.addChild(_info.actionMovieClip);
            layoutEffect();
            Helpers.getPos(HeroRoleInfo(_info).pos_head_hero,_info.actionMovieClip,"pos_body");
            Helpers.getPos(HeroRoleInfo(_info).pos_body_hero,_info.actionMovieClip,"pos_head");
            Helpers.getPos(HeroRoleInfo(_info).pos_leg_hero,_info.actionMovieClip,"pos_leg");
         }
         if(HeroRoleInfo(_info).heroInfo && HeroRoleInfo(_info).heroInfo.isSlavedChild)
         {
            _info.actionMovieClip.filters = [UIFilter.getDarkFilter()];
         }
         if(HeroRoleInfo(_info).isChildFake)
         {
            checkCanShowBody();
         }
      }
      
      protected function bossLoadComplete() : void
      {
         var onBattleUILoaded1:* = function(param1:BattleEvent):void
         {
            var _loc2_:Color = null;
            NotificationManager.instance.removeEventListener("battleUILoaded",onBattleUILoaded1);
            if(_disposed)
            {
               return;
            }
            if(_heroMovie)
            {
               _heroMovie.soundTransform = SharedManager.instance.getSkillSoundTransform();
            }
            _loadingState = 1;
            _info.isLoadComplete = true;
            removeLoadingView();
            if(_heroMovie && _heroMovie.getBodyMC() && _heroMovie.getBodyMC().hasOwnProperty("shadow"))
            {
               initShadeScale(_heroMovie.getBodyMC()["shadow"]);
            }
            if(_info.face == 2 && BattleManager.getInstance().battleModel.isKingTower())
            {
               _loc2_ = new Color();
               _loc2_.tintMultiplier = 0.5;
               if(_info.actionMovieClip)
               {
                  _info.actionMovieClip.transform.colorTransform = _loc2_;
               }
            }
            _delaySetStateId = setTimeout(delayInitState,200);
            checkCanShowBody();
         };
         if(_disposed)
         {
            return;
         }
         if(!_info)
         {
            return;
         }
         if(BattleModel.battleUILoaded)
         {
            onBattleUILoaded1(null);
         }
         else
         {
            NotificationManager.instance.addEventListener("battleUILoaded",onBattleUILoaded1,false,0,true);
         }
      }
      
      private function checkCanShowBody() : void
      {
         _loaded = _loaded + 1;
         if(_loaded == _needLoad)
         {
            changeBody();
         }
      }
      
      protected function heroMcLoadComplete() : void
      {
         var onBattleUILoaded1:* = function(param1:BattleEvent):void
         {
            NotificationManager.instance.removeEventListener("battleUILoaded",onBattleUILoaded1);
            if(_info)
            {
               if(_disposed)
               {
                  return;
               }
               if(gameView && gameView.content is MovieClip)
               {
                  _info.actionMovieClip = MovieClip(gameView.content);
                  MovieClip(gameView.content).soundTransform = SharedManager.instance.getSkillSoundTransform();
                  _info.isLoadComplete = true;
                  removeLoadingView();
                  if(MovieClip(gameView.content).shadow != undefined)
                  {
                     initShadeScale(MovieClip(gameView.content).shadow);
                  }
                  changeBody();
               }
            }
            _loadingState = 1;
         };
         if(BattleModel.battleUILoaded)
         {
            onBattleUILoaded1(null);
         }
         else
         {
            NotificationManager.instance.addEventListener("battleUILoaded",onBattleUILoaded1,false,0,true);
         }
      }
      
      private function delayInitState() : void
      {
         var _loc1_:HeroRoleInfo = null;
         if(_disposed)
         {
            return;
         }
         if(!_info.isLiving || _info.bloodA <= 0)
         {
            if(_info is HeroRoleInfo)
            {
               _loc1_ = _info as HeroRoleInfo;
               if(_loc1_.type < 101 || _loc1_.type > 106)
               {
                  _loc1_.isPetState = false;
               }
               if(_loc1_.petRoleInfo)
               {
                  _loc1_.petRoleInfo.visible = false;
               }
            }
            _info.action("Failed","STOP");
            if(_info == BattleManager.getInstance().battleModel.selfHero)
            {
               _info.cleanBuffers();
            }
         }
      }
      
      override protected function delayInitView() : void
      {
         var _loc4_:int = 0;
         if(_disposed)
         {
            return;
         }
         super.delayInitView();
         if(!roleInfoView)
         {
            return;
         }
         var _loc3_:HeroRoleInfo = _info as HeroRoleInfo;
         if(_loc3_ && _loc3_.petLivingId != 0)
         {
            if(!_awakenShineMc)
            {
               _awakenShineMc = ComponentFactory.Instance.creatCustomObject("battle.BottomAwakenMc");
            }
            _awakenMc = _awakenShineMc["progressMc"] as MovieClip;
            _awakenShineMc.gotoAndStop(1);
            _loc4_ = Math.floor(_loc3_.awaken * 100 / awakenFullValue);
            _awakenMc.gotoAndStop(_loc4_);
            if(_stripView)
            {
               (_stripView.getView() as Sprite).addChild(_awakenShineMc);
            }
         }
         var _loc1_:String = PlayerManager.instance.currentPlayerModel.playerInfo.nickName;
         var _loc2_:int = PlayerManager.instance.currentPlayerModel.userInfo.userId;
         if(_loc1_ == _loc2_ + "$" || _loc1_ == LanguageMgr.GetTranslation("public.nickName"))
         {
            if(_info == BattleManager.getInstance().battleModel.selfHero)
            {
               heroNameTxt.text = LanguageMgr.GetTranslation("public.nickName");
               refreshNameView();
               return;
            }
         }
         heroNameTxt.text = (_info as HeroRoleInfo).heroInfo.nickName || LanguageMgr.GetTranslation("battle.view.roles.HeroRoleView.roleInfoView.nameTxt") + "！";
         refreshNameView();
         if(BattleManager.getInstance().battleModel.battleType == 35)
         {
            heroNameTxt.setFrame((_info as HeroRoleInfo).petRoleInfo.quality + 1);
         }
      }
      
      override public function updateShadowPos() : void
      {
         var _loc1_:DisplayObject = null;
         if(_disposed)
         {
            return;
         }
         if(!_info || !_info.actionMovie.movie || !_shade)
         {
            return;
         }
         if((_info as HeroRoleInfo).type != 3)
         {
            _loc1_ = _info.actionMovie.movie.pos_leg;
         }
         else
         {
            _loc1_ = _info.actionMovie.movie.pos_leg;
         }
         if(_loc1_)
         {
            _shade.x = _loc1_.x;
            _shade.y = _loc1_.y;
         }
         else
         {
            _shade.x = 0;
            _shade.y = 0;
         }
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         _info.addEventListener("sp",onHeroSpChanged);
         _info.addEventListener("AWAKEN",__onHeroAwakenChanged);
         _info.addEventListener("HIT_POINT",__onHeroHitPointChanged);
         _info.addEventListener("CHILD_CHANGE_VALUE",__onHeroAwakenChanged);
         _info.addEventListener("HIT_POINT",__onHeroHitPointChanged);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         if(_info)
         {
            _info.removeEventListener("sp",onHeroSpChanged);
            _info.removeEventListener("AWAKEN",__onHeroAwakenChanged);
            _info.removeEventListener("HIT_POINT",__onHeroHitPointChanged);
            _info.removeEventListener("CHILD_CHANGE_VALUE",__onHeroAwakenChanged);
            _info.removeEventListener("HIT_POINT",__onHeroHitPointChanged);
         }
      }
      
      private function onHeroSpChanged(param1:RoleEvent) : void
      {
         var _loc2_:HeroRoleInfo = _info as HeroRoleInfo;
         if(_loc2_ && param1.data.buffCause)
         {
            if(_readySkillTemp)
            {
               if(_loc2_.sp < _readySkillTemp.Cost)
               {
                  cancelReadyState();
               }
            }
         }
      }
      
      private function __onHeroAwakenChanged(param1:RoleEvent) : void
      {
         killAwakenTween();
         var _loc3_:HeroRoleInfo = _info as HeroRoleInfo;
         var _loc2_:int = Math.floor(_loc3_.awaken * 100 / awakenFullValue);
         if(_awakenMc)
         {
            _awakenTween = TweenLite.to(_awakenMc,0.5,{
               "frame":_loc2_,
               "onComplete":_awakenTweenComplete
            });
         }
      }
      
      private function __onHeroHitPointChanged(param1:RoleEvent) : void
      {
         var _loc2_:HeroRoleInfo = _info as HeroRoleInfo;
         if(_loc2_ && param1.data.buffCause)
         {
            if(_readySkillTemp)
            {
               if(_loc2_.hitPoint < _readySkillTemp.HitPointCost)
               {
                  cancelReadyState();
               }
            }
         }
      }
      
      private function killAwakenTween() : void
      {
         if(_awakenTween)
         {
            _awakenTween.kill();
            _awakenTween = null;
         }
      }
      
      private function _awakenTweenComplete() : void
      {
         killAwakenTween();
         if(!_info)
         {
            return;
         }
         if(!isSelf)
         {
            return;
         }
         if(!_awakenShineMc)
         {
            return;
         }
         var _loc1_:HeroRoleInfo = _info as HeroRoleInfo;
         if(_loc1_ && _loc1_.awaken >= awakenFullValue)
         {
            _awakenShineMc.gotoAndPlay(1);
         }
         else
         {
            _awakenShineMc.gotoAndStop(1);
         }
      }
      
      protected function get awakenFullValue() : int
      {
         if(_info && (_info as HeroRoleInfo).isChildFake)
         {
            return 100;
         }
         return 3000;
      }
      
      private function get isSelf() : Boolean
      {
         return _info && BattleManager.getInstance().battleModel.selfHero == _info;
      }
      
      public function changeBody() : void
      {
         if(!_info)
         {
            return;
         }
         var _loc1_:HeroRoleInfo = _info as HeroRoleInfo;
         if(!_loc1_)
         {
            return;
         }
         if(_loc1_ && _loc1_.isChildFake)
         {
            childChangeBody();
         }
         else
         {
            heroChangeBody();
         }
         _info.action("Stand");
         if(_movieContainer.numChildren > 0)
         {
            _movieContainer.removeChildAt(0);
         }
         if(_info.actionMovieClip)
         {
            _movieContainer.addChild(_info.actionMovieClip);
            layoutEffect();
            Helpers.getPos(HeroRoleInfo(_info).pos_head_hero,_info.actionMovieClip,"pos_body");
            Helpers.getPos(HeroRoleInfo(_info).pos_body_hero,_info.actionMovieClip,"pos_head");
            Helpers.getPos(HeroRoleInfo(_info).pos_leg_hero,_info.actionMovieClip,"pos_leg");
         }
      }
      
      private function heroChangeBody() : void
      {
         if((_info as HeroRoleInfo).isPetState)
         {
            if(_petMovie)
            {
               _petMovie.gotoAndStop(1);
               _info.actionMovieClip = _petMovie;
               isChangeBody = true;
            }
         }
         else if(_heroMovie && _heroMovie.getBodyMC())
         {
            _heroMovie.gotoAndStop(1);
            _info.actionMovieClip = _heroMovie;
            isChangeBody = false;
         }
      }
      
      private function childChangeBody() : void
      {
         if(_childChangeMovie && _childChangeMovie.parent)
         {
            _childChangeMovie.parent.removeChild(_childChangeMovie);
         }
         if((_info as HeroRoleInfo).isPetState)
         {
            if(_childChangeMovie && _movieContainer)
            {
               _childChangeMovie.play();
               _movieContainer.addChild(_childChangeMovie);
               if(_info.actionMovieClip && _info.actionMovieClip.hasOwnProperty("pos_leg") && _info.actionMovieClip["pos_leg"] != null)
               {
                  _childChangeMovie.x = _info.actionMovieClip["pos_leg"].x;
                  _childChangeMovie.y = _info.actionMovieClip["pos_leg"].y;
               }
               isChangeBody = true;
            }
         }
         else if(_heroMovie && _heroMovie.getBodyMC())
         {
            _heroMovie.gotoAndStop(1);
            _info.actionMovieClip = _heroMovie;
            isChangeBody = false;
         }
      }
      
      public function removeChildChangeEffect() : void
      {
         if(_childChangeMovie && _childChangeMovie.parent)
         {
            _childChangeMovie.parent.removeChild(_childChangeMovie);
         }
      }
      
      private function layoutEffect() : void
      {
         if(!_petMovie)
         {
            return;
         }
         if(!_heroMovie)
         {
            return;
         }
         var _loc4_:HeroRoleInfo = _info as HeroRoleInfo;
         var _loc1_:int = _petMovie.height;
         var _loc2_:int = _heroMovie.height;
         var _loc3_:int = _loc1_ - _loc2_;
      }
      
      override public function dispose() : void
      {
         killAwakenTween();
         ObjectUtils.disposeViolentMc(_petMovie);
         _petMovie = null;
         ObjectUtils.disposeObject(_heroMovie);
         _heroMovie = null;
         ObjectUtils.disposeObject(gameView);
         gameView = null;
         ObjectUtils.disposeViolentMc(_awakenShineMc);
         _awakenShineMc = null;
         ObjectUtils.disposeViolentMc(_awakenMc);
         _awakenMc = null;
         ObjectUtils.disposeViolentMc(_childChangeMovie);
         _childChangeMovie = null;
         ObjectUtils.disposeObject(_avengerEffect);
         _avengerEffect = null;
         if(_vocationEffect)
         {
            ObjectUtils.disposeObject(_vocationEffect);
            _vocationEffect = null;
         }
         if(_delaySetStateId > 0)
         {
            clearTimeout(_delaySetStateId);
         }
         super.dispose();
      }
   }
}

