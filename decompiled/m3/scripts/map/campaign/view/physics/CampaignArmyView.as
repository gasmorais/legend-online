package map.campaign.view.physics
{
   import avatar.data.AvatarStaticData;
   import avatar.view.AppellView;
   import avatar.view.Avatar;
   import avatar.view.ChildrenAvatarView;
   import avatar.view.HeroAvatar;
   import avatar.view.MonsterAvatarView;
   import avatar.view.PetAvatarView;
   import avatar.view.RapidView;
   import avatar.view.SimpleAvatarView;
   import chat.datas.ChatFactory;
   import com.pickgliss.loader.LoaderHeaderList;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.AppellEvent;
   import events.ArmyEvent;
   import events.ObjectsEvent;
   import events.PetEvent;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.MarryManager;
   import managers.RapidThroughPassManager;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.mediator.activevehicle.ActiveVehicleCastSkillMediator;
   import map.campaign.mediator.hero.BattleMovieMediator;
   import map.campaign.mediator.hero.PlayerWalkMediator;
   import map.campaign.mediator.hero.TranseferWaitMediator;
   import map.campaign.mediator.pvp.TransportMediator;
   import map.campaign.mediator.unrealshooting.UnrealShootingCastSkillMediator;
   import map.internals.constant.ArmyState;
   import map.internals.data.ArmyChildrenInfo;
   import map.internals.data.ArmyMonsterInfo;
   import map.internals.data.ArmyPetInfo;
   import map.internals.data.PhysicsEvent;
   import map.internals.utils.ArmySpeedUtils;
   import map.internals.view.hero.HeroAvatarView;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tools.SimpleMovie;
   
   public class CampaignArmyView extends HeroAvatarView
   {
      
      public static const DEFAULT_SPEED:int = 7;
      
      public static const HALF_SPEED:int = 4;
      
      public static const NAME:String = "map.campaign.view.hero.CampaignArmyView";
      
      protected var _dieFilter:UIFilter;
      
      protected var _data:CampaignArmy;
      
      protected var _consortiaTxt:FilterFrameText;
      
      private var _mediatorKey:String;
      
      private var _bloodMc:MovieClip;
      
      private var _chatPopView:Component;
      
      private var _hangupView:SimpleAvatarView;
      
      private var _attackView:SimpleAvatarView;
      
      private var _buffEffect:SimpleAvatarView;
      
      protected var _honerTxt:GradientText;
      
      protected var _honerView:AppellView;
      
      protected var _vipIcon:Bitmap;
      
      protected var _vipText:GradientText;
      
      protected var _showNamePosY:int = -125;
      
      protected var _appellId:int = 0;
      
      protected var _fateSkillEffect:SimpleAvatarView;
      
      protected var _vocationIcon:ScaleFrameImage;
      
      protected var _petAvatarView:PetAvatarView;
      
      protected var _childrenAvatarView:ChildrenAvatarView;
      
      protected var _monsterAvatarView:MonsterAvatarView;
      
      protected var _regressIcon:Image;
      
      protected var _iconPosX:int;
      
      protected var _iconPosY:int;
      
      protected var _avengerEffect:MovieImage;
      
      private var _controller:CampaignMapController;
      
      protected var _isMounting:Boolean = false;
      
      protected var _isSitDown:Boolean = false;
      
      private var _isRenderingAvatar:Boolean = true;
      
      private var rapidView:RapidView;
      
      public var isAirGardenShowView:Boolean = false;
      
      protected var mapId:int;
      
      private var preEffectType:int;
      
      protected var isMonopoly:Boolean = false;
      
      private var _currentPos:Point;
      
      public var precentSpeed:Number = 1;
      
      public function CampaignArmyView(param1:Boolean = true)
      {
         super();
         _isRenderingAvatar = param1;
         _controller = CampaignManager.instance.controller as CampaignMapController;
         initView();
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      public function get isRenderingAvatar() : Boolean
      {
         return _isRenderingAvatar;
      }
      
      protected function initView() : void
      {
         _npcName = ComponentFactory.Instance.creatComponentByStylename("map.campaign.NpcNameText");
         _npcName.width = 200;
         _npcName.x = -_npcName.width / 2;
         _npcName.y = -125;
         addChild(_npcName);
         _vipText = ComponentFactory.Instance.creatComponentByStylename("core.NpcName_VipText");
         _vipIcon = ComponentFactory.Instance.creatBitmap("asset.core.simpleVIPIcon");
         _vipText.cacheAsBitmap = true;
         addChild(_vipText);
         addChild(_vipIcon);
         _vipIcon.visible = _vipText.visible = false;
         _consortiaTxt = ComponentFactory.Instance.creatComponentByStylename("map.campaign.ConsortiaText");
         _consortiaTxt.cacheAsBitmap = true;
         _consortiaTxt.x = -_consortiaTxt.width / 2;
         _consortiaTxt.y = -145;
         addChild(_consortiaTxt);
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("army.VocationIcon");
         _vocationIcon.visible = false;
         addChild(_vocationIcon);
         _regressIcon = ComponentFactory.Instance.creatComponentByStylename("core.RegressIcon");
         _regressIcon.visible = false;
         addChild(_regressIcon);
      }
      
      protected function get isSelf() : Boolean
      {
         if(mapModel.isCross)
         {
            return _data.userId == thane.userId && _data.baseHero.serviceName == PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         }
         return _data.userId == thane.userId;
      }
      
      protected function get isSelfConsortia() : Boolean
      {
         var _loc1_:int = 0;
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
            if(mapModel.isCross)
            {
               _loc1_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID);
               return _data.baseHero.consortiaName == playerInfo.consortiaName && _data.baseHero.consortiaID == _loc1_;
            }
            return _data.baseHero.consortiaName == playerInfo.consortiaName;
         }
         return false;
      }
      
      protected function get isSelfTeam() : Boolean
      {
         if(_data && _data.baseHero)
         {
            if(FreedomTeamManager.instance.inMyTeam(_data.userId))
            {
               return true;
            }
         }
         return false;
      }
      
      protected function get isInMineralPVP() : Boolean
      {
         if(_data && _data.baseHero)
         {
            return WorldBossHelper.checkMineralPVP(mapModel.mapId);
         }
         return false;
      }
      
      protected function addFateSkillEffect() : void
      {
         var _loc4_:int = 0;
         if(_fateSkillEffect)
         {
            _fateSkillEffect.dispose();
         }
         _fateSkillEffect = null;
         if(!_data.baseHero.fateSkill)
         {
            return;
         }
         var _loc1_:Array = _data.baseHero.fateSkill.split(",");
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         for each(var _loc5_:String in _loc1_)
         {
            _loc4_ = int(_loc5_.substr(_loc5_.length - 2,2));
            if(_loc4_ > _loc7_)
            {
               _loc7_ = _loc4_;
               _loc2_ = int(_loc5_);
            }
         }
         var _loc6_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_loc2_);
         if(!_loc6_ || _loc6_.Grades == 0)
         {
            return;
         }
         var _loc8_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc6_.Grades,26);
         if(StringHelper.isNullOrEmpty(_loc8_.TemplateName))
         {
            return;
         }
         var _loc3_:Array = _loc8_.TemplateName.split("|");
         _fateSkillEffect = new SimpleAvatarView(_loc3_[0],_loc3_[1],PathManager.getFateWalkPath(_loc8_.ActiveObject),_loc3_[2]);
         _fateSkillEffect.drawFrame = 1;
         _fateSkillEffect.x = -_loc3_[3];
         _fateSkillEffect.y = -_loc3_[4];
         addChild(_fateSkillEffect);
      }
      
      public function set data(param1:CampaignArmy) : void
      {
         if(param1)
         {
            mapId = param1.mapId;
         }
         removeEvent();
         _data = param1;
         if(isSelf)
         {
            mouseChildren = mouseEnabled = false;
         }
         if(isPlaying)
         {
            showAvatar(param1);
            showChildren(param1.childrenInfo);
            showPet(param1.petInfo);
            showMonster(param1.monsterInfo);
         }
         showInfoTxt();
         __isDieHandler(null);
         __updateCampaignArmyHandler(null);
         __hangupStateHandler(null);
         addEvent();
         showRapidState();
         var _loc2_:Array = [TranseferWaitMediator,BattleMovieMediator];
         if(WorldBossHelper.checkDuskArea(mapId) || Boolean(WorldBossHelper.checkIceFireTemple(_data.mapId)))
         {
            _loc2_.push(BattleMovieMediator);
         }
         if(isSelf)
         {
            _loc2_.push(PlayerWalkMediator);
            if(WorldBossHelper.checkActiveVehicle(_data.mapId))
            {
               _loc2_.push(ActiveVehicleCastSkillMediator);
            }
            if(WorldBossHelper.checkUnrealShooting(_data.mapId))
            {
               _loc2_.push(UnrealShootingCastSkillMediator);
            }
         }
         if(WorldBossHelper.checkPvp(_data.mapId) || Boolean(WorldBossHelper.checkMineral(_data.mapId)) || Boolean(WorldBossHelper.checkDuskArea(_data.mapId)) || Boolean(WorldBossHelper.checkIceFireTemple(_data.mapId)) || Boolean(WorldBossHelper.checkGodsEvening(_data.mapId)))
         {
            _loc2_.push(TransportMediator);
         }
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc2_,this,"map.campaign.view.hero.CampaignArmyView");
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         if(thane)
         {
            thane.removeEventListener("PLAYER_AVATA_CHANGE",__heroPropertyHandler);
            thane.removeEventListener("PLAYER_INFO_UPDATE",__updateInfoHandler);
            thane.removeEventListener("APPELL_CHANGE",__updateInfoHandler);
            thane.removeEventListener("VOCATION_GRADES",__updateInfoHandler);
            thane.removeEventListener("AVENGER_DEGREE_CHANGE",__updateInfoHandler);
         }
         NotificationManager.instance.removeEventListener("QUIT_CAMPAIGN",__lockKeyHandler);
         PlayerManager.instance.removeEventListener("PET_LEVEL_UP",__petLevelUpHandler);
         if(_data)
         {
            _data.baseHero.removeEventListener("PLAYER_INFO_UPDATE",__updateInfoHandler);
            _data.baseHero.removeEventListener("APPELL_CHANGE",__updateInfoHandler);
            _data.baseHero.removeEventListener("VOCATION_GRADES",__updateInfoHandler);
            _data.baseHero.removeEventListener("AVENGER_DEGREE_CHANGE",__updateInfoHandler);
            _data.baseHero.removeEventListener("PLAYER_AVATA_CHANGE",__avatarChangeHandler);
            _data.removeEventListener("UPDATE_CAMPAIGN_ARMY",__updateCampaignArmyHandler);
            _data.removeEventListener("ONLINE_STATE",__onlineStateHandler);
            _data.baseHero.removeEventListener("PLAYER_AVATA_CHANGE",__heroPropertyHandler);
            _data.removeEventListener("CHAT_DATA",__chatHandler);
            _data.removeEventListener("IS_DIE",__isDieHandler);
            _data.removeEventListener("UPDATE_CUR_HP",__updateCurHpHandler);
            _data.removeEventListener("hangupState",__hangupStateHandler);
            _data.removeEventListener("hangupadd",__hangupAddHandler);
            _data.removeEventListener("BUFFER_TEMP_ID",__updateBufferHandler);
            _data.removeEventListener("UPDATE_TEAM_ID",__updateTeamHandler);
            _data.removeEventListener("UPDATE_ROOM_PLAYER_DATA",onDataValueChange);
            _data.petInfo.removeEventListener("PETINFO_CHANGED",__updatePetAvatarHandler);
            _data.childrenInfo.removeEventListener("CHILDRENINFO_CHANGED",__updateChildrenAvatarHandler);
            _data.monsterInfo.removeEventListener("MONSTER_CHANGED",__updateMonsterAvatarHandler);
         }
         removeEventListener("addedToStage",__addToStageHandler);
         NotificationManager.instance.removeEventListener("APPELL_LOAD_COMPLETE",__appellLoadCompleteHandle);
         NotificationManager.instance.removeEventListener("rapid_pass_update",showRapidState);
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         _data.addEventListener("UPDATE_CAMPAIGN_ARMY",__updateCampaignArmyHandler);
         _data.addEventListener("ONLINE_STATE",__onlineStateHandler);
         _data.addEventListener("CHAT_DATA",__chatHandler);
         _data.addEventListener("UPDATE_ROOM_PLAYER_DATA",onDataValueChange);
         if(isSelf)
         {
            thane.addEventListener("PLAYER_AVATA_CHANGE",__heroPropertyHandler);
            thane.addEventListener("PLAYER_INFO_UPDATE",__updateInfoHandler);
            thane.addEventListener("APPELL_CHANGE",__updateInfoHandler);
            thane.addEventListener("VOCATION_GRADES",__updateInfoHandler);
            NotificationManager.instance.addEventListener("QUIT_CAMPAIGN",__lockKeyHandler);
            PlayerManager.instance.addEventListener("PET_LEVEL_UP",__petLevelUpHandler);
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
         _data.addEventListener("UPDATE_CUR_HP",__updateCurHpHandler);
         _data.addEventListener("IS_DIE",__isDieHandler);
         _data.addEventListener("hangupState",__hangupStateHandler);
         _data.addEventListener("hangupadd",__hangupAddHandler);
         _data.addEventListener("BUFFER_TEMP_ID",__updateBufferHandler);
         _data.addEventListener("UPDATE_TEAM_ID",__updateTeamHandler);
         _data.petInfo.addEventListener("PETINFO_CHANGED",__updatePetAvatarHandler);
         _data.childrenInfo.addEventListener("CHILDRENINFO_CHANGED",__updateChildrenAvatarHandler);
         _data.monsterInfo.addEventListener("MONSTER_CHANGED",__updateMonsterAvatarHandler);
         addEventListener("addedToStage",__addToStageHandler);
         NotificationManager.instance.addEventListener("APPELL_LOAD_COMPLETE",__appellLoadCompleteHandle);
         NotificationManager.instance.addEventListener("rapid_pass_update",showRapidState);
      }
      
      protected function __appellLoadCompleteHandle(param1:AppellEvent) : void
      {
         layoutTxtViewWithNamePosY();
      }
      
      private function onDataValueChange(param1:RoomEvent) : void
      {
         showAvatar(_data);
         showRapidState();
      }
      
      private function showRapidState(param1:Event = null) : void
      {
         if(!WorldBossHelper.checkRapidMap(_data.mapId))
         {
            return;
         }
         var _loc2_:int = int(RapidThroughPassManager.instance.rapidThroughInfo.pass);
         var _loc3_:Boolean = _data.baseHero.userId == PlayerManager.instance.currentPlayerModel.userInfo.userId;
         if(!rapidView && !_loc3_)
         {
            rapidView = new RapidView();
            this.addChild(rapidView);
            rapidView.x = 29;
            rapidView.y = -189;
         }
         if(!_loc3_)
         {
            rapidView.refreshView(_loc2_,_data.teamId);
         }
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         removeEventListener("addedToStage",__addToStageHandler);
         showChildren(_data.childrenInfo);
         showPet(_data.petInfo);
      }
      
      private function __updatePetAvatarHandler(param1:ArmyEvent) : void
      {
         showPet(param1.data as ArmyPetInfo);
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
      
      protected function showMonster(param1:ArmyMonsterInfo) : void
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
                  if(_monsterAvatarView.parent != CampaignManager.instance.mapView.walkLayer)
                  {
                     CampaignManager.instance.mapView.walkLayer.addChild(_monsterAvatarView);
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
      
      protected function showInfoTxt() : void
      {
         var _loc1_:int = getNameColor();
         setHonerName();
         if(!isSelfConsortia)
         {
            setConsortiaName(2);
         }
         else
         {
            setConsortiaName(_loc1_);
         }
         isVip ? setVipName() : clearVipName();
         setNpcName(_loc1_);
         refreshVocation();
         refreshRegress();
         layoutTxtViewWithNamePosY();
      }
      
      private function getNameColor() : int
      {
         var _loc1_:int = 2;
         if(isVip)
         {
            _loc1_ = 9;
         }
         if(isSelf)
         {
            _loc1_ = 1;
         }
         else if(isSelfConsortia)
         {
            _loc1_ = 3;
         }
         return _loc1_;
      }
      
      protected function setNpcName(param1:int) : void
      {
         if(isSelf)
         {
            _npcName.text = thane.nickName;
            _vipText.text = thane.nickName;
         }
         else
         {
            _npcName.text = _data.baseHero.nickName;
            _vipText.text = _data.baseHero.nickName;
         }
         _npcName.setFrame(param1);
         if(isSelf || isSelfConsortia)
         {
            _npcName.visible = true;
            _vipText.visible = false;
         }
         else if(isVip)
         {
            _vipText.visible = true;
            _npcName.visible = false;
         }
         else
         {
            _npcName.visible = true;
            _vipText.visible = false;
         }
      }
      
      protected function setConsortiaName(param1:int) : void
      {
         if(consortiaName)
         {
            _consortiaTxt.text = LanguageMgr.GetTranslation("map.avatar.view.consortiaName",consortiaName);
            if(param1 == 9)
            {
               _consortiaTxt.setFrame(2);
            }
            else
            {
               _consortiaTxt.setFrame(param1);
            }
         }
         else
         {
            _consortiaTxt.text = "";
         }
         addChild(_consortiaTxt);
      }
      
      private function get appellId() : int
      {
         if(!isSelf && _data)
         {
            return _data.baseHero.appellId;
         }
         return thane.appellId;
      }
      
      protected function setHonerName() : void
      {
         var _loc1_:ThaneInfo = null;
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
         if(isHoner)
         {
            _honerTxt = ComponentFactory.Instance.creatComponentByStylename(honerStyle);
            _honerTxt.cacheAsBitmap = true;
            _honerTxt.text = honerName;
            if(isSelf)
            {
               _loc1_ = thane;
            }
            else
            {
               _loc1_ = _data.baseHero;
            }
            if(_loc1_.appellId > 0)
            {
               _honerView = new AppellView(_loc1_.appellInfo);
            }
            showHoner();
         }
      }
      
      protected function showHoner() : void
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
         var _loc1_:ThaneInfo = null;
         if(isSelf)
         {
            _loc1_ = thane;
         }
         else
         {
            _loc1_ = _data.baseHero;
         }
         if(VersionSwitch.APPELL && _loc1_.appellInfo)
         {
            return "map.campaign.HonerText" + _loc1_.appellInfo.Quality;
         }
         return "map.campaign.HonerText";
      }
      
      private function get honerName() : String
      {
         var _loc1_:ThaneInfo = null;
         if(isSelf)
         {
            _loc1_ = thane;
         }
         else
         {
            _loc1_ = _data.baseHero;
         }
         if(VersionSwitch.APPELL && _loc1_.appellInfo)
         {
            return _loc1_.appellInfo.Title;
         }
         return _loc1_.honerTemp.TemplateName;
      }
      
      public function get isHoner() : Boolean
      {
         if(VersionSwitch.APPELL)
         {
            if(isSelf)
            {
               return thane.appellId != 0;
            }
            return _data.baseHero.appellId != 0;
         }
         if(isSelf)
         {
            return thane.honer >= thane.firstHonerTemp.Data;
         }
         return _data.baseHero.honer >= _data.baseHero.firstHonerTemp.Data;
      }
      
      protected function refreshVocation() : void
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
      
      private function setVipName() : void
      {
         _npcName.visible = false;
         _vipIcon.visible = _vipText.visible = true;
         _vipText.text = _data.baseHero.nickName;
      }
      
      private function clearVipName() : void
      {
         _npcName.visible = true;
         _vipIcon.visible = _vipText.visible = false;
         _vipText.text = "";
      }
      
      public function get isVip() : Boolean
      {
         return _data.baseHero.IsVipAndNoExpirt;
      }
      
      override public function set isPlaying(param1:Boolean) : void
      {
         if(_isPlaying == param1 && param1 == true)
         {
            return;
         }
         if(_avatar)
         {
            (_avatar as HeroAvatar).playing = param1;
         }
         super.isPlaying = param1;
         if(isPlaying && !avatarView)
         {
            showAvatar(data);
            showChildren(data.childrenInfo);
            showPet(data.petInfo);
            showMonster(data.monsterInfo);
         }
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
            if(_monsterAvatarView)
            {
               addMonsterToStage();
            }
            if(_fateSkillEffect)
            {
               addChildAt(_fateSkillEffect,0);
            }
            if(_avatar)
            {
               addChild(_avatar);
            }
            if(_consortiaTxt)
            {
               addChild(_consortiaTxt);
            }
            showHoner();
            if(_vipIcon)
            {
               addChild(_vipIcon);
            }
            if(_vipText)
            {
               addChild(_vipText);
            }
            if(_npcName)
            {
               addChild(_npcName);
            }
            if(_chatPopView)
            {
               addChild(_chatPopView);
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
            if(_hangupView)
            {
               addChild(_hangupView);
            }
            if(_attackView)
            {
               addChild(_attackView);
            }
            if(_buffEffect)
            {
               addChild(_buffEffect);
            }
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
            if(_chatPopView && _chatPopView.parent)
            {
               _chatPopView.parent.removeChild(_chatPopView);
            }
            if(_consortiaTxt && _consortiaTxt.parent)
            {
               _consortiaTxt.parent.removeChild(_consortiaTxt);
            }
            hideHoner();
            if(_fateSkillEffect && _fateSkillEffect.parent)
            {
               _fateSkillEffect.parent.removeChild(_fateSkillEffect);
            }
            if(_avengerEffect && _avengerEffect.parent)
            {
               _avengerEffect.parent.removeChild(_avengerEffect);
            }
            if(_hangupView && _hangupView.parent)
            {
               _hangupView.parent.removeChild(_hangupView);
            }
            if(_attackView && _attackView.parent)
            {
               _attackView.parent.removeChild(_attackView);
            }
            if(_buffEffect && _buffEffect.parent)
            {
               _buffEffect.parent.removeChild(_buffEffect);
            }
         }
      }
      
      protected function layoutTxtViewWithNamePosY() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:ThaneInfo = null;
         _showNamePosY = -125;
         if(_avatar)
         {
            _showNamePosY = getPosYBySizeType(avatarView.sizeType,avatarView.flight);
         }
         if(_npcName)
         {
            _npcName.x = -_npcName.width / 2;
            _npcName.y = _showNamePosY;
         }
         if(_consortiaTxt)
         {
            _consortiaTxt.x = -_consortiaTxt.width / 2;
            _consortiaTxt.y = _showNamePosY - 20;
         }
         if(consortiaName)
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
            if(isSelf)
            {
               _loc3_ = thane;
            }
            else
            {
               _loc3_ = _data.baseHero;
            }
            _honerView.x = -_loc3_.appellInfo.ImgWidth / 2;
            if(consortiaName)
            {
               _honerView.y = _showNamePosY - _loc3_.appellInfo.ImgHeight - 20;
            }
            else
            {
               _honerView.y = _showNamePosY - _loc3_.appellInfo.ImgHeight;
            }
         }
         if(_honerTxt)
         {
            _honerTxt.x = -_honerTxt.width / 2;
            if(consortiaName)
            {
               _honerTxt.y = _showNamePosY - 40;
            }
            else
            {
               _honerTxt.y = _showNamePosY - 20;
            }
         }
      }
      
      public function caluateTopPos() : int
      {
         var _loc1_:ThaneInfo = isSelf ? thane : data.baseHero;
         var _loc2_:int = _showNamePosY - 20;
         if(consortiaName)
         {
            _loc2_ -= 20;
         }
         if(isHoner)
         {
            if(VersionSwitch.APPELL)
            {
               _loc2_ -= _loc1_.appellInfo.ImgHeight;
            }
            else
            {
               _loc2_ -= 20;
            }
         }
         return _loc2_;
      }
      
      protected function get consortiaName() : String
      {
         if(isSelf)
         {
            return thane.consortiaName;
         }
         return _data.baseHero.consortiaName;
      }
      
      protected function showAvatar(param1:CampaignArmy) : void
      {
         var _loc14_:CampaignArmy = null;
         var _loc15_:ThaneInfo = null;
         var _loc19_:String = null;
         var _loc11_:String = null;
         var _loc18_:String = null;
         var _loc13_:Object = null;
         var _loc8_:String = null;
         _isMounting = false;
         _isSitDown = param1.isSitDown;
         if(RoomManager.instance.roomInfo)
         {
            _loc14_ = RoomManager.instance.roomInfo.getPlayerByUserId(param1.baseHero.userId,param1.baseHero.serviceName);
         }
         if(_loc14_ == null || _loc14_.baseHero == null)
         {
            _loc14_ = param1;
         }
         if(this.info)
         {
            this.info.speed = ArmySpeedUtils.getMoveSpeed(_loc14_);
         }
         if(isSelf)
         {
            _loc15_ = thane;
         }
         else
         {
            _loc15_ = _loc14_.baseHero;
            if(param1.mountTemplate)
            {
               _loc15_.avatarChange["mount"] = true;
            }
         }
         var _loc10_:MountTemplate = _loc14_.mountTemplate;
         _isMounting = _loc10_ != null;
         if(isMonopoly || isAirGardenShowView)
         {
            _loc10_ = null;
            _isMounting = false;
         }
         var _loc20_:int = int(_loc15_.changeShapeId);
         var _loc5_:int = int(_loc15_.templateInfo.Sexs);
         var _loc23_:int = int(_loc15_.templateInfo.Job);
         var _loc16_:String = _loc15_.bodyEquipAvata == "" ? JobType.getDefaultBodyEquipNameByJob(_loc23_) : _loc15_.bodyEquipAvata;
         var _loc3_:String = _loc15_.armsEquipAvata == "" ? JobType.getDefaultArmysEquipNameByJob(_loc23_) : _loc15_.armsEquipAvata;
         if(_loc16_.indexOf(PathManager.DRAGONIC) != -1)
         {
            _loc19_ = JobType.getDefaultHairUpByJob(4);
            _loc11_ = JobType.getDefaultHairDownByJob(4);
            _loc18_ = JobType.getDefaultCloakEquipNameByJob(4);
         }
         else
         {
            _loc19_ = JobType.getDefaultHairUpByJob(_loc23_);
            _loc11_ = JobType.getDefaultHairDownByJob(_loc23_);
            _loc18_ = JobType.getDefaultCloakEquipNameByJob(_loc23_);
         }
         var _loc6_:String = _loc15_.wingAvata;
         var _loc21_:String = _loc10_ ? _loc10_.AvatarPath : "";
         var _loc12_:Boolean = !_loc15_.hideFashion;
         var _loc17_:Boolean = isSelf;
         var _loc7_:int = isSelf ? 10 : 4;
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
         if(_loc20_ > 0 && !_isSitDown)
         {
            _loc16_ = _loc20_ + "";
            _loc3_ = "";
            if(!avatarView)
            {
               avatarView = new HeroAvatar(true,_loc16_,2,_loc5_,_loc17_,_loc23_);
            }
            avatarView.type = 2;
            avatarView.removeAllAvatar();
            avatarView.currentMountId = _loc10_ ? _loc10_.TemplateId : -1;
            _loc8_ = PathManager.getAvatarResourcePath(_loc16_,_loc5_,1,"body",_loc23_,2);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.BASE_NPC_STAND,AvatarStaticData.BASE_NPC_WALK,"body");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
            return;
         }
         var _loc2_:int = 1;
         var _loc4_:int = 1;
         var _loc9_:int = 1;
         if(_loc12_)
         {
            if(_loc15_.bodyFashionAvata)
            {
               _loc16_ = _loc15_.bodyFashionAvata;
               _loc18_ = "";
               _loc2_ = 2;
            }
            if(_loc15_.armsFashionAvata)
            {
               _loc3_ = _loc15_.armsFashionAvata;
               _loc4_ = 2;
            }
            if(_loc15_.hairFashionAvata)
            {
               _loc19_ = _loc15_.hairFashionAvata + "Up";
               _loc11_ = _loc15_.hairFashionAvata + "Down";
               _loc9_ = 2;
            }
         }
         if(_isSitDown)
         {
            _loc16_ = JobType.getSitDownBodyEquipNameBtJob(_loc23_);
            _loc3_ = "";
            _loc19_ = "";
            _loc11_ = "";
            _loc18_ = "";
            _loc6_ = "";
            _loc21_ = "";
            _loc2_ = 1;
            if(!avatarView)
            {
               avatarView = new HeroAvatar(true,_loc16_,2,_loc5_,_loc17_,_loc23_);
            }
            avatarView.currentMountId = _loc10_ ? _loc10_.TemplateId : -1;
            avatarView.removeAllAvatar();
         }
         if(avatarView)
         {
            for(var _loc22_:String in _loc15_.avatarChange)
            {
               avatarView.removeAvatar(_loc22_);
            }
            _avatar.type = 1;
            avatarView.currentMountId = _loc10_ ? _loc10_.TemplateId : -1;
         }
         else
         {
            avatarView = new HeroAvatar(true,_loc16_,1,_loc5_,_loc17_);
            avatarView.currentMountId = _loc10_ ? _loc10_.TemplateId : -1;
         }
         if(_isMounting)
         {
            (avatarView as HeroAvatar).isStandPosMount = _loc10_.useStandPose;
            if(!_loc10_.useStandPose)
            {
               _loc16_ = JobType.getMapMountEquipment(_loc16_);
               _loc3_ = JobType.getMapMountEquipment(_loc3_);
               _loc19_ = JobType.getMapMountEquipment(_loc19_);
               _loc11_ = JobType.getMapMountEquipment(_loc11_);
               _loc18_ = JobType.getMapMountEquipment(_loc18_);
               _loc6_ = JobType.getMapMountEquipment(_loc6_);
            }
            if(!_loc21_)
            {
               _loc21_ = JobType.getDefaultMount();
            }
         }
         else
         {
            (avatarView as HeroAvatar).isStandPosMount = false;
         }
         if(_loc6_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc6_,_loc5_,1,"wing",_loc23_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","wing",_isMounting),AvatarStaticData.getBaseNumByType("Walk","wing",_isMounting),"wing");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         else if(_loc18_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc18_,_loc5_,1,"cloak",_loc23_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","cloak",_isMounting),AvatarStaticData.getBaseNumByType("Walk","cloak",_isMounting),"cloak");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_loc11_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc11_,_loc5_,_loc9_,"hairDown",_loc23_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","hairDown",_isMounting),AvatarStaticData.getBaseNumByType("Walk","hairDown",_isMounting),"hairDown");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_loc19_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc19_,_loc5_,_loc9_,"hairUp",_loc23_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","hairUp",_isMounting),AvatarStaticData.getBaseNumByType("Walk","hairUp",_isMounting),"hairUp");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_loc3_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc3_,_loc5_,_loc4_,"army",_loc23_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","army",_isMounting),AvatarStaticData.getBaseNumByType("Walk","army",_isMounting),"army");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_loc16_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc16_,_loc5_,_loc2_,"body",_loc23_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","body",_isMounting),AvatarStaticData.getBaseNumByType("Walk","body",_isMounting),"body");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_loc21_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc21_,_loc5_,1,"mount",_loc23_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","mount",_isMounting),AvatarStaticData.getBaseNumByType("Walk","mount",_isMounting),"mount");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_data == null || Boolean(WorldBossHelper.checkUnrealShooting(_data.mapId)))
         {
            avatarView.footPrintLayer = null;
         }
         if(avatarView == null)
         {
            return;
         }
         if(_isMounting && Boolean(param1.mountTemplate.hasEffectFoot))
         {
            avatarView.footPrintLayer = CampaignManager.instance.mapView.footLayer;
         }
         else
         {
            avatarView.footPrintLayer = null;
         }
         avatarView.showMountShadow = _isMounting;
      }
      
      protected function showPet(param1:ArmyPetInfo) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc4_:int = 0;
         if(WorldBossHelper.checkGodsEvening(mapModel.mapId) || Boolean(WorldBossHelper.checkDeepPrison(mapModel.mapId)))
         {
            return;
         }
         if(!param1.petTemplate)
         {
            if(_petAvatarView)
            {
               _petAvatarView.dispose();
               _petAvatarView = null;
            }
            return;
         }
         if(param1.petTemplate)
         {
            _loc3_ = param1.petTemplate.PetAvatar;
         }
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
            if(petAvatarView.followType == 1)
            {
               if(_petAvatarView.parent != CampaignManager.instance.mapView.walkLayer && parent)
               {
                  CampaignManager.instance.mapView.walkLayer.addChild(_petAvatarView);
                  initPetPos();
               }
            }
            else
            {
               addChild(petAvatarView);
            }
            _loc4_ = 1;
            _loc2_ = param1.petName ? param1.petName : "";
            if(param1.petQuaity > 0)
            {
               _loc4_ = int(param1.petTemQuality);
            }
            petAvatarView.showAvatar(_loc2_,param1,_loc3_);
         }
         __isDieHandler(null);
      }
      
      private function addPetToStage() : void
      {
         if(petAvatarView.followType == 1)
         {
            if(_petAvatarView.parent != CampaignManager.instance.mapView.walkLayer)
            {
               CampaignManager.instance.mapView.walkLayer.addChild(_petAvatarView);
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
      
      protected function showChildren(param1:ArmyChildrenInfo) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(WorldBossHelper.checkGodsEvening(mapModel.mapId) || Boolean(WorldBossHelper.checkDeepPrison(mapModel.mapId)))
         {
            return;
         }
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
            childrenAvatarView.isFlying = false;
            childrenAvatarView.isSelf = this.isSelf;
            childrenAvatarView.followTarget = this;
            if(_childrenAvatarView.parent != CampaignManager.instance.mapView.walkLayer)
            {
               CampaignManager.instance.mapView.walkLayer.addChild(_childrenAvatarView);
               initChildrenPos();
            }
            if(parent)
            {
               _loc4_ = 1;
               _loc3_ = param1.childrenName ? param1.childrenName : "";
               childrenAvatarView.showAvatar(_loc3_,_loc4_,_loc2_,param1.childrenGrade,param1.growthGrade2);
            }
         }
         __isDieHandler(null);
      }
      
      private function addChildrenToStage() : void
      {
         if(_childrenAvatarView.parent != CampaignManager.instance.mapView.walkLayer)
         {
            CampaignManager.instance.mapView.walkLayer.addChild(_childrenAvatarView);
         }
      }
      
      private function addMonsterToStage() : void
      {
         if(_monsterAvatarView.parent != CampaignManager.instance.mapView.walkLayer)
         {
            CampaignManager.instance.mapView.walkLayer.addChild(_monsterAvatarView);
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
      
      protected function __heroPropertyHandler(param1:PlayerEvent) : void
      {
         if(!_data || !_data.baseHero || !RoomManager.instance.roomInfo)
         {
            return;
         }
         var _loc2_:CampaignArmy = RoomManager.instance.roomInfo.getPlayerByUserId(_data.baseHero.userId,_data.baseHero.serviceName);
         if(!_loc2_)
         {
            return;
         }
         if(isSelf)
         {
            _loc2_.baseHero.nickName = thane.nickName;
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
         showInfoTxt();
      }
      
      private function __avatarChangeHandler(param1:PlayerEvent) : void
      {
         if(isSelf)
         {
            ArmyManager.instance.army.mountTemplateId = data.mountTemplateId;
         }
         showInfoTxt();
         showAvatar(_data);
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
         if(_attackView)
         {
            _attackView.dispose();
         }
         _attackView = null;
         if(_bloodMc)
         {
            _bloodMc.stop();
            if(_bloodMc.parent)
            {
               _bloodMc.parent.removeChild(_bloodMc);
            }
         }
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
            data.childrenInfo.commit();
            data.monsterInfo.monsterTemplateId = _loc2_.monsterTempteId;
            data.monsterInfo.commit();
         }
         showInfoTxt();
      }
      
      private function __updateTeamHandler(param1:CampaignMapEvent) : void
      {
         showInfoTxt();
         var _loc4_:CampaignArmy = param1.data as CampaignArmy;
         var _loc3_:int = _loc4_.curPosX * 20;
         var _loc2_:int = _loc4_.curPosY * 20;
         if(Math.abs(x - _loc3_) > 100 || Math.abs(y - _loc2_) > 100)
         {
            x = _loc3_;
            y = _loc2_;
            _info.pathInfo = [];
         }
      }
      
      private function __updateBufferHandler(param1:CampaignMapEvent) : void
      {
         if(!WorldBossHelper.checkPvp(_data.mapId))
         {
            return;
         }
         if(_data.bufferTempId > 0)
         {
            _buffEffect = new SimpleAvatarView(178,200,PathManager.warFightBuff);
            addChildAt(_buffEffect,0);
            _buffEffect.x = -91;
            _buffEffect.y = -146;
         }
         else if(_buffEffect)
         {
            if(_buffEffect.parent)
            {
               _buffEffect.parent.removeChild(_buffEffect);
            }
            _buffEffect.dispose();
            _buffEffect = null;
         }
      }
      
      protected function __lockKeyHandler(param1:NotificationEvent) : void
      {
         info.pathInfo = [];
      }
      
      private function __hangupAddHandler(param1:CampaignMapEvent) : void
      {
         var _loc2_:MovieClip = ComponentFactory.Instance.creat("asset.campaign.map.HangupAddAsset");
         var _loc3_:BitmapData = ComponentFactory.Instance.creatBitmapData("asset.core.number_img_05");
         NumberViewUtils.refreshValue(int(param1.data),_loc2_["content"]["num_pos"],_loc3_,40,40,25,40,"0123456789.");
         var _loc4_:SimpleMovie = new SimpleMovie(_loc2_);
         _loc4_.y = -50;
         addChild(_loc4_);
         _loc3_.dispose();
         _loc3_ = null;
      }
      
      private function __hangupStateHandler(param1:CampaignMapEvent) : void
      {
         if(_data.hangupState > 0)
         {
            if(!_hangupView)
            {
               _hangupView = new SimpleAvatarView(80,180,PathManager.getHookStatePath(_data.hangupState));
            }
            addChild(_hangupView);
            _hangupView.x = -47;
            _hangupView.y = -157;
         }
         else
         {
            if(_hangupView)
            {
               _hangupView.dispose();
            }
            _hangupView = null;
         }
      }
      
      protected function __updateCurHpHandler(param1:PhysicsEvent) : void
      {
         if(_data.totalHp <= 0)
         {
            return;
         }
         if(!_bloodMc)
         {
            _bloodMc = ComponentFactory.Instance.creatCustomObject("asset.campaign.map.BloodAsset");
         }
         _bloodMc.play();
         addChild(_bloodMc);
         _bloodMc.y = _bloodMc.height;
         _bloodMc.bloodMc.gotoAndStop(int(_data.curHp / _data.totalHp * 100));
      }
      
      protected function __isDieHandler(param1:CampaignMapEvent) : void
      {
         if(CampaignArmyState.checkDied(_data.isDie))
         {
            if(!_dieFilter)
            {
               _dieFilter = new UIFilter();
            }
            _dieFilter.setGrayFilter(_avatar);
            if(_petAvatarView)
            {
               _dieFilter.setGrayFilter(_petAvatarView);
            }
            if(_childrenAvatarView)
            {
               _dieFilter.setGrayFilter(_childrenAvatarView);
            }
            if(_monsterAvatarView)
            {
               _dieFilter.setGrayFilter(_monsterAvatarView);
            }
         }
         else
         {
            if(_avatar)
            {
               _avatar.filters = null;
            }
            if(_petAvatarView)
            {
               _petAvatarView.filters = null;
            }
            if(_childrenAvatarView)
            {
               _childrenAvatarView.filters = null;
            }
            if(_monsterAvatarView)
            {
               _monsterAvatarView.filters = null;
            }
            this.mouseChildren = false;
         }
      }
      
      protected function __chatHandler(param1:PhysicsEvent) : void
      {
         if(_chatPopView)
         {
            _chatPopView.dispose();
         }
         _chatPopView = null;
         if(!_chatPopView)
         {
            _chatPopView = ChatFactory.createChatPopByType(_data.chatData,__chatBackCall);
            _chatPopView.x = -_chatPopView.displayWidth / 2;
            _chatPopView.y = _npcName.y + 20 - _chatPopView.displayHeight;
            addChild(_chatPopView);
            addChild(_npcName);
         }
      }
      
      private function __chatBackCall() : void
      {
         _chatPopView = null;
      }
      
      private function layoutTextView(param1:String) : void
      {
         if(!_npcName)
         {
            return;
         }
         var _loc2_:Object = LoaderHeaderList.avatarShowNamePos[param1];
         if(_loc2_ && _loc2_.showNamePosY)
         {
            _showNamePosY = _loc2_.showNamePosY * 1.15;
         }
         else
         {
            _showNamePosY = -125;
         }
         layoutTxtViewWithNamePosY();
      }
      
      public function updateVisible() : void
      {
         if(!_data)
         {
            return;
         }
         this.visible = _data.online;
         if(this.petAvatarView)
         {
            this.petAvatarView.visible = _data.online;
         }
         if(this.childrenAvatarView)
         {
            this.childrenAvatarView.visible = _data.online;
         }
         if(this._monsterAvatarView)
         {
            this._monsterAvatarView.visible = _data.online;
         }
      }
      
      protected function __onlineStateHandler(param1:CampaignMapEvent) : void
      {
         updateVisible();
         if(avatarView)
         {
            if(_data.online)
            {
               if(!avatarView.parent)
               {
                  addChildAt(avatarView,0);
                  this.x = _data.curPosX * 20;
                  this.y = _data.curPosY * 20;
               }
               if(petAvatarView && !petAvatarView.parent)
               {
                  if(petAvatarView.followType == 1)
                  {
                     if(petAvatarView.parent != CampaignManager.instance.mapView.walkLayer)
                     {
                        CampaignManager.instance.mapView.walkLayer.addChild(petAvatarView);
                        initPetPos();
                     }
                  }
                  else
                  {
                     addChildAt(petAvatarView,1);
                  }
               }
               if(childrenAvatarView && !childrenAvatarView.parent)
               {
                  if(childrenAvatarView.parent != CampaignManager.instance.mapView.walkLayer)
                  {
                     CampaignManager.instance.mapView.walkLayer.addChild(childrenAvatarView);
                     initChildrenPos();
                  }
               }
               if(_monsterAvatarView && !_monsterAvatarView.parent)
               {
                  if(_monsterAvatarView.parent != CampaignManager.instance.mapView.walkLayer)
                  {
                     CampaignManager.instance.mapView.walkLayer.addChild(_monsterAvatarView);
                     initMonsterPos();
                  }
               }
               __updateCampaignArmyHandler(null);
            }
            else
            {
               if(avatarView.parent)
               {
                  avatarView.parent.removeChild(avatarView);
               }
               if(petAvatarView && petAvatarView.parent)
               {
                  petAvatarView.parent.removeChild(petAvatarView);
               }
               if(childrenAvatarView && childrenAvatarView.parent)
               {
                  childrenAvatarView.parent.removeChild(childrenAvatarView);
               }
               if(_monsterAvatarView && _monsterAvatarView.parent)
               {
                  _monsterAvatarView.parent.removeChild(_monsterAvatarView);
               }
               this.x = _data.curPosX * 20;
               this.y = _data.curPosY * 20;
            }
         }
         setWeddingLockScreen();
         if(visible)
         {
            visible = _data.mapId == mapModel.mapId ? true : false;
         }
         execute();
      }
      
      private function setWeddingLockScreen() : void
      {
         if(WorldBossHelper.checkWedding(CampaignManager.instance.mapId))
         {
            if(_data.userId == MarryManager.instance.model.selfMarryInfo.userId)
            {
               MarryManager.instance.model.lockScreen = false;
            }
         }
      }
      
      public function __updateCampaignArmyHandler(param1:CampaignMapEvent) : void
      {
         if(!ArmyState.checkCampaignAttack(_data.state))
         {
            this.info.pathInfo = [];
            setFireView();
            return;
         }
         clearFireView();
      }
      
      override protected function newMove() : void
      {
         if(info.moveOverState == 1)
         {
            CampaignManager.instance.mapModel.moveToVisible(data);
         }
         else if(info.moveOverState == 2)
         {
            CampaignManager.instance.mapModel.moveToUnVisible(data);
         }
      }
      
      override public function execute() : void
      {
         super.execute();
         if(_avatar == null)
         {
            return;
         }
         if(_avatar.state == 4 && _isSitDown)
         {
            data.isSitDown = false;
            showAvatar(data);
         }
         if(_avatar && _avatar.isRending)
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
            if(_avatar.state == 4 && isSelf && (_avatar.frameX == 0 || _avatar.frameX == 2 || _avatar.frameX == 4))
            {
               SoundManager.instance.play("001");
            }
         }
         if(petAvatarView)
         {
            petAvatarView.execute();
         }
         if(_childrenAvatarView)
         {
            _childrenAvatarView.execute();
         }
         if(_monsterAvatarView)
         {
            _monsterAvatarView.execute();
         }
         if(isPlaying)
         {
            if(_hangupView && _hangupView.visible)
            {
               _hangupView.draw();
            }
            if(_attackView && _attackView.visible)
            {
               _attackView.draw();
            }
            if(_buffEffect && _buffEffect.visible)
            {
               _buffEffect.draw();
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
      
      public function hideFateSkillEffect() : void
      {
         if(_fateSkillEffect)
         {
            _fateSkillEffect.visible = false;
         }
      }
      
      public function showFateSkillEffect() : void
      {
      }
      
      override protected function nextWalk(param1:Point) : void
      {
         _currentPos = this.getTilePos();
         _data.curPosX = _currentPos.x;
         _data.curPosY = _currentPos.y;
         super.nextWalk(param1);
         this.dispatchEvent(new PhysicsEvent("WALK_NEXT_POINT",null));
      }
      
      override protected function playMovie() : void
      {
         var _loc2_:Boolean = false;
         var _loc1_:Number = NaN;
         super.playMovie();
         var _loc3_:Point = getTilePos();
         if(_loc3_.x != _currentPos.x || _loc3_.y != _currentPos.y)
         {
            dispatchEvent(new ObjectsEvent("WALK_NEXT",{"point":_loc3_}));
            _currentPos = _loc3_;
            if(!CampaignArmyState.checkDied(_data.isDie))
            {
               _loc2_ = Boolean(mapModel.walkableValueIsPara(4,this.x / 20,this.y / 20));
               _loc1_ = _loc2_ ? 0.5 : 1;
               updateBodyAlpha(_loc1_);
            }
            _data.curPosX = _currentPos.x;
            _data.curPosY = _currentPos.y;
         }
      }
      
      protected function updateBodyAlpha(param1:Number) : void
      {
         if(_avatar == null)
         {
            return;
         }
         _avatar.alpha = param1;
         if(_petAvatarView)
         {
            _petAvatarView.alpha = param1;
         }
         if(_childrenAvatarView)
         {
            _childrenAvatarView.alpha = param1;
         }
         if(_monsterAvatarView)
         {
            _monsterAvatarView.alpha = param1;
         }
      }
      
      override protected function walkOver() : void
      {
         super.walkOver();
      }
      
      override public function updateDirection(param1:Number) : void
      {
         var _loc2_:int = param1;
         super.updateDirection(_loc2_);
         if(_data)
         {
            _data.angle = _loc2_;
         }
      }
      
      public function get data() : CampaignArmy
      {
         return _data;
      }
      
      public function get aiInfo() : BaseArmyAiInfo
      {
         return _info as BaseArmyAiInfo;
      }
      
      protected function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      protected function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      protected function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function set avatarView(param1:Avatar) : void
      {
         if(_avatar)
         {
            _avatar.removeEventListener("sizeTypeChange",__onSizeTypeChangeHandler);
         }
         if(!isRenderingAvatar)
         {
            return;
         }
         super.avatarView = param1;
         if(_isPlaying)
         {
            if(_petAvatarView && _petAvatarView.parent == this)
            {
               addChild(_petAvatarView);
            }
            if(_childrenAvatarView && _childrenAvatarView.parent == this)
            {
               addChild(_childrenAvatarView);
            }
            if(_monsterAvatarView && _monsterAvatarView.parent == this)
            {
               addChild(_monsterAvatarView);
            }
         }
         _npcName && addChild(_npcName);
         _consortiaTxt && addChild(_consortiaTxt);
         showHoner();
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
      
      private function __onSizeTypeChangeHandler(param1:Event) : void
      {
         layoutTxtViewWithNamePosY();
      }
      
      private function __petLevelUpHandler(param1:PetEvent) : void
      {
         if(petAvatarView)
         {
            petAvatarView.playPetLevelUpMovie();
         }
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
         avatarView && avatarView.removeEventListener("sizeTypeChange",__onSizeTypeChangeHandler);
         removeEvent();
         if(_controller)
         {
            _controller.removeArmyView(this);
            _controller = null;
         }
         if(_data)
         {
            if(mapId == _data.mapId)
            {
               _data.curPosX = this.x / 20;
               _data.curPosY = this.y / 20;
            }
            _data.preParent = null;
            _data.armyView = null;
         }
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
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         clearFireView();
         ObjectUtils.disposeViolentMc(_bloodMc);
         _bloodMc = null;
         ObjectUtils.disposeObject(_npcName);
         _npcName = null;
         ObjectUtils.disposeObject(_hangupView);
         _hangupView = null;
         ObjectUtils.disposeObject(_buffEffect);
         _buffEffect = null;
         ObjectUtils.disposeObject(_honerTxt);
         _honerTxt = null;
         ObjectUtils.disposeObject(_honerView);
         _honerView = null;
         ObjectUtils.disposeObject(_fateSkillEffect);
         _fateSkillEffect = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_vipText);
         _vipText = null;
         ObjectUtils.disposeObject(_consortiaTxt);
         _consortiaTxt = null;
         ObjectUtils.disposeObject(_chatPopView);
         _chatPopView = null;
         ObjectUtils.disposeObject(_attackView);
         _attackView = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeObject(_regressIcon);
         _regressIcon = null;
         ObjectUtils.disposeObject(_avengerEffect);
         _avengerEffect = null;
         ObjectUtils.disposeObject(rapidView);
         rapidView = null;
         _data = null;
         _dieFilter = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
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
         if(_petAvatarView)
         {
            addChild(_petAvatarView);
         }
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
      
      public function changeSpeedTo(param1:Number = 0.5) : void
      {
         precentSpeed = param1;
         var _loc2_:int = int(ArmySpeedUtils.getMoveSpeed(_data));
         this.info.speed = Math.ceil(_loc2_ * param1);
      }
      
      public function get isMounting() : Boolean
      {
         return _isMounting;
      }
   }
}

