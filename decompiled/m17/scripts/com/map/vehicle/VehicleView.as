package com.map.vehicle
{
   import com.map.vehicle.data.HurtData;
   import com.map.vehicle.data.PlayerVehicleInfo;
   import com.map.vehicle.data.UseSkillInfo;
   import com.map.vehicle.data.VehicleNode;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.objects.TankAvatarView;
   import com.map.vehicle.objects.VehicleBoxView;
   import com.map.vehicle.objects.VehicleNpcAvatarView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.mapengine.bitmap.BaseMapScene;
   import com.road.mapengine.bitmap.logic.BitmapSimpleLogic;
   import com.road.mapengine.bitmap.logic.VehicleBaseSprite;
   import com.road.mapengine.bitmap.map.BaseMapsData;
   import com.road.mapengine.bitmap.map.BaseMapsView;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.effect.Earthquake;
   import map.internals.library.MapElmsLibrary;
   import yishi.manager.NotificationManager;
   
   public class VehicleView extends BaseMapScene
   {
      
      private var _objectLayer:Sprite;
      
      private var _nameLayer:Sprite;
      
      private var _backMapModel:BaseMapsData;
      
      private var _backMapView:BaseMapsView;
      
      private var _bossAttackNoticeMc:MovieClip;
      
      private var _characterController:VehicleCharacterController;
      
      private var _count:int;
      
      private var _cursorMc:MovieClip;
      
      private var _isDown:Boolean = false;
      
      private var _mapController:VehicleSceneController;
      
      private var _model:VehicleModel;
      
      private var _mouseDownTimeId:int;
      
      private var _selectedEffect:MovieClip;
      
      private var _selectedLogic:BitmapSimpleLogic;
      
      private var _selfArmy:TankAvatarView;
      
      private var _tempArr:Array = [];
      
      private var _timeId:int = 0;
      
      private var _topLayer:Sprite;
      
      private var _walkLayer:Sprite;
      
      private var _staticLayer:Sprite;
      
      private var _self:PlayerVehicleInfo;
      
      public function VehicleView(param1:Sprite)
      {
         super(param1);
      }
      
      public function get topLayer() : Sprite
      {
         return _topLayer;
      }
      
      public function get nameLayer() : Sprite
      {
         return _nameLayer;
      }
      
      private function init() : void
      {
         var _loc4_:TankAvatarView = null;
         var _loc3_:VehicleBoxView = null;
         var _loc1_:VehicleNpcAvatarView = null;
         _objectLayer = new Sprite();
         _nameLayer = new Sprite();
         _nameLayer.mouseChildren = _nameLayer.mouseEnabled = false;
         _backMapModel = new BaseMapsData();
         _backMapModel.elmsData = MapElmsLibrary.instance;
         _backMapModel.mapWidth = _model.mapTempInfo.Width;
         _backMapModel.mapHeight = _model.mapTempInfo.Height;
         _backMapModel.mapData = _model.floorData;
         _backMapView = new BaseMapsView();
         _backMapView.data = _backMapModel;
         _mapController = parent as VehicleSceneController;
         _staticLayer = new Sprite();
         _walkLayer = new Sprite();
         _topLayer = new Sprite();
         _objectLayer.addChild(_backMapView);
         _objectLayer.addChild(_staticLayer);
         _objectLayer.addChild(_walkLayer);
         _objectLayer.addChild(_topLayer);
         parent.addChild(_objectLayer);
         parent.addChild(_nameLayer);
         _cursorMc = ComponentFactory.Instance.creat("asset.vehiclemap.SkillCursor");
         _cursorMc.mouseChildren = false;
         _selectedEffect = ComponentFactory.Instance.creat("asset.vehiclemap.SelectedEffect");
         _selectedEffect.gotoAndStop(1);
         _selectedEffect.mouseEnabled = _selectedEffect.mouseChildren = false;
         _bossAttackNoticeMc = ComponentFactory.Instance.creat("asset.vehiclemap.BossSkillCursor");
         _bossAttackNoticeMc.gotoAndStop(1);
         _bossAttackNoticeMc.mouseEnabled = _bossAttackNoticeMc.mouseChildren = false;
         for each(var _loc5_:PlayerVehicleInfo in _model.playerList.getList())
         {
            _loc4_ = new TankAvatarView(this);
            _loc4_.angle = 36;
            _loc4_.data = _loc5_;
            _loc4_.x = _loc5_.x * 20;
            _loc4_.y = _loc5_.y * 20;
            _loc4_.state = 3;
            addLogic(_loc4_);
            addToWalkLayer(_loc4_.container);
         }
         for each(var _loc2_:VehicleNode in _model.nodeList)
         {
            if(_loc2_.resource != 1)
            {
               _loc3_ = new VehicleBoxView(this);
               _loc3_.data = _loc2_;
               _loc3_.x = _loc2_.posX * 20;
               _loc3_.y = _loc2_.posY * 20;
               addLogic(_loc3_);
               addToStaticLayer(_loc3_.container);
            }
            else
            {
               _loc1_ = new VehicleNpcAvatarView(this);
               _loc1_.data = _loc2_;
               _loc1_.x = _loc2_.posX * 20;
               _loc1_.y = _loc2_.posY * 20;
               _loc1_.state = 3;
               addLogic(_loc1_);
               addToStaticLayer(_loc1_.container);
            }
         }
         if(_model.selfVehicleInfo && _model.selfVehicleInfo.logicView)
         {
            _mapController.dispatchEvent(new CampaignMapEvent("LOOK_AT_ROLE",_model.selfVehicleInfo.logicView));
         }
      }
      
      public function get self() : PlayerVehicleInfo
      {
         return _self;
      }
      
      public function set self(param1:PlayerVehicleInfo) : void
      {
         removeSelfEvent();
         _self = param1;
         addSelfEvent();
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseDown",__mouseClickHandler);
         addEventListener("mouseUp",__mouseUpHandler);
         addEventListener("mouseOut",__mouseOutHandler);
         addEventListener("mouseOver",__mouseOverHandler);
         addEventListener("mouseMove",__mouseMoveHandler);
         addEventListener("deactivate",__deactiveteHandler);
         _model.addEventListener("addPlayer",__addPlayerHandler);
         _model.addEventListener("remove_player",__removePlayerHandler);
         _model.addEventListener("addNode",__addNodeHandler);
         _model.addEventListener("updateNode",__updateNodeHandler);
         _model.addEventListener("REMOVE_NODE",__updateNodeHandler);
         _model.addEventListener("ATTACK_NOTICE",__attackNoticeHandler);
         NotificationManager.instance.addEventListener("EARTHQUAKE",__earthQuakeHandler);
         if(_model.selfVehicleInfo)
         {
            self = _model.selfVehicleInfo;
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseDown",__mouseClickHandler);
         removeEventListener("mouseUp",__mouseUpHandler);
         removeEventListener("mouseOut",__mouseOutHandler);
         removeEventListener("mouseOver",__mouseOverHandler);
         removeEventListener("mouseMove",__mouseMoveHandler);
         removeEventListener("deactivate",__deactiveteHandler);
         _model.removeEventListener("addPlayer",__addPlayerHandler);
         _model.removeEventListener("remove_player",__removePlayerHandler);
         _model.removeEventListener("addNode",__addNodeHandler);
         _model.removeEventListener("updateNode",__updateNodeHandler);
         _model.removeEventListener("REMOVE_NODE",__updateNodeHandler);
         _model.removeEventListener("ATTACK_NOTICE",__attackNoticeHandler);
         NotificationManager.instance.removeEventListener("EARTHQUAKE",__earthQuakeHandler);
      }
      
      private function addSelfEvent() : void
      {
         if(_self)
         {
            _self.addEventListener("SKILL_SHOOT_OVER",__earthQuakeHandler);
            _self.addEventListener("SKILL_HURT",__earthQuakeHandler);
            _self.addEventListener("DIE",__selfDieHandler);
            _self.addEventListener("REVIER",__selfRevierHandler);
         }
      }
      
      private function removeSelfEvent() : void
      {
         if(_self)
         {
            _self.removeEventListener("SKILL_SHOOT_OVER",__earthQuakeHandler);
            _self.removeEventListener("SKILL_HURT",__earthQuakeHandler);
            _self.removeEventListener("DIE",__selfDieHandler);
            _self.removeEventListener("REVIER",__selfRevierHandler);
         }
      }
      
      private function __earthQuakeHandler(param1:VehicleEvent) : void
      {
         var _loc3_:UseSkillInfo = null;
         var _loc2_:Array = null;
         var _loc4_:HurtData = null;
         if(param1.data is UseSkillInfo)
         {
            _loc3_ = param1.data as UseSkillInfo;
            _loc2_ = [13,5,6];
            if(_loc2_.indexOf(_loc3_.skillId) >= 0)
            {
               Earthquake.go(parent,10,0.2);
            }
         }
         else if(param1.data is HurtData)
         {
            _loc4_ = param1.data as HurtData;
            if(_loc4_.attackType == 1)
            {
               Earthquake.go(parent,10,0.2);
            }
         }
      }
      
      private function __selfDieHandler(param1:VehicleEvent) : void
      {
      }
      
      private function __selfRevierHandler(param1:VehicleEvent) : void
      {
      }
      
      public function addToStaticLayer(param1:DisplayObject) : DisplayObject
      {
         return _staticLayer.addChild(param1);
      }
      
      public function addToWalkLayer(param1:DisplayObject) : DisplayObject
      {
         return _walkLayer.addChild(param1);
      }
      
      public function get characterController() : VehicleCharacterController
      {
         return _characterController;
      }
      
      override public function enterFrame() : void
      {
         if(_characterController.isSelection)
         {
            if(!_cursorMc.parent)
            {
               _staticLayer.addChild(_cursorMc);
               _cursorMc.scaleX = _characterController.scale;
               _cursorMc.scaleY = _characterController.scale;
            }
            _cursorMc.x = _topLayer.mouseX;
            _cursorMc.y = _topLayer.mouseY;
         }
         else if(_cursorMc.parent)
         {
            _cursorMc.parent.removeChild(_cursorMc);
         }
         super.enterFrame();
         updateWalkDepth();
         checkFoucs();
      }
      
      public function findNearEnemy() : BitmapSimpleLogic
      {
         var _loc5_:BitmapSimpleLogic = null;
         var _loc2_:Point = null;
         var _loc4_:int = 0;
         if(!_model.selfVehicleInfo)
         {
            return null;
         }
         if(!_model.selfVehicleInfo.logicView)
         {
            return null;
         }
         var _loc6_:int = 800;
         var _loc1_:Point = new Point(_model.selfVehicleInfo.logicView.x,_model.selfVehicleInfo.logicView.y);
         var _loc3_:int = 800;
         for each(var _loc7_:PlayerVehicleInfo in _model.playerList)
         {
            if(_loc7_ != _model.selfVehicleInfo)
            {
               if(!_model.isFriend(_loc7_.team))
               {
                  if(_loc7_.logicView)
                  {
                     _loc2_ = new Point(_loc7_.logicView.x,_loc7_.logicView.y);
                     _loc4_ = Point.distance(_loc1_,_loc2_);
                     if(_loc4_ < _loc6_ && _loc4_ < _loc3_ && _loc7_.hp > 0)
                     {
                        _loc3_ = _loc4_;
                        _loc5_ = _loc7_.logicView;
                     }
                  }
               }
            }
         }
         return _loc5_;
      }
      
      public function getClicker() : BitmapSimpleLogic
      {
         return this.selectedLogic;
      }
      
      public function getMouesPos() : Point
      {
         return new Point(_mapController.mouseX,_mapController.mouseY);
      }
      
      public function set model(param1:VehicleModel) : void
      {
         _model = param1;
         _characterController = new VehicleCharacterController(this,_model);
         init();
         addEvent();
      }
      
      public function moveMeToPos(param1:int, param2:int) : void
      {
         _mapController.moveVehicleToPos(param1,param2);
      }
      
      public function get selectedLogic() : BitmapSimpleLogic
      {
         return _selectedLogic;
      }
      
      public function set selectedLogic(param1:BitmapSimpleLogic) : void
      {
         var _loc3_:TankAvatarView = null;
         var _loc2_:VehicleNpcAvatarView = null;
         if(_selectedLogic)
         {
            _selectedLogic.unSelect();
            _selectedLogic = null;
         }
         if(_model.selfVehicleInfo.isDie)
         {
            return;
         }
         if(_selectedEffect.parent)
         {
            _selectedEffect.parent.removeChild(_selectedEffect);
            _selectedEffect.hitArea = null;
         }
         if(param1 is TankAvatarView)
         {
            _loc3_ = param1 as TankAvatarView;
            if(!_loc3_.data.isDie)
            {
               _selectedLogic = param1;
               _selectedLogic.select(_selectedEffect);
               _selectedEffect.play();
            }
         }
         else if(param1 is VehicleNpcAvatarView)
         {
            _loc2_ = param1 as VehicleNpcAvatarView;
            if(!_loc2_.isDie)
            {
               _selectedLogic = param1;
               _selectedLogic.select(_selectedEffect);
               _selectedEffect.play();
            }
         }
         else
         {
            _selectedEffect.gotoAndStop(1);
         }
      }
      
      public function updateWalkDepth() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DisplayObject = null;
         var _loc3_:int = 0;
         _count = _count + 1;
         if(_count % 20 != 0)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _walkLayer.numChildren)
         {
            _loc1_ = _walkLayer.getChildAt(_loc2_);
            _tempArr.push({
               "obj":_loc1_,
               "x":_loc1_.x,
               "y":_loc1_.y,
               "index":_loc2_
            });
            _loc2_++;
         }
         _tempArr = _tempArr.sort(checkDepth);
         _loc3_ = 0;
         while(_loc3_ < _tempArr.length)
         {
            if(_tempArr[_loc3_].index != _loc3_)
            {
               if(_walkLayer.numChildren > _loc3_)
               {
                  _walkLayer.addChildAt(_tempArr[_loc3_].obj as DisplayObject,_loc3_);
               }
               else
               {
                  _walkLayer.addChild(_tempArr[_loc3_].obj as DisplayObject);
               }
            }
            _loc3_++;
         }
         while(_tempArr.length > 0)
         {
            _tempArr.pop();
         }
      }
      
      private function __addNodeHandler(param1:VehicleEvent) : void
      {
         var _loc4_:VehicleBoxView = null;
         var _loc2_:VehicleNpcAvatarView = null;
         var _loc3_:VehicleNode = param1.data as VehicleNode;
         if(_loc3_.resource != 1)
         {
            _loc4_ = new VehicleBoxView(this);
            _loc4_.data = _loc3_;
            _loc4_.x = _loc3_.posX * 20;
            _loc4_.y = _loc3_.posY * 20;
            addLogic(_loc4_);
            addToStaticLayer(_loc4_.container);
         }
         else
         {
            _loc2_ = new VehicleNpcAvatarView(this);
            _loc2_.data = _loc3_;
            _loc2_.x = _loc3_.posX * 20;
            _loc2_.y = _loc3_.posY * 20;
            addLogic(_loc2_);
            addToStaticLayer(_loc2_.container);
         }
      }
      
      private function __addPlayerHandler(param1:VehicleEvent) : void
      {
         var _loc2_:TankAvatarView = null;
         var _loc3_:PlayerVehicleInfo = param1.data as PlayerVehicleInfo;
         if(_loc3_)
         {
            _loc2_ = new TankAvatarView(this);
            _loc2_.angle = 36;
            _loc2_.data = _loc3_;
            _loc2_.x = _loc3_.x * 20;
            _loc2_.y = _loc3_.y * 20;
            addLogic(_loc2_);
            addToWalkLayer(_loc2_.container);
            if(_model.selfVehicleInfo == _loc3_)
            {
               self = _model.selfVehicleInfo;
               _mapController.dispatchEvent(new CampaignMapEvent("LOOK_AT_ROLE",_model.selfVehicleInfo.logicView));
            }
         }
      }
      
      private function __attackNoticeHandler(param1:VehicleEvent) : void
      {
         var _loc2_:Point = param1.data as Point;
         _staticLayer.addChildAt(_bossAttackNoticeMc,0);
         _bossAttackNoticeMc.x = _loc2_.x;
         _bossAttackNoticeMc.y = _loc2_.y;
         if(_timeId != 0)
         {
            clearTimeout(_timeId);
            _timeId = 0;
         }
         _timeId = setTimeout(noticeEnd,2000);
      }
      
      private function __deactiveteHandler(param1:Event) : void
      {
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
         }
         _mouseDownTimeId = 0;
         _isDown = false;
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:BitmapSimpleLogic = null;
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
         }
         _mouseDownTimeId = 0;
         if(param1.target is VehicleBaseSprite)
         {
            _loc3_ = (param1.target as VehicleBaseSprite).logic;
            if(_loc3_.mouseClickEvent(param1))
            {
               this.selectedLogic = _loc3_;
               return;
            }
         }
         if(_characterController.isSelection)
         {
            return;
         }
         var _loc2_:Point = getMouesPos();
         moveMeToPos(_loc2_.x,_loc2_.y);
         _isDown = true;
         _mouseDownTimeId = setInterval(clickWalk,500);
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:BitmapSimpleLogic = null;
         if(param1.target is VehicleBaseSprite)
         {
            _loc2_ = (param1.target as VehicleBaseSprite).logic;
            if(_loc2_.mouseMoveEvent(param1))
            {
               return;
            }
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:BitmapSimpleLogic = null;
         if(param1.target is VehicleBaseSprite)
         {
            _loc2_ = (param1.target as VehicleBaseSprite).logic;
            if(_loc2_.mouseOutEvent(param1))
            {
               return;
            }
         }
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:BitmapSimpleLogic = null;
         if(param1.target is VehicleBaseSprite)
         {
            _loc2_ = (param1.target as VehicleBaseSprite).logic;
            if(_loc2_.mouseOverEvent(param1))
            {
               return;
            }
         }
      }
      
      private function __mouseUpHandler(param1:MouseEvent) : void
      {
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
         }
         _mouseDownTimeId = 0;
         _isDown = false;
      }
      
      private function __removePlayerHandler(param1:VehicleEvent) : void
      {
         var _loc2_:BitmapSimpleLogic = null;
         var _loc3_:PlayerVehicleInfo = param1.data as PlayerVehicleInfo;
         if(_loc3_)
         {
            _loc2_ = _loc3_.logicView;
            if(_loc2_)
            {
               _loc2_.dispose();
               removeLogic(_loc2_);
            }
            if(_loc2_ == this.selectedLogic)
            {
               this.selectedLogic = null;
            }
         }
      }
      
      private function __updateNodeHandler(param1:VehicleEvent) : void
      {
         var _loc3_:BitmapSimpleLogic = null;
         var _loc2_:VehicleNode = param1.data as VehicleNode;
         if(_loc2_)
         {
            _loc3_ = _loc2_.logicView;
            if(_loc2_.state == 1)
            {
               if(_loc3_ == this.selectedLogic)
               {
                  this.selectedLogic = null;
               }
               if(_loc3_)
               {
                  _loc3_.dispose();
                  removeLogic(_loc3_);
               }
            }
         }
      }
      
      private function checkDepth(param1:Object, param2:Object) : int
      {
         if(param1.y > param2.y)
         {
            return 1;
         }
         if(param1.y == param2.y)
         {
            if(param1.x < param2.x)
            {
               return -1;
            }
            if(param1.x > param2.x)
            {
               return 1;
            }
            return param1.index > param2.index ? 1 : -1;
         }
         return -1;
      }
      
      private function checkFoucs() : void
      {
         if(!selectedLogic)
         {
            return;
         }
         if(!_model.selfVehicleInfo)
         {
            return;
         }
         if(!_model.selfVehicleInfo.logicView)
         {
            return;
         }
         var _loc1_:Point = new Point(_model.selfVehicleInfo.logicView.x,_model.selfVehicleInfo.logicView.y);
         var _loc3_:Point = new Point(selectedLogic.x,selectedLogic.y);
         var _loc2_:int = Point.distance(_loc1_,_loc3_);
         if(_loc2_ > 800)
         {
            selectedLogic = null;
         }
      }
      
      private function clickWalk() : void
      {
         var _loc1_:Point = null;
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
         }
         _mouseDownTimeId = 0;
         if(_isDown)
         {
            _mouseDownTimeId = setInterval(clickWalk,500);
            _loc1_ = getMouesPos();
            moveMeToPos(_loc1_.x,_loc1_.y);
         }
      }
      
      private function getLogicsUnderPoint(param1:Point) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:BitmapSimpleLogic in _list)
         {
            if(_loc3_.hitRect.containsPoint(param1))
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("instanceId",2);
         return _loc2_;
      }
      
      private function noticeEnd() : void
      {
         if(_timeId != 0)
         {
            clearTimeout(_timeId);
            _timeId = 0;
         }
         if(_bossAttackNoticeMc && _bossAttackNoticeMc.parent)
         {
            _bossAttackNoticeMc.parent.removeChild(_bossAttackNoticeMc);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_mouseDownTimeId > 0)
         {
            clearInterval(_mouseDownTimeId);
            _mouseDownTimeId = 0;
         }
         if(_characterController)
         {
            _characterController.dispose();
            _characterController = null;
         }
         if(_timeId != 0)
         {
            clearTimeout(_timeId);
            _timeId = 0;
         }
         if(_selectedEffect)
         {
            _selectedEffect.gotoAndStop(1);
            ObjectUtils.disposeObject(_selectedEffect);
         }
         if(_cursorMc)
         {
            _cursorMc.gotoAndStop(1);
            ObjectUtils.disposeObject(_cursorMc);
         }
         if(_bossAttackNoticeMc)
         {
            _bossAttackNoticeMc.gotoAndStop(1);
            ObjectUtils.disposeObject(_bossAttackNoticeMc);
         }
         ObjectUtils.disposeAllChildren(_staticLayer);
         _staticLayer = null;
         ObjectUtils.disposeAllChildren(_walkLayer);
         _walkLayer = null;
         ObjectUtils.disposeAllChildren(_topLayer);
         _topLayer = null;
         ObjectUtils.disposeAllChildren(_objectLayer);
         _objectLayer = null;
         ObjectUtils.disposeAllChildren(_nameLayer);
         _nameLayer = null;
         if(_backMapModel)
         {
            _backMapModel.elmsData = null;
            _backMapModel.mapData = null;
            _backMapModel = null;
         }
         if(_backMapView)
         {
            _backMapView.dispose();
            _backMapView = null;
         }
         self = null;
         _selectedLogic = null;
         super.dispose();
      }
   }
}

