package yishi.view.component
{
   import flash.events.Event;
   
   public class ChangeableSprite extends DelayRendSprite
   {
      
      public static const CHILD_CHANGE:String = "child_change";
      
      public static const DEFAULT_CHANGE:String = "default_change";
      
      public static const UPDATE:String = "update";
      
      protected var _changeablePropertys:Array = [];
      
      protected var _changeableThings:Array = ["default_change"];
      
      protected var _changes:Object = {};
      
      protected var _height:Number = 0;
      
      protected var _lastPropertyValue:Object = {};
      
      protected var _width:Number = 0;
      
      public function ChangeableSprite()
      {
         super();
         initChangeables();
         initChanges();
         addEventListener("added",__childAdd);
         addEventListener("removed",__childRemove);
      }
      
      public function get contentHeight() : Number
      {
         return super.height;
      }
      
      public function get contentWidth() : Number
      {
         return super.width;
      }
      
      override public function get height() : Number
      {
         return _height;
      }
      
      override public function set height(param1:Number) : void
      {
         if(param1 == _height)
         {
            return;
         }
         _height = param1;
         commitChage("height");
      }
      
      override public function get width() : Number
      {
         return _width;
      }
      
      override public function set width(param1:Number) : void
      {
         if(param1 == _width)
         {
            return;
         }
         _width = param1;
         commitChage("width");
      }
      
      override protected function afterDraw() : void
      {
         recordChangeablePropertys();
         dispatchEvent(new Event("update"));
      }
      
      override protected function beforDraw() : void
      {
         if(!checkCanDraw())
         {
            cancelCurrentRend();
         }
      }
      
      protected function commitChage(param1:String = "default_change") : void
      {
         _changes[param1] = true;
         upDateNextRend();
      }
      
      protected function initChangeables() : void
      {
         registChangeableThings("width");
         registChangeableThings("height");
         registChangeableThings("child_change",false);
      }
      
      final protected function registChangeableThings(param1:String, param2:Boolean = true) : void
      {
         if(param2)
         {
            _changeablePropertys.push(param1);
         }
         else
         {
            _changeableThings.push(param1);
         }
      }
      
      private function __childAdd(param1:Event) : void
      {
         commitChage("child_change");
      }
      
      private function __childRemove(param1:Event) : void
      {
         commitChage("child_change");
      }
      
      private function checkCanDraw() : Boolean
      {
         for(var _loc1_:String in _changes)
         {
            if(_changes[_loc1_])
            {
               if(_changeableThings.indexOf(_loc1_) >= 0)
               {
                  return true;
               }
               if(_lastPropertyValue[_loc1_] != this[_loc1_])
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function initChanges() : void
      {
         for each(var _loc1_:String in _changeablePropertys)
         {
            _lastPropertyValue[_loc1_] = this[_loc1_];
         }
      }
      
      private function recordChangeablePropertys() : void
      {
         for(var _loc1_:String in _changes)
         {
            if(_changes[_loc1_])
            {
               if(_changeableThings.indexOf(_loc1_) >= 0)
               {
                  _changes[_loc1_] = false;
               }
               else
               {
                  _lastPropertyValue[_loc1_] = this[_loc1_];
                  _changes[_loc1_] = false;
               }
            }
         }
      }
   }
}

