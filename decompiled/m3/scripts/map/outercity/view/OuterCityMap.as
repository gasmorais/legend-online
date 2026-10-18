package map.outercity.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.speedEngine.components.bone.BoneMovieFactory;
   import com.speedEngine.game.Director;
   import com.speedEngine.game.base.AppStage;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import mainBar.SmallMapBar;
   import map.internals.event.OuterCityEvent;
   import map.internals.library.MapElmsLibrary;
   import map.internals.mediator.mapview.LockTargetMediator;
   import map.internals.view.layer.MapRenderLayer;
   import map.internals.view.layer.OuterCityStaticLayer;
   import map.internals3D.Stage3DManager;
   import map.internals3D.display3d.Sprite3D;
   import map.internals3D.mapbackground.MapBackgroundView3D;
   import map.internals3D.mapbackground.model.MapBackgroundMaxModel3D;
   import map.outercity.BoxMsgInfo;
   import map.outercity.OuterCityController;
   import map.outercity.OuterCityModel;
   import map.outercity.helper.mapview.MapViewHelper;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.mediator.layer.DeleteWorldPlayerMediator;
   import map.outercity.mediator.mapview.OuterCityDragMediator;
   import map.outercity.mediator.mapview.OuterCityMapCursorMediator;
   import map.outercity.mediator.mapview.OuterCityMapDirectionKeyMediator;
   import map.outercity.mediator.mapview.OuterCityMouseEventMediator;
   import map.outercity.mediator.mapview.OuterCitySmallMapMediator;
   import map.outercity.mediator.mapview.TranseferMediator;
   import map.outercity.view.bossinfo.OuterCityBossBoxView;
   import map.outercity.view.cloud.OuterCityCloudView;
   import map.outercity.view.layer.OuterCityBorderLayer;
   import map.outercity.view.layer.OuterCityDenseFogLayer;
   import map.outercity.view.layer.OuterCityMainBuidingLayer;
   import map.outercity.view.layer.OuterCityNpcLayer;
   import map.outercity.view.layer.WorldWalkLayer;
   import yishi.datas.VersionSwitch;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.utils.StringUtil;
   
   public class OuterCityMap extends Sprite implements Disposeable
   {
      
      public static const NAME:String = "map.outercity.view.OuterCityMap";
      
      public static var RENDER_TILE:Boolean = true;
      
      public static var RENDER_TILE_3D:Boolean = true;
      
      private var _model:OuterCityModel;
      
      public var isMove:Boolean = false;
      
      private var _contro:OuterCityController;
      
      private var _mapBackgroundHitArea:Sprite;
      
      private var _mapBackgroundView:MapBackgroundView3D;
      
      private var _mapTileContainer3D:Sprite3D;
      
      private var _mapTileContainer2D:Sprite;
      
      private var _staticLayer:OuterCityStaticLayer;
      
      private var _mainBuidingLayer:OuterCityMainBuidingLayer;
      
      private var _npcLayer:OuterCityNpcLayer;
      
      private var _worldWalkLayer:WorldWalkLayer;
      
      private var _staticRender:MapRenderLayer;
      
      private var _cloudView:OuterCityCloudView;
      
      private var _borderLayer:OuterCityBorderLayer;
      
      private var _denseFogLayer:OuterCityDenseFogLayer;
      
      private var _mediatorKey:String;
      
      private var _boxObj:Object;
      
      private var _moveTimeId:int;
      
      private var _reshrePoint:Point = new Point();
      
      public function OuterCityMap(param1:OuterCityController, param2:OuterCityModel)
      {
         super();
         RENDER_TILE_3D = VersionSwitch.OUTCITY_3D;
         _contro = param1;
         _model = param2;
         init();
         addEvent();
      }
      
      public function get denseFogLayer() : OuterCityDenseFogLayer
      {
         return _denseFogLayer;
      }
      
      public function get staticRender() : MapRenderLayer
      {
         return _staticRender;
      }
      
      private function init() : void
      {
         var _loc1_:BitmapData = null;
         OuterCityManager.instance.mapView = this;
         if(_model.mapTempInfo.Width < 5000)
         {
            _loc1_ = new BitmapData(_model.mapTempInfo.Width,_model.mapTempInfo.Height,true,0);
            _staticRender = new MapRenderLayer(this,_loc1_);
            _staticRender.elmsDatas = MapElmsLibrary.instance;
            _staticRender.data = _model.floorData;
         }
         else
         {
            createMapBackground();
         }
         _mainBuidingLayer = new OuterCityMainBuidingLayer();
         _mainBuidingLayer.mapData = _model;
         this.addChild(_mainBuidingLayer);
         _npcLayer = new OuterCityNpcLayer();
         _npcLayer.mapData = _model;
         addChild(_npcLayer);
         _worldWalkLayer = new WorldWalkLayer();
         this.addChild(_worldWalkLayer);
         _borderLayer = new OuterCityBorderLayer();
         addChild(_borderLayer);
         _boxObj = {};
         _denseFogLayer = new OuterCityDenseFogLayer(_model.mapTempInfo.Width,_model.mapTempInfo.Height);
         this.addChild(_denseFogLayer);
         if(OuterCityManager.instance.model.bossInfo.leftFogTime > 0)
         {
            onRemoveFog();
         }
         if(_model.mapTempInfo.Id != 100)
         {
            _cloudView = new OuterCityCloudView();
            addChild(_cloudView);
         }
      }
      
      private function onRemoveFog(param1:OuterCityEvent = null) : void
      {
         if(this.contains(_denseFogLayer))
         {
            this.removeChild(_denseFogLayer);
         }
      }
      
      private function onAddFog(param1:OuterCityEvent) : void
      {
         this.addChild(_denseFogLayer);
      }
      
      private function createMapBackground() : void
      {
         if(!RENDER_TILE)
         {
            _staticLayer = new OuterCityStaticLayer();
            _staticLayer.mapData = _model;
            this.addChild(_staticLayer);
         }
         else if(RENDER_TILE_3D && checkVersion())
         {
            Stage3DManager.instance.create(create3DCallBack);
         }
         else
         {
            _mapTileContainer2D = new Sprite();
            _mapBackgroundView = new MapBackgroundView3D(_mapTileContainer2D,false);
            _mapBackgroundView.model = new MapBackgroundMaxModel3D();
            _mapBackgroundView.x = x;
            _mapBackgroundView.y = y;
            this.addChildAt(_mapTileContainer2D,0);
         }
      }
      
      private function create3DCallBack() : void
      {
         Director.instance.hideInfoSprite();
         if(Director.instance.isOpenDriver() && AppStage.context3D)
         {
            _mapBackgroundHitArea = new Sprite();
            _mapBackgroundHitArea.graphics.beginFill(0,0);
            _mapBackgroundHitArea.graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
            _mapBackgroundHitArea.graphics.endFill();
            this.addChildAt(_mapBackgroundHitArea,0);
            _mapBackgroundHitArea.x = -x;
            _mapBackgroundHitArea.y = -y;
            _mapTileContainer3D = new Sprite3D();
            Director.instance.addToLayer("aad",_mapTileContainer3D);
            _mapBackgroundView = new MapBackgroundView3D(_mapTileContainer3D,true);
            _mapBackgroundView.model = new MapBackgroundMaxModel3D();
            _mapBackgroundView.x = x;
            _mapBackgroundView.y = y;
         }
         else
         {
            _mapTileContainer2D = new Sprite();
            _mapBackgroundView = new MapBackgroundView3D(_mapTileContainer2D,false);
            _mapBackgroundView.model = new MapBackgroundMaxModel3D();
            _mapBackgroundView.x = x;
            _mapBackgroundView.y = y;
            this.addChildAt(_mapTileContainer2D,0);
         }
      }
      
      private function checkVersion() : Boolean
      {
         var _loc2_:String = getNoStrVersion(Capabilities.version);
         var _loc1_:Array = _loc2_.split(",");
         if(int(_loc1_[0]) > 11)
         {
            return true;
         }
         return int(_loc1_[0]) >= 11 && int(_loc1_[1]) >= 4;
      }
      
      private function getNoStrVersion(param1:String) : String
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1.charAt(_loc2_);
            if(!StringUtil.isEnglish(_loc3_))
            {
               return StringUtil.ltrim(param1.substring(_loc2_,param1.length));
            }
            _loc2_++;
         }
         return param1;
      }
      
      private function initRegisterList() : void
      {
         var _loc1_:Array = [OuterCityDragMediator,OuterCityMapCursorMediator,OuterCityMapDirectionKeyMediator,OuterCityMouseEventMediator,OuterCitySmallMapMediator,DeleteWorldPlayerMediator,TranseferMediator,LockTargetMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.outercity.view.OuterCityMap");
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         this.addEventListener("addedToStage",__addedToStageHandler);
         NotificationManager.instance.addEventListener("OUTER_CITY_REMOVE_FOG",onRemoveFog);
         NotificationManager.instance.addEventListener("OUTER_CITY_ADD_FOG",onAddFog);
         NotificationManager.instance.addEventListener("OUTER_CITY_UPDATE_BOX",onUpdateBox);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         this.removeEventListener("addedToStage",__addedToStageHandler);
         NotificationManager.instance.removeEventListener("OUTER_CITY_REMOVE_FOG",onRemoveFog);
         NotificationManager.instance.removeEventListener("OUTER_CITY_ADD_FOG",onAddFog);
         NotificationManager.instance.removeEventListener("OUTER_CITY_UPDATE_BOX",onUpdateBox);
      }
      
      private function onUpdateBox(param1:OuterCityEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:BoxMsgInfo = null;
         var _loc5_:OuterCityBossBoxView = null;
         var _loc2_:Array = _model.bossInfo.bossBoxList;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_];
            _loc5_ = _boxObj[_loc3_.boxId];
            if(_loc5_ == null)
            {
               _loc5_ = new OuterCityBossBoxView();
               _loc5_.setData(_loc3_);
               addChild(_loc5_);
               _boxObj[_loc3_.boxId] = _loc5_;
            }
            _loc4_++;
         }
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         moveEnd();
         if(_staticLayer)
         {
            _staticLayer.resize();
         }
         if(_mapBackgroundHitArea)
         {
            _mapBackgroundHitArea.width = StageReferance.stageWidth;
            _mapBackgroundHitArea.height = StageReferance.stageHeight;
         }
      }
      
      private function __addedToStageHandler(param1:Event) : void
      {
         initRegisterList();
         var _loc2_:Point = MapViewHelper.targetSolveCenter(_model.targetPoint);
         this.x = _loc2_.x;
         this.y = _loc2_.y;
         moveEnd();
      }
      
      public function moveEnd() : void
      {
         var _loc1_:Rectangle = MapViewHelper.getCurrentMapRect(this);
         _contro.moveMapCallBack(_loc1_);
         _mainBuidingLayer.outSceneMovies();
         _borderLayer.update();
      }
      
      public function onDraging() : void
      {
         var _loc1_:Rectangle = MapViewHelper.getCurrentMapRect(this);
         _contro.moveMapCallBack(_loc1_);
      }
      
      public function motionTo(param1:Point) : void
      {
         param1 = MapViewHelper.checkTargetPoint(param1);
         _model.targetPoint = param1;
         var _loc2_:Point = param1;
         if(this.x == _loc2_.x && this.y == _loc2_.y)
         {
            return;
         }
         if(isMove)
         {
            return;
         }
         isMove = true;
         var _loc3_:int = MapViewHelper.checkDistance(this.x,this.y,_loc2_.x,_loc2_.y);
         if(_moveTimeId > 0)
         {
            clearInterval(_moveTimeId);
         }
         _moveTimeId = 0;
         this.alpha = 1;
         if(_loc3_ > 1000)
         {
            this.x = _loc2_.x;
            this.y = _loc2_.y;
            moveTweencompleted();
            _moveTimeId = setInterval(unLockScene,1300);
         }
         else
         {
            TweenLite.to(this,0.3,{
               "x":_loc2_.x,
               "y":_loc2_.y,
               "onComplete":moveTweencompleted
            });
         }
      }
      
      private function unLockScene() : void
      {
         if(_moveTimeId > 0)
         {
            clearInterval(_moveTimeId);
         }
         _moveTimeId = 0;
         this.alpha = 1;
      }
      
      public function novimotionTo(param1:Point) : void
      {
         param1 = MapViewHelper.checkTargetPoint(param1);
         _model.targetPoint = param1;
         var _loc2_:Point = param1;
         if(this.x == _loc2_.x && this.y == _loc2_.y)
         {
            return;
         }
         if(isMove)
         {
            return;
         }
         isMove = true;
         this.x = _loc2_.x;
         this.y = _loc2_.y;
         moveTweencompleted();
      }
      
      private function moveTweencompleted() : void
      {
         if(!_contro)
         {
            return;
         }
         moveEnd();
         isMove = false;
         if(_staticLayer)
         {
            _staticLayer.upDateNextRend();
         }
      }
      
      public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         removeEvent();
         if(_borderLayer)
         {
            _borderLayer.dispose();
         }
         _borderLayer = null;
         if(_staticRender)
         {
            _staticRender.dispose();
         }
         _staticRender = null;
         if(_staticLayer)
         {
            _staticLayer.dispose();
         }
         if(_mapBackgroundHitArea)
         {
            ObjectUtils.disposeObject(_mapBackgroundHitArea);
            _mapBackgroundHitArea = null;
         }
         if(_mapTileContainer2D)
         {
            ObjectUtils.disposeObject(_mapTileContainer2D);
            _mapTileContainer2D = null;
         }
         if(_mapBackgroundView)
         {
            _mapBackgroundView.dispose();
            _mapBackgroundView = null;
         }
         if(_mapTileContainer3D)
         {
            try
            {
               if(RENDER_TILE_3D)
               {
                  BoneMovieFactory.instance.removieSkeletons();
               }
               _mapTileContainer3D.dispose();
               _mapTileContainer3D = null;
            }
            catch(evt:Error)
            {
            }
         }
         if(_npcLayer)
         {
            _npcLayer.dispose();
         }
         ObjectUtils.disposeAllChildren(this);
         _npcLayer = null;
         _staticLayer = null;
         _mainBuidingLayer = null;
         _contro = null;
         _model = null;
         if(_denseFogLayer)
         {
            _denseFogLayer.dispose();
         }
         _denseFogLayer = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
         if(_mapBackgroundHitArea)
         {
            _mapBackgroundHitArea.x = -x;
         }
         if(_mapBackgroundView)
         {
            _mapBackgroundView.x = x;
         }
         SmallMapBar.instance.iconContainerX = param1 / 16;
         if(Math.abs(param1 - _reshrePoint.x) > 100)
         {
            _reshrePoint.x = param1;
            _reshrePoint.y = y;
            if(_staticLayer)
            {
               _staticLayer.upDateNextRend();
               _staticLayer.backgroundXandY(-this.x,-this.y);
            }
            _worldWalkLayer.outSceneMovies();
         }
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
         if(_mapBackgroundHitArea)
         {
            _mapBackgroundHitArea.y = -y;
         }
         if(_mapBackgroundView)
         {
            _mapBackgroundView.y = y;
         }
         SmallMapBar.instance.iconContainerY = param1 / 16;
         if(Math.abs(param1 - _reshrePoint.y) > 100)
         {
            _reshrePoint.y = param1;
            _reshrePoint.x = x;
            if(_staticLayer)
            {
               _staticLayer.upDateNextRend();
               _staticLayer.backgroundXandY(-this.x,-this.y);
            }
            _worldWalkLayer.outSceneMovies();
         }
      }
      
      public function get staticLayer() : OuterCityStaticLayer
      {
         return _staticLayer;
      }
      
      public function get worldWalkLayer() : WorldWalkLayer
      {
         return _worldWalkLayer;
      }
      
      public function get mainBuidingLayer() : OuterCityMainBuidingLayer
      {
         return _mainBuidingLayer;
      }
      
      public function get npcLayer() : OuterCityNpcLayer
      {
         return _npcLayer;
      }
      
      public function moveMapHandler(param1:String) : void
      {
         var _loc2_:Array = param1.split(",");
         if(_loc2_.length == 2)
         {
            motionTo(new Point(int(_loc2_[0]) * 50,int(_loc2_[1]) * 50));
         }
      }
   }
}

