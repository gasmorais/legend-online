package treasurehunt
{
   import avatar.data.AvatarStaticData;
   import avatar.view.Avatar;
   import avatar.view.HeroAvatar;
   import avatar.view.HumanAvatar;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.utils.SoundManager;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.internals.utils.MapUtisl;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.datas.ai.AIPhysicsBase;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   
   public class HeroHunterView extends AIPhysicsBase
   {
      
      protected var isSelf:Boolean = true;
      
      protected var _isMounting:Boolean = false;
      
      protected var _avatar:Avatar;
      
      private var _angle:Number;
      
      public function HeroHunterView()
      {
         super();
         showAvatar();
      }
      
      protected function showAvatar() : void
      {
         var _loc18_:String = null;
         var _loc11_:String = null;
         var _loc17_:String = null;
         var _loc5_:String = null;
         var _loc13_:Object = null;
         var _loc8_:String = null;
         var _loc14_:ThaneInfo = thane;
         var _loc10_:MountTemplate = getMountTemplate();
         _isMounting = _loc10_ != null;
         var _loc19_:int = int(_loc14_.changeShapeId);
         var _loc4_:int = int(_loc14_.templateInfo.Sexs);
         var _loc22_:int = int(_loc14_.templateInfo.Job);
         var _loc15_:String = _loc14_.bodyEquipAvata == "" ? JobType.getDefaultBodyEquipNameByJob(_loc22_) : _loc14_.bodyEquipAvata;
         var _loc2_:String = _loc14_.armsEquipAvata == "" ? JobType.getDefaultArmysEquipNameByJob(_loc22_) : _loc14_.armsEquipAvata;
         if(_loc15_.indexOf(PathManager.DRAGONIC) != -1)
         {
            _loc18_ = JobType.getDefaultHairUpByJob(4);
            _loc11_ = JobType.getDefaultHairDownByJob(4);
            _loc17_ = JobType.getDefaultCloakEquipNameByJob(4);
         }
         else
         {
            _loc18_ = JobType.getDefaultHairUpByJob(_loc22_);
            _loc11_ = JobType.getDefaultHairDownByJob(_loc22_);
            _loc17_ = JobType.getDefaultCloakEquipNameByJob(_loc22_);
         }
         var _loc6_:String = _loc14_.wingAvata;
         var _loc20_:String = _loc10_ ? _loc10_.AvatarPath : "";
         var _loc12_:Boolean = !_loc14_.hideFashion;
         if(_loc14_.petTemplate)
         {
            _loc5_ = _loc14_.petTemplate.PetAvatar;
         }
         var _loc16_:Boolean = isSelf;
         var _loc7_:int = isSelf ? 10 : 4;
         if(_loc19_ > 0)
         {
            _loc15_ = _loc19_ + "";
            _loc2_ = "";
            if(!avatarView)
            {
               avatarView = new HeroAvatar(true,_loc15_,2,_loc4_,_loc16_,_loc22_);
               avatarView.currentMountId = _loc10_ ? _loc10_.TemplateId : -1;
            }
            avatarView.type = 2;
            avatarView.removeAllAvatar();
            _loc8_ = PathManager.getAvatarResourcePath(_loc15_,_loc4_,1,"body",_loc22_,2);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.BASE_NPC_STAND,AvatarStaticData.BASE_NPC_WALK,"body");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
            return;
         }
         var _loc1_:int = 1;
         var _loc3_:int = 1;
         var _loc9_:int = 1;
         if(_loc12_)
         {
            if(_loc14_.bodyFashionAvata)
            {
               _loc15_ = _loc14_.bodyFashionAvata;
               _loc17_ = "";
               _loc1_ = 2;
            }
            if(_loc14_.armsFashionAvata)
            {
               _loc2_ = _loc14_.armsFashionAvata;
               _loc3_ = 2;
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
            for(var _loc21_:String in thane.avatarChange)
            {
               avatarView.removeAvatar(_loc21_);
            }
            _avatar.type = 1;
         }
         else
         {
            avatarView = new HeroAvatar(true,_loc15_,1,_loc4_,_loc16_);
            avatarView.currentMountId = _loc10_ ? _loc10_.TemplateId : -1;
         }
         if(_isMounting)
         {
            (avatarView as HeroAvatar).isStandPosMount = _loc10_.useStandPose;
            if(!_loc10_.useStandPose)
            {
               _loc15_ = JobType.getMapMountEquipment(_loc15_);
               _loc2_ = JobType.getMapMountEquipment(_loc2_);
               _loc18_ = JobType.getMapMountEquipment(_loc18_);
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
            _loc8_ = PathManager.getAvatarResourcePath(_loc6_,_loc4_,1,"wing",_loc22_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","wing",_isMounting),AvatarStaticData.getBaseNumByType("Walk","wing",_isMounting),"wing");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         else if(_loc17_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc17_,_loc4_,1,"cloak",_loc22_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","cloak",_isMounting),AvatarStaticData.getBaseNumByType("Walk","cloak",_isMounting),"cloak");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_loc11_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc11_,_loc4_,_loc9_,"hairDown",_loc22_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","hairDown",_isMounting),AvatarStaticData.getBaseNumByType("Walk","hairDown",_isMounting),"hairDown");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_loc18_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc18_,_loc4_,_loc9_,"hairUp",_loc22_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","hairUp",_isMounting),AvatarStaticData.getBaseNumByType("Walk","hairUp",_isMounting),"hairUp");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_loc2_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc2_,_loc4_,_loc3_,"army",_loc22_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","army",_isMounting),AvatarStaticData.getBaseNumByType("Walk","army",_isMounting),"army");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_loc15_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc15_,_loc4_,_loc1_,"body",_loc22_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","body",_isMounting),AvatarStaticData.getBaseNumByType("Walk","body",_isMounting),"body");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(_loc20_)
         {
            _loc8_ = PathManager.getAvatarResourcePath(_loc20_,_loc4_,1,"mount",_loc22_,1);
            _loc13_ = createResourceLoadInfo(_loc8_,AvatarStaticData.getBaseNumByType("Stand","mount",_isMounting),AvatarStaticData.getBaseNumByType("Walk","mount",_isMounting),"mount");
            LoaderManagerII.instance.load(_loc8_,4,_loc7_,loaderCompleteHandler,null,null,_loc13_);
         }
         if(!_isMounting && CampaignManager.instance.mapView)
         {
            avatarView.footPrintLayer = CampaignManager.instance.mapView.footLayer;
         }
         else
         {
            avatarView.footPrintLayer = null;
         }
         avatarView.showMountShadow = _isMounting;
      }
      
      protected function getMountTemplate() : MountTemplate
      {
         return ArmyManager.instance.army.mountTemplate;
      }
      
      override public function set info(param1:AIBaseInfo) : void
      {
         super.info = param1;
      }
      
      override protected function nextWalk(param1:Point) : void
      {
         var _loc2_:Point = new Point(param1.x,param1.y);
         this._angle = Math.atan2(_loc2_.y - this.y,_loc2_.x - this.x);
         var _loc3_:Number = _angle * 180 / 3.141592653589793;
         if(_loc3_ < 0)
         {
            _loc3_ += 360;
         }
         updateDirection(_loc3_);
         super.nextWalk(param1);
      }
      
      protected function updateDirection(param1:Number) : void
      {
         if(_avatar)
         {
            _avatar.angle = param1;
         }
      }
      
      public function standImp() : void
      {
         if(_avatar)
         {
            _avatar.state = 3;
         }
      }
      
      override protected function walkOver() : void
      {
         super.walkOver();
         walkOverExecute();
      }
      
      protected function walkOverExecute() : void
      {
         standImp();
         FrameControllerManager.instance.treasureHuntControler.showDialogFrame();
         FrameControllerManager.instance.treasureHuntControler.frame.closeButton.enable = true;
         TreasureHuntFrame(FrameControllerManager.instance.treasureHuntControler.frame).setStartBtnState(true);
      }
      
      override public function execute() : void
      {
         super.execute();
         if(_avatar && _isPlaying)
         {
            _avatar.run();
            if(!_isStand)
            {
               _avatar.state = 4;
            }
         }
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
            if(_avatar.state == 4 && isSelf && (_avatar.frameX == 0 || _avatar.frameX == 2 || _avatar.frameX == 4))
            {
               SoundManager.instance.play("001");
            }
         }
      }
      
      protected function createResourceLoadInfo(param1:String, param2:Array, param3:Array, param4:String) : ResourceLoaderInfo
      {
         var _loc5_:ResourceLoaderInfo = new ResourceLoaderInfo();
         _loc5_.packageName = MapUtisl.getPackageName(param1);
         _loc5_.stand = param2;
         _loc5_.walk = param3;
         _loc5_.position = param4;
         _loc5_.url = param1;
         return _loc5_;
      }
      
      protected function loaderCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(_avatar)
         {
            (_avatar as HumanAvatar).loaderCompleteHandler(param1.args as ResourceLoaderInfo,param2);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function set avatarView(param1:Avatar) : void
      {
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
         (_avatar as HumanAvatar).isShowWeapons = true;
         _avatar.angle = 2;
         if(_isPlaying)
         {
            addChild(_avatar);
         }
      }
      
      public function get avatarView() : Avatar
      {
         return _avatar;
      }
   }
}

