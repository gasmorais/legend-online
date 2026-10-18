package com.map.vehicle.objects
{
   import com.greensock.TweenMax;
   import com.map.vehicle.action.HurtNumberAction;
   import com.map.vehicle.action.ShootAction;
   import com.map.vehicle.data.HurtData;
   import com.map.vehicle.data.UseSkillInfo;
   import com.map.vehicle.data.VGlobal;
   import com.map.vehicle.data.VehicleNode;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.interfaces.ICaster;
   import com.map.vehicle.utils.AsynActionManager;
   import com.map.vehicle.view.EffectsLayer;
   import com.map.vehicle.view.VehicleNpcBloodStuffView;
   import com.pickgliss.loader.LoaderHeaderList;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.mapengine.bitmap.BaseMapScene;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import com.road.mapengine.bitmap.logic.BitmapAvatarLogic;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import yishi.manager.ActionQueueManager;
   import yishi.manager.PathManager;
   
   public class VehicleNpcAvatarView extends BitmapAvatarLogic implements ICaster
   {
      
      private var _skillQueue:ActionQueueManager;
      
      private var _asynActionMgr:AsynActionManager;
      
      private var _data:VehicleNode;
      
      private var _effectLayer:EffectsLayer;
      
      private var _stuffView:VehicleNpcBloodStuffView;
      
      private var _showNamePosY:int = -125;
      
      private var _defaultMovie:MovieClip;
      
      private var _hurtNumLayer:Sprite;
      
      private var _delayTween:TweenMax;
      
      public function VehicleNpcAvatarView(param1:BaseMapScene, param2:Boolean = true)
      {
         super(param1,param2);
         _walkTotalFrameX = 5;
         _walkTotalFrameY = 4;
         _standTotalFrameX = 4;
         _standTotalFrameY = 2;
         _attackTotalFrameX = 5;
         _attackTotalFrameY = 4;
         _skillQueue = new ActionQueueManager();
         _asynActionMgr = new AsynActionManager();
      }
      
      private function initView() : void
      {
         _stuffView = new VehicleNpcBloodStuffView();
         _effectLayer = new EffectsLayer();
         _defaultMovie = ComponentFactory.Instance.creatCustomObject("asset.avatar.DefaultAvatarMovieAsset");
         _hurtNumLayer = new Sprite();
         _hurtNumLayer.mouseChildren = _hurtNumLayer.mouseEnabled = false;
         _container.addChild(_baseView);
         addChild(_defaultMovie);
         _container.addChild(_effectLayer);
         VGlobal.logicWorld.nameLayer.addChild(_stuffView);
         VGlobal.logicWorld.nameLayer.addChild(_hurtNumLayer);
      }
      
      public function get data() : VehicleNode
      {
         return _data;
      }
      
      public function set data(param1:VehicleNode) : void
      {
         _data = param1;
         _data.logicView = this;
         initView();
         _stuffView.data = _data;
         _effectLayer.data = _data;
         _effectLayer.tankBody = this._baseView;
         addEvent();
         loadResource();
      }
      
      private function addEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("SKILL_CAST_OVER",__useSkillHandler);
            _data.addEventListener("SKILL_HURT",__skillHurtHandler);
            _data.addEventListener("BUFF_HURT",__buffHurtHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("SKILL_CAST_OVER",__useSkillHandler);
            _data.removeEventListener("SKILL_HURT",__skillHurtHandler);
            _data.removeEventListener("BUFF_HURT",__buffHurtHandler);
         }
      }
      
      private function __useSkillHandler(param1:VehicleEvent) : void
      {
         var _loc2_:UseSkillInfo = param1.data;
         var _loc3_:ShootAction = new ShootAction(this,_loc2_);
         _skillQueue.addAction(_loc3_);
      }
      
      private function __skillHurtHandler(param1:VehicleEvent) : void
      {
         var _loc2_:HurtData = param1.data as HurtData;
         var _loc3_:HurtNumberAction = new HurtNumberAction(this,_loc2_);
         _asynActionMgr.addAction(_loc3_);
         if(_loc2_.skillId == 1 && VGlobal.model.selfVehicleInfo && _loc2_.shootId == VGlobal.model.selfVehicleInfo.playerId)
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
      
      override public function update() : void
      {
         if(_skillQueue)
         {
            _skillQueue.update();
         }
         if(_asynActionMgr)
         {
            _asynActionMgr.update();
         }
         super.update();
      }
      
      private function loadResource() : void
      {
         var _loc1_:ResourceLoaderInfo = createLoaderInfo(String(data.sonType),"body",false);
         var _loc2_:String = getResourcepath(String(data.sonType));
         LoaderManagerII.instance.load(_loc2_,4,4,loaderResourceCall,null,null,_loc1_);
      }
      
      override protected function loaderResourceCall(param1:LoaderInfo, param2:Object) : void
      {
         if(!_skillQueue)
         {
            return;
         }
         if(_defaultMovie)
         {
            ObjectUtils.disposeObject(_defaultMovie);
            _defaultMovie = null;
         }
         super.loaderResourceCall(param1,param2);
         layout();
      }
      
      private function layout() : void
      {
         var _loc3_:String = getResourcepath(String(data.sonType));
         var _loc2_:Object = LoaderHeaderList.avatarShowNamePos[_loc3_];
         var _loc1_:int = -160;
         if(_loc2_ && _loc2_.showNamePosY)
         {
            _loc1_ = int(_loc2_.showNamePosY);
         }
         _stuffView.y = this.y + _showNamePosY;
      }
      
      private function createLoaderInfo(param1:String, param2:String, param3:Boolean) : ResourceLoaderInfo
      {
         var _loc4_:ResourceLoaderInfo = new ResourceLoaderInfo();
         _loc4_.url = getResourcepath(param1);
         _loc4_.position = param2;
         _loc4_.resourceType = 5;
         _loc4_.queueLoader = param3;
         _loc4_.loaderType = 4;
         return _loc4_;
      }
      
      override public function mouseClickEvent(param1:MouseEvent) : Boolean
      {
         var _loc3_:* = 0;
         var _loc2_:Boolean = false;
         if(_baseView)
         {
            _loc3_ = _baseView.bitmapData.getPixel(_baseView.mouseX,_baseView.mouseY);
            if(_loc3_ > 50)
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      override public function mouseMoveEvent(param1:MouseEvent) : Boolean
      {
         var _loc2_:Boolean = false;
         if(!_baseView)
         {
            return false;
         }
         var _loc3_:uint = _baseView.bitmapData.getPixel(_baseView.mouseX,_baseView.mouseY);
         if(_loc3_ > 50)
         {
            VGlobal.buildfilter.setGlowFilter(_baseView);
            _loc2_ = true;
         }
         else
         {
            _baseView.filters = null;
         }
         return _loc2_;
      }
      
      override public function mouseOutEvent(param1:MouseEvent) : Boolean
      {
         if(_baseView)
         {
            _baseView.filters = null;
         }
         return true;
      }
      
      override protected function getResourcepath(param1:String) : String
      {
         return PathManager.getVehicleNPCPath(param1);
      }
      
      override public function get curResourceType() : int
      {
         return 5;
      }
      
      override protected function updateDepth() : void
      {
      }
      
      public function beAttacted(param1:UseSkillInfo) : void
      {
      }
      
      public function bombFlyOut() : void
      {
      }
      
      public function changeDirectionTo(param1:int, param2:int) : void
      {
         var _loc3_:Number = param1 - x;
         var _loc4_:Number = param2 - y;
         var _loc5_:Number = Math.atan2(_loc4_,_loc3_);
         var _loc6_:int = _loc5_ * 180 / 3.141592653589793;
         if(_loc6_ < 0)
         {
            _loc6_ += 360;
         }
         this.angle = _loc6_;
         if(_delayTween)
         {
            _delayTween.kill();
            _delayTween = null;
         }
         this.state = 2;
         _delayTween = TweenMax.delayedCall(0.7,attackOver);
      }
      
      private function attackOver() : void
      {
         if(_delayTween)
         {
            _delayTween.kill();
            _delayTween = null;
         }
         this.state = 3;
      }
      
      public function getShootPoint() : Point
      {
         return new Point(this.x,this.y - 80);
      }
      
      public function playBombSmoke(param1:Sprite) : void
      {
      }
      
      override public function select(param1:Sprite) : void
      {
         if(param1)
         {
            addChildAt(param1,0);
            param1.y = 0;
         }
      }
      
      public function get isDie() : Boolean
      {
         return _data.hp <= 0;
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
         if(_stuffView)
         {
            _stuffView.x = super.x;
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
            _stuffView.y = super.y + _showNamePosY;
         }
         if(_hurtNumLayer)
         {
            _hurtNumLayer.y = this.y;
         }
      }
      
      override public function set sizeType(param1:int) : void
      {
         super.sizeType = param1;
         _showNamePosY = -125;
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
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderResourceCall);
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
         if(_stuffView)
         {
            _stuffView.dispose();
         }
         _stuffView = null;
         ObjectUtils.disposeObject(_effectLayer);
         _effectLayer = null;
         ObjectUtils.disposeObject(_hurtNumLayer);
         _hurtNumLayer = null;
         if(_defaultMovie)
         {
            ObjectUtils.disposeObject(_defaultMovie);
            _defaultMovie = null;
         }
         super.dispose();
      }
   }
}

