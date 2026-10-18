package stage3drender.avatar
{
   import avatar.data.AvatarPartInfo;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.utils.ObjectUtils;
   import events.ArmyEvent;
   import events.ObjectsEvent;
   import flash.events.Event;
   import flash.geom.Point;
   import map.internals.data.ArmyPetInfo;
   import map.internals.utils.ArmySpeedUtils;
   import map.internals.view.hero.BaseNameView;
   import map.internals.view.hero.HeroNameView;
   import map.space.SpaceManager;
   import map.space.data.SpaceArmy;
   import map.space.mediator.hero.SpacePlayerWalkMediator;
   import stage3drender.Global;
   import stage3drender.SimpleAtfLoader;
   import stage3drender.utils.AtfDecoder;
   import starling.display.Image;
   import starling.textures.Texture;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class SpaceAvatar extends AvatarRender
   {
      
      public static const NAME:String = "stage3drender.avatar.SpaceAvatar";
      
      private static const WALKSENDSERVER:int = 200;
      
      private var _mediatorKey:String;
      
      private var _fateImg:SimpleMoveiClip;
      
      private var _data:SpaceArmy;
      
      private var _shadowImg:Image;
      
      private var _selectedImg:Image;
      
      private var _isFlying:Boolean;
      
      private var thaneInfo:ThaneInfo;
      
      private var isShaping:Boolean;
      
      private var upgradeTemp:UpgradeTemplateInfo;
      
      private var _walkedPointNum:int = 0;
      
      private var _currentPos:Point;
      
      public function SpaceAvatar()
      {
         super();
         _shadowImg = new Image(Global.avatarTextureDic["mount_shadow"]);
         _shadowImg.touchable = false;
         _shadowImg.x = -91;
         _shadowImg.y = -33;
         addChildAt(_shadowImg,0);
         _nameView = new HeroNameView();
         _nameView.heroView = this;
         Global.nameLayer.addChild(_nameView);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function get isSelf() : Boolean
      {
         if(_data)
         {
            return _data.userId == playerInfo.userId;
         }
         return false;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get data() : SpaceArmy
      {
         return _data;
      }
      
      public function set data(param1:SpaceArmy) : void
      {
         _data = param1;
         if(_nameView)
         {
            (_nameView as HeroNameView).data = _data;
         }
         _avatarInfo = new AvatarInfo();
         this.debug = isSelf;
         addDataEvent();
         showAvatar();
         if(data)
         {
            showPet(data.petInfo);
         }
         else
         {
            showPet(null);
         }
         touchable = !isSelf;
      }
      
      private function addDataEvent() : void
      {
         if(!_data)
         {
            return;
         }
         if(isSelf)
         {
            loaderPriority = 10;
            thane.addEventListener("PLAYER_AVATA_CHANGE",__changeAvatarHandler);
         }
         else
         {
            loaderPriority = 4;
            _data.baseHero.addEventListener("PLAYER_AVATA_CHANGE",__changeAvatarHandler);
         }
         _data.petInfo.addEventListener("PETINFO_CHANGED",__updatePetAvatarHandler);
      }
      
      private function removeDataEvent() : void
      {
         if(!_data)
         {
            return;
         }
         if(isSelf)
         {
            thane.removeEventListener("PLAYER_AVATA_CHANGE",__changeAvatarHandler);
         }
         else
         {
            _data.baseHero.removeEventListener("PLAYER_AVATA_CHANGE",__changeAvatarHandler);
         }
         _data.petInfo.removeEventListener("PETINFO_CHANGED",__updatePetAvatarHandler);
      }
      
      private function __changeAvatarHandler(param1:PlayerEvent) : void
      {
         showAvatar();
      }
      
      private function __updatePetAvatarHandler(param1:ArmyEvent) : void
      {
         showPet(param1.currentTarget as ArmyPetInfo);
      }
      
      private function showAvatar() : void
      {
         var _loc16_:int = 0;
         var _loc9_:Boolean = false;
         var _loc15_:String = null;
         var _loc10_:String = null;
         var _loc14_:String = null;
         var _loc11_:AvatarPartInfo = null;
         var _loc20_:String = null;
         var _loc1_:String = null;
         if(_isFlying)
         {
            aiInfo.pathInfo = [];
         }
         _isFlying = false;
         aiInfo.speed = ArmySpeedUtils.getMoveSpeed(_data);
         var _loc12_:Boolean = this.isMount;
         if(isSelf)
         {
            thaneInfo = thane;
            _mediatorKey = MediatorMananger.instance.registerMediatorList([SpacePlayerWalkMediator],this,"stage3drender.avatar.SpaceAvatar");
         }
         else
         {
            thaneInfo = data.baseHero;
            if(data.mountTemplate)
            {
               thane.avatarChange["mount"] = true;
            }
         }
         var _loc13_:String = thaneInfo.bodyEquipAvata;
         var _loc3_:String = thaneInfo.armsEquipAvata;
         _loc16_ = int(thaneInfo.changeShapeId);
         _loc9_ = !thaneInfo.hideFashion;
         if(!data.baseHero.templateInfo)
         {
            return;
         }
         var _loc5_:int = int(data.baseHero.templateInfo.Sexs);
         var _loc18_:int = int(data.baseHero.templateInfo.Job);
         var _loc19_:String = _loc3_;
         var _loc7_:String = _loc13_;
         if(_loc13_ == "")
         {
            _loc13_ = JobType.getDefaultBodyEquipNameByJob(_loc18_);
         }
         if(_loc3_ == "")
         {
            _loc3_ = JobType.getDefaultArmysEquipNameByJob(_loc18_);
         }
         if(_loc13_.indexOf(PathManager.DRAGONIC) != -1)
         {
            _loc15_ = JobType.getDefaultHairUpByJob(4);
            _loc10_ = JobType.getDefaultHairDownByJob(4);
            _loc14_ = JobType.getDefaultCloakEquipNameByJob(4);
         }
         else
         {
            _loc15_ = JobType.getDefaultHairUpByJob(_loc18_);
            _loc10_ = JobType.getDefaultHairDownByJob(_loc18_);
            _loc14_ = JobType.getDefaultCloakEquipNameByJob(_loc18_);
         }
         var _loc6_:String = thaneInfo.wingAvata;
         var _loc17_:String = "";
         if(_loc16_ > 0)
         {
            clearAllParts();
            _avatarInfo.clear();
            _loc20_ = "body";
            _loc11_ = _avatarInfo.getPartInfo(_loc20_);
            if(!_loc11_)
            {
               _loc11_ = new AvatarPartInfo();
            }
            _loc1_ = PathManager.getAvatarResourcePath(_loc16_.toString(),_loc5_,1,"body",_loc18_,2);
            _loc1_ = _loc1_.replace(".bswf","");
            if(_loc11_.url != _loc1_)
            {
               _loc11_.partPosition = _loc20_;
               _loc11_.url = _loc1_;
               _avatarInfo.addPartInfo(_loc11_);
            }
            _shadowImg.texture = Global.avatarTextureDic["shadow"];
            _shadowImg.x = -45;
            _shadowImg.y = -32;
            _shadowImg.readjustSize();
            startLoad();
            isShaping = true;
            return;
         }
         var _loc2_:int = 1;
         var _loc4_:int = 1;
         var _loc8_:int = 1;
         if(_loc9_)
         {
            if(thaneInfo.bodyFashionAvata)
            {
               _loc13_ = thaneInfo.bodyFashionAvata;
               _loc14_ = "";
               _loc2_ = 2;
            }
            if(thaneInfo.armsFashionAvata)
            {
               _loc3_ = thaneInfo.armsFashionAvata;
               _loc4_ = 2;
            }
            if(thaneInfo.hairFashionAvata)
            {
               _loc15_ = thaneInfo.hairFashionAvata + "up";
               _loc10_ = thaneInfo.hairFashionAvata + "down";
               _loc8_ = 2;
            }
         }
         if(data.mountTemplate)
         {
            isMount = true;
            _loc13_ = JobType.getMapMountEquipment(_loc13_);
            _loc3_ = JobType.getMapMountEquipment(_loc3_);
            _loc15_ = JobType.getMapMountEquipment(_loc15_);
            _loc10_ = JobType.getMapMountEquipment(_loc10_);
            _loc14_ = JobType.getMapMountEquipment(_loc14_);
            _loc6_ = JobType.getMapMountEquipment(_loc6_);
            _loc17_ = data.mountTemplate.AvatarPath == "" ? JobType.getDefaultMount() : data.mountTemplate.AvatarPath;
            _isFlying = SpaceManager.instance.model.isFlying(_data.mountTemplateId);
         }
         else
         {
            isMount = false;
         }
         if(_loc12_ != isMount || isShaping)
         {
            clearAllParts();
            _avatarInfo.clear();
         }
         isShaping = false;
         if(_loc6_)
         {
            _loc20_ = isMount ? "wing_mount" : "wing";
            _loc11_ = _avatarInfo.getPartInfo(_loc20_);
            if(!_loc11_)
            {
               _loc11_ = new AvatarPartInfo();
            }
            _loc1_ = PathManager.getAvatarResourcePath(_loc6_,_loc5_,1,"wing",_loc18_,1,"");
            if(_loc11_.url != _loc1_)
            {
               _loc11_.partPosition = _loc20_;
               _loc11_.url = _loc1_;
               _avatarInfo.addPartInfo(_loc11_);
            }
         }
         else if(_loc14_)
         {
            _loc20_ = isMount ? "cloak_mount" : "cloak";
            _loc11_ = _avatarInfo.getPartInfo(_loc20_);
            if(!_loc11_)
            {
               _loc11_ = new AvatarPartInfo();
            }
            _loc1_ = PathManager.getAvatarResourcePath(_loc14_,_loc5_,1,"cloak",_loc18_,1,"");
            if(_loc11_.url != _loc1_)
            {
               _loc11_.partPosition = _loc20_;
               _loc11_.url = _loc1_;
               _avatarInfo.addPartInfo(_loc11_);
            }
         }
         if(_loc10_)
         {
            _loc20_ = isMount ? "hair_down_mount" : "hair_down";
            _loc11_ = _avatarInfo.getPartInfo(_loc20_);
            if(!_loc11_)
            {
               _loc11_ = new AvatarPartInfo();
            }
            _loc1_ = PathManager.getAvatarResourcePath(_loc10_,_loc5_,_loc8_,"hairDown",_loc18_,1,"");
            if(_loc11_.url != _loc1_)
            {
               _loc11_.partPosition = _loc20_;
               _loc11_.url = _loc1_;
               _avatarInfo.addPartInfo(_loc11_);
            }
         }
         if(_loc15_)
         {
            _loc20_ = isMount ? "hair_up_mount" : "hair_up";
            _loc11_ = _avatarInfo.getPartInfo(_loc20_);
            if(!_loc11_)
            {
               _loc11_ = new AvatarPartInfo();
            }
            _loc1_ = PathManager.getAvatarResourcePath(_loc15_,_loc5_,_loc8_,"hairUp",_loc18_,1,"");
            if(_loc11_.url != _loc1_)
            {
               _loc11_.partPosition = _loc20_;
               _loc11_.url = _loc1_;
               _avatarInfo.addPartInfo(_loc11_);
            }
         }
         if(_loc3_)
         {
            _loc20_ = isMount ? "arms_mount" : "arms";
            _loc11_ = _avatarInfo.getPartInfo(_loc20_);
            if(!_loc11_)
            {
               _loc11_ = new AvatarPartInfo();
            }
            _loc1_ = PathManager.getAvatarResourcePath(_loc3_,_loc5_,_loc4_,"army",_loc18_,1,"");
            if(_loc11_.url != _loc1_)
            {
               _loc11_.partPosition = _loc20_;
               _loc11_.url = _loc1_;
               _avatarInfo.addPartInfo(_loc11_);
            }
         }
         if(_loc13_)
         {
            _loc20_ = isMount ? "body_mount" : "body";
            _loc11_ = _avatarInfo.getPartInfo(_loc20_);
            if(!_loc11_)
            {
               _loc11_ = new AvatarPartInfo();
            }
            _loc1_ = PathManager.getAvatarResourcePath(_loc13_,_loc5_,_loc2_,"body",_loc18_,1,"");
            if(_loc11_.url != _loc1_)
            {
               _loc11_.partPosition = _loc20_;
               _loc11_.url = _loc1_;
               _avatarInfo.addPartInfo(_loc11_);
            }
         }
         if(_loc17_)
         {
            _loc20_ = "mount";
            _loc11_ = _avatarInfo.getPartInfo(_loc20_);
            if(!_loc11_)
            {
               _loc11_ = new AvatarPartInfo();
            }
            _loc1_ = PathManager.getAvatarResourcePath(_loc17_,_loc5_,1,"mount",_loc18_,1,"");
            if(_loc11_.url != _loc1_)
            {
               _loc11_.partPosition = _loc20_;
               _loc11_.url = _loc1_;
               _avatarInfo.addPartInfo(_loc11_);
            }
         }
         if(isMount)
         {
            _shadowImg.texture = Global.avatarTextureDic["mount_shadow"];
            _shadowImg.x = -91;
            _shadowImg.y = -33;
         }
         else
         {
            _shadowImg.texture = Global.avatarTextureDic["shadow"];
            _shadowImg.x = -45;
            _shadowImg.y = -32;
         }
         _shadowImg.readjustSize();
         startLoad();
      }
      
      override protected function showPet(param1:ArmyPetInfo) : void
      {
         super.showPet(param1);
         if(!_petPart)
         {
            return;
         }
         _petPart.followTarget = this;
         _petPart.isSelf = this.isSelf;
         _petPart.petTemplate = param1.petTemplate;
         _petPart.changeFollowType(param1.petTemplate);
         if(_petPart.followType == 1)
         {
            if(_petPart.parent != SpaceManager.instance.controller.walkLayer)
            {
               SpaceManager.instance.controller.walkLayer.addChild(_petPart);
               initPetPos();
            }
         }
         else
         {
            addChild(_petPart);
         }
         var _loc2_:String = param1.petName;
         var _loc3_:int = int(param1.petQuaity);
         var _loc4_:String = param1.petTemplate.PetAvatar;
         _petPart.showAvatar(_loc2_,_loc3_,_loc4_);
      }
      
      private function initPetPos() : void
      {
         var _loc1_:int = -1;
         _petPart.x = data.curPosX * 20 + _loc1_ * 100;
         _petPart.y = data.curPosY * 20;
      }
      
      override protected function defaultView() : void
      {
         if(_data)
         {
            angle = _data.angle;
         }
         action("S",_currentDirection);
         showOther();
         if(_nameView)
         {
            _nameView.layout();
         }
      }
      
      override protected function showOther() : void
      {
         super.showOther();
         if(!_data)
         {
            return;
         }
         showFate();
      }
      
      private function showFate() : void
      {
         var _loc5_:int = 0;
         if(!_data.baseHero.fateSkill)
         {
            return;
         }
         var _loc1_:Array = _data.baseHero.fateSkill.split(",");
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         for each(var _loc6_:String in _loc1_)
         {
            _loc5_ = int(_loc6_.substr(_loc6_.length - 2,2));
            if(_loc5_ > _loc8_)
            {
               _loc8_ = _loc5_;
               _loc3_ = int(_loc6_);
            }
         }
         var _loc7_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_loc3_);
         if(!_loc7_ || _loc7_.Grades == 0)
         {
            return;
         }
         upgradeTemp = TempleteManager.instance.getTemplateByLevelAndType(_loc7_.Grades,26);
         if(StringHelper.isNullOrEmpty(upgradeTemp.TemplateName))
         {
            return;
         }
         var _loc2_:String = PathManager.getFateWalkPath(upgradeTemp.ActiveObject,"").toLowerCase();
         if(LoaderManagerII.instance.isLoaded(_loc2_))
         {
            addFate(_loc2_);
            return;
         }
         var _loc4_:SimpleAtfLoader = new SimpleAtfLoader(5);
         _loc4_.addEventListener("complete",__fateCompleteHandler);
         _loc4_.load(_loc2_);
      }
      
      private function __fateCompleteHandler(param1:Event) : void
      {
         var _loc2_:SimpleAtfLoader = param1.currentTarget as SimpleAtfLoader;
         if(_loc2_.atfData)
         {
            AtfDecoder.decode(_loc2_.path,_loc2_.atfData,_loc2_.atlData);
         }
         addFate(_loc2_.path);
      }
      
      private function addFate(param1:String) : void
      {
         if(_fateImg)
         {
            if(_fateImg.parent)
            {
               _fateImg.parent.removeChild(_fateImg);
            }
            _fateImg.dispose();
         }
         _fateImg = new SimpleMoveiClip(1);
         _fateImg.changeAnimation(Global.avatarTextureDic[param1],Global.avatarPartPostion[param1]);
         var _loc2_:Array = upgradeTemp.TemplateName.split("|");
         _fateImg.x = -_loc2_[3];
         _fateImg.y = -_loc2_[4];
         _fateImg.visible = isPlaying && PlayerManager.instance.currentPlayerModel.selectTarget != data;
         addChildAt(_fateImg,0);
      }
      
      override protected function nextWalk(param1:Point) : void
      {
         _currentPos = this.getTilePos();
         _data.curPosX = _currentPos.x;
         _data.curPosY = _currentPos.y;
         super.nextWalk(param1);
         resetAlpha();
         changeLandEffect();
      }
      
      override protected function playMovie() : void
      {
         super.playMovie();
         var _loc1_:Point = getTilePos();
         if(_loc1_.x != _currentPos.x || _loc1_.y != _currentPos.y)
         {
            _info.dispatchEvent(new ObjectsEvent("WALK_NEXT",{"point":_loc1_}));
            _currentPos = _loc1_;
            _data.curPosX = _currentPos.x;
            _data.curPosY = _currentPos.y;
            resetAlpha();
            changeLandEffect();
         }
      }
      
      override protected function walkOver() : void
      {
         resetAlpha();
         super.walkOver();
         changeLandEffect();
      }
      
      private function resetAlpha() : void
      {
         var _loc1_:Boolean = false;
         if(SpaceManager.instance.model)
         {
            _loc1_ = Boolean(SpaceManager.instance.model.walkableValueIsPara(4,this.x / 20,this.y / 20));
         }
         var _loc2_:Number = 1;
         if(!isFlying)
         {
            _loc2_ = _loc1_ ? 0.5 : 1;
         }
         if(_avatarContainer)
         {
            _avatarContainer.alpha = _loc2_;
         }
      }
      
      override public function advanceTime(param1:Number) : void
      {
         if(_fateImg)
         {
            _fateImg.advanceTime(param1);
         }
         super.advanceTime(param1);
      }
      
      public function lockTargetAndHideFate() : void
      {
         if(_fateImg)
         {
            _fateImg.visible = false;
         }
         showSelected();
      }
      
      public function unlockTargetAndShowFate() : void
      {
         if(_fateImg && PlayerManager.instance.currentPlayerModel.selectTarget != data)
         {
            _fateImg.visible = true;
         }
         showUnSelected();
      }
      
      public function showSelected() : void
      {
         var _loc1_:Texture = null;
         if(isMount)
         {
            _loc1_ = Global.avatarTextureDic["selecttarget1"] as Texture;
         }
         else
         {
            _loc1_ = Global.avatarTextureDic["selecttarget2"] as Texture;
         }
         if(!_selectedImg)
         {
            _selectedImg = new Image(_loc1_);
         }
         _selectedImg.texture = _loc1_;
         _selectedImg.readjustSize();
         _selectedImg.x = -_selectedImg.width >> 1;
         _selectedImg.y = -_selectedImg.height >> 1;
         addChildAt(_selectedImg,0);
      }
      
      public function showUnSelected() : void
      {
         if(_selectedImg)
         {
            _selectedImg.removeFromParent();
         }
      }
      
      private function changeLandEffect() : void
      {
         if(SpaceManager.instance.model.armyIsOnObstacle(this))
         {
            if(_fateImg)
            {
               _fateImg.visible = false;
            }
            if(_shadowImg)
            {
               _shadowImg.removeFromParent();
            }
         }
         else if(isPlaying)
         {
            if(_fateImg && PlayerManager.instance.currentPlayerModel.selectTarget != data)
            {
               _fateImg.visible = true;
            }
            if(_shadowImg && !_shadowImg.parent)
            {
               addChildAt(_shadowImg,0);
            }
         }
      }
      
      override public function set isPlaying(param1:Boolean) : void
      {
         super.isPlaying = param1;
         if(param1)
         {
            if(_avatarContainer)
            {
               _avatarContainer.visible = true;
            }
            if(_fateImg && PlayerManager.instance.currentPlayerModel.selectTarget != data && !SpaceManager.instance.model.armyIsOnObstacle(this))
            {
               _fateImg.visible = true;
            }
            if(_shadowImg)
            {
               _shadowImg.visible = true;
            }
         }
         else
         {
            if(_avatarContainer)
            {
               _avatarContainer.visible = false;
            }
            if(_fateImg)
            {
               _fateImg.visible = false;
            }
            if(_shadowImg)
            {
               _shadowImg.visible = false;
            }
         }
      }
      
      public function get nameView() : BaseNameView
      {
         return _nameView;
      }
      
      public function setNormalFilter() : void
      {
         filter = null;
      }
      
      override public function dispose() : void
      {
         removeDataEvent();
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         ObjectUtils.disposeObject(_nameView);
         _nameView = null;
         _data = null;
         _fateImg = null;
         _shadowImg = null;
         super.dispose();
      }
      
      public function get isFlying() : Boolean
      {
         return _isFlying;
      }
   }
}

