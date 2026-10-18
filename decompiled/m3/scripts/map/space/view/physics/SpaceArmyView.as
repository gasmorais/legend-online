package map.space.view.physics
{
   import avatar.data.AvatarStaticData;
   import avatar.view.AppellView;
   import avatar.view.Avatar;
   import avatar.view.ChildrenAvatarView;
   import avatar.view.HeroAvatar;
   import avatar.view.MonsterAvatarView;
   import avatar.view.PetAvatarView;
   import avatar.view.SimpleAvatarView;
   import chat.datas.ChatFactory;
   import com.pickgliss.loader.LoaderHeaderList;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import events.AppellEvent;
   import events.ArmyEvent;
   import events.ObjectsEvent;
   import events.PetEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import map.internals.constant.ArmyState;
   import map.internals.data.ArmyChildrenInfo;
   import map.internals.data.ArmyMonsterInfo;
   import map.internals.data.ArmyPetInfo;
   import map.internals.data.PhysicsEvent;
   import map.internals.utils.ArmySpeedUtils;
   import map.internals.view.hero.HeroAvatarView;
   import map.space.SpaceManager;
   import map.space.SpaceSceneController;
   import map.space.data.SpaceArmy;
   import map.space.mediator.hero.SpacePlayerWalkMediator;
   import mvc.module.armyII.BaseArmy;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.view.tools.SimpleMovie;
   
   public class SpaceArmyView extends HeroAvatarView
   {
      
      public static const DEFAULT_SPEED:int = 7;
      
      public static const HALF_SPEED:int = 4;
      
      public static const NAME:String = "map.space.view.physics.SpaceArmyView";
      
      private static const WALKSENDSERVER:int = 200;
      
      protected var _mediatorKey:String;
      
      protected var _data:SpaceArmy;
      
      protected var _consortiaTxt:FilterFrameText;
      
      protected var _honerTxt:GradientText;
      
      protected var _honerView:AppellView;
      
      protected var _vipIcon:Bitmap;
      
      protected var _vipText:GradientText;
      
      protected var _showNamePosY:Number = -125;
      
      protected var _chatPopView:Component;
      
      protected var _attackView:SimpleAvatarView;
      
      protected var _fateSkillEffect:SimpleAvatarView;
      
      protected var _isMounting:Boolean = false;
      
      protected var _isFlying:Boolean = false;
      
      protected var _appellId:int = 0;
      
      protected var _vocationIcon:ScaleFrameImage;
      
      protected var _petAvatarView:PetAvatarView;
      
      protected var _childrenAvatarView:ChildrenAvatarView;
      
      protected var _monsterAvatarView:MonsterAvatarView;
      
      protected var _regressIcon:Image;
      
      protected var _iconPosX:int;
      
      protected var _iconPosY:int;
      
      protected var _avengerEffect:MovieImage;
      
      protected var _controller:SpaceSceneController;
      
      private var _dragonTransferEffect:SimpleMovie;
      
      private var preEffectType:int;
      
      private var _walkedPointNum:int = 0;
      
      private var _offX:int;
      
      private var _offY:int;
      
      private var _currentPos:Point;
      
      public function SpaceArmyView()
      {
         super();
         _controller = SpaceManager.instance.controller as SpaceSceneController;
         initView();
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _npcName = ComponentFactory.Instance.creatComponentByStylename("core.NpcNameText");
         _consortiaTxt = ComponentFactory.Instance.creatComponentByStylename("map.campaign.ConsortiaText");
         _vipIcon = ComponentFactory.Instance.creatBitmap("asset.core.simpleVIPIcon");
         _vipText = ComponentFactory.Instance.creatComponentByStylename("core.NpcName_VipText");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("army.VocationIcon");
         _regressIcon = ComponentFactory.Instance.creatComponentByStylename("core.RegressIcon");
         _consortiaTxt.cacheAsBitmap = true;
         _vipText.cacheAsBitmap = true;
         _vocationIcon.visible = false;
         _regressIcon.visible = false;
         addChild(_npcName);
      }
      
      private function get isSelf() : Boolean
      {
         if(_data)
         {
            return _data.userId == playerInfo.userId;
         }
         return false;
      }
      
      private function get isSelfConsortia() : Boolean
      {
         if(_data && _data.baseHero)
         {
            if(StringHelper.isNullOrEmpty(_data.baseHero.consortiaName))
            {
               return false;
            }
            if(StringHelper.isNullOrEmpty(playerInfo.consortiaName))
            {
               return false;
            }
            return _data.baseHero.consortiaName == playerInfo.consortiaName;
         }
         return false;
      }
      
      private function showFateSkillEffect() : void
      {
         var _loc4_:int = 0;
      }
      
      public function lockTargetAndHideFate() : void
      {
         if(_fateSkillEffect && _fateSkillEffect.parent)
         {
            _fateSkillEffect.parent.removeChild(_fateSkillEffect);
         }
      }
      
      public function unlockTargetAndShowFate() : void
      {
         if(_fateSkillEffect && isPlaying)
         {
            addChildAt(_fateSkillEffect,0);
         }
      }
      
      public function set data(param1:SpaceArmy) : void
      {
         if(_data == param1)
         {
            return;
         }
         removeEvent();
         _data = param1;
         var _loc2_:Array = [];
         if(isSelf)
         {
            _loc2_.push(SpacePlayerWalkMediator);
         }
         addEvent();
         showAvatar(param1);
         showChildren(param1.childrenInfo);
         showPet(param1.petInfo);
         showMonster(param1.monsterInfo);
         __updateInfoHandler(null);
         __updateSpaceArmyStateHandler(null);
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc2_,this,"map.space.view.physics.SpaceArmyView");
      }
      
      public function showDragonTransferEffect() : void
      {
         _dragonTransferEffect = new SimpleMovie(ComponentFactory.Instance.creat("asset.map.DragonTransferEffect"));
         addChild(_dragonTransferEffect);
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         if(_data)
         {
            _data.addEventListener("CHAT_DATA",__chatHandler);
            _data.addEventListener("UPDATE_STATE",__updateSpaceArmyStateHandler);
            if(isSelf)
            {
               PlayerManager.instance.addEventListener("PET_LEVEL_UP",__petLevelUpHandler);
               thane.addEventListener("PLAYER_AVATA_CHANGE",__heroPropertyHandler);
               thane.addEventListener("PLAYER_INFO_UPDATE",__updateInfoHandler);
               thane.addEventListener("APPELL_CHANGE",__updateInfoHandler);
               thane.addEventListener("VOCATION_GRADES",__updateInfoHandler);
               thane.addEventListener("AVENGER_DEGREE_CHANGE",__updateInfoHandler);
            }
            else
            {
               _data.baseHero.addEventListener("PLAYER_AVATA_CHANGE",__avatarChangeHandler);
               _data.baseHero.addEventListener("PLAYER_INFO_UPDATE",__updateInfoHandler);
               _data.baseHero.addEventListener("APPELL_CHANGE",__updateInfoHandler);
               _data.baseHero.addEventListener("VOCATION_GRADES",__updateInfoHandler);
               _data.baseHero.addEventListener("AVENGER_DEGREE_CHANGE",__updateInfoHandler);
            }
            _data.petInfo.addEventListener("PETINFO_CHANGED",__updatePetAvatarHandler);
            _data.childrenInfo.addEventListener("CHILDRENINFO_CHANGED",__updateChildrenAvatarHandler);
            _data.monsterInfo.addEventListener("MONSTER_CHANGED",__updateMonsterAvatarHandler);
            NotificationManager.instance.addEventListener("APPELL_LOAD_COMPLETE",__appellLoadCompleteHandle);
         }
      }
      
      protected function __appellLoadCompleteHandle(param1:AppellEvent) : void
      {
         layoutTxtViewWithNamePosY();
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         PlayerManager.instance.removeEventListener("PET_LEVEL_UP",__petLevelUpHandler);
         if(_data)
         {
            _data.removeEventListener("CHAT_DATA",__chatHandler);
            _data.removeEventListener("UPDATE_STATE",__updateSpaceArmyStateHandler);
            if(isSelf)
            {
               thane.removeEventListener("PLAYER_AVATA_CHANGE",__heroPropertyHandler);
               thane.removeEventListener("PLAYER_INFO_UPDATE",__updateInfoHandler);
               thane.removeEventListener("APPELL_CHANGE",__updateInfoHandler);
               thane.removeEventListener("VOCATION_GRADES",__updateInfoHandler);
               thane.removeEventListener("AVENGER_DEGREE_CHANGE",__updateInfoHandler);
            }
            else
            {
               _data.baseHero.removeEventListener("PLAYER_AVATA_CHANGE",__avatarChangeHandler);
               _data.baseHero.removeEventListener("PLAYER_INFO_UPDATE",__updateInfoHandler);
               _data.baseHero.removeEventListener("APPELL_CHANGE",__updateInfoHandler);
               _data.baseHero.removeEventListener("VOCATION_GRADES",__updateInfoHandler);
               _data.baseHero.removeEventListener("AVENGER_DEGREE_CHANGE",__updateInfoHandler);
            }
            _data.petInfo.removeEventListener("PETINFO_CHANGED",__updatePetAvatarHandler);
            _data.childrenInfo.removeEventListener("CHILDRENINFO_CHANGED",__updateChildrenAvatarHandler);
            _data.monsterInfo.removeEventListener("MONSTER_CHANGED",__updateMonsterAvatarHandler);
            NotificationManager.instance.removeEventListener("APPELL_LOAD_COMPLETE",__appellLoadCompleteHandle);
         }
      }
      
      private function __updatePetAvatarHandler(param1:ArmyEvent) : void
      {
         showPet(param1.data as ArmyPetInfo);
         changePetFollowTarget();
      }
      
      private function __updateChildrenAvatarHandler(param1:ArmyEvent) : void
      {
         showChildren(param1.data as ArmyChildrenInfo);
         changePetFollowTarget();
      }
      
      private function __updateMonsterAvatarHandler(param1:ArmyEvent) : void
      {
         showMonster(param1.data as ArmyMonsterInfo);
         changePetFollowTarget();
      }
      
      private function changePetFollowTarget() : void
      {
         if(petAvatarView)
         {
            if(childrenAvatarView && petAvatarView.followType == 1)
            {
               petAvatarView.followTarget = childrenAvatarView;
            }
            else
            {
               petAvatarView.followTarget = this;
            }
         }
         if(_monsterAvatarView)
         {
            if(childrenAvatarView)
            {
               if(petAvatarView)
               {
                  if(petAvatarView.followType == 1)
                  {
                     _monsterAvatarView.followTarget = petAvatarView;
                  }
                  else if(petAvatarView.followType == 0)
                  {
                     _monsterAvatarView.followTarget = childrenAvatarView;
                  }
               }
               else
               {
                  _monsterAvatarView.followTarget = childrenAvatarView;
               }
            }
            else
            {
               _monsterAvatarView.followTarget = this;
            }
         }
      }
      
      override protected function showName(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         super.showName(param1,param2,param3,param4,param5);
         setHonerName();
         setConsortiaName(consortiaName,param5);
         setNpcName(param1,param5);
         refreshVocation();
         refreshRegress();
         isVip ? setVipIcon() : clearVipIcon();
         layoutTxtViewWithNamePosY();
      }
      
      private function setNpcName(param1:String, param2:int) : void
      {
         if(isSelf || isSelfConsortia)
         {
            _npcName.visible = true;
            _vipText.visible = false;
         }
         else if(isVip)
         {
            _npcName.visible = false;
            _vipText.visible = true;
         }
         else
         {
            _npcName.visible = true;
            _vipText.visible = false;
         }
         _vipText.text = _data.baseHero.nickName;
         _npcName.text = _data.baseHero.nickName;
         _npcName.setFrame(param2);
         addChild(_npcName);
         addChild(_vipText);
      }
      
      public function setConsortiaName(param1:String, param2:int, param3:Boolean = false) : void
      {
         if(StringHelper.isNullOrEmpty(param1))
         {
            _consortiaTxt.text = "";
            return;
         }
         _consortiaTxt.text = param3 ? param1 : LanguageMgr.GetTranslation("map.avatar.view.consortiaName",param1);
         _consortiaTxt.setFrame(param2);
         if(_isPlaying)
         {
            addChild(_consortiaTxt);
         }
      }
      
      private function get appellId() : int
      {
         if(!isSelf && _data)
         {
            return _data.baseHero.appellId;
         }
         return thane.appellId;
      }
      
      private function setHonerName() : void
      {
         if(_appellId == appellId && (_honerView && _honerView.parent || _honerTxt && _honerTxt.parent))
         {
            return;
         }
         _appellId = appellId;
         if(_honerTxt && _honerTxt.parent)
         {
            _honerTxt.parent.removeChild(_honerTxt);
         }
         ObjectUtils.disposeObject(_honerTxt);
         _honerTxt = null;
         if(_honerView && _honerView.parent)
         {
            _honerView.parent.removeChild(_honerView);
         }
         ObjectUtils.disposeObject(_honerView);
         _honerView = null;
         if(isHoner && _isPlaying)
         {
            _honerTxt = ComponentFactory.Instance.creatComponentByStylename(honerStyle);
            _honerTxt.cacheAsBitmap = true;
            _honerTxt.text = honerName;
            if(appellId > 0)
            {
               _honerView = new AppellView(_data.baseHero.appellInfo);
            }
            showHoner();
         }
      }
      
      private function showHoner() : void
      {
         if(VersionSwitch.APPELL)
         {
            if(_honerTxt && _honerTxt.parent)
            {
               _honerTxt.parent.removeChild(_honerTxt);
            }
            if(_honerView)
            {
               addChild(_honerView);
            }
         }
         else
         {
            if(_honerTxt)
            {
               addChild(_honerTxt);
            }
            if(_honerView && _honerView.parent)
            {
               _honerView.parent.removeChild(_honerView);
            }
         }
      }
      
      private function hideHoner() : void
      {
         if(_honerTxt && _honerTxt.parent)
         {
            _honerTxt.parent.removeChild(_honerTxt);
         }
         if(_honerView && _honerView.parent)
         {
            _honerView.parent.removeChild(_honerView);
         }
      }
      
      private function get honerStyle() : String
      {
         if(VersionSwitch.APPELL)
         {
            if(!_data.baseHero || !_data.baseHero.appellInfo)
            {
               return "map.campaign.HonerText";
            }
            return "map.campaign.HonerText" + _data.baseHero.appellInfo.Quality;
         }
         return "map.campaign.HonerText";
      }
      
      private function get honerName() : String
      {
         var _loc1_:String = "";
         if(VersionSwitch.APPELL)
         {
            _loc1_ = _data.baseHero.appellInfo ? _data.baseHero.appellInfo.Title : "";
         }
         else
         {
            _loc1_ = _data.baseHero.honerTemp ? _data.baseHero.honerTemp.TemplateName : "";
         }
         return _loc1_;
      }
      
      private function get isHoner() : Boolean
      {
         if(VersionSwitch.APPELL)
         {
            return _data.baseHero.appellId != 0;
         }
         return _data.baseHero.honer >= _data.baseHero.firstHonerTemp.Data;
      }
      
      private function refreshVocation() : void
      {
         if(!_data || !_data.baseHero || !_vocationIcon)
         {
            return;
         }
         if(_data.baseHero.vocationGrades > 0)
         {
            _vocationIcon.setFrame(_data.baseHero.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            _vocationIcon.visible = false;
         }
         if(_data.baseHero.avengerDegree > 0)
         {
            loadAvengerEffect();
         }
         else if(_avengerEffect)
         {
            _avengerEffect.visible = false;
         }
      }
      
      private function refreshRegress() : void
      {
         if(!_data || !_data.baseHero || !_regressIcon)
         {
            return;
         }
         if(_data.baseHero.isBackPlayer)
         {
            _regressIcon.visible = true;
         }
         else
         {
            _regressIcon.visible = false;
         }
      }
      
      private function loadAvengerEffect() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = int(isSelf ? thane.avengerDegree : int(_data.baseHero.avengerDegree));
         var _loc3_:int = Math.min(10,Math.ceil(_loc2_ / 2));
         if(preEffectType != _loc3_)
         {
            _loc1_ = ComponentSetting.getUISourcePath("avengereffect");
            LoaderManagerII.instance.load(_loc1_,3,0,completeHandler);
         }
         preEffectType = _loc3_;
      }
      
      private function completeHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:int = int(isSelf ? thane.avengerDegree : int(_data.baseHero.avengerDegree));
         var _loc4_:int = Math.min(10,Math.ceil(_loc3_ / 2));
         if(_avengerEffect && _avengerEffect.parent)
         {
            _avengerEffect.parent.removeChild(_avengerEffect);
         }
         ObjectUtils.disposeObject(_avengerEffect);
         _avengerEffect = null;
         _avengerEffect = ComponentFactory.Instance.creatComponentByStylename("core.avengerEffectfb" + _loc4_);
         addChild(_avengerEffect);
         _avengerEffect.movie.gotoAndPlay(1);
      }
      
      private function setVipIcon() : void
      {
         _vipIcon.visible = true;
      }
      
      private function clearVipIcon() : void
      {
         _vipIcon.visible = false;
      }
      
      private function get isVip() : Boolean
      {
         return _data.baseHero.IsVipAndNoExpirt;
      }
      
      private function get consortiaName() : String
      {
         if(isSelf)
         {
            return thane.consortiaName;
         }
         return _data.baseHero.consortiaName;
      }
      
      public function layoutTxtViewWithNamePosY() : void
      {
         var _loc2_:Number = NaN;
         if(!_data)
         {
            return;
         }
         _showNamePosY = -125;
         if(_avatar)
         {
            _showNamePosY = getPosYBySizeType(avatarView.sizeType,avatarView.flight);
         }
         if(_npcName)
         {
            _npcName.x = -_npcName.width / 2;
            _npcName.y = int(_showNamePosY);
         }
         if(_consortiaTxt)
         {
            _consortiaTxt.x = -_consortiaTxt.width / 2;
            _consortiaTxt.y = _showNamePosY - 20;
         }
         if(consortiaName && isPlaying)
         {
            if(_consortiaTxt && !_consortiaTxt.parent)
            {
               addChild(_consortiaTxt);
            }
         }
         else if(_consortiaTxt && _consortiaTxt.parent)
         {
            _consortiaTxt.parent.removeChild(_consortiaTxt);
         }
         var _loc1_:Number = _npcName.width - _npcName.textWidth >> 1;
         _iconPosX = _npcName.x + _loc1_ - 5;
         _iconPosY = _npcName.y;
         if(_vipIcon != null && _npcName != null)
         {
            _loc2_ = _vipIcon.width + _npcName.textWidth + 10;
            _vipIcon.y = _npcName.y;
            _vipIcon.x = -_loc2_ >> 1;
            if(isVip)
            {
               _npcName.x = _vipIcon.x + _vipIcon.width - _loc1_ + 1;
            }
            if(_vipText)
            {
               _vipText.x = _npcName.x + 10;
               _vipText.y = _npcName.y;
               _vipText.text = _npcName.text;
            }
            if(_vipIcon.visible)
            {
               _iconPosX = _vipIcon.x;
               _iconPosY = _vipIcon.y;
            }
         }
         if(_vocationIcon != null)
         {
            _vocationIcon.x = _iconPosX - _vocationIcon.width;
            _vocationIcon.y = _iconPosY - 4;
            if(_vocationIcon.visible)
            {
               _iconPosX = _vocationIcon.x;
            }
         }
         if(_regressIcon != null)
         {
            _regressIcon.x = _iconPosX - _regressIcon.width + 5;
            _regressIcon.y = _iconPosY - 9;
            if(_regressIcon.visible)
            {
               _iconPosX = _regressIcon.x;
            }
         }
         if(_avengerEffect != null)
         {
            if(avatarView && avatarView.flight < 0)
            {
               _avengerEffect.y = avatarView.flight;
            }
            else
            {
               _avengerEffect.y = 0;
            }
         }
         if(_honerView)
         {
            _honerView.x = -_honerView.appellWidth / 2;
            if(_data.baseHero.consortiaName)
            {
               _honerView.y = _showNamePosY - _honerView.appellHeight - 20;
            }
            else
            {
               _honerView.y = _showNamePosY - _honerView.appellHeight;
            }
         }
         if(_honerTxt)
         {
            _honerTxt.x = -_honerTxt.width / 2;
            if(_data.baseHero.consortiaName)
            {
               _honerTxt.y = _showNamePosY - 40;
            }
            else
            {
               _honerTxt.y = _showNamePosY - 20;
            }
         }
         if(_attackView)
         {
            _attackView.y = _showNamePosY - 90;
         }
      }
      
      override public function execute() : void
      {
         super.execute();
         if(_avatar)
         {
            if(_isStand)
            {
               (_avatar as HeroAvatar).stepFrame = 4;
            }
            else if(_isMounting)
            {
               (_avatar as HeroAvatar).stepFrame = 1;
            }
            else
            {
               (_avatar as HeroAvatar).stepFrame = 2;
            }
         }
         if(petAvatarView)
         {
            petAvatarView.execute();
         }
         if(childrenAvatarView)
         {
            childrenAvatarView.execute();
         }
         if(_monsterAvatarView)
         {
            _monsterAvatarView.execute();
         }
         if(isPlaying)
         {
            if(_attackView && _attackView.visible)
            {
               _attackView.draw();
            }
            if(_honerView && _honerView.visible)
            {
               _honerView.draw();
            }
            if(_fateSkillEffect && _fateSkillEffect.visible)
            {
               _fateSkillEffect.draw();
            }
         }
      }
      
      private function resetAlpha() : void
      {
         if(!SpaceManager.instance.model)
         {
            return;
         }
         if(!SpaceManager.instance.model.mapTielsData)
         {
            return;
         }
         var _loc1_:Boolean = Boolean(SpaceManager.instance.model.walkableValueIsPara(4,this.x / 20,this.y / 20));
         var _loc2_:Number = 1;
         if(!_isFlying)
         {
            _loc2_ = _loc1_ ? 0.5 : 1;
         }
         if(_avatar)
         {
            _avatar.alpha = _loc2_;
         }
      }
      
      public function stopWalkByOut() : void
      {
         nextWalk(new Point(_data.curPosX,_data.curPosY));
      }
      
      override protected function nextWalk(param1:Point) : void
      {
         _currentPos = this.getTilePos();
         _data.curPosX = _currentPos.x;
         _data.curPosY = _currentPos.y;
         super.nextWalk(param1);
      }
      
      override protected function playMovie() : void
      {
         super.playMovie();
         var _loc1_:Point = getTilePos();
         if(_loc1_.x != _currentPos.x || _loc1_.y != _currentPos.y)
         {
            _info.dispatchEvent(new ObjectsEvent("WALK_NEXT",{"point":_loc1_}));
            _currentPos = _loc1_;
            resetAlpha();
            changeLandEffect();
            _data.curPosX = _currentPos.x;
            _data.curPosY = _currentPos.y;
         }
      }
      
      private function changeLandEffect() : void
      {
         if(SpaceManager.instance.model.armyIsOnObstacle(this))
         {
            if(_fateSkillEffect && _fateSkillEffect.visible)
            {
               _fateSkillEffect.visible = false;
            }
            if(avatarView && !avatarView.noShadow)
            {
               avatarView.noShadow = true;
            }
         }
         else
         {
            if(_fateSkillEffect && !_fateSkillEffect.visible)
            {
               _fateSkillEffect.visible = true;
            }
            if(avatarView && avatarView.noShadow)
            {
               avatarView.noShadow = false;
            }
         }
      }
      
      override protected function newMove() : void
      {
         if(!isSelf)
         {
            SpaceManager.instance.model.moveToVisible(data);
         }
      }
      
      override protected function walkOver() : void
      {
         super.walkOver();
         resetAlpha();
         changeLandEffect();
      }
      
      private function __updateInfoHandler(param1:PlayerEvent) : void
      {
         var _loc2_:ThaneInfo = null;
         if(param1)
         {
            _loc2_ = param1.currentTarget as ThaneInfo;
            data.petInfo.petTemplateId = _loc2_.petTemplateId;
            data.petInfo.petName = _loc2_.petName;
            data.petInfo.petQuaity = _loc2_.petQuaity;
            data.petInfo.petTemQuality = _loc2_.temQuality;
            data.petInfo.commit();
            data.childrenInfo.childrenName = _loc2_.childrenName;
            data.childrenInfo.childrenJob = _loc2_.childrenJob;
            data.childrenInfo.childrenSex = _loc2_.childrenSex;
            data.childrenInfo.childrenGrade = _loc2_.childrenGrade;
            data.childrenInfo.growthGrade2 = _loc2_.growthGrade2;
            data.childrenInfo.commit();
            data.monsterInfo.monsterTemplateId = _loc2_.monsterTempteId;
            data.monsterInfo.commit();
         }
         var _loc3_:int = 2;
         if(isSelf)
         {
            _loc3_ = 1;
         }
         else if(isSelfConsortia)
         {
            _loc3_ = 3;
         }
         showName(_data.nickName,_data.baseHero.grades,_data.baseHero.state,0,_loc3_);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function showAvatar(param1:SpaceArmy) : void
      {
         var _loc16_:ThaneInfo = null;
         var _loc12_:MountTemplate = null;
         var _loc19_:String = null;
         var _loc14_:String = null;
         var _loc18_:String = null;
         var _loc15_:Object = null;
         var _loc10_:String = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc11_:int = 0;
         if(_isFlying)
         {
            aiInfo.pathInfo = [];
         }
         _isMounting = false;
         _isFlying = false;
         var _loc9_:BaseArmy = ArmyManager.instance.army;
         if(isSelf)
         {
            _loc16_ = thane;
            _loc12_ = _loc9_.mountTemplate;
            if(this.info)
            {
               this.info.speed = ArmySpeedUtils.getMoveSpeed(_loc9_);
            }
         }
         else
         {
            _loc16_ = param1.baseHero;
            if(param1.mountTemplate)
            {
               _loc16_.avatarChange["mount"] = true;
            }
            _loc12_ = param1.mountTemplate;
            if(this.info)
            {
               this.info.speed = ArmySpeedUtils.getMoveSpeed(param1);
            }
         }
         _isMounting = _loc12_ != null;
         var _loc17_:String = _loc16_.bodyEquipAvata;
         var _loc3_:String = _loc16_.armsEquipAvata;
         var _loc20_:int = int(_loc16_.changeShapeId);
         var _loc13_:Boolean = !_loc16_.hideFashion;
         if(!_loc16_.templateInfo)
         {
            return;
         }
         var _loc5_:int = int(_loc16_.templateInfo.Sexs);
         var _loc23_:int = int(_loc16_.templateInfo.Job);
         var _loc24_:String = _loc3_;
         var _loc7_:String = _loc17_;
         if(_loc17_ == "")
         {
            _loc17_ = JobType.getDefaultBodyEquipNameByJob(_loc23_);
         }
         if(_loc3_ == "")
         {
            _loc3_ = JobType.getDefaultArmysEquipNameByJob(_loc23_);
         }
         if(_loc17_.indexOf(PathManager.DRAGONIC) != -1)
         {
            _loc19_ = JobType.getDefaultHairUpByJob(4);
            _loc14_ = JobType.getDefaultHairDownByJob(4);
            _loc18_ = JobType.getDefaultCloakEquipNameByJob(4);
         }
         else
         {
            _loc19_ = JobType.getDefaultHairUpByJob(_loc23_);
            _loc14_ = JobType.getDefaultHairDownByJob(_loc23_);
            _loc18_ = JobType.getDefaultCloakEquipNameByJob(_loc23_);
         }
         var _loc6_:String = _loc16_.wingAvata;
         var _loc21_:String = _loc12_ ? _loc12_.AvatarPath : "";
         var _loc8_:int = isSelf ? 10 : 4;
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
         if(_loc20_ > 0)
         {
            if(!avatarView)
            {
               avatarView = new HeroAvatar(true,_loc17_,2,_loc5_,true,_loc23_);
            }
            avatarView.currentMountId = _loc12_ ? _loc12_.TemplateId : -1;
            _loc17_ = _loc20_ + "";
            avatarView.type = 2;
            _loc3_ = "";
            avatarView.removeAllAvatar();
            _loc10_ = PathManager.getAvatarResourcePath(_loc17_,_loc5_,1,"body",_loc23_,2);
            _loc15_ = createResourceLoadInfo(_loc10_,[0,0,0,0,0],[0,0,0],"body");
            LoaderManagerII.instance.load(_loc10_,4,_loc8_,loaderCompleteHandler,null,null,_loc15_);
            return;
         }
         if(!avatarView)
         {
            avatarView = new HeroAvatar(true,_loc17_,1,_loc5_,true,_loc23_);
         }
         avatarView.currentMountId = _loc12_ ? _loc12_.TemplateId : -1;
         avatarView.type = 1;
         for(var _loc22_:String in _loc16_.avatarChange)
         {
            avatarView.removeAvatar(_loc22_);
         }
         _loc2_ = 1;
         _loc4_ = 1;
         _loc11_ = 1;
         if(_loc13_)
         {
            if(_loc16_.bodyFashionAvata)
            {
               _loc17_ = _loc16_.bodyFashionAvata;
               _loc18_ = "";
               _loc2_ = 2;
            }
            if(_loc16_.armsFashionAvata)
            {
               _loc3_ = _loc16_.armsFashionAvata;
               _loc4_ = 2;
            }
            if(_loc16_.hairFashionAvata)
            {
               _loc19_ = _loc16_.hairFashionAvata + "up";
               _loc14_ = _loc16_.hairFashionAvata + "down";
               _loc11_ = 2;
            }
         }
         if(_isMounting)
         {
            (avatarView as HeroAvatar).isStandPosMount = _loc12_.useStandPose;
            if(!_loc12_.useStandPose)
            {
               _loc17_ = JobType.getMapMountEquipment(_loc17_);
               _loc3_ = JobType.getMapMountEquipment(_loc3_);
               _loc19_ = JobType.getMapMountEquipment(_loc19_);
               _loc14_ = JobType.getMapMountEquipment(_loc14_);
               _loc18_ = JobType.getMapMountEquipment(_loc18_);
               _loc6_ = JobType.getMapMountEquipment(_loc6_);
            }
            if(!_loc21_)
            {
               _loc21_ = JobType.getDefaultMount();
            }
            _isFlying = SpaceManager.instance.model.isFlying(_data.mountTemplateId);
         }
         else
         {
            (avatarView as HeroAvatar).isStandPosMount = false;
         }
         if(_loc6_)
         {
            _loc10_ = PathManager.getAvatarResourcePath(_loc6_,_loc5_,1,"wing",_loc23_,1);
            _loc15_ = createResourceLoadInfo(_loc10_,AvatarStaticData.getBaseNumByType("Stand","wing",_isMounting),AvatarStaticData.getBaseNumByType("Walk","wing",_isMounting),"wing");
            LoaderManagerII.instance.load(_loc10_,4,_loc8_,loaderCompleteHandler,null,null,_loc15_);
         }
         else if(_loc18_)
         {
            _loc10_ = PathManager.getAvatarResourcePath(_loc18_,_loc5_,1,"cloak",_loc23_,1);
            _loc15_ = createResourceLoadInfo(_loc10_,AvatarStaticData.getBaseNumByType("Stand","cloak",_isMounting),AvatarStaticData.getBaseNumByType("Walk","cloak",_isMounting),"cloak");
            LoaderManagerII.instance.load(_loc10_,4,_loc8_,loaderCompleteHandler,null,null,_loc15_);
         }
         if(_loc14_)
         {
            _loc10_ = PathManager.getAvatarResourcePath(_loc14_,_loc5_,_loc11_,"hairDown",_loc23_,1);
            _loc15_ = createResourceLoadInfo(_loc10_,AvatarStaticData.getBaseNumByType("Stand","hairDown",_isMounting),AvatarStaticData.getBaseNumByType("Walk","hairDown",_isMounting),"hairDown");
            LoaderManagerII.instance.load(_loc10_,4,_loc8_,loaderCompleteHandler,null,null,_loc15_);
         }
         if(_loc19_)
         {
            _loc10_ = PathManager.getAvatarResourcePath(_loc19_,_loc5_,_loc11_,"hairUp",_loc23_,1);
            _loc15_ = createResourceLoadInfo(_loc10_,AvatarStaticData.getBaseNumByType("Stand","hairUp",_isMounting),AvatarStaticData.getBaseNumByType("Walk","hairUp",_isMounting),"hairUp");
            LoaderManagerII.instance.load(_loc10_,4,_loc8_,loaderCompleteHandler,null,null,_loc15_);
         }
         if(_loc3_)
         {
            _loc10_ = PathManager.getAvatarResourcePath(_loc3_,_loc5_,_loc4_,"army",_loc23_,1);
            _loc15_ = createResourceLoadInfo(_loc10_,AvatarStaticData.getBaseNumByType("Stand","army",_isMounting),AvatarStaticData.getBaseNumByType("Walk","army",_isMounting),"army");
            LoaderManagerII.instance.load(_loc10_,4,_loc8_,loaderCompleteHandler,null,null,_loc15_);
         }
         if(_loc17_)
         {
            _loc10_ = PathManager.getAvatarResourcePath(_loc17_,_loc5_,_loc2_,"body",_loc23_,1);
            _loc15_ = createResourceLoadInfo(_loc10_,AvatarStaticData.getBaseNumByType("Stand","body",_isMounting),AvatarStaticData.getBaseNumByType("Walk","body",_isMounting),"body");
            LoaderManagerII.instance.load(_loc10_,4,_loc8_,loaderCompleteHandler,null,null,_loc15_);
         }
         if(_loc21_)
         {
            _loc10_ = PathManager.getAvatarResourcePath(_loc21_,_loc5_,1,"mount",_loc23_,1);
            _loc15_ = createResourceLoadInfo(_loc10_,AvatarStaticData.getBaseNumByType("Stand","mount",_isMounting),AvatarStaticData.getBaseNumByType("Walk","mount",_isMounting),"mount");
            LoaderManagerII.instance.load(_loc10_,4,_loc8_,loaderCompleteHandler,null,null,_loc15_);
         }
         avatarView.mouseChildren = false;
         avatarView.mouseEnabled = false;
         if(_isMounting && Boolean(_loc12_.hasEffectFoot))
         {
            avatarView.footPrintLayer = SpaceManager.instance.mapView.footLayer;
         }
         else
         {
            avatarView.footPrintLayer = null;
         }
         avatarView.showMountShadow = _isMounting;
         resetAlpha();
         if(childrenAvatarView)
         {
            childrenAvatarView.isFlying = isFlying;
         }
      }
      
      private function showPet(param1:ArmyPetInfo) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc4_:int = 0;
         if(!param1.petTemplate)
         {
            if(_petAvatarView)
            {
               _petAvatarView.dispose();
               _petAvatarView = null;
            }
            return;
         }
         _loc3_ = param1.petTemplate.PetAvatar;
         if(_loc3_)
         {
            if(!petAvatarView)
            {
               petAvatarView = new PetAvatarView();
            }
         }
         else
         {
            petAvatarView = null;
         }
         if(petAvatarView)
         {
            petAvatarView.isSelf = this.isSelf;
            petAvatarView.changeFollowType(param1.petTemplate);
            if(childrenAvatarView && petAvatarView.followType == 1)
            {
               petAvatarView.followTarget = childrenAvatarView;
            }
            else
            {
               petAvatarView.followTarget = this;
            }
            if(isPlaying)
            {
               if(petAvatarView.followType == 1)
               {
                  if(_petAvatarView.parent != SpaceManager.instance.mapView.walkLayer)
                  {
                     SpaceManager.instance.mapView.walkLayer.addChild(_petAvatarView);
                     initPetPos();
                  }
               }
               else
               {
                  addChild(petAvatarView);
               }
            }
            _loc4_ = 1;
            _loc2_ = param1.petName ? param1.petName : "";
            if(param1.petQuaity > 0)
            {
               _loc4_ = int(param1.petTemQuality);
            }
            petAvatarView.showAvatar(_loc2_,param1,_loc3_);
         }
      }
      
      private function showMonster(param1:ArmyMonsterInfo) : void
      {
         var _loc2_:String = null;
         if(VersionSwitch.MONSTER_FOLLOW)
         {
            if(!param1.monsterTemplate)
            {
               if(_monsterAvatarView)
               {
                  _monsterAvatarView.dispose();
                  _monsterAvatarView = null;
               }
               return;
            }
            _loc2_ = param1.monsterTemplate.ResType.toString();
            if(_loc2_)
            {
               if(!_monsterAvatarView)
               {
                  _monsterAvatarView = new MonsterAvatarView();
               }
            }
            else
            {
               _monsterAvatarView = null;
            }
            if(_monsterAvatarView)
            {
               if(childrenAvatarView)
               {
                  if(petAvatarView)
                  {
                     if(petAvatarView.followType == 1)
                     {
                        _monsterAvatarView.followTarget = petAvatarView;
                     }
                     else if(petAvatarView.followType == 0)
                     {
                        _monsterAvatarView.followTarget = childrenAvatarView;
                     }
                  }
                  else
                  {
                     _monsterAvatarView.followTarget = childrenAvatarView;
                  }
               }
               else
               {
                  _monsterAvatarView.followTarget = this;
               }
               if(isPlaying)
               {
                  if(_monsterAvatarView.parent != SpaceManager.instance.mapView.walkLayer)
                  {
                     SpaceManager.instance.mapView.walkLayer.addChild(_monsterAvatarView);
                     initMonsterPos();
                  }
                  _monsterAvatarView.setName(param1.monsterTemplate.Name);
                  _monsterAvatarView.refreshAvatarView(_loc2_);
               }
            }
         }
      }
      
      public function initMonsterPos() : void
      {
         if(!_monsterAvatarView)
         {
            return;
         }
         if(!data)
         {
            return;
         }
         var _loc1_:int = -1;
         if(avatarView)
         {
            _loc1_ = -(avatarView as HeroAvatar).mirror;
         }
         _monsterAvatarView.x = data.curPosX * 20 + _loc1_ * 100;
         _monsterAvatarView.y = data.curPosY * 20;
      }
      
      private function addPetToStage() : void
      {
         if(petAvatarView.followType == 1)
         {
            if(_petAvatarView.parent != SpaceManager.instance.mapView.walkLayer)
            {
               SpaceManager.instance.mapView.walkLayer.addChild(_petAvatarView);
            }
         }
         else
         {
            addChild(petAvatarView);
         }
      }
      
      public function initPetPos() : void
      {
         if(!petAvatarView)
         {
            return;
         }
         if(petAvatarView.followType != 1)
         {
            return;
         }
         if(!data)
         {
            return;
         }
         var _loc1_:int = -1;
         if(avatarView)
         {
            _loc1_ = -(avatarView as HeroAvatar).mirror;
         }
         petAvatarView.x = data.curPosX * 20 + _loc1_ * 100;
         petAvatarView.y = data.curPosY * 20;
      }
      
      private function showChildren(param1:ArmyChildrenInfo) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(param1.childrenJob == 0 && param1.childrenSex == 0)
         {
            if(_childrenAvatarView)
            {
               _childrenAvatarView.dispose();
               _childrenAvatarView = null;
            }
            return;
         }
         var _loc5_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(param1.childrenJob,param1.childrenGrade);
         _loc2_ = _loc5_.ResPath;
         if(_loc2_)
         {
            if(!childrenAvatarView)
            {
               childrenAvatarView = new ChildrenAvatarView();
            }
         }
         else
         {
            childrenAvatarView = null;
         }
         if(childrenAvatarView)
         {
            childrenAvatarView.isFlying = isFlying;
            childrenAvatarView.isSelf = this.isSelf;
            childrenAvatarView.followTarget = this;
            if(isPlaying)
            {
               if(_childrenAvatarView.parent != SpaceManager.instance.mapView.walkLayer)
               {
                  SpaceManager.instance.mapView.walkLayer.addChild(_childrenAvatarView);
                  initChildrenPos();
               }
            }
            _loc4_ = 1;
            _loc3_ = param1.childrenName ? param1.childrenName : "";
            childrenAvatarView.showAvatar(_loc3_,_loc4_,_loc2_,param1.childrenGrade,param1.growthGrade2);
         }
      }
      
      private function addChildrenToStage() : void
      {
         if(_childrenAvatarView.parent != SpaceManager.instance.mapView.walkLayer)
         {
            SpaceManager.instance.mapView.walkLayer.addChild(_childrenAvatarView);
         }
      }
      
      private function addMonsterToStage() : void
      {
         if(_monsterAvatarView.parent != SpaceManager.instance.mapView.walkLayer)
         {
            SpaceManager.instance.mapView.walkLayer.addChild(_monsterAvatarView);
         }
      }
      
      public function initChildrenPos() : void
      {
         if(!childrenAvatarView)
         {
            return;
         }
         if(!data)
         {
            return;
         }
         var _loc1_:int = -1;
         if(avatarView)
         {
            _loc1_ = -(avatarView as HeroAvatar).mirror;
         }
         childrenAvatarView.x = data.curPosX * 20 + _loc1_ * 100;
         childrenAvatarView.y = data.curPosY * 20;
      }
      
      override public function set avatarView(param1:Avatar) : void
      {
         if(_avatar)
         {
            _avatar.removeEventListener("sizeTypeChange",__onSizeTypeChangeHandler);
         }
         if(_avatar)
         {
            if(_avatar.parent)
            {
               _avatar.parent.removeChild(_avatar);
            }
            _avatar.dispose();
         }
         _avatar = null;
         _avatar = param1;
         (_avatar as HeroAvatar).isShowWeapons = true;
         _avatar.angle = 2;
         if(data.isRobot)
         {
            _avatar.angle = int(Math.random() * 360);
         }
         if(_isPlaying)
         {
            addChild(_avatar);
         }
         if(_petAvatarView && _petAvatarView.parent == this)
         {
            addChild(_petAvatarView);
         }
         if(_childrenAvatarView && _childrenAvatarView.parent == this)
         {
            addChild(_childrenAvatarView);
         }
         if(_monsterAvatarView && _monsterAvatarView.parent == this && VersionSwitch.MONSTER_FOLLOW)
         {
            addChild(_monsterAvatarView);
         }
         showHoner();
         _consortiaTxt && addChild(_consortiaTxt);
         _npcName && addChild(_npcName);
         _vipIcon && addChild(_vipIcon);
         _vipText && addChild(_vipText);
         _vocationIcon && addChild(_vocationIcon);
         _regressIcon && addChild(_regressIcon);
         if(_avengerEffect && !this.contains(_avengerEffect))
         {
            addChild(_avengerEffect);
         }
         param1.addEventListener("sizeTypeChange",__onSizeTypeChangeHandler);
      }
      
      override public function getCurrentPixels() : int
      {
         if(_avatar)
         {
            return (_avatar as HeroAvatar).getCurrentPixels();
         }
         return 0;
      }
      
      private function __onSizeTypeChangeHandler(param1:Event) : void
      {
         layoutTxtViewWithNamePosY();
      }
      
      override protected function loaderCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(_avatar)
         {
            (_avatar as HeroAvatar).loaderCompleteHandler(param1.args as ResourceLoaderInfo,param2);
         }
         if(param1.url.indexOf("body") >= 0)
         {
            layouTextView(param1.url);
         }
      }
      
      private function layouTextView(param1:String) : void
      {
         if(!_npcName)
         {
            return;
         }
         var _loc2_:Object = LoaderHeaderList.avatarShowNamePos[param1];
         if(_loc2_ && _loc2_.showNamePosY)
         {
            _showNamePosY = _loc2_.showNamePosY;
         }
         else
         {
            _showNamePosY = -110;
         }
         layoutTxtViewWithNamePosY();
      }
      
      protected function __heroPropertyHandler(param1:PlayerEvent) : void
      {
         if(!_data || !_data.baseHero || !SpaceManager.instance.model)
         {
            return;
         }
         var _loc2_:SpaceArmy = SpaceManager.instance.model.getUserArmyByUserId(_data.baseHero.userId);
         if(!_loc2_)
         {
            return;
         }
         _loc2_.baseHero.hideFashion = thane.hideFashion;
         _loc2_.baseHero.changeShapeId = thane.changeShapeId;
         _loc2_.baseHero.bodyEquipAvata = thane.bodyEquipAvata;
         _loc2_.baseHero.armsEquipAvata = thane.armsEquipAvata;
         if(_loc2_.baseHero.wingAvata != thane.wingAvata)
         {
            _loc2_.baseHero.wingAvata = thane.wingAvata;
         }
         _loc2_.baseHero.bodyFashionAvata = thane.bodyFashionAvata;
         _loc2_.baseHero.armsFashionAvata = thane.armsFashionAvata;
         _loc2_.baseHero.hairFashionAvata = thane.hairFashionAvata;
         _loc2_.mountTemplateId = ArmyManager.instance.army.mountTemplateId;
         avatarView.angle += 1;
         showAvatar(_data);
      }
      
      private function __avatarChangeHandler(param1:PlayerEvent) : void
      {
         showAvatar(_data);
      }
      
      private function get state() : int
      {
         if(isSelf)
         {
            return SpaceManager.instance.model.selfArmy.state;
         }
         return _data.state;
      }
      
      public function __updateSpaceArmyStateHandler(param1:ArmyEvent) : void
      {
         if(!ArmyState.checkCampaignAttack(state))
         {
            this.info.pathInfo = [];
            setFireView();
            return;
         }
         clearFireView();
      }
      
      protected function setFireView() : void
      {
         if(!_attackView)
         {
            _attackView = new SimpleAvatarView(110,110,PathManager.fightStatePath,10);
         }
         _attackView.drawFrame = 2;
         addChild(_attackView);
         _attackView.x = -55;
         _attackView.y = _showNamePosY - 90;
         _npcName && addChild(_npcName);
         _consortiaTxt && addChild(_consortiaTxt);
         showHoner();
         _vipIcon && addChild(_vipIcon);
         _vipText && addChild(_vipText);
         _chatPopView && addChild(_chatPopView);
         _vocationIcon && addChild(_vocationIcon);
         _regressIcon && addChild(_regressIcon);
         if(_avengerEffect && !this.contains(_avengerEffect))
         {
            addChild(_avengerEffect);
         }
      }
      
      protected function clearFireView() : void
      {
         ObjectUtils.disposeObject(_attackView);
         _attackView = null;
      }
      
      public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:SpaceArmyView = null;
         if(_data.baseHero.userId == selfUserId)
         {
            return false;
         }
         if(_avatar)
         {
            if((_avatar as HeroAvatar).getCurrentPixels() > 50)
            {
               PlayerManager.instance.currentPlayerModel.selectTarget = _data;
               PlayerManager.instance.currentPlayerModel.reinforce = _data;
               return true;
            }
            _loc2_ = StageReferance.stage.getObjectsUnderPoint(new Point(StageReferance.stage.mouseX,StageReferance.stage.mouseY));
            if(_loc2_[0])
            {
               _loc4_ = _loc2_.length - 2;
               while(_loc4_ >= 0)
               {
                  if(_loc2_[_loc4_].parent is HeroAvatar && _loc2_[_loc4_].parent.parent is SpaceArmyView)
                  {
                     _loc3_ = _loc2_[_loc4_].parent.parent;
                     if(_loc3_.getCurrentPixels() > 50)
                     {
                        if(_loc3_.data.baseHero.userId != selfUserId)
                        {
                           if(_loc3_.mouseEnabled)
                           {
                              PlayerManager.instance.currentPlayerModel.selectTarget = _loc3_.data;
                              PlayerManager.instance.currentPlayerModel.reinforce = _loc3_.data;
                              return true;
                           }
                        }
                     }
                  }
                  _loc4_--;
               }
            }
         }
         return false;
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:SpaceArmyView = null;
         if(_data.baseHero.userId == selfUserId)
         {
            this.buttonMode = false;
            this.mouseChildren = this.mouseEnabled = false;
            return false;
         }
         if(_avatar)
         {
            if(!param1)
            {
               SpaceManager.instance.model.glowTarget = this;
               return true;
            }
            if((_avatar as HeroAvatar).getCurrentPixels() > 50)
            {
               SpaceManager.instance.model.glowTarget = this;
               return true;
            }
            _loc2_ = StageReferance.stage.getObjectsUnderPoint(new Point(StageReferance.stage.mouseX,StageReferance.stage.mouseY));
            if(_loc2_[0])
            {
               _loc4_ = _loc2_.length - 2;
               while(_loc4_ >= 0)
               {
                  if(_loc2_[_loc4_].parent is HeroAvatar && _loc2_[_loc4_].parent.parent is SpaceArmyView)
                  {
                     _loc3_ = _loc2_[_loc4_].parent.parent;
                     if(_loc3_.getCurrentPixels() > 50)
                     {
                        if(_loc3_.data.baseHero.userId != selfUserId)
                        {
                           if(_loc3_.mouseEnabled)
                           {
                              SpaceManager.instance.model.glowTarget = _loc3_;
                              return true;
                           }
                        }
                     }
                  }
                  _loc4_--;
               }
            }
         }
         return false;
      }
      
      public function setGlowFilter() : void
      {
         if(_avatar && _filter)
         {
            _filter.setGlowFilter(_avatar.contentBitmap);
         }
      }
      
      public function setNormalFilter() : void
      {
         if(_avatar && _filter)
         {
            _filter.setNormalFilter(_avatar.contentBitmap);
         }
      }
      
      private function get selfUserId() : int
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.userId;
      }
      
      private function get checkUserId() : Boolean
      {
         if(!_data)
         {
            return false;
         }
         return _data.userId == playerInfo.userId || _data.userId == MarryManager.instance.model.selfMarryInfo.userId;
      }
      
      private function __chatHandler(param1:PhysicsEvent) : void
      {
         if(MarryManager.instance.model.lockScreen && checkUserId)
         {
            return;
         }
         if(_data.chatData == null)
         {
            if(_chatPopView)
            {
               _chatPopView.dispose();
            }
            _chatPopView = null;
         }
         if(_chatPopView)
         {
            _chatPopView.dispose();
            _chatPopView = null;
         }
         if(!_chatPopView)
         {
            _chatPopView = ChatFactory.createChatPopByType(_data.chatData,chatBack);
            _chatPopView.x = -90;
            if(_npcName)
            {
               _chatPopView.y = _npcName.y + 20 - _chatPopView.displayHeight;
            }
            else
            {
               _chatPopView.y = -100 - _chatPopView.displayHeight;
            }
            if(_isPlaying)
            {
               addChild(_chatPopView);
               if(_npcName)
               {
                  addChild(_npcName);
               }
               if(_vipIcon)
               {
                  addChild(_vipIcon);
               }
               if(_vipText)
               {
                  addChild(_vipText);
               }
               if(_vocationIcon)
               {
                  addChild(_vocationIcon);
               }
               if(_regressIcon)
               {
                  addChild(_regressIcon);
               }
               if(_avengerEffect && !this.contains(_avengerEffect))
               {
                  addChild(_avengerEffect);
               }
            }
         }
      }
      
      private function chatBack() : void
      {
         _chatPopView = null;
      }
      
      override public function set isPlaying(param1:Boolean) : void
      {
         if(_isPlaying == param1)
         {
            return;
         }
         _isPlaying = param1;
         if(petAvatarView)
         {
            petAvatarView.isPlaying = param1;
         }
         if(childrenAvatarView)
         {
            childrenAvatarView.isPlaying = param1;
         }
         if(_monsterAvatarView)
         {
            _monsterAvatarView.isPlaying = param1;
         }
         if(param1)
         {
            if(_petAvatarView)
            {
               addPetToStage();
            }
            if(_childrenAvatarView)
            {
               addChildrenToStage();
            }
            if(_monsterAvatarView && VersionSwitch.MONSTER_FOLLOW)
            {
               addMonsterToStage();
            }
            if(_avatar)
            {
               addChildAt(_avatar,0);
            }
            if(_fateSkillEffect)
            {
               addChildAt(_fateSkillEffect,0);
            }
            if(_consortiaTxt)
            {
               addChild(_consortiaTxt);
            }
            showHoner();
            if(_vocationIcon)
            {
               addChild(_vocationIcon);
            }
            if(_regressIcon)
            {
               addChild(_regressIcon);
            }
            if(_avengerEffect && !this.contains(_avengerEffect))
            {
               addChild(_avengerEffect);
            }
            if(_chatPopView)
            {
               addChild(_chatPopView);
            }
            __updateSpaceArmyStateHandler(null);
         }
         else
         {
            if(_petAvatarView && _petAvatarView.parent)
            {
               _petAvatarView.parent.removeChild(_petAvatarView);
            }
            if(_childrenAvatarView && _childrenAvatarView.parent)
            {
               _childrenAvatarView.parent.removeChild(_childrenAvatarView);
            }
            if(_monsterAvatarView && _monsterAvatarView.parent)
            {
               _monsterAvatarView.parent.removeChild(_monsterAvatarView);
            }
            if(_avatar && _avatar.parent)
            {
               _avatar.parent.removeChild(_avatar);
            }
            if(_fateSkillEffect && _fateSkillEffect.parent)
            {
               _fateSkillEffect.parent.removeChild(_fateSkillEffect);
            }
            if(_consortiaTxt && _consortiaTxt.parent)
            {
               _consortiaTxt.parent.removeChild(_consortiaTxt);
            }
            hideHoner();
            if(_vocationIcon && _vocationIcon.parent)
            {
               _vocationIcon.parent.removeChild(_vocationIcon);
            }
            if(_regressIcon && _regressIcon.parent)
            {
               _regressIcon.parent.removeChild(_regressIcon);
            }
            if(_avengerEffect && _avengerEffect.parent)
            {
               _avengerEffect.parent.removeChild(_avengerEffect);
            }
            if(_chatPopView && _chatPopView.parent)
            {
               _chatPopView.parent.removeChild(_chatPopView);
            }
            clearFireView();
         }
      }
      
      public function get data() : SpaceArmy
      {
         return _data;
      }
      
      public function get aiInfo() : BaseArmyAiInfo
      {
         return _info as BaseArmyAiInfo;
      }
      
      private function __petLevelUpHandler(param1:PetEvent) : void
      {
         if(petAvatarView)
         {
            petAvatarView.playPetLevelUpMovie();
         }
      }
      
      public function get petAvatarView() : PetAvatarView
      {
         return _petAvatarView;
      }
      
      public function set petAvatarView(param1:PetAvatarView) : void
      {
         if(_petAvatarView)
         {
            _petAvatarView.dispose();
         }
         _petAvatarView = param1;
      }
      
      public function get childrenAvatarView() : ChildrenAvatarView
      {
         return _childrenAvatarView;
      }
      
      public function set childrenAvatarView(param1:ChildrenAvatarView) : void
      {
         if(_childrenAvatarView)
         {
            _childrenAvatarView.dispose();
         }
         _childrenAvatarView = param1;
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
         removeEvent();
         if(_controller)
         {
            _controller.removeArmyView(this);
            _controller = null;
         }
         if(isSelf)
         {
            _data.curPosX = int(this.x / 20);
            _data.curPosY = int(this.y / 20);
         }
         if(_avatar)
         {
            _avatar.removeEventListener("sizeTypeChange",__onSizeTypeChangeHandler);
         }
         if(_data)
         {
            _data.armyView = null;
         }
         if(isDie)
         {
            return;
         }
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         _data = null;
         if(_petAvatarView)
         {
            _petAvatarView.dispose();
            _petAvatarView = null;
         }
         if(_childrenAvatarView)
         {
            _childrenAvatarView.dispose();
            _childrenAvatarView = null;
         }
         if(_monsterAvatarView)
         {
            _monsterAvatarView.dispose();
            _monsterAvatarView = null;
         }
         clearFireView();
         ObjectUtils.disposeObject(_honerTxt);
         _honerTxt = null;
         ObjectUtils.disposeObject(_honerView);
         _honerView = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_vipText);
         _vipText = null;
         ObjectUtils.disposeObject(_chatPopView);
         _chatPopView = null;
         ObjectUtils.disposeObject(_consortiaTxt);
         _consortiaTxt = null;
         ObjectUtils.disposeObject(_attackView);
         _attackView = null;
         ObjectUtils.disposeObject(_fateSkillEffect);
         _fateSkillEffect = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeObject(_regressIcon);
         _regressIcon = null;
         if(_avengerEffect)
         {
            ObjectUtils.disposeObject(_avengerEffect);
            _avengerEffect = null;
         }
         super.dispose();
      }
      
      public function get isMounting() : Boolean
      {
         return _isMounting;
      }
      
      public function get isFlying() : Boolean
      {
         return _isFlying;
      }
   }
}

