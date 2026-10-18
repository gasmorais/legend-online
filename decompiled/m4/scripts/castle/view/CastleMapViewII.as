package castle.view
{
   import castle.view.layer.CastleAirlayer;
   import castle.view.layer.CastleAnimalLayer;
   import castle.view.layer.CastleBackgroundLayer;
   import castle.view.layer.CastleNameLayer;
   import castle.view.layer.CastleWalkLayer;
   import castle.view.layer.FogBorderLayer;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.BuildingEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import mvc.module.buildings.BuildInfo;
   import yishi.actions.castle.NewBuildAction;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.CursorManagerII;
   import yishi.manager.PlayerManager;
   import yishi.utils.DelayActionsUtils;
   import yishi.utils.TweenDrag;
   
   public class CastleMapViewII extends Sprite implements Disposeable
   {
      
      protected var _backgroundLayer:CastleBackgroundLayer;
      
      protected var _animalLayer:CastleAnimalLayer;
      
      protected var _walkLayer:CastleWalkLayer;
      
      protected var _airLayer:CastleAirlayer;
      
      private var _nameLayer:CastleNameLayer;
      
      private var _borderLayer:FogBorderLayer;
      
      private var _dragObj:TweenDrag;
      
      private var _mouseTime:int;
      
      private var _timeId:int;
      
      private var _mouseDown:Boolean;
      
      private var _minScale:Number;
      
      public function CastleMapViewII(param1:CastleNameLayer)
      {
         super();
         _nameLayer = param1;
         initBackgroundLayer();
         initWalklayer();
         initAirLayer();
         initBorderLayer();
         initEvent();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function initBackgroundLayer() : void
      {
         _backgroundLayer = new CastleBackgroundLayer();
         addChild(_backgroundLayer);
      }
      
      private function initAnimalLayer() : void
      {
         _animalLayer = new CastleAnimalLayer();
         addChild(_animalLayer);
      }
      
      private function initWalklayer() : void
      {
         _walkLayer = new CastleWalkLayer(_nameLayer);
         addChild(_walkLayer);
      }
      
      private function initAirLayer() : void
      {
         _airLayer = new CastleAirlayer();
         addChild(_airLayer);
      }
      
      private function initBorderLayer() : void
      {
         _borderLayer = new FogBorderLayer(_backgroundLayer.resWidth,_backgroundLayer.resHeight);
         addChild(_borderLayer);
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseDown",__onMouseDownHandler);
         addEventListener("mouseUp",__onMouseUpHandler);
         addEventListener("mouseWheel",__onMouseWheel);
         addEventListener("mouseOver",__onMouseOver);
         addEventListener("mouseOut",__onMouseOut);
         KeyBoardRegister.instance.registerMapKey(__leftMove,__rightMove,__topMove,__downMove);
         BuildingManager.instance.addEventListener("CREATE_NEW_BUILDING",__createNewBuildHandler);
         BuildingManager.instance.addEventListener("BUILDING_UPGRADE_RECEIVE",__buildUpgradeHandler);
         _dragObj = new TweenDrag(this,this);
         _dragObj.onDraging = dragingCallBack;
         _dragObj.onDragDrop = dropCallBack;
         _dragObj.onTweening = dragingCallBack;
         StageReferance.stage.addEventListener("resize",__resizeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseDown",__onMouseDownHandler);
         removeEventListener("mouseUp",__onMouseUpHandler);
         removeEventListener("mouseWheel",__onMouseWheel);
         removeEventListener("mouseOver",__onMouseOver);
         removeEventListener("mouseOut",__onMouseOut);
         BuildingManager.instance.removeEventListener("CREATE_NEW_BUILDING",__createNewBuildHandler);
         BuildingManager.instance.removeEventListener("BUILDING_UPGRADE_RECEIVE",__buildUpgradeHandler);
         _dragObj.enable = false;
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         this.scaleX = this.scaleY = 1;
         dragingCallBack();
         dropCallBack();
         addName(scaleX);
      }
      
      private function __leftMove() : void
      {
         x += 50;
         dragingCallBack();
         dropCallBack();
      }
      
      private function __rightMove() : void
      {
         x -= 50;
         dragingCallBack();
         dropCallBack();
      }
      
      private function __topMove() : void
      {
         y += 50;
         dragingCallBack();
         dropCallBack();
      }
      
      private function __downMove() : void
      {
         y -= 50;
         dragingCallBack();
         dropCallBack();
      }
      
      private function __onMouseOver(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         var _loc2_:CastleBuildingView = param1.target as CastleBuildingView;
         if(!_loc2_)
         {
            return;
         }
         for each(var _loc3_:CastleBuildingView in _walkLayer.buildingsDic)
         {
            if(_loc2_.buildingInfo.sonType == _loc3_.buildingInfo.sonType)
            {
               _loc3_.mouseOverHandler(param1);
            }
         }
      }
      
      private function __onMouseOut(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(_timeId != 0)
         {
            clearTimeout(_timeId);
         }
         var _loc2_:CastleBuildingView = param1.target as CastleBuildingView;
         if(!_loc2_)
         {
            return;
         }
         for each(var _loc3_:CastleBuildingView in _walkLayer.buildingsDic)
         {
            if(_loc2_.buildingInfo.sonType == _loc3_.buildingInfo.sonType)
            {
               _loc3_.mouseOutHandler(param1);
            }
         }
      }
      
      private function __onMouseDownHandler(param1:MouseEvent) : void
      {
         _mouseDown = true;
         _mouseTime = getTimer();
         if(_timeId != 0)
         {
            clearTimeout(_timeId);
         }
         _timeId = setTimeout(dragStart,300);
      }
      
      private function __onMouseUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = getTimer() - _mouseTime;
         _mouseDown = false;
         if(_loc2_ < 300)
         {
            castleMapClick(param1);
         }
      }
      
      private function castleMapClick(param1:MouseEvent) : void
      {
         if(param1.target as BuildingBase)
         {
            (param1.target as BuildingBase).mouseClickHandler(param1);
         }
         dropCallBack();
      }
      
      private function removeName() : void
      {
         for each(var _loc1_:CastleBuildingView in _walkLayer.buildingsDic)
         {
            _loc1_.removeName();
         }
      }
      
      private function addName(param1:Number) : void
      {
         for each(var _loc2_:CastleBuildingView in _walkLayer.buildingsDic)
         {
            _loc2_.addChildByScale(param1);
         }
      }
      
      public function __onMouseWheel(param1:MouseEvent) : void
      {
      }
      
      private function __buildUpgradeHandler(param1:BuildingEvent) : void
      {
         if(param1.buildingInfo.templeteInfo.MasterType == 13 || param1.buildingInfo.templeteInfo.MasterType == 14)
         {
            return;
         }
         SoundManager.instance.play("010",true);
         _walkLayer.updateBuildingView(param1.buildingInfo);
      }
      
      private function __createNewBuildHandler(param1:BuildingEvent) : void
      {
         var _loc4_:BuildingTempInfo = param1.buildingInfo.templeteInfo;
         if(_loc4_.MasterType == 13 || _loc4_.MasterType == 14)
         {
            return;
         }
         _walkLayer.updateBuildingView(param1.buildingInfo);
         var _loc3_:BuildingTempInfo = param1.buildingInfo.templeteInfo;
         var _loc2_:CastleBuildingView = buildingsDic[param1.buildingInfo.buildingId] as CastleBuildingView;
         var _loc5_:Point = getTopoint(_loc2_);
         if(PlayerManager.instance.newbieProcess >= 21000)
         {
            DelayActionsUtils.instance.addAction(new NewBuildAction(this,param1.buildingInfo,_loc5_.x,_loc5_.y,newBuildingFocus));
         }
      }
      
      private function newBuildingFocus(param1:BuildInfo) : void
      {
         var _loc2_:CastleBuildingView = buildingsDic[param1.buildingId] as CastleBuildingView;
         _loc2_.newBuilding = true;
      }
      
      public function moveFocus(param1:BuildInfo, param2:Function) : void
      {
         if(beyondScreen())
         {
            if(param2 != null)
            {
               param1 ? param2(param1) : param2();
            }
            param2 = null;
            param1 = null;
            return;
         }
         var _loc3_:CastleBuildingView = buildingsDic[param1.buildingId] as CastleBuildingView;
         var _loc4_:Point = getTopoint(_loc3_);
         DelayActionsUtils.instance.addAction(new NewBuildAction(this,param1,_loc4_.x,_loc4_.y,param2));
      }
      
      public function moveFocus2(param1:CastleBuildingView, param2:Function) : void
      {
         if(beyondScreen())
         {
            if(param2 != null)
            {
               param2();
            }
            param2 = null;
            return;
         }
         var _loc3_:Point = getTopoint(param1);
         DelayActionsUtils.instance.addAction(new NewBuildAction(this,null,_loc3_.x,_loc3_.y,param2));
      }
      
      private function getTopoint(param1:CastleBuildingView) : Point
      {
         var _loc3_:Point = new Point();
         var _loc2_:int = StageReferance.stageWidth / 2 - param1.x - param1.width / 2;
         var _loc4_:int = StageReferance.stageHeight / 2 - param1.y - param1.height / 2;
         if(_loc2_ < StageReferance.stageWidth - _backgroundLayer.resWidth * this.scaleX)
         {
            _loc2_ = StageReferance.stageWidth - _backgroundLayer.resWidth * this.scaleX;
         }
         else if(_loc2_ > 0)
         {
            _loc2_ = 0;
         }
         if(_loc4_ < StageReferance.stageHeight - _backgroundLayer.resHeight * this.scaleY)
         {
            _loc4_ = StageReferance.stageHeight - _backgroundLayer.resHeight * this.scaleY;
         }
         else if(_loc4_ > 0)
         {
            _loc4_ = 0;
         }
         _loc3_.x = _loc2_;
         _loc3_.y = _loc4_;
         return _loc3_;
      }
      
      public function moveMapToPoint(param1:Point, param2:Function) : void
      {
         TweenMax.to(this,1,{
            "x":stage.stageWidth / 2 - param1.x,
            "y":stage.stageHeight / 2 - param1.y,
            "onComplete":param2
         });
      }
      
      public function moveMapToPointII(param1:Point, param2:Function) : void
      {
         TweenMax.to(this,1,{
            "x":stage.stageWidth / 2 - param1.x,
            "y":stage.stageHeight / 2 - param1.y,
            "onUpdate":dragingCallBack,
            "onComplete":param2
         });
      }
      
      private function dragStart() : void
      {
         clearTimeout(_timeId);
         _timeId = 0;
         if(_mouseDown)
         {
            dragStartCallBack();
         }
      }
      
      private function dragStartCallBack() : void
      {
         TweenMax.killTweensOf(this);
         if(PlayerManager.instance.newbieProcess <= 25000)
         {
            return;
         }
         CursorManagerII.instance.showCursorByType("DRAG_CURSOR");
      }
      
      public function dropCallBack() : void
      {
         CursorManagerII.instance.resetCursor();
      }
      
      public function onStageScale() : void
      {
         this.scaleX = 1;
         this.scaleY = 1;
         _nameLayer.refreshChild(1);
         dragingCallBack();
         addName(1);
      }
      
      public function dragingCallBack() : void
      {
         if(_backgroundLayer.resWidth * this.scaleX < StageReferance.stageWidth)
         {
            x = (StageReferance.stageWidth - _backgroundLayer.resWidth * this.scaleX) * 0.5;
         }
         else if(x < StageReferance.stageWidth - _backgroundLayer.resWidth * this.scaleX)
         {
            x = StageReferance.stageWidth - _backgroundLayer.resWidth * this.scaleX;
         }
         else if(x > 0)
         {
            x = 0;
         }
         if(_backgroundLayer.resHeight * this.scaleY < StageReferance.stageHeight)
         {
            y = (StageReferance.stageHeight - _backgroundLayer.resHeight * this.scaleY) * 0.5;
         }
         else if(y < StageReferance.stageHeight - _backgroundLayer.resHeight * this.scaleY)
         {
            y = StageReferance.stageHeight - _backgroundLayer.resHeight * this.scaleY;
         }
         else if(y > 0)
         {
            y = 0;
         }
      }
      
      private function beyondScreen() : Boolean
      {
         if(_backgroundLayer.resWidth * this.scaleX < StageReferance.stageWidth)
         {
            return true;
         }
         if(_backgroundLayer.resHeight * this.scaleY < StageReferance.stageHeight)
         {
            return true;
         }
         return false;
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
         _nameLayer.x = param1;
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
         _nameLayer.y = param1;
      }
      
      public function get buildingsDic() : Dictionary
      {
         return _walkLayer.buildingsDic;
      }
      
      public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.removeMapKey(__leftMove,__rightMove,__topMove,__downMove);
         TweenMax.killTweensOf(this);
         _dragObj.dispose();
         _dragObj = null;
         ObjectUtils.disposeObject(_backgroundLayer);
         _backgroundLayer = null;
         ObjectUtils.disposeObject(_animalLayer);
         _animalLayer = null;
         ObjectUtils.disposeObject(_walkLayer);
         _walkLayer = null;
         ObjectUtils.disposeObject(_airLayer);
         _airLayer = null;
         ObjectUtils.disposeObject(_borderLayer);
         _borderLayer = null;
         ObjectUtils.disposeObject(_nameLayer);
         _nameLayer = null;
         _backgroundLayer = null;
         _animalLayer = null;
         _walkLayer = null;
         _airLayer = null;
         _nameLayer = null;
         _borderLayer = null;
      }
   }
}

