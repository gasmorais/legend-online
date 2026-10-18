package yishi.utils
{
   import battle.BattleManager;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class ButtonSkiner extends LogicObject
   {
      
      public var onDownView:Function;
      
      public var onOverView:Function;
      
      public var onNormalView:Function;
      
      public var onEnableView:Function;
      
      public var onDisableView:Function;
      
      private var _enable:Boolean = true;
      
      private var _target:InteractiveObject;
      
      public function ButtonSkiner(param1:InteractiveObject)
      {
         super();
         _target = param1;
         addEvent();
      }
      
      private function addEvent() : void
      {
         _target.addEventListener("rollOver",__rollOver);
         _target.addEventListener("rollOut",__rollOut);
         _target.addEventListener("mouseDown",__mouseDown);
         _target.addEventListener("mouseUp",__mouseUp);
      }
      
      private function __mouseUp(param1:MouseEvent) : void
      {
         callBackFunction(onNormalView);
      }
      
      private function removeEvent() : void
      {
         if(_target)
         {
            _target.removeEventListener("rollOver",__rollOver);
            _target.removeEventListener("rollOut",__rollOut);
            _target.removeEventListener("mouseDown",__mouseDown);
            _target.removeEventListener("mouseUp",__mouseUp);
         }
      }
      
      private function __mouseDown(param1:MouseEvent) : void
      {
         callBackFunction(onDownView);
      }
      
      private function __rollOut(param1:MouseEvent) : void
      {
         callBackFunction(onNormalView);
      }
      
      private function __rollOver(param1:MouseEvent) : void
      {
         callBackFunction(onOverView);
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         if(BattleManager.getInstance().battleModel && BattleManager.getInstance().battleModel.isControledByBoss())
         {
            param1 = false;
         }
         if(_enable == param1)
         {
            return;
         }
         _enable = param1;
         if(_enable)
         {
            callBackFunction(onEnableView);
            callBackFunction(onNormalView);
            addEvent();
         }
         else
         {
            callBackFunction(onDisableView);
            callBackFunction(onNormalView);
            removeEvent();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         onDownView = null;
         onOverView = null;
         onNormalView = null;
         onEnableView = null;
         onDisableView = null;
         removeEvent();
      }
   }
}

