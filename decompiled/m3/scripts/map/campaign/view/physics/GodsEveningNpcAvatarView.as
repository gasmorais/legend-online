package map.campaign.view.physics
{
   import avatar.data.AvatarStaticData;
   import avatar.view.HeroAvatar;
   import avatar.view.HumanAvatar;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import events.GodsEveningEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import map.campaign.CampaignManager;
   import map.internals.data.CampaignNode;
   import map.internals.event.OuterCityEvent;
   import mvc.module.godsevening.GodsEveningModel;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.PathManager;
   
   public class GodsEveningNpcAvatarView extends NpcAvatarView
   {
      
      public static const FOLLOW_DISTANCE:uint = 150;
      
      private var _serverName:FilterFrameText;
      
      private var _nodeTypeName:FilterFrameText;
      
      public var followTarget:GodsEveningArmyView;
      
      private var _lastFollowTime:int = 0;
      
      public function GodsEveningNpcAvatarView(param1:String, param2:String, param3:int, param4:int)
      {
         super(param1,param2,param3,param4);
         this.buttonMode = true;
      }
      
      override public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         if(!_avatar || !_avatar.contentBitmap)
         {
            return false;
         }
         if(!param1)
         {
            _filter.setGlowFilter(_avatar.contentBitmap);
         }
         else if((_avatar as HumanAvatar).getCurrentPixels() > 50)
         {
            _filter.setGlowFilter(_avatar.contentBitmap);
         }
         else
         {
            _filter.setNormalFilter(_avatar.contentBitmap);
         }
         return false;
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         GodsEveningManager.instance.addEventListener("NPC_NODE_INFO",__npcNodeInfoHandler);
         if(_nodeInfo)
         {
            _nodeInfo.addEventListener("UPDATA_MAP_PHYSICS",__nodeInfoChangeHandler);
         }
         CampaignManager.instance.mapModel.addEventListener("UPDATE_CAMPAING_NODE",__nodeTeamInfoChangeHandler);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         GodsEveningManager.instance.removeEventListener("NPC_NODE_INFO",__npcNodeInfoHandler);
         if(_nodeInfo)
         {
            _nodeInfo.removeEventListener("UPDATA_MAP_PHYSICS",__nodeInfoChangeHandler);
         }
         CampaignManager.instance.mapModel.removeEventListener("UPDATE_CAMPAING_NODE",__nodeTeamInfoChangeHandler);
      }
      
      private function __nodeTeamInfoChangeHandler(param1:* = null) : void
      {
         refreshAvatarView();
      }
      
      private function __nodeInfoChangeHandler(param1:OuterCityEvent) : void
      {
         refreshAvatarView();
      }
      
      private function __npcNodeInfoHandler(param1:GodsEveningEvent) : void
      {
         refreshAvatarView();
      }
      
      override protected function refreshAvatarView() : void
      {
         var _loc1_:CampaignNode = _nodeInfo as CampaignNode;
         if(!_loc1_)
         {
            return;
         }
         _loc1_.toward = _loc1_.sizeType == 10 ? 0 : _loc1_.toward;
         updateDirection(_loc1_.toward);
         showName(_loc1_.info.names,_loc1_.info.grade,_loc1_.info.state,_loc1_.info.types,_loc1_.nameColor);
         if(_loc1_.param2 == 1)
         {
            refreshBossAvatar(_loc1_);
         }
         else if(_loc1_.param2 == 2 || _loc1_.param2 == 3)
         {
            refreshPlayerAvatar(_loc1_);
         }
         this.avatarView.angle = 80;
      }
      
      private function get model() : GodsEveningModel
      {
         return GodsEveningManager.instance.model;
      }
      
      override protected function showName(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:ThaneInfo = null;
         super.showName(param1,param2,param3,param4,param5);
         var _loc8_:CampaignNode = _nodeInfo as CampaignNode;
         if(_loc8_ == null)
         {
            return;
         }
         if(_loc8_.armyId == 1)
         {
            _loc6_ = 5;
         }
         else if(_loc8_.armyId == 2)
         {
            _loc6_ = 1;
         }
         else
         {
            _loc6_ = 3;
         }
         if(_loc8_.param2 == 2 || _loc8_.param2 == 3)
         {
            _loc7_ = GodsEveningManager.instance.model.getNpcNodeInfoByTeamAndType(_loc8_.param1,_loc8_.param2);
            if(_loc7_ == null)
            {
               return;
            }
            if(_serverName == null)
            {
               _serverName = ComponentFactory.Instance.creatComponentByStylename("GodsEveningCampaign.ServerName");
            }
            if(_nodeTypeName == null)
            {
               _nodeTypeName = ComponentFactory.Instance.creatComponentByStylename("GodsEveningCampaign.NodeTypeName");
            }
            if(_isPlaying)
            {
               addChild(_serverName);
               addChild(_nodeTypeName);
            }
            _npcName.text = _loc7_.nickName;
            _npcName.y = -130;
            _npcName.width = 200;
            _serverName.text = _loc7_.serviceName;
            _serverName.y = -155;
            _nodeTypeName.text = param1;
            _nodeTypeName.y = -180;
            _npcName.x = (_npcName.textWidth - 200) / 2 - 12;
            _serverName.x = (_serverName.textWidth - 200) / 2 - 12 - (_serverName.textWidth - _npcName.textWidth) / 2;
            _nodeTypeName.x = (_nodeTypeName.textWidth - 200) / 2 - 12 - (_nodeTypeName.textWidth - _npcName.textWidth) / 2;
            _npcName.setFrame(_loc6_);
            _serverName.setFrame(_loc6_);
            _nodeTypeName.setFrame(_loc6_);
         }
         else
         {
            _npcName.setFrame(_loc6_);
         }
      }
      
      private function refreshBossAvatar(param1:CampaignNode) : void
      {
         var _loc2_:CampaignNode = _nodeInfo as CampaignNode;
         if(!_loc2_)
         {
            return;
         }
         _loc2_.toward = _loc2_.sizeType == 10 ? 0 : _loc2_.toward;
         updateDirection(_loc2_.toward);
         showName(_loc2_.info.names,_loc2_.info.grade,_loc2_.info.state,_loc2_.info.types,_loc2_.nameColor);
         if(avatarView == null)
         {
            avatarView = new HeroAvatar(true,param1.sonType.toString(),2,0,true);
         }
         var _loc4_:String = PathManager.getAvatarResourcePath(param1.sonType.toString(),-1,1,"body",-1,2);
         var _loc3_:ResourceLoaderInfo = createResourceLoadInfo(_loc4_,AvatarStaticData.getBaseNumByType("Stand","body"),AvatarStaticData.getBaseNumByType("Walk","body"),"body");
         LoaderManagerII.instance.load(_loc4_,4,7,loaderCompleteHandler,null,null,_loc3_);
      }
      
      private function refreshPlayerAvatar(param1:CampaignNode) : void
      {
         var thaneInfo:ThaneInfo;
         var sex:int;
         var job:int;
         var bodyAvatar:String;
         var armyAvatar:String;
         var hairUpAvatar:String;
         var hairDownAvatar:String;
         var cloakAvatar:String;
         var wingAvatar:String;
         var bodyType:int;
         var armyType:int;
         var hairType:int;
         var node:CampaignNode = param1;
         var loadCurAvatarParts:* = function(param1:String, param2:int, param3:int, param4:String, param5:int, param6:int, param7:Array = null, param8:Array = null):void
         {
            var _loc10_:String = null;
            var _loc9_:ResourceLoaderInfo = null;
            if(param1 != null && param1 != "")
            {
               _loc10_ = PathManager.getAvatarResourcePath(param1,param2,param3,param4,param5,param6);
               _loc9_ = createResourceLoadInfo(_loc10_,AvatarStaticData.getBaseNumByType("Stand",param4),AvatarStaticData.getBaseNumByType("Walk",param4),param4);
               LoaderManagerII.instance.load(_loc10_,4,7,loaderCompleteHandler,null,null,_loc9_);
            }
         };
         if(avatarView == null)
         {
            avatarView = new HeroAvatar(true,"",1,sex,false);
         }
         thaneInfo = GodsEveningManager.instance.model.getNpcNodeInfoByTeamAndType(node.param1,node.param2);
         if(thaneInfo == null)
         {
            return;
         }
         sex = int(thaneInfo.templateInfo.Sexs);
         job = int(thaneInfo.templateInfo.Job);
         bodyAvatar = thaneInfo.bodyEquipAvata == "" ? JobType.getDefaultBodyEquipNameByJob(job) : thaneInfo.bodyEquipAvata;
         armyAvatar = thaneInfo.armsEquipAvata == "" ? JobType.getDefaultArmysEquipNameByJob(job) : thaneInfo.armsEquipAvata;
         if(bodyAvatar.indexOf(PathManager.DRAGONIC) != -1)
         {
            hairUpAvatar = JobType.getDefaultHairUpByJob(4);
            hairDownAvatar = JobType.getDefaultHairDownByJob(4);
            cloakAvatar = JobType.getDefaultCloakEquipNameByJob(4);
         }
         else
         {
            hairUpAvatar = JobType.getDefaultHairUpByJob(job);
            hairDownAvatar = JobType.getDefaultHairDownByJob(job);
            cloakAvatar = JobType.getDefaultCloakEquipNameByJob(job);
         }
         wingAvatar = thaneInfo.wingAvata;
         bodyType = 1;
         armyType = 1;
         hairType = 1;
         if(thaneInfo.bodyFashionAvata)
         {
            bodyAvatar = thaneInfo.bodyFashionAvata;
            cloakAvatar = "";
            bodyType = 2;
         }
         if(thaneInfo.armsFashionAvata)
         {
            armyAvatar = thaneInfo.armsFashionAvata;
            armyType = 2;
         }
         if(thaneInfo.hairFashionAvata)
         {
            hairUpAvatar = thaneInfo.hairFashionAvata + "up";
            hairDownAvatar = thaneInfo.hairFashionAvata + "down";
            hairType = 2;
         }
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
         if(wingAvatar)
         {
            loadCurAvatarParts(wingAvatar,sex,1,"wing",job,1);
         }
         else if(cloakAvatar)
         {
            loadCurAvatarParts(cloakAvatar,sex,1,"cloak",job,1);
         }
         loadCurAvatarParts(hairUpAvatar,sex,hairType,"hairUp",job,1);
         loadCurAvatarParts(hairDownAvatar,sex,hairType,"hairDown",job,1);
         loadCurAvatarParts(armyAvatar,sex,armyType,"army",job,1);
         loadCurAvatarParts(bodyAvatar,sex,bodyType,"body",job,1);
      }
      
      override public function execute() : void
      {
         var _loc1_:int = getTimer();
         if(_loc1_ - _lastFollowTime >= 100)
         {
            doFollow();
            _lastFollowTime = _loc1_;
         }
         super.execute();
      }
      
      private function doFollow() : void
      {
         var _loc4_:Point = null;
         var _loc3_:Number = NaN;
         var _loc1_:Point = null;
         var _loc2_:Array = null;
         if(!followTarget)
         {
            return;
         }
         if(!stage)
         {
            this.x = followTarget.x;
            this.y = followTarget.y;
         }
         else if(distance(this,followTarget) > 150)
         {
            _loc4_ = new Point(followTarget.x - this.x,followTarget.y - this.y);
            _loc3_ = _loc4_.length;
            if(_loc3_ > 1000)
            {
               this.x = followTarget.x;
               this.y = followTarget.y;
            }
            else
            {
               _loc4_.x *= 0.4;
               _loc4_.y *= 0.4;
               _loc1_ = new Point(this.x + _loc4_.x,this.y + _loc4_.y);
               _loc1_.x /= 20;
               _loc1_.y /= 20;
               _loc2_ = [this.getTilePos(),_loc1_];
               this.info.speed = followTarget.info.speed;
               this.info.pathInfo = _loc2_;
            }
         }
      }
      
      private function distance(param1:Object, param2:Object) : Number
      {
         var _loc3_:Number = param2.x - param1.x;
         var _loc4_:Number = param2.y - param1.y;
         return Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
      }
      
      override public function dispose() : void
      {
         followTarget = null;
         super.dispose();
      }
   }
}

