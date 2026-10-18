package map.space.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.bg.BgLayer;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import mainBar.SmallMapBar;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import map.campaign.data.MouseData;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.mediator.mapview.LockTargetMediator;
   import map.internals.mediator.team.FreedomTeamFollowMediator;
   import map.internals.mediator.team.FreedomTeamListMediator;
   import map.internals.view.layer.MapNameLayer;
   import map.internals.view.layer.MapRenderLayer;
   import map.internals.view.layer.OuterCityStaticLayer;
   import map.space.SpaceManager;
   import map.space.SpaceModel;
   import map.space.SpaceSceneController;
   import map.space.helper.mapview.SpaceMapViewHelper;
   import map.space.mediator.mapview.SpaceActivationMovieMediator;
   import map.space.mediator.mapview.SpaceCursorMediator;
   import map.space.mediator.mapview.SpaceMapCameraMediator;
   import map.space.mediator.mapview.SpaceMouseEventMediator;
   import map.space.mediator.mapview.SpacePKMediator;
   import map.space.mediator.mapview.SpaceUIMediator;
   import map.space.view.layer.SpaceApexLayer;
   import map.space.view.layer.SpaceBuildingLayer;
   import map.space.view.layer.SpaceNpcLayer;
   import map.space.view.layer.SpaceWalkLayer;
   import map.space.view.physics.MarryCarView;
   import mvc.module.crossguild.CrossGuildModel;
   import stage3drender.Global;
   import stage3drender.SimpleAtfLoader;
   import stage3drender.Stage3DRenderLayer;
   import starling.core.Starling;
   import starling.events.Event;
   import starling.textures.Texture;
   import yishi.events.SceneViewEvent;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringUtil;
   
   public class SpaceSceneMapView extends Sprite
   {
      
      public static const NAME:String = "map.space.view.SpaceMapView";
      
      protected var _mediatorKey:String;
      
      private var _model:SpaceModel;
      
      private var _controller:SpaceSceneController;
      
      private var _bgLayer:BgLayer;
      
      private var _staticLayer:OuterCityStaticLayer;
      
      private var _staticRender:MapRenderLayer;
      
      private var _footLayer:Sprite;
      
      private var _walkLayer:SpaceWalkLayer;
      
      private var _buildingLayer:SpaceBuildingLayer;
      
      private var _npcLayer:SpaceNpcLayer;
      
      private var _apexLayer:SpaceApexLayer;
      
      private var _topLayer:Component;
      
      private var _guildName:GradientText;
      
      private var _guildKingImg:Bitmap;
      
      private var _guildEffect:MovieClip;
      
      private var _staling:Starling;
      
      private var _nameLayer:MapNameLayer;
      
      private var _lookAtTimeId:int;
      
      private var _prePoint:Point = new Point();
      
      public function SpaceSceneMapView(param1:SpaceSceneController, param2:SpaceModel)
      {
         super();
         SpaceManager.instance.mapView = this;
         _controller = param1;
         _model = param2;
         init();
         addEvent();
         setStartPoint();
         showFirstGuildName();
      }
      
      protected function registerList() : void
      {
         var _loc1_:Array = [SpaceMouseEventMediator,SpaceMapCameraMediator,FreedomTeamListMediator,FreedomTeamFollowMediator,SpaceActivationMovieMediator,SpaceCursorMediator,SpaceUIMediator,LockTargetMediator,SpacePKMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.space.view.SpaceMapView");
      }
      
      private function initStage3DRender() : void
      {
         mouseEnabled = false;
         _staling = new Starling(Stage3DRenderLayer,StageReferance.stage);
         _staling.restartFun = restartHandler;
         _staling.addEventListener("context3DCreate",__createdHandler);
         _staling.start();
      }
      
      private function restartHandler() : void
      {
         disposeStarling();
         initStage3DRender();
      }
      
      protected function init() : void
      {
         if(ComponentSetting.useStage3D)
         {
            _nameLayer = new MapNameLayer();
            addChild(_nameLayer);
            Global.nameLayer = _nameLayer;
            initStage3DRender();
            return;
         }
         if(!_model.bgLayer)
         {
            _model.bgLayer = new BgLayer(this,_model.mapTempInfo,_model.floorData);
         }
         _bgLayer = _model.bgLayer as BgLayer;
         _bgLayer.setParent(this);
         _footLayer = new Sprite();
         addChild(_footLayer);
         _buildingLayer = new SpaceBuildingLayer();
         _controller.buildLayer = _buildingLayer;
         addChild(_buildingLayer);
         _walkLayer = new SpaceWalkLayer();
         _controller.walkLayer = _walkLayer;
         addChild(_walkLayer);
         _npcLayer = new SpaceNpcLayer(_walkLayer);
         _apexLayer = new SpaceApexLayer(_walkLayer);
         _topLayer = new Component();
         _topLayer.mouseChildren = _topLayer.mouseEnabled = false;
         addChild(_topLayer);
      }
      
      private function __createdHandler(param1:starling.events.Event) : void
      {
         _staling.removeEventListener("context3DCreate",__createdHandler);
         registerList();
      }
      
      protected function setStartPoint() : void
      {
      }
      
      public function moveCenterPoint(param1:Point, param2:Number = 0.6, param3:Boolean = true) : void
      {
         MouseData.instance.curState = "ON_DRAG";
         param1.x = -param1.x;
         param1.y = -param1.y;
         param1.x += this.stage.stageWidth / 2;
         param1.y += this.stage.stageHeight / 2;
         TweenLite.killTweensOf(this,false);
         var _loc4_:Point = new Point(this.x,this.y);
         if(Point.distance(param1,_loc4_) < 20)
         {
            return;
         }
         if(param3)
         {
            TweenLite.to(this,param2,{
               "x":param1.x,
               "y":param1.y,
               "onUpdate":moveEndCheck
            });
         }
         else
         {
            x = param1.x;
            y = param1.y;
         }
      }
      
      protected function addEvent() : void
      {
         addEventListener("addedToStage",__addToStageHandler);
         StageReferance.stage.addEventListener("resize",__stageResizeHandler);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("addedToStage",__addToStageHandler);
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
      }
      
      private function __stageResizeHandler(param1:flash.events.Event) : void
      {
         if(_staticLayer)
         {
            _staticLayer.resize();
         }
         lookAtTarget();
      }
      
      private function __addToStageHandler(param1:flash.events.Event) : void
      {
         if(_walkLayer)
         {
            _walkLayer.addToStage(param1);
         }
         if(!ComponentSetting.useStage3D)
         {
            registerList();
         }
         _bgLayer.onStageScale();
         lookAtTarget();
         NotificationManager.instance.dispatchEvent(new SceneViewEvent("addToStage","SPACE_SCENE"));
         SmallMapBar.instance.initData(TempleteManager.instance.mapTemplateCate.getTemplateByID(_model.selfArmy.mapId));
      }
      
      protected function lookAtTarget(param1:Boolean = false) : void
      {
         var _loc3_:MarryCarView = null;
         if(MarryManager.instance.model.lockScreen)
         {
            _loc3_ = _npcLayer.seltCar();
            if(_loc3_)
            {
               dispatchEvent(new CampaignMapEvent("LOOK_AT_ROLE",_loc3_));
               return;
            }
         }
         if(_lookAtTimeId > 0)
         {
            clearInterval(_lookAtTimeId);
         }
         _lookAtTimeId = 0;
         if(!_model.selfArmy)
         {
            _lookAtTimeId = setInterval(lookAtTarget,1000);
            return;
         }
         var _loc2_:Object = _controller.getArmyView(_model.selfArmy);
         if(!_loc2_)
         {
            return;
         }
         if(param1)
         {
            moveCenterPoint(new Point(_loc2_.x,_loc2_.y),0.1,false);
         }
         dispatchEvent(new CampaignMapEvent("LOOK_AT_ROLE",_loc2_));
      }
      
      public function moveEndCheck() : void
      {
         setPosition(this.x,this.y);
      }
      
      override public function set x(param1:Number) : void
      {
         if(super.x == param1)
         {
            return;
         }
         super.x = param1;
         SmallMapBar.instance.iconContainerX = param1 / 16;
      }
      
      override public function set y(param1:Number) : void
      {
         if(super.y == param1)
         {
            return;
         }
         super.y = param1;
         SmallMapBar.instance.iconContainerY = param1 / 16;
      }
      
      public function setPosition(param1:Number, param2:Number) : void
      {
         this.x = param1;
         this.y = param2;
         if(Math.abs(_prePoint.x - x >> 0) > 100 || Math.abs(_prePoint.y - y >> 0) > 100)
         {
            moveOver(this.x,this.y);
         }
      }
      
      public function updateOff(param1:Number, param2:Number) : void
      {
         if(Math.abs(param2 - param1 >> 0) > 100)
         {
            moveOver(x,y);
         }
      }
      
      private function moveOver(param1:Number, param2:Number) : void
      {
         var _loc3_:Rectangle = null;
         _prePoint.x = param1;
         _prePoint.y = param2;
         if(_staticLayer && stage)
         {
            _loc3_ = SpaceMapViewHelper.getCurrentMapRect(this);
            _controller.moveMapCallBack(_loc3_);
            _staticLayer.backgroundXandY(-this.x,-this.y);
            _staticLayer.upDateNextRend();
         }
         dispatchEvent(new CampaignMapEvent("MOVE_SCENET_END",this));
      }
      
      public function get npcLayer() : SpaceNpcLayer
      {
         return _npcLayer;
      }
      
      public function get buildingLayer() : SpaceBuildingLayer
      {
         return _buildingLayer;
      }
      
      public function get walkLayer() : SpaceWalkLayer
      {
         return _walkLayer;
      }
      
      public function get footLayer() : Sprite
      {
         return _footLayer;
      }
      
      private function disposeStarling() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         for each(var _loc1_:Object in Global.avatarTextureDic)
         {
            if(_loc1_ is Texture)
            {
               Global.disposeTexture(_loc1_ as Texture);
            }
            else if(_loc1_ is Vector.<Texture>)
            {
               for each(var _loc2_:Texture in _loc1_)
               {
                  Global.disposeTexture(_loc1_ as Texture);
               }
            }
         }
         Global.nameLayer.removeChildren();
         Starling.current.juggler.purge();
         _staling.dispose();
         _staling = null;
         Global.avatarTextureDic = new Dictionary();
         Global.avatarPartParams = new Dictionary();
         SimpleAtfLoader.isLoaded = new Dictionary();
      }
      
      private function get crossGuildModel() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      private function showFirstGuildName() : void
      {
         if(!crossGuildModel.firstGuild)
         {
            return;
         }
         _guildEffect = ComponentFactory.Instance.creatCustomObject("spaceBuildingLayer.guildEffect");
         _guildKingImg = ComponentFactory.Instance.creatCustomObject("spaceBuildingLayer.guildKingImg");
         _guildName = ComponentFactory.Instance.creatComponentByStylename("spaceBuildingLayer.guildName");
         _topLayer.addChild(_guildEffect);
         _topLayer.addChild(_guildKingImg);
         _topLayer.addChild(_guildName);
         _guildEffect.mouseChildren = _guildEffect.mouseEnabled = false;
         var _loc1_:String = swapLetter(crossGuildModel.firstGuild.consortiaName);
         _guildName.htmlText = LanguageMgr.GetTranslation("map.avatar.view.consortiaName",_loc1_);
         _guildEffect.width = 1.8 * _guildName.textWidth;
      }
      
      private function swapLetter(param1:String) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         var _loc4_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = param1.charAt(_loc3_);
            if(!StringUtil.isChinese(_loc2_))
            {
               _loc2_ = LanguageMgr.GetTranslation("ArialFont",_loc2_);
            }
            _loc4_.push(_loc2_);
            _loc3_++;
         }
         return _loc4_.join("");
      }
      
      public function dispose() : void
      {
         if(_staling)
         {
            disposeStarling();
         }
         else
         {
            MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         }
         removeEvent();
         if(_bgLayer)
         {
            _bgLayer.removeParent();
         }
         _bgLayer = null;
         if(_staticLayer)
         {
            ObjectUtils.disposeObject(_staticLayer);
         }
         _staticLayer = null;
         if(_staticRender)
         {
            ObjectUtils.disposeObject(_staticRender);
         }
         _staticRender = null;
         if(_walkLayer)
         {
            ObjectUtils.disposeObject(_walkLayer);
         }
         _walkLayer = null;
         if(_footLayer)
         {
            ObjectUtils.disposeObject(_footLayer);
         }
         _footLayer = null;
         if(_buildingLayer)
         {
            ObjectUtils.disposeObject(_buildingLayer);
         }
         _buildingLayer = null;
         if(_npcLayer)
         {
            ObjectUtils.disposeObject(_npcLayer);
         }
         _npcLayer = null;
         _controller = null;
         _model = null;
         ObjectUtils.disposeObject(_guildKingImg);
         _guildKingImg = null;
         ObjectUtils.disposeObject(_guildName);
         _guildName = null;
         ObjectUtils.disposeObject(_guildEffect);
         _guildEffect = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

