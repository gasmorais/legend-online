package map.outercity.view.mapphysics
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
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ArmyEvent;
   import events.PetEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import map.internals.data.ArmyChildrenInfo;
   import map.internals.data.ArmyMonsterInfo;
   import map.internals.data.ArmyPetInfo;
   import map.internals.data.PhysicsEvent;
   import map.internals.event.OuterCityEvent;
   import map.internals.interfaces.IBaseMouseEvent;
   import map.internals.utils.ArmySpeedUtils;
   import map.internals.view.hero.HeroAvatarView;
   import map.outercity.helper.mapview.OuterCityArmyViewHelper;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.mediator.hero.OuterCityBattleGetMovieMediator;
   import map.outercity.mediator.layer.OutercityNpcActivationMediator;
   import map.outercity.mediator.mapview.OuterCityPkMediator;
   import mvc.module.armyII.UserArmy;
   import yishi.datas.VersionSwitch;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.CursorManagerII;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   import yishi.view.community.PlayerMenu;
   import yishi.view.tips.MessageTipManager;
   
   public class ArmyView extends HeroAvatarView implements IBaseMouseEvent
   {
      
      public static const NAME:String = "map.outercity.view.mapphysics.ArmyView";
      
      private static const updateTrun:int = 5;
      
      private var _armyInfo:UserArmy;
      
      private var _consortiaTxt:FilterFrameText;
      
      private var _honerTxt:GradientText;
      
      private var _honerView:AppellView;
      
      private var _vipIcon:ScaleFrameImage;
      
      private var _vipText:GradientText;
      
      private var _mediatorKey:String;
      
      private var _showNamePosY:Number = -110;
      
      private var _attacking:MovieClip;
      
      protected var _isMounting:Boolean = false;
      
      private var _appellId:int = 0;
      
      protected var _petAvatarView:PetAvatarView;
      
      protected var _fateSkillEffect:SimpleAvatarView;
      
      protected var _childrenAvatarView:ChildrenAvatarView;
      
      protected var _monsterAvatarView:MonsterAvatarView;
      
      private var _count:int;
      
      private var _currentPos:Point;
      
      private var _chatPopView:Component;
      
      public function ArmyView()
      {
         super();
         initView();
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _npcName = ComponentFactory.Instance.creatComponentByStylename("core.NpcNameText");
         _consortiaTxt = ComponentFactory.Instance.creatComponentByStylename("map.campaign.ConsortiaText");
         _vipIcon = ComponentFactory.Instance.creatComponentByStylename("core.vipIcon");
         _vipText = ComponentFactory.Instance.creatComponentByStylename("core.NpcName_VipText");
         _consortiaTxt.cacheAsBitmap = true;
         _vipText.cacheAsBitmap = true;
         addChild(_npcName);
      }
      
      override protected function showName(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         super.showName(param1,param2,param3,param4,param5);
         setNpcName(param1,param5);
         armyInfo.baseHero.vipType == 1 ? _vipIcon.setFrame(1) : _vipIcon.setFrame(2);
         isVip ? setVipIcon() : clearVipIcon();
         setConsortiaName(_armyInfo.baseHero.consortiaName,param5);
         setHonerName();
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
         _vipText.text = _armyInfo.baseHero.nickName;
         _npcName.text = _armyInfo.baseHero.nickName;
         _npcName.setFrame(param2);
         addChild(_npcName);
         addChild(_vipText);
      }
      
      private function get isSelf() : Boolean
      {
         if(_armyInfo && _armyInfo.baseHero)
         {
            return _armyInfo.baseHero.userId == playerInfo.userId;
         }
         return false;
      }
      
      private function get isSelfConsortia() : Boolean
      {
         if(_armyInfo && _armyInfo.baseHero)
         {
            if(StringHelper.isNullOrEmpty(_armyInfo.baseHero.consortiaName))
            {
               return false;
            }
            if(StringHelper.isNullOrEmpty(playerInfo.consortiaName))
            {
               return false;
            }
            return _armyInfo.baseHero.consortiaName == playerInfo.consortiaName;
         }
         return false;
      }
      
      private function setConsortiaName(param1:String, param2:int) : void
      {
         if(StringHelper.isNullOrEmpty(param1))
         {
            _consortiaTxt.text = "";
            return;
         }
         _consortiaTxt.text = LanguageMgr.GetTranslation("map.avatar.view.consortiaName",param1);
         _consortiaTxt.setFrame(param2);
         if(_isPlaying)
         {
            addChild(_consortiaTxt);
         }
      }
      
      private function get appellId() : int
      {
         if(!isSelf && _armyInfo)
         {
            return _armyInfo.baseHero.appellId;
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
         if(isHoner)
         {
            _honerTxt = ComponentFactory.Instance.creatComponentByStylename(honerStyle);
            _honerTxt.cacheAsBitmap = true;
            _honerTxt.text = honerName;
            _honerView = new AppellView(_armyInfo.baseHero.appellInfo);
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
            return "map.campaign.HonerText" + _armyInfo.baseHero.appellInfo.Quality;
         }
         return "map.campaign.HonerText";
      }
      
      private function get honerName() : String
      {
         if(VersionSwitch.APPELL)
         {
            return _armyInfo.baseHero.appellInfo.Title;
         }
         return _armyInfo.baseHero.honerTemp.TemplateName;
      }
      
      private function get isHoner() : Boolean
      {
         if(VersionSwitch.APPELL)
         {
            return _armyInfo.baseHero.appellId != 0;
         }
         return _armyInfo.baseHero.honer >= _armyInfo.baseHero.firstHonerTemp.Data;
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
         return _armyInfo.baseHero.IsVipAndNoExpirt;
      }
      
      private function get consortiaName() : String
      {
         if(isSelf)
         {
            return thane.consortiaName;
         }
         return _armyInfo.baseHero.consortiaName;
      }
      
      private function layoutTxtViewWithNamePosY() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         if(!_armyInfo)
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
         else if(_consortiaTxt)
         {
            _consortiaTxt.text = "";
            if(_consortiaTxt.parent)
            {
               _consortiaTxt.parent.removeChild(_consortiaTxt);
            }
         }
         if(_vipIcon != null && _npcName != null)
         {
            _loc2_ = _vipIcon.width + _npcName.textWidth + 10;
            _loc1_ = _npcName.width - _npcName.textWidth >> 1;
            _vipIcon.y = _npcName.y;
            _vipIcon.x = -_loc2_ >> 1;
            if(isVip)
            {
               _npcName.x = _vipIcon.x + _vipIcon.width - _loc1_ + 1;
            }
            if(_vipText)
            {
               _vipText.x = _npcName.x;
               _vipText.y = _npcName.y;
            }
         }
         if(_honerView)
         {
            _honerView.x = -_armyInfo.baseHero.appellInfo.ImgWidth / 2;
            if(_armyInfo.baseHero.consortiaName)
            {
               _honerView.y = _showNamePosY - _armyInfo.baseHero.appellInfo.ImgHeight - 20;
            }
            else
            {
               _honerView.y = _showNamePosY - _armyInfo.baseHero.appellInfo.ImgHeight;
            }
         }
         if(_honerTxt)
         {
            _honerTxt.x = -_honerTxt.width / 2;
            if(_armyInfo.baseHero.consortiaName)
            {
               _honerTxt.y = _showNamePosY - 40;
            }
            else
            {
               _honerTxt.y = _showNamePosY - 20;
            }
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
         if(_honerView)
         {
            _honerView.draw();
         }
         if(_fateSkillEffect)
         {
            _fateSkillEffect.draw();
         }
      }
      
      public function get armyInfo() : UserArmy
      {
         return _armyInfo;
      }
      
      override protected function nextWalk(param1:Point) : void
      {
         var _loc2_:Array = null;
         _currentPos = this.getTilePos();
         armyInfo.curPosX = _currentPos.x;
         armyInfo.curPosY = _currentPos.y;
         super.nextWalk(new Point(param1.x / 20,param1.y / 20));
         if(_armyInfo.userId == selfUserId)
         {
            _loc2_ = [param1];
            OuterCityManager.instance.controler.sendWalkPathII(_loc2_);
         }
      }
      
      override protected function walkOver() : void
      {
         super.walkOver();
         standImp();
         if(_armyInfo.userId == selfUserId)
         {
            NotificationManager.instance.dispatchEvent(new OuterCityEvent("MOVE_OVER",new Point(this.x,this.y)));
         }
      }
      
      override protected function playMovie() : void
      {
         var _loc1_:Boolean = false;
         super.playMovie();
         _count = _count + 1;
         if(_count > 10)
         {
            _loc1_ = OutercityNpcActivationMediator.checkOutScene(this,this.getBounds(StageReferance.stage),this.parent);
            isPlaying = _loc1_;
            _count = 0;
         }
         var _loc2_:Point = getTilePos();
         if(_loc2_.x != _currentPos.x || _loc2_.y != _currentPos.y)
         {
            _currentPos = _loc2_;
            armyInfo.curPosX = _currentPos.x;
            armyInfo.curPosY = _currentPos.y;
            MsgMan.notifyObserver("ARCHAEOLOGY_WALK_NEXT");
            if(OuterCityArmyViewHelper.checkArmyEventNode(armyInfo.userId,this.info,this,_loc2_,false,armyInfo.state))
            {
               this.info.pathInfo = [];
            }
         }
      }
      
      private function showFateSkillEffect() : void
      {
         var _loc4_:int = 0;
      }
      
      private function __updatePetAvatarHandler(param1:ArmyEvent) : void
      {
         showPet(param1.data as ArmyPetInfo);
      }
      
      public function set armyInfo(param1:UserArmy) : void
      {
         if(param1.state == 2)
         {
            setFireView();
         }
         else
         {
            clearFireView();
         }
         if(_armyInfo == param1)
         {
            return;
         }
         removeEvent();
         _armyInfo = param1;
         addEvent();
         var _loc2_:Array = [];
         param1.addEventListener("CHAT_DATA",__chatHandler);
         if(param1.userId == playerInfo.userId)
         {
            _loc2_.push(OuterCityPkMediator);
            _loc2_.push(OuterCityBattleGetMovieMediator);
            thane.addEventListener("PLAYER_AVATA_CHANGE",__heroPropertyHandler);
            PlayerManager.instance.addEventListener("PET_LEVEL_UP",__petLevelUpHandler);
         }
         else
         {
            param1.baseHero.addEventListener("PLAYER_AVATA_CHANGE",__heroPropertyHandler);
         }
         param1.baseHero.addEventListener("PLAYER_INFO_UPDATE",__updateInfoHandler);
         param1.petInfo.addEventListener("PETINFO_CHANGED",__updatePetAvatarHandler);
         param1.childrenInfo.addEventListener("CHILDRENINFO_CHANGED",__updateChildrenAvatarHandler);
         param1.monsterInfo.addEventListener("MONSTER_CHANGED",__updateMonsterAvatarHandler);
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc2_,this,"map.outercity.view.mapphysics.ArmyView");
         __updateInfoHandler(null);
         showAvatar(param1);
         showPet(param1.petInfo);
         showChildren(param1.childrenInfo);
         showMonster(param1.monsterInfo);
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
      
      override protected function addEvent() : void
      {
         super.addEvent();
         if(_armyInfo == null)
         {
            return;
         }
         if(isSelf)
         {
            PlayerManager.instance.addEventListener("PET_LEVEL_UP",__petLevelUpHandler);
            thane.addEventListener("PLAYER_AVATA_CHANGE",__heroPropertyHandler);
         }
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         if(_armyInfo == null)
         {
            return;
         }
         if(isSelf)
         {
            thane.removeEventListener("PLAYER_AVATA_CHANGE",__heroPropertyHandler);
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
            petAvatarView.followTarget = this;
            petAvatarView.isSelf = this.isSelf;
            petAvatarView.petTemplate = param1.petTemplate;
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
                  if(_petAvatarView.parent != OuterCityManager.instance.mapView.worldWalkLayer)
                  {
                     OuterCityManager.instance.mapView.worldWalkLayer.addChild(_petAvatarView);
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
            childrenAvatarView.isFlying = false;
            childrenAvatarView.isSelf = this.isSelf;
            childrenAvatarView.followTarget = this;
            if(isPlaying)
            {
               if(_childrenAvatarView.parent != OuterCityManager.instance.mapView.worldWalkLayer)
               {
                  OuterCityManager.instance.mapView.worldWalkLayer.addChild(_childrenAvatarView);
                  initChildrenPos();
               }
            }
            _loc4_ = 1;
            _loc3_ = param1.childrenName ? param1.childrenName : "";
            childrenAvatarView.showAvatar(_loc3_,_loc4_,_loc2_,param1.childrenGrade,param1.growthGrade2);
         }
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
                  if(_monsterAvatarView.parent != OuterCityManager.instance.mapView.worldWalkLayer)
                  {
                     OuterCityManager.instance.mapView.worldWalkLayer.addChild(_monsterAvatarView);
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
      
      private function addChildrenToStage() : void
      {
         if(_childrenAvatarView.parent != OuterCityManager.instance.mapView.worldWalkLayer)
         {
            OuterCityManager.instance.mapView.worldWalkLayer.addChild(_childrenAvatarView);
         }
      }
      
      private function addMonsterToStage() : void
      {
         if(_monsterAvatarView.parent != OuterCityManager.instance.mapView.worldWalkLayer)
         {
            OuterCityManager.instance.mapView.worldWalkLayer.addChild(_monsterAvatarView);
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
      
      private function initPetPos() : void
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
      
      private function addPetToStage() : void
      {
         if(petAvatarView.followType == 1)
         {
            if(_petAvatarView.parent != OuterCityManager.instance.mapView.worldWalkLayer)
            {
               OuterCityManager.instance.mapView.worldWalkLayer.addChild(_petAvatarView);
            }
         }
         else
         {
            addChild(petAvatarView);
         }
      }
      
      private function __petLevelUpHandler(param1:PetEvent) : void
      {
         if(petAvatarView)
         {
            petAvatarView.playPetLevelUpMovie();
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
            data.childrenInfo.childrenName = _loc2_.childrenName;
            data.childrenInfo.childrenJob = _loc2_.childrenJob;
            data.childrenInfo.childrenSex = _loc2_.childrenSex;
            data.childrenInfo.childrenGrade = _loc2_.childrenGrade;
            data.monsterInfo.monsterTemplateId = _loc2_.monsterTempteId;
            data.petInfo.commit();
            data.childrenInfo.commit();
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
         showName(_armyInfo.nickName,_armyInfo.baseHero.grades,_armyInfo.baseHero.state,0,_loc3_);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function showAvatar(param1:UserArmy) : void
      {
         var _loc19_:int = 0;
         var _loc12_:Boolean = false;
         var _loc15_:ThaneInfo = null;
         var _loc18_:String = null;
         var _loc13_:String = null;
         var _loc17_:String = null;
         var _loc6_:String = null;
         var _loc14_:Object = null;
         var _loc10_:String = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc11_:int = 0;
         _isMounting = false;
         this.info.speed = ArmySpeedUtils.getMoveSpeed(param1);
         if(_armyInfo != null && _armyInfo.userId == playerInfo.userId)
         {
            _loc15_ = thane;
         }
         else
         {
            _loc15_ = param1.baseHero;
            if(param1.mountTemplate)
            {
               thane.avatarChange["mount"] = true;
            }
         }
         var _loc16_:String = _loc15_.bodyEquipAvata;
         var _loc3_:String = _loc15_.armsEquipAvata;
         _loc19_ = int(_loc15_.changeShapeId);
         _loc12_ = !_loc15_.hideFashion;
         if(!_loc15_.templateInfo)
         {
            return;
         }
         var _loc5_:int = int(_loc15_.templateInfo.Sexs);
         var _loc22_:int = int(_loc15_.templateInfo.Job);
         var _loc23_:String = _loc3_;
         var _loc8_:String = _loc16_;
         if(_loc16_ == "")
         {
            _loc16_ = JobType.getDefaultBodyEquipNameByJob(_loc22_);
         }
         if(_loc3_ == "")
         {
            _loc3_ = JobType.getDefaultArmysEquipNameByJob(_loc22_);
         }
         if(_loc16_.indexOf(PathManager.DRAGONIC) != -1)
         {
            _loc18_ = JobType.getDefaultHairUpByJob(4);
            _loc13_ = JobType.getDefaultHairDownByJob(4);
            _loc17_ = JobType.getDefaultCloakEquipNameByJob(4);
         }
         else
         {
            _loc18_ = JobType.getDefaultHairUpByJob(_loc22_);
            _loc13_ = JobType.getDefaultHairDownByJob(_loc22_);
            _loc17_ = JobType.getDefaultCloakEquipNameByJob(_loc22_);
         }
         var _loc7_:String = _loc15_.wingAvata;
         var _loc20_:String = "";
         if(_loc15_.petTemplate)
         {
            _loc6_ = _loc15_.petTemplate.PetAvatar;
         }
         var _loc9_:int = isSelf ? 10 : 4;
         if(_loc19_ > 0)
         {
            if(!avatarView)
            {
               avatarView = new HeroAvatar(true,_loc16_,2,_loc5_,true,_loc22_);
               avatarView.currentMountId = param1.mountTemplate ? param1.mountTemplate.TemplateId : -1;
            }
            _loc16_ = _loc19_ + "";
            avatarView.type = 2;
            _loc3_ = "";
            avatarView.removeAllAvatar();
            _loc10_ = PathManager.getAvatarResourcePath(_loc16_,_loc5_,1,"body",_loc22_,2);
            _loc14_ = createResourceLoadInfo(_loc10_,[0,0,0,0,0],[0,0,0],"body");
            LoaderManagerII.instance.load(_loc10_,4,_loc9_,loaderCompleteHandler,null,null,_loc14_);
            return;
         }
         if(!avatarView)
         {
            avatarView = new HeroAvatar(true,_loc16_,1,_loc5_,true,_loc22_);
         }
         avatarView.type = 1;
         avatarView.currentMountId = param1.mountTemplate ? param1.mountTemplate.TemplateId : -1;
         for(var _loc21_:String in _loc15_.avatarChange)
         {
            avatarView.removeAvatar(_loc21_);
         }
         _loc2_ = 1;
         _loc4_ = 1;
         _loc11_ = 1;
         if(_loc12_)
         {
            if(_loc15_.bodyFashionAvata)
            {
               _loc16_ = _loc15_.bodyFashionAvata;
               _loc17_ = "";
               _loc2_ = 2;
            }
            if(_loc15_.armsFashionAvata)
            {
               _loc3_ = _loc15_.armsFashionAvata;
               _loc4_ = 2;
            }
            if(_loc15_.hairFashionAvata)
            {
               _loc18_ = _loc15_.hairFashionAvata + "up";
               _loc13_ = _loc15_.hairFashionAvata + "down";
               _loc11_ = 2;
            }
         }
         if(param1.mountTemplate)
         {
            (avatarView as HeroAvatar).isStandPosMount = param1.mountTemplate.useStandPose;
            if(!param1.mountTemplate.useStandPose)
            {
               _loc16_ = JobType.getMapMountEquipment(_loc16_);
               _loc3_ = JobType.getMapMountEquipment(_loc3_);
               _loc18_ = JobType.getMapMountEquipment(_loc18_);
               _loc13_ = JobType.getMapMountEquipment(_loc13_);
               _loc17_ = JobType.getMapMountEquipment(_loc17_);
               _loc7_ = JobType.getMapMountEquipment(_loc7_);
            }
            if(!_loc20_)
            {
               _loc20_ = param1.mountTemplate.AvatarPath == "" ? JobType.getDefaultMount() : param1.mountTemplate.AvatarPath;
            }
            _isMounting = true;
         }
         else
         {
            (avatarView as HeroAvatar).isStandPosMount = false;
         }
         if(_loc7_)
         {
            _loc10_ = PathManager.getAvatarResourcePath(_loc7_,_loc5_,1,"wing",_loc22_,1);
            _loc14_ = createResourceLoadInfo(_loc10_,AvatarStaticData.getBaseNumByType("Stand","wing",_isMounting),AvatarStaticData.getBaseNumByType("Walk","wing",_isMounting),"wing");
            LoaderManagerII.instance.load(_loc10_,4,_loc9_,loaderCompleteHandler,null,null,_loc14_);
         }
         else if(_loc17_)
         {
            _loc10_ = PathManager.getAvatarResourcePath(_loc17_,_loc5_,1,"cloak",_loc22_,1);
            _loc14_ = createResourceLoadInfo(_loc10_,AvatarStaticData.getBaseNumByType("Stand","cloak",_isMounting),AvatarStaticData.getBaseNumByType("Walk","cloak",_isMounting),"cloak");
            LoaderManagerII.instance.load(_loc10_,4,_loc9_,loaderCompleteHandler,null,null,_loc14_);
         }
         if(_loc18_)
         {
            _loc10_ = PathManager.getAvatarResourcePath(_loc18_,_loc5_,_loc11_,"hairUp",_loc22_,1);
            _loc14_ = createResourceLoadInfo(_loc10_,AvatarStaticData.getBaseNumByType("Stand","hairUp",_isMounting),AvatarStaticData.getBaseNumByType("Walk","hairUp",_isMounting),"hairUp");
            LoaderManagerII.instance.load(_loc10_,4,_loc9_,loaderCompleteHandler,null,null,_loc14_);
         }
         if(_loc13_)
         {
            _loc10_ = PathManager.getAvatarResourcePath(_loc13_,_loc5_,_loc11_,"hairDown",_loc22_,1);
            _loc14_ = createResourceLoadInfo(_loc10_,AvatarStaticData.getBaseNumByType("Stand","hairDown",_isMounting),AvatarStaticData.getBaseNumByType("Walk","hairDown",_isMounting),"hairDown");
            LoaderManagerII.instance.load(_loc10_,4,_loc9_,loaderCompleteHandler,null,null,_loc14_);
         }
         if(_loc3_)
         {
            _loc10_ = PathManager.getAvatarResourcePath(_loc3_,_loc5_,_loc4_,"army",_loc22_,1);
            _loc14_ = createResourceLoadInfo(_loc10_,AvatarStaticData.getBaseNumByType("Stand","army",_isMounting),AvatarStaticData.getBaseNumByType("Walk","army",_isMounting),"army");
            LoaderManagerII.instance.load(_loc10_,4,_loc9_,loaderCompleteHandler,null,null,_loc14_);
         }
         if(_loc16_)
         {
            _loc10_ = PathManager.getAvatarResourcePath(_loc16_,_loc5_,_loc2_,"body",_loc22_,1);
            _loc14_ = createResourceLoadInfo(_loc10_,AvatarStaticData.getBaseNumByType("Stand","body",_isMounting),AvatarStaticData.getBaseNumByType("Walk","body",_isMounting),"body");
            LoaderManagerII.instance.load(_loc10_,4,_loc9_,loaderCompleteHandler,null,null,_loc14_);
         }
         if(_loc7_)
         {
            avatarView.updateAvatar(_loc7_,AvatarStaticData.getBaseNumByType("Stand","wing",_isMounting),AvatarStaticData.getBaseNumByType("Walk","wing",_isMounting),"wing",null,1);
         }
         else if(_loc17_)
         {
            avatarView.updateAvatar(_loc17_,AvatarStaticData.getBaseNumByType("Stand","cloak",_isMounting),AvatarStaticData.getBaseNumByType("Walk","cloak",_isMounting),"cloak",null,1);
         }
         if(_loc20_)
         {
            _loc10_ = PathManager.getAvatarResourcePath(_loc20_,_loc5_,1,"mount",_loc22_,1);
            _loc14_ = createResourceLoadInfo(_loc10_,AvatarStaticData.getBaseNumByType("Stand","mount",_isMounting),AvatarStaticData.getBaseNumByType("Walk","mount",_isMounting),"mount");
            LoaderManagerII.instance.load(_loc10_,4,_loc9_,loaderCompleteHandler,null,null,_loc14_);
         }
         avatarView.scaleX = avatarView.scaleY = 0.85;
         avatarView.mouseChildren = false;
         avatarView.mouseEnabled = false;
      }
      
      override public function set avatarView(param1:Avatar) : void
      {
         if(_avatar)
         {
            _avatar.removeEventListener("sizeTypeChange",__onSizeTypeChangeHandler);
         }
         super.avatarView = param1;
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
         _npcName && addChild(_npcName);
         _consortiaTxt && addChild(_consortiaTxt);
         showHoner();
         _vipIcon && addChild(_vipIcon);
         _vipText && addChild(_vipText);
         param1.addEventListener("sizeTypeChange",__onSizeTypeChangeHandler);
      }
      
      private function __onSizeTypeChangeHandler(param1:Event) : void
      {
         layoutTxtViewWithNamePosY();
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
      
      private function __heroPropertyHandler(param1:PlayerEvent) : void
      {
         if(_armyInfo)
         {
            showAvatar(_armyInfo);
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
      
      override public function dispose() : void
      {
         thane.removeEventListener("PLAYER_AVATA_CHANGE",__heroPropertyHandler);
         if(_armyInfo)
         {
            _armyInfo.baseHero.removeEventListener("PLAYER_AVATA_CHANGE",__heroPropertyHandler);
            _armyInfo.baseHero.removeEventListener("PLAYER_INFO_UPDATE",__updateInfoHandler);
            _armyInfo.removeEventListener("CHAT_DATA",__chatHandler);
            PlayerManager.instance.removeEventListener("PET_LEVEL_UP",__petLevelUpHandler);
         }
         if(_avatar)
         {
            _avatar.removeEventListener("sizeTypeChange",__onSizeTypeChangeHandler);
         }
         if(_armyInfo)
         {
            OuterCityManager.instance.model.removeWorldArmyById(_armyInfo.id);
            _armyInfo.armyView = null;
         }
         _armyInfo.petInfo.removeEventListener("PETINFO_CHANGED",__updatePetAvatarHandler);
         _armyInfo.childrenInfo.removeEventListener("CHILDRENINFO_CHANGED",__updateChildrenAvatarHandler);
         _armyInfo.monsterInfo.removeEventListener("MONSTER_CHANGED",__updateMonsterAvatarHandler);
         ObjectUtils.disposeViolentMc(_attacking);
         _attacking = null;
         if(isDie)
         {
            return;
         }
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         _armyInfo = null;
         if(_petAvatarView)
         {
            _petAvatarView.dispose();
            _petAvatarView = null;
         }
         ObjectUtils.disposeObject(_honerTxt);
         _honerTxt = null;
         ObjectUtils.disposeObject(_honerView);
         _honerView = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_vipText);
         _vipText = null;
         ObjectUtils.disposeObject(_consortiaTxt);
         _consortiaTxt = null;
         ObjectUtils.disposeObject(_fateSkillEffect);
         _fateSkillEffect = null;
         ObjectUtils.disposeObject(_childrenAvatarView);
         _childrenAvatarView = null;
         ObjectUtils.disposeObject(_monsterAvatarView);
         _monsterAvatarView = null;
         super.dispose();
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
         if((_avatar as HeroAvatar).getCurrentPixels() < 50)
         {
            if(CursorManagerII.instance.currentState != "PVP_ATTACT_CURSOR")
            {
               OuterCityManager.instance.mapView.worldWalkLayer.mouseClickHandler(null);
            }
            return false;
         }
         if(_armyInfo.baseHero.userId != PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            if(CursorManagerII.instance.currentState == "PVP_ATTACT_CURSOR")
            {
               OuterCityManager.instance.model.selectPkArmy = _armyInfo;
               return true;
            }
         }
         var _loc3_:ThaneInfo = _armyInfo.baseHero;
         if(_loc3_.userId == selfUserId)
         {
            return false;
         }
         var _loc2_:PlayerMenu = new PlayerMenu(false,false,false,false,true);
         _loc2_.setData(_loc3_);
         _loc2_.x = StageReferance.stage.mouseX + _loc2_.width >= StageReferance.stageWidth ? StageReferance.stageWidth - _loc2_.width : Number(StageReferance.stage.mouseX);
         _loc2_.y = StageReferance.stage.mouseY + _loc2_.height >= StageReferance.stageHeight ? StageReferance.stageHeight - _loc2_.height : Number(StageReferance.stage.mouseY);
         LayerManager.Instance.addToLayer(_loc2_,7);
         return true;
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         if(_armyInfo.baseHero.userId == selfUserId)
         {
            this.buttonMode = false;
            this.mouseChildren = this.mouseEnabled = false;
            return false;
         }
         if(_avatar)
         {
            if(!param1)
            {
               _filter.setLightFilter(_avatar);
               return true;
            }
            if((_avatar as HeroAvatar).getCurrentPixels() > 50)
            {
               _filter.setLightFilter(_avatar);
               return true;
            }
            _filter.setNormalFilter(_avatar);
         }
         return false;
      }
      
      private function get selfUserId() : int
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.userId;
      }
      
      private function returnCastle() : void
      {
         OuterCityManager.instance.controler.sendReturnHomeArmy();
      }
      
      public function armyBack() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("map.ArmyView.command01");
         MessageTipManager.instance().show(_loc1_);
      }
      
      private function __chatHandler(param1:PhysicsEvent) : void
      {
         if(_armyInfo.chatData == null)
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
            _chatPopView = ChatFactory.createChatPopByType(_armyInfo.chatData,chatBack);
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
            }
         }
      }
      
      private function chatBack() : void
      {
         _chatPopView = null;
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
      
      override public function set isPlaying(param1:Boolean) : void
      {
         if(_isPlaying == param1)
         {
            return;
         }
         super.isPlaying = param1;
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
            if(_consortiaTxt)
            {
               addChild(_consortiaTxt);
            }
            if(_fateSkillEffect)
            {
               addChildAt(_fateSkillEffect,0);
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
            if(_chatPopView)
            {
               addChild(_chatPopView);
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
            if(_chatPopView && _chatPopView.parent)
            {
               _chatPopView.parent.removeChild(_chatPopView);
            }
            if(_consortiaTxt && _consortiaTxt.parent)
            {
               _consortiaTxt.parent.removeChild(_consortiaTxt);
            }
            if(_fateSkillEffect && _fateSkillEffect.parent)
            {
               _fateSkillEffect.parent.removeChild(_fateSkillEffect);
            }
            hideHoner();
            if(_vipIcon && _vipIcon.parent)
            {
               _vipIcon.parent.removeChild(_vipIcon);
            }
            if(_vipText && _vipText.parent)
            {
               _vipText.parent.removeChild(_vipText);
            }
         }
      }
      
      protected function setFireView() : void
      {
         if(!_attacking)
         {
            _attacking = ComponentFactory.Instance.creatCustomObject("asset.outercity.AttackingAsset");
            _attacking.x = 0;
            _attacking.y = -110;
         }
         if(_isPlaying)
         {
            addChild(_attacking);
         }
         _attacking.play();
      }
      
      protected function clearFireView() : void
      {
         if(_attacking)
         {
            if(_attacking.parent)
            {
               _attacking.parent.removeChild(_attacking);
            }
            _attacking.stop();
            _attacking = null;
         }
      }
      
      public function get data() : UserArmy
      {
         return _armyInfo;
      }
      
      public function get isMounting() : Boolean
      {
         return _isMounting;
      }
      
      public function setAllVisible(param1:Boolean) : void
      {
         if(this.petAvatarView != null)
         {
            this.petAvatarView.visible = param1;
         }
         if(this._fateSkillEffect != null)
         {
            this._fateSkillEffect.visible = param1;
         }
         if(this.childrenAvatarView != null)
         {
            this.childrenAvatarView.visible = param1;
         }
         if(this._monsterAvatarView != null)
         {
            this._monsterAvatarView.visible = param1;
         }
      }
   }
}

