package battle.view.roles
{
   import battle.BattleManager;
   import battle.data.GameLoadNeedData;
   import battle.view.GameView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.PetRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.manager.PathManager;
   import yishi.manager.SharedManager;
   
   public class PetRoleView extends RoleViewBase
   {
      
      private var _battleModel:BattleModel = BattleManager.getInstance().battleModel;
      
      private var gameView:GameView;
      
      private var petInfo:PetRoleInfo;
      
      private var _hBox:HBox = new HBox();
      
      public function PetRoleView(param1:RoleInfo)
      {
         petInfo = param1 as PetRoleInfo;
         _hBox.spacing = 2;
         addChild(_hBox);
         super(param1);
      }
      
      override public function load() : void
      {
         _displayMode = 1;
         if(!petInfo.template)
         {
            return;
         }
         if(!petInfo.heroRoleInfo)
         {
            return;
         }
         petInfo.heroRoleInfo.heroInfo.petTemplateId = petInfo.templateId;
         gameView = new GameView(false);
         gameView.onComplete = onPetPartComplete;
         gameView.data = HeroLoadDataFactory.create(petInfo.heroRoleInfo.heroInfo,"pet_follow",PathManager.isShowDragon(petInfo.heroRoleInfo.heroInfo));
         _movieContainer.addChild(_info.actionMovie);
         this.y = info.point.y - 80;
         if(_info.face == 2)
         {
            _movieContainer.scaleX = -1;
            this.x = 60 + info.point.x;
         }
         else
         {
            _movieContainer.scaleX = 1;
            this.x = -60 + info.point.x;
         }
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
            if(_heroNameTxt && _heroNameTxt.parent)
            {
               _heroNameTxt.parent.removeChild(_heroNameTxt);
            }
            if(_hBox)
            {
               _hBox.removeAllChild();
            }
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
            if(_heroNameTxt && !heroNameTxt.parent)
            {
               _roleInfoView.container.addChild(_heroNameTxt);
            }
            showStar(petInfo);
         }
         else if(!_info.startload)
         {
            if(battleModel.isHideOtherInBattle(info))
            {
               return;
            }
            _info.load();
            _displayMode = 1;
            if(_heroNameTxt && !heroNameTxt.parent)
            {
               _roleInfoView.container.addChild(_heroNameTxt);
            }
            showStar(petInfo);
         }
      }
      
      private function onPetPartComplete(param1:GameView) : void
      {
         if(!_battleModel)
         {
            return;
         }
         var _loc2_:GameLoadNeedData = param1.data as GameLoadNeedData;
         if(_info)
         {
            _info.actionMovieClip = MovieClip(param1.content);
            _info.actionMovie.soundTransform = SharedManager.instance.getSkillSoundTransform();
            _info.isLoadComplete = true;
            setShadeAndNamePos();
            _hBox.y = _heroNameTxt.y - 5;
         }
      }
      
      override protected function delayInitView() : void
      {
         if(_disposed)
         {
            return;
         }
         if(!_heroNameTxt)
         {
            _heroNameTxt = ComponentFactory.Instance.creatComponentByStylename("battle.PetNameTxt");
         }
         super.delayInitView();
         var _loc1_:BattleModel = BattleManager.getInstance().battleModel;
         if(_loc1_.battleType != 35 && petInfo.template.Property1 == 0)
         {
            _shade.visible = false;
         }
         _roleInfoView.visible = true;
         if(petInfo.name != null)
         {
            heroNameTxt.text = petInfo.name;
            if(_hBox)
            {
               _hBox.removeAllChild();
            }
            showStar(petInfo);
            if(petInfo.quality > 0)
            {
               heroNameTxt.setFrame(petInfo.quality);
            }
         }
         else
         {
            heroNameTxt.text = "";
         }
         setShadeAndNamePos();
         _hBox.y = _heroNameTxt.y - 5;
         if(_loc1_.isHideOtherInBattle(info))
         {
            if(_heroNameTxt && _heroNameTxt.parent)
            {
               _heroNameTxt.parent.removeChild(_heroNameTxt);
            }
            if(_hBox)
            {
               _hBox.removeAllChild();
            }
         }
      }
      
      private function setShadeAndNamePos() : void
      {
         var _loc4_:BattleModel = null;
         var _loc1_:Rectangle = null;
         var _loc2_:int = 0;
         if(!petInfo)
         {
            return;
         }
         if(!petInfo.template)
         {
            return;
         }
         if(petInfo.template.Property1 == 0)
         {
            return;
         }
         var _loc3_:MovieClip = petInfo.actionMovieClip;
         if(_loc3_)
         {
            _loc4_ = BattleManager.getInstance().battleModel;
            _loc1_ = _loc3_.getBounds(_loc3_);
            _loc2_ = petInfo.side == _loc4_.selfSide ? 1 : -1;
            if(_shade)
            {
               _shade.x = _loc2_ * (_loc1_.x + _loc1_.width / 2);
            }
            if(_roleInfoView)
            {
               _roleInfoView.x = _loc2_ * (_loc1_.x + _loc1_.width / 2);
            }
            if(_heroNameTxt)
            {
               _heroNameTxt.y = _loc1_.y - 37;
            }
            if(_hBox)
            {
               _hBox.x = _loc2_ * (_loc1_.x + (_loc1_.width - _hBox.width) / 2);
            }
         }
      }
      
      private function showStar(param1:PetRoleInfo) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Bitmap = null;
         if(_hBox)
         {
            _hBox.removeAllChild();
         }
         if(param1.template.NeedGrade == 3)
         {
            if(param1.quality == 6 && param1.temQuality == 31)
            {
               return;
            }
         }
         else if(param1.quality == 5 && param1.temQuality == 21)
         {
            return;
         }
         _loc2_ = param1.temQuality % 5 == 0 ? 5 : param1.temQuality % 5;
         if(param1.temQuality > 25)
         {
            _loc3_ = "asset.pet.smallMoonLightLevelImg";
         }
         else
         {
            _loc3_ = "asset.pet.smallStarLevelImg";
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = ComponentFactory.Instance.creatBitmap(_loc3_);
            _hBox.addChild(_loc5_);
            _loc4_++;
         }
      }
      
      override public function setRoleInfoViewVisible(param1:Boolean) : void
      {
         super.setRoleInfoViewVisible(param1);
         var _loc2_:BattleModel = BattleManager.getInstance().battleModel;
         if(_loc2_.battleType != 35)
         {
            setBloodStripVisible(false,true);
         }
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
         if(!_battleModel)
         {
            return;
         }
         if(_battleModel.isOver)
         {
            return;
         }
         if(!petInfo.template)
         {
            return;
         }
         if(petInfo.heroRoleInfo && petInfo.heroRoleInfo.isPetState)
         {
            petInfo.visible = false;
         }
         if(petInfo.template.Property1 == 0)
         {
            this.y = info.point.y - 80;
         }
         else
         {
            this.y = info.point.y;
         }
         if(_info.face == 2)
         {
            _movieContainer.scaleX = -1;
            this.x = 60 + info.point.x;
         }
         else
         {
            _movieContainer.scaleX = 1;
            this.x = -60 + info.point.x;
         }
      }
      
      override public function dispose() : void
      {
         if(gameView)
         {
            gameView.onComplete = null;
            gameView.dispose();
            gameView = null;
         }
         super.dispose();
         if(_hBox)
         {
            _hBox = null;
         }
         _battleModel = null;
      }
   }
}

