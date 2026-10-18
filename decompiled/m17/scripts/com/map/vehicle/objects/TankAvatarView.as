package com.map.vehicle.objects
{
   import com.greensock.TweenMax;
   import com.map.vehicle.SkillEffectFactory;
   import com.map.vehicle.VehicleModel;
   import com.map.vehicle.action.CastAction;
   import com.map.vehicle.action.HurtNumberAction;
   import com.map.vehicle.action.PickupAction;
   import com.map.vehicle.action.ShootAction;
   import com.map.vehicle.data.HurtData;
   import com.map.vehicle.data.PlayerVehicleInfo;
   import com.map.vehicle.data.SkillCastInfo;
   import com.map.vehicle.data.TankState;
   import com.map.vehicle.data.UseSkillInfo;
   import com.map.vehicle.data.VGlobal;
   import com.map.vehicle.data.VehicleNode;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.interfaces.ICaster;
   import com.map.vehicle.net.VehicleSocketManager;
   import com.map.vehicle.utils.AsynActionManager;
   import com.map.vehicle.view.EffectsLayer;
   import com.map.vehicle.view.VehicleBloodStuffView;
   import com.map.vehicle.view.VehicleChatPopView;
   import com.pickgliss.loader.ResourceDomain;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.mapengine.ai.astar.AvatarPathWalkAi;
   import com.road.mapengine.bitmap.BaseMapScene;
   import com.road.mapengine.bitmap.logic.BitmapAvatarLogic;
   import com.road.mapengine.bitmap.logic.BitmapSimpleLogic;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ActionQueueManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   
   public class TankAvatarView extends BitmapAvatarLogic implements ICaster
   {
      
      private var _skillQueue:ActionQueueManager;
      
      private var _asynActionMgr:AsynActionManager;
      
      private var _pathLogic:AvatarPathWalkAi;
      
      private var _data:PlayerVehicleInfo;
      
      private var _model:VehicleModel = VehicleSocketManager.instance.model;
      
      private var _barrel:MovieClip;
      
      private var _soulMc:MovieClip;
      
      private var _riverMc:MovieClip;
      
      private var _barrelLayer:Sprite;
      
      private var _effectLayer:EffectsLayer;
      
      private var _stuffView:VehicleBloodStuffView;
      
      private var _standPos:Bitmap;
      
      private var _chatPopView:VehicleChatPopView;
      
      private var _showNamePosY:int = -125;
      
      private var _hurtNumLayer:Sprite;
      
      private var resDomain:ResourceDomain;
      
      private var _angleCorrect:Number;
      
      private var _barrelPos:Point = new Point();
      
      private var _follow:BitmapSimpleLogic;
      
      private var _dieTimeId:int = 0;
      
      private var _lastSoundTime:Number = 0;
      
      private var _curLabel:String = "Stand";
      
      public function TankAvatarView(param1:BaseMapScene)
      {
         super(param1);
         _skillQueue = new ActionQueueManager();
         _asynActionMgr = new AsynActionManager();
         _pathLogic = new AvatarPathWalkAi();
         _pathLogic.avatar = this;
         _walkTotalFrameX = 5;
         _walkTotalFrameY = 4;
         _standTotalFrameX = 4;
         _standTotalFrameY = 2;
         _standPos = ComponentFactory.Instance.creatBitmap("asset.core.StandShadowAsset");
         _standPos.width = 150;
         _standPos.x = -70;
         _standPos.y = -42;
         _barrelLayer = new Sprite();
         _effectLayer = new EffectsLayer();
         _stuffView = new VehicleBloodStuffView();
         _soulMc = ComponentFactory.Instance.creat("asset.vehiclemap.DieEffect");
         _soulMc.gotoAndStop(1);
         _soulMc.y = -75;
         _riverMc = ComponentFactory.Instance.creat("asset.vehiclemap.RiverMC");
         _riverMc.gotoAndStop(1);
         _riverMc.y = -75;
         _hurtNumLayer = new Sprite();
         _soulMc.mouseEnabled = _soulMc.mouseChildren = false;
         _barrelLayer.mouseChildren = _barrelLayer.mouseEnabled = false;
         _effectLayer.mouseChildren = _effectLayer.mouseEnabled = false;
         _stuffView.mouseChildren = _stuffView.mouseEnabled = false;
         _riverMc.mouseChildren = _riverMc.mouseEnabled = false;
         _hurtNumLayer.mouseChildren = _hurtNumLayer.mouseEnabled = false;
      }
      
      public function get data() : PlayerVehicleInfo
      {
         return _data;
      }
      
      public function set data(param1:PlayerVehicleInfo) : void
      {
         if(_data)
         {
            return;
         }
         resDomain = SkillEffectFactory.instance.domain;
         _data = param1;
         _data.logicView = this;
         initView();
         _container.mouseEnabled = _container.mouseChildren = !isFriend;
         addEvent();
         _effectLayer.data = param1;
         _stuffView.data = _data;
         loadResource();
         if(_model.isFriend(_data.team))
         {
            _container.mouseChildren = _container.mouseEnabled = false;
         }
         if(_data.hp <= 0)
         {
            __onDieHandler();
         }
      }
      
      private function initView() : void
      {
         _container.addChild(_standPos);
         _container.addChild(_baseView);
         _container.addChild(_barrelLayer);
         VGlobal.logicWorld.nameLayer.addChild(_stuffView);
         VGlobal.logicWorld.nameLayer.addChild(_hurtNumLayer);
         _container.addChild(_effectLayer);
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
         if(_stuffView)
         {
            _stuffView.x = param1;
         }
         if(_hurtNumLayer)
         {
            _hurtNumLayer.x = this.x;
         }
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
         if(_stuffView)
         {
            _stuffView.y = param1 + _showNamePosY;
         }
         if(_hurtNumLayer)
         {
            _hurtNumLayer.y = this.y;
         }
      }
      
      override public function set sizeType(param1:int) : void
      {
         super.sizeType = param1;
         _showNamePosY = getNamePosY();
         layout();
      }
      
      private function getNamePosY() : int
      {
         var _loc1_:int = -125;
         switch(sizeType - 1)
         {
            case 0:
               _loc1_ = -125;
               break;
            case 1:
               _loc1_ = -150;
               break;
            case 2:
            case 9:
               _loc1_ = -165;
         }
         return _loc1_;
      }
      
      private function addEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("SKILL_CAST_OVER",__useSkillHandler);
            _data.addEventListener("cast",__castHandler);
            _data.addEventListener("pickup",__onPickupHandler);
            _data.addEventListener("stateChange",__stateChangeHandler);
            _data.addEventListener("playerInfoChange",__updateHandler);
            _data.addEventListener("SKILL_HURT",__skillHurtHandler);
            _data.addEventListener("BUFF_HURT",__buffHurtHandler);
            _data.addEventListener("CHAT_DATA",__teamChatHandler);
            _data.addEventListener("HP_ADD",__addHpHandler);
            _data.addEventListener("DIE",__onDieHandler);
            _data.addEventListener("REVIER",__onRiverHandler);
            _pathLogic.addEventListener("WALK_OVER",__walkOverHandler);
         }
         if(isSelf)
         {
            playerInfo.addEventListener("CONSORTIA_NAME_CHANGE",__consortiaChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("SKILL_CAST_OVER",__useSkillHandler);
            _data.removeEventListener("cast",__castHandler);
            _data.removeEventListener("pickup",__onPickupHandler);
            _data.removeEventListener("stateChange",__stateChangeHandler);
            _data.removeEventListener("playerInfoChange",__updateHandler);
            _data.removeEventListener("SKILL_HURT",__skillHurtHandler);
            _data.removeEventListener("BUFF_HURT",__buffHurtHandler);
            _data.removeEventListener("CHAT_DATA",__teamChatHandler);
            _data.removeEventListener("HP_ADD",__addHpHandler);
            _data.removeEventListener("DIE",__onDieHandler);
            _data.removeEventListener("REVIER",__onRiverHandler);
            _pathLogic.removeEventListener("WALK_OVER",__walkOverHandler);
         }
         if(isSelf)
         {
            playerInfo.removeEventListener("CONSORTIA_NAME_CHANGE",__consortiaChangeHandler);
         }
      }
      
      public function get isFriend() : Boolean
      {
         var _loc1_:int = 0;
         if(_model.selfVehicleInfo && _data)
         {
            _loc1_ = _model.selfVehicleInfo.team;
            return _loc1_ == _data.team;
         }
         return true;
      }
      
      public function get isSelf() : Boolean
      {
         if(data)
         {
            return data == _model.selfVehicleInfo;
         }
         return false;
      }
      
      private function loadResource() : void
      {
         resDomain.removeCallBackFunction(__onLoadedHandler);
         var _loc1_:String = PathManager.getVehicleAvatarPath(String(_data.template.Avatar));
         resDomain.load(_loc1_,false,__onLoadedHandler);
      }
      
      private function __onLoadedHandler() : void
      {
         if(!_skillQueue)
         {
            return;
         }
         if(_barrel)
         {
            _barrel.gotoAndStop(1);
            ObjectUtils.disposeObject(_barrel);
         }
         var _loc3_:String = data.template.Avatar.substr(1);
         var _loc2_:String = "asset.avatar." + _loc3_;
         var _loc1_:ResourceDomain = SkillEffectFactory.instance.domain;
         if(_loc1_ && _loc1_.hasDefinition(_loc2_))
         {
            _barrel = _loc1_.createInstane(_loc2_) as MovieClip;
            _barrelLayer.addChild(_barrel);
            _barrel.mouseChildren = _barrel.mouseEnabled = false;
            keepAngleWithBody();
            _effectLayer.tankBody = _barrel;
         }
         layout();
         if(_data.hp <= 0)
         {
            __onDieHandler();
         }
      }
      
      private function layout() : void
      {
         if(_stuffView)
         {
            _effectLayer.posA = _showNamePosY - _stuffView.getTextHeight() - 5;
         }
      }
      
      public function changeDirectionTo(param1:int, param2:int) : void
      {
         if(!_barrel)
         {
            return;
         }
         var _loc3_:Number = param1 - x;
         var _loc4_:Number = param2 - y;
         var _loc5_:Number = Math.atan2(_loc4_,_loc3_);
         var _loc6_:int = _loc5_ * 180 / 3.141592653589793;
         if(_loc6_ < 0)
         {
            _loc6_ += 360;
         }
         this.angle = _loc6_;
      }
      
      public function getShootPoint() : Point
      {
         var _loc2_:Sprite = null;
         var _loc1_:Point = new Point(this.x,this.y);
         if(_barrel && _barrel["bombpos"])
         {
            _loc2_ = _barrel["bombpos"] as Sprite;
            if(_loc2_)
            {
               _loc1_ = _loc2_.localToGlobal(new Point(0,0));
               _loc1_ = mapScene.parent.globalToLocal(_loc1_);
            }
         }
         return _loc1_;
      }
      
      public function bombFlyOut() : void
      {
         if(!_barrel)
         {
            return;
         }
      }
      
      public function playBombSmoke(param1:Sprite) : void
      {
         if(_barrel)
         {
            _barrel.gotoAndPlay("Attack" + (frameY + 1));
         }
      }
      
      public function fineTuning(param1:Number) : Point
      {
         param1 = param1 < 0 ? param1 + 360 : param1;
         if(param1 >= 260 && param1 < 280)
         {
            _barrelPos.x = 4;
            _barrelPos.y = 1;
         }
         else if(param1 >= 280 && param1 < 350)
         {
            _barrelPos.x = 3;
            _barrelPos.y = 1;
         }
         else if(param1 >= 350 || param1 < 10)
         {
            _barrelPos.x = 2;
            _barrelPos.y = 1;
         }
         else if(param1 >= 10 && param1 < 80)
         {
            _barrelPos.x = 1;
            _barrelPos.y = 1;
         }
         else if(param1 >= 80 && param1 < 100)
         {
            _barrelPos.x = 0;
            _barrelPos.y = 1;
         }
         else if(param1 < 170 && param1 >= 100)
         {
            _barrelPos.x = 1;
            _barrelPos.y = -1;
         }
         else if(param1 < 190 && param1 >= 170)
         {
            _barrelPos.x = 2;
            _barrelPos.y = -1;
         }
         else if(param1 < 260 && param1 >= 190)
         {
            _barrelPos.x = 3;
            _barrelPos.y = -1;
         }
         return _barrelPos;
      }
      
      public function get follow() : BitmapSimpleLogic
      {
         return _follow;
      }
      
      public function set follow(param1:BitmapSimpleLogic) : void
      {
         _follow = param1;
         if(_follow)
         {
            changeDirectionTo(_follow.x,_follow.y);
         }
      }
      
      override protected function drawStand() : void
      {
      }
      
      override protected function darwWalk() : void
      {
      }
      
      private function __castHandler(param1:VehicleEvent) : void
      {
         var _loc2_:CastAction = null;
         var _loc3_:SkillCastInfo = param1.data as SkillCastInfo;
         if(_loc3_)
         {
            _loc2_ = new CastAction(this,_loc3_.skillid);
            _loc2_.targetLogic = _loc3_.target;
            _loc2_.targetPoint = _loc3_.castPos;
            _skillQueue.addAction(_loc2_);
         }
      }
      
      private function __onPickupHandler(param1:VehicleEvent) : void
      {
         var _loc3_:PickupAction = null;
         var _loc2_:VehicleNode = VehicleNode(param1.data);
         if(_loc2_ && _loc2_.logicView)
         {
            _loc3_ = new PickupAction(this,_loc2_.logicView);
            _skillQueue.addAction(_loc3_);
            VehicleSocketManager.instance.controller.vehicleWorld.characterController.cancel();
         }
      }
      
      private function __stateChangeHandler(param1:VehicleEvent) : void
      {
         if(_data.state == TankState.Stun)
         {
            stop();
         }
      }
      
      private function __updateHandler(param1:VehicleEvent) : void
      {
      }
      
      private function __skillHurtHandler(param1:VehicleEvent) : void
      {
         var _loc2_:HurtData = param1.data as HurtData;
         var _loc3_:HurtNumberAction = new HurtNumberAction(this,_loc2_);
         _asynActionMgr.addAction(_loc3_);
         if(_loc2_.skillId == 1 && _model.selfVehicleInfo && _loc2_.shootId == _model.selfVehicleInfo.playerId)
         {
            SoundManager.instance.play("050");
         }
      }
      
      private function __buffHurtHandler(param1:VehicleEvent) : void
      {
         var _loc2_:HurtData = param1.data as HurtData;
         var _loc3_:HurtNumberAction = new HurtNumberAction(this,_loc2_);
         _asynActionMgr.addAction(_loc3_);
      }
      
      private function __useSkillHandler(param1:VehicleEvent) : void
      {
         var _loc2_:UseSkillInfo = param1.data;
         var _loc3_:ShootAction = new ShootAction(this,_loc2_);
         _skillQueue.addAction(_loc3_);
      }
      
      private function __teamChatHandler(param1:VehicleEvent) : void
      {
         if(_chatPopView)
         {
            _chatPopView.dispose();
         }
         _chatPopView = null;
         if(!_chatPopView)
         {
            _chatPopView = new VehicleChatPopView();
            _chatPopView.data = _data.chatData;
            _chatPopView.x = -_chatPopView.displayWidth / 2;
            _chatPopView.y = _standPos.y - 100 - _chatPopView.displayHeight;
            if(_stuffView)
            {
               _chatPopView.y = -13 - _chatPopView.displayHeight;
               _stuffView.addChild(_chatPopView);
            }
            else
            {
               addChild(_chatPopView);
            }
         }
      }
      
      private function __addHpHandler(param1:VehicleEvent) : void
      {
         var _loc4_:int = param1.data;
         var _loc2_:HurtData = new HurtData();
         _loc2_.effectType = 1;
         _loc2_.effectValue = _loc4_;
         var _loc3_:HurtNumberAction = new HurtNumberAction(this,_loc2_);
         _asynActionMgr.addAction(_loc3_);
      }
      
      private function __onDieHandler(param1:VehicleEvent = null) : void
      {
         unSelect();
         container.mouseEnabled = container.mouseChildren = false;
         if(_barrel && _barrel.parent)
         {
            _barrel.parent.removeChild(_barrel);
         }
         if(_soulMc)
         {
            _barrelLayer.addChild(_soulMc);
            _soulMc.gotoAndPlay(1);
         }
         if(_dieTimeId > 0)
         {
            clearTimeout(_dieTimeId);
         }
         _dieTimeId = 0;
         var _loc2_:Number = (_data.rebornTime - 1) * 1000;
         if(_loc2_ >= 0)
         {
            _dieTimeId = setTimeout(playRiverMovie,_loc2_);
         }
         SoundManager.instance.play("047");
      }
      
      private function playRiverMovie() : void
      {
         if(_dieTimeId > 0)
         {
            clearTimeout(_dieTimeId);
         }
         _dieTimeId = 0;
         if(_soulMc && _soulMc.parent)
         {
            _soulMc.gotoAndStop(1);
            _soulMc.parent.removeChild(_soulMc);
         }
         if(_riverMc)
         {
            _barrelLayer.addChild(_riverMc);
            _riverMc.gotoAndStop(1);
            TweenMax.to(_riverMc,1,{
               "frame":_riverMc.totalFrames,
               "onComplete":riverMcCompleteHandler
            });
         }
      }
      
      private function riverMcCompleteHandler() : void
      {
         if(_riverMc && _riverMc.parent)
         {
            TweenMax.killTweensOf(_riverMc);
            _riverMc.parent.removeChild(_riverMc);
         }
      }
      
      private function __onRiverHandler(param1:VehicleEvent = null) : void
      {
         if(isSelf)
         {
            SoundManager.instance.play("010");
         }
         _container.mouseEnabled = container.mouseChildren = !isFriend;
         if(_dieTimeId > 0)
         {
            clearTimeout(_dieTimeId);
         }
         _dieTimeId = 0;
         riverMcCompleteHandler();
         if(_soulMc && _soulMc.parent)
         {
            _soulMc.gotoAndStop(1);
            _soulMc.parent.removeChild(_soulMc);
         }
         if(_barrel)
         {
            _barrelLayer.addChild(_barrel);
         }
      }
      
      private function __chatBackCall() : void
      {
      }
      
      public function keepAngleWithBody() : void
      {
         if(_barrel)
         {
            _barrel.scaleX = mirror;
            _barrel.gotoAndPlay(curLabel + (frameY + 1));
         }
      }
      
      public function getAngle(param1:Point, param2:Point) : Number
      {
         var _loc3_:Number = param2.x - param1.x;
         var _loc4_:Number = param2.y - param1.y;
         var _loc6_:Number = Math.atan2(_loc4_,_loc3_);
         var _loc5_:int = _loc6_ * 180 / 3.141592653589793;
         if(_loc5_ < 0)
         {
            _loc5_ += 360;
         }
         return _loc5_;
      }
      
      public function set path(param1:Array) : void
      {
         if(_pathLogic)
         {
            _pathLogic.paths = param1;
         }
      }
      
      public function get path() : Array
      {
         if(_pathLogic)
         {
            return _pathLogic.paths;
         }
         return null;
      }
      
      public function beAttacted(param1:UseSkillInfo) : void
      {
      }
      
      override protected function getResourcepath(param1:String) : String
      {
         return PathManager.getVehicleAvatarPath(param1);
      }
      
      override public function update() : void
      {
         var _loc1_:Number = getTimer();
         if(_asynActionMgr)
         {
            _asynActionMgr.update();
         }
         if(_skillQueue)
         {
            _skillQueue.update();
         }
         if(_pathLogic)
         {
            _pathLogic.execute();
         }
         if(_stuffView)
         {
            _stuffView.updateHoner();
         }
         super.update();
         if(_data)
         {
            if(_data.isStun)
            {
               stop();
            }
         }
      }
      
      override public function get speed() : int
      {
         if(_data)
         {
            return _data.speed;
         }
         return 7;
      }
      
      override public function get curResourceType() : int
      {
         return 6;
      }
      
      override public function mouseClickEvent(param1:MouseEvent) : Boolean
      {
         if(_data && _data == _model.selfVehicleInfo)
         {
            return false;
         }
         var _loc2_:Boolean = true;
         if(_loc2_)
         {
         }
         return _loc2_;
      }
      
      override public function mouseMoveEvent(param1:MouseEvent) : Boolean
      {
         var _loc2_:Boolean = false;
         if(_data && _data == _model.selfVehicleInfo)
         {
            return false;
         }
         if(_barrel)
         {
            _loc2_ = Boolean(_container.hitTestPoint(StageReferance.stage.mouseX,StageReferance.stage.mouseY,true));
            if(_loc2_)
            {
               VGlobal.buildfilter.setGlowFilter(_barrel);
            }
            else
            {
               VGlobal.buildfilter.setNormalFilter(_barrel);
            }
         }
         return _loc2_;
      }
      
      override public function mouseOutEvent(param1:MouseEvent) : Boolean
      {
         if(_data && _data == _model.selfVehicleInfo)
         {
            return false;
         }
         if(_barrel)
         {
            VGlobal.buildfilter.setNormalFilter(_barrel);
         }
         return true;
      }
      
      override public function mouseOverEvent(param1:MouseEvent) : Boolean
      {
         return true;
      }
      
      override protected function drawJumpPrepare() : void
      {
      }
      
      override protected function drawAttackPrepare() : void
      {
      }
      
      override protected function darwWalkPrepare() : void
      {
      }
      
      public function get curLabel() : String
      {
         return _curLabel;
      }
      
      public function set curLabel(param1:String) : void
      {
         if(_curLabel == param1)
         {
            return;
         }
         _curLabel = param1;
      }
      
      override public function set angle(param1:Number) : void
      {
         super.angle = param1;
         if(_barrel)
         {
            _barrel.scaleX = mirror;
            playBarrel();
         }
      }
      
      override public function set state(param1:int) : void
      {
         if(_state != param1)
         {
            _state = param1;
            if(state == 3)
            {
               curLabel = "Stand";
            }
            else if(state == 4)
            {
               curLabel = "Walk";
            }
            else if(state == 2)
            {
               curLabel = "Attack";
            }
            playBarrel();
         }
      }
      
      private function playBarrel() : void
      {
         var _loc1_:String = curLabel + (frameY + 1);
         if(!_barrel)
         {
            return;
         }
         if(_loc1_ == _barrel.currentLabel)
         {
            return;
         }
         _barrel.gotoAndPlay(_loc1_);
      }
      
      override public function stop() : void
      {
         super.stop();
         this.path = null;
      }
      
      private function __walkOverHandler(param1:VehicleEvent) : void
      {
         _lastSoundTime = 0;
      }
      
      private function __consortiaChangeHandler(param1:PlayerEvent) : void
      {
         if(_data)
         {
            _data.consortiaName = playerInfo.consortiaName;
            if(_stuffView)
            {
               _stuffView.update();
            }
         }
      }
      
      override public function select(param1:Sprite) : void
      {
         if(param1)
         {
            super.select(param1);
            addChildAt(param1,0);
            param1.y = -25;
         }
      }
      
      public function addHurtMovie(param1:DisplayObject) : void
      {
         if(_hurtNumLayer)
         {
            _hurtNumLayer.addChild(param1);
         }
         else
         {
            addChild(param1);
         }
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         if(resDomain)
         {
            resDomain.removeCallBackFunction(__onLoadedHandler);
         }
         resDomain = null;
         if(_dieTimeId > 0)
         {
            clearTimeout(_dieTimeId);
         }
         _dieTimeId = 0;
         removeEvent();
         if(_skillQueue)
         {
            _skillQueue.dispose();
         }
         _skillQueue = null;
         if(_asynActionMgr)
         {
            _asynActionMgr.dispose();
         }
         _asynActionMgr = null;
         ObjectUtils.disposeObject(_soulMc);
         _soulMc = null;
         if(_effectLayer)
         {
            _effectLayer.dispose();
         }
         _effectLayer = null;
         ObjectUtils.disposeViolentMc(_barrelLayer);
         _barrelLayer = null;
         ObjectUtils.disposeObject(_standPos);
         _standPos = null;
         ObjectUtils.disposeObject(_pathLogic);
         _pathLogic = null;
         ObjectUtils.disposeObject(_stuffView);
         _stuffView = null;
         ObjectUtils.disposeObject(_hurtNumLayer);
         _hurtNumLayer = null;
         if(_riverMc)
         {
            TweenMax.killTweensOf(_riverMc);
            ObjectUtils.disposeObject(_riverMc);
            _riverMc = null;
         }
         super.dispose();
      }
   }
}

