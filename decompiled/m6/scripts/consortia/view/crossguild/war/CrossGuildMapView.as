package consortia.view.crossguild.war
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.InteractiveObject;
   import flash.display.Shape;
   import flash.events.Event;
   import yishi.manager.CursorManagerII;
   import yishi.utils.TweenDrag;
   
   public class CrossGuildMapView extends Component
   {
      
      private static const MAP_WIDTH:int = 3600;
      
      private static const MAP_HEIGHT:int = 1080;
      
      private var _viewContainer:Component;
      
      private var _mapMask:Shape;
      
      private var _dragObj:TweenDrag;
      
      private var _isDraging:Boolean;
      
      private var _mapLayer:CrossGuildWarMapLayer;
      
      private var _towerView:CrossGuildWarTowerView;
      
      public function CrossGuildMapView()
      {
         super();
         initView();
         initDrag();
         initMoveMap();
         addEvent();
      }
      
      private function initView() : void
      {
         _mapLayer = new CrossGuildWarMapLayer(3600,1080);
         _towerView = new CrossGuildWarTowerView();
         _viewContainer = new Component();
         _mapMask = new Shape();
         _mapMask.graphics.beginFill(16711680,0);
         _mapMask.graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         _mapMask.graphics.endFill();
         addChild(_viewContainer);
         addChild(_mapMask);
         _viewContainer.mask = _mapMask;
         _viewContainer.addChild(_mapLayer);
         _viewContainer.addChild(_towerView);
      }
      
      private function initDrag() : void
      {
         _dragObj = new TweenDrag(_viewContainer,_viewContainer as InteractiveObject);
         _dragObj.onDragStart = dragStartCallBack;
         _dragObj.onDraging = dragingCallBack;
         _dragObj.onDragDrop = dropCallBack;
         _dragObj.upNoMove = true;
      }
      
      public function initMoveMap() : void
      {
         var _loc2_:int = (StageReferance.stageWidth - 3600) / 2;
         var _loc1_:int = (StageReferance.stageHeight - 1080) / 2;
         mapMoveCheck(_loc2_,_loc1_);
      }
      
      private function dragStartCallBack() : void
      {
         CursorManagerII.instance.showCursorByType("DRAG_CURSOR");
      }
      
      private function dragingCallBack() : void
      {
         mapMoveCheck(_viewContainer.x,_viewContainer.y);
      }
      
      private function dropCallBack() : void
      {
         if(CursorManagerII.instance.currentState == "DRAG_CURSOR")
         {
            CursorManagerII.instance.resetCursor();
         }
      }
      
      private function mapMoveCheck(param1:int, param2:int) : void
      {
         var _loc3_:int = StageReferance.stageWidth - 3600;
         var _loc4_:int = StageReferance.stageHeight - 1080;
         if(param1 >= 0)
         {
            param1 = 0;
         }
         else if(param1 <= _loc3_)
         {
            param1 = _loc3_;
         }
         if(_loc4_ < 0)
         {
            if(param2 >= 0)
            {
               param2 = 0;
            }
            else if(param2 <= _loc4_)
            {
               param2 = _loc4_;
            }
         }
         else
         {
            param2 = (StageReferance.stageHeight - 1080) / 2;
         }
         _viewContainer.x = param1;
         _viewContainer.y = param2;
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",resizeHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",resizeHandler);
      }
      
      private function resizeHandler(param1:Event = null) : void
      {
         _mapMask.graphics.clear();
         _mapMask.graphics.beginFill(16711680,0);
         _mapMask.graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         _mapMask.graphics.endFill();
         initMoveMap();
      }
      
      override public function get width() : Number
      {
         return 3600;
      }
      
      override public function get height() : Number
      {
         return 1080;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_mapLayer);
         _mapLayer = null;
         ObjectUtils.disposeObject(_towerView);
         _towerView = null;
         ObjectUtils.disposeObject(_mapMask);
         _mapMask = null;
         ObjectUtils.disposeObject(_viewContainer);
         _viewContainer = null;
         super.dispose();
      }
   }
}

