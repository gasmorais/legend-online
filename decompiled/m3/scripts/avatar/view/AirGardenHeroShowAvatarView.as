package avatar.view
{
   import avatar.data.AvatarStaticData;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ObjectsEvent;
   import flash.events.Event;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.data.CampaignMapModel;
   import map.internals.data.PhysicsEvent;
   import map.internals.view.hero.HeroAvatarView;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   
   public class AirGardenHeroShowAvatarView extends HeroAvatarView
   {
      
      protected var _data:CampaignArmy;
      
      protected var _isMounting:Boolean = false;
      
      private var _controller:CampaignMapController;
      
      private var _currentPos:Point;
      
      public function AirGardenHeroShowAvatarView()
      {
         super();
         initView();
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      protected function initView() : void
      {
      }
      
      public function set data(param1:CampaignArmy) : void
      {
         removeEvent();
         _data = param1;
         if(isPlaying)
         {
            showAvatar(param1);
         }
         addEvent();
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         removeEventListener("addedToStage",__addToStageHandler);
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         addEventListener("addedToStage",__addToStageHandler);
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         removeEventListener("addedToStage",__addToStageHandler);
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
         }
         if(param1)
         {
            if(_avatar)
            {
               addChild(_avatar);
            }
         }
         else if(_avatar && _avatar.parent)
         {
            _avatar.parent.removeChild(_avatar);
         }
      }
      
      protected function showAvatar(param1:CampaignArmy) : void
      {
         var _loc18_:String = null;
         var _loc11_:String = null;
         var _loc17_:String = null;
         var _loc13_:Object = null;
         var _loc8_:String = null;
         if(this.info)
         {
            this.info.speed = 0;
         }
         var _loc14_:ThaneInfo = param1.baseHero;
         if(!_loc14_)
         {
            return;
         }
         _isMounting = false;
         var _loc10_:MountTemplate = null;
         var _loc19_:int = int(_loc14_.changeShapeId);
         var _loc5_:int = int(_loc14_.templateInfo.Sexs);
         var _loc21_:int = int(_loc14_.templateInfo.Job);
         var _loc15_:String = _loc14_.bodyEquipAvata == "" ? JobType.getDefaultBodyEquipNameByJob(_loc21_) : _loc14_.bodyEquipAvata;
         var _loc3_:String = _loc14_.armsEquipAvata == "" ? JobType.getDefaultArmysEquipNameByJob(_loc21_) : _loc14_.armsEquipAvata;
         if(_loc15_.indexOf(PathManager.DRAGONIC) != -1)
         {
            _loc18_ = JobType.getDefaultHairUpByJob(4);
            _loc11_ = JobType.getDefaultHairDownByJob(4);
            _loc17_ = JobType.getDefaultCloakEquipNameByJob(4);
         }
         else
         {
            _loc18_ = JobType.getDefaultHairUpByJob(_loc21_);
            _loc11_ = JobType.getDefaultHairDownByJob(_loc21_);
            _loc17_ = JobType.getDefaultCloakEquipNameByJob(_loc21_);
         }
         var _loc6_:String = _loc14_.wingAvata;
         var _loc20_:String = _loc10_ ? _loc10_.AvatarPath : "";
         var _loc12_:Boolean = !_loc14_.hideFashion;
         var _loc16_:Boolean = true;
         var _loc7_:int = 10;
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
         if(_loc19_ > 0)
         {
            _loc15_ = _loc19_ + "";
            _loc3_ = "";
            if(!avatarView)
            {
               avatarView = new HeroAvatar(true,_loc15_,2,_loc5_,_loc16_,_loc21_);
            }
            avatarView.type = 2;
            avatarView.removeAllAvatar();
            avatarView.currentMountId = _loc10_ ? _loc10_.TemplateId : -1;
            _loc8_ = PathManager.getAvatarResourcePath(_loc15_,_loc5_,1,"body",_loc21_,2);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.BASE_NPC_STAND,AvatarStaticData.BASE_NPC_WALK,"body");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
            return;
         }
         var _loc2_:int = 1;
         var _loc4_:int = 1;
         var _loc9_:int = 1;
         if(_loc12_)
         {
            if(_loc14_.bodyFashionAvata)
            {
               _loc15_ = _loc14_.bodyFashionAvata;
               _loc17_ = "";
               _loc2_ = 2;
            }
            if(_loc14_.armsFashionAvata)
            {
               _loc3_ = _loc14_.armsFashionAvata;
               _loc4_ = 2;
            }
            if(_loc14_.hairFashionAvata)
            {
               _loc18_ = _loc14_.hairFashionAvata + "Up";
               _loc11_ = _loc14_.hairFashionAvata + "Down";
               _loc9_ = 2;
            }
         }
         if(avatarView)
         {
            avatarView.removeAllAvatar();
            _avatar.type = 1;
            avatarView.currentMountId = _loc10_ ? _loc10_.TemplateId : -1;
         }
         else
         {
            avatarView = new HeroAvatar(true,_loc15_,1,_loc5_,_loc16_);
            avatarView.currentMountId = _loc10_ ? _loc10_.TemplateId : -1;
         }
         if(_isMounting)
         {
            (avatarView as HeroAvatar).isStandPosMount = _loc10_.useStandPose;
            if(!_loc10_.useStandPose)
            {
               _loc15_ = JobType.getMapMountEquipment(_loc15_);
               _loc3_ = JobType.getMapMountEquipment(_loc3_);
               _loc18_ = JobType.getMapMountEquipment(_loc18_);
               _loc11_ = JobType.getMapMountEquipment(_loc11_);
               _loc17_ = JobType.getMapMountEquipment(_loc17_);
               _loc6_ = JobType.getMapMountEquipment(_loc6_);
            }
            if(!_loc20_)
            {
               _loc20_ = JobType.getDefaultMount();
            }
         }
         else
         {
            (avatarView as HeroAvatar).isStandPosMount = false;
         }
         if(_loc6_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc6_,_loc5_,1,"wing",_loc21_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","wing",_isMounting),AvatarStaticData.getBaseNumByType("Walk","wing",_isMounting),"wing");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         else if(_loc17_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc17_,_loc5_,1,"cloak",_loc21_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","cloak",_isMounting),AvatarStaticData.getBaseNumByType("Walk","cloak",_isMounting),"cloak");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_loc11_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc11_,_loc5_,_loc9_,"hairDown",_loc21_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","hairDown",_isMounting),AvatarStaticData.getBaseNumByType("Walk","hairDown",_isMounting),"hairDown");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_loc18_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc18_,_loc5_,_loc9_,"hairUp",_loc21_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","hairUp",_isMounting),AvatarStaticData.getBaseNumByType("Walk","hairUp",_isMounting),"hairUp");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_loc3_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc3_,_loc5_,_loc4_,"army",_loc21_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","army",_isMounting),AvatarStaticData.getBaseNumByType("Walk","army",_isMounting),"army");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_loc15_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc15_,_loc5_,_loc2_,"body",_loc21_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","body",_isMounting),AvatarStaticData.getBaseNumByType("Walk","body",_isMounting),"body");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_loc20_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc20_,_loc5_,1,"mount",_loc21_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","mount",_isMounting),AvatarStaticData.getBaseNumByType("Walk","mount",_isMounting),"mount");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_data == null)
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
      
      override public function execute() : void
      {
         super.execute();
         if(_avatar == null)
         {
            return;
         }
         if(_avatar.state == 4)
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
            if(_avatar.state == 4 && (_avatar.frameX == 0 || _avatar.frameX == 2 || _avatar.frameX == 4))
            {
               SoundManager.instance.play("001");
            }
         }
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
         super.avatarView = param1;
         param1.addEventListener("sizeTypeChange",__onSizeTypeChangeHandler);
      }
      
      private function __onSizeTypeChangeHandler(param1:Event) : void
      {
      }
      
      public function get isMounting() : Boolean
      {
         return _isMounting;
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
            _data.preParent = null;
            _data.armyView = null;
         }
         ObjectUtils.disposeObject(_npcName);
         _npcName = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

