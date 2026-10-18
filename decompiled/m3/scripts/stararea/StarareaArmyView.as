package stararea
{
   import avatar.data.AvatarStaticData;
   import avatar.view.HeroAvatar;
   import com.pickgliss.loader.LoaderManagerII;
   import events.ObjectsEvent;
   import flash.geom.Point;
   import map.internals.view.hero.HeroAvatarView;
   import mvc.module.stararea.StarareaArmy;
   import mvc.module.stararea.StarareaManager;
   import mvc.module.stararea.StarareaModel;
   import mvc.module.stararea.event.StarareaEvent;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   
   public class StarareaArmyView extends HeroAvatarView
   {
      
      private var _isMounting:Boolean = false;
      
      private var _data:StarareaArmy;
      
      private var targetId:int;
      
      public function StarareaArmyView()
      {
         super();
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
         removeEvent();
         super.dispose();
         _data = null;
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         thane.addEventListener("PLAYER_AVATA_CHANGE",__avatarChangeHandler);
         addEventListener("walkOver",__warkOverHandler);
         StarareaManager.instance.addEventListener("GAME_PASS",miniGamePass);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         thane.removeEventListener("PLAYER_AVATA_CHANGE",__avatarChangeHandler);
         removeEventListener("walkOver",__warkOverHandler);
         StarareaManager.instance.removeEventListener("GAME_PASS",miniGamePass);
      }
      
      private function miniGamePass(param1:StarareaEvent) : void
      {
         StarareaManager.instance.gameFinsh(StarareaManager.instance.model.gameRoadId);
      }
      
      private function toMove(param1:StarareaEvent) : void
      {
         var _loc2_:Point = model.getStarPosById(param1.data);
         targetId = param1.data;
         if(model.canGo(targetId) && !model.isLockMove)
         {
            model.isLockMove = true;
            model.myPointId = targetId;
            this.aiInfo.pathInfo = [new Point(this.x / 20,this.y / 20),new Point(_loc2_.x / 20,_loc2_.y / 20)];
         }
      }
      
      public function setPoint(param1:int) : void
      {
         if(model.getNodeType(param1) != -1)
         {
            StarareaManager.instance.sendGetAward(param1);
         }
      }
      
      private function __warkOverHandler(param1:ObjectsEvent) : void
      {
         if(!targetId)
         {
            return;
         }
         model.isLockMove = false;
         if(model.targetType == 4 || model.targetType == 4 + 100)
         {
            model.targetType = 0;
            StarareaManager.instance.startMiniGame();
         }
         else
         {
            setPoint(targetId);
         }
         StarareaManager.instance.sendEvent("UPDATE_NODES");
         StarareaManager.instance.sendEvent("UPDATE_ROADS");
         StarareaManager.instance.sendEvent("UPDATE_DATA");
      }
      
      private function get model() : StarareaModel
      {
         return StarareaManager.instance.model;
      }
      
      private function __avatarChangeHandler(param1:PlayerEvent) : void
      {
      }
      
      public function set data(param1:StarareaArmy) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         removeEvent();
         addEvent();
         showAvatar(param1);
      }
      
      public function get data() : StarareaArmy
      {
         return _data;
      }
      
      private function get isSelf() : Boolean
      {
         if(_data)
         {
            return _data.userId == playerInfo.userId;
         }
         return false;
      }
      
      public function get aiInfo() : BaseArmyAiInfo
      {
         return _info as BaseArmyAiInfo;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
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
      }
      
      private function showAvatar(param1:StarareaArmy) : void
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
         if(isSelf)
         {
            _loc15_ = thane;
         }
         else
         {
            _loc15_ = param1.baseHero;
         }
         this.info.speed = 10;
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
      
      override public function set info(param1:AIBaseInfo) : void
      {
         super.info = param1;
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
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

