package planeswar.view
{
   import avatar.data.AvatarStaticData;
   import avatar.view.HeroAvatar;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import manager.LanguageMgr;
   import map.internals.view.hero.HeroAvatarView;
   import mvc.module.planeswar.PlanesArmy;
   import mvc.module.planeswar.PlanesWarModel;
   import planeswar.view.eventframe.PlanesGetHelpFrame;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.view.frame.TodayNotAlertFrame;
   
   public class PlanesArmyView extends HeroAvatarView
   {
      
      private var _armyInfo:PlanesArmy;
      
      protected var _isMounting:Boolean = false;
      
      private var reviveBtn:BaseButton;
      
      private var getHelpBtn:BaseButton;
      
      private var _dieEffect:MovieClip;
      
      private var _timeOutUint:uint;
      
      public function PlanesArmyView()
      {
         super();
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         if(_armyInfo)
         {
            thane.addEventListener("PLAYER_AVATA_CHANGE",__avatarChangeHandler);
         }
      }
      
      private function __avatarChangeHandler(param1:PlayerEvent) : void
      {
         showAvatar(_armyInfo);
      }
      
      private function showAvatar(param1:PlanesArmy) : void
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
         if(_armyInfo.userId == playerInfo.userId)
         {
            _loc15_ = thane;
         }
         else
         {
            _loc15_ = param1.baseHero;
         }
         var _loc16_:String = _loc15_.bodyEquipAvata;
         var _loc3_:String = _loc15_.armsEquipAvata;
         _loc19_ = int(_loc15_.changeShapeId);
         _loc12_ = !_loc15_.hideFashion;
         if(!param1.baseHero.templateInfo)
         {
            return;
         }
         var _loc5_:int = int(param1.baseHero.templateInfo.Sexs);
         var _loc22_:int = int(param1.baseHero.templateInfo.Job);
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
         var _loc9_:int = 10;
         if(_loc19_ > 0)
         {
            if(!avatarView)
            {
               avatarView = new HeroAvatar(true,_loc16_,2,_loc5_,true,_loc22_);
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
         for(var _loc21_:String in thane.avatarChange)
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
         if(_isMounting)
         {
            _loc16_ = JobType.getMapMountEquipment(_loc16_);
            _loc3_ = JobType.getMapMountEquipment(_loc3_);
            _loc18_ = JobType.getMapMountEquipment(_loc18_);
            _loc13_ = JobType.getMapMountEquipment(_loc13_);
            _loc17_ = JobType.getMapMountEquipment(_loc17_);
            _loc7_ = JobType.getMapMountEquipment(_loc7_);
            _loc20_ = param1.mountTemplate.AvatarPath == "" ? JobType.getDefaultMount() : param1.mountTemplate.AvatarPath;
            _isMounting = true;
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
      
      override protected function showName(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         param5 = 1;
         super.showName(param1,param2,param3,param4,param5);
      }
      
      public function showDie(param1:Boolean) : void
      {
         if(_dieEffect == null)
         {
            _dieEffect = ComponentFactory.Instance.creatCustomObject("planesArmyView.HeroDieEffect");
         }
         if(this.contains(_dieEffect))
         {
            return;
         }
         if(param1)
         {
            _dieEffect.gotoAndPlay(1);
            _dieEffect.addEventListener("removeHero",onRemoveHero);
         }
         else
         {
            _dieEffect.gotoAndPlay(60);
         }
         addChild(_dieEffect);
         _dieEffect.mouseChildren = _dieEffect.mouseEnabled = false;
         super._avatar.visible = false;
         if(reviveBtn == null)
         {
            reviveBtn = ComponentFactory.Instance.creatComponentByStylename("planesArmyView.reviveBtn");
            reviveBtn.tipData = [LanguageMgr.GetTranslation("dungeonexplore.view.DunGeonExploreHeroView.backToLifeBtn")];
         }
         if(getHelpBtn == null)
         {
            getHelpBtn = ComponentFactory.Instance.creatComponentByStylename("planesArmyView.getHelpBtn");
            getHelpBtn.tipData = [LanguageMgr.GetTranslation("fish.FishHelpFrame.title")];
         }
         addChild(reviveBtn);
         addChild(getHelpBtn);
         _dieEffect.y = 62;
         reviveBtn.addEventListener("click",reviveBtnClick);
         getHelpBtn.addEventListener("click",getHelpBtnClick);
      }
      
      public function showLife() : void
      {
         if(_dieEffect != null)
         {
            _dieEffect.removeEventListener("removeHero",onRemoveHero);
            if(this.contains(_dieEffect))
            {
               removeChild(_dieEffect);
            }
            if(this.contains(reviveBtn))
            {
               removeChild(reviveBtn);
            }
            if(this.contains(getHelpBtn))
            {
               removeChild(getHelpBtn);
            }
         }
         if(super._avatar != null)
         {
            super._avatar.visible = true;
         }
         this.mouseEnabled = false;
      }
      
      private function reviveBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(todayNeedAlertForBuy(SharedManager.instance.armyViewReviveAlertDate))
         {
            showReviveTips();
         }
         else
         {
            _loc2_ = 1;
            if(SharedManager.instance.armyViewReviveUseBind)
            {
               _loc2_ = 2;
            }
            PlanesWarManager.instance.sendPlanesOpMsg(6,[_loc2_]);
         }
      }
      
      private function getHelpBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:PlanesGetHelpFrame = ComponentFactory.Instance.creatComponentByStylename("planeswar.view.PlanesGetHelpFrame");
         _loc2_.show();
      }
      
      private function showReviveTips() : void
      {
         var _loc5_:TodayNotAlertFrame = null;
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("planes_buy_revive");
         var _loc6_:Array = _loc2_.ConfigValue.split(",");
         var _loc1_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc4_:String = LanguageMgr.GetTranslation("planeswar.planesArmyView.reviveAlertTiptext",parseInt(_loc6_[0]));
         var _loc3_:Boolean = true;
         _loc3_ = todayNeedAlertForBuy(SharedManager.instance.armyViewReviveAlertDate);
         if(_loc3_)
         {
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert");
            _loc5_.show(_loc4_,_loc1_,__showReviveTipResult,null,"center",2,true);
            return;
         }
      }
      
      private function __showReviveTipResult(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.armyViewReviveAlertDate = new Date();
            SharedManager.instance.saveArmyViewReviveAlertDate();
         }
         SharedManager.instance.armyViewReviveUseBind = param2;
         SharedManager.instance.saveArmyViewReviveUseBind();
         var _loc3_:int = 1;
         if(SharedManager.instance.armyViewReviveUseBind)
         {
            _loc3_ = 2;
         }
         PlanesWarManager.instance.sendPlanesOpMsg(6,[_loc3_]);
      }
      
      private function todayNeedAlertForBuy(param1:Date) : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         if(param1)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == param1.fullYear && _loc2_.month == param1.month && _loc2_.date == param1.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         if(reviveBtn)
         {
            reviveBtn.removeEventListener("click",reviveBtnClick);
         }
         if(getHelpBtn)
         {
            reviveBtn.removeEventListener("click",getHelpBtnClick);
         }
         if(_armyInfo)
         {
            thane.removeEventListener("PLAYER_AVATA_CHANGE",__avatarChangeHandler);
         }
      }
      
      private function onRemoveHero(param1:Event) : void
      {
         super._avatar.visible = false;
      }
      
      public function get armyInfo() : PlanesArmy
      {
         return _armyInfo;
      }
      
      public function set armyInfo(param1:PlanesArmy) : void
      {
         removeEvent();
         _armyInfo = param1;
         showAvatar(param1);
         showName(_armyInfo.nickName,0,_armyInfo.baseHero.state,0,1);
         this.mouseEnabled = false;
         addEvent();
      }
      
      override public function set info(param1:AIBaseInfo) : void
      {
         super.info = param1;
      }
      
      public function get aiInfo() : BaseArmyAiInfo
      {
         return _info as BaseArmyAiInfo;
      }
      
      override public function execute() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Point = null;
         super.execute();
         if(_armyInfo.isMoving)
         {
            _loc1_ = [];
            _loc2_ = _armyInfo.standPoint;
            if(_loc2_ && Math.abs(_loc2_.x * 100 + 50 - this.x) <= 20 && Math.abs(_loc2_.y * 100 + 50 - this.y) <= 20)
            {
               _loc1_.push(planesWarModel.planesWarInfo.posX,planesWarModel.planesWarInfo.posY,_loc2_.x,_loc2_.y);
               PlanesWarManager.instance.sendPlanesOpMsg(2,_loc1_);
               _armyInfo.walkIndex++;
               _armyInfo.standPoint = _armyInfo.walkPath[_armyInfo.walkIndex + 1];
            }
         }
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
            if(_avatar.state == 4 && (_avatar.frameX == 0 || _avatar.frameX == 2 || _avatar.frameX == 4))
            {
               SoundManager.instance.play("001");
            }
         }
      }
      
      override protected function nextWalk(param1:Point) : void
      {
         _nextPoint = param1.clone();
         _endPoint = new Point(_nextPoint.x * 20,_nextPoint.y * 20);
         _angle = Math.atan2(_endPoint.y - this.y,_endPoint.x - this.x);
         var _loc3_:Number = _angle * 180 / 3.141592653589793;
         if(_loc3_ < 0)
         {
            _loc3_ += 360;
         }
         updateDirection(_loc3_);
         this.stepX = _info.speed * Math.cos(this._angle);
         this.stepY = _info.speed * Math.sin(this._angle);
         var _loc2_:Number = Point.distance(_endPoint,new Point(this.x,this.y));
         info.totalFrame = int(_loc2_ / _info.speed);
         var _loc4_:Number = this.x + info.totalFrame * this.stepX;
         var _loc5_:Number = this.y + info.totalFrame * this.stepY;
         if(!(_loc4_ >= _nextPoint.x * 20 && _loc4_ < (_nextPoint.x + 1) * 20 && _loc5_ >= _nextPoint.y * 20 && _loc5_ < (_nextPoint.y + 1) * 20))
         {
            info.currentFrame = info.totalFrame + 1;
         }
         info.currentFrame = 0;
         if(info.totalFrame <= 0)
         {
            return;
         }
         super._isStand = false;
      }
      
      override public function updateDirection(param1:Number) : void
      {
         super.updateDirection(param1);
      }
      
      override protected function standImp() : void
      {
         super.standImp();
      }
      
      override protected function walkOver() : void
      {
         super.walkOver();
         standImp();
         var _loc1_:MovieClip = PlanesWarManager.instance.mapView.walkLayer.walkTarget;
         _loc1_.visible = false;
         _loc1_.stop();
         _armyInfo.isMoving = false;
         _armyInfo.walkPath = [];
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get planesWarModel() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
         clearTimeout(_timeOutUint);
         removeEvent();
         if(_armyInfo)
         {
            _armyInfo.armyView = null;
            _armyInfo = null;
         }
         if(reviveBtn)
         {
            ObjectUtils.disposeObject(reviveBtn);
         }
         reviveBtn = null;
         if(getHelpBtn)
         {
            ObjectUtils.disposeObject(getHelpBtn);
         }
         getHelpBtn = null;
         if(_dieEffect)
         {
            ObjectUtils.disposeViolentMc(_dieEffect);
         }
         _dieEffect = null;
         super.dispose();
      }
   }
}

