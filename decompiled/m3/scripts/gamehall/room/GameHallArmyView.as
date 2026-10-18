package gamehall.room
{
   import avatar.data.AvatarStaticData;
   import avatar.view.Avatar;
   import avatar.view.HeroAvatar;
   import chat.datas.ChatFactory;
   import com.pickgliss.loader.LoaderHeaderList;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import events.FreedomTeamEvent;
   import events.GameHallEvent;
   import events.ObjectsEvent;
   import flash.events.Event;
   import flash.geom.Point;
   import gamehall.room.mediator.GameHallPlayerWalkMediator;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import map.internals.data.PhysicsEvent;
   import map.internals.utils.ArmySpeedUtils;
   import map.internals.view.hero.HeroAvatarView;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.gamehall.GameHallArmy;
   import mvc.module.gamehall.GameHallModel;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.events.PlayerEvent;
   import yishi.interfaces.IBuildingFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.StringHelper;
   
   public class GameHallArmyView extends HeroAvatarView
   {
      
      public static const DEFAULT_SPEED:int = 7;
      
      public static const HALF_SPEED:int = 4;
      
      public static const NAME:String = "map.space.view.physics.SpaceArmyView";
      
      private static const WALKSENDSERVER:int = 200;
      
      protected var _mediatorKey:String;
      
      protected var _data:GameHallArmy;
      
      protected var _consortiaTxt:FilterFrameText;
      
      protected var _flagView:ScaleFrameImage;
      
      protected var _chatPopView:Component;
      
      protected var _showNamePosY:Number = -125;
      
      protected var _isMounting:Boolean = false;
      
      private var _walkedPointNum:int = 0;
      
      private var _offX:int;
      
      private var _offY:int;
      
      private var _currentPos:Point;
      
      public function GameHallArmyView()
      {
         super();
         initView();
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _npcName = ComponentFactory.Instance.creatComponentByStylename("core.NpcNameText");
         _consortiaTxt = ComponentFactory.Instance.creatComponentByStylename("map.campaign.ConsortiaText");
         _flagView = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallArmyView.flagView");
         _flagView.setFrame(1);
         _consortiaTxt.cacheAsBitmap = true;
         addChild(_npcName);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_chatPopView);
         _chatPopView = null;
         ObjectUtils.disposeObject(_flagView);
         _flagView = null;
         ObjectUtils.disposeObject(_consortiaTxt);
         _consortiaTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
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
      
      public function set data(param1:GameHallArmy) : void
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
            _loc2_.push(GameHallPlayerWalkMediator);
         }
         addEvent();
         showAvatar(param1);
         __updateInfoHandler(null);
         __prepareStateHandler(null);
         __onlineStateHandler(null);
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc2_,this,"map.space.view.physics.SpaceArmyView");
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         if(_data)
         {
            _data.addEventListener("CHAT_DATA",__chatHandler);
            _data.addEventListener("PREPARE_STATE",__prepareStateHandler);
            _data.addEventListener("ONLINE_STATE",__onlineStateHandler);
            if(isSelf)
            {
               thane.addEventListener("PLAYER_AVATA_CHANGE",__heroPropertyHandler);
               thane.addEventListener("PLAYER_INFO_UPDATE",__updateInfoHandler);
            }
            else
            {
               _data.baseHero.addEventListener("PLAYER_AVATA_CHANGE",__avatarChangeHandler);
               _data.baseHero.addEventListener("PLAYER_INFO_UPDATE",__updateInfoHandler);
            }
         }
         NotificationManager.instance.addEventListener("TEAM_INFO_SYNC",__teamInfoUpdateHandler);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         if(_data)
         {
            _data.removeEventListener("CHAT_DATA",__chatHandler);
            _data.removeEventListener("PREPARE_STATE",__prepareStateHandler);
            _data.removeEventListener("ONLINE_STATE",__onlineStateHandler);
            if(isSelf)
            {
               thane.removeEventListener("PLAYER_AVATA_CHANGE",__heroPropertyHandler);
               thane.removeEventListener("PLAYER_INFO_UPDATE",__updateInfoHandler);
            }
            else
            {
               _data.baseHero.removeEventListener("PLAYER_AVATA_CHANGE",__avatarChangeHandler);
               _data.baseHero.removeEventListener("PLAYER_INFO_UPDATE",__updateInfoHandler);
            }
         }
         NotificationManager.instance.addEventListener("TEAM_INFO_SYNC",__teamInfoUpdateHandler);
      }
      
      private function __teamInfoUpdateHandler(param1:FreedomTeamEvent) : void
      {
         refreshFlagView();
      }
      
      private function __prepareStateHandler(param1:GameHallEvent) : void
      {
         refreshFlagView();
      }
      
      private function __onlineStateHandler(param1:GameHallEvent) : void
      {
         refreshOnlineState();
         refreshFlagView();
      }
      
      private function refreshOnlineState() : void
      {
         if(_data.online)
         {
            setNormalFilter();
         }
         else
         {
            setGrayFilter();
         }
      }
      
      private function refreshFlagView() : void
      {
         if(_flagView)
         {
            if(_data && !_data.online)
            {
               _flagView.setFrame(2);
            }
            else if(_data && _data.userId != model.captainId && _data.isPrepare)
            {
               _flagView.setFrame(3);
            }
            else
            {
               _flagView.setFrame(1);
            }
         }
      }
      
      private function get model() : GameHallModel
      {
         return GameHallManager.instance.model;
      }
      
      override protected function showName(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         super.showName(param1,param2,param3,param4,param5);
         setConsortiaName(consortiaName,param5);
         setNpcName(param1,param5);
         layoutTxtViewWithNamePosY();
      }
      
      private function setNpcName(param1:String, param2:int) : void
      {
         _npcName.visible = true;
         _npcName.text = _data.baseHero.nickName;
         _npcName.setFrame(param2);
         addChild(_npcName);
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
         if(_flagView)
         {
            _flagView.x = -_flagView.width / 2;
            if(_data.baseHero.consortiaName)
            {
               _flagView.y = _showNamePosY - _flagView.height - 20;
            }
            else
            {
               _flagView.y = _showNamePosY - _flagView.height;
            }
         }
         if(_flagView && isPlaying)
         {
            if(_flagView && !_flagView.parent)
            {
               addChild(_flagView);
            }
            refreshFlagView();
         }
         else if(_flagView && _flagView.parent)
         {
            _flagView.parent.removeChild(_flagView);
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
            _data.curPosX = _currentPos.x;
            _data.curPosY = _currentPos.y;
         }
      }
      
      override protected function walkOver() : void
      {
         super.walkOver();
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
      
      private function showAvatar(param1:GameHallArmy) : void
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
         _isMounting = false;
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
         avatarView.footPrintLayer = null;
         avatarView.showMountShadow = _isMounting;
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
         if(_isPlaying)
         {
            addChild(_avatar);
         }
         _consortiaTxt && addChild(_consortiaTxt);
         _npcName && addChild(_npcName);
         param1.addEventListener("sizeTypeChange",__onSizeTypeChangeHandler);
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
         refreshOnlineState();
         refreshFlagView();
      }
      
      protected function __heroPropertyHandler(param1:PlayerEvent) : void
      {
         if(!_data || !_data.baseHero)
         {
            return;
         }
         var _loc2_:GameHallArmy = GameHallManager.instance.model.getUserArmyByUserId(_data.baseHero.userId);
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
      
      override public function set filter(param1:IBuildingFilter) : void
      {
         _filter = param1;
         refreshOnlineState();
         refreshFlagView();
      }
      
      public function setGrayFilter() : void
      {
         if(_avatar && _filter)
         {
            _filter.setGrayFilter(_avatar.contentBitmap);
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
      
      private function __chatHandler(param1:PhysicsEvent) : void
      {
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
         if(param1)
         {
            if(_avatar)
            {
               addChildAt(_avatar,0);
            }
            if(_consortiaTxt)
            {
               addChild(_consortiaTxt);
            }
            if(_chatPopView)
            {
               addChild(_chatPopView);
            }
         }
         else
         {
            if(_avatar && _avatar.parent)
            {
               _avatar.parent.removeChild(_avatar);
            }
            if(_consortiaTxt && _consortiaTxt.parent)
            {
               _consortiaTxt.parent.removeChild(_consortiaTxt);
            }
            if(_chatPopView && _chatPopView.parent)
            {
               _chatPopView.parent.removeChild(_chatPopView);
            }
         }
      }
      
      public function get data() : GameHallArmy
      {
         return _data;
      }
      
      public function get aiInfo() : BaseArmyAiInfo
      {
         return _info as BaseArmyAiInfo;
      }
      
      public function get isMounting() : Boolean
      {
         return _isMounting;
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
         removeEvent();
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
         uninitView();
         super.dispose();
      }
   }
}

