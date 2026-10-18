package stararea
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.InteractiveObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import mvc.module.stararea.StarareaManager;
   import mvc.module.stararea.StarareaModel;
   import yishi.utils.TweenDrag;
   
   public class StarareaSceneView extends Sprite
   {
      
      private var _showContainer:Sprite;
      
      private var _showMask:Shape;
      
      private var _backView:StarareaBackView;
      
      private var _dragObj:TweenDrag;
      
      private var _warkLayer:StarareaWalkLayer;
      
      private var _rightView:StarareaRightView;
      
      private var _leftView:StarareaLeftView;
      
      private var _smallMapView:StarareaSmallMapView;
      
      private var _mapWidth:int = 2659;
      
      private var _mapHeight:int = 2320;
      
      private const MAP_WIDTH:int = 1920;
      
      private const MAP_HEIGHT:int = 1080;
      
      public function StarareaSceneView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _mapWidth = model.width;
         _mapHeight = model.height;
         _showContainer = new Sprite();
         _showMask = new Shape();
         _showMask.graphics.beginFill(16711680,0);
         _showMask.graphics.drawRect(0,0,1920,1080);
         _showMask.graphics.endFill();
         addChild(_showContainer);
         addChild(_showMask);
         _showContainer.mask = _showMask;
         _backView = new StarareaBackView();
         _showContainer.addChild(_backView);
         _warkLayer = new StarareaWalkLayer();
         _showContainer.addChild(_warkLayer);
         _rightView = new StarareaRightView();
         _leftView = new StarareaLeftView();
         _smallMapView = new StarareaSmallMapView();
         _dragObj = new TweenDrag(_showContainer,this as InteractiveObject);
         _dragObj.onDragStart = dragStartCallBack;
         _dragObj.onDraging = dragingCallBack;
         _dragObj.onDragDrop = dropCallBack;
         _dragObj.upNoMove = true;
         initMoveMap();
      }
      
      private function dragStartCallBack() : void
      {
      }
      
      private function dragingCallBack() : void
      {
         mapMoveCheck(_showContainer.x,_showContainer.y);
      }
      
      private function mapMoveCheck(param1:int, param2:int) : void
      {
         var _loc3_:int = StageReferance.stage.stageWidth - _mapWidth;
         var _loc4_:int = StageReferance.stage.stageHeight - _mapHeight;
         if(param1 >= 0)
         {
            param1 = 0;
         }
         else if(param1 <= _loc3_)
         {
            param1 = _loc3_;
         }
         if(param2 >= 0)
         {
            param2 = 0;
         }
         else if(param2 <= _loc4_)
         {
            param2 = _loc4_;
         }
         _showContainer.x = param1;
         _showContainer.y = param2;
      }
      
      private function dropCallBack() : void
      {
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",resizeHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",resizeHandler);
      }
      
      private function resizeHandler(param1:Event = null) : void
      {
         initMoveMap();
      }
      
      public function initMoveMap() : void
      {
         var _loc5_:int = StageReferance.stage.stageWidth * 0.5;
         var _loc3_:int = StageReferance.stage.stageHeight * 0.5;
         var _loc1_:Point = model.getStarPosById(model.myPointId);
         var _loc6_:int = _loc5_ - _loc1_.x;
         var _loc4_:int = _loc3_ - _loc1_.y;
         var _loc2_:int = StageReferance.stage.stageWidth - _mapWidth;
         var _loc7_:int = StageReferance.stage.stageHeight - _mapHeight;
         if(Math.abs(_loc6_) > Math.abs(_loc2_))
         {
            _loc6_ = _loc2_;
         }
         if(Math.abs(_loc4_) > Math.abs(_loc7_))
         {
            _loc4_ = _loc7_;
         }
         mapMoveCheck(_loc6_,_loc4_);
      }
      
      private function get model() : StarareaModel
      {
         return StarareaManager.instance.model;
      }
      
      public function dispose() : void
      {
         model.clear();
         removeEvent();
         ObjectUtils.disposeObject(_showContainer);
         _showContainer = null;
         ObjectUtils.disposeObject(_showMask);
         _showMask = null;
         ObjectUtils.disposeObject(_backView);
         _backView = null;
         ObjectUtils.disposeObject(_warkLayer);
         _warkLayer = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_smallMapView);
         _smallMapView = null;
         _dragObj.dispose();
         _dragObj = null;
         ObjectUtils.disposeSelf(this);
      }
   }
}

