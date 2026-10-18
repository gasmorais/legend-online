package map.campaign.view.physics
{
   import avatar.data.AvatarStaticData;
   import avatar.view.HeroAvatar;
   import avatar.view.HumanAvatar;
   import avatar.view.SimpleAvatarView;
   import chat.datas.ChatFactory;
   import com.greensock.TweenMax;
   import com.pickgliss.loader.LoaderHeaderList;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.CollectionRobotData;
   import map.campaign.helper.SearchPathHelper;
   import map.campaign.helper.npcai.NpcAttackHelper;
   import map.campaign.mediator.hero.FollowTargetMediator;
   import map.campaign.mediator.npcai.NpcAlertMediator;
   import map.campaign.mediator.npcai.NpcAttackAndChaseMediator;
   import map.campaign.mediator.npcai.NpcAttackIIMediator;
   import map.campaign.mediator.npcai.NpcEnterFightMediator;
   import map.campaign.mediator.npcai.NpcStateMediator;
   import map.internals.constant.NodeState;
   import map.internals.data.CampaignNode;
   import map.internals.data.MapPhysics;
   import map.internals.data.PhysicsEvent;
   import map.internals.interfaces.IBaseMouseEvent;
   import map.internals.view.hero.HeroAvatarView;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.datas.ai.NpcAiInfo;
   import yishi.datas.consant.JobType;
   import yishi.events.AiEvents;
   import yishi.events.NotificationEvent;
   import yishi.manager.LocalConnectionManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class NpcAvatarView extends HeroAvatarView implements IBaseMouseEvent
   {
      
      public static const NAME:String = "map.campaign.view.npc.NpcAvatarView";
      
      protected var _mediatorKey:String;
      
      protected var _nodeInfo:MapPhysics;
      
      private var _chatPopView:Component;
      
      private var _attackView:SimpleAvatarView;
      
      protected var _bloodMc:MovieClip;
      
      protected var _bloodTween:TweenMax;
      
      public var showNamePosY:int = -130;
      
      public function NpcAvatarView(param1:String, param2:String, param3:int, param4:int)
      {
         super();
         this.mouseChildren = false;
      }
      
      override protected function showName(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         super.showName(param1,param2,param3,param4,param5);
         var _loc6_:CampaignNode = nodeInfo as CampaignNode;
         if(_loc6_ && _loc6_.param4 == "3")
         {
            _npcName.text = param1;
         }
         _npcName.y = -130;
         setNameColor();
      }
      
      protected function setNameColor() : void
      {
         var _loc3_:int = int(CampaignManager.instance.mapModel.mapId);
         var _loc2_:CampaignNode = _nodeInfo as CampaignNode;
         var _loc1_:int = -1;
         var _loc4_:CampaignArmy = CampaignManager.instance.mapModel.selfMemberData;
         if(_loc4_)
         {
            _loc1_ = int(_loc4_.teamId);
         }
         if(WorldBossHelper.checkPvp(_loc3_))
         {
            if(_loc2_.param1 == _loc1_)
            {
               _npcName.setFrame(1);
            }
            else
            {
               _npcName.setFrame(5);
            }
         }
         else if(WorldBossHelper.checkDuskArea(_loc3_) || Boolean(WorldBossHelper.checkIceFireTemple(_loc3_)))
         {
            if(_loc2_.param1 == 0)
            {
               _npcName.setFrame(2);
            }
            else if(_loc2_.param1 == 1)
            {
               _npcName.setFrame(1);
            }
            else
            {
               _npcName.setFrame(5);
            }
         }
      }
      
      override public function set info(param1:AIBaseInfo) : void
      {
         super.info = param1;
         initDataImp();
         initSpeed();
      }
      
      public function set nodeInfo(param1:MapPhysics) : void
      {
         _nodeInfo = param1;
         refreshAvatarView();
         initDataImp();
         initSpeed();
      }
      
      private function initSpeed() : void
      {
         if(_nodeInfo && info)
         {
            if(_nodeInfo.info.types == 67)
            {
               info.speed = 3;
               return;
            }
            if(_nodeInfo.info.types == 101)
            {
               info.speed = 7;
               return;
            }
            if(_nodeInfo is CampaignNode && (_nodeInfo as CampaignNode).nodeId == 1000402)
            {
               info.speed = 7;
               return;
            }
         }
      }
      
      protected function refreshAvatarView() : void
      {
         var _loc1_:Object = null;
         var _loc7_:String = null;
         var _loc5_:Object = null;
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc6_:int = 0;
         var _loc4_:CampaignNode = _nodeInfo as CampaignNode;
         if(!_loc4_)
         {
            return;
         }
         avatarView = new HeroAvatar(true,_loc4_.sonType.toString(),2,0,true);
         _loc4_.toward = _loc4_.toward;
         updateDirection(_loc4_.toward);
         showName(_loc4_.info.names,_loc4_.info.grade,_loc4_.info.state,_loc4_.info.types,_loc4_.nameColor);
         if(_loc4_.info.types != 101)
         {
            _loc7_ = PathManager.getAvatarResourcePath(_loc4_.sonType.toString(),-1,1,"body",-1,2);
            _loc1_ = createResourceLoadInfo(_loc7_,AvatarStaticData.getBaseNumByType("Stand","body"),AvatarStaticData.getBaseNumByType("Walk","body"),"body");
            LoaderManagerII.instance.load(_loc7_,4,7,loaderCompleteHandler,null,null,_loc1_);
         }
         else
         {
            avatarView.type = 1;
            _loc5_ = CollectionRobotData.robotData[_loc4_.sonType];
            _loc3_ = "/" + _loc5_.body;
            _loc2_ = "/" + _loc5_.army;
            _loc6_ = int(_loc5_.job);
            this._avatar.scaleX = this._avatar.scaleY = 0.85;
            _loc7_ = PathManager.getAvatarResourcePath(_loc3_,_loc5_.sex,1,"body",-1,1);
            _loc1_ = createResourceLoadInfo(_loc7_,AvatarStaticData.getBaseNumByType("Stand","body"),AvatarStaticData.getBaseNumByType("Walk","body"),"body");
            LoaderManagerII.instance.load(_loc7_,4,7,loaderCompleteHandler,null,null,_loc1_);
            _loc7_ = PathManager.getAvatarResourcePath(_loc2_,_loc5_.sex,1,"army",-1,1);
            _loc1_ = createResourceLoadInfo(_loc7_,AvatarStaticData.getBaseNumByType("Stand","army"),AvatarStaticData.getBaseNumByType("Walk","army"),"army");
            LoaderManagerII.instance.load(_loc7_,4,7,loaderCompleteHandler,null,null,_loc1_);
            _loc7_ = PathManager.getAvatarResourcePath(JobType.getDefaultHairUpByJob(_loc6_),_loc5_.sex,1,"hairUp",-1,1);
            _loc1_ = createResourceLoadInfo(_loc7_,AvatarStaticData.getBaseNumByType("Stand","hairUp"),AvatarStaticData.getBaseNumByType("Walk","hairUp"),"hairUp");
            LoaderManagerII.instance.load(_loc7_,4,7,loaderCompleteHandler,null,null,_loc1_);
            _loc7_ = PathManager.getAvatarResourcePath(JobType.getDefaultHairDownByJob(_loc6_),_loc5_.sex,1,"hairDown",-1,1);
            _loc1_ = createResourceLoadInfo(_loc7_,AvatarStaticData.getBaseNumByType("Stand","hairDown"),AvatarStaticData.getBaseNumByType("Walk","hairDown"),"hairDown");
            LoaderManagerII.instance.load(_loc7_,4,7,loaderCompleteHandler,null,null,_loc1_);
            _loc7_ = PathManager.getAvatarResourcePath(_loc3_ + "_cloak",_loc5_.sex,1,"cloak",-1,1);
            _loc1_ = createResourceLoadInfo(_loc7_,AvatarStaticData.getBaseNumByType("Stand","cloak"),AvatarStaticData.getBaseNumByType("Walk","cloak"),"cloak");
            LoaderManagerII.instance.load(_loc7_,4,7,loaderCompleteHandler,null,null,_loc1_);
         }
         if(_loc4_.info.types == 1101)
         {
            this.mouseChildren = this.mouseEnabled = false;
            avatarView.shadowScaleX = avatarView.shadowScaleY = 1.5;
            avatarView.moveShadow(-68,-42);
         }
      }
      
      private function initDataImp() : void
      {
         if(_nodeInfo && _info)
         {
            __updateNodeStateHandler(null);
            addEvent();
            initMediator();
         }
      }
      
      private function initMediator() : void
      {
         if(!_nodeInfo)
         {
            return;
         }
         if(_nodeInfo.info.types == 101)
         {
            return;
         }
         if(!CampaignManager.instance.mapModel)
         {
            return;
         }
         var _loc5_:int = int(CampaignManager.instance.mapModel.mapId);
         var _loc1_:Array = [NpcStateMediator];
         var _loc4_:int = int((_nodeInfo as CampaignNode).param1);
         var _loc3_:CampaignArmy = CampaignManager.instance.mapModel.selfMemberData;
         var _loc2_:Boolean = false;
         if(_loc3_ && _loc4_ > 0 && _loc4_ == _loc3_.teamId)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc2_ = _nodeInfo.info.types == 42;
         }
         if(!WorldBossHelper.checkMonopoly(_loc5_))
         {
            if((_nodeInfo as CampaignNode).attackTypes == 1)
            {
               _loc1_.push(NpcAlertMediator);
               _loc1_.push(NpcAttackAndChaseMediator);
               _loc1_.push(NpcEnterFightMediator);
            }
            else if(!_loc2_ && _nodeInfo.info.types != 151 && _nodeInfo.info.types != 91 && CampaignManager.instance.mapModel.campaignTemplate.Types != 13)
            {
               if(!WorldBossHelper.checkPetLand(_loc5_) && !WorldBossHelper.checkFarm(_loc5_) && !WorldBossHelper.checkSumCampaign(_loc5_) && !WorldBossHelper.checkGodsEvening(_loc5_) && !WorldBossHelper.checkActiveVehicle(_loc5_))
               {
                  _loc1_.push(NpcAttackIIMediator);
               }
            }
         }
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.campaign.view.npc.NpcAvatarView");
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         if(_nodeInfo)
         {
            if(_nodeInfo.info)
            {
               _nodeInfo.info.addEventListener("UP_STATE",__updateNodeStateHandler);
            }
            _nodeInfo.addEventListener("UP_SONTYPE",__updateAvatarHandler);
            _nodeInfo.addEventListener("followTarget",__followTargetHandler);
            _nodeInfo.addEventListener("CHAT_DATA",__chatDataHandler);
            _nodeInfo.addEventListener("UPDATE_CUR_HP",__updateCurHpHandler);
            _nodeInfo.addEventListener("MOVE_POS",__movePosHandler);
         }
         if(info)
         {
            info.addEventListener("updateNextPoint",__nextPointHandler);
         }
         this.addEventListener("addedToStage",__addToStageHandler);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         if(_nodeInfo)
         {
            if(_nodeInfo.info)
            {
               _nodeInfo.info.removeEventListener("UP_STATE",__updateNodeStateHandler);
            }
            _nodeInfo.removeEventListener("UP_SONTYPE",__updateAvatarHandler);
            _nodeInfo.removeEventListener("followTarget",__followTargetHandler);
            _nodeInfo.removeEventListener("CHAT_DATA",__chatDataHandler);
            _nodeInfo.removeEventListener("UPDATE_CUR_HP",__updateCurHpHandler);
            _nodeInfo.removeEventListener("MOVE_POS",__movePosHandler);
         }
         if(info)
         {
            info.removeEventListener("updateNextPoint",__nextPointHandler);
         }
         this.removeEventListener("addedToStage",__addToStageHandler);
      }
      
      private function __movePosHandler(param1:PhysicsEvent) : void
      {
         x = _nodeInfo.x;
         y = _nodeInfo.y;
      }
      
      private function __chatDataHandler(param1:PhysicsEvent) : void
      {
         if(_nodeInfo.chatData == null)
         {
            if(_chatPopView)
            {
               _chatPopView.dispose();
            }
            _chatPopView = null;
            return;
         }
         if(_chatPopView)
         {
            _chatPopView.dispose();
            _chatPopView = null;
         }
         if(!_chatPopView)
         {
            _chatPopView = ChatFactory.createChatPopByType(_nodeInfo.chatData,__chatBackCall);
            _chatPopView.x = -_chatPopView.displayWidth / 2;
            _chatPopView.y = _npcName.y - _chatPopView.displayHeight;
            addChild(_chatPopView);
         }
      }
      
      public function __chatBackCall() : void
      {
         _chatPopView = null;
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         __followTargetHandler(null);
      }
      
      private function __followTargetHandler(param1:PhysicsEvent) : void
      {
         if((_nodeInfo as CampaignNode).followTarget != 0)
         {
            MediatorMananger.instance.addRegisterMediator(FollowTargetMediator,this,_mediatorKey);
            MediatorMananger.instance.removeRegisterMediator(NpcAttackAndChaseMediator,this,_mediatorKey);
         }
         else
         {
            MediatorMananger.instance.removeRegisterMediator(FollowTargetMediator,this,_mediatorKey);
         }
      }
      
      public function get aiInfo() : AIBaseInfo
      {
         return _info;
      }
      
      override public function execute() : void
      {
         if(info && info.isLiving)
         {
            super.execute();
         }
         if(_attackView)
         {
            _attackView.draw();
         }
      }
      
      private function __updateAvatarHandler(param1:PhysicsEvent) : void
      {
         refreshAvatarView();
         super.info = _info;
      }
      
      protected function __updateNodeStateHandler(param1:PhysicsEvent) : void
      {
         removeFireView();
         switch(int(_nodeInfo.info.state))
         {
            case 0:
            case 8:
            case 9:
               _info.isLiving = false;
               this.visible = false;
               break;
            case 4:
               _info.isLiving = true;
               aiInfo.pathInfo = [];
               this.visible = true;
               setFireView();
               break;
            default:
               _info.isLiving = true;
               this.visible = true;
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         displayVisible = param1;
      }
      
      private function setFireView() : void
      {
         if(!_attackView)
         {
            _attackView = new SimpleAvatarView(110,110,PathManager.fightStatePath,10);
         }
         _attackView.drawFrame = 2;
         addChild(_attackView);
         _attackView.x = -55;
         _attackView.y = -170;
      }
      
      private function set displayVisible(param1:Boolean) : void
      {
         if(param1)
         {
            if(_avatar)
            {
               addChild(_avatar);
            }
            if(_npcName)
            {
               addChild(_npcName);
            }
         }
         else
         {
            if(_avatar && _avatar.parent)
            {
               _avatar.parent.removeChild(_avatar);
            }
            if(_npcName && _npcName.parent)
            {
               _npcName.parent.removeChild(_npcName);
            }
         }
      }
      
      private function removeFireView() : void
      {
         if(_attackView)
         {
            _attackView.dispose();
         }
         _attackView = null;
         if(_bloodMc)
         {
            if(_bloodMc.parent)
            {
               _bloodMc.parent.removeChild(_bloodMc);
            }
            _bloodMc.stop();
            _bloodMc = null;
         }
      }
      
      protected function __updateCurHpHandler(param1:PhysicsEvent) : void
      {
         if(!_bloodMc)
         {
            _bloodMc = ComponentFactory.Instance.creatCustomObject("asset.campaign.map.BloodAsset");
         }
         _bloodMc.play();
         addChild(_bloodMc);
         _bloodMc.y = _bloodMc.height;
         var _loc2_:int = (_nodeInfo as CampaignNode).curHp * 100 / (_nodeInfo as CampaignNode).totalHp;
         _bloodMc.bloodMc.gotoAndStop(_loc2_);
         if(_bloodMc.bufferBar)
         {
            if(_bloodTween)
            {
               _bloodTween.currentProgress = 1;
            }
            _bloodTween = TweenMax.to(_bloodMc.bufferBar,0.4,{
               "delay":0.6,
               "frame":_loc2_,
               "onComplete":killBloodMaskTweens
            });
         }
      }
      
      private function killBloodMaskTweens() : void
      {
         if(_bloodTween)
         {
            _bloodTween.kill();
            _bloodTween = null;
         }
      }
      
      override protected function nextWalk(param1:Point) : void
      {
         super.nextWalk(param1);
         if(aiInfo.moveState == 4)
         {
            (_nodeInfo as CampaignNode).curPosX = param1.x;
            (_nodeInfo as CampaignNode).curPosY = param1.y;
         }
      }
      
      private function __nextPointHandler(param1:AiEvents) : void
      {
         var _loc5_:* = null;
         var _loc6_:Array = null;
         var _loc4_:Point = new Point(x,y);
         var _loc2_:Point = param1.data as Point;
         var _loc3_:int = Point.distance(_loc4_,_loc2_);
         if(_loc3_ < 20)
         {
            info.pathInfo = [];
            return;
         }
         _loc4_ = mapModel.getNeighborII(_loc4_.x / 20,_loc4_.y / 20);
         _loc2_ = mapModel.getNeighborII(_loc2_.x / 20,_loc2_.y / 20);
         if(!_loc4_ || !_loc2_)
         {
            return;
         }
         _loc4_.x *= 20;
         _loc4_.y *= 20;
         _loc2_.x *= 20;
         _loc2_.y *= 20;
         if(ExternalInterface.available && Boolean(LocalConnectionManager.instance.isUse))
         {
            _loc6_ = [_loc4_.x,_loc4_.y,_loc2_.x,_loc2_.y];
            LocalConnectionManager.instance.Call("searchPathAngle",_loc6_,searchPathSyc,null);
         }
         else
         {
            info.pathInfo = SearchPathHelper.searchPath(_loc4_,_loc2_);
         }
      }
      
      private function searchPathSyc(param1:Array, param2:Object) : void
      {
         var _loc3_:int = 0;
         if(!param1)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            param1[_loc3_] = new Point(param1[_loc3_].x,param1[_loc3_].y);
            _loc3_++;
         }
         info.pathInfo = param1;
      }
      
      public function get nodeInfo() : MapPhysics
      {
         return _nodeInfo;
      }
      
      protected function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      override protected function walkOver() : void
      {
         super.walkOver();
         standImp();
         npcAiInfo.moveState = 3;
      }
      
      override protected function loaderCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(_avatar)
         {
            (_avatar as HumanAvatar).loaderCompleteHandler(param1.args as ResourceLoaderInfo,param2);
         }
         if(param1.url.indexOf("body") >= 0 || param1.url.indexOf("npc") >= 0)
         {
            layouTextView(param1.url);
         }
      }
      
      protected function layouTextView(param1:String) : void
      {
         if(!_npcName)
         {
            return;
         }
         var _loc2_:Object = LoaderHeaderList.avatarShowNamePos[param1];
         showNamePosY = -110;
         if(_loc2_)
         {
            if(_loc2_.showNamePosY)
            {
               showNamePosY = _loc2_.showNamePosY;
            }
            if(_loc2_.hasOwnProperty("noShadow"))
            {
               _avatar.noShadow = _loc2_.noShadow;
            }
            if(_loc2_.hasOwnProperty("curTotalFrameX"))
            {
               _avatar.curTotalFrameX = _loc2_.curTotalFrameX;
            }
         }
         if(inWeddingRoom)
         {
            showNamePosY = -130;
         }
         _npcName.y = showNamePosY;
         if(inSacrificeRoom)
         {
            _npcName.y = -130;
         }
         if(WorldBossHelper.checkAirGarden(CampaignManager.instance.mapId))
         {
            _npcName.y = -130;
         }
         NotificationManager.instance.sendNotification("NPC_LOAD_COMPLETE",this);
      }
      
      private function get inSacrificeRoom() : Boolean
      {
         return WorldBossHelper.checkSacrificeRoom(CampaignManager.instance.mapId);
      }
      
      private function get inWeddingRoom() : Boolean
      {
         return WorldBossHelper.checkWedding(CampaignManager.instance.mapId);
      }
      
      public function get npcAiInfo() : NpcAiInfo
      {
         return _info as NpcAiInfo;
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
         killBloodMaskTweens();
         if(nodeInfo is CampaignNode)
         {
            (nodeInfo as CampaignNode).curPosX = this.x / 20;
            (nodeInfo as CampaignNode).curPosY = this.y / 20;
         }
         removeFireView();
         removeEvent();
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         super.dispose();
         if(_nodeInfo is CampaignNode)
         {
            _nodeInfo["nodeView"] = null;
         }
         _nodeInfo = null;
         if(_chatPopView)
         {
            _chatPopView.dispose();
         }
         _chatPopView = null;
      }
      
      public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:uint = uint(getCurrentPixels());
         if(_loc2_ <= 50)
         {
            return false;
         }
         CampaignManager.instance.mapModel.selectNode = _nodeInfo as CampaignNode;
         if(CampaignManager.instance.mapModel.chckeNpcFriendState(_nodeInfo as CampaignNode))
         {
            return false;
         }
         return attackFun();
      }
      
      public function attackFun() : Boolean
      {
         var _loc1_:String = null;
         var _loc3_:int = 0;
         if(!mapModel.mapTielsData)
         {
            return false;
         }
         if(_nodeInfo.info.types == 151)
         {
            _loc3_ = int((_nodeInfo as CampaignNode).param1);
            if(_loc3_ > 0 && mapModel.selfMemberData.teamId == _loc3_)
            {
               return false;
            }
            NotificationManager.instance.dispatchEvent(new NotificationEvent("LOCK_PVP_WARFIGHT",_nodeInfo));
            return true;
         }
         if(_nodeInfo.info.state == 4)
         {
            if(_nodeInfo.info.types == 91 || _nodeInfo.info.types == 181)
            {
               _loc1_ = LanguageMgr.GetTranslation("map.outercity.view.mapphysics.MapPhysicsCastle.command05");
               MessageTipManager.instance().show(_loc1_);
               CampaignManager.instance.mapModel.selectNode = null;
               return true;
            }
         }
         else if(_nodeInfo.info.types == 91)
         {
            NotificationManager.instance.sendNotification("CHASE_NPC",nodeInfo);
            return true;
         }
         var _loc4_:CampaignArmy = mapModel.selfMemberData;
         if(!_loc4_)
         {
            return false;
         }
         var _loc5_:Object = CampaignManager.instance.controller.getArmyView(_loc4_);
         var _loc6_:int = int(mapModel.mapId);
         var _loc2_:Point = NpcAttackHelper.getAttackPoint(nodeInfo as CampaignNode,new Point(_loc5_.x,_loc5_.y),new Point(this.x,this.y));
         CampaignManager.instance.controller.moveArmyByPos(_loc2_.x,_loc2_.y,false,true);
         return true;
      }
      
      public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         if(CampaignManager.instance.mapModel.chckeNpcFriendState(_nodeInfo as CampaignNode))
         {
            return _loc2_;
         }
         if(_avatar)
         {
            _loc3_ = int((_nodeInfo as CampaignNode).param1);
            if(_nodeInfo.info.types != 161 && _loc3_ > 0 && mapModel.selfMemberData.teamId == _loc3_)
            {
               return _loc2_;
            }
            _loc2_ = true;
            if(_nodeInfo.info.types == 161)
            {
               if(_loc3_ > 0 && mapModel.selfMemberData.teamId == _loc3_)
               {
                  _loc2_ = false;
               }
               else
               {
                  _loc2_ = true;
               }
            }
            if(!param1)
            {
               _filter.setGlowFilter(_avatar.contentBitmap);
               return _loc2_;
            }
            if((_avatar as HumanAvatar).getCurrentPixels() > 50)
            {
               _filter.setGlowFilter(_avatar.contentBitmap);
               return _loc2_;
            }
            _filter.setNormalFilter(_avatar.contentBitmap);
         }
         return false;
      }
      
      private function throughDispatch(param1:MouseEvent) : void
      {
         var _loc4_:Rectangle = null;
         var _loc2_:Array = CampaignManager.instance.mapModel.mapNodesData;
         for each(var _loc3_:CampaignNode in _loc2_)
         {
            if(NodeState.displayState(_loc3_.info.state))
            {
               if(_loc3_.nodeView && _loc3_.nodeView.stage)
               {
                  _loc4_ = _loc3_.nodeView.getRect(stage);
                  if(_loc4_.contains(param1.stageX,param1.stageY))
                  {
                     _loc3_.nodeView.dispatchEvent(param1);
                     return;
                  }
               }
            }
         }
         _loc2_ = null;
      }
      
      public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         _filter.setNormalFilter(_avatar.contentBitmap);
         return true;
      }
   }
}

