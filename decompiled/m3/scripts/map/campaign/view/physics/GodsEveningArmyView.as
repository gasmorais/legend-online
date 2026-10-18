package map.campaign.view.physics
{
   import avatar.data.AvatarStaticData;
   import avatar.view.HeroAvatar;
   import com.pickgliss.loader.LoaderManagerII;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import flash.events.MouseEvent;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.data.CampaignNode;
   import yishi.datas.ai.NpcAiInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   
   public class GodsEveningArmyView extends CampaignArmyView
   {
      
      private const NORMAL_SPEED:int = 8;
      
      private var _godsEveningNpcAvatarView:GodsEveningNpcAvatarView;
      
      public function GodsEveningArmyView()
      {
         super();
         this.mouseChildren = this.mouseEnabled = true;
      }
      
      public function get godsEveningNpcAvatarView() : GodsEveningNpcAvatarView
      {
         return _godsEveningNpcAvatarView;
      }
      
      override protected function setNpcName(param1:int) : void
      {
         var _loc2_:int = 0;
         super.setNpcName(param1);
         _vipText.visible = false;
         _npcName.visible = true;
         if(data.teamId == 1)
         {
            _loc2_ = 5;
         }
         else if(data.teamId == 2)
         {
            _loc2_ = 1;
         }
         else
         {
            _loc2_ = 3;
         }
         _npcName.setFrame(_loc2_);
         _consortiaTxt.setFrame(_loc2_);
      }
      
      override protected function get consortiaName() : String
      {
         return _data.baseHero.serviceName;
      }
      
      override protected function __isDieHandler(param1:CampaignMapEvent) : void
      {
         super.__isDieHandler(param1);
         if(isWithGoddess || isTransMineral)
         {
            changeSpeedTo(0.5);
         }
         else
         {
            changeSpeedTo(1);
         }
         showAvatar(_data);
         showNpcAvata(_data.goddessId);
         updateVisible();
         removeNpcAvatarView();
      }
      
      public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         if(mouseHitTest())
         {
            CampaignManager.instance.mapModel.selectNode = null;
            if(_data.teamId != GodsEveningManager.instance.model.teamId)
            {
               NotificationManager.instance.dispatchEvent(new NotificationEvent("LOCK_PVP_WARFIGHT",_data));
            }
            return true;
         }
         return false;
      }
      
      override protected function __onlineStateHandler(param1:CampaignMapEvent) : void
      {
         super.__onlineStateHandler(param1);
         if(!_data)
         {
            return;
         }
         if(avatarView)
         {
            if(!_data.online)
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
               this.x = _data.curPosX * 20;
               this.y = _data.curPosY * 20;
               if(_data.goddessId > 0)
               {
                  if(_godsEveningNpcAvatarView && _godsEveningNpcAvatarView.parent)
                  {
                     _godsEveningNpcAvatarView.parent.removeChild(_godsEveningNpcAvatarView);
                     _godsEveningNpcAvatarView.followTarget = null;
                     _godsEveningNpcAvatarView = null;
                  }
               }
            }
         }
      }
      
      override public function updateVisible() : void
      {
         if(!_data)
         {
            return;
         }
         this.visible = _data.online;
         if(this._fateSkillEffect)
         {
            this._fateSkillEffect.visible = false;
         }
         if(this.petAvatarView)
         {
            this.petAvatarView.visible = false;
         }
         if(this.childrenAvatarView)
         {
            this.childrenAvatarView.visible = false;
         }
      }
      
      override protected function refreshVocation() : void
      {
         super.refreshVocation();
         if(_vocationIcon)
         {
            _vocationIcon.visible = false;
         }
         if(_avengerEffect)
         {
            _avengerEffect.visible = false;
         }
      }
      
      private function showNpcAvata(param1:int) : void
      {
         var _loc2_:CampaignNode = null;
         var _loc3_:NpcAiInfo = null;
         if(!_godsEveningNpcAvatarView)
         {
            _loc2_ = GodsEveningManager.instance.model.npcNodeViewDic[param1];
            if(!_loc2_)
            {
               return;
            }
            _godsEveningNpcAvatarView = new GodsEveningNpcAvatarView("","",0,0);
            _loc3_ = new NpcAiInfo();
            _loc2_.info.state = 1;
            _godsEveningNpcAvatarView.info = _loc3_;
            _godsEveningNpcAvatarView.nodeInfo = _loc2_;
            _loc3_.isLiving = true;
            _godsEveningNpcAvatarView.followTarget = this;
            _godsEveningNpcAvatarView.filter = new SimpleBuildingFilter();
            if(_godsEveningNpcAvatarView.parent != CampaignManager.instance.mapView.walkLayer)
            {
               CampaignManager.instance.mapView.walkLayer.addChild(_godsEveningNpcAvatarView);
               initGodsEveningNpcAvatarViewPos();
            }
         }
      }
      
      public function removeNpcAvatarView() : void
      {
         if(_data && _data.goddessId == 0 || _data.isDie == 1 || _data.isDie == 11)
         {
            if(_godsEveningNpcAvatarView && _godsEveningNpcAvatarView.parent)
            {
               _godsEveningNpcAvatarView.parent.removeChild(_godsEveningNpcAvatarView);
               _godsEveningNpcAvatarView.followTarget = null;
               _godsEveningNpcAvatarView = null;
            }
         }
      }
      
      private function initGodsEveningNpcAvatarViewPos() : void
      {
         if(!_godsEveningNpcAvatarView)
         {
            return;
         }
         var _loc1_:int = -1;
         if(avatarView)
         {
            _loc1_ = -(avatarView as HeroAvatar).mirror;
         }
         _godsEveningNpcAvatarView.x = _data.curPosX * 20 + _loc1_ * 100;
         _godsEveningNpcAvatarView.y = _data.curPosY * 20;
      }
      
      override public function execute() : void
      {
         if(_godsEveningNpcAvatarView != null)
         {
            _godsEveningNpcAvatarView.execute();
         }
         super.execute();
      }
      
      override protected function showAvatar(param1:CampaignArmy) : void
      {
         var bodyAvatar:String;
         var args:Object;
         var url:String;
         var mountAvatar:String;
         var mountWingAvatar:String;
         var value:CampaignArmy = param1;
         var loadCurAvatarParts:* = function(param1:String, param2:int, param3:int, param4:String, param5:int, param6:int, param7:Array = null, param8:Array = null):void
         {
            var _loc11_:String = null;
            var _loc9_:Boolean = false;
            var _loc10_:ResourceLoaderInfo = null;
            if(param1 != null && param1 != "")
            {
               _loc11_ = PathManager.getAvatarResourcePath(param1,param2,param3,param4,param5,param6);
               _loc9_ = param4 == "mount" || param4 == "mountWing";
               if(_loc9_)
               {
                  param7 = param7 == null ? AvatarStaticData.getBaseNumByType("Stand",param4,_isMounting) : param7;
                  param8 = param8 == null ? AvatarStaticData.getBaseNumByType("Walk",param4,_isMounting) : param8;
               }
               else
               {
                  param7 = param7 == null ? AvatarStaticData.getSetOffsetArray("Stand",param4,_isMounting,[{2:-renderIndex}]) : param7;
                  param8 = param8 == null ? AvatarStaticData.getSetOffsetArray("Walk",param4,_isMounting,[{0:uint(renderIndex / 10)},{2:-renderIndex},{3:-renderIndex},{4:-renderIndex}]) : param8;
               }
               _loc10_ = createResourceLoadInfo(_loc11_,param7,param8,param4);
               _loc10_.positionAddSign = myUserId;
               if(!_loc9_)
               {
                  _loc10_.resourceType = 0;
               }
               LoaderManagerII.instance.load(_loc11_,4,priority,loaderCompleteHandler,null,null,_loc10_);
            }
         };
         _isMounting = isWithGoddess;
         var thaneInfo:ThaneInfo = value.baseHero;
         var delay:Boolean = isSelf;
         var sex:int = int(thaneInfo.templateInfo.Sexs);
         var job:int = 1;
         var priority:int = isSelf ? 10 : 4;
         var renderIndex:Number = 60;
         var myUserId:String = _data.userId.toString();
         var bodyType:int = 1;
         var armsType:int = 1;
         var hairType:int = 1;
         if(value.teamId == 1)
         {
            bodyAvatar = "/fashion_bloodsucking_red";
         }
         else if(value.teamId == 2)
         {
            bodyAvatar = "/fashion_bloodsucking_blue";
         }
         else
         {
            bodyAvatar = "/fashion_bloodsucking_white";
         }
         mountAvatar = "";
         mountWingAvatar = "";
         if(avatarView)
         {
            avatarView.removeAllAvatar();
            _avatar.type = 1;
         }
         else
         {
            avatarView = new HeroAvatar(true,bodyAvatar,1,sex,delay);
         }
         (avatarView as HeroAvatar).isStandPosMount = false;
         loadCurAvatarParts(bodyAvatar,sex,2,"body",job,1);
      }
      
      override public function changeSpeedTo(param1:Number = 0.5) : void
      {
         precentSpeed = param1;
         this.info.speed = Math.ceil(8 * param1);
      }
      
      override protected function __heroPropertyHandler(param1:PlayerEvent) : void
      {
         super.__heroPropertyHandler(param1);
         changeSpeedTo(precentSpeed);
      }
      
      private function get isWithGoddess() : Boolean
      {
         return _data.isDie == 12 || _data.isDie == 10 || _data.isDie == 11;
      }
      
      private function get isTransMineral() : Boolean
      {
         return _data.isDie == 2 || _data.isDie == 3 || _data.isDie == 11;
      }
      
      override public function dispose() : void
      {
         if(_godsEveningNpcAvatarView && _godsEveningNpcAvatarView.parent)
         {
            _godsEveningNpcAvatarView.parent.removeChild(_godsEveningNpcAvatarView);
            _godsEveningNpcAvatarView.followTarget = null;
            _godsEveningNpcAvatarView = null;
         }
         super.dispose();
      }
   }
}

