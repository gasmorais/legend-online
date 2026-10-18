package yishi.manager
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import yishi.utils.GameDrag;
   
   public class DragManager
   {
      
      private static var _instance:DragManager;
      
      private var _lockCenter:Boolean = false;
      
      private var _dragType:String = "click";
      
      private var _stage:Stage = StageReferance.stage;
      
      private var _isDraging:Boolean = false;
      
      private var _dragIcon:DisplayObject;
      
      private var offsetX:Number = 0;
      
      private var offsetY:Number = 0;
      
      private var drageObject:GameDrag;
      
      public function DragManager()
      {
         super();
      }
      
      public static function getInstance() : DragManager
      {
         if(!_instance)
         {
            _instance = new DragManager();
         }
         return _instance;
      }
      
      public function starDrag(param1:Object, param2:Object = null, param3:Boolean = false) : GameDrag
      {
         _isDraging = true;
         drageObject = new GameDrag(param1,param2);
         _lockCenter = drageObject.lockCenter;
         doDragStart(param3);
         return drageObject;
      }
      
      private function doDragStart(param1:Boolean) : void
      {
         if(!_isDraging)
         {
            return;
         }
         _dragIcon = drageObject.dragIcon || new Sprite();
         if(_lockCenter)
         {
            offsetX = param1 ? 0 : -_dragIcon.width / 2;
            offsetY = param1 ? 0 : -_dragIcon.height / 2;
         }
         LayerManager.Instance.addToLayer(_dragIcon,2,false);
         updateIconPosition();
         _stage.addEventListener("mouseMove",__mouseMove);
         if(drageObject.type == "click")
         {
            _stage.addEventListener("click",__dragDownDropHandler,true);
         }
         else if(drageObject.type == "down")
         {
            _stage.addEventListener("mouseUp",__dragDownDropHandler);
         }
      }
      
      public function stopDrag() : void
      {
         _isDraging = false;
         removeEvents();
         removeDisplays();
         drageObject = null;
      }
      
      private function __dragDownDropHandler(param1:MouseEvent) : void
      {
         if(drageObject.stopDropClickEvent)
         {
            param1.stopPropagation();
            param1.stopImmediatePropagation();
         }
         doDrag(param1);
      }
      
      private function doDrag(param1:MouseEvent) : void
      {
         if(drageObject.dropChecks)
         {
            doDropCheck(param1);
            if(drageObject.stopDropProgress)
            {
               drageObject.stopDropProgress = false;
               return;
            }
            stopDrag();
         }
         else
         {
            drageObject.onDrop && drageObject.onDrop(drageObject);
            stopDrag();
         }
      }
      
      private function doDropCheck(param1:MouseEvent) : void
      {
         var _loc13_:DisplayObject = null;
         var _loc2_:Boolean = false;
         var _loc9_:int = 0;
         var _loc8_:Array = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc11_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc12_:Array = [];
         if(drageObject.dragIcon is InteractiveObject)
         {
            _loc2_ = Boolean(InteractiveObject(drageObject.dragIcon).mouseEnabled);
         }
         else if(drageObject.dragIcon is DisplayObjectContainer)
         {
            _loc2_ = Boolean(DisplayObjectContainer(drageObject.dragIcon).mouseChildren);
         }
         if(_loc2_)
         {
            _loc12_ = _stage.getObjectsUnderPoint(new Point(param1.stageX,param1.stageY));
            _loc13_ = _loc12_.pop();
         }
         else
         {
            _loc13_ = param1.target as DisplayObject;
            _loc12_.push(_loc13_);
         }
         var _loc10_:int = int(drageObject.dropChecks.length);
         var _loc4_:int = int(_loc12_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc10_)
         {
            _loc11_ = drageObject.dropChecks[_loc5_];
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc13_ = _loc12_[_loc6_];
               _loc8_ = [];
               _loc8_.push(_loc13_);
               while(_loc13_.parent)
               {
                  _loc8_.push(_loc13_.parent);
                  _loc13_ = _loc13_.parent;
               }
               _loc9_ = int(_loc8_.length);
               _loc7_ = 0;
               while(_loc7_ < _loc9_)
               {
                  if(drageObject.isStop)
                  {
                     return;
                  }
                  if(_loc11_ is Class && _loc8_[_loc7_] is Class(_loc11_))
                  {
                     drageObject.dropTarget = _loc8_[_loc7_];
                     drageObject.onDrop && drageObject.onDrop(drageObject);
                     return;
                  }
                  if(_loc8_[_loc7_] == _loc11_)
                  {
                     drageObject.dropTarget = _loc8_[_loc7_];
                     drageObject.onDrop && drageObject.onDrop(drageObject);
                     return;
                  }
                  _loc7_++;
               }
               _loc6_++;
            }
            _loc5_++;
         }
      }
      
      private function removeDisplays() : void
      {
         ObjectUtils.disposeObject(_dragIcon);
         _dragIcon = null;
      }
      
      private function removeEvents() : void
      {
         _stage.removeEventListener("mouseMove",__mouseMove);
         _stage.removeEventListener("click",__dragDownDropHandler,true);
         _stage.removeEventListener("mouseUp",__dragDownDropHandler);
      }
      
      private function __mouseMove(param1:MouseEvent) : void
      {
         updateIconPosition();
      }
      
      private function updateIconPosition() : void
      {
         _dragIcon.x = _stage.mouseX + offsetX;
         _dragIcon.y = _stage.mouseY + offsetY;
      }
      
      public function get isDraging() : Boolean
      {
         return _isDraging;
      }
   }
}

