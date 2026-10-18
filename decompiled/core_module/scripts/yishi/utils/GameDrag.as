package yishi.utils
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   
   public class GameDrag extends LogicObject
   {
      
      public var target:Object;
      
      private var _dropTarget:Object;
      
      public var onDrop:Function;
      
      public var onDrag:Function;
      
      private var _isStop:Boolean = false;
      
      private var _dragIcon:DisplayObject;
      
      private var _dragType:String;
      
      private var _lockCenter:Boolean;
      
      public var stopDropClickEvent:Boolean = true;
      
      public var stopDropProgress:Boolean = false;
      
      public var checkType:String;
      
      public var dropChecks:Array;
      
      private var param:Object;
      
      public function GameDrag(param1:Object, param2:Object = null)
      {
         super();
         this.target = param1;
         this.param = param2;
         _dragIcon = param2.icon || DisplayObject(param1);
         _dragType = param2.type || "click";
         stopDropClickEvent = param2.stopDropClickEvent;
         _lockCenter = param2.lockCenter || true;
      }
      
      public function get dropTarget() : Object
      {
         return _dropTarget;
      }
      
      public function set dropTarget(param1:Object) : void
      {
         _dropTarget = param1;
      }
      
      public function stopImmediatePropagation() : void
      {
         _isStop = true;
      }
      
      public function get dragIcon() : DisplayObject
      {
         return _dragIcon;
      }
      
      public function get lockCenter() : Boolean
      {
         return _lockCenter;
      }
      
      public function get isStop() : Boolean
      {
         return _isStop;
      }
      
      public function get type() : String
      {
         return _dragType;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(target);
         target = null;
         ObjectUtils.disposeObject(_dragIcon);
         _dragIcon = null;
      }
   }
}

